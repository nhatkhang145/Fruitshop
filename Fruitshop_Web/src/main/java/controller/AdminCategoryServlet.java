package controller;

import dal.CategoryDAO;
import model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// Map URL khớp với form action trong Categories.jsp và các link xóa
@WebServlet(name = "AdminCategoryServlet", urlPatterns = { "/admin/categories", "/admin/category-servlet",
        "/admin/delete-category" })
public class AdminCategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        switch (action) {
            case "/admin/delete-category":
                deleteCategory(req, resp);
                break;
            case "/admin/categories":
            default:
                listCategories(req, resp);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Xử lý Thêm mới hoặc Cập nhật từ Modal
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action"); // Lấy value từ input hidden name="action"

        if ("add".equals(action)) {
            addCategory(req, resp);
        } else if ("edit".equals(action)) {
            updateCategory(req, resp);
        } else {
            resp.sendRedirect("categories");
        }
    }

    // 1. Hiển thị danh sách danh mục
    private void listCategories(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> list = categoryDAO.getAllCategories();
        List<Category> parentCategories = categoryDAO.getParentCategories();
        req.setAttribute("listC", list);
        req.setAttribute("parentC", parentCategories);
        req.getRequestDispatcher("/admin/Categories.jsp").forward(req, resp);
    }

    // 2. Xóa danh mục
    private void deleteCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            // Cần bổ sung method delete trong CategoryDAO
            categoryDAO.delete(Integer.parseInt(idStr));
        }
        resp.sendRedirect("categories");
    }

    // 3. Thêm danh mục mới
    private void addCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            String name = req.getParameter("name");
            String desc = req.getParameter("description");
            // Kiểm tra null/trống trước khi ép kiểu để tránh lỗi NumberFormatException
            int parentId = Integer.parseInt(req.getParameter("parentId") == null ? "0" : req.getParameter("parentId"));
            int status = Integer.parseInt(req.getParameter("status") == null ? "1" : req.getParameter("status"));

            Category c = new Category();
            c.setName(name);
            c.setDescription(desc);
            c.setParentId(parentId);
            c.setStatus(status);

            categoryDAO.insert(c);

            // Phải dùng đường dẫn tuyệt đối hoặc context path để đảm bảo load lại đúng trang
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/categories?error=1");
        }
    }

    // 4. Cập nhật danh mục
    private void updateCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String desc = req.getParameter("description");
        int parentId = Integer.parseInt(req.getParameter("parentId"));
        int status = Integer.parseInt(req.getParameter("status"));

        Category c = new Category();
        c.setId(id);
        c.setName(name);
        c.setDescription(desc);
        c.setParentId(parentId);
        c.setStatus(status);

        categoryDAO.update(c); // Cần bổ sung method update trong CategoryDAO
        resp.sendRedirect("categories");
    }
}