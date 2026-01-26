package dal;

import model.User;

import java.util.List;
import java.util.Optional;

public class UserDAO {

    // 1. Kiểm tra Email tồn tại
    public boolean checkExist(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        return DBContext.get().withHandle(handle -> handle.createQuery(query)
                .bind(0, email)
                .mapTo(Integer.class)
                .one() > 0);
    }

    // 2. Đăng ký người dùng mới
    public void signup(String fullname, String email, String password) {
        // Lưu ý: Đảm bảo bảng users của bạn có cột role, status, login_type
        String query = "INSERT INTO users (fullname, email, password, role, status, login_type) VALUES (?, ?, ?, 0, 1, 'local')";

        DBContext.get().useHandle(handle -> handle.createUpdate(query)
                .bind(0, fullname)
                .bind(1, email)
                .bind(2, password)
                .execute());
    }

    // 3. Đăng nhập
    public User checkLogin(String email, String password) {
        String query = "SELECT id, fullname, email, password, phone, role, avatar, gender, birthdate FROM users WHERE email = ? AND password = ? AND status = 1";

        return DBContext.get().withHandle(handle -> handle.createQuery(query)
                .bind(0, email)
                .bind(1, password)
                .map((rs, ctx) -> {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFullName(rs.getString("fullname"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setPhone(rs.getString("phone"));
                    user.setRole(rs.getInt("role"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setGender(rs.getString("gender"));
                    user.setBirthDate(rs.getDate("birthdate"));
                    return user;
                })
                .findFirst()
                .orElse(null));
    }

    // 1. HÀM CẬP NHẬT THÔNG TIN CÁ NHÂN (Bảng users)
    // Chỉ update những cột có trong bảng users
    public void updateProfile(User user) {
        String query = "UPDATE users SET fullname = ?, phone = ?, gender = ?, birthdate = ?, avatar = ? WHERE id = ?";

        DBContext.get().useHandle(handle -> handle.createUpdate(query)
                .bind(0, user.getFullName())
                .bind(1, user.getPhone())
                .bind(2, user.getGender())
                .bind(3, user.getBirthDate())
                .bind(4, user.getAvatar())
                .bind(5, user.getId())
                .execute());
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
        return DBContext.get().withHandle(handle -> handle
                .createQuery("SELECT address FROM user_addresses WHERE user_id = ? ORDER BY is_default DESC LIMIT 1")
                .bind(0, userId)
                .mapTo(String.class)
                .findFirst()
                .orElse("") // Nếu không có địa chỉ thì trả về chuỗi rỗng
        );
    }

    // 5. Đổi mật khẩu
    public void changePassword(int id, String newPassword) {
        String query = "UPDATE users SET password = ? WHERE id = ?";

        DBContext.get().useHandle(handle -> handle.createUpdate(query)
                .bind(0, newPassword)
                .bind(1, id)
                .execute());
    }

    // 5.1. Cập nhật mật khẩu theo email (dùng cho reset password)
    public void updatePasswordByEmail(String email, String newPassword) {
        String query = "UPDATE users SET password = ? WHERE email = ?";

        DBContext.get().useHandle(handle -> handle.createUpdate(query)
                .bind(0, newPassword)
                .bind(1, email)
                .execute());
    }

    // 6. Lấy user theo email (cho Google Login)
    public User getUserByEmail(String email) {
        String query = "SELECT id, fullname, email, password, phone, role, avatar, gender, birthdate, status, login_type, social_id, created_at "
                +
                "FROM users WHERE email = ?";

        return DBContext.get().withHandle(handle -> handle.createQuery(query)
                .bind(0, email)
                .map((rs, ctx) -> {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFullName(rs.getString("fullname"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setPhone(rs.getString("phone"));
                    user.setRole(rs.getInt("role"));
                    user.setAvatar(rs.getString("avatar"));
                    user.setGender(rs.getString("gender"));
                    user.setBirthDate(rs.getDate("birthdate"));
                    user.setStatus(rs.getInt("status"));
                    user.setLoginType(rs.getString("login_type"));
                    user.setSocialId(rs.getString("social_id"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    return user;
                })
                .findFirst()
                .orElse(null));
    }

    // 7. Insert user mới (cho Google Login)
    public void insertUser(User user) {
        String sql = "INSERT INTO users (fullname, email, password, avatar, login_type, social_id, role, status, created_at) "
                +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        DBContext.get().useHandle(handle -> handle.createUpdate(sql)
                .bind(0, user.getFullName())
                .bind(1, user.getEmail())
                .bind(2, user.getPassword())
                .bind(3, user.getAvatar())
                .bind(4, user.getLoginType())
                .bind(5, user.getSocialId())
                .bind(6, user.getRole())
                .bind(7, user.getStatus())
                .bind(8, user.getCreatedAt())
                .execute());
    }

    // 8. Update login type và social ID (khi merge account)
    public void updateSocialInfo(User user) {
        String query = "UPDATE users SET login_type = ?, social_id = ?, avatar = ? WHERE id = ?";

        DBContext.get().useHandle(handle -> handle.createUpdate(query)
                .bind(0, user.getLoginType())
                .bind(1, user.getSocialId())
                .bind(2, user.getAvatar())
                .bind(3, user.getId())
                .execute());
    }

    // 9. Lấy danh sách tất cả người dùng
    public List<User> getAllUsers() {
        String sql = "SELECT id, fullname AS fullName, email, password, phone, role, avatar, gender, " +
                "birthdate AS birthDate, status, login_type AS loginType, social_id AS socialId, created_at AS createdAt "
                +
                "FROM users ORDER BY id DESC";

        return DBContext.get().withHandle(handle -> handle.createQuery(sql)
                .mapToBean(User.class)
                .list());
    }

    // 10. Cập nhật Role và Status (Cho chức năng Phân quyền/Chặn)
    public boolean updateUserStatusAndRole(int userId, int role, String status) {
        String sql = "UPDATE users SET role = :role, status = :status WHERE id = :userId";
        int rows = DBContext.get().withHandle(handle -> handle.createUpdate(sql)
                .bind("role", role)
                .bind("status", status)
                .bind("userId", userId)
                .execute());
        return rows > 0;
    }

    // 11. Lấy User theo ID (Để hiện trang chi tiết)
    public User getUserById(int id) {
        String sql = "SELECT id, fullname, email, password, phone, role, avatar, gender, birthdate, status, login_type, social_id, created_at "
                +
                "FROM users WHERE id = :id";

        return DBContext.get().withHandle(handle -> handle.createQuery(sql)
                .bind("id", id)
                .map((rs, ctx) -> {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setFullName(rs.getString("fullname"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setPhone(rs.getString("phone"));
                    u.setRole(rs.getInt("role"));
                    u.setAvatar(rs.getString("avatar"));
                    u.setGender(rs.getString("gender"));
                    u.setBirthDate(rs.getDate("birthdate"));
                    u.setStatus(rs.getInt("status"));
                    u.setLoginType(rs.getString("login_type"));
                    u.setSocialId(rs.getString("social_id"));
                    u.setCreatedAt(rs.getTimestamp("created_at"));
                    return u;
                })
                .findFirst()
                .orElse(null));
    }

    // 12. Thống kê: Đếm tổng số thành viên
    public int countTotalUsers() {
        return DBContext.get().withHandle(handle -> handle.createQuery("SELECT COUNT(*) FROM users")
                .mapTo(Integer.class)
                .one());
    }

    // Thêm vào trong UserDAO.java
    public List<model.Address> getAllAddressesByUserId(int userId) {
        String sql = "SELECT id, user_id, receiver_name, phone_number, address, city, is_default " +
                "FROM user_addresses WHERE user_id = ?";

        return DBContext.get().withHandle(handle -> handle.createQuery(sql)
                .bind(0, userId)
                .map((rs, ctx) -> {
                    model.Address addr = new model.Address();
                    addr.setId(rs.getInt("id"));
                    addr.setUserId(rs.getInt("user_id"));
                    addr.setReceiverName(rs.getString("receiver_name"));
                    addr.setPhoneNumber(rs.getString("phone_number"));
                    addr.setAddress(rs.getString("address"));
                    addr.setCity(rs.getString("city"));
                    addr.setDefault(rs.getBoolean("is_default"));
                    return addr;
                })
                .list());
    }
}