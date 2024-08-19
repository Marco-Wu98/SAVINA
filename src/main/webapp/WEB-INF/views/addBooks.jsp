<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AddBooks</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/admin/addBooks.css">

    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

<div class="main">
    <jsp:include page="header.jsp"/>

    <div class="addForm container-fluid">
        <form id="addBookForm" action="addBook" method="post" enctype="multipart/form-data">
            <h2>THÊM SÁCH</h2>

            <label>Tiêu đề:</label><br>
            <input type="text" name="title" required><br><br>

            <div class="sub-page-cover row justify-content-between">
                <div class="col-12 col-lg-6">
                    <label>Subcategory:</label><br>
                    <select name="subcategoryId" required>
                        <option value="1">Tiểu Thuyết</option>
                        <option value="2">Truyện Ngắn</option>
                        <option value="3">Cẩm Nang Làm Cha Mẹ</option>
                        <option value="4">Phương Pháp Giáo Dục Trẻ</option>
                        <option value="5">Manga-Comic</option>
                        <option value="6">Kiến Thức Bách Khoa</option>
                        <option value="7">Tiếng Anh</option>
                        <option value="8">Tiếng Nhật</option>
                    </select><br><br>
                </div>
                <div class="col-6 col-lg-3">
                    <label>Page Number:</label><br>
                    <input type="number" min="1" name="pageNo" required><br><br>
                </div>
                <div class="col-6 col-lg-3">
                    <label>Cover Type:</label><br>
                    <select name="coverType" required>
                        <option value="Bìa cứng">Bìa cứng</option>
                        <option value="Bìa mềm">Bìa mềm</option>
                    </select><br><br>
                </div>
            </div>

            <div class="price-discount row justify-content-between">
                <div class="col-6">
                    <label>Price:</label><br>
                    <input type="number" min="0" step="0.01" name="price" required><br><br>
                </div>
                <div class="col-6">
                    <label>Discount:</label><br>
                    <input type="number" min="0" step="0.01" name="discount"><br><br>
                </div>
            </div>

            <label>Tác giả:</label><br>
            <input type="text" name="author" required><br><br>

            <div class="publisher-publishYear row justify-content-between">
                <div class="col-6">
                    <label>NXB:</label><br>
                    <select name="publisher">
                        <option>NXB Dân Trí</option>
                        <option>NXB Hà Nội</option>
                        <option>NXB Hội Nhà Văn</option>
                        <option>NXB Kim Đồng</option>
                        <option>NXB Lao Động</option>
                        <option>NXB Đại Học Quốc Gia Tp.HCM</option>
                        <option>NXB Hồng Đức</option>
                        <option>NXB Phụ Nữ</option>
                        <option>NXB Thanh Niên</option>
                        <option>NXB Thế Giới</option>
                        <option>NXB Tổng Hợp Tp.HCM</option>
                        <option>NXB Trẻ</option>
                        <option>NXB Văn Học</option>
                    </select><br><br>
                </div>
                <div class="col-6">
                    <label>Năm phát hành:</label><br>
                    <input type="number" name="publishedYear" required><br><br>
                </div>
            </div>

            <label>Miêu tả:</label><br>
            <textarea name="description" required></textarea><br><br>

            <label>Ảnh bìa:</label>
            <input type="file" name="coverImage" required><br><br>

            <div class="sale-stock row justify-content-between">
                <div class="col-6">
                    <label>Số lượng bán:</label><br>
                    <input type="number" min="0" name="saleQuantity" required><br><br>
                </div>
                <div class="col-6">
                    <label>Tồn kho:</label><br>
                    <input type="number" min="0" name="stockQuantity" required><br><br>
                </div>
            </div>

            <input type="submit" value="LƯU SÁCH" id="submitBtn" disabled onclick="return confirmAdd()">
        </form>
        <jsp:include page="footer.jsp"/>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("addBookForm");
        const submitBtn = document.getElementById("submitBtn");

        form.addEventListener("input", function () {
            const isValid = form.checkValidity();
            submitBtn.disabled = !isValid;
        });
    });

    const confirmAdd = function () {
        return confirm("Bạn chắc chắn muốn thêm mới sản phẩm?");
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>

</html>

