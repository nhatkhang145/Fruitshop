package controller;

import dal.BannerDAO;
import dal.CategoryDAO;
import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Banner;
import model.Category;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {
    
    private BannerDAO bannerDAO = new BannerDAO();
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    
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
        List<Product> newProducts = productDAO.getNewestProducts(10);
        request.setAttribute("newProducts", newProducts);
        
        // 4. Load sản phẩm bán chạy (Trending)
        List<Product> trendingProducts = productDAO.getBestSellingProducts(12);
        request.setAttribute("trendingProducts", trendingProducts);
        
        // Forward đến index.jsp
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
