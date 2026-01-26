package controller;

import dal.OrderDAO;
import model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminOrderDetailServlet", urlPatterns = {"/admin/order-detail", "/admin/order-update-status"})
public class AdminOrderDetailServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int orderId = Integer.parseInt(idStr);
                // 1. Lấy thông tin đơn hàng
                Order order = orderDAO.getOrderById(orderId);
                req.setAttribute("order", order);
                req.getRequestDispatcher("/admin/order-detail.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                resp.sendRedirect("orders");
            }
        } else {
            resp.sendRedirect("orders");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Xử lý cập nhật trạng thái đơn hàng
        int orderId = Integer.parseInt(req.getParameter("orderId"));
        String status = req.getParameter("status");

        orderDAO.updateStatus(orderId, status);

        // Quay lại trang chi tiết
        resp.sendRedirect("order-detail?id=" + orderId);
        try {
            // Lấy ID đơn hàng
            int orderId = Integer.parseInt(req.getParameter("orderId"));

            // --- SỬA LỖI TẠI ĐÂY ---
            // Nhận status là String (vì JSP gửi lên chữ "shipped", "pending"...)
            String status = req.getParameter("status");

            // Gọi hàm updateOrderStatus (nhận String) trong OrderDAO
            boolean success = orderDAO.updateOrderStatus(orderId, status);
            // -----------------------

            if (success) {
                resp.sendRedirect("order-detail?id=" + orderId + "&msg=success");
            } else {
                resp.sendRedirect("order-detail?id=" + orderId + "&msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("orders");
        }
    }
}