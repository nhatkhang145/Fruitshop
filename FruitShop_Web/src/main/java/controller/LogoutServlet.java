package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy phiên làm việc hiện tại (Session)
        // tham số false nghĩa là: Nếu chưa có session thì đừng tạo mới
        HttpSession session = request.getSession(false);

        // 2. Nếu session tồn tại -> Xóa nó đi (Hủy phiên đăng nhập)
        if (session != null) {
            session.invalidate();
        }

        // 3. Chuyển hướng người dùng về trang chủ hoặc trang đăng nhập
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}