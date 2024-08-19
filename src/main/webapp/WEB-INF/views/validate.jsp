<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Validate</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/user/validate.css">
    <script src="static/js/user/login.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link rel="stylesheet" href="static/css/bootstrap/bootstrap.css">
</head>

<body>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<div class="main">
    <form action="${root}/verify" method="post">
        <div class="form-header">
            <h1 class="form-title__1">SAVINA</h1>
            <h6 class="message">${requestScope.error_msg}</h6>
        </div>

        <div class="form-body">
            <div class="form-item">
                <input type="text" name="verificationCode" placeholder="Nhập mã xác thực" autocomplete="off">
            </div>
            <div class="form-item">
                <input type="submit" value="Xác thực"/>
            </div>
        </div>

        <div class="form-footer">
            <div><a href="${root}/regist">Đăng ký</a></div>
        </div>
    </form>
</div>


<!--BOOTSTRAP -->
<script src="static/js/bootstrap/bootstrap.bundle.js"></script>
</body>

</html>
