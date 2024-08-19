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
    <link rel="stylesheet" href="static/css/home/home.css">
    <%--    <script src="static/js/user/login.js"></script>--%>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

<div class="main">
    <jsp:include page="header.jsp"/>
    <div class="body">
        <!-- Start Sale -->
        <div class="sale container">
            <div class="sale-up row">

                <!-- Start Carousel -->
                <div class="sale-up__carousel col-md-12 col-lg-8">
                    <div id="carousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                        <div class="carousel-indicators">
                            <button type="button" data-bs-target="#carousel" data-bs-slide-to="0" class="active"
                                    aria-current="true" aria-label="Slide 1"></button>
                            <button type="button" data-bs-target="#carousel" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carousel" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                            <button type="button" data-bs-target="#carousel" data-bs-slide-to="3"
                                    aria-label="Slide 4"></button>
                        </div>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <a href="#"> <img src="static/img/cr1.jpg" class="d-block w-100" alt="sale1"></a>
                            </div>
                            <div class="carousel-item">
                                <a href="#"> <img src="static/img/cr2.jpg" class="d-block w-100" alt="sale2"></a>
                            </div>
                            <div class="carousel-item">
                                <a href="#"> <img src="static/img/cr3.jpg" class="d-block w-100" alt="sale3"></a>
                            </div>
                            <div class="carousel-item">
                                <a href="#"> <img src="static/img/cr4.jpg" class="d-block w-100" alt="sale4"></a>
                            </div>
                        </div>

                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carousel" data-bs-slide="prev">
                        <i class="fa-solid fa-circle-chevron-left" aria-hidden="true"></i>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carousel" data-bs-slide="next">
                        <i class="fa-solid fa-circle-chevron-right" aria-hidden="true"></i>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
                <!-- End Carousel -->

                <!-- Start Sale Side -->
                <div class="sale-up__side col-lg-4 d-none d-lg-flex flex-column justify-content-between">
                    <a href="#"><img src="static/img/side1.jpg" alt="side1" class="side1"></a>
                    <a href="#"><img src="static/img/side2.jpg" alt="side2" class="side2"></a>
                </div>
                <!-- End Sale Side -->

            </div>

            <div class="sale-down row d-flex">

                <div class="item col-6 col-md-3">
                    <a href="#"><img src="static/img/sd1.jpg" class="img-fluid" alt="sd1"/></a>
                </div>
                <div class="item col-6 col-md-3">
                    <a href="#"><img src="static/img/sd2.jpg" class="img-fluid" alt="sd2"/></a>
                </div>
                <div class="item col-6 col-md-3">
                    <a href="#"><img src="static/img/sd3.png" class="img-fluid" alt="sd3"/></a>
                </div>
                <div class="item col-6 col-md-3">
                    <a href="#"><img src="static/img/sd4.png" class="img-fluid" alt="sd4"/></a>
                </div>
            </div>
        </div>
        <!-- End Sale -->
        <jsp:include page="footer.jsp"/>
    </div>

</div>


<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>

</html>
