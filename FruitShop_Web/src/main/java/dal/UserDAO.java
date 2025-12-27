package dal;

import model.User;
import java.util.Optional;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    
    // 1. Kiểm tra Email tồn tại (Viết lại bằng Jdbi)
    public boolean checkExist(String email) {
        String query = "SELECT COUNT(*) FROM users WHERE email = ?";
        // withHandle tự động mở và đóng kết nối, không cần try-catch
        return DBContext.get().withHandle(handle -> 
            handle.createQuery(query)
                  .bind(0, email) // Gán email vào dấu ? đầu tiên
                  .mapTo(Integer.class)
                  .one() > 0
        );
    }

    // 2. Đăng ký người dùng mới
    public void signup(String fullname, String email, String password) {
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
                  .mapToBean(User.class) // Tự động mapping cột SQL vào class User
                  .findFirst()
                  .orElse(null) // Nếu không tìm thấy thì trả về null
        );
    }

    // 4. Cập nhật thông tin User (Tên, Số điện thoại)
    public void update(User user) {
        String query = "UPDATE users SET fullname = ?, phone = ? WHERE id = ?";

        DBContext.get().useHandle(handle ->
                handle.createUpdate(query)
                        .bind(0, user.getFullName())
                        .bind(1, user.getPhone())
                        .bind(2, user.getId())
                        .execute()
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