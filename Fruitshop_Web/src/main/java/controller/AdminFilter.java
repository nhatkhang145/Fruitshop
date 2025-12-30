package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import java.io.IOException;

// @WebFilter: Khai báo đây là Filter
// urlPatterns = {"/admin/*"}: Chặn tất cả mọi đường dẫn bắt đầu bằng /admin/
@WebFilter(filterName = "AdminFilter", urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        // 1. Ép kiểu về HttpServlet để dùng được Session và SendRedirect
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        HttpSession session = request.getSession();

        // 2. Lấy thông tin người dùng từ Session
        // "account" là cái tên bạn đã đặt trong LoginServlet
        User user = (User) session.getAttribute("account");

        // 3. XỬ LÝ LOGIC BẢO MẬT
        if (user == null) {
            // TRƯỜNG HỢP 1: Chưa đăng nhập
            // -> Đá về trang Login
            response.sendRedirect(request.getContextPath() + "/login.jsp");

        } else if (user.getRole() != 1) {
            // TRƯỜNG HỢP 2: Đã đăng nhập nhưng KHÔNG PHẢI ADMIN
            // (Giả sử role 1 là Admin, các số khác là khách)
            // -> Đá về trang chủ
            response.sendRedirect(request.getContextPath() + "/index.jsp");

        } else {
            // TRƯỜNG HỢP 3: Đã đăng nhập và ĐÚNG LÀ ADMIN (Role == 1)
            // -> Cho phép đi tiếp (Mở cửa)
            chain.doFilter(req, resp);
        }
    }

    // Các hàm này để mặc định, không cần viết gì
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}