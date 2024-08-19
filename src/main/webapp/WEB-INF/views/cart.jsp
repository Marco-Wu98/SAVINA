<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart</title>
    <base href="http://localhost:8080/savina/"/>
    <link rel="stylesheet" href="static/css/book/cart.css">
    <script src="static/js/book/cart.js"></script>
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

<div class="main">
    <jsp:include page="header.jsp"/>

    <c:if test="${!sessionScope.isLoggedIn}">
        <c:set var="addList" value="${sessionScope.addListNotLoggedIn}"/>
    </c:if>
    <c:if test="${sessionScope.isLoggedIn}">
        <c:set var="addList" value="${sessionScope.addListWithLoggedIn}"/>
    </c:if>

    <div class="container-fluid">
        <div class="title container">
            <h5>GIỎ HÀNG (<c:if test="${empty addList}">0</c:if><c:if
                    test="${not empty addList}">${addList.size()}</c:if>
                sản phẩm)</h5>
        </div>


        <div class="wrapper container">

            <c:if test="${empty addList}">
                <div class="cartItems">
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
                    <p>Chưa có sản phẩm trong giỏ hàng của bạn</p>
                </div>
                <div class="buy-btn d-flex justify-content-center">
                    <a href="#">
                        <div class="btn">MUA SẮM NGAY</div>
                    </a>
                </div>
            </c:if>


            <div class="row">
                <div class="addItems col-12 col-lg-8">
                    <%--title--%>
                    <c:if test="${not empty addList}">
                        <div class="addItem title">

                            <!--Code for Checkbox-->
                            <div class="checkbox-all">
                                <input type="checkbox" id="checkbox-all" class="checkbox-all">
                                <label for="checkbox-all"></label><br>
                            </div>

                            <div class="book-info">
                                Chọn tất cả (${addList.size()} sản phẩm)
                            </div>

                            <div class="quantity">
                                <span>Số lượng</span>
                            </div>

                            <div class="price">
                                <span>Thành tiền</span>
                            </div>

                        </div>
                    </c:if>

                    <%--Hidden Form--%>
                    <form id="checkout-form" action="order" method="post">
                        <!-- Các input ẩn để chứa thông tin bookId và buyQuantity của từng mục -->
                        <input type="hidden" name="bookId" id="bookId" value="">
                        <input type="hidden" name="buyQuantity" id="buyQuantity" value="">
                    </form>
                    <%--Hidden Form--%>

                    <c:forEach var="entry" items="${addList}">

                        <%--buy items--%>
                        <div class="addItem">

                            <!--Code for Checkbox-->
                            <div class="checkbox">
                                <input type="checkbox" id="checkbox${entry.key.id}" class="item-checkbox"
                                       data-book-id="${entry.key.id}"
                                       data-buy-quantity="${entry.value}"
                                       data-price="${entry.key.price * (1 - entry.key.discount/100) * entry.value}">
                                <label for="checkbox${entry.key.id}"></label><br>
                            </div>

                            <div class="book-img">
                                <a href="info/${entry.key.id}">
                                    <img class="book-img" src="getImage/${entry.key.id}"/>
                                </a>

                            </div>
                            <div class="row align-items-center">
                                <div class="book-detail col-12 col-md-6">
                                    <div class="book-title">
                                            ${entry.key.title}
                                    </div>
                                    <div class="book-price">
                                    <span class="sale">
                                    <c:set var="afterDiscount"
                                           value="${entry.key.price * (1 - entry.key.discount/100)}"/>
                                            ${String.format("%.3f", afterDiscount/1000)} đ
                                    </span>
                                        <span class="origin">
                                            ${String.format("%.3f", entry.key.price/1000)} đ
                                    </span>
                                    </div>

                                </div>

                                <div class="col-12 col-md-6">
                                    <div class="quantity col-12 col-lg-3">
                                        <div class="quantity-control">
                                            <!-- Form để giảm số lượng -->
                                            <form action="updateQuantity" method="post" style="display:inline;">
                                                <input type="hidden" name="bookId" value="${entry.key.id}">
                                                <input type="hidden" name="newQuantity" value="${entry.value - 1}">
                                                <button type="submit" class="decrement" name="quantityBtn">-</button>
                                            </form>
                                            <span class="quantity-input">${entry.value}</span>
                                            <!-- Form để tăng số lượng -->
                                            <form action="updateQuantity" method="post" style="display:inline;">
                                                <input type="hidden" name="bookId" value="${entry.key.id}">
                                                <input type="hidden" name="newQuantity" value="${entry.value + 1}">
                                                <button type="submit" class="increment" name="quantityBtn">+</button>
                                            </form>
                                        </div>
                                    </div>


                                        <%--                            <c:if test="${sessionScope.user == null}">--%>
                                        <%--                                <div class="quantity">--%>
                                        <%--                                    <div class="quantity-control">--%>
                                        <%--                                        <!-- Form để giảm số lượng -->--%>

                                        <%--                                        <button type="submit" class="decrement" name="quantityBtn">-</button>--%>

                                        <%--                                        <span class="quantity-input">${entry.value}</span>--%>
                                        <%--                                        <!-- Form để tăng số lượng -->--%>

                                        <%--                                        <button type="submit" class="increment" name="quantityBtn">+</button>--%>

                                        <%--                                    </div>--%>
                                        <%--                                </div>--%>
                                        <%--                            </c:if>--%>
                                    <div class="col-12 col-lg-3">

                                        <div class="price">
                                            <span name="totalAmount"></span>
                                        </div>

                                        <a href="dellToCart/${entry.key.id}/${entry.value}"><i
                                                class="fa-regular fa-trash-can"></i></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>


                </div>
                <c:if test="${not empty addList}">
                    <div class="payment col-lg-4">
                        <div class="sum">
                            <span>Thành tiền</span>
                            <div>
                                <span id="total-price">0</span>
                                <span> đ</span>
                            </div>
                        </div>
                        <hr>
                        <div class="VAT">
                            <span>Tổng số tiền (gồm VAT)</span>
                            <div>
                                <span id="total-price-vat">0</span>
                                <span> đ</span>
                            </div>
                        </div>

                            <%--                        <form action="delivery">--%>
                        <button id="checkout-button" class="btn btn-danger" disabled>THANH TOÁN</button>
                            <%--                        </form>--%>
                    </div>
                </c:if>
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
