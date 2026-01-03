package dal;

import model.Product;
import model.WishlistItem;

import java.util.List;

public class WishlistDAO {
    // Thêm vào yêu thích
    public boolean addToWishlist(int userId, int productId) {
        String query = "INSERT IGNORE INTO wishlists (user_Id, product_Id) VALUES (:uid, :pid)";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(query)
                        .bind("uid", userId)
                        .bind("pid", productId)
                        .execute() > 0
        );
    }

    // Xóa khỏi yêu thích
    public boolean removeFromWishlist(int userId, int productId) {
        String query = "DELETE FROM wishlists WHERE user_Id = :uid  AND product_Id = :pid";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(query)
                        .bind("uid", userId)
                        .bind("pid", productId)
                        .execute() > 0
        );
    }

    // Đếm số lượng để hiện lên header (nếu cần)
    public int countWishlist(int userId) {
        String query = "SELECT COUNT(*) FROM wishlists WHERE user_Id = :uid";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind("uid", userId)
                        .mapTo(Integer.class)
                        .one());
    }

    // Lấy danh sách hiển thị
    public List<WishlistItem> getWishlistByUserId(int userId) {
        // 1. SỬA CÂU SQL: Thêm p.quantity vào danh sách cột cần lấy
        String query = "SELECT w.user_id, w.product_id, w.created_at, " +
                "p.id as p_id, p.name, p.price, p.sale_price, p.image, p.quantity " +
                "FROM wishlists w " +
                "JOIN products p ON w.product_id = p.id " +
                "WHERE w.user_id = :uid " +
                "ORDER BY w.created_at DESC";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind("uid", userId)
                        .map((rs, ctx) -> {
                            WishlistItem item = new WishlistItem();
                            // Không set id vì bảng wishlists không có cột id
                            item.setUserId(rs.getInt("user_id"));
                            item.setProductId(rs.getInt("product_id"));
                            item.setCreatedAt(rs.getTimestamp("created_at"));

                            Product product = new Product();
                            product.setId(rs.getInt("p_id"));
                            product.setName(rs.getString("name"));
                            product.setPrice(rs.getDouble("price"));
                            product.setSalePrice(rs.getDouble("sale_price"));
                            product.setImage(rs.getString("image"));

                            // 2. SỬA MAPPER: Set số lượng cho sản phẩm
                            product.setQuantity(rs.getInt("quantity"));

                            item.setProduct(product);
                            return item;
                        })
                        .list());
    }

    // Lấy sản phẩm yêu thích
    public List<Integer> getLikedProductIds(int userId) {
        String query = "SELECT product_id FROM wishlists WHERE user_id = ?";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, userId)
                        .mapTo(Integer.class)
                        .list()
        );
    }
}
