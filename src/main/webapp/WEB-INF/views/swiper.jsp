<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/book/swiper.css">
    <script src="static/js/book/swiper.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

<!-- Swiper -->
<div class="swiper-container two">
    <div class="swiper-wrapper">
        <c:forEach items="${requestScope.books}" var="book">
            <div class="swiper-slide">
                <div class="book-item">
                    <div class="book-item-core">
                        <div class="book-head">
                            <a href="info/${book.id}" class="book-img">
                                <img src="getImage/${book.id}" alt="Book Cover">
                            </a>
                            <div class="sale-icon">
                                    ${String.format("%.0f", book.discount)}%
                            </div>
                        </div>
                        <div class="book-body">
                            <div class="book-title">
                                    ${book.title}
                            </div>
                            <div class="book-sale">
                                <c:set var="afterDiscount" value="${book.price * (1 - book.discount/100)}"/>
                                    ${String.format("%.3f", afterDiscount/1000)} đ
                            </div>
                            <div class="book-price">
                                    ${String.format("%.3f", book.price/1000)} đ
                            </div>
                            <div class="book-rating">
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-solid fa-star"></i>
                                <i class="fa-regular fa-star"></i>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </c:forEach>


    </div>
    <div class="swiper-pagination"></div>
</div>


<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<%--Swiper--%>

<%--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>--%>
<%--<script src="custom.js"></script>--%>
</body>

</html>
