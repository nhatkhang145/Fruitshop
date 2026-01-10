package controller;

import dal.OrderDAO;
import model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminOrderServlet", urlPatterns = {"/admin/orders"})
public class AdminOrderServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy tất cả đơn hàng (Cần thêm method getAllOrders trong OrderDAO)
        List<Order> list = orderDAO.getAllOrders();

        req.setAttribute("orders", list);
        req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
    }
}