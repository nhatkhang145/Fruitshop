package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/resetPassword"})
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPass = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("forget_pass.jsp");
            return;
        }

        if (newPass.equals(confirmPass)) {
            UserDAO userDAO = new UserDAO();
            // Cập nhật mật khẩu mới vào DB
            userDAO.updatePasswordByEmail(email, newPass);

            // Xóa session OTP để bảo mật
            session.removeAttribute("otp");
            session.removeAttribute("email");

            // Chuyển về trang login
            request.setAttribute("mess", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("reset_pass.jsp").forward(request, response);
        }
    }
}