package controller;

import dal.OrderDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        // Thiết lập mặc định nếu người dùng chưa lọc (7 ngày gần nhất)
        if (startDate == null || endDate == null || startDate.isEmpty() || endDate.isEmpty()) {
            endDate = java.time.LocalDate.now().toString();
            startDate = java.time.LocalDate.now().minusDays(6).toString();
        }

        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();

        // 1. Lấy dữ liệu thống kê
        int totalOrders = orderDAO.countTotalOrders();
        int totalUsers = orderDAO.countTotalUsers();
        double totalRevenue = orderDAO.getTotalRevenue();

        // 2. Lấy dữ liệu biểu đồ theo khoảng ngày đã chọn
        List<Double> revenueData = orderDAO.getRevenueByPeriod(startDate, endDate);
        List<String> revenueLabels = orderDAO.getLabelsByPeriod(startDate, endDate);

        // 3. Lấy sản phẩm sắp hết hàng
        List<Product> lowStockProducts = productDAO.getLowStockProducts(10);

        // Đẩy toàn bộ dữ liệu ra JSP
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("revenueData", revenueData);
        request.setAttribute("revenueLabels", revenueLabels);
        request.setAttribute("lowStockProducts", lowStockProducts);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
