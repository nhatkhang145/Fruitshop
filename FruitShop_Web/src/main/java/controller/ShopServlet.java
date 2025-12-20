package controller;

import dal.ProductDAO;
import model.Product;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Khai báo đường dẫn URL cho Servlet này là /shop
@WebServlet(name = "ShopServlet", urlPatterns = {"/shop"})
public class ShopServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Khởi tạo DAO
        ProductDAO dao = new ProductDAO();

        // 2. Nhận các tham số từ URL
        String cid_raw = request.getParameter("cid");   // Lấy mã danh mục (nếu có)
        String index_raw = request.getParameter("index"); // Lấy số trang (nếu có)

        // Xử lý số trang (nếu không truyền index thì mặc định là trang 1)
        int index = 1;
        if (index_raw != null) {
            index = Integer.parseInt(index_raw);
        }

        List<Product> listP; // List chứa sản phẩm sẽ gửi sang JSP

        // 3. Xử lý Logic: Phân biệt xem người dùng đang Lọc hay đang Phân trang
        if (cid_raw != null) {
            // == TRƯỜNG HỢP 1: LỌC THEO DANH MỤC (có cid) ==
            int cid = Integer.parseInt(cid_raw);
            listP = dao.getProductsByCategoryID(cid);

            // Đánh dấu để bên JSP biết đang chọn danh mục nào (để active menu)
            request.setAttribute("tag", cid);
        } else {
            // == TRƯỜNG HỢP 2: KHÔNG CHỌN DANH MỤC (Xem tất cả + Phân trang) ==

            // a. Lấy danh sách sản phẩm theo trang (Mỗi trang 6 món)
            listP = dao.pagingProduct(index);

            // b. Tính toán tổng số trang (để hiển thị nút 1, 2, 3...)
            int count = dao.countAll(); // Đếm tổng sản phẩm trong DB
            int pageSize = 6;           // Số lượng sản phẩm mỗi trang
            int endPage = count / pageSize;
            if (count % pageSize != 0) {
                endPage++; // Nếu chia dư thì cộng thêm 1 trang
            }

            // Gửi số trang cuối cùng sang JSP để vòng lặp for chạy nút
            request.setAttribute("endP", endPage);
        }

        // 4. Gửi dữ liệu sang trang shop.jsp
        request.setAttribute("listP", listP); // List sản phẩm
        request.setAttribute("index", index); // Trang hiện tại (để active nút phân trang)

        // Chuyển hướng
        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu có xử lý form tìm kiếm hoặc gì đó thì viết ở đây, tạm thời doGet là đủ
        doGet(request, response);
    }
}