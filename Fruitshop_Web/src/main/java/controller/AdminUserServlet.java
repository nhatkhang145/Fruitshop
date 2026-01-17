package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUserServlet", urlPatterns = {"/admin/users"})
public class AdminUserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Lấy danh sách user từ Database
        List<User> list = userDAO.getAllUsers();

        // 2. Đẩy dữ liệu sang JSP
        req.setAttribute("users", list);

        // 3. Hiển thị trang giao diện
        req.getRequestDispatcher("/admin/users.jsp").forward(req, resp);
    }
}