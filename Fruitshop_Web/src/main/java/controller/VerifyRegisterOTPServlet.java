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
import java.sql.Timestamp;

@WebServlet(name = "VerifyRegisterOTPServlet", urlPatterns = {"/verify-register-otp"})
public class VerifyRegisterOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String inputOTP = request.getParameter("otp");
        
        String sessionOTP = (String) session.getAttribute("registerOTP");
        Long otpExpiry = (Long) session.getAttribute("otpExpiry");
        String fullname = (String) session.getAttribute("registerFullname");
        String email = (String) session.getAttribute("registerEmail");
        String hashedPassword = (String) session.getAttribute("registerPassword");

        // 1. Kiểm tra session có đủ dữ liệu không
        if (sessionOTP == null || otpExpiry == null || fullname == null || email == null || hashedPassword == null) {
            request.setAttribute("error", "Phiên đăng ký đã hết hạn. Vui lòng đăng ký lại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // 2. Kiểm tra OTP đã hết hạn chưa
        if (System.currentTimeMillis() > otpExpiry) {
            request.setAttribute("error", "Mã OTP đã hết hạn! Vui lòng yêu cầu gửi lại.");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
            return;
        }

        // 3. Kiểm tra OTP có đúng không
        if (!inputOTP.equals(sessionOTP)) {
            request.setAttribute("error", "Mã OTP không chính xác! Vui lòng thử lại.");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
            return;
        }

        // 4. OTP đúng → Tạo tài khoản trong database
        try {
            UserDAO dao = new UserDAO();
            dao.signup(fullname, email, hashedPassword);

            // 5. Xóa session OTP
            session.removeAttribute("registerOTP");
            session.removeAttribute("otpExpiry");
            session.removeAttribute("registerFullname");
            session.removeAttribute("registerEmail");
            session.removeAttribute("registerPassword");
            session.removeAttribute("otpType");
            session.removeAttribute("otpEmail");

            // 6. Hiển thị thông báo thành công và redirect về login
            session.setAttribute("registerSuccess", "✅ Đăng ký thành công! Vui lòng đăng nhập.");
            response.sendRedirect("login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
        }
    }
}
