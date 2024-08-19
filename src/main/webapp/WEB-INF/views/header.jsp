<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/home/header.css">
    <script src="static/js/home/header.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<c:if test="${!sessionScope.isLoggedIn}">
    <c:set var="addList" value="${sessionScope.addListNotLoggedIn}"/>
</c:if>
<c:if test="${sessionScope.isLoggedIn}">
    <c:set var="addList" value="${sessionScope.addListWithLoggedIn}"/>
</c:if>
<header class="header">
    <div class="header__up">
        <img src="static/img/header-bg.png"></img>
    </div>
    <div class="container header__down">
        <div class="logo">
            <a href="#"><img src="static/img/brand.png" alt="Logo"></a>
        </div>
        <div class="_navbar">
            <div class="_nav">
                <div class="menu d-none d-lg-flex" id="headerMenu">
                    <i class="fa-solid fa-list"></i>
                    <i class="fa-solid fa-chevron-down"></i>
                </div>

                <div type="button" class="menu-sm d-flex d-lg-none" data-bs-toggle="offcanvas"
                     data-bs-target="#staticBackdrop" aria-controls="staticBackdrop">
                    <i class="fa-solid fa-list"></i>
                </div>


                <%--Start Offcanvas--%>
                <div class="offcanvas offcanvas-start" data-bs-backdrop="static" tabindex="-1" id="staticBackdrop"
                     aria-labelledby="staticBackdropLabel">
                    <div class="offcanvas-header">
                        <div type="button" data-bs-dismiss="offcanvas" aria-label="Close"><i
                                class="fa-solid fa-angles-left"></i></div>
                        <span class="offcanvas-title" id="staticBackdropLabel">Danh Mục Sản Phẩm</span>
                    </div>
                    <div class="offcanvas-body">

                        <%--Start Accordion--%>
                        <div class="accordion accordion-flush" id="accordionFlushExample">
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#flush-collapse1" aria-expanded="false"
                                            aria-controls="flush-collapse1">
                                        SÁCH THIẾU NHI
                                    </button>
                                </h2>
                                <div id="flush-collapse1" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionFlushExample">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="bookList/Manga-Comic">Manga - Comic</a></li>
                                        <li class="list-group-item"><a href="bookList/kiến_thức_bách_khoa">Kiến Thức Bách Khoa</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Sách Tranh Kỹ Năng Sống</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Vừa Học Vừa Chơi</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Xem tất cả</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#flush-collapse2" aria-expanded="false"
                                            aria-controls="flush-collapse2">
                                        TIỂU SỬ - HỒI KÝ
                                    </button>
                                </h2>
                                <div id="flush-collapse2" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionFlushExample">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="javascript:;">Câu Chuyện Cuộc Đời</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Chính Trị</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Kinh Tế</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Nghệ Thuật - Giải Trí</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Xem tất cả</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#flush-collapse3" aria-expanded="false"
                                            aria-controls="flush-collapse3">
                                        GIÁO KHOA - THAM KHẢO
                                    </button>
                                </h2>
                                <div id="flush-collapse3" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionFlushExample">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="javascript:;">Sách Giáo Khoa</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Sách Tham Khảo</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Luyện Thi THPT Quốc Gia</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Mẫu Giáo</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Xem tất cả</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#flush-collapse4" aria-expanded="false"
                                            aria-controls="flush-collapse4">
                                        SÁCH HỌC NGOẠI NGỮ
                                    </button>
                                </h2>
                                <div id="flush-collapse4" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionFlushExample">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="bookList/tiếng_anh">Tiếng Anh</a></li>
                                        <li class="list-group-item"><a href="bookList/tiếng_anh">Tiếng Nhật</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Tiếng Hoa</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Tiếng Hàn</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Xem tất cả</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#flush-collapse5" aria-expanded="false"
                                            aria-controls="flush-collapse5">
                                        VĂN HỌC
                                    </button>
                                </h2>
                                <div id="flush-collapse5" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionFlushExample">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="bookList/tiểu_thuyết">Tiểu Thuyết</a></li>
                                        <li class="list-group-item"><a href="bookList/truyện_ngắn">Truyện ngắn - Tản Văn</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Light Novel</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Ngôn Tình</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Xem tất cả</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#flush-collapse6" aria-expanded="false"
                                            aria-controls="flush-collapse6">
                                        KINH TẾ
                                    </button>
                                </h2>
                                <div id="flush-collapse6" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionFlushExample">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="javascript:;">Nhân Vật - Bài Học Kinh Doanh</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Quản Trị Lãnh Đạo</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Marketing - Bán Hàng</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Phân Tích Kinh Tế</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Xem tất cả</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#flush-collapse7" aria-expanded="false"
                                            aria-controls="flush-collapse7">
                                        TÂM LÝ - KỸ NĂNG SỐNG
                                    </button>
                                </h2>
                                <div id="flush-collapse7" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionFlushExample">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="javascript:;">Kỹ Năng Sống</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Rèn Luyện Nhân Cách</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Tâm Lý</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Sách Cho Tuổi Mới Lớn</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Xem tất cả</a></li>
                                    </ul>
                                </div>
                            </div>
                            <div class="accordion-item">
                                <h2 class="accordion-header">
                                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#flush-collapse8" aria-expanded="false"
                                            aria-controls="flush-collapse8">
                                        NUÔI DẠY CON
                                    </button>
                                </h2>
                                <div id="flush-collapse8" class="accordion-collapse collapse"
                                     data-bs-parent="#accordionFlushExample">
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item"><a href="bookList/cẩm_nang_làm_cha_mẹ">Cẩm Nang Làm Cha Mẹ</a></li>
                                        <li class="list-group-item"><a href="bookList/phương_pháp_giáo_dục_trẻ">Phương Pháp Giáo Dục Trẻ</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Phát Triển Trí Tuệ Cho Trẻ</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Phát Triển Kỹ Năng Cho Trẻ</a></li>
                                        <li class="list-group-item"><a href="javascript:;">Xem tất cả</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <%--End Accordion--%>
                    </div>


                </div>
                <%--End Offcanvas--%>

                <div class="search">
                    <input id="search-bar" type="text" placeholder="Nhập sách mà bạn muốn tìm">
                    <button id="search-btn" class="btn"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
            </div>
            <div class="items">
                <div class="item info">
                    <i class="fa-regular fa-bell"></i>
                    <span>Thông báo</span>
                </div>
                <a href="cart" id="cart" class="item cart text-decoration-none">
                    <i class="fa-solid fa-cart-plus"></i>
                    <span>Giỏ hàng</span>
                    <c:if test="${not empty addList}">
                        <span class="badge rounded-pill bg-danger">${addList.size()}</span>
                    </c:if>
                </a>
                <div class="item account">
                    <c:if test="${!sessionScope.isLoggedIn}">
                        <i class="acc_logOut fa-regular fa-user"></i>
                    </c:if>
                    <c:if test="${sessionScope.isLoggedIn}">
                        <i class="acc_logIn fa-regular fa-user"></i>
                    </c:if>
                    <span>Tài khoản</span>
                    <c:if test="${!sessionScope.isLoggedIn}">
                        <div class="account__detail">
                            <a href="login" type="button" class="btn btn-sm"> Đăng nhập</a>
                            <a href="regist" type="button" class="btn btn-outline btn-sm"> Đăng ký</a>
                        </div>
                    </c:if>
                    <c:if test="${sessionScope.isLoggedIn}">
                        <div class="account__detail2">
                            <div class="list-group">
                                <button type="button" class="list-group-item list-group-item-action active"
                                        aria-current="true">
                                    <span> Xin chào: </span>
                                    <span>
                                            ${sessionScope.user.userName}
                                    </span>
                                </button>
                                <c:if test="${sessionScope.user.userRole.equalsIgnoreCase('user')}">
                                    <a href="orders" type="button" class="list-group-item list-group-item-action">
                                        <i class="fa-solid fa-clipboard-check"></i>
                                        <span>Đơn hàng của tôi</span>

                                    </a>
                                </c:if>
                                <c:if test="${sessionScope.user.userRole.equalsIgnoreCase('admin')}">
                                    <a href="orderManage" type="button" class="list-group-item list-group-item-action">
                                        <i class="fa-solid fa-list-check"></i>
                                        <span>Quản lý đơn hàng</span>
                                    </a>
                                </c:if>
                                <c:if test="${sessionScope.user.userRole.equalsIgnoreCase('user')}">
                                    <a href="javascript:;" type="button" class="list-group-item list-group-item-action">
                                        <i class="fa-solid fa-heart"></i>
                                        <span>Sản phẩm yêu thích</span>
                                    </a>
                                </c:if>
                                <c:if test="${sessionScope.user.userRole.equalsIgnoreCase('admin')}">
                                    <a href="addBooks" type="button" class="list-group-item list-group-item-action">
                                        <i class="fa-solid fa-plus"></i>
                                        <span>Thêm sản phẩm mới</span>
                                    </a>
                                </c:if>
                               <c:if test="${sessionScope.user.userRole.equalsIgnoreCase('user')}">
                                   <a href="javascript:;" type="button" class="list-group-item list-group-item-action">
                                       <i class="fa-solid fa-ticket"></i>
                                       <span>Wallet Voucher</span>
                                   </a>
                               </c:if>
                                <c:if test="${sessionScope.user.userRole.equalsIgnoreCase('admin')}">
                                    <a href="adminDashboard" type="button" class="list-group-item list-group-item-action">
                                        <i class="fa-solid fa-chart-simple"></i>
                                        <span>Thống kê</span>
                                    </a>
                                </c:if>
                                <a href="logout" type="button" class="list-group-item list-group-item-action">
                                    <i class="fa-solid fa-right-from-bracket"></i>
                                    <span>Thoát tài khoản</span>
                                </a>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Start Menu Detal -->
        <div class="menu__detail container">
            <div class="items row">
                <div class="item col-3">
                    <span>VĂN HỌC</span>
                    <a href="bookList/tiểu_thuyết">Tiểu Thuyết</a>
                    <a href="bookList/truyện_ngắn">Truyện ngắn - Tản Văn</a>
                    <a href="javascript:;">Light Novel</a>
                    <a href="javascript:;">Ngôn Tình</a>
                    <a href="javascript:;">Xem tất cả</a>
                </div>
                <div class="item col-3">
                    <span>KINH TẾ</span>
                    <a href="javascript:;">Nhân Vật - Bài Học Kinh Doanh</a>
                    <a href="javascript:;">Quản Trị Lãnh Đạo</a>
                    <a href="javascript:;">Marketing - Bán Hàng</a>
                    <a href="javascript:;">Phân Tích Kinh Tế</a>
                    <a href="javascript:;">Xem tất cả</a>
                </div>
                <div class="item col-3">
                    <span>TÂM LÝ - KỸ NĂNG SỐNG</span>
                    <a href="javascript:;">Kỹ Năng Sống</a>
                    <a href="javascript:;">Rèn Luyện Nhân Cách</a>
                    <a href="javascript:;">Tâm Lý</a>
                    <a href="javascript:;">Sách Cho Tuổi Mới Lớn</a>
                    <a href="javascript:;">Xem tất cả</a>
                </div>
                <div class="item col-3">
                    <span>NUÔI DẠY CON</span>
                    <a href="bookList/cẩm_nang_làm_cha_mẹ">Cẩm Nang Làm Cha Mẹ</a>
                    <a href="bookList/phương_pháp_giáo_dục_trẻ">Phương Pháp Giáo Dục Trẻ</a>
                    <a href="javascript:;">Phát Triển Trí Tuệ Cho Trẻ</a>
                    <a href="javascript:;">Phát Triển Kỹ Năng Cho Trẻ</a>
                    <a href="javascript:;">Xem tất cả</a>
                </div>
            </div>

            <div class="items row">
                <div class="item col-3">
                    <span>SÁCH THIẾU NHI</span>
                    <a href="bookList/Manga-Comic">Manga - Comic</a>
                    <a href="bookList/kiến_thức_bách_khoa">Kiến Thức Bách Khoa</a>
                    <a href="javascript:;">Sách Tranh Kỹ Năng Sống</a>
                    <a href="javascript:;">Vừa Học Vừa Chơi</a>
                    <a href="javascript:;">Xem tất cả</a>
                </div>
                <div class="item col-3">
                    <span>TIỂU SỬ - HỒI KÝ</span>
                    <a href="javascript:;">Câu Chuyện Cuộc Đời</a>
                    <a href="javascript:;">Chính Trị</a>
                    <a href="javascript:;">Kinh Tế</a>
                    <a href="javascript:;">Nghệ Thuật - Giải Trí</a>
                    <a href="javascript:;">Xem tất cả</a>
                </div>
                <div class="item col-3">
                    <span>GIÁO KHOA - THAM KHẢO</span>
                    <a href="javascript:;">Sách Giáo Khoa</a>
                    <a href="javascript:;">Sách Tham Khảo</a>
                    <a href="javascript:;">Luyện Thi THPT Quốc Gia</a>
                    <a href="javascript:;">Mẫu Giáo</a>
                    <a href="javascript:;">Xem tất cả</a>
                </div>
                <div class="item col-3">
                    <span>SÁCH HỌC NGOẠI NGỮ</span>
                    <a href="bookList/tiếng_anh">Tiếng Anh</a>
                    <a href="bookList/tiếng_nhật">Tiếng Nhật</a>
                    <a href="javascript:;">Tiếng Hoa</a>
                    <a href="javascript:;">Tiếng Hàn</a>
                    <a href="javascript:;">Xem tất cả</a>
                </div>
            </div>
        </div>
        <!-- End Menu Detal -->

    </div>

</header>
</body>
</html>

