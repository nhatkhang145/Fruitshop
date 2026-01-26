package controller;

import dal.OrderDAO;
import model.Order;
// import model.OrderDetail; // Import model chi tiết đơn hàng của bạn

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderDetailServlet", urlPatterns = {"/admin/order-detail", "/admin/order-update-status"})
public class AdminOrderDetailServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            int orderId = Integer.parseInt(idStr);

            // 1. Lấy thông tin đơn hàng
            Order order = orderDAO.getOrderById(orderId);

            // 2. Lấy danh sách sản phẩm trong đơn hàng (OrderDetail)
            // List<OrderDetail> details = orderDAO.getOrderDetails(orderId);

            req.setAttribute("order", order);
            // req.setAttribute("details", details);

            req.getRequestDispatcher("/admin/order-detail.jsp").forward(req, resp);
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
    }
}