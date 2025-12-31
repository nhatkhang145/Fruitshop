package controller;

import dal.ReviewDAO;
import model.Review;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (action != null && action.equals("add")) {
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int rating = Integer.parseInt(request.getParameter("rating"));
                String comment = request.getParameter("comment");

                Review review = new Review();
                review.setUserId(user.getId());
                review.setProductId(productId);
                review.setRating(rating);
                review.setComment(comment);

                ReviewDAO dao = new ReviewDAO();
                dao.insertReview(review);

                // Reload lại trang chi tiết sản phẩm
                response.sendRedirect("product-detail?pid=" + productId + "&msg=success");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("index.jsp");
            }
        }
        else if (action != null && action.equals("delete")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                new ReviewDAO().deleteReview(id);
                response.sendRedirect(request.getContextPath() + "/admin/reviews.jsp"); // Hoặc trang quản lý admin tương ứng
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}