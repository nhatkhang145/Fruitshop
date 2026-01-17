package dal;

import model.Product;
import java.util.List;

public class ProductDAO {

    // 1. Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        // SỬA: short_description AS description (để khớp với file Model)
        String sql = "SELECT id, name, price,sale_price, quantity, short_description AS description, image, category_id AS categoryId FROM products";
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
        String sql = "SELECT id, " +
                "       name, " +
                "       product_code AS productCode, " +
                "       price, " +
                "       sale_price AS salePrice, " +
                "       quantity, " +
                "       short_description AS description, " +
                "       image, " +
                "       category_id AS categoryId " +
                "FROM products WHERE id = ?";        return DBContext.get().withHandle(handle ->
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
// ================== PHẦN ADMIN CRUD ==================

    // 6. Thêm sản phẩm mới (Create)
    public int insert(Product p) {
        String sql = "INSERT INTO products (name, price, sale_price, quantity, short_description, image, category_id) " +
                "VALUES (:name, :price, :salePrice, :quantity, :description, :image, :categoryId)";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(p) // Tự động map các getter trong Product với param :name, :price...
                        .execute()
        );
    }

    // 7. Cập nhật sản phẩm (Update)
    public int update(Product p) {
        String sql = "UPDATE products SET name = :name, price = :price, sale_price = :salePrice, " +
                "quantity = :quantity, short_description = :description, image = :image, category_id = :categoryId " +
                "WHERE id = :id";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bindBean(p)
                        .execute()
        );
    }

    // 8. Xóa sản phẩm (Delete)
    // Lưu ý: Nếu bạn muốn xóa mềm (ẩn đi) thì đổi câu lệnh thành UPDATE products SET status = 0 WHERE id = ?
    // Ở đây mình viết xóa cứng theo cơ bản trước.
    public int delete(int id) {
        String sql = "DELETE FROM products WHERE id = ?";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, id)
                        .execute()
        );
    }

    // Lọc sản phẩm
    public List<Product> filterProducts(Integer categoryId, Double minPrice, Double maxPrice, String sortType) {
        StringBuilder sql = new StringBuilder("SELECT id, name, product_code AS productCode, price, sale_price AS salePrice, quantity, short_description AS description, image, category_id AS categoryId FROM products WHERE status = 1");

        // 1. Lọc theo Category
        if (categoryId != null && categoryId > 0) {
            sql.append(" AND category_id = :cid ");
        }

        // 2. Lọc theo Giá (Sử dụng giá thực tế phải trả: nếu có sale thì lấy sale_price, không thì lấy price)
        // Logic SQL: Nếu (sale_price > 0 và < price) thì dùng sale_price, ngược lại dùng price
        if (minPrice != null) {
            sql.append(" AND (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) >= :min ");
        }
        if (maxPrice != null) {
            sql.append(" AND (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) <= :max ");
        }

        // 3. Sắp xếp
        if (sortType != null) {
            switch (sortType) {
                case "price_asc": // Giá tăng dần
                    sql.append(" ORDER BY (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) ASC ");
                    break;
                case "price_desc": // Giá giảm dần
                    sql.append(" ORDER BY (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) DESC ");
                    break;
                case "name_asc":
                    sql.append(" ORDER BY name ASC ");
                    break;
                default: // Mặc định mới nhất
                    sql.append(" ORDER BY id DESC ");
                    break;
            }
        } else {
            sql.append(" ORDER BY id DESC ");
        }

        return DBContext.get().withHandle(handle -> {
            var query = handle.createQuery(sql.toString());

            if (categoryId != null && categoryId > 0) query.bind("cid", categoryId);
            if (minPrice != null) query.bind("min", minPrice);
            if (maxPrice != null) query.bind("max", maxPrice);

            return query.mapToBean(Product.class).list();
        });
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