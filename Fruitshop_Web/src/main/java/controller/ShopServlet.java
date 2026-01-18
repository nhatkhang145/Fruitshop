package controller;

import dal.ProductDAO;
import dal.CategoryDAO;
import dal.WishlistDAO;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.Category;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"})
public class ShopServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ProductDAO pDao = new ProductDAO();
        CategoryDAO cDao = new CategoryDAO();

        // Lấy các tham số từ request
        String indexPage = request.getParameter("index");
        String categoryId = request.getParameter("cid");
        String searchKeyword = request.getParameter("q");
        String priceRaw = request.getParameter("price");
        String sortRaw = request.getParameter("sort");

        List<Product> listP;
        List<Integer> likedIds = new ArrayList<>();

        // 1. Load danh sách Categories
        List<Category> listC = cDao.getAllCategories();
        request.setAttribute("listC", listC);

        // 2. Xử lý Logic hiển thị sản phẩm

        // Priority 1: Tìm kiếm (có từ khóa)
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Case A: Tìm kiếm sản phẩm theo từ khóa
            listP = pDao.searchProducts(searchKeyword, null);
            request.setAttribute("searchKeyword", searchKeyword);
            request.setAttribute("isSearch", true);
        }
        // Priority 2: Lọc và phân trang (có filter hoặc pagination)
        else {
            // Parse parameters
            int index = (indexPage == null || indexPage.isEmpty()) ? 1 : Integer.parseInt(indexPage);
            Integer cid = (categoryId == null || categoryId.isEmpty()) ? null : Integer.parseInt(categoryId);

            Double minPrice = null, maxPrice = null;
            // Tách chuỗi giá (ví dụ: "100000-500000")
            if (priceRaw != null && !priceRaw.isEmpty()) {
                String[] parts = priceRaw.split("-");
                if (parts.length >= 1) minPrice = Double.parseDouble(parts[0]);
                if (parts.length >= 2 && !parts[1].equals("max")) maxPrice = Double.parseDouble(parts[1]);
            }

            // Tính toán số trang dựa trên filter
            int count = pDao.countProductsByFilter(cid, minPrice, maxPrice);
            int endPage = count / 6;
            if (count % 6 != 0) endPage++;

            // Lấy danh sách sản phẩm (Lọc + Phân trang + Sắp xếp)
            listP = pDao.filterProducts(cid, minPrice, maxPrice, sortRaw, index);

            // Truyền dữ liệu phân trang
            request.setAttribute("endP", endPage);

            // Logic giữ active menu (tag)
            if (cid != null) {
                request.setAttribute("tag", cid);
            } else {
                request.setAttribute("tag", index);
            }

            // Truyền lại các tham số lọc để giao diện hiển thị đúng trạng thái
            request.setAttribute("cid", categoryId);
            request.setAttribute("priceTag", priceRaw);
            request.setAttribute("sortTag", sortRaw);
        }

        // 3. Lấy danh sách sản phẩm đã thích và số lượng wishlist
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user != null) {
            WishlistDAO wDao = new WishlistDAO();
            likedIds = wDao.getLikedProductIds(user.getId());
            // Cập nhật số lượng wishlist vào session
            int wishlistCount = wDao.countWishlist(user.getId());
            session.setAttribute("wishlistCount", wishlistCount);
        } else {
            session.setAttribute("wishlistCount", 0);
        }
        request.setAttribute("likedIds", likedIds);

        // 4. Gửi dữ liệu về JSP
        request.setAttribute("listP", listP);
        request.getRequestDispatcher("shop.jsp").forward(request, response);
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