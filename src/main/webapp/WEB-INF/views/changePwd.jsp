<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ChangePassword</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/user/changePwd.css">
    <script src="static/js/user/login.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link rel="stylesheet" href="static/css/bootstrap/bootstrap.css">
</head>

<body>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<div class="main">
    <div class="form">
        <div class="form-header">
            <h1 class="form-title__1">SAVINA</h1>
            <h6 class="message">${requestScope.changePwd_error_msg}</h6>
        </div>
        <form action="${root}/getCode" method="post">
            <div class="form-body">
                <div class="form-item">
                    <input type="email" name="email" placeholder="Nhập email bạn dùng để đăng ký" autocomplete="off"
                           value="${sessionScope.inputEmail}">
                </div>
                <div class="form-item">
                    <input type="submit" value="Gửi mã xác thực"/>
                </div>
            </div>
        </form>
        <form action="${root}/confirmCode" method="post">
            <div class="form-body">
                <div class="form-item">
                    <input type="text" name="verificationCode" placeholder="Nhập mã xác thực được gửi đến email"
                           autocomplete="off">
                </div>
                <div class="form-item">
                    <input type="submit" value="Xác thực"/>
                </div>
            </div>
        </form>
        <div class="form-footer">
            <div><a href="${root}/regist">Đăng ký</a></div>
        </div>
    </div>

</div>


<!--BOOTSTRAP -->
<script src="static/js/bootstrap/bootstrap.bundle.js"></script>
</body>

</html>
