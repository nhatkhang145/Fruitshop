package dal;

import model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // 1. Kiểm tra Email tồn tại
    public boolean checkExist(String email) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT * FROM users WHERE email = ?";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return false;
    }

    // 2. Đăng ký người dùng mới
    public void signup(String fullname, String email, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        String query = "INSERT INTO users (fullname, email, password, role, status, login_type) VALUES (?, ?, ?, 0, 1, 'local')";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(" LỖI SIGNUP: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
    }

    // 3. Đăng nhập - Kiểm tra chỉ tài khoản active (status = 1)
    public User checkLogin(String email, String password) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT * FROM users WHERE email = ? AND password = ? AND status = 1";
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setFullName(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getInt("role"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return null;
    }

    // Đóng tài nguyên để tránh memory leak
    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 4. Cập nhật thông tin User (Tên, Số điện thoại)
    public void update(User user) {
        Connection conn = null;
        PreparedStatement ps = null;

        String query = "UPDATE users SET fullname = ?, phone = ?, WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhone());
            ps.setInt(3, user.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("Lỗi updateUser: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
    }

    // 5. Đổi mật khẩu
    public void changePassword(int id, String newPassword) {
        Connection conn = null;
        PreparedStatement ps = null;
        String query = "UPDATE users SET password = ? WHERE id = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(query);

            ps.setString(1, newPassword);
            ps.setInt(2, id);

            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println("Lỗi changePassword: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
    }
}