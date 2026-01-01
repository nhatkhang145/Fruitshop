package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import model.Category;
import model.Product;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet(name = "AdminProductServlet", urlPatterns = {"/admin/products", "/admin/product-save", "/admin/product-delete", "/admin/product-form"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        switch (action) {
            case "/admin/product-delete":
                deleteProduct(req, resp);
                break;
            case "/admin/product-form":
                showForm(req, resp);
                break;
            case "/admin/products":
            default:
                listProducts(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();
        if ("/admin/product-save".equals(action)) {
            saveProduct(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    // 1. Hiển thị danh sách sản phẩm
    private void listProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Có thể thêm logic phân trang ở đây nếu muốn
        List<Product> list = productDAO.getAllProducts();
        req.setAttribute("products", list);
        req.getRequestDispatcher("/admin/products.jsp").forward(req, resp);
    }

    // 2. Hiển thị Form (Dùng chung cho cả Thêm mới và Sửa)
    private void showForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        Product product = new Product(); // Mặc định là rỗng (thêm mới)

        if (idStr != null && !idStr.isEmpty()) {
            // Nếu có ID -> Là chức năng Sửa (Edit)
            int id = Integer.parseInt(idStr);
            product = productDAO.getProductByID(id);
        }

        // Lấy danh sách danh mục để hiển thị trong <select>
        List<Category> categories = categoryDAO.getAllCategories();

        req.setAttribute("product", product);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/admin/product-edit.jsp").forward(req, resp);
    }

    // 3. Xử lý xóa sản phẩm
    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            productDAO.delete(Integer.parseInt(idStr));
        }
        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }

    // 4. Xử lý Lưu (Thêm mới hoặc Cập nhật)
    private void saveProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8"); // Để nhận tiếng Việt

        // Lấy thông tin từ form
        String idStr = req.getParameter("id"); // Nếu id = 0 hoặc null -> Insert, ngược lại -> Update
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        double salePrice = Double.parseDouble(req.getParameter("salePrice"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        String description = req.getParameter("description");

        // Xử lý upload ảnh
        Part filePart = req.getPart("image");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            // Có chọn file mới
            fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Đường dẫn lưu file (Lưu vào thư mục assets/images trong server)
            String uploadPath = req.getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            filePart.write(uploadPath + File.separator + fileName);

            // Lưu đường dẫn tương đối để lưu vào DB
            fileName = "assets/images/" + fileName;
        } else {
            // Không chọn file mới -> Giữ lại ảnh cũ (được gửi từ input hidden trong form)
            fileName = req.getParameter("currentImage");
        }

        Product p = new Product();
        p.setName(name);
        p.setPrice(price);
        p.setSalePrice(salePrice);
        p.setQuantity(quantity);
        p.setCategoryId(categoryId);
        p.setDescription(description);
        p.setImage(fileName);

        if (idStr == null || idStr.isEmpty() || idStr.equals("0")) {
            // INSERT
            productDAO.insert(p);
        } else {
            // UPDATE
            p.setId(Integer.parseInt(idStr));
            productDAO.update(p);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products");
    }
}