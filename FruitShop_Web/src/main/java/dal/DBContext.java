package dal;

import org.jdbi.v3.core.Jdbi;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Properties;

public class DBContext {
    private static Jdbi jdbi;

    // Khối static này sẽ chạy ngay khi gọi DBContext lần đầu
    static {
        try {
            // 1. Đọc file properties từ thư mục resources
            InputStream is = DBContext.class.getClassLoader().getResourceAsStream("db.properties");
            Properties props = new Properties();

            if (is == null) {
                throw new RuntimeException("Không tìm thấy file db.properties trong resources!");
            }
            props.load(is);

            // 2. Lấy thông tin cấu hình
            String driver = props.getProperty("db.driver");
            String url = props.getProperty("db.url");
            String user = props.getProperty("db.username");
            String pass = props.getProperty("db.password");

            // 3. Nạp Driver (Bắt buộc với một số phiên bản cũ)
            Class.forName(driver);

            // 4. Tạo kết nối Jdbi
            jdbi = Jdbi.create(url, user, pass);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khởi tạo kết nối Database: " + e.getMessage());
        }
    }

    // Hàm này để các DAO gọi lấy kết nối
    public static Jdbi get() {
        return jdbi;
    }

    // Test thử kết nối luôn
    public static void main(String[] args) {
        try {
            var handle = DBContext.get().open();
            System.out.println("Kết nối Database thành công!");
            handle.close();
        } catch (Exception e) {
            System.out.println("Kết nối thất bại!");
            e.printStackTrace();
        }
    }
}