<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Regist</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/user/regist.css">
    <%--    <script src="static/js/user/regist.js"></script>--%>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link rel="stylesheet" href="static/css/bootstrap/bootstrap.css">
</head>

<body>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<div class="main">
    <form action="${root}/add" method="post">
        <div class="form-header">
            <h1 class="form-title__1">SAVINA</h1>
            <h3 class="form-title__2">---- Tạo tài khoản cho riêng mình ----</h3>
        </div>

        <div class="form-body">
            <div class="form-item">
                <input type="email" name="email" id="email" placeholder="Email" autocomplete="off">
            </div>
            <div id="email-error" class="input-error"></div> <!-- Thông báo lỗi email -->
            <div class="input-error">${requestScope.email_error_msg}</div>
            <div class="input-error">${requestScope.register_error_msg}</div>
            <div class="form-item">
                <input type="text" name="userName" id="username" placeholder="Tên đăng nhập" autocomplete="off">
            </div>
            <div class="input-error">${requestScope.username_error_msg}</div>
            <div class="form-item">
                <input type="password" name="pwd" id="password" placeholder="Mật khẩu" autocomplete="off">
            </div>
            <div id="password-error" class="input-error"></div> <!-- Thông báo lỗi password -->

            <div class="form-item">
                <input type="password" name="confirm" id="confirm" placeholder="Xác nhận mật khẩu" autocomplete="off">
            </div>
            <div id="confirm-error" class="input-error"></div> <!-- Thông báo lỗi xác nhận password -->

            <div class="form-item">
                <input disabled="disabled" type="submit" id="submit-btn" value="Đăng ký"/>
            </div>
        </div>

        <div class="form-footer">
            <div><a href="${root}/login">Đăng nhập</a></div>
        </div>
    </form>
</div>


<!--BOOTSTRAP -->
<script>

    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const confirmInput = document.getElementById("confirm");
    const submitButton = document.getElementById("submit-btn");

    const emailError = document.getElementById("email-error");
    const passwordError = document.getElementById("password-error");
    const confirmError = document.getElementById("confirm-error");

    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(String(email).toLowerCase());
    }

    function validatePassword(password) {
        const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        return re.test(password);
    }

    function validateConfirmPassword() {
        return passwordInput.value === confirmInput.value;
    }

    function checkEmailValidity() {
        const emailValid = validateEmail(emailInput.value);
        emailError.textContent = emailValid ? "" : "Email không hợp lệ!";
        updateSubmitButtonState();
    }

    function checkPasswordValidity() {
        const passwordValid = validatePassword(passwordInput.value);
        passwordError.textContent = passwordValid ? "" : "Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số";
        updateSubmitButtonState();
    }

    function checkConfirmPasswordValidity() {
        const passwordsMatch = validateConfirmPassword();
        confirmError.textContent = passwordsMatch ? "" : "Xác nhận mật khẩu không khớp";
        updateSubmitButtonState();
    }

    function updateSubmitButtonState() {
        const emailValid = validateEmail(emailInput.value);
        const passwordValid = validatePassword(passwordInput.value);
        const passwordsMatch = validateConfirmPassword();

        if (emailValid && passwordValid && passwordsMatch) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }

    // Sử dụng sự kiện keyup để kiểm tra khi click ra ngoài
    emailInput.addEventListener("keyup", checkEmailValidity);
    passwordInput.addEventListener("keyup", checkPasswordValidity);
    confirmInput.addEventListener("keyup", checkConfirmPasswordValidity);

    // Initially disable the submit button
    submitButton.disabled = true;


</script>
<script src="static/js/bootstrap/bootstrap.bundle.js"></script>
</body>

</html>
