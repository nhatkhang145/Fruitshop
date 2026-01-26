package controller;

import dal.UserDAO;
import model.User;
import util.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO userDAO = new UserDAO();

        if (userDAO.checkExist(email)) {
            // Email tồn tại -> Sinh OTP và gửi
            String otp = String.format("%06d", (int)(Math.random() * 1000000));

            // Lấy thông tin user để lấy fullname
            User user = userDAO.getUserByEmail(email);
            String fullname = (user != null && user.getFullName() != null) ? user.getFullName() : "Khách hàng";

            try {
                EmailUtils.sendOTPEmail(email, fullname, otp, "forgot-password");
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("otpExpiry", System.currentTimeMillis() + 5 * 60 * 1000);
                session.setAttribute("emailReset", email);
                session.setAttribute("otpType", "forgot-password");
                session.setAttribute("otpEmail", email);
                session.setMaxInactiveInterval(300);

                // Chuyển sang trang nhập OTP chung
                response.sendRedirect("verify-otp.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Không thể gửi email. Vui lòng thử lại!");
                request.getRequestDispatcher("forget_pass.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("forget_pass.jsp").forward(request, response);
        }
    }
}