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
        
        // Gửi OTP qua email với template đồng bộ
        try {
            EmailUtils.sendOTPEmail(email, fullname, otp, "register");
            
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
        session.setAttribute("otpType", "register");
        session.setAttribute("otpEmail", email);

        // Redirect đến trang nhập OTP chung
        response.sendRedirect("verify-otp.jsp");
    }

}