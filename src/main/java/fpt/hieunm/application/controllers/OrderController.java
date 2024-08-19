package fpt.hieunm.application.controllers;

import fpt.hieunm.application.models.pojo.*;
import fpt.hieunm.application.services.Book.BookService;
import fpt.hieunm.application.services.Cart.CartService;
import fpt.hieunm.application.services.Delivery.DeliveryService;
import fpt.hieunm.application.services.Order.OrderService;
import fpt.hieunm.application.services.User.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
public class OrderController {

    @Autowired
    OrderService orderService;

    @Autowired
    BookService bookService;

    @Autowired
    DeliveryService deliveryService;

    @Autowired
    UserService userService;

    @Autowired
    CartService cartService;

//    @RequestMapping("/create")
//    public String createOrder(@RequestBody List<OrderDetail> orderDetails, @RequestParam int userId) {
//        // Giả định bạn có một phương thức để lấy thông tin user từ userId
//        User user = getUserById(userId);
//
//         buyService.createOrder(user, orderDetails);
//        return null;
//    }

    @RequestMapping("/order")
    public String createOrderDetails(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        // Lấy giá trị từ request
        String bookIds = request.getParameter("bookId");
        String buyQuantities = request.getParameter("buyQuantity");

        // Chuyển đổi thành mảng các bookId và buyQuantity
        String[] bookIdArray = bookIds.split(",");
        // Thêm mảng lưu bookId muốn mua vào session
        session.setAttribute("buyBookIds", bookIdArray);
        String[] buyQuantityArray = buyQuantities.split(",");

        // Xử lý logic tạo order ở đây

        List<OrderDetail> orderDetails = new ArrayList<>();
        for (int i = 0; i < bookIdArray.length; i++) {
            OrderDetail orderDetail = new OrderDetail();
            // lấy ra Book tương ứng với bookId
            Book book = bookService.getBookById(Integer.parseInt(bookIdArray[i]));
            orderDetail.setBook(book);
            orderDetail.setBuyQuantity(Integer.parseInt(buyQuantityArray[i]));
            orderDetails.add(orderDetail);
        }
        session.setAttribute("orderDetails", orderDetails);
        return "delivery"; // Chuyển hướng đến trang delivery
    }

    @RequestMapping("/orderDetail")
    public String orderDetail() {
        return "orderDetail";
    }

    @RequestMapping("/orderOneMoreStep")
    public String orderOneMoreStep(HttpServletRequest request, Delivery delivery) {
        // Gán địa chỉ này cho user
        User user = (User) request.getSession().getAttribute("user");
        delivery.setUser(user);
        deliveryService.addDelivery(delivery);
        return "success";
    }

    @RequestMapping("/updateDelivery")
    public String updateDelivery(HttpServletRequest request, Delivery delivery, @RequestParam("index") String index) {
        // Lấy ra địa chỉ cũ trong List<Dekivery> của user
        User user = (User) request.getSession().getAttribute("user");
        delivery.setUser(user);
        // Cập nhật lại delivery
        Delivery currentDelivery = user.getDeliveries().get(Integer.parseInt(index));
        deliveryService.updateDeliveryById(currentDelivery.getId(), delivery);
        // Cập nhập lại deliveries trong user
        user.getDeliveries().set(Integer.parseInt(index), delivery);
        return "redirect:/delivery";
    }

    @RequestMapping("/addDelivery")
    public String addDelivery(HttpServletRequest request, Delivery delivery) {
        User user = (User) request.getSession().getAttribute("user");
        delivery.setUser(user);
        deliveryService.addDelivery(delivery);
        // Cập nhập lại deliveries trong user
        user.getDeliveries().add(delivery);
        return "redirect:/delivery";
    }

    @RequestMapping("/orderFinish")
    public String orderFinish(@RequestParam("index") String index, HttpSession session, Model model) {
        // Lấy ra user
        User user = (User) session.getAttribute("user");
        // Lấy ra delivery dùng để đặt hàng
        Delivery delivery = user.getDeliveries().get(Integer.parseInt(index));


        List<OrderDetail> orderDetails = (List<OrderDetail>) session.getAttribute("orderDetails");


        // Tạo order
        Order order = orderService.createOrder(user, delivery, orderDetails);
        session.setAttribute("order", order);
        session.setAttribute("delivery", delivery);
        // Xóa book ra khỏi giỏ hàng
        // Lấy buyBookId từ session
        String bookIds[] = (String[]) session.getAttribute("buyBookIds");
        for (String bookId : bookIds) {
            cartService.deleteFromCart(user, Integer.parseInt(bookId));
        }
        Map<Book, Integer> addListWithLoggedIn = cartService.getAllByUser(user);
        session.setAttribute("addListWithLoggedIn", addListWithLoggedIn);
        return "redirect:/orderDetail";
    }

    @RequestMapping("/firstOrderFinish")
    public String firstOrderFinish(HttpSession session, Model model, Delivery delivery) {
        User user = (User) session.getAttribute("user");
        // Thêm mới delivery
        delivery.setUser(user);
        deliveryService.addDelivery(delivery);
        user.getDeliveries().add(delivery);
        // Lấy ra orderDetails
        List<OrderDetail> orderDetails = (List<OrderDetail>) session.getAttribute("orderDetails");
        // Tạo order
        Order order = orderService.createOrder(user, delivery, orderDetails);
        session.setAttribute("user", user);
        session.setAttribute("order", order);
        session.setAttribute("delivery", delivery);
        // Xóa book ra khỏi giỏ hàng
        // Lấy buyBookId từ session
        String bookIds[] = (String[]) session.getAttribute("buyBookIds");
        for (String bookId : bookIds) {
            cartService.deleteFromCart(user, Integer.parseInt(bookId));
        }
        Map<Book, Integer> addListWithLoggedIn = cartService.getAllByUser(user);
        session.setAttribute("addListWithLoggedIn", addListWithLoggedIn);
        return "redirect:/orderDetail";
    }

    @RequestMapping("/orders")
    public String orders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        List<Order> orders = orderService.getOrders(user);
        session.setAttribute("orders", orders);
        model.addAttribute("allOption", true);
        // tạo pendingOrders
        List<Order> pendingOrders = new ArrayList<>();
        for (Order order : orders) {
            if (order.getStatus().equalsIgnoreCase("pending")) {
                pendingOrders.add(order);
            }
        }
        session.setAttribute("pendingOrders", pendingOrders);

        // tạo completedOrders
        List<Order> completedOrders = new ArrayList<>();
        for (Order order : orders) {
            if (order.getStatus().equalsIgnoreCase("completed")) {
                completedOrders.add(order);
            }
        }
        session.setAttribute("completedOrders", completedOrders);

        // tạo cancelOrders
        List<Order> cancelOrders = new ArrayList<>();
        for (Order order : orders) {
            if (order.getStatus().equalsIgnoreCase("cancel")) {
                cancelOrders.add(order);
            }
        }
        session.setAttribute("cancelOrders", cancelOrders);
        return "orders";
    }

    @RequestMapping("/pendingOrders")
    public String pendingOrders(Model model) {
        model.addAttribute("pendingOption", true);
        return "orders";
    }

    @RequestMapping("/completedOrders")
    public String completedOrders(Model model) {
        model.addAttribute("completedOption", true);
        return "orders";
    }

    @RequestMapping("/cancelOrders")
    public String cancelOrders(Model model) {
        model.addAttribute("cancelOption", true);
        return "orders";
    }

    // Hủy đơn
    @RequestMapping("/cancelOrder")
    public String cancelOrder(HttpSession session, Model model,
                              @RequestParam("orderNo") String orderNo) {
        User user = (User) session.getAttribute("user");
        orderService.cancelOrder(user, orderNo);
        return "redirect:/orders";

    }

    // Hủy đơn bởi admin
    @RequestMapping("/cancelOrderByAdmin")
    public String cancelOrderByAdmin(HttpSession session, Model model,
                              @RequestParam("orderNo") String orderNo) {
               orderService.cancelOrderByAdmin(orderNo);
        return "redirect:/orderManage";
    }

    // Hoàn thành đơn bởi admin
    @RequestMapping("/completedOrderByAdmin")
    public String completedOrderByAdmin(HttpSession session, Model model,
                                     @RequestParam("orderNo") String orderNo) {
        orderService.completedOrderByAdmin(orderNo);
        return "redirect:/orderManage";
    }

    // Ấn vào từng order để xem chi tiết
    @RequestMapping("/orderInfo")
    public String orderInfo(HttpSession session, Model model, @RequestParam("orderNo") String orderNo) {
        Order order = orderService.getOrder(orderNo);
        session.setAttribute("order", order);
        return "redirect:/orderDetail";
    }

    //    PHẦN NÀY DÀNH CHO ADMIN

    // orderManage dành cho admin
    @RequestMapping("/orderManage")
    public String orderManage(HttpSession session, Model model) {
        List<Order> orders = orderService.getAll();
        session.setAttribute("allOrders", orders);
//       =================================
        model.addAttribute("allOption", true);
        // tạo pendingOrders
        List<Order> pendingOrders = new ArrayList<>();
        for (Order order : orders) {
            if (order.getStatus().equalsIgnoreCase("pending")) {
                pendingOrders.add(order);
            }
        }
        session.setAttribute("pendingOrders", pendingOrders);

        // tạo completedOrders
        List<Order> completedOrders = new ArrayList<>();
        for (Order order : orders) {
            if (order.getStatus().equalsIgnoreCase("completed")) {
                completedOrders.add(order);
            }
        }
        session.setAttribute("completedOrders", completedOrders);

        // tạo cancelOrders
        List<Order> cancelOrders = new ArrayList<>();
        for (Order order : orders) {
            if (order.getStatus().equalsIgnoreCase("cancel")) {
                cancelOrders.add(order);
            }
        }
        session.setAttribute("cancelOrders", cancelOrders);

//        ================================

        return "orderManage";
    }

    @RequestMapping("/pendingOrdersAdmin")
    public String pendingOrdersAdmin(Model model) {
        model.addAttribute("pendingOption", true);
        return "orderManage";
    }

    @RequestMapping("/completedOrdersAdmin")
    public String completedOrdersAdmin(Model model) {
        model.addAttribute("completedOption", true);
        return "orderManage";
    }

    @RequestMapping("/cancelOrdersAdmin")
    public String cancelOrdersAdmin(Model model) {
        model.addAttribute("cancelOption", true);
        return "orderManage";
    }
}
