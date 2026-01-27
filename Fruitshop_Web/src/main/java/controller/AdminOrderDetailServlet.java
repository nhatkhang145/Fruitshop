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
        try {
            // 1. Lấy tham số từ form (đảm bảo name trong JSP là "orderId" và "status")
            String orderIdStr = req.getParameter("orderId");
            String status = req.getParameter("status");

            if (orderIdStr != null && status != null) {
                int orderId = Integer.parseInt(orderIdStr);

                // 2. Gọi hàm updateStatus (đã sửa ở DAO để trả về boolean)
                boolean success = orderDAO.updateStatus(orderId, status);

                // 3. Điều hướng dựa trên kết quả
                if (success) {
                    // Thêm msg=success để hiển thị thông báo bên JSP nếu cần
                    resp.sendRedirect("order-detail?id=" + orderId + "&msg=success");
                } else {
                    resp.sendRedirect("order-detail?id=" + orderId + "&msg=error");
                }
            } else {
                // Trường hợp thiếu tham số
                resp.sendRedirect("orders");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("orders");
        }
    }
}