package fpt.hieunm.application.models.dao.User;

import fpt.hieunm.application.models.dao.Book.BookDAO;
import fpt.hieunm.application.models.dao.Order.OrderDAO;
import fpt.hieunm.application.models.pojo.User;
import fpt.hieunm.application.services.Order.OrderService;
import jakarta.servlet.http.HttpServletRequest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.http.HttpRequest;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.io.*;
import java.util.List;
import java.util.jar.JarOutputStream;

import static org.junit.jupiter.api.Assertions.*;

class UserDAOImplTest {
    ApplicationContext context = null;
    UserDAO userDAO = null;
    BookDAO bookDAO = null;
    OrderDAO orderDAO = null;
    OrderService orderService = null;


    @BeforeEach
    void init() {
        context = new ClassPathXmlApplicationContext("applicationContext.xml");
        userDAO = context.getBean(UserDAO.class);
        bookDAO = context.getBean(BookDAO.class);
        orderDAO = context.getBean(OrderDAO.class);
        orderService = (OrderService) context.getBean("orderService");
    }

    @Test
    void test3() {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        List<Object[]> monthlySalesData = orderService.getMonthlySalesData(2024);
        System.out.println(monthlySalesData);

    }

    @Test
    void test1() {
        List<User> users = userDAO.getAllUsers();
        for (User user : users) {
            System.out.println(user);
        }
    }


    @Test
    void testSave() {
        User user = new User();
        user.setUserName("TEST3");
        user.setPwd("TEST3");
        user.setEmail("TEST3");
        user.setUserName("TEST3");
        user.setUserRole("TEST3");
        userDAO.save(user);
    }

    public String formatSubcategory(String subcategory) {
        StringBuilder formatted = new StringBuilder();
        // Tách chuỗi theo dấu gạch ngang "-"
        String[] words = subcategory.split("_");
        for (String word : words) {
            // Kiểm tra và loại bỏ các từ trống
            if (!word.isEmpty()) {
                // Chuyển chữ cái đầu của mỗi từ thành chữ in hoa
                String firstLetter = word.substring(0, 1).toUpperCase();
                String restLetters = word.substring(1);
                // Ghép từ đã chuyển đổi lại và thêm dấu cách
                formatted.append(firstLetter).append(restLetters).append(" ");
            }
        }
        // Xóa dấu cách cuối cùng
        formatted.deleteCharAt(formatted.length() - 1);
        return formatted.toString();
    }

    @Test
    void testSplit() {
        System.out.println(formatSubcategory("tiểu_thuyết"));
    }


    public void saveInputStreamToFile(InputStream inputStream, String directoryPath, String fileName) throws Exception {
        File directory = new File(directoryPath);
        if (!directory.exists()) {
            directory.mkdirs(); // Tạo thư mục nếu nó không tồn tại
        }

        File file = new File(directory, fileName);
        OutputStream outputStream = new FileOutputStream(file);
        byte[] buffer = new byte[1024];
        int length;
        while ((length = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, length);
        }
        System.out.println("File saved to: " + file.getAbsolutePath());

    }


    @Test
    void testBookDAO() throws Exception {
        byte[] coverImageById = bookDAO.getImageData(1);
        ByteArrayInputStream inputStream = new ByteArrayInputStream(coverImageById);
        String directoryPath = "src/main/img";
        String fileName = "1.jpg"; // Tên tệp bạn muốn lưu
        saveInputStreamToFile(inputStream, directoryPath, fileName);
        //System.out.println(coverImageById);

    }

}
