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

        // 3. Chuyển hướng
        req.getRequestDispatcher("/admin/reports.jsp").forward(req, resp);
    }
}