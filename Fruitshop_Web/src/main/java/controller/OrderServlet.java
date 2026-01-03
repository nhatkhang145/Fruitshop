package controller;

import dal.OrderDAO;
import model.Order;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderServlet", urlPatterns = {"/orders"})
public class OrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy filter status (nếu có)
        String filterStatus = req.getParameter("status");

        List<Order> orders;
        if (filterStatus != null && !filterStatus.isEmpty() && !filterStatus.equals("all")) {
            // Lọc theo status
            orders = orderDAO.getOrdersByStatus(user.getId(), filterStatus);
        } else {
            // Lấy tất cả
            orders = orderDAO.getOrdersByUserId(user.getId());
        }

        // Đếm số đơn hàng theo từng trạng thái (để hiển thị badge)
        int pendingCount = orderDAO.countOrdersByStatus(user.getId(), "pending");
        int processingCount = orderDAO.countOrdersByStatus(user.getId(), "processing");
        int shippedCount = orderDAO.countOrdersByStatus(user.getId(), "shipped");
        int completedCount = orderDAO.countOrdersByStatus(user.getId(), "completed");
        int cancelledCount = orderDAO.countOrdersByStatus(user.getId(), "cancelled");

        req.setAttribute("orders", orders);
        req.setAttribute("filterStatus", filterStatus == null ? "all" : filterStatus);
        req.setAttribute("pendingCount", pendingCount);
        req.setAttribute("processingCount", processingCount);
        req.setAttribute("shippedCount", shippedCount);
        req.setAttribute("completedCount", completedCount);
        req.setAttribute("cancelledCount", cancelledCount);

        req.getRequestDispatcher("/orders.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        String orderIdStr = req.getParameter("orderId");

        if ("cancel".equals(action) && orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                boolean success = orderDAO.cancelOrder(orderId, user.getId());

                if (success) {
                    session.setAttribute("successMessage", "Hủy đơn hàng thành công!");
                } else {
                    session.setAttribute("errorMessage", "Không thể hủy đơn hàng này!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("errorMessage", "Có lỗi xảy ra!");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/orders");
    }
}
