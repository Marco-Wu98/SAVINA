package fpt.hieunm.application.services.Book;

import fpt.hieunm.application.models.dao.Book.BookDAO;
import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.Subcategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {

    @Autowired
    private BookDAO bookDAO;

    // ========================================================================

    @Override
    public List<Book> getBooksBySubcategory(String subcategory, int page, int pageSize) {
        int firstResult = page * pageSize;
        return bookDAO.findBySubcategory(subcategory, firstResult, pageSize);
    }

    @Override
    public long countBooksBySubcategory(String subcategory) {
        return bookDAO.countBySubcategory(subcategory);
    }

    // ========================================================================

    @Override
    public List<Book> getBooksByCategory(String category, int page, int pageSize) {
        int firstResult = page * pageSize;
        return bookDAO.findByCategory(category, firstResult, pageSize);
    }

    @Override
    public long countBooksByCategory(String category) {
        return bookDAO.countByCategory(category);
    }
    //    ========================================================================

    @Override
    public String formatSubcategory(String subcategory) {
        StringBuilder formatted = new StringBuilder();
        // Tách chuỗi theo dấu gạch ngang "_"
        String[] words = subcategory.split("_");
        for (String word : words) {
            // Chuyển chữ cái đầu của mỗi từ thành chữ in hoa
            String firstLetter = word.substring(0, 1).toUpperCase();
            String restLetters = word.substring(1);
            // Ghép từ đã chuyển đổi lại
            formatted.append(firstLetter).append(restLetters).append(" ");
        }
        // Xóa dấu cách cuối cùng
        formatted.deleteCharAt(formatted.length() - 1);
        return formatted.toString();
    }

    @Override
    public byte[] getImageData(int bookId) {
        return bookDAO.getImageData(bookId);
    }


    @Override
    public List<Book> getBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, String publisher, int page, int pageSize) {
        List<Book> books;
        int firstResult = page * pageSize;

        if (publisher == null) {
            // Nếu publisher là null, không lọc theo publisher
            books = bookDAO.getBooksBySubcategoryWithFilter(subcategory, minPrice, maxPrice, firstResult, pageSize);
        } else {
            // Nếu publisher không phải là null, lọc theo cả publisher
            books = bookDAO.getBooksBySubcategoryWithFilter(subcategory, minPrice, maxPrice, publisher, firstResult, pageSize);
        }
        return books;
    }

    @Override
    public long countBooksBySubcategoryWithFilter(String subcategory, int minPrice, int maxPrice, String publisher) {
        long totalBooks;

        if (publisher == null) {
            // Nếu publisher là null, không lọc theo publisher
            totalBooks = bookDAO.countBooksBySubcategoryWithFilter(subcategory, minPrice, maxPrice);
        } else {
            // Nếu publisher không phải là null, lọc theo cả publisher
            totalBooks = bookDAO.countBooksBySubcategoryWithFilter(subcategory, minPrice, maxPrice, publisher);
        }
        return totalBooks;
    }

    @Override
    public Book getBookById(int bookId) {
        return bookDAO.getBookById(bookId);
    }

    @Override
    public List<Book> getBooksBySubcategoryWithoutPagination(String subcategory) {
        return bookDAO.getBooksBySubcategoryWithoutPagination(subcategory);
    }

    @Override
    public List<Book> searchBooks(String keyword) {
        return bookDAO.searchBooks(keyword);
    }

    @Override
    public List<Book> getBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, String publisher, int page, int pageSize) {
        List<Book> books;
        int firstResult = page * pageSize;

        if (publisher == null) {
            // Nếu publisher là null, không lọc theo publisher
            books = bookDAO.getBooksByKeywordWithFilter(keyword, minPrice, maxPrice, firstResult, pageSize);
        } else {
            // Nếu publisher không phải là null, lọc theo cả publisher
            books = bookDAO.getBooksByKeywordWithFilter(keyword, minPrice, maxPrice, publisher, firstResult, pageSize);
        }
        return books;
    }

    @Override
    public long countBooksByKeywordWithFilter(String keyword, int minPrice, int maxPrice, String publisher) {
        long totalBooks;

        if (publisher == null) {
            // Nếu publisher là null, không lọc theo publisher
            totalBooks = bookDAO.countBooksByKeywordWithFilter(keyword, minPrice, maxPrice);
        } else {
            // Nếu publisher không phải là null, lọc theo cả publisher
            totalBooks = bookDAO.countBooksByKeywordWithFilter(keyword, minPrice, maxPrice, publisher);
        }
        return totalBooks;
    }

    @Override
    public List<Book> getArrangedBooksBySubcategory(String subcategory, int page, int pageSize, String option) {
        int firstResult = page * pageSize;
        return bookDAO.getArrangedBooksBySubcategory(subcategory, firstResult, pageSize, option);
    }

    @Override
    public List<Book> getArrangedBooksByCategory(String category, int page, int pageSize, String option) {
        int firstResult = page * pageSize;
        return bookDAO.getArrangedBooksByCategory(category, firstResult, pageSize, option);
    }

    @Override
    public Subcategory getSubcategory(int subcategoryId) {
        return bookDAO.getSubcategoryById(subcategoryId);
    }

    @Override
    public void saveBook(Book book) {
        bookDAO.saveBook(book);
    }

    @Override
    public void deleteBook(int bookId) {
        bookDAO.deleteBookById(bookId);
    }

    @Override
    public List<Book> findAllBooks() {
        return bookDAO.getAllBooks();
    }


}

