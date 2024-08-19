package fpt.hieunm.application.controllers;

import com.oracle.wls.shaded.org.apache.xpath.operations.Mod;
import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.Subcategory;
import fpt.hieunm.application.services.Book.BookService;
import fpt.hieunm.application.services.Subcategory.SubcategoryService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


import java.io.IOException;
import java.util.List;

@Controller
public class BookController {
    @Autowired
    BookService bookService;

    @Autowired
    SubcategoryService subcategoryService;
    @Autowired
    private HttpServletRequest httpServletRequest;

    @RequestMapping(value = "/bookList/{subcategory}", method = RequestMethod.GET)
    public String getBooksBySubcategory(
            @PathVariable("subcategory") String subcategory,
            Model model,
            @RequestParam(value = "page", defaultValue = "0") int page) {
        int pageSize = 8;
        subcategory = bookService.formatSubcategory(subcategory);
        List<Book> books = bookService.getBooksBySubcategory(subcategory, page, pageSize);
        long totalBooks = bookService.countBooksBySubcategory(subcategory);
        String category = subcategoryService.getCategoryName(subcategory);
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        model.addAttribute("books", books);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("currentSubcategory", subcategory);
        model.addAttribute("currentCategory", category);
        model.addAttribute("category", false);

        return "bookList";
    }


    @RequestMapping(value = "/categoryList/{subcategory}", method = RequestMethod.GET)
    public String getBooksByCategory(
            @PathVariable("subcategory") String subcategory,
            Model model,
            @RequestParam(value = "page", defaultValue = "0") int page) {
        int pageSize = 8;
        subcategory = bookService.formatSubcategory(subcategory);
        String category = subcategoryService.getCategoryName(subcategory);
        List<Book> books = bookService.getBooksByCategory(category, page, pageSize);
        long totalBooks = bookService.countBooksByCategory(category);
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        model.addAttribute("books", books);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("currentSubcategory", subcategory);
        model.addAttribute("currentCategory", category);
        model.addAttribute("category", true);

        return "bookList";
    }


    @RequestMapping(value = "/filter/{subcategory}", method = RequestMethod.GET)
    public String filterBooks(@PathVariable("subcategory") String subcategory,
                              Model model,
                              @RequestParam(value = "page", defaultValue = "0") int page,
                              @RequestParam(required = false) Integer minPrice,
                              @RequestParam(required = false) Integer maxPrice,
                              @RequestParam(required = false) String publisher) {
        int pageSize = 8;
        subcategory = bookService.formatSubcategory(subcategory);
        if (minPrice == null) {
            minPrice = 0;
        }
        if (maxPrice == null) {
            maxPrice = Integer.MAX_VALUE;
        }


        List<Book> books = bookService.getBooksBySubcategoryWithFilter(subcategory, minPrice, maxPrice, publisher, page, pageSize);
        long totalBooks = bookService.countBooksBySubcategoryWithFilter(subcategory, minPrice, maxPrice, publisher);
        String category = subcategoryService.getCategoryName(subcategory);
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        model.addAttribute("books", books);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("currentSubcategory", subcategory);
        model.addAttribute("currentCategory", category);
        model.addAttribute("category", true);
        return "bookList";
    }


    @RequestMapping("/getImage/{bookId}")
    @ResponseBody
    public ResponseEntity<byte[]> getImage(@PathVariable Integer bookId) {
        byte[] image = bookService.getImageData(bookId);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG); // or MediaType.IMAGE_PNG
        return new ResponseEntity<>(image, headers, HttpStatus.OK);
    }

    //  controller de tra ve trang info cua 1 cuon sach
    @RequestMapping("/info/{bookId}")
    public String getBookInfo(@PathVariable Integer bookId, Model model) {
        Book book = bookService.getBookById(bookId);
        List<Book> books = bookService.getBooksBySubcategoryWithoutPagination(book.getSubcategory().getSubcategoryName());
        model.addAttribute("book", book);
        model.addAttribute("books", books);
        return "bookInfo";
    }

    // search book by keyword
    @RequestMapping(value = "/search/{keyword}", method = RequestMethod.GET)
    public String searchBooks(@PathVariable("keyword") String keyword,
                              Model model,
                              @RequestParam(value = "page", defaultValue = "0") int page,
                              @RequestParam(required = false) Integer minPrice,
                              @RequestParam(required = false) Integer maxPrice,
                              @RequestParam(required = false) String publisher) {
        int pageSize = 8;

        if (minPrice == null) {
            minPrice = 0;
        }
        if (maxPrice == null) {
            maxPrice = Integer.MAX_VALUE;
        }

        List<Book> books = bookService.getBooksByKeywordWithFilter(keyword, minPrice, maxPrice, publisher, page, pageSize);
        long totalBooks = bookService.countBooksByKeywordWithFilter(keyword, minPrice, maxPrice, publisher);
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        model.addAttribute("books", books);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("keyword", keyword);
        model.addAttribute("totalBooks", totalBooks);
        return "searchList";
    }

    // Arrange
    @RequestMapping("/arrange-1/{subcategory}/{option}")
    public String arrangeBooksBySubcategory(@PathVariable("subcategory") String subcategory,
                                            @PathVariable("option") String option,
                                            Model model,
                                            @RequestParam(value = "page", defaultValue = "0") int page) {
        int pageSize = 8;
        subcategory = bookService.formatSubcategory(subcategory);
        List<Book> books = bookService.getArrangedBooksBySubcategory(subcategory, page, pageSize, option);
        long totalBooks = bookService.countBooksBySubcategory(subcategory);
        String category = subcategoryService.getCategoryName(subcategory);
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        if (option.equals("price-up")) {
            // sắp xếp books theo giá
            model.addAttribute("optionName", "Giá Thấp Đến Cao");
        } else if (option.equals("price-down")) {
            // sắp xếp books theo giá
            model.addAttribute("optionName", "Giá Cao Đến Thấp");
        } else if (option.equals("discount")) {
            // sắp xếp books theo Chiết Khấu
            model.addAttribute("optionName", "Chiết Khấu");
        } else {
            // sắp xếp books theo Nổi Bật Năm
            model.addAttribute("optionName", "Chiết Khấu");
        }

        model.addAttribute("books", books);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("currentSubcategory", subcategory);
        model.addAttribute("currentCategory", category);
        model.addAttribute("category", false);
        model.addAttribute("arrange", true);
        model.addAttribute("option", option);
        return "bookList";
    }

    @RequestMapping(value = "/arrange-2/{subcategory}/{option}", method = RequestMethod.GET)
    public String arrangeBooksByCategory(
            @PathVariable("subcategory") String subcategory,
            @PathVariable("option") String option,
            Model model,
            @RequestParam(value = "page", defaultValue = "0") int page) {
        int pageSize = 8;
        subcategory = bookService.formatSubcategory(subcategory);
        String category = subcategoryService.getCategoryName(subcategory);
        List<Book> books = bookService.getArrangedBooksByCategory(category, page, pageSize, option);
        long totalBooks = bookService.countBooksByCategory(category);
        int totalPages = (int) Math.ceil((double) totalBooks / pageSize);
        if (option.equals("price-up")) {
            // sắp xếp books theo giá
            model.addAttribute("optionName", "Giá Thấp Đến Cao");
        } else if (option.equals("price-down")) {
            // sắp xếp books theo giá
            model.addAttribute("optionName", "Giá Cao Đến Thấp");
        } else if (option.equals("discount")) {
            // sắp xếp books theo Chiết Khấu
            model.addAttribute("optionName", "Chiết Khấu");
        } else {
            // sắp xếp books theo Nổi Bật Năm
            model.addAttribute("optionName", "Chiết Khấu");
        }
        model.addAttribute("books", books);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("currentPage", page);
        model.addAttribute("currentSubcategory", subcategory);
        model.addAttribute("currentCategory", category);
        model.addAttribute("category", true);
        model.addAttribute("arrange", true);
        model.addAttribute("option", option);
        return "bookList";
    }

    @PostMapping("/addBook")
    public String saveBook(@RequestParam("title") String title,
                           @RequestParam("price") Double price,
                           @RequestParam("discount") Double discount,
                           @RequestParam("author") String author,
                           @RequestParam("publisher") String publisher,
                           @RequestParam("publishedYear") Integer publishedYear,
                           @RequestParam("subcategoryId") Integer subcategoryId,
                           @RequestParam("pageNo") Integer pageNo,
                           @RequestParam("description") String description,
                           @RequestParam("saleQuantity") Integer saleQuantity,
                           @RequestParam("stockQuantity") Integer stockQuantity,
                           @RequestParam("coverType") String coverType,
                           @RequestParam("coverImage") MultipartFile coverImage) {
        // Tạo đối tượng Book và gán các giá trị từ form
        Book book = new Book();
        book.setTitle(title);
        book.setPrice(price);
        book.setDiscount(discount);
        book.setAuthor(author);
        book.setPublisher(publisher);
        book.setPublishedYear(publishedYear);
        book.setPageNo(pageNo);
        book.setDescription(description);
        book.setSaleQuantity(saleQuantity);
        book.setStockQuantity(stockQuantity);
        book.setCoverType(coverType);

        // Lấy đối tượng Subcategory từ cơ sở dữ liệu
        Subcategory subcategory = bookService.getSubcategory(subcategoryId);
        book.setSubcategory(subcategory);

        // Xử lý file ảnh
        if (!coverImage.isEmpty()) {
            try {
                book.setCoverImage(coverImage.getBytes());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Lưu đối tượng Book vào cơ sở dữ liệu
        bookService.saveBook(book);

        // Trả về trang hiển thị sau khi xử lý thành công
        return "addBooks";
    }

    @PostMapping("/uploadImage")
    public String uploadImage(@RequestParam("image") MultipartFile image) {
        if (image.isEmpty()) {
            // Xử lý khi không có file được chọn
            return "error";
        }
        System.out.println(image);
        return "success";
    }

    @RequestMapping("/delete/{bookId}")
    public String deleteBook(@PathVariable("bookId") Integer bookId) {
        bookService.deleteBook(bookId);
        return "home";
    }

    @RequestMapping("/edit/{bookId}")
    public String editBook(@PathVariable("bookId") Integer bookId, Model model) {
        Book book = bookService.getBookById(bookId);
        model.addAttribute("editBook", book);
        return "editBooks";
    }

    @PostMapping("/editBook/{bookId}")
    public String editBook(@RequestParam("title") String title,
                           @RequestParam("price") Double price,
                           @RequestParam("discount") Double discount,
                           @RequestParam("author") String author,
                           @RequestParam("publisher") String publisher,
                           @RequestParam("publishedYear") Integer publishedYear,
                           @RequestParam("subcategoryId") Integer subcategoryId,
                           @RequestParam("pageNo") Integer pageNo,
                           @RequestParam("description") String description,
                           @RequestParam("saleQuantity") Integer saleQuantity,
                           @RequestParam("stockQuantity") Integer stockQuantity,
                           @RequestParam("coverType") String coverType,
                           @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
                           @PathVariable("bookId") String bookId) {
        // Lấy ra book cần sửa
        Book book = bookService.getBookById(Integer.parseInt(bookId));
        book.setTitle(title);
        book.setPrice(price);
        book.setDiscount(discount);
        book.setAuthor(author);
        book.setPublisher(publisher);
        book.setPublishedYear(publishedYear);
        book.setPageNo(pageNo);
        book.setDescription(description);
        book.setSaleQuantity(saleQuantity);
        book.setStockQuantity(stockQuantity);
        book.setCoverType(coverType);

        // Lấy đối tượng Subcategory từ cơ sở dữ liệu
        Subcategory subcategory = bookService.getSubcategory(subcategoryId);
        book.setSubcategory(subcategory);

        // Xử lý file ảnh
        if (!coverImage.isEmpty()) {
            try {
                book.setCoverImage(coverImage.getBytes());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        // Lưu đối tượng Book vào cơ sở dữ liệu
        bookService.saveBook(book);

        // Trả về trang hiển thị sau khi xử lý thành công
        return "success";
    }

}
