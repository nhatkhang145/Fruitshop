package dal;

import model.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<Category> getAllCategories() {
        String query = "SELECT * FROM Categories WHERE status = 1";

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

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
        List<Category> list = dao.getAllCategories();
        System.out.println("Số lượng danh mục: " + list.size());
        for (Category c : list) {
            System.out.println(c.getName());
        }
    }
}
