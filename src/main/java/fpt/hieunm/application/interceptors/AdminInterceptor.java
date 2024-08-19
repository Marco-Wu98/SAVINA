package fpt.hieunm.application.interceptors;

import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.Order;
import fpt.hieunm.application.models.pojo.OrderDetail;
import fpt.hieunm.application.models.pojo.User;
import fpt.hieunm.application.services.Book.BookService;
import fpt.hieunm.application.services.Order.OrderService;
import fpt.hieunm.application.services.User.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class AdminInterceptor implements HandlerInterceptor {
    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    @Autowired
    private BookService bookService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !user.getUserRole().equalsIgnoreCase("admin")) {
            // Nếu người dùng không phải admin
            response.sendRedirect(request.getContextPath() + "/home");
            return false;
        }
        // Lấy ra các thông số để hiển thị

        // 1. Lấy ra tổng sản phẩm đã bán được trong tháng
        List<Order> orders = orderService.getAll();
        List<Order> monthOrders = new ArrayList<>();
        // Lấy tháng hiện tại
        int currentMonth = LocalDate.now().getMonthValue();

        for (Order order : orders) {
            // So sánh tháng của đơn hàng với tháng hiện tại
            if (order.getDate().getMonth() + 1 == currentMonth) {
                monthOrders.add(order);
            }
        }
        HttpSession session = request.getSession();
        int sales = 0;
        for (Order order : monthOrders) {
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for (OrderDetail orderDetail : orderDetails) {
                sales += orderDetail.getBuyQuantity();
            }
        }
        session.setAttribute("sales", sales);

        // 2. Lấy ra tổng khách hàng
        List<User> users = userService.findAllUsers();
        int usersCount = users.size();
        session.setAttribute("usersCount", usersCount);
        session.setAttribute("users", users);

        // 3. Lấy ra tổng sản phẩm
        List<Book> books = bookService.findAllBooks();
        int booksCount = books.size();
        session.setAttribute("product", booksCount);

        // 3. Lấy ra doanh thu tháng
        double revenue = 0;
        for (Order order : monthOrders) {
            revenue += order.getAmount();
        }
        session.setAttribute("revenue", revenue);
        //--------------------------------------------------------------
        // So sánh doanh thu so với tháng trước
        // Lấy tháng truớc
        int prevMonth = (currentMonth == 1) ? 12 : currentMonth - 1;
        // Lấy ra đơn hàng tháng trước
        List<Order> prevMonthOrders = new ArrayList<>();
        for (Order order : orders) {
            // So sánh tháng của đơn hàng với tháng trước
            if (order.getDate().getMonth() + 1 == prevMonth) {
                prevMonthOrders.add(order);
            }
        }
        // Tính doanh thu tháng trước
        int prevMonthRevenue = 0;
        for (Order order : prevMonthOrders) {
            prevMonthRevenue += order.getAmount();
        }
        // So sánh tăng trưởng so với tháng trước
        double growthRate = 0;
        if (prevMonthRevenue != 0) {
            growthRate = ((double) (revenue - prevMonthRevenue) / prevMonthRevenue) * 100;
        }
        System.out.println("prev: " + prevMonthRevenue);
        System.out.println("curr: " + revenue);
        session.setAttribute("growthRate", growthRate);

        // Lấy ra top 10 cuốn sách bán chạy
        List<Book> topBooks = new ArrayList<>();
        books.sort(new Comparator<Book>() {

            @Override
            public int compare(Book b1, Book b2) {
                return Integer.compare(b2.getSaleQuantity(), b1.getSaleQuantity());
            }
        });
        for (int i = 0; i < 10; i++) {
            topBooks.add(books.get(i));
        }
        session.setAttribute("topBooks", topBooks);
        return true;
    }
}
