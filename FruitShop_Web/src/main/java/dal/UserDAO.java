package dal;

import model.User;
import java.util.Optional;

public class UserDAO {

    // 1. Kiểm tra Email tồn tại
    public boolean checkExist(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, email)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    // 2. Đăng ký người dùng mới
    public void signup(String fullname, String email, String password) {
        // Lưu ý: Đảm bảo bảng users của bạn có cột role, status, login_type
        String query = "INSERT INTO users (fullname, email, password, role, status, login_type) VALUES (?, ?, ?, 0, 1, 'local')";

        DBContext.get().useHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, fullname)
                        .bind(1, email)
                        .bind(2, password)
                        .execute()
        );
    }

    // 3. Đăng nhập
    public User checkLogin(String email, String password) {
        String query = "SELECT * FROM users WHERE email = ? AND password = ? AND status = 1";

        return DBContext.get().withHandle(handle ->
                handle.createQuery(query)
                        .bind(0, email)
                        .bind(1, password)
                        .mapToBean(User.class)
                        .findFirst()
                        .orElse(null)
        );
    }

    // 1. HÀM CẬP NHẬT THÔNG TIN CÁ NHÂN (Bảng users)
    // Chỉ update những cột có trong bảng users
    public void updateProfile(User user) {
        // Thêm gender = ? vào câu lệnh SQL
        String query = "UPDATE users SET fullname = ?, phone = ?, gender = ? WHERE id = ?";

        DBContext.get().useHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, user.getFullName())
                        .bind(1, user.getPhone())
                        .bind(2, user.getGender()) // Bind tham số gender
                        .bind(3, user.getId())
                        .execute()
        );
    }

    // 2. HÀM XỬ LÝ ĐỊA CHỈ (Bảng user_addresses)
    // Hàm này sẽ kiểm tra xem user đã có địa chỉ mặc định chưa.
    // Nếu có rồi -> UPDATE. Nếu chưa -> INSERT.
    public void updateAddress(int userId, String address, String city, String receiverName, String phone) {
        DBContext.get().useHandle(handle -> {
            // A. Kiểm tra xem user này đã có địa chỉ nào chưa
            int count = handle.createQuery("SELECT COUNT(*) FROM user_addresses WHERE user_id = ?")
                    .bind(0, userId)
                    .mapTo(Integer.class)
                    .one();

            if (count > 0) {
                // B. Nếu có rồi -> Cập nhật địa chỉ mặc định (hoặc địa chỉ đầu tiên tìm thấy)
                String sqlUpdate = "UPDATE user_addresses SET address = ?, city = ?, receiver_name = ?, phone_number = ? WHERE user_id = ? LIMIT 1";
                handle.createUpdate(sqlUpdate)
                        .bind(0, address)
                        .bind(1, city) // Bạn cần truyền city vào, hoặc tạm thời để fix cứng nếu form chưa có
                        .bind(2, receiverName)
                        .bind(3, phone)
                        .bind(4, userId)
                        .execute();
            } else {
                // C. Nếu chưa có -> Thêm mới
                String sqlInsert = "INSERT INTO user_addresses (user_id, receiver_name, phone_number, address, city, is_default) VALUES (?, ?, ?, ?, ?, 1)";
                handle.createUpdate(sqlInsert)
                        .bind(0, userId)
                        .bind(1, receiverName)
                        .bind(2, phone)
                        .bind(3, address)
                        .bind(4, city)
                        .execute();
            }
        });
    }

    // 3. Hàm lấy địa chỉ mặc định để hiển thị lên Form
    public String getUserAddress(int userId) {
        return DBContext.get().withHandle(handle ->
                handle.createQuery("SELECT address FROM user_addresses WHERE user_id = ? ORDER BY is_default DESC LIMIT 1")
                        .bind(0, userId)
                        .mapTo(String.class)
                        .findFirst()
                        .orElse("") // Nếu không có địa chỉ thì trả về chuỗi rỗng
        );
    }

    // 5. Đổi mật khẩu
    public void changePassword(int id, String newPassword) {
        String query = "UPDATE users SET password = ? WHERE id = ?";

        DBContext.get().useHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, newPassword)
                        .bind(1, id)
                        .execute()
        );
    }
}