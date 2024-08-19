package fpt.hieunm.application.services.User;

import fpt.hieunm.application.models.pojo.User;
import org.apache.commons.mail.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class EmailServiceImpl implements EmailService {


    private static final String HOST_NAME = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;
    private static final String USER_NAME = "savina.fpt.edu@gmail.com";
    private static final String PASSWORD = "bqbu gxfm mfrq ekyc";
    private static final boolean STARTTLS_ENABLED = true;

    @Override
    public void sendVerificationEmail(User user, String verificationCode) throws EmailException {
        try {
            SimpleEmail email = new SimpleEmail();
            email.setHostName(HOST_NAME);
            email.setSmtpPort(SMTP_PORT);
            email.setAuthenticator(new DefaultAuthenticator(USER_NAME, PASSWORD));
            email.setStartTLSEnabled(STARTTLS_ENABLED);

            // Địa chỉ email người gửi và người nhận
            email.setFrom(USER_NAME, "SAVINA");
            email.addTo(user.getEmail(), user.getUserName());

            // Tiêu đề và nội dung email
            email.setCharset("UTF-8"); // Thiết lập charset là UTF-8 để hỗ trợ các ký tự đặc biệt và ngôn ngữ khác nhau
            email.setSubject("Xác nhận đăng ký tài khoản");
            email.setMsg("Chào " + user.getUserName() + ",\n\n"
                    + "Đây là mã xác nhận của bạn:\n\n" +
                    ""
                    + verificationCode + "\n\n"
                    + "Xin vui lòng sử dụng mã này để hoàn tất quá trình.");

            // Gửi email
            email.send();
            System.out.println("Email sent successfully.");
        } catch (EmailException e) {
            e.printStackTrace();
        }
    }


    @Override
    // Phương thức này sinh ra mã xác nhận ngẫu nhiên
    public String generateVerificationCode() {
        Random random = new Random();
        int verificationCode = 100000 + random.nextInt(900000); // Random từ 100000 đến 999999
        return String.valueOf(verificationCode);
    }
}
