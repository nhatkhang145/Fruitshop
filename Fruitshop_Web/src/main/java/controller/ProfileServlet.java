package controller;

import dal.UserDAO;
import model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 15     // 15 MB
)
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy địa chỉ từ bảng user_addresses để hiển thị lên form (vì trong User object không có)
        UserDAO dao = new UserDAO();
        String currentAddress = dao.getUserAddress(user.getId());

        request.setAttribute("userAddress", currentAddress); // Gửi địa chỉ sang JSP
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Lấy dữ liệu từ Form (multipart/form-data)
        // QUAN TRỌNG: Với enctype="multipart/form-data", phải dùng getPart() cho cả text fields
        String fullName = getPartValue(request, "fullname");
        String phone = getPartValue(request, "phone");
        String address = getPartValue(request, "address");
        String gender = getPartValue(request, "gender");
        String birthDay = getPartValue(request, "birthDay");
        String birthMonth = getPartValue(request, "birthMonth");
        String birthYear = getPartValue(request, "birthYear");
        
        // Xử lý upload avatar
        String avatarUrl = null;
        Part avatarPart = request.getPart("avatarFile");
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = "avatar_" + user.getId() + "_" + System.currentTimeMillis() + extension;
            
            // Đường dẫn lưu file
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads" + File.separator + "avatars";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // Lưu file
            String filePath = uploadPath + File.separator + newFileName;
            avatarPart.write(filePath);
            
            // URL để lưu vào database
            avatarUrl = request.getContextPath() + "/uploads/avatars/" + newFileName;
        }
        
        // Giả sử form chưa có ô nhập Thành phố, ta tạm để mặc định hoặc lấy từ form nếu có
        String city = "Hồ Chí Minh"; // Hoặc getPartValue(request, "city");

        // 2. Cập nhật Object User (để lưu session)
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setGender(gender);
        
        // Cập nhật avatar nếu có
        if (avatarUrl != null && !avatarUrl.trim().isEmpty()) {
            user.setAvatar(avatarUrl);
        }
        // Lưu ý: User.java KHÔNG CÓ setAddress, nên đừng gọi nó ở đây

 // Xử lý birthDate
        if (birthDay != null && !birthDay.isEmpty()
                && birthMonth != null && !birthMonth.isEmpty()
                && birthYear != null && !birthYear.isEmpty()) {
            // Format: yyyy-MM-dd
            String dateStr = String.format("%s-%02d-%02d",
                    birthYear,
                    Integer.parseInt(birthMonth),
                    Integer.parseInt(birthDay));
            java.sql.Date birthDate = java.sql.Date.valueOf(dateStr);
            user.setBirthDate(birthDate);
        }

        UserDAO dao = new UserDAO();
        try {
            // 3. Cập nhật bảng users (Tên, SĐT)
            dao.updateProfile(user);

            // 4. Cập nhật bảng user_addresses (Địa chỉ)
            // Lưu ý: receiver_name tạm lấy là fullname của user
            if (address != null && !address.trim().isEmpty()) {
                dao.updateAddress(user.getId(), address, city, fullName, phone);
            }

            // 5. Lưu lại session
            session.setAttribute("account", user);
            request.setAttribute("message", "Cập nhật thành công!");

            // Gửi lại địa chỉ mới để hiển thị
            request.setAttribute("userAddress", address);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi: " + e.getMessage());
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
    
    // Helper method để đọc text value từ multipart form
    private String getPartValue(HttpServletRequest request, String partName) throws IOException, ServletException {
        Part part = request.getPart(partName);
        if (part == null) {
            return null;
        }
        
        // Đọc text content từ Part
        java.io.BufferedReader reader = new java.io.BufferedReader(
            new java.io.InputStreamReader(part.getInputStream(), "UTF-8")
        );
        StringBuilder value = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            value.append(line);
        }
        return value.toString();
    }
}