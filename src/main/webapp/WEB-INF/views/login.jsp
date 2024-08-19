<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/user/login.css">
    <script src="static/js/user/login.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link rel="stylesheet" href="static/css/bootstrap/bootstrap.css">
</head>

<body>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<div class="main">
    <form action="${root}/authentic" method="post">
        <div class="form-header">
            <h1 class="form-title__1">SAVINA</h1>
            <h6 class="message">${requestScope.message}</h6>
        </div>

        <div class="form-body">
            <div class="form-item">
                <input type="text" name="userName" id="username" placeholder="Tên đăng nhập" autocomplete="off" value="${sessionScope.cookieName}">
            </div>
            <div class="form-item">
                <input type="password" name="pwd" id="password" placeholder="Mật khẩu" autocomplete="off" value="${sessionScope.cookiePassword}">
                <label for="chk" id="close-icon"><i class="fa-regular fa-eye-slash"></i></label>
                <label for="chk" class="d-none" id="open-icon"><i class="fa-regular fa-eye"></i></label>
                <input type="checkbox" id="chk" class="d-none">
            </div>
            <div class="form-item">
                <input type="submit" value="Đăng nhập"/>
            </div>
        </div>

        <div class="form-footer">
            <div><a href="${root}/changePwd">Quên mật khẩu?</a></div>
            <div>
                <input type="checkbox" id="rememberMe" name="rememberMe">
                <label for="rememberMe">Nhớ đăng nhập</label>
            </div>
            <div><a href="${root}/regist">Đăng ký</a></div>
        </div>
    </form>
</div>


<!--BOOTSTRAP -->
<script src="static/js/bootstrap/bootstrap.bundle.js"></script>
</body>

</html>
