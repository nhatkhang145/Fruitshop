package controller.admin;

import dal.WeekendDealDAO;
import dal.ProductDAO;
import model.WeekendDeal;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.text.SimpleDateFormat;
import java.sql.Timestamp;

@WebServlet(name = "WeekendDealsServlet", urlPatterns = {"/admin/weekend-deals", "/admin/weekend-deal-edit"})
public class WeekendDealsServlet extends HttpServlet {

    private final WeekendDealDAO dealDAO = new WeekendDealDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String path = request.getServletPath();
        
        if (path.equals("/admin/weekend-deal-edit")) {
            showEditPage(request, response);
        } else {
            String action = request.getParameter("action");
            
            if (action != null) {
                switch (action) {
                    case "delete":
                        handleDelete(request, response, session);
                        return;
                    case "toggle":
                        handleToggleStatus(request, response, session);
                        return;
                }
            }

            // Load all deals
            List<WeekendDeal> deals = dealDAO.getAllDeals();
            request.setAttribute("deals", deals);
            request.getRequestDispatcher("weekend-deals.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        handleSave(request, response, session);
    }

    /**
     * Hiển thị trang thêm/sửa deal
     */
    private void showEditPage(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String dealIdStr = request.getParameter("id");
        
        if (dealIdStr != null) {
            // Edit mode
            try {
                int dealId = Integer.parseInt(dealIdStr);
                WeekendDeal deal = dealDAO.getDealById(dealId);
                
                if (deal != null) {
                    request.setAttribute("deal", deal);
                } else {
                    request.getSession().setAttribute("errorMessage", "❌ Không tìm thấy deal!");
                    response.sendRedirect(request.getContextPath() + "/admin/weekend-deals");
                    return;
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("errorMessage", "❌ ID không hợp lệ!");
                response.sendRedirect(request.getContextPath() + "/admin/weekend-deals");
                return;
            }
        }
        
        // Load all products for selection
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        
        request.getRequestDispatcher("weekend-deal-edit.jsp").forward(request, response);
    }

    /**
     * Lưu deal (thêm mới hoặc cập nhật)
     */
    private void handleSave(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws IOException {
        try {
            String dealIdStr = request.getParameter("dealId");
            int productId = Integer.parseInt(request.getParameter("productId"));
            String tag = request.getParameter("tag");
            String subtitle = request.getParameter("subtitle");
            int discountPercent = Integer.parseInt(request.getParameter("discountPercent"));
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            int status = request.getParameter("status") != null ? 1 : 0;
            int sortOrder = Integer.parseInt(request.getParameter("sortOrder"));

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Timestamp startDate = new Timestamp(sdf.parse(startDateStr).getTime());
            Timestamp endDate = new Timestamp(sdf.parse(endDateStr).getTime());

            WeekendDeal deal = new WeekendDeal();
            deal.setProductId(productId);
            deal.setTag(tag);
            deal.setSubtitle(subtitle);
            deal.setDiscountPercent(discountPercent);
            deal.setStartDate(startDate);
            deal.setEndDate(endDate);
            deal.setStatus(status);
            deal.setSortOrder(sortOrder);

            boolean success;
            if (dealIdStr != null && !dealIdStr.isEmpty()) {
                // Update
                deal.setId(Integer.parseInt(dealIdStr));
                success = dealDAO.updateDeal(deal);
                session.setAttribute("successMessage", success ? "✅ Cập nhật deal thành công!" : "❌ Cập nhật thất bại!");
            } else {
                // Insert
                success = dealDAO.insertDeal(deal);
                session.setAttribute("successMessage", success ? "✅ Thêm deal mới thành công!" : "❌ Thêm deal thất bại!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "❌ Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/weekend-deals");
    }

    /**
     * Xóa deal
     */
    private void handleDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws IOException {
        try {
            int dealId = Integer.parseInt(request.getParameter("id"));
            
            if (dealDAO.deleteDeal(dealId)) {
                session.setAttribute("successMessage", "✅ Đã xóa deal thành công!");
            } else {
                session.setAttribute("errorMessage", "❌ Không thể xóa deal. Vui lòng thử lại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "❌ Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/weekend-deals");
    }

    /**
     * Bật/tắt deal
     */
    private void handleToggleStatus(HttpServletRequest request, HttpServletResponse response, HttpSession session) 
            throws IOException {
        try {
            int dealId = Integer.parseInt(request.getParameter("id"));
            WeekendDeal deal = dealDAO.getDealById(dealId);
            
            if (deal != null) {
                int newStatus = deal.getStatus() == 1 ? 0 : 1;
                deal.setStatus(newStatus);
                
                if (dealDAO.updateDeal(deal)) {
                    session.setAttribute("successMessage", 
                        newStatus == 1 ? "✅ Đã BẬT deal!" : "⚠️ Đã TẮT deal!");
                } else {
                    session.setAttribute("errorMessage", "❌ Không thể cập nhật trạng thái!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "❌ Lỗi: " + e.getMessage());
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/weekend-deals");
    }
}
