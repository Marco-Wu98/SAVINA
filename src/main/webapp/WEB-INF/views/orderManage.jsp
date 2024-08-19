<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OrderManage</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/admin/orderManage.css">

    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

<div class="main">
    <jsp:include page="header.jsp"/>
    <c:set var="orders" value="${sessionScope.allOrders}"/>
    <c:if test="${requestScope.allOption == true}">
        <c:set var="displayOrders" value="${sessionScope.allOrders}"/>
    </c:if>
    <c:if test="${requestScope.pendingOption == true}">
        <c:set var="displayOrders" value="${sessionScope.pendingOrders}"/>
    </c:if>
    <c:if test="${requestScope.completedOption == true}">
        <c:set var="displayOrders" value="${sessionScope.completedOrders}"/>
    </c:if>
    <c:if test="${requestScope.cancelOption == true}">
        <c:set var="displayOrders" value="${sessionScope.cancelOrders}"/>
    </c:if>
    <div class="wrapper container-fluid">
        <div class="orders container">
            <h4>Quản lý đơn hàng</h4>
            <div class="options row"></span>
                <a href="orderManage" class="col-2 <c:if test="${requestScope.allOption == true}">active</c:if>">
                    <span>${sessionScope.allOrders.size()}</span>
                    <span>Tất cả</span>
                </a>
                <a href="pendingOrdersAdmin"
                   class="col-2 <c:if test="${requestScope.pendingOption == true}">active</c:if>">
                    <span>${sessionScope.pendingOrders.size()}</span>
                    <span>Đang xử lý</span>
                </a>
                <a href="javascript:;" class="col-2">
                    <span>0</span>
                    <span>Đang giao</span>
                </a>
                <a href="completedOrdersAdmin"
                   class="col-2 <c:if test="${requestScope.completedOption == true}">active</c:if>">
                    <span>${sessionScope.completedOrders.size()}</span>
                    <span>Hoàn tất</span>
                </a>
                <a href="cancelOrdersAdmin"
                   class="col-2 <c:if test="${requestScope.cancelOption == true}">active</c:if>">
                    <span>${sessionScope.cancelOrders.size()}</span>
                    <span>Bị hủy</span>
                </a>
                <a href="javascript:;" class="col-2">
                    <span>0</span>
                    <span>Đổi trả</span>
                </a>
            </div>
        </div>
        <c:if test="${not empty displayOrders}">
            <c:forEach items="${displayOrders}" var="order">
                <div class="order-wrapper container" data-orderNo="${order.orderNo}" onclick="toOrderInfo(this)">
                    <div class="order">
                        <div class="order-header">
                            <div class="id">
                                <span>#${order.orderNo}</span>
                                <span class="badge mx-4
                       <c:if test="${order.status.equalsIgnoreCase('PENDING')}">bg-secondary</c:if>
                       <c:if test="${order.status.equalsIgnoreCase('COMPLETED')}">bg-success</c:if>
                       <c:if test="${order.status.equalsIgnoreCase('CANCEL')}">bg-danger</c:if>
                        ">
                       <c:if test="${order.status.equalsIgnoreCase('PENDING')}">Đang xử lý</c:if>
                       <c:if test="${order.status.equalsIgnoreCase('COMPLETED')}">Hoàn tất</c:if>
                       <c:if test="${order.status.equalsIgnoreCase('CANCEL')}">Bị hủy</c:if>
                        </span>
                            </div>
                            <div class="time">
                                <fmt:formatDate value="${order.date}" pattern="dd/MM/yyyy - HH:mm"/>
                            </div>
                        </div>
                        <hr/>
                        <div class="order-body">
                            <c:forEach items="${order.orderDetails}" var="orderDetail">
                                <div>
                                    <img src="./getImage/${orderDetail.book.id}" alt="BookImage">
                                    <span>${orderDetail.book.title}</span>
                                </div>
                                <hr/>
                            </c:forEach>
                        </div>
                        <div class="order-footer">
                            <div class="totalAmount">
                                <span>Tổng tiền:</span>
                                <span>
                                ${String.format("%.3f", order.amount/1000)} đ
                            </span>
                            </div>
                            <div>
                                <div class="quantity">
                                        ${order.orderDetails.size()} sản phẩm
                                </div>
                                <div class="button">
                                    <a href="cancelOrderByAdmin?orderNo=${order.orderNo}"
                                       onclick="return confirmCancel()"
                                       class="btn btn-danger <c:if test="${order.status.equalsIgnoreCase('cancel')}">disabled</c:if>
                                                             <c:if test="${order.status.equalsIgnoreCase('completed')}">disabled</c:if>">Hủy
                                        đơn</a>
                                    <a href="completedOrderByAdmin?orderNo=${order.orderNo}"
                                       onclick="return confirmComplete()"
                                       class="btn btn-success <c:if test="${order.status.equalsIgnoreCase('completed')}">disabled</c:if>
                                                              <c:if test="${order.status.equalsIgnoreCase('cancel')}">disabled</c:if>">Hoàn
                                        thành</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty displayOrders}">
            <div class="cartItems container d-flex flex-column align-items-center justify-content-center">
                <div class="emptyIcon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="160" height="160.001" viewBox="0 0 160 160.001">
                        <defs>
                            <style>.a {
                                fill: #f2f4f5;
                            }

                            .b {
                                fill: #e3e5e5;
                            }

                            .c {
                                fill: #cdcfd0;
                            }

                            .d, .j, .k, .l {
                                fill: #b4b6b8;
                            }

                            .e {
                                fill: #464a4c;
                            }

                            .f {
                                fill: #7a7e7f;
                            }

                            .g {
                                fill: #979697;
                            }

                            .h, .i {
                                fill: none;
                                stroke-linecap: round;
                                stroke-linejoin: round;
                            }

                            .h {
                                stroke: #f1f1f2;
                                stroke-width: 2px;
                            }

                            .i {
                                stroke: #b4b6b8;
                            }

                            .j {
                                font-size: 29px;
                            }

                            .j, .k, .l {
                                font-family: Nunito-ExtraBold, Nunito;
                                font-weight: 800;
                            }

                            .k {
                                font-size: 22px;
                            }

                            .l {
                                font-size: 18px;
                            }</style>
                        </defs>
                        <g transform="translate(-114.83 -59.67)">
                            <path class="a"
                                  d="M274.83,139.664A80,80,0,1,1,194.835,59.67,79.751,79.751,0,0,1,274.83,139.664Z"
                                  transform="translate(0 0)"/>
                            <g transform="translate(115.028 134.896)">
                                <path class="b"
                                      d="M357.482,165.461a90.512,90.512,0,0,1-1.813,14.866c-.341,1.638-.715,3.253-1.152,4.845a91.87,91.87,0,0,1-20.9,28.85q-1.888,1.752-3.872,3.367a82.015,82.015,0,0,1-46.3,18.748c-1.941.149-3.9.218-5.887.218q-2.016,0-4-.1a81.857,81.857,0,0,1-48.144-18.828q-2.016-1.632-3.914-3.4a92.282,92.282,0,0,1-20.776-28.529c-.213-.779-.416-1.58-.608-2.371a90.62,90.62,0,0,1-2.432-17.511,37.132,37.132,0,0,1,13.865-2.84A22.814,22.814,0,0,1,221.5,164.8a18.291,18.291,0,0,1,3.978,2.543c8.778,7.169,10.346,20.352,23.891,20.352,18.633,0,18.185-24.921,44.624-24.921s16.979,24.921,31.591,24.921a12.037,12.037,0,0,0,4.16-.733,15.15,15.15,0,0,0,3.872-2.1C340.321,180.018,345.771,170.2,357.482,165.461Z"
                                      transform="translate(-197.68 -162.77)"/>
                                <path class="c"
                                      d="M355.4,178.26c-.341,1.638-.714,3.253-1.151,4.845a86.657,86.657,0,0,1-24.758,41.585,75.751,75.751,0,0,1-104.253,0,86.672,86.672,0,0,1-24.672-41.264c-.213-.779-.416-1.581-.607-2.371A36.146,36.146,0,0,1,215.989,177a21.113,21.113,0,0,1,9.251,1.89c11.67,5.52,11.627,21.3,25.919,21.3,17.319,0,16.9-23.192,41.49-23.192s15.795,23.192,29.383,23.192a12.4,12.4,0,0,0,7.46-2.634C336.4,192.576,341.877,181.9,355.4,178.26Z"
                                      transform="translate(-197.463 -160.702)"/>
                            </g>
                            <path class="d" d="M227.471,139.5v61.822a80.051,80.051,0,0,1-76.141-1.262V139.5Z"
                                  transform="translate(4.268 9.334)"/>
                            <path class="e" d="M136.17,151.83v34.022a79.913,79.913,0,0,0,109.638,2.535V151.83Z"
                                  transform="translate(2.495 10.776)"/>
                            <path class="f" d="M153.107,139.5l-16.94,13.775h16.94Z"
                                  transform="translate(2.495 9.334)"/>
                            <path class="f" d="M219.5,139.5l16.564,13.775H219.5Z"
                                  transform="translate(12.239 9.334)"/>
                            <circle class="g" cx="2.897" cy="2.897" r="2.897"
                                    transform="translate(184.036 165.297)"/>
                            <circle class="g" cx="2.897" cy="2.897" r="2.897"
                                    transform="translate(199.83 165.297)"/>
                            <path class="h" d="M179.407,158.305s-2.246-14.065,8.04-14.065,7.754,14.065,7.754,14.065"
                                  transform="translate(7.526 9.888)"/>
                            <g transform="translate(157.557 111.866)">
                                <rect class="d" width="3.551" height="3.551"
                                      transform="translate(2.511 27.146) rotate(45)"/>
                                <rect class="d" width="3.551" height="3.551"
                                      transform="translate(67.883 24.636) rotate(45)"/>
                                <line class="i" x2="7.003" transform="translate(5.021 8.386)"/>
                                <line class="i" x2="7.003" transform="translate(64.991 3.502)"/>
                                <line class="i" y2="7.003" transform="translate(8.523 4.884)"/>
                                <line class="i" y2="7.003" transform="translate(68.493)"/>
                            </g>
                            <g transform="translate(175.971 80.445)">
                                <text class="j" transform="translate(0 29)">
                                    <tspan x="0" y="0">Z</tspan>
                                </text>
                                <text class="k" transform="translate(21 48)">
                                    <tspan x="0" y="0">Z</tspan>
                                </text>
                                <text class="l" transform="translate(8 63)">
                                    <tspan x="0" y="0">Z</tspan>
                                </text>
                            </g>
                        </g>
                    </svg>
                </div>
                <p>Không có đơn hàng nào</p>
            </div>
        </c:if>
        <jsp:include page="footer.jsp"/>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script>
    const confirmCancel = function (event) {
        const flag = confirm("Bạn chắc chắn muốn hủy đơn hàng này?");
        event.stopPropagation(); // Hủy sự kiện bubble
        return flag;
    }

    const confirmComplete = function (event) {
        const flag = confirm("Bạn chắc chắn muốn hoàn thành đơn hàng này?");
        event.stopPropagation(); // Hủy sự kiện bubble
        return flag;
    }

</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>

</html>

