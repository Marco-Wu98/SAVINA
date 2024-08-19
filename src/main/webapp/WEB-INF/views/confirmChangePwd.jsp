<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConfirmChangePassword</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/user/confirmChangePwd.css">
    <script src="static/js/user/login.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link rel="stylesheet" href="static/css/bootstrap/bootstrap.css">
</head>

<body>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<div class="main">
    <form action="${root}/changeAccount" method="post">
        <div class="form-header">
            <h1 class="form-title__1">SAVINA</h1>
            <h6 class="message">${requestScope.error_msg}</h6>
        </div>

        <div class="form-body">
            <div class="form-item">
                <input type="text" name="userName" placeholder="Tên đăng nhập mới" autocomplete="off">
            </div>
            <div class="form-item">
                <input id="password" type="password" name="pwd" placeholder="Mật khẩu mới" autocomplete="off">
            </div>
            <div id="password-error" class="input-error"></div> <!-- Thông báo lỗi password -->
            <div class="form-item">
                <input id="submit-btn" type="submit" value="Đổi tài khoản"/>
            </div>
        </div>

        <div class="form-footer">
            <div><a href="${root}/login">Đăng nhập</a></div>
        </div>
    </form>
</div>


<!--BOOTSTRAP -->
<script>


    const passwordInput = document.getElementById("password");
    const submitButton = document.getElementById("submit-btn");


    const passwordError = document.getElementById("password-error");

    function validatePassword(password) {
        const re = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$/;
        return re.test(password);
    }


    function checkPasswordValidity() {
        const passwordValid = validatePassword(passwordInput.value);
        passwordError.textContent = passwordValid ? "" : "Mật khẩu phải chứa ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường và số";
        updateSubmitButtonState();
    }

    function updateSubmitButtonState() {
        const passwordValid = validatePassword(passwordInput.value);

        if (passwordValid) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }

    // Sử dụng sự kiện keyup để kiểm tra khi click ra ngoài
    passwordInput.addEventListener("keyup", checkPasswordValidity);

    // Initially disable the submit button
    submitButton.disabled = true;


</script>
<script src="static/js/bootstrap/bootstrap.bundle.js"></script>
</body>

</html>
