package controller;

import dal.AddressDAO;
import dal.OrderDAO;
import model.Address;
import model.CartItem;
import model.Order;
import model.OrderItem;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private AddressDAO addressDAO = new AddressDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        // Kiểm tra đăng nhập
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // Kiểm tra giỏ hàng - ưu tiên buyNowCart nếu đang trong chế độ "Mua ngay"
        @SuppressWarnings("unchecked")
        List<CartItem> cart;
        Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");
        
        // Kiểm tra xem có buyNowCart hợp lệ không
        List<CartItem> buyNowCart = (List<CartItem>) session.getAttribute("buyNowCart");
        
        if (isBuyNow != null && isBuyNow && buyNowCart != null && !buyNowCart.isEmpty()) {
            // Dùng buyNowCart nếu có và hợp lệ
            cart = buyNowCart;
        } else {
            // Nếu không có buyNowCart hợp lệ, clear flags và dùng cart thông thường
            session.removeAttribute("isBuyNow");
            session.removeAttribute("buyNowCart");
            cart = (List<CartItem>) session.getAttribute("cart");
        }

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        // Lấy danh sách địa chỉ của user
        List<Address> addresses = addressDAO.getAddressesByUserId(user.getId());
        
        // Nếu không có địa chỉ → redirect đến trang addresses
        if (addresses == null || addresses.isEmpty()) {
            session.setAttribute("checkoutMessage", "Vui lòng thêm địa chỉ giao hàng trước khi thanh toán.");
            session.setAttribute("returnToCheckout", true); // Lưu flag để quay lại checkout sau khi thêm địa chỉ
            resp.sendRedirect(req.getContextPath() + "/addresses");
            return;
        }
        
        req.setAttribute("addresses", addresses);
        req.setAttribute("user", user);

        // Tính toán với giá đã có deal
        double totalProducts = 0;
        double totalOriginalPrice = 0; // Tổng giá gốc (chưa giảm)
        for (CartItem item : cart) {
            totalProducts += item.getFinalPrice().doubleValue() * item.getQuantity();
            totalOriginalPrice += item.getOriginalPrice().doubleValue() * item.getQuantity();
        }

        double shippingFee = 30000; // Phí ship cố định
        double discount = 0; // Giảm giá từ coupon (nếu có)
        double finalAmount = totalProducts + shippingFee - discount;

        // Debug
        System.out.println("=== CHECKOUT DEBUG ===");
        System.out.println("Total Products (after discount): " + totalProducts);
        System.out.println("Total Original Price: " + totalOriginalPrice);
        System.out.println("Shipping Fee: " + shippingFee);
        System.out.println("Discount: " + discount);
        System.out.println("Final Amount: " + finalAmount);
        System.out.println("Cart size: " + cart.size());
        System.out.println("Addresses size: " + addresses.size());

        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("totalOriginalPrice", totalOriginalPrice);
        req.setAttribute("shippingFee", shippingFee);
        req.setAttribute("discount", discount);
        req.setAttribute("finalAmount", finalAmount);

        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        // Kiểm tra đăng nhập
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Lấy thông tin từ form
        String addressIdStr = req.getParameter("addressId");
        String fullname;
        String phone;
        String address;
        
        // Nếu chọn địa chỉ có sẵn
        if (addressIdStr != null && !addressIdStr.isEmpty()) {
            int addressId = Integer.parseInt(addressIdStr);
            Address selectedAddress = addressDAO.getAddressById(addressId);
            if (selectedAddress != null && selectedAddress.getUserId() == user.getId()) {
                fullname = selectedAddress.getReceiverName();
                phone = selectedAddress.getPhoneNumber();
                address = selectedAddress.getAddress() + ", " + selectedAddress.getCity();
            } else {
                fullname = req.getParameter("fullname");
                phone = req.getParameter("phone");
                address = req.getParameter("address");
            }
        } else {
            fullname = req.getParameter("fullname");
            phone = req.getParameter("phone");
            address = req.getParameter("address");
        }
        
        String note = req.getParameter("note");
        String paymentMethod = req.getParameter("paymentMethod");

        // Validate
        if (fullname == null || fullname.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            address == null || address.trim().isEmpty() ||
            paymentMethod == null) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            doGet(req, resp);
            return;
        }

        // Lấy giỏ hàng - ưu tiên buyNowCart nếu đang trong chế độ "Mua ngay"
        @SuppressWarnings("unchecked")
        List<CartItem> cart;
        Boolean isBuyNow = (Boolean) session.getAttribute("isBuyNow");
        
        // Kiểm tra xem có buyNowCart hợp lệ không
        List<CartItem> buyNowCart = (List<CartItem>) session.getAttribute("buyNowCart");
        
        if (isBuyNow != null && isBuyNow && buyNowCart != null && !buyNowCart.isEmpty()) {
            // Dùng buyNowCart nếu có và hợp lệ
            cart = buyNowCart;
        } else {
            // Nếu không có buyNowCart hợp lệ, clear flags và dùng cart thông thường
            session.removeAttribute("isBuyNow");
            session.removeAttribute("buyNowCart");
            cart = (List<CartItem>) session.getAttribute("cart");
        }

        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart.jsp");
            return;
        }

        try {
            // Tính toán với giá đã có deal trong cart
            double totalProducts = 0;
            for (CartItem item : cart) {
                totalProducts += item.getFinalPrice().doubleValue() * item.getQuantity();
            }

            double shippingFee = 30000;
            double discount = 0;
            double finalAmount = totalProducts + shippingFee - discount;

            // Tạo Order
            Order order = new Order();
            order.setUserId(user.getId());
            order.setCouponId(null); // Không dùng coupon nữa
            order.setFullname(fullname);
            order.setPhone(phone);
            order.setAddress(address);
            order.setNote(note);
            order.setTotalProductsMoney(totalProducts);
            order.setShippingFee(shippingFee);
            order.setDiscountAmount(discount);
            order.setFinalAmount(finalAmount);
            order.setPaymentMethod(paymentMethod);
            order.setPaymentStatus(0); // Chưa thanh toán
            order.setStatus("pending"); // Chờ xác nhận

            // Lưu vào database
            int orderId = orderDAO.createOrder(order);

            if (orderId > 0) {
                // Tạo OrderItems với thông tin DEAL
                List<OrderItem> orderItems = new ArrayList<>();
                for (CartItem cartItem : cart) {
                    OrderItem item = new OrderItem();
                    item.setOrderId(orderId);
                    item.setProductId(cartItem.getProduct().getId());
                    item.setProductName(cartItem.getProduct().getName());
                    
                    // LƯU THÔNG TIN DEAL
                    item.setDealType(cartItem.getDealType());
                    item.setDealId(cartItem.getDealId());
                    item.setOriginalPrice(cartItem.getOriginalPrice());
                    item.setDiscountAmount(cartItem.getDiscountAmount());
                    item.setFinalPrice(cartItem.getFinalPrice());
                    
                    item.setQuantity(cartItem.getQuantity());
                    item.setTotal(cartItem.getTotalPrice());
                    orderItems.add(item);
                }

                // Lưu OrderItems
                orderDAO.addOrderDetails(orderId, orderItems);

                // Xóa giỏ hàng hoặc buyNowCart tùy vào chế độ
                if (isBuyNow != null && isBuyNow) {
                    session.removeAttribute("buyNowCart");
                    session.removeAttribute("isBuyNow");
                } else {
                    session.removeAttribute("cart");
                }
                
                // Xóa badge và tổng tiền
                session.removeAttribute("size");
                session.removeAttribute("totalMoney");

                // Chuyển đến trang thành công
                session.setAttribute("successMessage", "Đặt hàng thành công! Mã đơn hàng: #" + orderId);
                resp.sendRedirect(req.getContextPath() + "/order-detail?id=" + orderId);
            } else {
                req.setAttribute("error", "Có lỗi xảy ra khi tạo đơn hàng!");
                doGet(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            doGet(req, resp);
        }
    }
}
