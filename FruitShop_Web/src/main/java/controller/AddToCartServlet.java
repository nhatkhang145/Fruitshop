package controller;

import dal.ProductDAO;
import model.CartItem;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // 1. Lấy tham số từ form hoặc URL
        String pidRaw = request.getParameter("pid");
        String quantityRaw = request.getParameter("quantity");

        // Mặc định số lượng là 1 (nếu add từ trang Shop)
        int quantity = 1;
        try {
            if (quantityRaw != null && !quantityRaw.isEmpty()) {
                quantity = Integer.parseInt(quantityRaw);
                // Đảm bảo số lượng luôn dương
                if(quantity < 1) quantity = 1;
            }

            int pid = Integer.parseInt(pidRaw);
            ProductDAO pDao = new ProductDAO();
            Product product = pDao.getProductByID(pid);

            if (product != null) {
                HttpSession session = request.getSession();
                // 2. Lấy giỏ hàng từ session
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if (cart == null) {
                    cart = new ArrayList<>(); // Nếu chưa có thì tạo mới
                }

                // 3. Kiểm tra sản phẩm đã có trong giỏ chưa
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == pid) {
                        // Nếu có rồi thì cộng dồn số lượng
                        item.setQuantity(item.getQuantity() + quantity);
                        found = true;
                        break;
                    }
                }

                // Nếu chưa có thì thêm mới vào list
                if (!found) {
                    cart.add(new CartItem(product, quantity));
                }

                // 4. Lưu lại giỏ hàng vào session
                session.setAttribute("cart", cart);

                // Tính tổng tiền toàn bộ giỏ hàng (để hiển thị nhanh ở header nếu cần)
                double totalMoney = 0;
                for (CartItem item : cart) {
                    totalMoney += item.getTotalPrice();
                }
                session.setAttribute("totalMoney", totalMoney);

                // Đếm tổng số lượng sản phẩm (để hiện số trên icon giỏ hàng)
                session.setAttribute("size", cart.size());
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // 5. Quay lại trang người dùng vừa đứng (Trang Shop hoặc Trang Chi tiết)
        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("shop");
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