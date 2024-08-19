package fpt.hieunm.application.controllers;

import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.User;
import fpt.hieunm.application.services.Book.BookService;
import fpt.hieunm.application.services.Cart.CartService;
import fpt.hieunm.application.services.User.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.*;

@Controller
public class CartController {

    @Autowired
    CartService cartService;

    @Autowired
    BookService bookService;

    @Autowired
    UserService userService;

    @RequestMapping("/addToCart/{bookId}/{quantity}")
    public String addToCart(@PathVariable int bookId,
                            @PathVariable int quantity,
                            HttpServletRequest request) {
        HttpSession session = request.getSession();

        // Nếu chưa đăng nhập
        if (session.getAttribute("isLoggedIn") == null) {
            // xử lý với addListNotLoggedIn
            Map<Book, Integer> addListNotLoggedIn;

            // Kiểm tra xem addListNotLoggedIn đã được khởi tạo chưa
            if (session.getAttribute("addListNotLoggedIn") == null) {
                addListNotLoggedIn = new HashMap<>();
            } else {
                // Lấy addListNotLoggedIn từ session nếu đã tồn tại
                addListNotLoggedIn = (Map<Book, Integer>) session.getAttribute("addListNotLoggedIn");
            }

            // Kiểm tra xem bookId đã tồn tại trong addListNotLoggedIn chưa
            Book existingBook = findBookInMap(addListNotLoggedIn, bookId);

            if (existingBook != null) {
                // Nếu sách đã tồn tại, tăng số lượng
                int currentQuantity = addListNotLoggedIn.get(existingBook);
                addListNotLoggedIn.put(existingBook, currentQuantity + quantity);
            } else {
                // Nếu sách chưa tồn tại, thêm mới vào addListNotLoggedIn
                Book addBook = bookService.getBookById(bookId);
                addListNotLoggedIn.put(addBook, quantity);
            }

            // Cập nhật addListNotLoggedIn vào session
            session.setAttribute("addListNotLoggedIn", addListNotLoggedIn);
        }

        // Nếu đăng nhập rồi
        else {
            // Lấy ra user
            User user = (User) session.getAttribute("user");
            // Lấy ra book
            Book book = bookService.getBookById(bookId);
            // Kiểm tra xem user đã mua sách đó chưa
            if (cartService.checkExistByBookId(user, bookId)) {
                // Nếu rồi thì update
                cartService.updateToCart(user, bookId, quantity);
            } else {
                // Nếu chưa thì thêm mới
                cartService.add(user, book, quantity);
            }
            // xử lý với addListWithLoggedIn
            Map<Book, Integer> addListWithLoggedIn;
            addListWithLoggedIn = cartService.getAllByUser(user);
            session.setAttribute("addListWithLoggedIn", addListWithLoggedIn);
        }


        return "redirect:/info/" + bookId;
    }

    @RequestMapping("/buy/{bookId}/{quantity}")
    public String buy(@PathVariable int bookId,
                      @PathVariable int quantity,
                      HttpServletRequest request) {
        HttpSession session = request.getSession();

        // Nếu chưa đăng nhập
        if (session.getAttribute("isLoggedIn") == null) {
            // xử lý với addListNotLoggedIn
            Map<Book, Integer> addListNotLoggedIn;

            // Kiểm tra xem addListNotLoggedIn đã được khởi tạo chưa
            if (session.getAttribute("addListNotLoggedIn") == null) {
                addListNotLoggedIn = new HashMap<>();
            } else {
                // Lấy addListNotLoggedIn từ session nếu đã tồn tại
                addListNotLoggedIn = (Map<Book, Integer>) session.getAttribute("addListNotLoggedIn");
            }

            // Kiểm tra xem bookId đã tồn tại trong addListNotLoggedIn chưa
            Book existingBook = findBookInMap(addListNotLoggedIn, bookId);

            if (existingBook != null) {
                // Nếu sách đã tồn tại, tăng số lượng
                int currentQuantity = addListNotLoggedIn.get(existingBook);
                addListNotLoggedIn.put(existingBook, currentQuantity + quantity);
            } else {
                // Nếu sách chưa tồn tại, thêm mới vào addListNotLoggedIn
                Book addBook = bookService.getBookById(bookId);
                addListNotLoggedIn.put(addBook, quantity);
            }

            // Cập nhật addListNotLoggedIn vào session
            session.setAttribute("addListNotLoggedIn", addListNotLoggedIn);
        }

        // Nếu đăng nhập rồi
        else {
            // Lấy ra user
            User user = (User) session.getAttribute("user");
            // Lấy ra book
            Book book = bookService.getBookById(bookId);
            // Kiểm tra xem user đã mua sách đó chưa
            if (cartService.checkExistByBookId(user, bookId)) {
                // Nếu rồi thì update
                cartService.updateToCart(user, bookId, quantity);
            } else {
                // Nếu chưa thì thêm mới
                cartService.add(user, book, quantity);
            }
            // xử lý với addListWithLoggedIn
            Map<Book, Integer> addListWithLoggedIn;
            addListWithLoggedIn = cartService.getAllByUser(user);
            session.setAttribute("addListWithLoggedIn", addListWithLoggedIn);
        }


        return "redirect:/cart";
    }

    // Hàm tìm kiếm book trong Map theo bookId
    private Book findBookInMap(Map<Book, Integer> map, int bookId) {
        for (Map.Entry<Book, Integer> entry : map.entrySet()) {
            if (entry.getKey().getId() == bookId) {
                return entry.getKey();
            }
        }
        return null;
    }


    @RequestMapping("/dellToCart/{bookId}/{quantity}")
    public String dellFromCart(@PathVariable int bookId,
                               @PathVariable int quantity,
                               HttpServletRequest request) {
        HttpSession session = request.getSession();
        // Kiểm tra xem có đang đăng nhập không

        // Nếu chưa đăng nhập
        if (session.getAttribute("isLoggedIn") == null) {
            // Nếu chưa đăng nhập thì xóa từ addListNotLoggedIn trong phiên
            Map<Book, Integer> addListNotLoggedIn = (Map<Book, Integer>) session.getAttribute("addListNotLoggedIn");
            if (addListNotLoggedIn != null) {
                Iterator<Map.Entry<Book, Integer>> iterator = addListNotLoggedIn.entrySet().iterator();
                while (iterator.hasNext()) {
                    Map.Entry<Book, Integer> entry = iterator.next();
                    if (entry.getKey().getId() == bookId) {
                        iterator.remove(); // Sử dụng Iterator để xóa phần tử an toàn
                    }
                }
            }
        } else {
            // Nếu đã đăng nhập
            User user = (User) session.getAttribute("user");
            cartService.deleteFromCart(user, bookId);
            Map<Book, Integer> addListWithLoggedIn = cartService.getAllByUser(user);
            session.setAttribute("addListWithLoggedIn", addListWithLoggedIn);
        }


        return "redirect:/cart";
    }

    @RequestMapping("/updateQuantity")
    public String updateQuantity(
            @RequestParam("bookId") int bookId,
            @RequestParam("newQuantity") int newQuantity,
            HttpSession session) {
        Map<Book, Integer> addListWithLoggedIn = (Map<Book, Integer>) session.getAttribute("addListWithLoggedIn");
        Map<Book, Integer> addListNotLoggedIn = (Map<Book, Integer>) session.getAttribute("addListNotLoggedIn");
        Book book = bookService.getBookById(bookId);
//        if(newQuantity > book.getStockQuantity()){
//            session.setAttribute("alert", true);
//            return "redirect:/cart";
//        }
//        session.setAttribute("alert", false);
        // Nếu người dùng chưa đăng nhập
        if (session.getAttribute("user") == null) {
            for (Map.Entry<Book, Integer> entry : addListNotLoggedIn.entrySet()) {
                if (entry.getKey().getId() == bookId) {
                    if (newQuantity < 1) {
                        newQuantity = 1; // Đảm bảo số lượng không nhỏ hơn 1
                    }
                    addListNotLoggedIn.put(entry.getKey(), newQuantity);
                    // cập nhật lại addListNotLoggedIn
                    session.setAttribute("addListNotLoggedIn", addListNotLoggedIn);
                    break;
                }
            }
        }
        // Nếu người dùng đã đăng nhập
        if (session.getAttribute("user") != null) {
            for (Map.Entry<Book, Integer> entry : addListWithLoggedIn.entrySet()) {
                if (entry.getKey().getId() == bookId) {
                    if (newQuantity < 1) {
                        newQuantity = 1; // Đảm bảo số lượng không nhỏ hơn 1
                    }
                    addListWithLoggedIn.put(entry.getKey(), newQuantity);
                    // cập nhật lại cartItem
                    User user = (User) session.getAttribute("user");
                    cartService.updateQuantity(user, bookId, newQuantity);
                    break;
                }
            }
        }

        // Chuyển hướng về trang giỏ hàng sau khi cập nhật số lượng
        return "redirect:/cart";
    }


}
