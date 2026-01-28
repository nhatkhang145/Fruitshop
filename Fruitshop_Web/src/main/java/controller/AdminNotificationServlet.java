package controller;

import dal.NotificationDAO;
import model.Notification;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminNotificationServlet", urlPatterns = {"/admin/notifications"})
public class AdminNotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        NotificationDAO notificationDAO = new NotificationDAO();
        String action = request.getParameter("action");
        if ("markAllRead".equals(action)) {
            notificationDAO.markAllAsRead();
            // Sau khi update xong thì load lại trang thông báo
            response.sendRedirect("notifications");
            return;
        }

        // Xử lý xóa thông báo
        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                notificationDAO.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // Xóa xong thì load lại trang hiện tại
            response.sendRedirect("notifications");
            return;
        }

        // Xử lý phân trang
        int page = 1;
        int pageSize = 10; // Số thông báo trên 1 trang

        try {
            String pageStr = request.getParameter("page");
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        // Tính toán Offset (Vị trí bắt đầu lấy dữ liệu trong DB)
        int offset = (page - 1) * pageSize;

        // Lấy dữ liệu
        List<Notification> list = notificationDAO.getNotificationsWithPagination(offset, pageSize);
        int totalNotifications = notificationDAO.getTotalNotifications();
        int unreadCount = notificationDAO.countUnread();

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalNotifications / pageSize);

        request.setAttribute("notificationList", list);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("unreadCount", unreadCount);

        request.getRequestDispatcher("/admin/notifications.jsp").forward(request, response);
    }
}