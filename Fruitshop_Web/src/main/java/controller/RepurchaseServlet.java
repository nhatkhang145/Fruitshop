package controller;

import dal.OrderDAO;
import model.CartItem;
import model.OrderItem;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RepurchaseServlet", urlPatterns = {"/repurchase"})
public class RepurchaseServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy order ID từ request
        String orderIdRaw = request.getParameter("orderId");
        
        if (orderIdRaw == null || orderIdRaw.isEmpty()) {
            response.sendRedirect("orders");
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdRaw);
            OrderDAO orderDAO = new OrderDAO();
            
            // Lấy danh sách chi tiết đơn hàng
            List<OrderItem> orderItems = orderDAO.getOrderDetails(orderId);
            
            if (orderItems == null || orderItems.isEmpty()) {
                response.sendRedirect("orders");
                return;
            }

            // Lấy giỏ hàng hiện tại từ session
            HttpSession session = request.getSession();
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            // Xóa flag buyNow nếu có
            session.removeAttribute("isBuyNow");
            session.removeAttribute("buyNowCart");

            // Thêm tất cả sản phẩm từ order vào giỏ hàng
            for (OrderItem item : orderItems) {
                Product product = item.getProduct();
                int quantityToAdd = item.getQuantity();
                BigDecimal price = BigDecimal.valueOf(item.getPrice());

                // Kiểm tra sản phẩm đã có trong giỏ chưa
                boolean found = false;
                for (CartItem cartItem : cart) {
                    if (cartItem.getProduct().getId() == product.getId()) {
                        // Nếu có rồi thì cộng dồn số lượng
                        cartItem.setQuantity(cartItem.getQuantity() + quantityToAdd);
                        found = true;
                        break;
                    }
                }

                // Nếu chưa có thì thêm mới
                if (!found) {
                    CartItem newItem = new CartItem(product, quantityToAdd);
                    newItem.setFinalPrice(price);
                    newItem.setOriginalPrice(price);
                    newItem.setDiscountAmount(BigDecimal.ZERO);
                    cart.add(newItem);
                }
            }

            // Lưu lại giỏ hàng vào session
            session.setAttribute("cart", cart);

            // Tính tổng tiền toàn bộ giỏ hàng
            BigDecimal totalMoney = BigDecimal.ZERO;
            int totalQuantity = 0;
            for (CartItem item : cart) {
                totalMoney = totalMoney.add(item.getTotalPrice());
                totalQuantity += item.getQuantity();
            }
            session.setAttribute("totalMoney", totalMoney.doubleValue());

            // Đếm số mục (items) trong giỏ hàng
            session.setAttribute("size", cart.size());

            // Debug log
            System.out.println("=== Repurchase Debug ===");
            System.out.println("Order ID: " + orderId);
            System.out.println("Items added to cart: " + orderItems.size());
            System.out.println("Total cart items now: " + cart.size());
            System.out.println("Total quantity: " + totalQuantity);
            System.out.println("========================");

            // Redirect đến trang giỏ hàng
            response.sendRedirect("cart.jsp");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("orders");
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
