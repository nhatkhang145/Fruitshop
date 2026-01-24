package controller;

import dal.AddressDAO;
import dal.UserDAO;
import model.Address;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminUserDetailServlet", urlPatterns = {"/admin/user-detail"})
public class AdminUserDetailServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idRaw = req.getParameter("id");

        try {
            int id = Integer.parseInt(idRaw);

            // 1. Lấy thông tin User từ Database (DÒNG BẠN BỊ THIẾU)
            User user = userDAO.getUserById(id);

            // Kiểm tra xem user có tồn tại không trước khi làm việc khác
            if (user == null) {
                resp.sendRedirect("users");
                return;
            }

            // 2. Lấy danh sách địa chỉ
            AddressDAO addressDAO = new AddressDAO();
            List<Address> addresses = addressDAO.getAddressesByUserId(id);

            // 3. Đẩy dữ liệu sang JSP
            req.setAttribute("user", user);       // Bây giờ biến 'user' đã được khai báo ở trên nên sẽ hết lỗi
            req.setAttribute("addresses", addresses);

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