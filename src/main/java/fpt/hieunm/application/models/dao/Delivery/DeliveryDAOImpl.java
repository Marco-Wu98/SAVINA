package fpt.hieunm.application.models.dao.Delivery;

import fpt.hieunm.application.models.pojo.Delivery;
import jakarta.persistence.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class DeliveryDAOImpl implements DeliveryDAO{

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public void addDelivery(Delivery delivery) {
        Session session = sessionFactory.getCurrentSession();
        session.save(delivery);
    }

    @Override
    @Transactional
    public void updateDeliveryById(Integer deliveryId, Delivery delivery) {
        Session session = sessionFactory.getCurrentSession();
        String hql = "UPDATE Delivery SET recipientName = :recipientName, email = :email, phoneNumber = :phoneNumber, city = :city, district = :district, ward = :ward, address = :address WHERE id = :deliveryId";
        Query query = session.createQuery(hql);
        query.setParameter("recipientName", delivery.getRecipientName());
        query.setParameter("email", delivery.getEmail());
        query.setParameter("phoneNumber", delivery.getPhoneNumber());
        query.setParameter("city", delivery.getCity());
        query.setParameter("district", delivery.getDistrict());
        query.setParameter("ward", delivery.getWard());
        query.setParameter("address", delivery.getAddress());
        query.setParameter("deliveryId", deliveryId);
        query.executeUpdate();
    }


}
