package fpt.hieunm.application.models.dao.Order;

import fpt.hieunm.application.models.pojo.Order;
import fpt.hieunm.application.models.pojo.User;

import java.util.List;

public interface OrderDAO {
    void save(Order order);

    List<Order> findAll(User user);

    void update(Order order);

    Order findByOrderNo(String orderNo);

    List<Order> findAll();

    List<Object[]> getMonthlySalesDataOfYear(int currentYear);

    List<Object[]> getDailySalesData(int currentYear, int currentMonth);
}
