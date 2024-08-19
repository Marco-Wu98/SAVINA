package fpt.hieunm.application.services.Delivery;

import fpt.hieunm.application.models.pojo.Delivery;

public interface DeliveryService {

    void addDelivery(Delivery delivery);

    void updateDeliveryById(Integer deliveryId, Delivery delivery);
}
