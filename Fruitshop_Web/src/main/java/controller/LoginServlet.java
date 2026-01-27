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

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Form gửi name="user" nhưng ta coi đó là Email
        String email = request.getParameter("user");
        String pass = request.getParameter("pass");

        // Mã hóa mật khẩu để so sánh với database
        String hashedPassword = PasswordUtils.hashMD5(pass);

        UserDAO dao = new UserDAO();
        User account = dao.checkLogin(email, hashedPassword);

        if (account == null) {
            // Kiểm tra xem email có tồn tại không
            User existingUser = dao.getUserByEmail(email);
            
            if (existingUser != null && "google".equals(existingUser.getLoginType())) {
                // Email tồn tại nhưng đã được liên kết với Google
                request.setAttribute("error", "Tài khoản này đã được liên kết với Google. Vui lòng đăng nhập bằng nút 'Đăng nhập với Google'!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            
            // Email không tồn tại hoặc mật khẩu sai
            request.setAttribute("error", "Email hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            
            // Load số lượng wishlist từ database vào session
            dal.WishlistDAO wishlistDAO = new dal.WishlistDAO();
            int wishlistCount = wishlistDAO.countWishlist(account.getId());
            session.setAttribute("wishlistCount", wishlistCount);
            
            // Kiểm tra quyền: Nếu Role = 1 (Admin) thì vào trang quản trị
            if (account.getRole() == 1) {
                response.sendRedirect("admin/index.jsp");
            } else {
                // Nếu là khách bình thường thì về trang chủ
                response.sendRedirect(request.getContextPath() + "/");
            }
        }
    }
}