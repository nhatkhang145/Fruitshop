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
            String subject = "Mã OTP mới - Xác thực đăng ký";
            String body = "<!DOCTYPE html>" +
                "<html><head><style>" +
                "body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }" +
                ".container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }" +
                ".header { text-align: center; color: #4CAF50; margin-bottom: 20px; }" +
                ".otp-code { font-size: 36px; font-weight: bold; color: #4CAF50; text-align: center; " +
                "           padding: 25px; background: #f0f0f0; border-radius: 8px; margin: 25px 0; letter-spacing: 8px; }" +
                ".note { color: #666; font-size: 14px; margin-top: 20px; line-height: 1.6; }" +
                ".footer { text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; color: #999; font-size: 12px; }" +
                "</style></head><body>" +
                "<div class='container'>" +
                "  <h2 class='header'>🔄 Mã OTP mới</h2>" +
                "  <p>Xin chào <strong>" + fullname + "</strong>,</p>" +
                "  <p>Đây là mã OTP mới của bạn:</p>" +
                "  <div class='otp-code'>" + otp + "</div>" +
                "  <p class='note'>⏰ Mã OTP có hiệu lực trong <strong>5 phút</strong>.</p>" +
                "  <div class='footer'>© 2026 Organic Harvest. All rights reserved.</div>" +
                "</div></body></html>";

            EmailUtils.sendEmail(email, subject, body);

            // Cập nhật session
            session.setAttribute("registerOTP", otp);
            session.setAttribute("otpExpiry", System.currentTimeMillis() + 5 * 60 * 1000); // 5 phút

            request.setAttribute("success", "✅ Mã OTP mới đã được gửi đến email của bạn!");
            request.getRequestDispatcher("register-verify-otp.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể gửi lại OTP. Vui lòng thử lại!");
            request.getRequestDispatcher("register-verify-otp.jsp").forward(request, response);
        }
    }
}
