package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminUserDetailServlet", urlPatterns = {"/admin/user-detail"})
public class AdminUserDetailServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idRaw = req.getParameter("id");

        try {
            int id = Integer.parseInt(idRaw);
            User user = userDAO.getUserById(id); // Hàm này bạn đã thêm ở Giai đoạn 1

            if (user == null) {
                resp.sendRedirect("users"); // Không tìm thấy thì quay lại danh sách
                return;
            }

            req.setAttribute("user", user);
            req.getRequestDispatcher("/admin/user-detail.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Lấy dữ liệu từ form
            int id = Integer.parseInt(req.getParameter("id"));
            int role = Integer.parseInt(req.getParameter("role"));
            String status = req.getParameter("status");

            // 2. Gọi DAO cập nhật
            boolean success = userDAO.updateUserStatusAndRole(id, role, status);

            // 3. Thông báo và điều hướng
            if (success) {
                // Cập nhật thành công -> Quay về trang danh sách
                req.getSession().setAttribute("message", "Cập nhật thành công!");
                resp.sendRedirect("users");
            } else {
                // Thất bại -> Ở lại trang cũ và báo lỗi
                req.setAttribute("error", "Cập nhật thất bại!");
                req.setAttribute("user", userDAO.getUserById(id));
                req.getRequestDispatcher("/admin/user-detail.jsp").forward(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("users");
        }
    }
}