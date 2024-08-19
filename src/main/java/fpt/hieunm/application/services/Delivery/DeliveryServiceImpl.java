package fpt.hieunm.application.services.Delivery;

import fpt.hieunm.application.models.dao.Delivery.DeliveryDAO;
import fpt.hieunm.application.models.pojo.Delivery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeliveryServiceImpl implements DeliveryService{

    @Autowired
    DeliveryDAO deliveryDAO;

    @Override
    public void addDelivery(Delivery delivery) {
        deliveryDAO.addDelivery(delivery);
    }

    @Override
    public void updateDeliveryById(Integer deliveryId, Delivery delivery) {
        deliveryDAO.updateDeliveryById(deliveryId, delivery);
    }
}
