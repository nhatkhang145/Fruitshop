package util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import model.User;

import java.io.InputStream;
import java.util.Properties;
import java.util.Random;

public class EmailUtils {

    public static String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    public static boolean sendEmail(User user, String code) {
        // 1. Đọc thông tin từ file mail.properties
        Properties props = new Properties();
        try (InputStream input = EmailUtils.class.getClassLoader().getResourceAsStream("mail.properties")) {

            if (input == null) {
                System.out.println("Lỗi: Không tìm thấy file mail.properties");
                return false;
            }
            // Nạp toàn bộ cấu hình vào biến props
            props.load(input);

        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }

        // 2. Lấy thông tin đăng nhập từ file cấu hình (Không còn hardcode)
        final String fromEmail = props.getProperty("mail.username");
        final String password = props.getProperty("mail.password");

        // 3. Tạo phiên gửi mail (Session)
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        // 4. Thực hiện gửi
        try {
            Message mess = new MimeMessage(session);
            mess.setHeader("Content-Type", "text/plain; charset=UTF-8");
            mess.setFrom(new InternetAddress(fromEmail));
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(user.getEmail()));
            mess.setSubject("Xác thực OTP - Organic Harvest");
            mess.setText("Chào bạn,\n\nMã xác thực OTP của bạn là: " + code + "\n\nMã này sẽ hết hạn sau 5 phút.");

            Transport.send(mess);
            System.out.println("Đã gửi mail thành công tới: " + user.getEmail());
            return true;
        } catch (Exception e) {
            System.out.println("Gửi mail thất bại!");
            e.printStackTrace();
            return false;
        }
    }

    private static Properties configEmail(Properties pr) {
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");
        pr.put("mail.smtp.socketFactory.port", "587");
        pr.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        return pr;
    }
}