package controller;

import dal.UserDAO;
import model.User;
import util.PasswordUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/change-password"})
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("account");

        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String oldPass = request.getParameter("old_pass");
        String newPass = request.getParameter("new_pass");
        String renewPass = request.getParameter("renew_pass");

        // Mã hóa mật khẩu cũ để so sánh
        String hashedOldPass = PasswordUtils.hashMD5(oldPass);
        
        // Mật khẩu cũ có đúng không?
        if (!hashedOldPass.equals(u.getPassword())) {
            request.setAttribute("error", "Mật khẩu cũ không đúng!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // Validate mật khẩu mới
        String passwordError = PasswordUtils.getPasswordValidationMessage(newPass);
        if (passwordError != null) {
            request.setAttribute("error", passwordError);
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // Mật khẩu mới có khớp nhập lại không?
        if (!newPass.equals(renewPass)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // Không cho trùng mật khẩu cũ
        if (newPass.equals(oldPass)) {
            request.setAttribute("error", "Mật khẩu mới không được trùng mật khẩu cũ!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // Mã hóa mật khẩu mới
        String hashedNewPass = PasswordUtils.hashMD5(newPass);

        UserDAO dao = new UserDAO();
        dao.changePassword(u.getId(), hashedNewPass);

        // Cập nhật lại pass trong session
        u.setPassword(hashedNewPass);
        session.setAttribute("account", u);

        request.setAttribute("mess", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }
}