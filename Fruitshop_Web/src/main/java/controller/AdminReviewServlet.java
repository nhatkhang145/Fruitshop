package controller;

import dal.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminReviewServlet", urlPatterns = {"/admin/review-action"})
public class AdminReviewServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        ReviewDAO dao = new ReviewDAO();

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            if ("reply".equals(action)) {
                String content = request.getParameter("replyContent");
                dao.replyReview(id, content);
            } else if ("hide".equals(action)) {
                dao.updateStatus(id, "hidden");
            } else if ("show".equals(action)) {
                dao.updateStatus(id, "visible");
            } else if ("delete".equals(action)) {
                dao.deleteReview(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Quay lại trang quản lý
        response.sendRedirect("reviews.jsp");
    }
}