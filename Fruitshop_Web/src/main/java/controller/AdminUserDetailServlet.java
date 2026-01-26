package controller;

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

// Đường dẫn URL khớp với action trong form JSP
@WebServlet(name = "AdminUserDetailServlet", urlPatterns = {"/admin/user-detail"})
public class AdminUserDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Lấy ID từ tham số URL (ví dụ: /user-detail?id=5)
            String idStr = request.getParameter("id");

            // Kiểm tra nếu không có ID thì quay về trang danh sách
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect("users");
                return;
            }

            int userId = Integer.parseInt(idStr);
            UserDAO userDAO = new UserDAO();

            // 2. Lấy thông tin User
            User user = userDAO.getUserById(userId);

            // Nếu không tìm thấy user (id sai), quay về danh sách
            if (user == null) {
                response.sendRedirect("users");
                return;
            }

            // 3. Lấy danh sách địa chỉ của User này (Dùng hàm mới thêm ở bước 1)
            List<Address> addresses = userDAO.getAllAddressesByUserId(userId);

            // 4. Đẩy dữ liệu sang JSP
            request.setAttribute("user", user);
            request.setAttribute("addresses", addresses);

            // Forward về trang JSP
            request.getRequestDispatcher("/admin/user-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            // Xử lý trường hợp ID không phải là số
            response.sendRedirect("users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Lấy dữ liệu từ Form
            int userId = Integer.parseInt(request.getParameter("id"));
            int role = Integer.parseInt(request.getParameter("role"));

            // JSP gửi về "active" hoặc "banned"
            String statusRaw = request.getParameter("status");

            // 2. Xử lý Logic Status
            // Database của bạn lưu status là int (1: active, 0: banned/inactive)
            // Nhưng hàm DAO updateUserStatusAndRole nhận tham số String status.
            // Tùy vào cấu trúc DB, ta cần gửi chuỗi "1" hoặc "0"
            String statusToDb = "1"; // Mặc định là active
            if ("banned".equals(statusRaw)) {
                statusToDb = "0";
            } else if ("active".equals(statusRaw)) {
                statusToDb = "1";
            }

            // 3. Gọi DAO để update
            UserDAO userDAO = new UserDAO();
            boolean isUpdated = userDAO.updateUserStatusAndRole(userId, role, statusToDb);

            // 4. Điều hướng sau khi update
            if (isUpdated) {
                // Thành công: Load lại trang chi tiết để thấy thay đổi
                // Dùng sendRedirect để tránh lỗi resubmit form khi F5
                response.sendRedirect("user-detail?id=" + userId + "&msg=success");
            } else {
                // Thất bại
                response.sendRedirect("user-detail?id=" + userId + "&msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("users");
        }
    }
}