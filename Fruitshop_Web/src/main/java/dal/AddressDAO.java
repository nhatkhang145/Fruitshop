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

   
}
