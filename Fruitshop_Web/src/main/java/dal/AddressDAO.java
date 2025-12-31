package dal;

import model.Address;
import java.util.List;

public class AddressDAO {

    // 1. Lấy danh sách địa chỉ theo userId
    public List<Address> getAddressesByUserId(int userId) {
        String query = "SELECT id, user_id, receiver_name, phone_number, address, city, is_default " +
                       "FROM user_addresses WHERE user_id = ? ORDER BY is_default DESC, id DESC";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, userId)
                        .map((rs, ctx) -> {
                            Address addr = new Address();
                            addr.setId(rs.getInt("id"));
                            addr.setUserId(rs.getInt("user_id"));
                            addr.setReceiverName(rs.getString("receiver_name"));
                            addr.setPhoneNumber(rs.getString("phone_number"));
                            addr.setAddress(rs.getString("address"));
                            addr.setCity(rs.getString("city"));
                            addr.setDefault(rs.getInt("is_default") == 1);
                            return addr;
                        })
                        .list()
        );
    }

    // 2. Lấy địa chỉ theo ID
    public Address getAddressById(int addressId) {
        String query = "SELECT id, user_id, receiver_name, phone_number, address, city, is_default " +
                       "FROM user_addresses WHERE id = ?";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, addressId)
                        .map((rs, ctx) -> {
                            Address addr = new Address();
                            addr.setId(rs.getInt("id"));
                            addr.setUserId(rs.getInt("user_id"));
                            addr.setReceiverName(rs.getString("receiver_name"));
                            addr.setPhoneNumber(rs.getString("phone_number"));
                            addr.setAddress(rs.getString("address"));
                            addr.setCity(rs.getString("city"));
                            addr.setDefault(rs.getInt("is_default") == 1);
                            return addr;
                        })
                        .findFirst()
                        .orElse(null)
        );
    }

    // 3. Thêm địa chỉ mới
    public void addAddress(Address address) {
        DBContext.get().useHandle(handle -> {
            // Nếu địa chỉ mới là mặc định, bỏ mặc định của các địa chỉ khác
            if (address.isDefault()) {
                handle.createUpdate("UPDATE user_addresses SET is_default = 0 WHERE user_id = ?")
                        .bind(0, address.getUserId())
                        .execute();
            }

            String query = "INSERT INTO user_addresses (user_id, receiver_name, phone_number, address, city, is_default) " +
                           "VALUES (?, ?, ?, ?, ?, ?)";
            handle.createUpdate(query)
                    .bind(0, address.getUserId())
                    .bind(1, address.getReceiverName())
                    .bind(2, address.getPhoneNumber())
                    .bind(3, address.getAddress())
                    .bind(4, address.getCity())
                    .bind(5, address.isDefault() ? 1 : 0)
                    .execute();
        });
    }

    // 4. Cập nhật địa chỉ
    public void updateAddress(Address address) {
        DBContext.get().useHandle(handle -> {
            // Nếu địa chỉ này được đặt làm mặc định, bỏ mặc định của các địa chỉ khác
            if (address.isDefault()) {
                handle.createUpdate("UPDATE user_addresses SET is_default = 0 WHERE user_id = ? AND id != ?")
                        .bind(0, address.getUserId())
                        .bind(1, address.getId())
                        .execute();
            }

            String query = "UPDATE user_addresses SET receiver_name = ?, phone_number = ?, address = ?, city = ?, is_default = ? " +
                           "WHERE id = ?";
            handle.createUpdate(query)
                    .bind(0, address.getReceiverName())
                    .bind(1, address.getPhoneNumber())
                    .bind(2, address.getAddress())
                    .bind(3, address.getCity())
                    .bind(4, address.isDefault() ? 1 : 0)
                    .bind(5, address.getId())
                    .execute();
        });
    }

    // 5. Xóa địa chỉ
    public void deleteAddress(int addressId) {
        String query = "DELETE FROM user_addresses WHERE id = ?";

        DBContext.get().useHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, addressId)
                        .execute()
        );
    }

    // 6. Đặt địa chỉ mặc định
    public void setDefaultAddress(int userId, int addressId) {
        DBContext.get().useHandle(handle -> {
            // Bỏ mặc định tất cả địa chỉ của user
            handle.createUpdate("UPDATE user_addresses SET is_default = 0 WHERE user_id = ?")
                    .bind(0, userId)
                    .execute();

            // Đặt địa chỉ được chọn làm mặc định
            handle.createUpdate("UPDATE user_addresses SET is_default = 1 WHERE id = ?")
                    .bind(0, addressId)
                    .execute();
        });
    }

    // 7. Lấy địa chỉ mặc định của user
    public Address getDefaultAddress(int userId) {
        String query = "SELECT id, user_id, receiver_name, phone_number, address, city, is_default " +
                       "FROM user_addresses WHERE user_id = ? AND is_default = 1 LIMIT 1";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, userId)
                        .map((rs, ctx) -> {
                            Address addr = new Address();
                            addr.setId(rs.getInt("id"));
                            addr.setUserId(rs.getInt("user_id"));
                            addr.setReceiverName(rs.getString("receiver_name"));
                            addr.setPhoneNumber(rs.getString("phone_number"));
                            addr.setAddress(rs.getString("address"));
                            addr.setCity(rs.getString("city"));
                            addr.setDefault(true);
                            return addr;
                        })
                        .findFirst()
                        .orElse(null)
        );
    }

    // 8. Đếm số địa chỉ của user
    public int countAddresses(int userId) {
        String query = "SELECT COUNT(*) FROM user_addresses WHERE user_id = ?";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, userId)
                        .mapTo(Integer.class)
                        .one()
        );
    }
}
