package fpt.hieunm.application.controllers;

import fpt.hieunm.application.models.pojo.Book;
import fpt.hieunm.application.models.pojo.CustomExceptions;
import fpt.hieunm.application.models.pojo.User;
import fpt.hieunm.application.services.Cart.CartService;
import fpt.hieunm.application.services.User.EmailService;
import fpt.hieunm.application.services.User.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;


@Controller
public class UserController {
    @Autowired
    UserService userService;

    @Autowired
    CartService cartService;

    @Autowired
    EmailService emailService;

    @PostMapping("/authentic")
    public String login(User user,
                        HttpServletRequest request,
                        HttpServletResponse response,
                        Model model,
                        @RequestParam(value = "rememberMe", required = false) String rememberMe) {
        HttpSession session = request.getSession();
        User existedUser = userService.getUser(user.getUserName(), user.getPwd());
        if (existedUser != null) {
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("user", existedUser);
            Map<Book, Integer> addListWithLoggedIn;
            addListWithLoggedIn = cartService.getAllByUser(existedUser);
            session.setAttribute("addListWithLoggedIn", addListWithLoggedIn);
            // Xử lý khi người dùng chọn rememberMe
            if (rememberMe != null && rememberMe.equals("on")) {
                // Create a cookie for the username and password
                Cookie cookieName = new Cookie("cookieName", user.getUserName());
                Cookie cookiePassword = new Cookie("cookiePassword", user.getPwd());
                cookieName.setMaxAge(60 * 60 * 24); // Cookie expires in 1 day
                cookiePassword.setMaxAge(60 * 60 * 24); // Cookie expires in 60s
                response.addCookie(cookieName);
                response.addCookie(cookiePassword);
            } else {
                // If "Remember Me" checkbox is not checked, remove any existing cookie
                Cookie cookieName = new Cookie("cookieName", "");
                Cookie cookiePassword = new Cookie("cookiePassword", "");
                cookieName.setMaxAge(0); // Immediately remove cookie
                cookiePassword.setMaxAge(0); // Immediately remove cookie
                response.addCookie(cookieName);
                response.addCookie(cookiePassword);
            }

            if (session.getAttribute("loginToCart") != null) {
                return "cart";
            } else {
                return "home";
            }

        } else {
            model.addAttribute("message", "Tài khoản không tồn tại");
        }
        return "login";
    }

    @GetMapping("/login")
    public String cookie(HttpSession session, HttpServletRequest request) {
        Cookie cookies[] = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("cookieName")) {
                    session.setAttribute("cookieName", cookie.getValue());
                }
                if (cookie.getName().equals("cookiePassword")) {
                    session.setAttribute("cookiePassword", cookie.getValue());
                }
            }
        }
        // Forward to login.jsp
       return "login";
    }

    @RequestMapping("/loginToCart")
    public String loginToCart(HttpServletRequest request) {
        request.getSession().setAttribute("loginToCart", true);
        return "login";
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("isLoggedIn");
        session.removeAttribute("user");
        session.removeAttribute("addListWithLoggedIn");
        session.removeAttribute("loginToCart");

        return "redirect:/home";
    }

    @RequestMapping("/add")
    public String regist(User user, Model model, HttpSession session) {
        try {
            user.setUserRole("user");
            userService.registerUser(user);
            session.setAttribute("user", user);
            // Gửi email xác nhận đăng ký
            String verificationCode = emailService.generateVerificationCode(); // Sinh mã xác nhận
            emailService.sendVerificationEmail(user, verificationCode); // Gửi email

            // Lưu mã xác nhận vào session
            session.setAttribute("verificationCode", verificationCode);
            return "validate"; // Chuyển hướng đến trang xác nhận
        } catch (CustomExceptions.EmailAlreadyExistsException e) {
            model.addAttribute("email_error_msg", e.getMessage());
            return "regist";
        } catch (CustomExceptions.UsernameAlreadyExistsException e) {
            model.addAttribute("username_error_msg", e.getMessage());
            return "regist";
        } catch (Exception e) {
            model.addAttribute("register_error_msg", "Đã xảy ra lỗi khi đăng ký");
            return "regist";
        }
    }

    // Phương thức xác nhận mã và hoàn thành đăng ký
    @RequestMapping("/verify")
    public String verifyRegistration(HttpSession session,
                                     Model model,
                                     @RequestParam("verificationCode") String verificationCode) {
        String storedVerificationCode = (String) session.getAttribute("verificationCode"); // Lấy mã đã lưu

        if (verificationCode.equals(storedVerificationCode)) {
            // Xác nhận thành công, hoàn tất đăng ký
            User user = (User) session.getAttribute("user");
            userService.saveUser(user);
            // Xóa mã xác nhận khỏi session hoặc đối tượng User
            session.removeAttribute("verificationCode");
            return "login"; // Hoặc trang chủ của ứng dụng
        } else {
            model.addAttribute("error_msg", "Mã xác nhận không chính xác");
            return "validate"; // Trở lại trang xác nhận
        }
    }

    @RequestMapping("/getCode")
    public String changePwd(HttpSession session,
                            Model model,
                            @RequestParam("email") String email) {
        try {
            // Kiểm tra email đã từng đăng ký chưa
            if (userService.findByEmail(email) == null) {
                throw new Exception();
            }
            // Gửi email xác nhận đăng ký
            String verificationCode = emailService.generateVerificationCode(); // Sinh mã xác nhận

            // Tạo tempUser để lưu trữ email
            User user = new User();
            user.setEmail(email);
            user.setUserName("Người dùng SAVINA");
            emailService.sendVerificationEmail(user, verificationCode); // Gửi email
            // Lưu mã xác nhận vào session
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("inputEmail", email);
        } catch (Exception e) {
            model.addAttribute("changePwd_error_msg", "Tài khoản email không tồn tại");
        }
        return "changePwd"; // Chuyển hướng đến trang xác nhận
    }

    @RequestMapping("/confirmCode")
    public String confirmCode(HttpSession session,
                              Model model,
                              @RequestParam("verificationCode") String verificationCode) {
        String storedVerificationCode = (String) session.getAttribute("verificationCode"); // Lấy mã đã lưu
        if (verificationCode.equals(storedVerificationCode)) {
            // Xác nhận thành công, đánh dấu là đã xác nhận
            session.setAttribute("isVerified", true);
            // Xóa mã xác nhận khỏi session hoặc đối tượng User
            session.removeAttribute("verificationCode");
            return "redirect:/confirmChangePwd";
        } else {
            model.addAttribute("error_msg", "Mã xác nhận không chính xác");
            return "changePwd"; // Trở lại trang xác nhận
        }
    }

    @RequestMapping("/confirmChangePwd")
    public String confirmChangePwd(HttpSession session, Model model) {
        Boolean isVerified = (Boolean) session.getAttribute("isVerified");
        if (isVerified != null && isVerified) {
            // Người dùng đã xác thực thành công
            return "confirmChangePwd"; // Trang đổi mật khẩu
        } else {
            // Người dùng chưa xác thực
            return "redirect:/home"; // Chuyển hướng đến trang xác nhận mã
        }
    }

    @RequestMapping("/changeAccount")
    public String changeAccount(User user, Model model, HttpSession session) {
        try {
            // Kiểm tra xem user mới có hợp lệ không
            userService.registerUser(user);
            // Đổi tên và mật khẩu
            // Lấy ra user ban đầu
            String inputEmail = (String) session.getAttribute("inputEmail");
            User originalUser = userService.findByEmail(inputEmail);
            // Đổi userName và password
            originalUser.setUserName(user.getUserName());
            originalUser.setPwd(user.getPwd());
            // save
            userService.updateUser(originalUser);
            return "login"; // Chuyển hướng đến trang đăng nhập
        } catch (CustomExceptions.UsernameAlreadyExistsException e) {
            model.addAttribute("error_msg", e.getMessage());
            return "confirmChangePwd";
        } catch (Exception e) {
            model.addAttribute("error_msg", "Đã xảy ra lỗi");
            return "confirmChangePwd";
        }
    }

}
