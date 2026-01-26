package controller;

import util.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ResendRegisterOTPServlet", urlPatterns = {"/resend-register-otp"})
public class ResendRegisterOTPServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("registerEmail");
        String fullname = (String) session.getAttribute("registerFullname");

        if (email == null || fullname == null) {
            request.setAttribute("error", "Phiên đăng ký đã hết hạn. Vui lòng đăng ký lại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Generate OTP mới
        String otp = String.format("%06d", (int)(Math.random() * 1000000));

        try {
            EmailUtils.sendOTPEmail(email, fullname, otp, "register");

            // Cập nhật session
            session.setAttribute("registerOTP", otp);
            session.setAttribute("otpExpiry", System.currentTimeMillis() + 5 * 60 * 1000); // 5 phút

            request.setAttribute("success", "✅ Mã OTP mới đã được gửi đến email của bạn!");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể gửi lại OTP. Vui lòng thử lại!");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
        }
    }
}
