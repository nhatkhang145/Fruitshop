package controller;

import dal.ProductDAO;
import dal.CategoryDAO;
import dal.WishlistDAO;
import dal.WeekendDealDAO;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.Category;
import model.WeekendDeal;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "ShopServlet", urlPatterns = { "/shop" })
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
            // Parse parameters với validation
            int index = 1;
            try {
                if (indexPage != null && !indexPage.isEmpty()) {
                    index = Integer.parseInt(indexPage);
                }
            } catch (NumberFormatException e) {
                index = 1; // Default nếu parse lỗi
            }

            Integer cid = null;
            try {
                if (categoryId != null && !categoryId.isEmpty()) {
                    cid = Integer.parseInt(categoryId);
                }
            } catch (NumberFormatException e) {
                // categoryId không phải số, set null để hiển thị tất cả
                cid = null;
            }

            // Nếu chọn danh mục cha, lấy tất cả category con để filter sản phẩm
            List<Integer> categoryIds = new ArrayList<>();
            if (cid != null) {
                categoryIds = cDao.getCategoryIdsIncludingChildren(cid);
            }

            Double minPrice = null, maxPrice = null;
            // Tách chuỗi giá (ví dụ: "100000-500000")
            if (priceRaw != null && !priceRaw.isEmpty()) {
                String[] parts = priceRaw.split("-");
                if (parts.length >= 1)
                    minPrice = Double.parseDouble(parts[0]);
                if (parts.length >= 2 && !parts[1].equals("max"))
                    maxPrice = Double.parseDouble(parts[1]);
            }

            // Tính toán số trang dựa trên filter
            int count;
            List<Product> listP_temp;

            if (!categoryIds.isEmpty()) {
                // Nếu có danh sách category, dùng method mới
                count = pDao.countProductsByFilterWithCategoryList(categoryIds, minPrice, maxPrice);
                listP_temp = pDao.filterProductsWithCategoryList(categoryIds, minPrice, maxPrice, sortRaw, index);
            } else {
                // Nếu không có category, dùng method cũ
                count = pDao.countProductsByFilter(null, minPrice, maxPrice);
                listP_temp = pDao.filterProducts(null, minPrice, maxPrice, sortRaw, index);
            }

            listP = listP_temp;

            int endPage = count / 6;
            if (count % 6 != 0)
                endPage++;

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

        // 4. Load weekend deals Map cho product cards
        WeekendDealDAO dealDAO = new WeekendDealDAO();
        java.util.Map<Integer, WeekendDeal> weekendDealMap = dealDAO.getActiveDealsByProductIds();
        request.setAttribute("weekendDealMap", weekendDealMap);

        // 5. Gửi dữ liệu về JSP
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