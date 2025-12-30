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

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Form gửi name="user" nhưng ta coi đó là Email
        String email = request.getParameter("user");
        String pass = request.getParameter("pass");

        UserDAO dao = new UserDAO();
        User account = dao.checkLogin(email, pass);

       // ... Các đoạn code trên giữ nguyên ...

if (account == null) {
    request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
    request.getRequestDispatcher("login.jsp").forward(request, response);
} else {
    HttpSession session = request.getSession();
    session.setAttribute("account", account);
    
    // --- ĐOẠN CODE CẦN SỬA LÀ ĐÂY ---
    
    // Kiểm tra quyền: Nếu Role = 1 (Admin) thì vào trang quản trị
    if (account.getRole() == 1) {
        response.sendRedirect("admin/index.jsp");
    } else {
        // Nếu là khách bình thường thì về trang chủ
        response.sendRedirect("index.jsp");
    }
    

}
    }

}