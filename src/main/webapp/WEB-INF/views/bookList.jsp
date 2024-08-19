<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book-List</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/book/bookList.css">
    <script src="static/js/book/bookList.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>
<div class="main">
    <jsp:include page="header.jsp"/>
    <div class="container-fluid">
        <div class="main container">
            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a style="text-decoration: none; color: black" href="#">Trang Chủ</a>
                    </li>
                    <c:if test="${requestScope.category == false}">
                        <li class="breadcrumb-item active" aria-current="page">
                            <a style="text-decoration: none; color: black"
                               href="categoryList/${requestScope.currentSubcategory}">${requestScope.currentCategory}</a>
                        </li>
                    </c:if>
                    <c:if test="${requestScope.category == true}">
                        <li class="breadcrumb-item active" aria-current="page">
                            <span style="color: var(--primary-color)">${requestScope.currentCategory}</span>
                        </li>
                    </c:if>

                    <c:if test="${requestScope.category == false}">
                        <li class="breadcrumb-item "></li>
                        <li style="color: var(--primary-color)" class="active"
                            aria-current="page">${requestScope.currentSubcategory}</li>
                    </c:if>

                </ol>
            </nav>

            <div class="main-core row justify-content-between">
                <div class="side col-12 col-lg-3 gx-5">
                    <div class="side-core">

                        <%--thẻ lưu trữ currentSubcategory để lấy ra trong JS--%>
                        <span id="currentSubcategory" class="d-none">${requestScope.currentSubcategory}</span>

                        <%--Price Filter--%>
                        <div class="filter d-flex flex-column">
                            <span>Giá</span>
                            <div class="option">
                                <input type="checkbox" id="opt1" name="price" value="0-50000">
                                <label for="opt1">
                                    0đ - 50.000đ
                                </label>
                            </div>
                            <div class="option">
                                <input type="checkbox" id="opt2" name="price" value="50000-100000">
                                <label for="opt2">
                                    50.000đ - 100.000đ
                                </label>
                            </div>
                            <div class="option">
                                <input type="checkbox" id="opt3" name="price" value="100000-200000">
                                <label for="opt3">
                                    100.000đ - 200.000đ
                                </label>
                            </div>
                            <div class="option">
                                <input type="checkbox" id="opt4" name="price" value="200000-${Integer.MAX_VALUE}">
                                <label for="opt4">
                                    200.000đ - Trở lên
                                </label>
                            </div>
                        </div>
                        <%--Price Filter--%>

                        <%--Publisher Filter--%>

                        <div class="filter d-flex flex-column">
                            <span>Nhà Xuất Bản</span>
                            <div class="option">
                                <input type="checkbox" id="nxb1" name="publisher" value="Dân Trí">
                                <label for="nxb1">
                                    Dân Trí
                                </label>
                            </div>
                            <div class="option">
                                <input type="checkbox" id="nxb2" name="publisher" value="Hội Nhà Văn">
                                <label for="nxb2">
                                    Hội Nhà Văn
                                </label>
                            </div>
                            <div class="option">
                                <input type="checkbox" id="nxb3" name="publisher" value="Phụ Nữ Việt Nam">
                                <label for="nxb3">
                                    Phụ Nữ Việt Nam
                                </label>
                            </div>
                            <div class="option">
                                <input type="checkbox" id="nxb4" name="publisher" value="NXB Lao Động">
                                <label for="nxb4">
                                    NXB Lao Động
                                </label>
                            </div>
                        </div>
                        <%--Publisher Filter--%>

                        <button id="filter-button" class="btn">Lọc</button>
                    </div>
                </div>

                <%--    =================================================BooK List==============================================        --%>
                <div class="book-list col-12 col-lg-9">

                    <%--Sắp xếp--%>
                    <div class="arrange">
                        <span>Sắp xếp theo:</span>
                        <div class="dropdown">
                            <a id="dropdownMenuButton" class="btn btn-secondary " href="#" role="button"
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <c:if test="${empty requestScope.optionName}">Chọn một tùy chọn</c:if>
                                ${requestScope.optionName}
                                <span class="dropdown-toggle"></span>
                            </a>

                            <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <c:if test="${requestScope.category == false}">
                                    <li>
                                        <a class="dropdown-item"
                                           href="arrange-1/${requestScope.currentSubcategory}/price-up">Giá Thấp Đến
                                            Cao</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item"
                                           href="arrange-1/${requestScope.currentSubcategory}/price-down">Giá Cao Đến
                                            Thấp</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item"
                                           href="arrange-1/${requestScope.currentSubcategory}/discount;">Chiết Khấu</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item"
                                           href="arrange-1/${requestScope.currentSubcategory}/year">Nổi
                                            Bật Năm</a>
                                    </li>
                                </c:if>
                                <c:if test="${requestScope.category == true}">
                                    <li>
                                        <a class="dropdown-item"
                                           href="arrange-2/${requestScope.currentSubcategory}/price-up">Giá Thấp Đến
                                            Cao</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item"
                                           href="arrange-2/${requestScope.currentSubcategory}/price-down">Giá Cao Đến
                                            Thấp</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item"
                                           href="arrange-2/${requestScope.currentSubcategory}/discount;">Chiết Khấu</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item"
                                           href="arrange-2/${requestScope.currentSubcategory}/year">Nổi
                                            Bật Năm</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </div>
                    <div class="book-row row">
                        <c:if test="${not empty requestScope.books}">
                        <c:forEach items="${requestScope.books}" var="book">

                        <div class="col-md-3">

                            <!-- Nội dung của mỗi cuốn sách -->
                            <div class="book-item col-3">
                                <div class="book-item-core">
                                    <div class="book-head">
                                        <a href="info/${book.id}" class="book-img">
                                            <img src="getImage/${book.id}" alt="Book Cover"/>
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
                        <!-- Kiểm tra nếu là phần tử cuối cùng của hàng hoặc là phần tử cuối cùng của danh sách -->
                        <c:if test="${loop.index % 4 == 3 || loop.last}">
                    </div> <!-- Đóng row -->
                    <!-- Mở row mới nếu chưa phải là phần tử cuối cùng của danh sách -->
                    <c:if test="${!loop.last}">
                    <div class="book-row row">
                        </c:if>
                        </c:if>
                        </c:forEach>
                        <nav id="page-nav" aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item">

                                    <c:if test="${requestScope.category == false}">
                                        <c:if test="${requestScope.arrange != true}">
                                            <a class="page-link"
                                               href="bookList/${requestScope.currentSubcategory}?page=${(requestScope.currentPage - 1) < 0 ? requestScope.currentPage : (requestScope.currentPage - 1)}">
                                                <i class="fa-solid fa-caret-left"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${requestScope.arrange == true}">
                                            <a class="page-link"
                                               href="arrange-1/${requestScope.currentSubcategory}/${requestScope.option}?page=${(requestScope.currentPage - 1) < 0 ? requestScope.currentPage : (requestScope.currentPage - 1)}">
                                                <i class="fa-solid fa-caret-left"></i>
                                            </a>
                                        </c:if>
                                    </c:if>

                                    <c:if test="${requestScope.category == true}">
                                        <c:if test="${requestScope.arrange != true}">
                                            <a class="page-link"
                                               href="categoryList/${requestScope.currentSubcategory}?page=${(requestScope.currentPage - 1) < 0 ? requestScope.currentPage : (requestScope.currentPage - 1)}">
                                                <i class="fa-solid fa-caret-left"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${requestScope.arrange == true}">
                                            <a class="page-link"
                                               href="arrange-2/${requestScope.currentSubcategory}/${requestScope.option}?page=${(requestScope.currentPage - 1) < 0 ? requestScope.currentPage : (requestScope.currentPage - 1)}">
                                                <i class="fa-solid fa-caret-left"></i>
                                            </a>
                                        </c:if>
                                    </c:if>
                                </li>

                                <c:forEach var="i" begin="0" end="${requestScope.totalPages - 1}">
                                    <li class="page-item ${i == requestScope.currentPage ? "active" : ""}">
                                            <%--                                        XEM LAI CHO NAY             ==================================--%>
                                        <c:if test="${requestScope.category == false}">
                                            <c:if test="${requestScope.arrange != true}">
                                                <a class="page-link"
                                                   href="bookList/${requestScope.currentSubcategory}?page=${i}">${i+1}</a>
                                            </c:if>
                                            <c:if test="${requestScope.arrange == true}">
                                                <a class="page-link"
                                                   href="arrange-1/${requestScope.currentSubcategory}/${requestScope.option}?page=${i}">${i+1}</a>
                                            </c:if>
                                        </c:if>

                                        <c:if test="${requestScope.category == true}">
                                            <c:if test="${requestScope.arrange != true}">
                                                <a class="page-link"
                                                   href="categoryList/${requestScope.currentSubcategory}?page=${i}">${i+1}</a>
                                            </c:if>
                                            <c:if test="${requestScope.arrange == true}">
                                                <a class="page-link"
                                                   href="arrange-2/${requestScope.currentSubcategory}/${requestScope.option}?page=${i}">${i+1}</a>
                                            </c:if>
                                        </c:if>
                                            <%--                                        XEM LAI CHO NAY             ==================================--%>
                                    </li>
                                </c:forEach>

                                <li class="page-item">
                                    <c:if test="${requestScope.category == false}">
                                        <c:if test="${requestScope.arrange != true}">
                                            <a class="page-link"
                                               href="bookList/${requestScope.currentSubcategory}?page=${(requestScope.currentPage + 1) > (requestScope.totalPages - 1) ? (requestScope.totalPages - 1) : (requestScope.currentPage + 1)}">
                                                <i class="fa-solid fa-caret-right"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${requestScope.arrange == true}">
                                            <a class="page-link"
                                               href="arrange-1/${requestScope.currentSubcategory}/${requestScope.option}?page=${(requestScope.currentPage + 1) > (requestScope.totalPages - 1) ? (requestScope.totalPages - 1) : (requestScope.currentPage + 1)}">
                                                <i class="fa-solid fa-caret-right"></i>
                                            </a>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${requestScope.category == true}">
                                        <c:if test="${requestScope.arrange != true}">
                                            <a class="page-link"
                                               href="categoryList/${requestScope.currentSubcategory}?page=${(requestScope.currentPage + 1) > (requestScope.totalPages - 1) ? (requestScope.totalPages - 1) : (requestScope.currentPage + 1)}">
                                                <i class="fa-solid fa-caret-right"></i>
                                            </a>
                                        </c:if>
                                        <c:if test="${requestScope.arrange == true}">
                                            <a class="page-link"
                                               href="arrange-2/${requestScope.currentSubcategory}/${requestScope.option}?page=${(requestScope.currentPage + 1) > (requestScope.totalPages - 1) ? (requestScope.totalPages - 1) : (requestScope.currentPage + 1)}">
                                                <i class="fa-solid fa-caret-right"></i>
                                            </a>
                                        </c:if>
                                    </c:if>
                                </li>
                            </ul>
                        </nav>
                        </c:if>

                        <c:if test="${empty requestScope.books}">
                            <div class="not-found text-center">
                                <i class="fa-solid fa-circle-exclamation"></i>
                                <h5 class="message">Không tìm thấy kết quả</h5>
                            </div>
                        </c:if>
                    </div>


                </div>


                <%--    =================================================TEST==============================================        --%>

            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </div>

</div>


<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>

</html>
