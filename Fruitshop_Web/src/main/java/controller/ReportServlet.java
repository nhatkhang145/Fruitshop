package controller;

import dal.OrderDAO;
import dal.ProductDAO;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ReportServlet", urlPatterns = {"/admin/reports"})
public class ReportServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private UserDAO userDAO = new UserDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Gọi DAO lấy số liệu thống kê
        double totalRevenue = orderDAO.getTotalRevenue();
        int totalOrders = orderDAO.countTotalOrders();
        int totalUsers = userDAO.countTotalUsers();
        int totalProducts = productDAO.countTotalProducts();

        // 2. Gửi số liệu sang JSP
        req.setAttribute("totalRevenue", totalRevenue);
        req.setAttribute("totalOrders", totalOrders);
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("totalProducts", totalProducts);

        // 2. Xử lý dữ liệu cho BIỂU ĐỒ DOANH THU (Line/Bar Chart)
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        List<Double> revenueList = orderDAO.getRevenueByMonth(currentYear);
        // Chuyển List thành chuỗi JSON: [12000.0, 50000.0, ...]
        req.setAttribute("chartRevenueData", listToString(revenueList));

        // 3. Xử lý dữ liệu cho BIỂU ĐỒ DANH MỤC (Pie Chart)
        Map<String, Double> categoryMap = orderDAO.getRevenueByCategory();
        // Tách thành 2 mảng: Nhãn (Labels) và Dữ liệu (Data)
        StringBuilder catLabels = new StringBuilder("[");
        StringBuilder catData = new StringBuilder("[");

        int i = 0;
        for (Map.Entry<String, Double> entry : categoryMap.entrySet()) {
            if (i > 0) { catLabels.append(","); catData.append(","); }
            catLabels.append("'").append(entry.getKey()).append("'"); // Thêm dấu nháy cho chuỗi
            catData.append(entry.getValue());
            i++;
        }
        catLabels.append("]");
        catData.append("]");

        req.setAttribute("pieLabels", catLabels.toString());
        req.setAttribute("pieData", catData.toString());

        req.getRequestDispatcher("/admin/reports.jsp").forward(req, resp);
    }

    // Hàm phụ trợ: Chuyển List<Double> thành chuỗi "[v1, v2, v3]"
    private String listToString(List<Double> list) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < list.size(); i++) {
            sb.append(list.get(i));
            if (i < list.size() - 1) sb.append(",");
        }
        sb.append("]");
        return sb.toString();
    }
}