package dal;

import model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<Category> getAllCategories() {
        String query = "SELECT id, name, description, parent_id AS parentId, status FROM Categories";

        return DBContext.get().withHandle(handle -> handle.createQuery(query)
                .mapToBean(Category.class)
                .list());
    }

    private static void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null)
                rs.close();
            if (ps != null)
                ps.close();
            if (conn != null)
                conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Thêm vào trong class CategoryDAO
    public void insert(Category c) {
        String sql = "INSERT INTO Categories (name, description, parent_id, status) VALUES (?, ?, ?, ?)";
        DBContext.get().withHandle(handle -> handle.createUpdate(sql)
                .bind(0, c.getName())
                .bind(1, c.getDescription())
                .bind(2, c.getParentId())
                .bind(3, c.getStatus())
                .execute());
    }

    public void update(Category c) {
        String sql = "UPDATE Categories SET name=?, description=?, parent_id=?, status=? WHERE id=?";
        DBContext.get().withHandle(handle -> handle.createUpdate(sql)
                .bind(0, c.getName())
                .bind(1, c.getDescription())
                .bind(2, c.getParentId())
                .bind(3, c.getStatus())
                .bind(4, c.getId())
                .execute());
    }

    public void delete(int id) {
        // Xóa mềm (ẩn đi) hoặc xóa cứng tùy logic của bạn. Ở đây ví dụ xóa cứng.
        String sql = "DELETE FROM Categories WHERE id=?";
        DBContext.get().withHandle(handle -> handle.createUpdate(sql)
                .bind(0, id)
                .execute());
    }

    // Lấy danh sách danh mục con theo parent_id
    public List<Category> getCategoriesByParentId(int parentId) {
        String query = "SELECT id, name, description, parent_id AS parentId, status FROM Categories WHERE parent_id = ?";

        return DBContext.get().withHandle(handle -> handle.createQuery(query)
                .bind(0, parentId)
                .mapToBean(Category.class)
                .list());
    }

    // Lấy chỉ danh mục cha (parent_id = 0)
    public List<Category> getParentCategories() {
        String query = "SELECT id, name, description, parent_id AS parentId, status FROM Categories WHERE parent_id = 0";

        return DBContext.get().withHandle(handle -> handle.createQuery(query)
                .mapToBean(Category.class)
                .list());
    }

    // Lấy tất cả ID của category con (và chính nó nếu là cha) để filter sản phẩm
    public List<Integer> getCategoryIdsIncludingChildren(int categoryId) {
        // Kiểm tra xem categoryId có phải là cha (parent_id=0) không
        String checkQuery = "SELECT parent_id FROM Categories WHERE id = ?";
        Integer parentId = DBContext.get().withHandle(handle -> handle.createQuery(checkQuery)
                .bind(0, categoryId)
                .mapTo(Integer.class)
                .findFirst()
                .orElse(null));

        // Nếu là danh mục cha (parent_id = 0), lấy tất cả con
        if (parentId != null && parentId == 0) {
            String sql = "SELECT id FROM Categories WHERE parent_id = ? OR id = ?";
            return DBContext.get().withHandle(handle -> handle.createQuery(sql)
                    .bind(0, categoryId)
                    .bind(1, categoryId)
                    .mapTo(Integer.class)
                    .list());
        } else {
            // Nếu là danh mục con, chỉ lấy nó
            List<Integer> ids = new ArrayList<>();
            ids.add(categoryId);
            return ids;
        }
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
        List<Category> list = dao.getAllCategories();
        System.out.println("Số lượng danh mục: " + list.size());
        for (Category c : list) {
            System.out.println(c.getName());
        }
    }

}
