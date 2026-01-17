package controller;

import dal.ProductDAO;
import dal.CategoryDAO;
import dal.WishlistDAO;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.Category;
import java.io.IOException;
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

        String indexPage = request.getParameter("index");
        String categoryId = request.getParameter("cid");
        String searchKeyword = request.getParameter("q");

        List<Product> listP;

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
        // Priority 2: Lọc theo danh mục từ sidebar
        else if (categoryId != null && !categoryId.isEmpty()) {
            // Case B: Lọc theo Danh mục
            int cid = Integer.parseInt(categoryId);
            listP = pDao.getProductsByCategoryID(cid);
            request.setAttribute("tag", cid);
        } 
        // Priority 3: Hiển thị bình thường với phân trang
        else {
            // Case C: Trang Shop bình thường (Phân trang)
            if (indexPage == null) {
                indexPage = "1";
            }
            int index = Integer.parseInt(indexPage);

            // Tính toán số trang (Pagination)
            int count = pDao.countAll();
            int endPage = count / 6;
            if (count % 6 != 0) {
                endPage++;
            }

            listP = pDao.pagingProduct(index);
            request.setAttribute("endP", endPage);
            request.setAttribute("tag", index);
        }

        // Lấy danh sách sản phẩm đã thích
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account"); // Lấy user hiện tại

        if (user != null) {
            WishlistDAO wDao = new WishlistDAO();
            // Gọi hàm getLikedProductIds bạn đã viết trong WishlistDAO
            List<Integer> likedIds = wDao.getLikedProductIds(user.getId());

            // Gửi list ID này sang JSP
            request.setAttribute("likedIds", likedIds);
        }

        // 3. Gửi dữ liệu về JSP
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