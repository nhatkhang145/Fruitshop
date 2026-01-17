package dal;

import model.Order;
import model.OrderItem;
import model.Product;

import java.util.List;

public class OrderDAO {

    /**
     * Tạo đơn hàng mới
     * @param order Order object với đầy đủ thông tin
     * @return ID của đơn hàng vừa tạo, hoặc -1 nếu lỗi
     */
    public int createOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, coupon_id, fullname, phone, address, note, " +
                     "total_products_money, shipping_fee, discount_amount, final_amount, " +
                     "payment_method, payment_status, status) " +
                     "VALUES (:userId, :couponId, :fullname, :phone, :address, :note, " +
                     ":totalProductsMoney, :shippingFee, :discountAmount, :finalAmount, " +
                     ":paymentMethod, :paymentStatus, :status)";

        return DBContext.get().withHandle(handle -> {
            int orderId = handle.createUpdate(sql)
                    .bind("userId", order.getUserId())
                    .bind("couponId", order.getCouponId())
                    .bind("fullname", order.getFullname())
                    .bind("phone", order.getPhone())
                    .bind("address", order.getAddress())
                    .bind("note", order.getNote())
                    .bind("totalProductsMoney", order.getTotalProductsMoney())
                    .bind("shippingFee", order.getShippingFee())
                    .bind("discountAmount", order.getDiscountAmount())
                    .bind("finalAmount", order.getFinalAmount())
                    .bind("paymentMethod", order.getPaymentMethod())
                    .bind("paymentStatus", order.getPaymentStatus())
                    .bind("status", order.getStatus())
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();
            return orderId;
        });
    }

    /**
     * Thêm chi tiết đơn hàng (order items)
     * @param orderId ID đơn hàng
     * @param items Danh sách sản phẩm trong đơn
     */
    public void addOrderDetails(int orderId, List<OrderItem> items) {
        String sql = "INSERT INTO order_details (order_id, product_id, product_name, price, quantity, total) " +
                     "VALUES (:orderId, :productId, :productName, :price, :quantity, :total)";

        DBContext.get().useHandle(handle -> {
            var batch = handle.prepareBatch(sql);
            for (OrderItem item : items) {
                batch.bind("orderId", orderId)
                     .bind("productId", item.getProductId())
                     .bind("productName", item.getProductName())
                     .bind("price", item.getPrice())
                     .bind("quantity", item.getQuantity())
                     .bind("total", item.getTotal())
                     .add();
            }
            batch.execute();
        });
    }

    /**
     * Lấy tất cả đơn hàng của user
     * @param userId ID user
     * @return Danh sách đơn hàng
     */
    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT * FROM orders WHERE user_id = :userId ORDER BY created_at DESC";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .map((rs, ctx) -> {
                            Order order = new Order();
                            order.setId(rs.getInt("id"));
                            order.setUserId(rs.getInt("user_id"));
                            order.setCouponId((Integer) rs.getObject("coupon_id"));
                            order.setFullname(rs.getString("fullname"));
                            order.setPhone(rs.getString("phone"));
                            order.setAddress(rs.getString("address"));
                            order.setNote(rs.getString("note"));
                            order.setTotalProductsMoney(rs.getDouble("total_products_money"));
                            order.setShippingFee(rs.getDouble("shipping_fee"));
                            order.setDiscountAmount(rs.getDouble("discount_amount"));
                            order.setFinalAmount(rs.getDouble("final_amount"));
                            order.setPaymentMethod(rs.getString("payment_method"));
                            order.setPaymentStatus(rs.getInt("payment_status"));
                            order.setStatus(rs.getString("status"));
                            order.setCreatedAt(rs.getTimestamp("created_at"));
                            return order;
                        })
                        .list()
        );
    }

    /**
     * Lấy đơn hàng theo status
     * @param userId ID user
     * @param status Status cần filter
     * @return Danh sách đơn hàng
     */
    public List<Order> getOrdersByStatus(int userId, String status) {
        String sql = "SELECT * FROM orders WHERE user_id = :userId AND status = :status ORDER BY created_at DESC";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .bind("status", status)
                        .map((rs, ctx) -> {
                            Order order = new Order();
                            order.setId(rs.getInt("id"));
                            order.setUserId(rs.getInt("user_id"));
                            order.setCouponId((Integer) rs.getObject("coupon_id"));
                            order.setFullname(rs.getString("fullname"));
                            order.setPhone(rs.getString("phone"));
                            order.setAddress(rs.getString("address"));
                            order.setNote(rs.getString("note"));
                            order.setTotalProductsMoney(rs.getDouble("total_products_money"));
                            order.setShippingFee(rs.getDouble("shipping_fee"));
                            order.setDiscountAmount(rs.getDouble("discount_amount"));
                            order.setFinalAmount(rs.getDouble("final_amount"));
                            order.setPaymentMethod(rs.getString("payment_method"));
                            order.setPaymentStatus(rs.getInt("payment_status"));
                            order.setStatus(rs.getString("status"));
                            order.setCreatedAt(rs.getTimestamp("created_at"));
                            return order;
                        })
                        .list()
        );
    }

    /**
     * Lấy chi tiết đơn hàng theo ID
     * @param orderId ID đơn hàng
     * @return Order object với đầy đủ thông tin và order details
     */
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE id = :orderId";

        return DBContext.get().withHandle(handle -> {
            Order order = handle.createQuery(sql)
                    .bind("orderId", orderId)
                    .map((rs, ctx) -> {
                        Order o = new Order();
                        o.setId(rs.getInt("id"));
                        o.setUserId(rs.getInt("user_id"));
                        o.setCouponId((Integer) rs.getObject("coupon_id"));
                        o.setFullname(rs.getString("fullname"));
                        o.setPhone(rs.getString("phone"));
                        o.setAddress(rs.getString("address"));
                        o.setNote(rs.getString("note"));
                        o.setTotalProductsMoney(rs.getDouble("total_products_money"));
                        o.setShippingFee(rs.getDouble("shipping_fee"));
                        o.setDiscountAmount(rs.getDouble("discount_amount"));
                        o.setFinalAmount(rs.getDouble("final_amount"));
                        o.setPaymentMethod(rs.getString("payment_method"));
                        o.setPaymentStatus(rs.getInt("payment_status"));
                        o.setStatus(rs.getString("status"));
                        o.setCreatedAt(rs.getTimestamp("created_at"));
                        return o;
                    })
                    .findFirst()
                    .orElse(null);

            if (order != null) {
                // Lấy chi tiết đơn hàng
                List<OrderItem> items = getOrderDetails(orderId);
                order.setOrderDetails(items);
            }

            return order;
        });
    }

    /**
     * Lấy chi tiết sản phẩm trong đơn hàng
     * @param orderId ID đơn hàng
     * @return Danh sách OrderItem
     */
    public List<OrderItem> getOrderDetails(int orderId) {
        String sql = "SELECT od.*, p.image, p.sale_price " +
                     "FROM order_details od " +
                     "LEFT JOIN products p ON od.product_id = p.id " +
                     "WHERE od.order_id = :orderId";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("orderId", orderId)
                        .map((rs, ctx) -> {
                            OrderItem item = new OrderItem();
                            item.setId(rs.getInt("id"));
                            item.setOrderId(rs.getInt("order_id"));
                            item.setProductId((Integer) rs.getObject("product_id"));
                            item.setProductName(rs.getString("product_name"));
                            item.setPrice(rs.getDouble("price"));
                            item.setQuantity(rs.getInt("quantity"));
                            item.setTotal(rs.getDouble("total"));

                            // Thêm thông tin product để hiển thị ảnh
                            if (item.getProductId() != null) {
                                Product product = new Product();
                                product.setId(item.getProductId());
                                product.setName(item.getProductName());
                                product.setImage(rs.getString("image"));
                                product.setSalePrice(rs.getDouble("sale_price"));
                                item.setProduct(product);
                            }

                            return item;
                        })
                        .list()
        );
    }

    /**
     * Cập nhật trạng thái đơn hàng
     * @param orderId ID đơn hàng
     * @param status Trạng thái mới
     * @return true nếu thành công
     */
    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = :status WHERE id = :orderId";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId", orderId)
                        .bind("status", status)
                        .execute() > 0
        );
    }

    /**
     * Hủy đơn hàng
     * @param orderId ID đơn hàng
     * @param userId ID user (để verify quyền)
     * @return true nếu thành công
     */
    public boolean cancelOrder(int orderId, int userId) {
        String sql = "UPDATE orders SET status = 'cancelled' " +
                     "WHERE id = :orderId AND user_id = :userId AND status IN ('pending', 'processing')";

        return DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind("orderId", orderId)
                        .bind("userId", userId)
                        .execute() > 0
        );
    }

    /**
     * Đếm số đơn hàng của user theo status
     * @param userId ID user
     * @param status Status cần đếm
     * @return Số lượng đơn hàng
     */
    public int countOrdersByStatus(int userId, String status) {
        String sql = "SELECT COUNT(*) FROM orders WHERE user_id = :userId AND status = :status";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("userId", userId)
                        .bind("status", status)
                        .mapTo(Integer.class)
                        .one()
        );
    }
    // 1. Lấy tất cả đơn hàng (cho trang Admin Orders)
    public List<Order> getAllOrders() {
        String sql = "SELECT * FROM orders ORDER BY id DESC";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .mapToBean(Order.class)
                        .list()
        );
    }



    // 3. Cập nhật trạng thái đơn hàng (cho chức năng Duyệt/Hủy đơn)
    public void updateStatus(int orderId, int status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        DBContext.get().withHandle(handle ->
                handle.createUpdate(sql)
                        .bind(0, status)
                        .bind(1, orderId)
                        .execute()
        );
    }

    // 2. Lấy danh sách đơn hàng theo trạng thái (Cho Admin lọc)
    public List<Order> getOrdersByStatus(String status) {
        String sql = "SELECT * FROM orders WHERE status = :status ORDER BY created_at DESC";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(sql)
                        .bind("status", status)
                        .mapToBean(Order.class)
                        .list()
        );
    }
}
