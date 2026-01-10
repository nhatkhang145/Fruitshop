package util;

public class GoogleOAuthConfig {
    
    // Google OAuth credentials
    public static final String CLIENT_ID = "479109820340-820s5m6iqbvauc9nqpojn3o6ica42hhc.apps.googleusercontent.com";
    public static final String CLIENT_SECRET = "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";
    public static final String REDIRECT_URI = "http://localhost:8080/Fruitshop_Web/login-google";
    
    // Google OAuth endpoints
    public static final String AUTHORIZATION_URL = "https://accounts.google.com/o/oauth2/v2/auth";
    public static final String TOKEN_URL = "https://oauth2.googleapis.com/token";
    public static final String USER_INFO_URL = "https://www.googleapis.com/oauth2/v2/userinfo";
    
    // Scopes
    public static final String SCOPE = "openid email profile";
}
