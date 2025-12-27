package controller;

import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet(name = "UpdateProfileServlet", urlPatterns = {"/update-profile"})
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // Lấy user hiện tại từ Session
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Lấy dữ liệu mới từ Form
        req.setCharacterEncoding("UTF-8");
        String newName = req.getParameter("fullname");
        String newPhone = req.getParameter("phone");

        // Cập nhật vào user hiện tại
        user.setFullName(newName);
        user.setPhone(newPhone);

        UserDAO dao = new UserDAO();
        dao.update(user);

        session.setAttribute("account", user);

        req.setAttribute("mess", "Cập nhật thành công!");
        req.getRequestDispatcher("profile.jsp").forward(req, resp);
    }
}
