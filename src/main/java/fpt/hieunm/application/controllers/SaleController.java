package fpt.hieunm.application.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import fpt.hieunm.application.models.pojo.Order;
import fpt.hieunm.application.services.Order.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/sales")
public class SaleController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private ObjectMapper objectMapper; // Inject ObjectMapper

    @GetMapping("/monthly")
    public ResponseEntity<?> getMonthlySalesData() {
        try {
            // Lấy dữ liệu bán hàng theo tháng từ service
            int currentYear = LocalDate.now().getYear();
            List<Object[]> salesData = orderService.getMonthlySalesData(currentYear);

            // Chuẩn bị danh sách tổng doanh thu của các tháng trong năm
            List<Double> monthlySales = new ArrayList<>();
            for (int month = 1; month <= 12; month++) {
                double salesAmount = 0;
                for (Object[] data : salesData) {
                    int dataMonth = (int) data[0];
                    double amount = (double) data[1];
                    if (dataMonth == month) {
                        salesAmount = amount;
                        break;
                    }
                }
                monthlySales.add(salesAmount);
            }

            // Convert the list to JSON using ObjectMapper
            String jsonResponse = objectMapper.writeValueAsString(monthlySales);
            return ResponseEntity.ok().body(jsonResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to fetch sales data.");
        }
    }

    @GetMapping("/status")
    public ResponseEntity<?> getOrderStatusCounts() {
        try {
            // Lấy số lượng đơn hàng theo từng trạng thái từ service
            List<Order> orders = orderService.getAll();
            Long pendingCount = orders.stream()
                    .filter(order -> order.getStatus().equalsIgnoreCase("pending"))
                    .count();
            Long completedCount = orders.stream()
                    .filter(order -> order.getStatus().equalsIgnoreCase("completed"))
                    .count();

            // Tạo một đối tượng để chứa số liệu
            Map<String, Long> statusCounts = new HashMap<>();
            statusCounts.put("pending", pendingCount);
            statusCounts.put("completed", completedCount);
            return ResponseEntity.ok().body(statusCounts);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to fetch order status counts.");
        }
    }

    @GetMapping("/daily")
    public ResponseEntity<?> getDailySalesData() {
        try {
            // Lấy dữ liệu bán hàng theo ngày từ service
            int currentYear = LocalDate.now().getYear();
            int currentMonth = LocalDate.now().getMonthValue();
            List<Object[]> salesData = orderService.getDailySalesData(currentYear, currentMonth);

            // Chuẩn bị danh sách tổng doanh thu của các ngày trong tháng
            List<Double> dailySales = new ArrayList<>();
            int daysInMonth = LocalDate.now().lengthOfMonth();
            for (int day = 1; day <= daysInMonth; day++) {
                double salesAmount = 0;
                for (Object[] data : salesData) {
                    int dataDay = (int) data[0];
                    double amount = (double) data[1];
                    if (dataDay == day) {
                        salesAmount = amount;
                        break;
                    }
                }
                dailySales.add(salesAmount);
            }

            // Convert the list to JSON using ObjectMapper
            String jsonResponse = objectMapper.writeValueAsString(dailySales);
            return ResponseEntity.ok().body(jsonResponse);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to fetch daily sales data.");
        }
    }
}
