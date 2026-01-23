package controller;

import dal.UserDAO;
import util.PasswordUtils;
import util.EmailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullname = request.getParameter("user"); // Form gửi name="user" nhưng ta lưu vào fullname
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String re_pass = request.getParameter("re_pass");

        // Validate input
        if (fullname == null || fullname.trim().isEmpty()) {
            request.setAttribute("registerError", "Tên đăng nhập không được để trống!");
            request.setAttribute("regFullname", fullname);
            request.setAttribute("regEmail", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("registerError", "Email không được để trống!");
            request.setAttribute("regFullname", fullname);
            request.setAttribute("regEmail", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Validate mật khẩu theo yêu cầu mới
        String passwordError = PasswordUtils.getPasswordValidationMessage(pass);
        if (passwordError != null) {
            request.setAttribute("registerError", passwordError);
            request.setAttribute("regFullname", fullname);
            request.setAttribute("regEmail", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (!pass.equals(re_pass)) {
            request.setAttribute("registerError", "Mật khẩu xác nhận không khớp!");
            request.setAttribute("regFullname", fullname);
            request.setAttribute("regEmail", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        // Kiểm tra email đã tồn tại chưa
        if (dao.checkExist(email)) {
            request.setAttribute("registerError", "Email này đã được sử dụng!");
            request.setAttribute("regFullname", fullname);
            request.setAttribute("regEmail", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Generate OTP (6 số)
        String otp = String.format("%06d", (int)(Math.random() * 1000000));
        
        // Gửi OTP qua email
        try {
            String subject = "Xác thực đăng ký tài khoản - Fruitshop";
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
                "  <h2 class='header'>🍎 Xác thực đăng ký tài khoản</h2>" +
                "  <p>Xin chào <strong>" + fullname + "</strong>,</p>" +
                "  <p>Cảm ơn bạn đã đăng ký tài khoản tại <strong>Organic Harvest</strong>. Vui lòng sử dụng mã OTP bên dưới để hoàn tất đăng ký:</p>" +
                "  <div class='otp-code'>" + otp + "</div>" +
                "  <p class='note'>⏰ Mã OTP có hiệu lực trong <strong>5 phút</strong>.</p>" +
                "  <p class='note'>🔒 Nếu bạn không yêu cầu đăng ký, vui lòng bỏ qua email này.</p>" +
                "  <div class='footer'>© 2026 Organic Harvest. All rights reserved.</div>" +
                "</div></body></html>";
            
            EmailUtils.sendEmail(email, subject, body);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("registerError", "Không thể gửi email xác thực. Vui lòng thử lại!");
            request.setAttribute("regFullname", fullname);
            request.setAttribute("regEmail", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Lưu thông tin vào session (chưa lưu vào database)
        HttpSession session = request.getSession();
        session.setAttribute("registerOTP", otp);
        session.setAttribute("otpExpiry", System.currentTimeMillis() + 5 * 60 * 1000); // 5 phút
        session.setAttribute("registerFullname", fullname);
        session.setAttribute("registerEmail", email);
        session.setAttribute("registerPassword", PasswordUtils.hashMD5(pass)); // Lưu đã hash

        // Redirect đến trang nhập OTP
        response.sendRedirect("register-verify-otp.jsp");
    }

}