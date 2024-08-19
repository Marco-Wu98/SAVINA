package fpt.hieunm.application.models.dao.Order;

import fpt.hieunm.application.models.pojo.OrderDetail;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class OrderDetailDAOImpl implements OrderDetailDAO{
    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public void save(OrderDetail orderDetail) {
        Session session = sessionFactory.getCurrentSession();
        session.save(orderDetail);
    }
}
