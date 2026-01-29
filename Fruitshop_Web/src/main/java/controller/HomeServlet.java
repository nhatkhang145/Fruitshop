package controller;

import dal.BannerDAO;
import dal.CategoryDAO;
import dal.ProductDAO;
import dal.WeekendDealDAO;
import dal.WishlistDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Banner;
import model.Category;
import model.Product;
import model.User;
import model.WeekendDeal;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {
    
    private BannerDAO bannerDAO = new BannerDAO();
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private WishlistDAO wishlistDAO = new WishlistDAO();
    private WeekendDealDAO dealDAO = new WeekendDealDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Load active banners cho slide
        List<Banner> banners = bannerDAO.getActiveBanners();
        request.setAttribute("banners", banners);
        
        // 2. Load categories cho header
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("listC", categories);
        
        // 3. Load sản phẩm mới nhất (Top Offers - thay vì hardcode)
        List<Product> newProducts = productDAO.getNewestProducts(16);
        request.setAttribute("newProducts", newProducts);
        
        // 4. Load sản phẩm bán chạy (Trending)
        List<Product> trendingProducts = productDAO.getBestSellingProducts(12);
        request.setAttribute("trendingProducts", trendingProducts);
        
        // 5. Load weekend deals
        List<WeekendDeal> weekendDeals = dealDAO.getActiveDeals();
        request.setAttribute("weekendDeals", weekendDeals);
        
        // 5.1. Load weekend deals Map cho product cards
        java.util.Map<Integer, WeekendDeal> weekendDealMap = dealDAO.getActiveDealsByProductIds();
        request.setAttribute("weekendDealMap", weekendDealMap);
        
        // 6. Load wishlist IDs và count nếu user đã đăng nhập
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");
        List<Integer> likedIds = new ArrayList<>();
        if (user != null) {
            likedIds = wishlistDAO.getLikedProductIds(user.getId());
            // Cập nhật số lượng wishlist vào session
            int wishlistCount = wishlistDAO.countWishlist(user.getId());
            session.setAttribute("wishlistCount", wishlistCount);
        } else {
            session.setAttribute("wishlistCount", 0);
        }
        request.setAttribute("likedIds", likedIds);
        
        // Forward đến index.jsp
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
