package dal;

import org.jdbi.v3.core.Jdbi;
import java.io.InputStream;
import java.util.Properties;

public class DBContext {
    private static Jdbi jdbi;

    // Khối static: Chạy ngay khi ứng dụng khởi động để nạp kết nối
    static {
        try {
            // 1. Đọc thông tin từ file cấu hình (db.properties)
            InputStream is = DBContext.class.getClassLoader().getResourceAsStream("db.properties");
            Properties props = new Properties();

            if (is == null) {
                // Nếu không thấy file properties, dùng cấu hình cứng (Dự phòng)
                jdbi = Jdbi.create("jdbc:mysql://localhost:3306/fruitshop_db", "root", "");
            } else {
                props.load(is);
                String driver = props.getProperty("db.driver");
                String url = props.getProperty("db.url");
                String user = props.getProperty("db.username");
                String pass = props.getProperty("db.password");
                // Nạp driver (quan trọng với Tomcat cũ)
                Class.forName(driver);
                // Tạo kết nối Jdbi
                jdbi = Jdbi.create(url, user, pass);
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(" Lỗi khởi tạo Database: " + e.getMessage());
        }
    }

    // Hàm lấy kết nối (Dùng cái này thay cho getConnection ngày xưa)
    public static Jdbi get() {
        return jdbi;
    }

    // Hàm main để test kết nối
    public static void main(String[] args) {
        try {
            System.out.println("Đang kết nối...");
            // Test thử truy vấn đơn giản
            String dbName = DBContext.get().withHandle(handle ->
                    handle.createQuery("SELECT DATABASE()").mapTo(String.class).one()
            );
            System.out.println("✅ KẾT NỐI THÀNH CÔNG TỚI DATABASE: " + dbName);
        } catch (Exception e) {
            System.out.println("❌ KẾT NỐI THẤT BẠI!");
            e.printStackTrace();
        }
    }
}