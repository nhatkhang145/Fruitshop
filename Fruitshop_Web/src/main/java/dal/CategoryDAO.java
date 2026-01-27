package dal;

import model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<Category> getAllCategories() {
        String query = "SELECT id, name, description, parent_id AS parentId, status FROM categories";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .mapToBean(Category.class)
                        .list());
    }

    private static void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Thêm vào trong class CategoryDAO
    public void insert(Category c) {
        String sql = "INSERT INTO categories (name, description, parent_id, status) VALUES (?, ?, ?, ?)";
        DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, c.getName())
                        .bind(1, c.getDescription())
                        .bind(2, c.getParentId())
                        .bind(3, c.getStatus())
                        .execute()
        );
    }

    public void update(Category c) {
        String sql = "UPDATE categories SET name=?, description=?, parent_id=?, status=? WHERE id=?";
        DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, c.getName())
                        .bind(1, c.getDescription())
                        .bind(2, c.getParentId())
                        .bind(3, c.getStatus())
                        .bind(4, c.getId())
                        .execute()
        );
    }

    public void delete(int id) {
        // Xóa mềm (ẩn đi) hoặc xóa cứng tùy logic của bạn. Ở đây ví dụ xóa cứng.
        String sql = "UPDATE categories SET status = 0 WHERE id = ?";
        DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, id)
                        .execute()
        );
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
