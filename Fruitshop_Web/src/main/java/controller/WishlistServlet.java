package controller;

import dal.WishlistDAO;
import model.User;
import model.WishlistItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account"); // Giả sử key session user là "account"

        // 1. Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        WishlistDAO dao = new WishlistDAO();

        if (action == null || action.equals("view")) {
            // --- VIEW: Hiển thị danh sách ---
            List<WishlistItem> list = dao.getWishlistByUserId(user.getId());
            request.setAttribute("wishlist", list);
            request.getRequestDispatcher("wishlist.jsp").forward(request, response);

        } else if (action.equals("add")) {
            // --- ADD: Thêm sản phẩm ---
            String pidStr = request.getParameter("pid");
            if (pidStr != null) {
                int pid = Integer.parseInt(pidStr);
                dao.addToWishlist(user.getId(), pid);
            }
            // Quay lại trang trước đó (ví dụ đang ở Shop thì ở lại Shop)
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "shop");

        } else if (action.equals("remove")) {
            // --- REMOVE: Xóa sản phẩm ---
            String pidStr = request.getParameter("pid");
            if (pidStr != null) {
                int pid = Integer.parseInt(pidStr);
                dao.removeFromWishlist(user.getId(), pid);
            }
            // Load lại trang wishlist
            response.sendRedirect("wishlist");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}