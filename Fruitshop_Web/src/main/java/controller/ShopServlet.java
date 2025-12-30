package controller;

import dal.ProductDAO;
import dal.CategoryDAO;
import model.Product;
import model.Category;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"})
public class ShopServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ProductDAO pDao = new ProductDAO();
        CategoryDAO cDao = new CategoryDAO(); // Giả sử bạn đã có CategoryDAO để lấy danh sách danh mục

        String indexPage = request.getParameter("index");
        String categoryId = request.getParameter("cid");

        List<Product> listP;

        // 1. Load danh sách Categories để hiển thị ở Sidebar bên trái (nếu có)
        List<Category> listC = cDao.getAllCategories(); // Bạn cần đảm bảo CategoryDAO có hàm này
        request.setAttribute("listC", listC);

        // 2. Xử lý Logic hiển thị sản phẩm
        if (categoryId != null && !categoryId.isEmpty()) {
            // Case A: Nếu người dùng lọc theo Danh mục
            int cid = Integer.parseInt(categoryId);
            listP = pDao.getProductsByCategoryID(cid);
            request.setAttribute("tag", cid); // Để đánh dấu active category menu
        } else {
            // Case B: Nếu vào trang Shop bình thường (Phân trang)
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
            request.setAttribute("endP", endPage); // Truyền tổng số trang về JSP
            request.setAttribute("tag", index);    // Để đánh dấu trang hiện tại đang active
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