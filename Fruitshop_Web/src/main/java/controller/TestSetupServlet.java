package controller;

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

// Đường dẫn chạy test: http://localhost:8080/FruitShop_Web/test-setup
@WebServlet(name = "TestSetupServlet", urlPatterns = {"/test-setup"})
public class TestSetupServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Tạo danh sách giỏ hàng giả
        List<CartItem> mockCart = new ArrayList<>();

        // 2. Tạo sản phẩm giả bằng cách Set từng thuộc tính (An toàn nhất)

        // --- Sản phẩm 1: Táo ---
        Product p1 = new Product();
        p1.setId(1);
        p1.setName("Táo Envy (Test)");
        p1.setPrice(250000);
        p1.setQuantity(100);
        p1.setDescription("Táo nhập khẩu Mỹ siêu giòn ngọt");
        p1.setImage("https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=200");
        p1.setCategoryId(1);

        // --- Sản phẩm 2: Cam ---
        Product p2 = new Product();
        p2.setId(2);
        p2.setName("Cam Sành (Test)");
        p2.setPrice(35000);
        p2.setQuantity(200);
        p2.setDescription("Cam mọng nước, nhiều vitamin C");
        p2.setImage("https://images.unsplash.com/photo-1611080626919-7cf5a9dbab5b?w=200");
        p2.setCategoryId(2);

        // --- Sản phẩm 3: Nho ---
        Product p3 = new Product();
        p3.setId(3);
        p3.setName("Nho Mẫu Đơn (Test)");
        p3.setPrice(800000);
        p3.setQuantity(50);
        p3.setDescription("Nho xanh chùm to, thơm mùi sữa");
        p3.setImage("https://images.unsplash.com/photo-1596363505729-41905a189512?w=200");
        p3.setCategoryId(1);

        // 3. Thêm vào giỏ hàng giả
        mockCart.add(new CartItem(p1, 2)); // Mua 2 quả Táo
        mockCart.add(new CartItem(p2, 5)); // Mua 5 quả Cam
        mockCart.add(new CartItem(p3, 1)); // Mua 1 chùm Nho

        // 4. Lưu vào Session
        HttpSession session = request.getSession();
        session.setAttribute("cart", mockCart);

        // 5. Tính tổng tiền
        double totalMoney = 0;
        for (CartItem item : mockCart) {
            totalMoney += item.getTotalPrice();
        }
        session.setAttribute("totalMoney", totalMoney);
        session.setAttribute("size", mockCart.size());

        // 6. Chuyển hướng sang trang Giỏ hàng
        response.sendRedirect("cart.jsp");
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