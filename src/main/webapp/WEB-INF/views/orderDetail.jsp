<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderDetail</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/book/orderDetail.css">

    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

<div class="main">
    <jsp:include page="header.jsp"/>
    <div class="wrapper container-fluid">
        <div class="orderInfo container">
            <c:set var="order" value="${sessionScope.order}"/>
            <c:set var="delivery" value="${sessionScope.order.delivery}"/>
            <div class="orderId">
                <div>Mã đơn hàng #${order.orderNo}</div>
                <div>Ngày mua: <fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy - HH:mm"/></div>
            </div>
            <div class="status
             <c:if test="${order.status.equalsIgnoreCase('PENDING')}">
             processing
             </c:if>
              <c:if test="${order.status.equalsIgnoreCase('COMPLETED')}">
             completed
             </c:if>
              <c:if test="${order.status.equalsIgnoreCase('CANCEL')}">
             cancel
             </c:if>
             row">
                <div class="status-item col-12 col-lg-2">
                    <i class="fa-solid fa-clipboard-check"></i>
                    <div class="item-detail">
                        <span>Đơn hàng mới</span>
                        <span class="info">
                    <fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy - HH:mm"/>
                    </span>
                    </div>
                </div>
                <div class="status-item col-12 col-lg-3">
                    <span>.</span>
                    <span>.</span>
                    <span>.</span>
                    <span>.</span>
                    <span>.</span>
                    <span>.</span>
                </div>
                <div class="status-item col-12 col-lg-2">
                    <i class="fa-solid fa-box"></i>
                    <div class="item-detail">
                        <span>Đang xử lý</span>
                    </div>
                </div>
                <%-- Cái này chỉ hiển thị khi status của order = cancel --%>
                <c:if test="${order.status.equalsIgnoreCase('cancel')}">
                    <div class="status-item col-12 col-lg-3">
                        <span>.</span>
                        <span>.</span>
                        <span>.</span>
                        <span>.</span>
                        <span>.</span>
                        <span>.</span>
                    </div>

                    <div class="status-item col-12 col-lg-2">
                        <i class="fa-solid fa-ban"></i>
                        <span>Bị hủy</span>
                    </div>
                </c:if>
                <%-- Cái này chỉ hiển thị khi status của order = completed --%>
                <c:if test="${order.status.equalsIgnoreCase('completed')}">
                    <div class="status-item col-12 col-lg-3">
                        <span>.</span>
                        <span>.</span>
                        <span>.</span>
                        <span>.</span>
                        <span>.</span>
                        <span>.</span>
                    </div>

                    <div class="status-item col-12 col-lg-2">
                        <i class="fa-regular fa-circle-check"></i>
                        <span>Hoàn thành</span>
                    </div>
                </c:if>

            </div>
            <div class="detail row justify-content-evenly">
                <div class="recipientInfo detail-item col-12 col-lg-5">
                    <h5>Thông tin người nhận</h5>
                    <div>${delivery.recipientName}</div>
                    <div>Tel: ${delivery.phoneNumber}</div>
                    <div>
                        <i class="fa-solid fa-house"></i>
                        <span>${delivery.address}, ${delivery.ward}, ${delivery.district}, ${delivery.city}</span>
                    </div>
                </div>
                <div class="payment detail-item col-12 col-lg-2">
                    <h5>Phương thức thanh toán</h5>
                    <div>Thanh toán bằng tiền mặt khi nhận hàng</div>
                </div>
                <div class="ammount detail-item col-12 col-lg-4">
                    <h5>Tổng tiền</h5>
                    <div>
                        <div>Tạm tính:</div>
                        <div><fmt:formatNumber value=" ${order.amount}" pattern="#,###.###"/> đ</div>
                    </div>
                    <div>
                        <div>Phí vận chuyển:</div>
                        <div>32.000 đ</div>
                    </div>
                    <div>
                        <div>Tổng Số Tiền (gồm VAT):</div>
                        <div><fmt:formatNumber value=" ${order.amount + 32000.00}" pattern="#,###.###"/> đ</div>
                    </div>
                </div>
            </div>
            <div class="button">
                <button class="btn btn-danger">
                    <a href="#">Tiếp tục mua sắm</a>
                </button>
            </div>
        </div>

        <div class="package container">

            <c:set var="orderDetails" value="${sessionScope.order.orderDetails}"/>

            <div class="package-header">
                <span>Sản phẩm (${orderDetails.size()})</span>
                <span>Giá</span>
                <span>Số lượng</span>
                <span>Thành tiền</span>
            </div>

            <c:forEach items="${orderDetails}" var="orderDetail">
                <c:set var="order" value="${orderDetail.order}"/>
                <div class="items">
                    <div class="product">
                        <div class="image">
                            <img src="./getImage/${orderDetail.book.id}" alt="BookImage">
                        </div>
                        <div class="info">
                            <span class="title">${orderDetail.book.title}</span>
                            <span class="sku">Sku: ${orderDetail.book.id}</span>
                        </div>
                    </div>
                    <div class="price">
                        <span class="sale">
                                 <c:set var="afterDiscount"
                                        value="${orderDetail.book.price * (1 - orderDetail.book.discount/100)}"/>
                                                ${String.format("%.3f", afterDiscount/1000)} đ
                            </span>
                        <span class="origin">
                                ${String.format("%.3f", orderDetail.book.price/1000)} đ
                        </span>
                    </div>
                    <div class="quantity">
                            ${orderDetail.buyQuantity}
                    </div>
                    <div class="amount">
                            ${String.format("%.3f", (afterDiscount * orderDetail.buyQuantity)/1000)} đ
                    </div>
                </div>
            </c:forEach>
            <div class="totalAmount">
                <span>Tổng tiền (Đã bao gồm cước vận chuyển):</span>
                <span>
                     ${String.format("%.3f", (order.amount + 32000)/1000)} đ
                </span>
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
