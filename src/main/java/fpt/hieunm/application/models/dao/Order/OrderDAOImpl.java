package fpt.hieunm.application.models.dao.Order;

import fpt.hieunm.application.models.pojo.Order;
import fpt.hieunm.application.models.pojo.User;
import jakarta.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class OrderDAOImpl implements OrderDAO {
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public void save(Order order) {
        Session session = sessionFactory.getCurrentSession();
        session.save(order);
    }

    @Override
    @Transactional
    public List<Order> findAll(User user) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "from Order o where o.user = :user";
        Query query = session.createQuery(hql);
        query.setParameter("user", user);
        return query.getResultList();

    }

    @Override
    @Transactional
    public void update(Order order) {
        Session session = sessionFactory.getCurrentSession();
        session.update(order);
    }

    @Override
    @Transactional
    public Order findByOrderNo(String orderNo) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "from Order o where o.orderNo = :orderNo";
        Query query = session.createQuery(hql, Order.class); // new fix 21/06/24
        query.setParameter("orderNo", orderNo);
        return (Order) query.getSingleResult();
    }

    @Override
    @Transactional
    public List<Order> findAll() {
        Session session = sessionFactory.getCurrentSession();
        String hql = "from Order";
        Query query = session.createQuery(hql, Order.class);
        return query.getResultList();
    }

    @Override
    @Transactional
    public List<Object[]> getMonthlySalesDataOfYear(int currentYear) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT MONTH(o.date), SUM(o.amount) " +
                "FROM Order o " +
                "WHERE YEAR(o.date) = :currentYear " +
                "GROUP BY MONTH(o.date)";
        Query query = session.createQuery(hql);
        query.setParameter("currentYear", currentYear);
        return query.getResultList();
    }

    @Override
    @Transactional
    public List<Object[]> getDailySalesData(int currentYear, int currentMonth) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "SELECT DAY(o.date), SUM(o.amount) " +
                "FROM Order o " +
                "WHERE YEAR(o.date) = :currentYear AND MONTH(o.date) = :currentMonth " +
                "GROUP BY DAY(o.date)";
        Query query = session.createQuery(hql);
        query.setParameter("currentYear", currentYear);
        query.setParameter("currentMonth", currentMonth);
        return query.getResultList();
    }


}
