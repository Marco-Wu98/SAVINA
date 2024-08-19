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
    <link rel="stylesheet" href="static/css/admin/adminDashboard.css">
    <!--Font Awesome -->
    <link rel="stylesheet" href="static/font/fontawesome-free-6.5.2-web/css/all.min.css">
    <!--BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>

<body>
<jsp:include page="header.jsp"/>
<div class="main">

    <div class="core container">

        <div class="content col-lg-12">
            <div class="row">
                <div class="row transaction">
                    <img src="static/img/sticker/illustration-john-2.png"/>
                    <h5>Transactions</h5>
                    <h6>Total ${String.format("%.2f", sessionScope.growthRate)}% growth</h6>
                    <div class="items row">
                        <div class="item col-6 col-lg-3 sales">
                            <i class="fa-solid fa-chart-line"></i>
                            <div class="statistic">
                                <span>Sales</span>
                                <span>${sessionScope.sales}</span>
                            </div>
                        </div>
                        <div class="item col-6 col-lg-3 customers">
                            <i class="fa-solid fa-users"></i>
                            <div class="statistic">
                                <span>Customers</span>
                                <span>${sessionScope.usersCount}</span>
                            </div>
                        </div>
                        <div class="item col-6 col-lg-3 products">
                            <i class="fa-solid fa-laptop"></i>
                            <div class="statistic">
                                <span>Product</span>
                                <span>${sessionScope.product}</span>
                            </div>
                        </div>
                        <div class="item col-6 col-lg-3 revenue">
                            <i class="fa-brands fa-bitcoin"></i>
                            <div class="statistic">
                                <span>Revenue</span>
                                <span>${sessionScope.revenue}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row users">
                <!-- Thêm thanh tìm kiếm -->
                <div class="search-bar">
                    <input type="text" id="searchInput" onkeyup="searchTable()" class="form-control"
                           placeholder="Nhập tên bạn muốn tìm kiếm...">
                </div>
                <div class="table-container">
                    <table class="table table-hover" id="userTable">
                        <thead>
                        <tr>
                            <th>
                                <span class="d-none d-lg-block">Khách hàng</span>
                                <span class="d-block d-lg-none"><i class="fa-solid fa-user"></i></span>
                            </th>
                            <th>Email</th>
                            <th class="text-center">
                                <span class="d-none d-lg-block">Tổng đơn hàng</span>
                                <span class="d-block d-lg-none"><i class="fa-solid fa-boxes-stacked"></i></span>
                            </th>
                            <th class="text-center">
                                <span class="d-none d-lg-block">Đang xử lý</span>
                                <span class="d-block d-lg-none"><i class="fa-solid fa-ellipsis"></i></span>
                            </th>
                            <th class="text-center">
                                <span class="d-none d-lg-block">Hoàn tất</span>
                                <span class="d-block d-lg-none"><i class="fa-solid fa-check"></i></span>
                            </th>
                            <th class="text-center">
                                <span class="d-none d-lg-block">Bị hủy</span>
                                <span class="d-block d-lg-none"><i class="fa-regular fa-circle-xmark"></i></span>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${sessionScope.users}" var="user">
                            <tr>
                                <td>${user.userName}</td>
                                <td>${user.email}</td>
                                <td class="text-center">${user.orders.size()}</td>

                                <td class="text-center">
                                    <c:set var="pendingCount" value="0"/>
                                    <c:forEach items="${user.orders}" var="order">
                                        <c:if test="${order.status.equalsIgnoreCase('pending')}">
                                            <c:set var="pendingCount" value="${pendingCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                        ${pendingCount}
                                </td>

                                <td class="text-center">
                                    <c:set var="completedCount" value="0"/>
                                    <c:forEach items="${user.orders}" var="order">
                                        <c:if test="${order.status.equalsIgnoreCase('completed')}">
                                            <c:set var="completedCount" value="${completedCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                        ${completedCount}
                                </td>

                                <td class="text-center">
                                    <c:set var="cancelledCount" value="0"/>
                                    <c:forEach items="${user.orders}" var="order">
                                        <c:if test="${order.status.equalsIgnoreCase('cancel')}">
                                            <c:set var="cancelledCount" value="${cancelledCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                        ${cancelledCount}
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
            <div class="customChart row mt-5">
                <div class="chart row col-12 col-lg-4">
                    <canvas class="mb-lg-5" id="myChart" width="400" height="400"></canvas>

                    <canvas id="myLineChart"></canvas>
                </div>

                <div class="d-flex align-items-center col-12 col-lg-4">
                    <canvas id="myPieChart"></canvas>
                </div>

                <div class="top-book-table col-12 col-lg-4">
                    <img class="bestSeller" src="static/img/sticker/best-seller.png" alt="sticker"/>

                    <table class="table table-hover" id="topBookTable">
                        <thead>
                        <tr>
                            <th style="font-size: 12px">Sách</th>
                            <th style="font-size: 12px">Tên sách</th>
                            <th style="font-size: 12px; width: 100px" class="text-center">Số lượng bán</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${sessionScope.topBooks}" var="book">
                            <tr>
                                <td><img style="height: 40px; width: 40px" src="getImage/${book.id}"/></td>
                                <td style="font-size: 12px">${book.title}</td>
                                <td style="font-size: 12px" class="text-center">${book.saleQuantity}</td>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>


        </div>


    </div>
    <jsp:include page="footer.jsp"/>


</div>


<!-- Bootstrap JS and dependencies -->
<%--<script src="static/js/book/bookInfo.js"></script>--%>
<script>

    function searchTable() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("userTable");
        tr = table.getElementsByTagName("tr");

        for (i = 1; i < tr.length; i++) {
            tr[i].style.display = "none"; // Ẩn tất cả các hàng trước

            td = tr[i].getElementsByTagName("td");
            for (var j = 0; j < td.length; j++) {
                if (td[j]) {
                    txtValue = td[j].textContent || td[j].innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                        break; // Nếu tìm thấy kết quả, hiển thị hàng và dừng tìm kiếm trong hàng này
                    }
                }
            }
        }
    }

    function fetchSalesData() {
        return fetch('api/sales/monthly')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => data)
            .catch(error => console.error('Lỗi khi lấy dữ liệu doanh thu:', error));
    }

    function drawChart() {
        fetchSalesData()
            .then(monthlySales => {
                const labels = ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'];
                const data = {
                    labels: labels,
                    datasets: [{
                        label: 'Dữ liệu doanh thu',
                        backgroundColor: 'blue',
                        borderColor: 'blue',
                        data: monthlySales
                    }]
                };

                const ctx = document.getElementById('myChart').getContext('2d');
                const myChart = new Chart(ctx, {
                    type: 'bar',
                    data: data,
                    options: {
                        // Cấu hình thêm nếu cần
                    }
                });
            });
    }

    // Gọi hàm để vẽ biểu đồ
    drawChart();

    // ===========================================================
    // Lấy context của canvas để vẽ biểu đồ
    var ctx = document.getElementById('myPieChart').getContext('2d');

    // Khởi tạo dữ liệu ban đầu
    var data = {
        labels: ['Đơn đang giao', 'Đơn hoàn thành'],
        datasets: [{
            label: 'Số lượng đơn hàng',
            data: [], // Dữ liệu sẽ được cập nhật sau khi lấy từ server
            backgroundColor: [
                'rgba(255, 206, 86, 0.6)', // Màu cho trạng thái 'Pending'
                'rgba(75, 192, 192, 0.6)' // Màu cho trạng thái 'Completed'
            ],
            borderColor: [
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            borderWidth: 1
        }]
    };

    var options = {
        responsive: true,
        plugins: {
            legend: {
                position: 'top',
            },
            tooltip: {
                callbacks: {
                    label: function (tooltipItem) {
                        return tooltipItem.label + ': ' + tooltipItem.raw.toLocaleString();
                    }
                }
            }
        }
    };

    // Hàm để lấy dữ liệu từ server và cập nhật biểu đồ
    function fetchDataAndUpdateChart() {

        fetch('api/sales/status') // Đường dẫn API để lấy dữ liệu đơn hàng
            .then(response => response.json())
            .then(data => {
                // Cập nhật dữ liệu cho biểu đồ
                myPieChart.data.datasets[0].data = [data.pending, data.completed];

                // Vẽ lại biểu đồ
                myPieChart.update();
            })
            .catch(error => {
                console.error('Error fetching data:', error);
            });
    }

    // Tạo biểu đồ hình bánh
    var myPieChart = new Chart(ctx, {
        type: 'pie',
        data: data,
        options: options
    });

    // Gọi hàm để lấy dữ liệu và cập nhật biểu đồ khi tài liệu đã sẵn sàng
    fetchDataAndUpdateChart();

    // ==============================================================
    // Biểu đồ đường mới
    async function fetchDailySalesData() {
        const response = await fetch(`api/sales/daily`);
        const data = await response.json();
        console.log(data)
        return data;
    }

    async function drawDailyLineChart() {
        const dailySales = await fetchDailySalesData();

        const labels = Array.from({length: 31}, (_, i) => {
            return (i + 1);
        });
        const data = {
            labels: labels,
            datasets: [{
                label: 'Doanh thu hàng ngày',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgb(69,162,0)',
                data: dailySales,
                fill: false,
                tension: 0.1
            }]
        };

        const ctxLine = document.getElementById('myLineChart').getContext('2d');
        const myLineChart = new Chart(ctxLine, {
            type: 'line',
            data: data,
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: 'Biểu đồ Đường - Doanh thu hàng ngày'
                    }
                },
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: 'Ngày'
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: 'Doanh thu'
                        }
                    }
                }
            }
        });
    }

    drawDailyLineChart();


</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>

<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="static/js/book/bookInfo.js"></script>

</body>

</html>
