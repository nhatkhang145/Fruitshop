package dal;

import model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DBContext {

    // 1. Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products"; // MySQL thường để tên bảng chữ thường, bạn kiểm tra lại DB nhé

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("category_id")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    // 2. Lấy sản phẩm theo Category ID
    public List<Product> getProductsByCategoryID(int cid) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE category_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, cid);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("category_id")
                );
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    // 3. Lấy chi tiết 1 sản phẩm
    public Product getProductByID(int id) {
        String sql = "SELECT * FROM products WHERE product_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("category_id")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    // ================== PHẦN PHÂN TRANG (MYSQL) ==================

    // 4. Đếm tổng số lượng sản phẩm
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM products";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;
    }

    // 5. Phân trang (Sử dụng LIMIT của MySQL)
    public List<Product> pagingProduct(int index) {
        List<Product> list = new ArrayList<>();
        // Cú pháp MySQL: LIMIT offset, count
        // offset: vị trí bắt đầu lấy (bắt đầu từ 0) -> (trang hiện tại - 1) * 6
        // count: số lượng lấy -> 6
        String sql = "SELECT * FROM products ORDER BY product_id LIMIT ?, 6";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            // Tính toán vị trí bắt đầu
            int offset = (index - 1) * 6;
            st.setInt(1, offset);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getDouble("price"),
                        rs.getInt("quantity"),
                        rs.getString("description"),
                        rs.getString("image"),
                        rs.getInt("category_id")
                ));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    // Main test
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProducts();
        for (Product p : list) {
            System.out.println(p.getId() + " - " + p.getName());
        }
    }
}