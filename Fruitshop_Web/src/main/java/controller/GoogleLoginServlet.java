package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.GoogleOAuthConfig;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet(name = "GoogleLoginServlet", urlPatterns = {"/login-google-redirect"})
public class GoogleLoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Tạo state random để bảo mật (CSRF protection)
        String state = java.util.UUID.randomUUID().toString();
        request.getSession().setAttribute("oauth_state", state);
        
        // Build Google OAuth URL
        String authUrl = GoogleOAuthConfig.AUTHORIZATION_URL +
                "?client_id=" + URLEncoder.encode(GoogleOAuthConfig.CLIENT_ID, "UTF-8") +
                "&redirect_uri=" + URLEncoder.encode(GoogleOAuthConfig.REDIRECT_URI, "UTF-8") +
                "&response_type=code" +
                "&scope=" + URLEncoder.encode(GoogleOAuthConfig.SCOPE, "UTF-8") +
                "&state=" + state +
                "&access_type=offline" +
                "&prompt=consent";
        
        // Redirect user đến Google login page
        response.sendRedirect(authUrl);
    }
}
