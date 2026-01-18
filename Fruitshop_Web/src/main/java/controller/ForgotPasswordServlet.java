package controller;

import dal.UserDAO;
import model.User;
import utils.EmailUtils;
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
            String otp = EmailUtils.getRandom();

            // Tạo User tạm để gửi mail (chỉ cần set Email)
            User user = new User();
            user.setEmail(email);

            boolean isSent = EmailUtils.sendEmail(user, otp);

            if (isSent) {
                HttpSession session = request.getSession();
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);
                session.setAttribute("otpCreationTime", System.currentTimeMillis());

                // Chuyển sang trang nhập OTP
                response.sendRedirect("OTP.jsp");
            } else {
                request.setAttribute("error", "Lỗi gửi mail. Vui lòng thử lại.");
                request.getRequestDispatcher("forget_pass.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Email không tồn tại trong hệ thống.");
            request.getRequestDispatcher("forget_pass.jsp").forward(request, response);
        }
    }
}