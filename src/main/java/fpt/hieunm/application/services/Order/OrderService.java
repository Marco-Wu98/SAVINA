package fpt.hieunm.application.services.Order;

import fpt.hieunm.application.models.pojo.Delivery;
import fpt.hieunm.application.models.pojo.Order;
import fpt.hieunm.application.models.pojo.OrderDetail;
import fpt.hieunm.application.models.pojo.User;

import java.util.List;


public interface OrderService {
    Order createOrder(User user, Delivery delivery, List<OrderDetail> orderDetails);

    List<Order> getOrders(User user);

    void cancelOrder(User user, String orderNo);

    Order getOrder(String orderNo);

    List<Order> getAll();

    void cancelOrderByAdmin(String orderNo);

    void completedOrderByAdmin(String orderNo);

    List<Object[]> getMonthlySalesData(int currentYear);

    List<Object[]> getDailySalesData(int currentYear, int currentMonth);
}
