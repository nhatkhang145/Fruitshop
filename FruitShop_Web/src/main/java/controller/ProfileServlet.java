package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy địa chỉ từ bảng user_addresses để hiển thị lên form (vì trong User object không có)
        UserDAO dao = new UserDAO();
        String currentAddress = dao.getUserAddress(user.getId());

        request.setAttribute("userAddress", currentAddress); // Gửi địa chỉ sang JSP
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Lấy dữ liệu từ Form
        String fullName = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String gender = request.getParameter("gender");
        // Giả sử form chưa có ô nhập Thành phố, ta tạm để mặc định hoặc lấy từ form nếu có
        String city = "Hồ Chí Minh"; // Hoặc request.getParameter("city");

        // 2. Cập nhật Object User (để lưu session)
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setGender(gender);
        // Lưu ý: User.java KHÔNG CÓ setAddress, nên đừng gọi nó ở đây

        UserDAO dao = new UserDAO();
        try {
            // 3. Cập nhật bảng users (Tên, SĐT)
            dao.updateProfile(user);

            // 4. Cập nhật bảng user_addresses (Địa chỉ)
            // Lưu ý: receiver_name tạm lấy là fullname của user
            if (address != null && !address.trim().isEmpty()) {
                dao.updateAddress(user.getId(), address, city, fullName, phone);
            }

            // 5. Lưu lại session
            session.setAttribute("account", user);
            request.setAttribute("message", "Cập nhật thành công!");

            // Gửi lại địa chỉ mới để hiển thị
            request.setAttribute("userAddress", address);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}