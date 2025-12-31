package dal;

import model.Review;
import model.User;

import java.util.List;

public class ReviewDAO {
    // Thêm đánh giá mới

    public boolean insertReview(Review review) {
        String query = "INSERT INTO reviews (user_id, product_id, rating, comment, status, created_at) " +
                "VALUES (:userId, :productId, :rating, :comment, 'approved', NOW())";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(query)
                        .bind("userId", review.getUserId())
                        .bind("productId", review.getProductId())
                        .bind("rating", review.getRating())
                        .bind("comment", review.getComment())
                        .execute() > 0);
    }

    // Lấy đánh giá theo Product ID (kèm thông tin User)
    public List<Review> getReviewsByProductId(int productId) {
        String query = "SELECT r.*, u.fullname, u.avatar " +
                "FROM reviews r JOIN users u ON r.user_id = u.id " +
                "WHERE r.product_id = :pid AND r.status = 'approved' " +
                "ORDER BY r.created_at DESC";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind("pid", productId)
                        .map((rs, ctx) -> {
                            Review r = new Review();
                            r.setId(rs.getInt("id"));
                            r.setUserId(rs.getInt("user_id"));
                            r.setProductId(rs.getInt("product_id"));
                            r.setRating(rs.getInt("rating"));
                            r.setComment(rs.getString("comment"));
                            r.setCreatedAt(rs.getTimestamp("created_at"));

                            // Map User info
                            User u = new User();
                            u.setFullName(rs.getString("fullname"));
                            u.setAvatar(rs.getString("avatar"));
                            r.setUser(u);

                            return r;
                        }).list());
    }

    // Lấy tất cả đánh giá (Admin)
    public List<Review> getAllReviews() {
        String query = "SELECT r.*, u.fullname, p.name as product_name " +
                "FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "JOIN products p ON r.product_id = p.id " +
                "ORDER BY r.created_at DESC";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .mapToBean(Review.class)
                        .list());
    }

    // Xóa đánh giá (Admin)
    public boolean deleteReview(int reviewId) {
        String query = "DELETE FROM reviews WHERE id = :id";
        return DBContext.get().withHandle(handle ->
                handle.createUpdate(query).bind("id", reviewId).execute() > 0);
    }

    // Kiểm tra đã mua hàng chưa
    public boolean hasBought(int userId, int productId) {
        String query = "SELECT count(*) FROM orders o " +
                "JOIN order_details od ON o.id = od.order_id " +
                "WHERE o.user_id = :uid AND od.product_id = :pid AND o.status = 'completed'";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind("uid", userId)
                        .bind("pid", productId)
                        .mapTo(Integer.class).one() > 0);
    }
}
