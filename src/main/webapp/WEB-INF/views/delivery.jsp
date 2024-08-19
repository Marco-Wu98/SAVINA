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
    <link rel="stylesheet" href="static/css/book/delivery.css">
    <script src="static/js/book/delivery.js"></script>
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

        <c:if test="${empty sessionScope.user}">
            <div class="alert container">
                <div class="alert-icon">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>
                <div class="alert-text">
                    Đăng nhập để thanh toán &nbsp;<a href="loginToCart"> Đăng nhập ngay.</a>
                </div>
            </div>
        </c:if>

        <c:if test="${empty sessionScope.user.deliveries}">
            <!-- Payment Form -->
            <form id="paymentForm" action="firstOrderFinish" method="post">
                <div class="form container">
                    <h5>ĐỊA CHỈ GIAO HÀNG</h5>
                    <hr/>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="floatingNamePayment" name="recipientName"
                               placeholder="#" oninput="validateNamePayment()">
                        <label for="floatingNamePayment">Nhập họ và tên người nhận</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="floatingEmailPayment" name="email" placeholder="#"
                               oninput="validateEmailPayment()">
                        <label for="floatingEmailPayment">Nhập email</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="number" class="form-control" id="floatingPhonePayment" name="phoneNumber"
                               placeholder="#" oninput="validatePhonePayment()">
                        <label for="floatingPhonePayment">Nhập số điện thoại</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" id="cityPayment" name="city"
                                onchange="delayedCheckFormValidityForPayment()">
                            <option value="" selected>Chọn tỉnh/thành phố</option>
                        </select>
                        <label for="cityPayment">Tỉnh/Thành phố</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" id="districtPayment" name="district"
                                onchange="delayedCheckFormValidityForPayment()">
                            <option value="" selected>Chọn quận/huyện</option>
                        </select>
                        <label for="districtPayment">Quận/Huyện</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" id="wardPayment" name="ward"
                                onchange="delayedCheckFormValidityForPayment()">
                            <option value="" selected>Chọn phường/xã</option>
                        </select>
                        <label for="wardPayment">Phường/Xã</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="floatingAddressPayment" name="address"
                               placeholder="#" oninput="delayedCheckFormValidityForPayment()">
                        <label for="floatingAddressPayment">Nhập địa chỉ nhận hàng</label>
                    </div>
                </div>
            </form>
        </c:if>

        <c:if test="${not empty sessionScope.user.deliveries}">
            <div class="delivery-address container">
                <p>ĐỊA CHỈ GIAO HÀNG</p>
                <hr/>
                <c:set var="deliveries" value="${sessionScope.user.deliveries}"/>
                <c:forEach items="${deliveries}" var="delivery" varStatus="status">
                    <label class="cr-wrapper">
                        <div>
                            <input name="radio" type="radio" data-index="${status.index}" checked="checked"/>
                            <div class="cr-input"></div>
                            <span>${delivery.recipientName} | ${delivery.address}, ${delivery.ward}, ${delivery.district}, ${delivery.city} | ${delivery.phoneNumber}</span>
                        </div>
                        <div class="edit" data-bs-toggle="modal" data-bs-target="#editModal"
                             data-recipient-name="${delivery.recipientName}"
                             data-email="${delivery.email}"
                             data-phone-number="${delivery.phoneNumber}"
                             data-city="${delivery.city}"
                             data-district="${delivery.district}"
                             data-ward="${delivery.ward}"
                             data-address="${delivery.address}"
                             data-index="${status.index}">Sửa
                        </div>
                    </label>
                    <br/>
                </c:forEach>
                <div class="add-address" data-bs-toggle="modal" data-bs-target="#addModal">
                    <i class="fa-solid fa-circle-plus"></i>
                    <span>Giao hàng đến địa chỉ khác</span>
                </div>


            </div>
        </c:if>

        <jsp:include page="footer.jsp"/>
    </div>

    <div class="payment">
        <div class="payment-main container">
            <hr/>
            <div class="wrapper">
                <div class="policy">
                    <i class="fa-solid fa-square-check"></i>
                    <div class="policy-content">
                        <div class="up">
                            Bằng việc tiến hành Mua hàng, Bạn đã đồng ý với
                        </div>
                        <a href="javascript:;" class="down">
                            Điều khoản & Điều kiện của SAVINA.com
                        </a>
                    </div>
                </div>
                <c:if test="${empty sessionScope.user.deliveries}">
                    <button disabled="disabled" id="firstConfirmPayment"
                            name="button"
                            class="myBtn paymentBtn btn btn-danger border-0
                            <c:if test='${sessionScope.user == null}'>disabled</c:if>"
                            onclick='submitFirstPaymentForm()'>
                        <span>Xác nhận thanh toán</span>
                    </button>
                </c:if>
                <c:if test="${not empty sessionScope.user.deliveries}">
                    <button id="confirmPayment"
                            name="button"
                            class="myBtn paymentBtn btn btn-danger">
                        <span>Xác nhận thanh toán</span>
                    </button>
                </c:if>


            </div>
        </div>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">THAY ĐỔI ĐỊA CHỈ GIAO HÀNG</h5>
            </div>
            <div class="modal-body">
                <form id="editForm" action="updateDelivery" method="post">
                    <div class="form container">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="floatingNameEdit" name="recipientName"
                                   placeholder="#">
                            <label for="floatingNameEdit">Nhập họ và tên người nhận</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="floatingEmailEdit" name="email"
                                   placeholder="#">
                            <label for="floatingEmailEdit">Nhập email</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="number" class="form-control" id="floatingPhoneEdit" name="phoneNumber"
                                   placeholder="#">
                            <label for="floatingPhoneEdit">Nhập số điện thoại</label>
                        </div>
                        <div class="form-floating mb-3">
                            <select class="form-select" id="cityEdit" name="city">
                                <option value="" selected>Chọn tỉnh/thành phố</option>
                            </select>
                            <label for="cityEdit">Tỉnh/Thành phố</label>
                        </div>
                        <div class="form-floating mb-3">
                            <select class="form-select" id="districtEdit" name="district">
                                <option value="" selected>Chọn quận/huyện</option>
                            </select>
                            <label for="districtEdit">Quận/Huyện</label>
                        </div>
                        <div class="form-floating mb-3">
                            <select class="form-select" id="wardEdit" name="ward">
                                <option value="" selected>Chọn phường/xã</option>
                            </select>
                            <label for="wardEdit">Phường/Xã</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="floatingAddressEdit" name="address"
                                   placeholder="#">
                            <label for="floatingAddressEdit">Nhập địa chỉ nhận hàng</label>
                        </div>
                        <input type="hidden" id="deliveryIndex" name="index" value="">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="editBtn" type="button" class="myBtn btn btn-primary" onclick="submitEditForm()">Lưu địa chỉ
                </button>
                <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            </div>
        </div>
    </div>
</div>


<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addModalLabel">THÊM ĐỊA CHỈ GIAO HÀNG MỚI</h5>
            </div>
            <div class="modal-body">
                <form id="addForm" action="addDelivery" method="post">
                    <div class="form container">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="floatingNameAdd" name="recipientName"
                                   placeholder="#">
                            <label for="floatingNameAdd">Nhập họ và tên người nhận</label>

                        </div>
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="floatingEmailAdd" name="email" placeholder="#">
                            <label for="floatingEmailAdd">Nhập email</label>

                        </div>
                        <div class="form-floating mb-3">
                            <input type="number" class="form-control" id="floatingPhoneAdd" name="phoneNumber"
                                   placeholder="#">
                            <label for="floatingPhoneAdd">Nhập số điện thoại</label>

                        </div>
                        <div class="form-floating mb-3">
                            <select class="form-select" id="cityAdd" name="city">
                                <option value="" selected>Chọn tỉnh/thành phố</option>
                            </select>
                            <label for="cityAdd">Tỉnh/Thành phố</label>
                        </div>
                        <div class="form-floating mb-3">
                            <select class="form-select" id="districtAdd" name="district">
                                <option value="" selected>Chọn quận/huyện</option>
                            </select>
                            <label for="districtAdd">Quận/Huyện</label>
                        </div>
                        <div class="form-floating mb-3">
                            <select class="form-select" id="wardAdd" name="ward">
                                <option value="" selected>Chọn phường/xã</option>
                            </select>
                            <label for="wardAdd">Phường/Xã</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="floatingAddressAdd" name="address"
                                   placeholder="#">
                            <label for="floatingAddressAdd">Nhập địa chỉ nhận hàng</label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button id="addBtn" type="button" class="myBtn btn btn-primary" onclick="submitAddForm()">Thêm địa chỉ
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
            </div>
        </div>
    </div>
</div>


<%--Province API--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Hàm để điền dữ liệu cho form payment
        var citisPayment = document.getElementById("cityPayment");
        var districtsPayment = document.getElementById("districtPayment");
        var wardsPayment = document.getElementById("wardPayment");

        var parameterPayment = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json",
        };
        var promisePayment = axios(parameterPayment);
        promisePayment.then(function (result) {
            renderCity(result.data, citisPayment, districtsPayment, wardsPayment);
        });

        // Hàm để điền dữ liệu cho form edit
        var citisEdit = document.getElementById("cityEdit");
        var districtsEdit = document.getElementById("districtEdit");
        var wardsEdit = document.getElementById("wardEdit");

        var parameterEdit = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json",
        };
        var promiseEdit = axios(parameterEdit);
        promiseEdit.then(function (result) {
            renderCity(result.data, citisEdit, districtsEdit, wardsEdit);
        });

        // Hàm để điền dữ liệu cho form add
        var citisAdd = document.getElementById("cityAdd");
        var districtsAdd = document.getElementById("districtAdd");
        var wardsAdd = document.getElementById("wardAdd");

        var parameterAdd = {
            url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
            method: "GET",
            responseType: "application/json",
        };
        var promiseAdd = axios(parameterAdd);
        promiseAdd.then(function (result) {
            renderCity(result.data, citisAdd, districtsAdd, wardsAdd);
        });

        function renderCity(data, citis, districts, wards) {
            for (const x of data) {
                var opt = document.createElement('option');
                opt.value = x.Name;
                opt.text = x.Name;
                opt.setAttribute('data-id', x.Id);
                citis.options.add(opt);
            }
            citis.onchange = function () {
                districts.length = 1;
                wards.length = 1;
                if (this.options[this.selectedIndex].dataset.id != "") {
                    const result = data.filter(n => n.Id === this.options[this.selectedIndex].dataset.id);

                    for (const k of result[0].Districts) {
                        var opt = document.createElement('option');
                        opt.value = k.Name;
                        opt.text = k.Name;
                        opt.setAttribute('data-id', k.Id);
                        districts.options.add(opt);
                    }
                }
            };
            districts.onchange = function () {
                wards.length = 1;
                const dataCity = data.filter((n) => n.Id === citis.options[citis.selectedIndex].dataset.id);
                if (this.options[this.selectedIndex].dataset.id != "") {
                    const dataWards = dataCity[0].Districts.filter(n => n.Id === this.options[this.selectedIndex].dataset.id)[0].Wards;

                    for (const w of dataWards) {
                        var opt = document.createElement('option');
                        opt.value = w.Name;
                        opt.text = w.Name;
                        opt.setAttribute('data-id', w.Id);
                        wards.options.add(opt);
                    }
                }
            };
        }

        const editButtons = document.querySelectorAll(".edit");

        editButtons.forEach(function (button) {
            button.addEventListener("click", function () {
                // Lấy dữ liệu từ data attributes của nút Sửa
                const recipientName = button.getAttribute("data-recipient-name");
                const email = button.getAttribute("data-email");
                const phoneNumber = button.getAttribute("data-phone-number");
                const city = button.getAttribute("data-city");
                const district = button.getAttribute("data-district");
                const ward = button.getAttribute("data-ward");
                const address = button.getAttribute("data-address");
                const index = button.getAttribute("data-index");

                // Điền các giá trị vào các trường nhập của form modal
                document.getElementById("floatingNameEdit").value = recipientName;
                document.getElementById("floatingEmailEdit").value = email;
                document.getElementById("floatingPhoneEdit").value = phoneNumber;
                document.getElementById("floatingAddressEdit").value = address;

                // Lưu index vào trường ẩn deliveryIndex
                document.getElementById("deliveryIndex").value = index;

                // Thiết lập giá trị cho city và kích hoạt sự kiện change để điền các giá trị cho district
                const citySelect = document.getElementById("cityEdit");
                citySelect.value = city;
                citySelect.dispatchEvent(new Event('change'));

                // Đợi một chút để các options của district được điền
                setTimeout(() => {
                    const districtSelect = document.getElementById("districtEdit");
                    districtSelect.value = district;
                    districtSelect.dispatchEvent(new Event('change'));

                    // Đợi một chút để các options của ward được điền
                    setTimeout(() => {
                        const wardSelect = document.getElementById("wardEdit");
                        wardSelect.value = ward;
                    }, 100); // Thời gian chờ tùy thuộc vào tốc độ phản hồi của việc điền dropdown
                }, 100); // Thời gian chờ tùy thuộc vào tốc độ phản hồi của việc điền dropdown
            });
        });
    });

    // Check Valid Form Cho Edit Form
    const cityEdit = document.getElementById("cityEdit");
    const districtEdit = document.getElementById("districtEdit");
    const wardEdit = document.getElementById("wardEdit");
    const floatingAddressEdit = document.getElementById("floatingAddressEdit");
    const floatingNameEdit = document.getElementById("floatingNameEdit");
    const floatingEmailEdit = document.getElementById("floatingEmailEdit")
    const floatingPhoneEdit = document.getElementById("floatingPhoneEdit");
    const editBtn = document.getElementById("editBtn");

    // Enable edit button initially
    enableEditBtn();

    function disableEditBtn() {
        editBtn.disabled = true;
    }

    function enableEditBtn() {
        editBtn.disabled = false;
    }

    function scanEmptyForEdit() {
        return (
            cityEdit.value.trim() === "" ||
            districtEdit.value.trim() === "" ||
            wardEdit.value.trim() === "" ||
            floatingAddressEdit.value.trim() === ""
        );
    }

    function scanError() {
        const errors = document.getElementsByClassName("error");
        return errors.length;
    }

    function checkFormValidityForEdit() {
        const isEmpty = scanEmptyForEdit();
        const hasErrors = scanError() !== 0;

        if (isEmpty || hasErrors) {
            disableEditBtn();
        } else {
            enableEditBtn();
        }
    }

    function delayedCheckFormValidityForEdit() {
        setTimeout(checkFormValidityForEdit, 101);
    }

    // Event listeners for changes in the form
    cityEdit.addEventListener("change", delayedCheckFormValidityForEdit);
    districtEdit.addEventListener("change", delayedCheckFormValidityForEdit);
    wardEdit.addEventListener("change", delayedCheckFormValidityForEdit);
    floatingAddressEdit.addEventListener("input", delayedCheckFormValidityForEdit);


    // Existing event listeners for input fields
    floatingNameEdit.addEventListener("input", function () {
        validateRecipientNameEdit(floatingNameEdit);
        checkFormValidityForEdit();
    });

    floatingEmailEdit.addEventListener("input", function () {
        validateEmailEdit(floatingEmailEdit);
        checkFormValidityForEdit();
    });

    floatingPhoneEdit.addEventListener("input", function () {
        validatePhoneNumberEdit(floatingPhoneEdit);
        checkFormValidityForEdit();
    });


    function validateRecipientNameEdit(inputElement) {
        const value = inputElement.value.trim();
        const errorElement = inputElement.parentElement.querySelector(".error-message");
        // Tách các từ trong giá trị và kiểm tra số lượng từ
        const words = value.split(/\s+/);
        if (words.length < 2) {
            showError(inputElement, "Tên người nhận phải có ít nhất 2 ký tự.");
            addError(inputElement);
        } else {
            showError(inputElement, "");
            hideError(inputElement);
        }
    }

    function validateEmailEdit(inputElement) {
        const value = inputElement.value.trim();
        const errorElement = inputElement.parentElement.querySelector(".error-message");
        if (!isValidEmail(value)) {
            showError(inputElement, "Email không hợp lệ.");
            addError(inputElement);
        } else {
            showError(inputElement, "");
            hideError(inputElement);
        }
    }

    function validatePhoneNumberEdit(inputElement) {
        const value = inputElement.value.trim();
        const errorElement = inputElement.parentElement.querySelector(".error-message");
        if (!/^\d{10}$/.test(value)) {
            showError(inputElement, "Số điện thoại phải gồm 10 chữ số.");
            addError(inputElement);
        } else {
            showError(inputElement, "");
            hideError(inputElement);
        }
    }


    // Check Valid Form Cho Add Form
    const cityAdd = document.getElementById("cityAdd");
    const districtAdd = document.getElementById("districtAdd");
    const wardAdd = document.getElementById("wardAdd");
    const floatingAddressAdd = document.getElementById("floatingAddressAdd");
    const floatingNameAdd = document.getElementById("floatingNameAdd");
    const floatingEmailAdd = document.getElementById("floatingEmailAdd");
    const floatingPhoneAdd = document.getElementById("floatingPhoneAdd");
    const addBtn = document.getElementById("addBtn");

    // Disable add button initially
    disableAddBtn();

    function disableAddBtn() {
        addBtn.disabled = true;
    }

    function enableAddBtn() {
        addBtn.disabled = false;
    }

    function scanEmptyForAdd() {
        return (cityAdd.value === "" || districtAdd.value === "" || wardAdd.value === "" || floatingAddressAdd.value.trim() === "");
    }

    function checkFormValidity() {
        if (!scanEmptyForAdd() && scanSuccess() === 3) {
            enableAddBtn();
        } else {
            disableAddBtn();
        }
    }

    function delayedCheckFormValidityForAdd() {
        setTimeout(checkFormValidity, 101);
    }

    // Event listeners for changes in the form
    cityAdd.addEventListener("change", delayedCheckFormValidityForAdd);
    districtAdd.addEventListener("change", delayedCheckFormValidityForAdd);
    wardAdd.addEventListener("change", delayedCheckFormValidityForAdd);
    floatingAddressAdd.addEventListener("input", delayedCheckFormValidityForAdd);

    // Existing event listeners for input fields
    floatingNameAdd.addEventListener("input", function () {
        validateRecipientName(floatingNameAdd);
        checkFormValidity();
    });

    floatingEmailAdd.addEventListener("input", function () {
        validateEmail(floatingEmailAdd);
        checkFormValidity();
    });

    floatingPhoneAdd.addEventListener("input", function () {
        validatePhoneNumber(floatingPhoneAdd);
        checkFormValidity();
    });

    // Check valid form cho Payment Form

    const cityPayment = document.getElementById("cityPayment");
    const districtPayment = document.getElementById("districtPayment");
    const wardPayment = document.getElementById("wardPayment");
    const floatingAddressPayment = document.getElementById("floatingAddressPayment");
    const floatingNamePayment = document.getElementById("floatingNamePayment");
    const floatingEmailPayment = document.getElementById("floatingEmailPayment");
    const floatingPhonePayment = document.getElementById("floatingPhonePayment");
    const firstConfirmPayment = document.getElementById("firstConfirmPayment");

    // Disable firstConfirmPayment initially
    // disableFirstConfirmPayment();

    function disableFirstConfirmPayment() {
        firstConfirmPayment.disabled = true;
    }

    function enableFirstConfirmPayment() {
        firstConfirmPayment.disabled = false;
    }

    function scanEmptyForPayment() {
        return (cityPayment.value === "" || districtPayment.value === "" || wardPayment.value === "" || floatingAddressPayment.value.trim() === "");
    }

    function checkPaymentFormValidity() {
        if (!scanEmptyForPayment() && scanSuccess() === 3) {
            enableFirstConfirmPayment();
        } else {
            disableFirstConfirmPayment();
        }
    }

    function delayedCheckFormValidityForPayment() {
        setTimeout(checkPaymentFormValidity, 101);
    }

    // Event listeners for changes in the form

    const validateNamePayment = function () {
        validateRecipientName(floatingNamePayment);
        checkPaymentFormValidity();
    }

    const validateEmailPayment = function () {
        validateEmail(floatingEmailPayment);
        checkPaymentFormValidity();
    }

    const validatePhonePayment = function () {
        validatePhoneNumber(floatingPhonePayment);
        checkPaymentFormValidity();
    }

    // Xử lý sự kiện khi click vào firstConfirmPayment
    const submitFirstPaymentForm = function () {
        const paymentForm = document.getElementById("paymentForm");
        paymentForm.submit();
    }
    // Xử lý sự kiện khi click vào ConfirmPayment
    const submitPaymentForm = function () {
        const paymentForm = document.getElementById("paymentForm");
        paymentForm.submit();
    }


    // Kết thúc Check valid form cho Payment Form


    function validateRecipientName(inputElement) {
        const value = inputElement.value.trim();
        const words = value.split(/\s+/);
        if (words.length < 2) {
            showError(inputElement, "Tên người nhận phải có ít nhất 2 từ.");
            hideSuccess(inputElement);
        } else {
            showError(inputElement, "");
            showSuccess(inputElement);
        }
    }

    function validateEmail(inputElement) {
        const value = inputElement.value.trim();
        if (!isValidEmail(value)) {
            showError(inputElement, "Email không hợp lệ.");
            hideSuccess(inputElement);
        } else {
            showError(inputElement, "");
            showSuccess(inputElement);
        }
    }

    function validatePhoneNumber(inputElement) {
        const value = inputElement.value.trim();
        if (!/^\d{10}$/.test(value)) {
            showError(inputElement, "Số điện thoại phải gồm 10 chữ số.");
            hideSuccess(inputElement);
        } else {
            showError(inputElement, "");
            showSuccess(inputElement);
        }
    }


    function scanSuccess() {
        const successes = document.getElementsByClassName("success");
        return successes.length;
    }

    // Đoạn này dùng chung cho 2 Modal
    function isValidEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }

    function showError(inputElement, message) {
        const formControl = inputElement.parentElement;
        let errorElement = formControl.querySelector(".error-message");
        if (!errorElement) {
            errorElement = document.createElement("div");
            errorElement.className = "error-message";
            formControl.appendChild(errorElement);
        }
        errorElement.textContent = message;
    }

    function addError(element) {
        element.classList.add("error");
    }

    function hideError(element) {
        element.classList.remove("error");
    }

    function showSuccess(element) {
        element.classList.add("success");
    }

    function hideSuccess(element) {
        element.classList.remove("success");
    }


    function submitEditForm() {
        document.getElementById("editForm").submit();
    }

    function submitAddForm() {
        document.getElementById("addForm").submit();
    }


    // Xử lý sự kiện khi click vào confirmPayment
    const confirmPayment = document.getElementById('confirmPayment');


    confirmPayment.addEventListener('click', function () {
        // Tìm input radio nào được checked
        var checkedRadio = document.querySelector('input[name="radio"]:checked');
        // Lấy giá trị data-index của input radio được checked
        var selectedIndex = checkedRadio.getAttribute('data-index');
        // Chuyển hướng đến URL /finish với tham số index
        window.location.href = 'orderFinish?index=' + selectedIndex;
    });


</script>
<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>

</html>

<%--chua sua--%>