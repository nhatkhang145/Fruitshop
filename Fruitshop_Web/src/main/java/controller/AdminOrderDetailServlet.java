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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. Lấy ID đơn hàng (vẫn là số)
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            // 2. Lấy Status là CHUỖI (Sửa dòng này)
            // CŨ (Sai): int status = Integer.parseInt(request.getParameter("status"));
            // MỚI (Đúng):
            String status = request.getParameter("status");

            // 3. Gọi hàm update trong DAO
            OrderDAO orderDAO = new OrderDAO();

            // Lưu ý: Gọi hàm updateOrderStatus (nhận String) chứ không phải updateStatus (nhận int)
            boolean isUpdated = orderDAO.updateOrderStatus(orderId, status);

            if (isUpdated) {
                // Cập nhật thành công, load lại trang chi tiết
                response.sendRedirect("order-detail?id=" + orderId + "&msg=success");
            } else {
                response.sendRedirect("order-detail?id=" + orderId + "&msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("orders"); // Hoặc trang lỗi
        }
    }
}