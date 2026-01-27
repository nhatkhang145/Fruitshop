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
@WebServlet(name = "AdminUserDetailServlet", urlPatterns = { "/admin/user-detail" })
public class AdminUserDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");

            // 1. Lấy dữ liệu từ Form
            int userId = Integer.parseInt(request.getParameter("id"));
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String birthDateStr = request.getParameter("birthDate");
            int role = Integer.parseInt(request.getParameter("role"));

            // JSP gửi về "active" hoặc "banned"
            String statusRaw = request.getParameter("status");

            // 2. Xử lý Logic Status
            // Database của bạn lưu status là int (1: active, 0: banned/inactive)
            String statusToDb = "1"; // Mặc định là active
            if ("banned".equals(statusRaw)) {
                statusToDb = "0";
            } else if ("active".equals(statusRaw)) {
                statusToDb = "1";
            }

            // 3. Cập nhật User object
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);

            if (user != null) {
                user.setFullName(fullName);
                user.setPhone(phone);
                user.setGender(gender);

                // Parse birthDate từ format yyyy-MM-dd
                if (birthDateStr != null && !birthDateStr.isEmpty()) {
                    try {
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date utilDate = sdf.parse(birthDateStr);
                        java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                        user.setBirthDate(sqlDate);
                    } catch (Exception e) {
                        // Nếu parse lỗi, giữ nguyên giá trị cũ
                    }
                }

                // Gọi DAO để update toàn bộ thông tin cá nhân
                userDAO.updateProfile(user);

                // Cập nhật role và status
                userDAO.updateUserStatusAndRole(userId, role, statusToDb);

                // Điều hướng về trang chi tiết với thông báo thành công
                response.sendRedirect("user-detail?id=" + userId + "&msg=success");
            } else {
                response.sendRedirect("users");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("users");
        }
    }
}