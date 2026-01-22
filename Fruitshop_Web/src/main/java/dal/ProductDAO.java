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
        String sql = "SELECT id, name, price, sale_price AS salePrice, quantity, short_description AS description, image, category_id AS categoryId FROM products WHERE category_id = ?";
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
        String sql = "SELECT id, name, price, sale_price AS salePrice, quantity, short_description AS description, image, category_id AS categoryId FROM products ORDER BY id LIMIT ?, 6";
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
    public int delete(int id) {
        String sql = "DELETE FROM products WHERE id = ?";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, id)
                        .execute()
        );
    }

    // Đếm tổng số sản phẩm sau khi lọc
    public int countProductsByFilter(Integer cid, Double minPrice, Double maxPrice) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products WHERE status = 1 ");
        if (cid != null) sql.append(" AND category_id = :cid ");
        if (minPrice != null) sql.append(" AND (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) >= :min ");
        if (maxPrice != null) sql.append(" AND (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) <= :max ");

        return DBContext.get().withHandle(handle -> {
            var query = handle.createQuery(sql.toString());
            if (cid != null) query.bind("cid", cid);
            if (minPrice != null) query.bind("min", minPrice);
            if (maxPrice != null) query.bind("max", maxPrice);
            return query.mapTo(Integer.class).one();
        });
    }

    // Lọc sản phẩm
    public List<Product> filterProducts(Integer cid, Double minPrice, Double maxPrice, String sortType, int index) {
        StringBuilder sql = new StringBuilder("SELECT id, name, product_code AS productCode, price, sale_price AS salePrice, quantity, short_description AS description, image, category_id AS categoryId, status FROM products WHERE status = 1 ");

        // Các điều kiện lọc
        if (cid != null) sql.append(" AND category_id = :cid ");
        if (minPrice != null) sql.append(" AND (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) >= :min ");
        if (maxPrice != null) sql.append(" AND (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) <= :max ");

        // Sắp xếp
        if (sortType != null) {
            switch (sortType) {
                case "price_asc": sql.append(" ORDER BY (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) ASC "); break;
                case "price_desc": sql.append(" ORDER BY (CASE WHEN sale_price > 0 AND sale_price < price THEN sale_price ELSE price END) DESC "); break;
                case "name_asc": sql.append(" ORDER BY name ASC "); break;
                default: sql.append(" ORDER BY id DESC "); break;
            }
        } else {
            sql.append(" ORDER BY id DESC ");
        }

        // Phân trang (Mỗi trang 6 sản phẩm)
        sql.append(" LIMIT 6 OFFSET :offset ");

        return DBContext.get().withHandle(handle -> {
            var query = handle.createQuery(sql.toString());
            if (cid != null) query.bind("cid", cid);
            if (minPrice != null) query.bind("min", minPrice);
            if (maxPrice != null) query.bind("max", maxPrice);
            query.bind("offset", (index - 1) * 6);

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

    // Tìm kiếm sản phẩm theo từ khóa và danh mục
    public List<Product> searchProducts(String keyword, String category) {
        StringBuilder sql = new StringBuilder(
            "SELECT id, name, price, sale_price AS salePrice, quantity, short_description AS description, image, category_id AS categoryId " +
            "FROM products WHERE status = 1"
        );

        // Tìm kiếm theo từ khóa (tên sản phẩm hoặc mô tả)
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (name LIKE :keyword OR short_description LIKE :keyword)");
        }

        // Lọc theo danh mục
        if (category != null && !category.equals("all")) {
            sql.append(" AND category_id = :categoryId");
        }

        sql.append(" ORDER BY id DESC");

        return DBContext.get().withHandle(handle -> {
            var query = handle.createQuery(sql.toString());

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.bind("keyword", "%" + keyword.trim() + "%");
            }

            if (category != null && !category.equals("all")) {
                try {
                    int catId = Integer.parseInt(category);
                    query.bind("categoryId", catId);
                } catch (NumberFormatException e) {
                    // Nếu category không phải số, bỏ qua
                }
            }

            return query.mapToBean(Product.class).list();
        });
    }

    // Lấy sản phẩm mới nhất
    public List<Product> getNewestProducts(int limit) {
        String sql = "SELECT id, name, price, sale_price AS salePrice, quantity, short_description AS description, image, category_id AS categoryId " +
                     "FROM products WHERE status = 1 ORDER BY id DESC LIMIT ?";
        
        return DBContext.get().withHandle(handle ->
            handle.createQuery(sql)
                .bind(0, limit)
                .mapToBean(Product.class)
                .list()
        );
    }

    // Lấy sản phẩm bán chạy
    public List<Product> getBestSellingProducts(int limit) {
        String sql = "SELECT p.id, p.name, p.price, p.sale_price AS salePrice, p.quantity, " +
                     "p.short_description AS description, p.image, p.category_id AS categoryId " +
                     "FROM products p " +
                     "WHERE p.status = 1 " +
                     "ORDER BY p.id DESC " +
                     "LIMIT ?";
        
        return DBContext.get().withHandle(handle ->
            handle.createQuery(sql)
                .bind(0, limit)
                .mapToBean(Product.class)
                .list()
        );
    }

    // Lấy sản phẩm có giảm giá
    public List<Product> getDiscountProducts(int limit) {
        String sql = "SELECT id, name, price, sale_price AS salePrice, quantity, short_description AS description, image, category_id AS categoryId " +
                     "FROM products " +
                     "WHERE status = 1 AND sale_price > 0 AND sale_price < price " +
                     "ORDER BY (price - sale_price) / price DESC " +
                     "LIMIT ?";
        
        return DBContext.get().withHandle(handle ->
            handle.createQuery(sql)
                .bind(0, limit)
                .mapToBean(Product.class)
                .list()
        );
    }

    // Thống kê: Đếm tổng số sản phẩm
    public int countTotalProducts() {
        return DBContext.get().withHandle(handle ->
                handle.createQuery("SELECT COUNT(*) FROM products").mapTo(Integer.class).one()
        );
    }

    public List<Product> getProductsWithSort(String sortType) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.* FROM products p ");

        // lọc theo bán chạy
        if ("best_sell".equals(sortType)) {
            sql.append("LEFT JOIN order_details od ON p.id = od.product_id ");
            sql.append("GROUP BY p.id ");
            sql.append("ORDER BY SUM(od.quantity) DESC");
        } else {
            // Các trường hợp sắp xếp khác
            switch (sortType) {
                case "new":
                    sql.append("ORDER BY p.created_at DESC"); // Mới nhất (dựa vào ngày tạo)
                    break;
                case "old":
                    sql.append("ORDER BY p.created_at ASC");  // Cũ nhất
                    break;
                case "popular":
                    sql.append("ORDER BY p.views DESC");      // Phổ biến (dựa vào views)
                    break;
                case "price_asc":
                    // Ưu tiên sắp xếp theo giá khuyến mãi nếu có, không thì giá gốc
                    sql.append("ORDER BY COALESCE(NULLIF(p.sale_price, 0), p.price) ASC");
                    break;
                case "price_desc":
                    sql.append("ORDER BY COALESCE(NULLIF(p.sale_price, 0), p.price) DESC");
                    break;
                default:
                    sql.append("ORDER BY p.id DESC");
                    break;
            }
        }

        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql.toString())
                        .mapToBean(Product.class)
                        .list()
        );
    }
}