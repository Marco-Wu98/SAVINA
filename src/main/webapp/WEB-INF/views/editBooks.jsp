<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EditBooks</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/admin/editBooks.css">

    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

<div class="main">
    <jsp:include page="header.jsp"/>
    <c:set var="editBook" value="${requestScope.editBook}"/>

    <div class="addForm container-fluid">
        <form id="editBookForm" action="editBook/${editBook.id}" method="post" enctype="multipart/form-data">
            <h2>SỬA THÔNG TIN</h2>
            <div class="book container row">
                <div class="image col-12 col-lg-6">
                    <img src="getImage/${editBook.id}"/>
                </div>

                <div class="info col-12 col-lg-6">
                    <label>Tiêu đề:</label><br>
                    <input type="text" name="title" required value="${editBook.title}"><br><br>

                    <div class="sub-page-cover row justify-content-between">
                        <div class="col-12 col-lg-4">
                            <label>Subcategory:</label><br>
                            <select name="subcategoryId" required value="${editBook.subcategory}">
                                <option value="1" ${editBook.subcategory.id == 1 ? 'selected' : ''}>Tiểu Thuyết</option>
                                <option value="2" ${editBook.subcategory.id == 2 ? 'selected' : ''}>Truyện Ngắn</option>
                                <option value="3" ${editBook.subcategory.id == 3 ? 'selected' : ''}>Cẩm Nang Làm Cha Mẹ
                                </option>
                                <option value="4" ${editBook.subcategory.id == 4 ? 'selected' : ''}>Phương Pháp Giáo Dục
                                    Trẻ
                                </option>
                                <option value="5" ${editBook.subcategory.id == 5 ? 'selected' : ''}>Manga-Comic</option>
                                <option value="6" ${editBook.subcategory.id == 6 ? 'selected' : ''}>Kiến Thức Bách Khoa
                                </option>
                                <option value="7" ${editBook.subcategory.id == 7 ? 'selected' : ''}>Tiếng Anh</option>
                                <option value="8" ${editBook.subcategory.id == 8 ? 'selected' : ''}>Tiếng Nhật</option>
                            </select><br><br>
                        </div>
                        <div class="col-6 col-lg-4">
                            <label>Page Number:</label><br>
                            <input type="number" min="1" name="pageNo" required value="${editBook.pageNo}"><br><br>
                        </div>
                        <div class="col-6 col-lg-4">
                            <label>Cover Type:</label><br>
                            <select name="coverType" required>
                                <option value="Bìa cứng" ${editBook.coverType.equalsIgnoreCase("bìa cứng")? 'selected' : ''}>
                                    Bìa cứng
                                </option>
                                <option value="Bìa mềm" ${editBook.coverType.equalsIgnoreCase("bìa mềm")? 'selected' : ''}>
                                    Bìa mềm
                                </option>
                            </select><br><br>
                        </div>
                    </div>

                    <div class="price-discount row justify-content-between">
                        <div class="col-6">
                            <label>Price:</label><br>
                            <input type="number" min="0" step="0.01" name="price" required
                                   value="${String.format("%.0f", editBook.price)}"><br><br>
                        </div>
                        <div class="col-6">
                            <label>Discount:</label><br>
                            <input type="number" min="0" step="0.01" name="discount"
                                   value="${String.format("%.0f", editBook.discount)}"><br><br>
                        </div>
                    </div>

                    <label>Tác giả:</label><br>
                    <input type="text" name="author" required value="${editBook.author}"><br><br>

                    <div class="publisher-publishYear row justify-content-between">
                        <div class="col-6">
                            <label>NXB:</label><br>
                            <select name="publisher">
                                <option ${editBook.publisher.contains('NXB Dân Trí') ? 'selected' : ''}>NXB Dân Trí
                                </option>
                                <option ${editBook.publisher.contains('NXB Hà Nội') ? 'selected' : ''}>NXB Hà Nội
                                </option>
                                <option ${editBook.publisher.contains('NXB Hội Nhà Văn') ? 'selected' : ''}>NXB Hội Nhà
                                    Văn
                                </option>
                                <option ${editBook.publisher.contains('NXB Kim Đồng') ? 'selected' : ''}>NXB Kim Đồng
                                </option>
                                <option ${editBook.publisher.contains('NXB Lao Động') ? 'selected' : ''}>NXB Lao Động
                                </option>
                                <option ${editBook.publisher.contains('NXB Đại Học Quốc Gia Tp.HCM') ? 'selected' : ''}>
                                    NXB Đại Học Quốc Gia Tp.HCM
                                </option>
                                <option ${editBook.publisher.contains('NXB Hồng Đức') ? 'selected' : ''}>NXB Hồng Đức
                                </option>
                                <option ${editBook.publisher.contains('NXB Phụ Nữ') ? 'selected' : ''}>NXB Phụ Nữ
                                </option>
                                <option ${editBook.publisher.contains('NXB Thanh Niên') ? 'selected' : ''}>NXB Thanh
                                    Niên
                                </option>
                                <option ${editBook.publisher.contains('NXB Thế Giới') ? 'selected' : ''}>NXB Thế Giới
                                </option>
                                <option ${editBook.publisher.contains('NXB Tổng Hợp Tp.HCM') ? 'selected' : ''}>NXB Tổng
                                    Hợp Tp.HCM
                                </option>
                                <option ${editBook.publisher.contains('NXB Trẻ') ? 'selected' : ''}>NXB Trẻ</option>
                                <option ${editBook.publisher.contains('NXB Văn Học') ? 'selected' : ''}>NXB Văn Học
                                </option>
                            </select><br><br>
                        </div>
                        <div class="col-6">
                            <label>Năm phát hành:</label><br>
                            <input type="number" name="publishedYear" required
                                   value="${editBook.publishedYear}"><br><br>
                        </div>
                    </div>

                    <label>Miêu tả:</label><br>
                    <textarea name="description" required>${editBook.description}</textarea><br><br>

                    <label>Ảnh bìa:</label>
                    <input type="file" name="coverImage"><br><br>

                    <div class="sale-stock row justify-content-between">
                        <div class="col-6">
                            <label>Số lượng bán:</label><br>
                            <input type="number" min="0" name="saleQuantity" required
                                   value="${editBook.saleQuantity}"><br><br>
                        </div>
                        <div class="col-6">
                            <label>Tồn kho:</label><br>
                            <input type="number" min="0" name="stockQuantity" required
                                   value="${editBook.stockQuantity}"><br><br>
                        </div>
                    </div>
                </div>
                <input type="submit" value="THAY ĐỔI" id="submitBtn" disabled onclick="return confirmEdit()">
            </div>
        </form>
        <jsp:include page="footer.jsp"/>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("editBookForm");
        const submitBtn = document.getElementById("submitBtn");

        form.addEventListener("input", function () {
            const isValid = form.checkValidity();
            submitBtn.disabled = !isValid;
        });
    });

    const confirmEdit = function () {
        return confirm("Bạn chắc chắn muốn sửa thông tin sản phẩm?");
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>

</html>

