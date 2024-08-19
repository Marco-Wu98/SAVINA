package fpt.hieunm.application.services.Order;

import fpt.hieunm.application.models.dao.Book.BookDAO;
import fpt.hieunm.application.models.dao.Order.OrderDAO;
import fpt.hieunm.application.models.dao.Order.OrderDetailDAO;
import fpt.hieunm.application.models.pojo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderDAO orderDAO;

    @Autowired
    OrderDetailDAO orderDetailDAO;

    @Autowired
    BookDAO bookDAO;

    @Override
    public Order createOrder(User user, Delivery delivery, List<OrderDetail> orderDetails) {
        // Tạo một đơn hàng mới
        Order order = new Order();
        order.setUser(user);
        order.setDate(new Date());
        order.setStatus("PENDING"); // Bạn có thể thay đổi trạng thái theo yêu cầu
        order.setOrderNo(generateOrderNo());
        order.setOrderDetails(orderDetails);
        order.setDelivery(delivery);

        // Tính tổng số tiền của đơn hàng
        double totalAmount = 0;
        for (OrderDetail orderDetail : orderDetails) {
            totalAmount += orderDetail.getBuyQuantity() * (orderDetail.getBook().getPrice() * (1 - orderDetail.getBook().getDiscount() / 100));

            // Cập nhật số lượng bán và số lượng trong kho
            Book book = orderDetail.getBook();
            book.setSaleQuantity(book.getSaleQuantity() + orderDetail.getBuyQuantity()); // Tăng số lượng bán
            book.setStockQuantity(book.getStockQuantity() - orderDetail.getBuyQuantity()); // Giảm số lượng trong kho

            // Lưu cập nhật của sách
            bookDAO.saveBook(book);
        }
        order.setAmount(totalAmount);

        // Lưu đơn hàng
        orderDAO.save(order);

        // Lưu từng chi tiết đơn hàng
        for (OrderDetail orderDetail : orderDetails) {
            orderDetail.setOrder(order);
            orderDetailDAO.save(orderDetail);
        }


        // Kiểm tra trạng thái đơn hàng và cập nhật số lượng hàng tồn kho nếu cần
//        if ("COMPLETED".equalsIgnoreCase(order.getStatus())) {
//            for (OrderDetail orderDetail : orderDetails) {
//                Book book = orderDetail.getBook();
//                book.setStockQuantity(book.getStockQuantity() - orderDetail.getBuyQuantity());
//                bookDAO.saveBook(book);
//            }
//        }

        return order;
    }

    @Override
    public List<Order> getOrders(User user) {
        return orderDAO.findAll(user);
    }

    @Override
    public void cancelOrder(User user, String orderNo) {
        List<Order> orders = user.getOrders();
        for (Order o : orders) {

            // fixed 24-06-2024
            if (o.getOrderNo().equals(orderNo)) {
                o.setStatus("CANCEL"); // Đặt trạng thái đơn hàng là "CANCEL"

                // Duyệt qua từng OrderDetail trong Order
                List<OrderDetail> orderDetails = o.getOrderDetails();
                for (OrderDetail od : orderDetails) {
                    Book book = od.getBook();
                    int buyQuantity = od.getBuyQuantity();

                    // Tăng lại số lượng trong kho
                    book.setStockQuantity(book.getStockQuantity() + buyQuantity);

                    // Giảm số lượng mua
                    book.setSaleQuantity(book.getSaleQuantity() - buyQuantity);

                    // Cập nhật sách
                    bookDAO.saveBook(book);
                }

                // Cập nhật đơn hàng
                orderDAO.update(o);
            }
        }
    }

    @Override
    public Order getOrder(String orderNo) {
        return orderDAO.findByOrderNo(orderNo);
    }

    @Override
    public List<Order> getAll() {
        return orderDAO.findAll();
    }


    @Override
    public void cancelOrderByAdmin(String orderNo) {
        Order order = orderDAO.findByOrderNo(orderNo);
        order.setStatus("CANCEL");
        orderDAO.update(order);
    }

    @Override
    public void completedOrderByAdmin(String orderNo) {
        // Lấy ra order >> cập nhập status thành completed
        Order order = orderDAO.findByOrderNo(orderNo);
        order.setStatus("COMPLETED");
        orderDAO.update(order);
//        // Đồng thời giảm số lượng sách trong kho + tăng số lượng sách bán được
//        for (OrderDetail orderDetail : order.getOrderDetails()) {
//            Book book = orderDetail.getBook();
//            int newStockQuantity = book.getStockQuantity() - orderDetail.getBuyQuantity();
//            int newSaleQuantity = book.getSaleQuantity() + orderDetail.getBuyQuantity();
//            book.setStockQuantity(newStockQuantity);
//            book.setSaleQuantity(newSaleQuantity);
//            bookDAO.saveBook(book);
//        }
    }

    @Override
    public List<Object[]> getMonthlySalesData(int currentYear) {
        return orderDAO.getMonthlySalesDataOfYear(currentYear);
    }

    @Override
    public List<Object[]> getDailySalesData(int currentYear, int currentMonth) {
        return orderDAO.getDailySalesData(currentYear, currentMonth);
    }

    private String generateOrderNo() {
        // Tạo một mã đơn hàng ngẫu nhiên. Bạn có thể thay đổi logic này nếu cần.
        return UUID.randomUUID().toString();
    }
}

