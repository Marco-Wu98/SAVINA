<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book-Info</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/book/bookInfo.css">
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

</head>

<body>
<div class="main">
    <jsp:include page="header.jsp"/>
    <c:set var="book" value="${requestScope.book}"/>
    <div class="container-fluid">
        <div class="main-1 container">
            <div class="book-info row">
                <div class="book-img col-12 col-lg-5">
                    <div class="image">
                        <img src="getImage/${book.id}" alt="">
                    </div>
                    <%--===========================================================================--%>
                    <%--Tạo 1 thẻ lưu trữ bookId--%>
                    <span id="bookId" class="d-none">${book.id}</span>
                    <form method="post" class="buttons d-flex justify-content-evenly">
                        <c:if test="${!sessionScope.user.userRole.equalsIgnoreCase('admin')}">
                            <button type="button" class="btn btn-outline" id="addBtn">
                                <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ hàng
                            </button>
                        </c:if>
                        <c:if test="${sessionScope.user.userRole.equalsIgnoreCase('admin')}">
                            <button type="button" class="btn btn-outline" id="deleteBtn"
                                    onclick="return confirmDelete();">
                                <i class="fa-regular fa-trash-can"></i> Xóa sản phẩm
                            </button>
                        </c:if>
                        <c:if test="${book.stockQuantity > 0 && !sessionScope.user.userRole.equalsIgnoreCase('admin')}">
                            <button type="button" class="btn" id="buyBtn">Mua ngay</button>
                        </c:if>
                        <c:if test="${book.stockQuantity == 0 && !sessionScope.user.userRole.equalsIgnoreCase('admin')}">
                            <button type="button" class="btn" id="buyBtn" disabled="disabled">Hết hàng</button>
                        </c:if>
                        <c:if test="${sessionScope.user.userRole.equalsIgnoreCase('admin')}">
                            <button type="button" class="btn" id="editBtn">
                                <i class="fa-solid fa-eraser"></i> Sửa sản phẩm
                            </button>
                        </c:if>
                    </form>
                </div>
                <div class="detail-wrapper col-12 col-lg-7">
                    <div class="detail-head">
                        <span id="stockQuantity" class="d-none">${book.stockQuantity}</span>
                        <div class="title">
                            ${book.title}
                        </div>
                        <div class="detail-main">
                            <div class="left">
                                <p>Nhà cung cấp:<span> FPT</span></p>
                                <p>Nhà xuất bản: <span> ${book.publisher}</span></p>
                            </div>
                            <div class="right">
                                <p>Tác giả: <span>${book.author}</span></p>
                                <p>Hình thức bìa: <span> ${book.coverType}</span></p>
                            </div>

                        </div>
                        <div class="glitch-wrapper">
                            <div class="glitch" data-text="FLASH SALE">FLASH SALE</div>
                        </div>


                    </div>
                    <div class="detail-body">
                        <div class="price">
                            <span class="sale">
                                 <c:set var="afterDiscount" value="${book.price * (1 - book.discount/100)}"/>
                                                ${String.format("%.3f", afterDiscount/1000)} đ
                            </span>
                            <span class="origin">
                                ${String.format("%.3f", book.price/1000)}
                            </span>
                            <span class="discount">
                                -${String.format("%.0f", book.discount)}%
                            </span>
                        </div>

                        <div class="delivery">
                            <div class="time">
                                <span>Thời gian giao hàng</span>
                                <span>Giao hàng đến</span>
                                <a href="javascript:;">Thay đổi</a>
                            </div>
                            <div class="policy">
                                <span>Chính sách đổi trả</span>
                                <span>Đổi trả sản phẩm trong 30 ngày</span>
                                <a href="javascript:;">Xem thêm</a>
                            </div>
                        </div>

                        <div class="quantity">
                            <span>Số lượng</span>
                            <div class="quantity-control">
                                <button class="decrement">-</button>
                                <span class="quantity-input">1</span>
                                <button class="increment">+</button>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="suggest container">
            <h5>SAVINA GIỚI THIỆU</h5>
            <jsp:include page="swiper.jsp"/>
        </div>

        <div class="main-2 container">
            <div class="title">Thông tin sản phẩm</div>
            <div class="description row">
                <div class="left col-6 col-lg-2">
                    <div class="code">Mã hàng</div>
                    <div class="author">Tác giả</div>
                    <div class="publisher">NXB</div>
                    <div class="publish-year">Năm XB</div>
                    <div class="pageNo">Số trang</div>
                    <div class="pageType">Hình thức</div>
                </div>
                <div class="right col-6 col-lg-10">
                    <div class="code">${book.id}</div>
                    <div class="author">${book.author}</div>
                    <div class="publisher">${book.publisher}</div>
                    <div class="publish-year">${book.publishedYear}</div>
                    <div class="pageNo">${book.pageNo}</div>
                    <div class="pageType">${book.coverType}</div>
                </div>
            </div>
            <hr>
            <div class="summarize" id="description">
                ${book.description}
            </div>
        </div>
        <jsp:include page="footer.jsp"/>
    </div>


</div>
<!-- Modal -->
<div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <i class="fa-solid fa-check"></i>
                Sản phẩm đã được thêm vào giỏ hàng
            </div>
        </div>
    </div>

</div>

<!-- Bootstrap JS and dependencies -->
<%--<script src="static/js/book/bookInfo.js"></script>--%>
<script>
    // Xử lý sự kiện khi admin ấn "Xóa sản phẩm"
    const deleteBtn = document.getElementById("deleteBtn");
    deleteBtn.addEventListener('click', function () {
        const bookId = document.getElementById("bookId").innerText;
        // Tạo URL dựa trên bookID và quantity
        var deleteBookUrl = 'delete/' + bookId;
        window.location.href = deleteBookUrl;
    })
    // Xử lý sự kiện khi admin ấn "Sửa sản phẩm"
    const editBtn = document.getElementById("editBtn");
    editBtn.addEventListener('click', function () {
        const bookId = document.getElementById("bookId").innerText;
        // Tạo URL dựa trên bookID và quantity
        var deleteBookUrl = 'edit/' + bookId;
        window.location.href = deleteBookUrl;
    })

    const confirmDelete = function () {
        return confirm("Bạn có chắc chắn muốn xóa?")
    }
    // xử lý sự kiện khi ấn vào nút search >> chuyển hướng đến /search/{keyword}
    const searchBar = document.querySelector('#search-bar');
    const searchBtn = document.querySelector('#search-btn');
    searchBtn.addEventListener('click', () => {
        let keyword = searchBar.value;
        if (keyword === '') {
            keyword = '_';
        }
        const url = 'search/' + keyword;
        window.location.href = url;
    })
</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>

<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="static/js/book/bookInfo.js"></script>

</body>

</html>
