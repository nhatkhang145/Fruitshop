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
        CategoryDAO cDao = new CategoryDAO(); // Giả sử bạn đã có CategoryDAO để lấy danh sách danh mục

        String indexPage = request.getParameter("index");

        List<Product> listP;

        // 1. Load danh sách Categories
        List<Category> listC = cDao.getAllCategories();
        request.setAttribute("listC", listC);

        // 2. Xử lý Logic hiển thị sản phẩm
        String cidRaw = request.getParameter("cid");
        String priceRaw = request.getParameter("price");
        String sortRaw = request.getParameter("sort");

        int index = (indexPage == null || indexPage.isEmpty()) ? 1 : Integer.parseInt(indexPage);
        Integer cid = (cidRaw == null || cidRaw.isEmpty()) ? null : Integer.parseInt(cidRaw);

        Double minPrice = null, maxPrice = null;
        // Tách chuỗi giá (ví dụ: "100000-500000")
        if (priceRaw != null && !priceRaw.isEmpty()) {
            String[] parts = priceRaw.split("-");
            if (parts.length >= 1) minPrice = Double.parseDouble(parts[0]);
            if (parts.length >= 2 && !parts[1].equals("max")) maxPrice = Double.parseDouble(parts[1]);
        }

        // 2. Tính toán Phân trang (Dựa trên kết quả lọc)
        // Gọi hàm countProductsByFilter vừa thêm trong DAO
        int count = pDao.countProductsByFilter(cid, minPrice, maxPrice);
        int endPage = count / 6;
        if (count % 6 != 0) endPage++;

        // 3. Lấy danh sách sản phẩm (Lọc + Phân trang + Sắp xếp)
        // Gọi hàm filterProducts vừa thêm trong DAO
        listP = pDao.filterProducts(cid, minPrice, maxPrice, sortRaw, index);

        // 4. Truyền dữ liệu về JSP
        request.setAttribute("endP", endPage);

        // Logic giữ active menu (tag) của bạn:
        // Nếu có chọn danh mục -> active danh mục, nếu không -> active số trang
        if (cid != null) {
            request.setAttribute("tag", cid);
        } else {
            request.setAttribute("tag", index);
        }

        // Truyền lại các tham số lọc để giao diện hiển thị đúng trạng thái (giữ giá trị trong ô select/checkbox)
        request.setAttribute("cid", cidRaw);
        request.setAttribute("priceTag", priceRaw);
        request.setAttribute("sortTag", sortRaw);

        // Lấy danh sách sản phẩm đã thích
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account"); // Lấy user hiện tại

        if (user != null) {
            WishlistDAO wDao = new WishlistDAO();
            List<Integer> likedIds = wDao.getLikedProductIds(user.getId());
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