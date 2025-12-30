package dal;

import model.Product;
import java.util.List;

public class ProductDAO {

    // 1. Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        // SỬA: short_description AS description (để khớp với file Model)
        String sql = "SELECT id, name, price, quantity, short_description AS description, image, category_id AS categoryId FROM products";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    // 2. Lấy sản phẩm theo Category ID
    public List<Product> getProductsByCategoryID(int cid) {
        // SỬA TƯƠNG TỰ
        String sql = "SELECT id, name, price, quantity, short_description AS description, image, category_id AS categoryId FROM products WHERE category_id = ?";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, cid)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    // 3. Lấy chi tiết 1 sản phẩm
    public Product getProductByID(int id) {
        // SỬA TƯƠNG TỰ
        String sql = "SELECT id, name, price, quantity, short_description AS description, image, category_id AS categoryId FROM products WHERE id = ?";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, id)
                        .mapToBean(Product.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    // ================== PHẦN PHÂN TRANG ==================

    // 4. Đếm tổng số lượng sản phẩm (Giữ nguyên)
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM products";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .mapTo(Integer.class)
                        .one()
        );
    }

    // 5. Phân trang
    public List<Product> pagingProduct(int index) {
        // SỬA TƯƠNG TỰ
        String sql = "SELECT id, name, price, quantity, short_description AS description, image, category_id AS categoryId FROM products ORDER BY id LIMIT ?, 6";
        int offset = (index - 1) * 6;

        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, offset)
                        .mapToBean(Product.class)
                        .list()
        );
    }

    // Main test
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProducts();

        System.out.println("----- TEST LIST PRODUCTS -----");
        System.out.println("Tổng số lượng tìm thấy: " + list.size());

        if (list.isEmpty()) {
            System.out.println("Lỗi: Không lấy được dữ liệu!");
        } else {
            for (Product p : list) {
                System.out.println("ID: " + p.getId() + " | Tên: " + p.getName() + " | Giá: " + p.getPrice());
            }
        }
    }
}