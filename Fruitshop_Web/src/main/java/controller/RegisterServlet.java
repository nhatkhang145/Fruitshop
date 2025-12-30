package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
// ... các import giữ nguyên
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
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("registerError", "Email không được để trống!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (pass == null || pass.length() < 6) {
            request.setAttribute("registerError", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (!pass.equals(re_pass)) {
            request.setAttribute("registerError", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        // Kiểm tra email đã tồn tại chưa
        if (dao.checkExist(email)) {
            request.setAttribute("registerError", "Email này đã được sử dụng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        } else {
            dao.signup(fullname, email, pass);
            request.setAttribute("registerSuccess", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}