package utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import model.User;

import java.util.Properties;
import java.util.Random;

public class EmailUtils {

    public static String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    public static boolean sendEmail(User user, String code) {
        boolean test = false;
        String toEmail = user.getEmail();
        String fromEmail = "your_email@gmail.com"; // Thay bằng email của bạn
        String password = "your_app_password"; // Thay bằng mật khẩu ứng dụng của bạn

        try {
            Properties pr = configEmail(new Properties());
            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message mess = new MimeMessage(session);
            mess.setHeader("Content-Type", "text/plain; charset=UTF-8");
            mess.setFrom(new InternetAddress(fromEmail));
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            mess.setSubject("Confirm Code - Organic Harvest");
            mess.setText("Chào bạn,\n\nMã xác thực OTP của bạn là: " + code + "\n\nMã này sẽ hết hạn sau 5 phút. Vui lòng không chia sẻ mã này cho ai khác.");

            Transport.send(mess);
            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return test;
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