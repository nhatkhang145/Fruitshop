package controller;

import dal.ProductDAO;
import dal.WeekendDealDAO;
import model.CartItem;
import model.Product;
import model.WeekendDeal;
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

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/add-to-cart"})
public class AddToCartServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // 1. Lấy tham số từ form hoặc URL
        String pidRaw = request.getParameter("pid");
        String quantityRaw = request.getParameter("quantity");
        String action = request.getParameter("btAction");

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
            WeekendDealDAO dealDAO = new WeekendDealDAO();
            
            Product product = pDao.getProductByID(pid);

            if (product != null) {
                // === TÍNH GIÁ VỚI WEEKEND DEAL ===
                BigDecimal originalPrice = BigDecimal.valueOf(product.getPrice());
                BigDecimal finalPrice = originalPrice;
                BigDecimal discountAmount = BigDecimal.ZERO;
                String dealType = null;
                Integer dealId = null;
                
                // Ưu tiên 1: Check weekend deal
                WeekendDeal weekendDeal = dealDAO.getActiveDealByProductId(pid);
                if (weekendDeal != null && weekendDeal.isActive()) {
                    dealType = "weekend";
                    dealId = weekendDeal.getId();
                    finalPrice = java.math.BigDecimal.valueOf(weekendDeal.getDiscountedPrice());
                    discountAmount = originalPrice.subtract(finalPrice);
                }
                // Ưu tiên 2: Nếu không có weekend deal, dùng sale_price
                else if (product.getSalePrice() > 0) {
                    dealType = "sale";
                    finalPrice = java.math.BigDecimal.valueOf(product.getSalePrice());
                    discountAmount = originalPrice.subtract(finalPrice);
                }
                
                HttpSession session = request.getSession();
                
                // === KIỂM TRA NẾU LÀ "MUA NGAY" ===
                if ("buy".equals(action)) {
                    // Nếu nhấn "Mua ngay", tạo giỏ hàng riêng chỉ có sản phẩm này
                    List<CartItem> buyNowCart = new ArrayList<>();
                    CartItem buyNowItem = new CartItem(product, quantity);
                    buyNowItem.setOriginalPrice(originalPrice);
                    buyNowItem.setDiscountAmount(discountAmount);
                    buyNowItem.setFinalPrice(finalPrice);
                    buyNowItem.setDealType(dealType);
                    buyNowItem.setDealId(dealId);
                    buyNowCart.add(buyNowItem);
                    
                    // Lưu vào session với key riêng
                    session.setAttribute("buyNowCart", buyNowCart);
                    session.setAttribute("isBuyNow", true);
                    
                    // Tính tổng tiền cho buyNow (không cập nhật badge "size")
                    BigDecimal buyNowTotal = buyNowItem.getTotalPrice();
                    session.setAttribute("totalMoney", buyNowTotal.doubleValue());
                    
                    System.out.println("=== Buy Now ===");
                    System.out.println("Product: " + product.getName() + " x " + quantity);
                    System.out.println("Total: " + buyNowTotal);
                    
                    // Redirect đến checkout servlet (không phải JSP) để load addresses
                    response.sendRedirect("checkout");
                    return;
                }
                
                // === LOGIC THÊM VÀO GIỎ HÀNG BÌNH THƯỜNG ===
                // Xóa flag buyNow nếu có
                session.removeAttribute("isBuyNow");
                session.removeAttribute("buyNowCart");
                
                // 2. Lấy giỏ hàng từ session
                List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                if (cart == null) {
                    cart = new ArrayList<>(); // Nếu chưa có thì tạo mới
                }

                // 3. Kiểm tra sản phẩm đã có trong giỏ chưa
                boolean found = false;
                for (CartItem item : cart) {
                    if (item.getProduct().getId() == pid) {
                        // Nếu có rồi thì cộng dồn số lượng (giữ nguyên giá deal cũ)
                        item.setQuantity(item.getQuantity() + quantity);
                        found = true;
                        break;
                    }
                }

                // Nếu chưa có thì thêm mới vào list với thông tin deal
                if (!found) {
                    CartItem newItem = new CartItem(product, quantity);
                    newItem.setOriginalPrice(originalPrice);
                    newItem.setDiscountAmount(discountAmount);
                    newItem.setFinalPrice(finalPrice);
                    newItem.setDealType(dealType);
                    newItem.setDealId(dealId);
                    cart.add(newItem);
                }

                // 4. Lưu lại giỏ hàng vào session
                session.setAttribute("cart", cart);

                // Tính tổng tiền toàn bộ giỏ hàng
                BigDecimal totalMoney = BigDecimal.ZERO;
                int totalQuantity = 0;
                for (CartItem item : cart) {
                    totalMoney = totalMoney.add(item.getTotalPrice());
                    totalQuantity += item.getQuantity();
                }
                session.setAttribute("totalMoney", totalMoney.doubleValue());

                // Đếm TỔNG SỐ LƯỢNG tất cả sản phẩm (theo số lượng, không phải số loại)
                session.setAttribute("size", totalQuantity);
                
                // Debug log
                System.out.println("=== AddToCart Debug ===");
                System.out.println("Product ID: " + pid + ", Quantity added: " + quantity);
                System.out.println("Total items quantity: " + totalQuantity);
                for (CartItem item : cart) {
                    System.out.println("  - Product #" + item.getProduct().getId() + " x " + item.getQuantity());
                }
                System.out.println("=======================");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Kiểm tra nếu là AJAX request (từ JavaScript)
        String ajaxHeader = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(ajaxHeader)) {
            // Trả về response JSON cho AJAX
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"success\": true, \"message\": \"Đã thêm vào giỏ hàng\"}");
            return;
        }
        
        // Nếu nhấn "Thêm vào giỏ" -> Quay lại trang hiện tại
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