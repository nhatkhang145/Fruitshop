package dal;

import model.Product;
import java.util.List;
import java.util.Optional;

// Không cần extends DBContext nữa vì ta dùng hàm static DBContext.get()
public class ProductDAO {

    // 1. Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM products";
        return DBContext.get().withHandle(handle ->
            handle.createQuery(sql)
                  .mapToBean(Product.class) // Tự động map cột DB vào class Product
                  .list()
        );
    }

    // 2. Lấy sản phẩm theo Category ID
    public List<Product> getProductsByCategoryID(int cid) {
        String sql = "SELECT * FROM products WHERE category_id = ?";
        return DBContext.get().withHandle(handle ->
            handle.createQuery(sql)
                  .bind(0, cid) // Gán cid vào dấu ? đầu tiên
                  .mapToBean(Product.class)
                  .list()
        );
    }

    // 3. Lấy chi tiết 1 sản phẩm
    public Product getProductByID(int id) {
        String sql = "SELECT * FROM products WHERE product_id = ?";
        return DBContext.get().withHandle(handle ->
            handle.createQuery(sql)
                  .bind(0, id)
                  .mapToBean(Product.class)
                  .findFirst()
                  .orElse(null) // Nếu không tìm thấy trả về null
        );
    }

    // ================== PHẦN PHÂN TRANG ==================

    // 4. Đếm tổng số lượng sản phẩm
    public int countAll() {
        String sql = "SELECT COUNT(*) FROM products";
        return DBContext.get().withHandle(handle ->
            handle.createQuery(sql)
                  .mapTo(Integer.class)
                  .one()
        );
    }

    // 5. Phân trang (Trang 1 lấy 6 bài, Trang 2 lấy 6 bài tiếp...)
    public List<Product> pagingProduct(int index) {
        String sql = "SELECT * FROM products ORDER BY product_id LIMIT ?, 6";
        int offset = (index - 1) * 6; // Tính vị trí bắt đầu
        
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
        
        // Thử lấy danh sách
        List<Product> list = dao.getAllProducts();
        
        System.out.println("----- TEST LIST PRODUCTS -----");
        if (list.isEmpty()) {
            System.out.println("Chưa có sản phẩm nào hoặc lỗi kết nối!");
        } else {
            for (Product p : list) {
                // Lưu ý: Đảm bảo class Product của bạn có hàm getProduct_name() hoặc getName()
                // Jdbi map theo tên cột product_name -> field productName hoặc product_name
                System.out.println(p.getId() + " - " + p.getName() + " - " + p.getPrice());
            }
        }
    }
}