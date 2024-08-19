<%--
  Created by IntelliJ IDEA.
  User: Acer
  Date: 02-Jun-24
  Time: 05:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <base href="http://localhost:8080/savina/"/>

</head>
<body>
<div style="text-align: center">
    <img src="static/img/error.png"/>
    <h1>Thật đáng tiếc! Điều gì đó không đúng đã xảy ra</h1>
    <h2>Bạn vui lòng thử lại sau</h2>
    <h2>${requestScope.error}</h2>
</div>
</body>
</html>
