package fpt.hieunm.application.models.dao.Delivery;

import fpt.hieunm.application.models.pojo.Delivery;

public interface DeliveryDAO {

    void addDelivery(Delivery delivery);

    void updateDeliveryById(Integer deliveryId, Delivery delivery);
}
