package fpt.hieunm.application.services.User;

import fpt.hieunm.application.models.pojo.User;

public interface EmailService {
    void sendVerificationEmail(User user, String verificationCode) throws Exception;

    String generateVerificationCode();
}
