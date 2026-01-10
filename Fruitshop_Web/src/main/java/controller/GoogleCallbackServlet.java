package controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.GoogleOAuthConfig;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;

@WebServlet(name = "GoogleCallbackServlet", urlPatterns = {"/login-google"})
public class GoogleCallbackServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Lấy authorization code từ Google
        String code = request.getParameter("code");
        String state = request.getParameter("state");
        String error = request.getParameter("error");
        
        // Check error
        if (error != null) {
            request.setAttribute("error", "Đăng nhập Google thất bại: " + error);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        // Check CSRF
        String sessionState = (String) request.getSession().getAttribute("oauth_state");
        if (state == null || !state.equals(sessionState)) {
            request.setAttribute("error", "Lỗi bảo mật. Vui lòng thử lại.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        try {
            // 2. Exchange code for access token
            String accessToken = getAccessToken(code);
            
            // 3. Get user info from Google
            JsonObject userInfo = getUserInfo(accessToken);
            
            String googleId = userInfo.get("id").getAsString();
            String email = userInfo.get("email").getAsString();
            String name = userInfo.get("name").getAsString();
            String picture = userInfo.has("picture") ? userInfo.get("picture").getAsString() : null;
            
            // 4. Check if user exists in database
            User user = userDAO.getUserByEmail(email);
            
            if (user == null) {
                // Tạo user mới từ Google
                user = new User();
                user.setFullName(name);
                user.setEmail(email);
                user.setPassword(null); // Google login không có password
                user.setAvatar(picture);
                user.setLoginType("google");
                user.setSocialId(googleId);
                user.setRole(0); // Khách hàng
                user.setStatus(1); // Active
                user.setCreatedAt(new Timestamp(System.currentTimeMillis()));
                
                userDAO.insertUser(user);
                user = userDAO.getUserByEmail(email); // Get lại để có ID
            } else {
                // User đã tồn tại
                if (user.getStatus() == 0) {
                    request.setAttribute("error", "Tài khoản này đã bị khóa.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                    return;
                }
                
                // Update social info nếu chưa có
                if (user.getSocialId() == null || user.getSocialId().isEmpty()) {
                    user.setSocialId(googleId);
                    user.setLoginType("google");
                    if (picture != null && (user.getAvatar() == null || user.getAvatar().contains("default-user"))) {
                        user.setAvatar(picture);
                    }
                    userDAO.updateSocialInfo(user);
                }
            }
            
            // 5. Lưu user vào session
            HttpSession session = request.getSession();
            session.setAttribute("account", user);
            session.setAttribute("user", user);
            session.removeAttribute("oauth_state");
            
            // 6. Redirect về trang phù hợp
            if (user.getRole() == 1) {
                response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi đăng nhập Google: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
    
    // Exchange authorization code for access token
    private String getAccessToken(String code) throws IOException {
        URL url = new URL(GoogleOAuthConfig.TOKEN_URL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setDoOutput(true);
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        
        String params = "code=" + URLEncoder.encode(code, "UTF-8") +
                "&client_id=" + URLEncoder.encode(GoogleOAuthConfig.CLIENT_ID, "UTF-8") +
                "&client_secret=" + URLEncoder.encode(GoogleOAuthConfig.CLIENT_SECRET, "UTF-8") +
                "&redirect_uri=" + URLEncoder.encode(GoogleOAuthConfig.REDIRECT_URI, "UTF-8") +
                "&grant_type=authorization_code";
        
        try (OutputStream os = conn.getOutputStream()) {
            os.write(params.getBytes("UTF-8"));
        }
        
        // Read response
        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }
        
        // Parse JSON response
        JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
        return jsonResponse.get("access_token").getAsString();
    }
    
    // Get user info from Google
    private JsonObject getUserInfo(String accessToken) throws IOException {
        URL url = new URL(GoogleOAuthConfig.USER_INFO_URL + "?access_token=" + accessToken);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        
        // Read response
        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"))) {
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
        }
        
        return JsonParser.parseString(response.toString()).getAsJsonObject();
    }
}
