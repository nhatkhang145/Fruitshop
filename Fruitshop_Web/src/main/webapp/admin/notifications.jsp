<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/notifications.css" />
    <title>Thông báo</title>
    <style>
        /* 1. Thiết lập Flexbox cho dòng thông báo */
        .log-item {
            display: flex !important; /* Bắt buộc dùng flex */
            align-items: center;
            justify-content: space-between; /* Đẩy nút xóa sang phải */
            padding: 15px;
            border-bottom: 1px solid #eee;
            transition: all 0.3s ease;
        }

        /* 2. Phần nội dung chính (Click để xem) */
        .notification-content-link {
            display: flex;
            align-items: center;
            flex-grow: 1; /* Chiếm hết khoảng trống còn lại */
            text-decoration: none; /* Bỏ gạch chân */
            color: inherit; /* Giữ màu chữ gốc (đen/xám) */
            margin-right: 15px; /* Cách nút xóa một chút */
        }

        .notification-content-link:hover {
            opacity: 0.8;
        }

        /* 3. Chỉnh icon loại thông báo */
        .log-item .item-icon {
            font-size: 24px;
            margin-right: 15px;
            min-width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #f1f1f1;
            color: #333;
        }

        /* 4. Nút xóa (Thùng rác) */
        .btn-delete {
            color: #ff4d4d; /* Màu đỏ */
            font-size: 20px;
            padding: 8px;
            border-radius: 50%;
            transition: all 0.2s;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .btn-delete:hover {
            background-color: #ffe6e6; /* Nền đỏ nhạt khi hover */
            transform: scale(1.1);
        }

        /* Màu nền cho tin chưa đọc */
        .log-item.unread {
            background-color: #f8faff;
        }
        .log-item.unread .item-icon {
            background-color: #cfe2ff;
            color: #0d6efd;
        }
    </style>
</head>

<body>
    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="notifications" />
    </jsp:include>

    <!-- Main Content -->
    <div class="content">
        <!-- Navbar -->
        <nav>
            <i class="bx bx-menu"></i>
            <form action="#">
            <div class="form-input">
                <input type="search" placeholder="Search..." />
                <button class="search-btn" type="submit">
                <i class="bx bx-search"></i>
                </button>
            </div>
            </form>

            <div class="notification-wrapper">
                <a href="#" class="notif" id="notifBtn">
                    <i class="bx bx-bell"></i>
                    <c:if test="${unreadCount > 0}">
                        <span class="count">${unreadCount}</span>
                    </c:if>
                </a>

                <div class="notification-dropdown" id="notifDropdown">
                    <h3 class="dropdown-header">Thông báo mới</h3>
                    <ul class="notification-list">
                        <c:forEach items="${notificationList}" var="n" end="4">
                            <li class="notification-item ${n.isRead == 0 ? 'unread' : ''}">
                                <a href="${pageContext.request.contextPath}${n.link}" class="notification-link">
                                    <i class="bx ${n.iconClass} item-icon"></i>
                                    <div class="item-content">
                                        <p><strong>${n.title}</strong></p>
                                        <span>${n.message}</span>
                                        <small><fmt:formatDate value="${n.createdAt}" pattern="HH:mm dd/MM/yyyy"/></small>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>

                        <c:if test="${empty notificationList}">
                            <li class="notification-item">
                                <div class="item-content" style="padding: 10px; text-align: center;">
                                    <span>Không có thông báo mới</span>
                                </div>
                            </li>
                        </c:if>
                    </ul>
                    <div class="dropdown-footer">
                        <a href="/admin/notifications.jsp">Xem tất cả thông báo</a>
                    </div>
                </div>
            </div>
            <div class="profile-wrapper">
                <a href="#" class="profile" id="profileBtn">
                    <img src="images/logo.png" />
                </a>

                <div class="profile-dropdown" id="profileDropdown">
                    <h3 class="dropdown-header">Tài khoản</h3>
                    <ul class="profile-menu">
                        <li>
                            <a href="/admin/profile.jsp">
                              <i class="bx bxs-user-circle"></i>
                              <span>Hồ sơ của tôi</span>
                            </a>
                        </li>
                        <li>
                            <a href="/admin/profile.jsp#changepassword">
                               <i class="bx bxs-lock-alt"></i>
                               <span>Đổi mật khẩu</span>
                            </a>
                        </li>

                        <li class="profile-menu-toggle">
                            <i class="bx bx-moon"></i>
                            <span>Chế độ Tối</span>

                            <input type="checkbox" id="theme-toggle" hidden />
                            <label for="theme-toggle" class="theme-toggle-dropdown"></label>
                        </li>
                        <hr />
                        <li>
                            <a href="#" class="logout">
                                <i class="bx bx-log-out-circle"></i>
                                <span>Đăng xuất</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <!-- End of Navbar -->
        <main>
            <div class="header">
                <div class="left">
                    <h1>Lịch sử Thông báo</h1>
                    <ul class="breadcrumb">
                        <li><a href="#">Quản lý</a></li>
                        <li>/</li>
                        <li><a href="#" class="active">Thông báo</a></li>
                    </ul>
                </div>
            </div>

            <div class="bottom-data">
                <div class="orders">
                    <div class="header">
                        <h3>Tất cả Thông báo</h3>
                        <a href="notifications?action=markAllRead" class="btn-primary" id="markAllAsReadBtn">
                            <i class="bx bx-check-double"></i>
                            <span>Đánh dấu tất cả là đã đọc</span>
                        </a>
                    </div>

                    <ul class="notification-log">
                        <c:forEach items="${notificationList}" var="n">
                            <li class="log-item ${n.isRead == 0 ? 'unread' : ''}">

                                <a href="${pageContext.request.contextPath}${n.link}" class="notification-content-link">
                                    <i class="bx ${n.iconClass} item-icon"></i>

                                    <div class="item-content">
                                        <p style="margin-bottom: 4px;">
                                            <strong>${n.title}:</strong> ${n.message}
                                        </p>
                                        <small style="color: #888;">
                                            <fmt:formatDate value="${n.createdAt}" pattern="HH:mm dd/MM/yyyy"/>
                                        </small>
                                    </div>
                                </a>

                                <a href="notifications?action=delete&id=${n.id}"
                                   class="btn-delete"
                                   title="Xóa thông báo"
                                   onclick="return confirm('Bạn có chắc chắn muốn xóa thông báo này?');">
                                    <i class='bx bx-trash'></i>
                                </a>

                            </li>
                        </c:forEach>

                        <c:if test="${empty notificationList}">
                            <li class="log-item" style="justify-content: center;">
                                <p>Hiện chưa có thông báo nào.</p>
                            </li>
                        </c:if>
                    </ul>

                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="notifications?page=${currentPage - 1}" class="page-btn">&laquo;</a>
                        </c:if>
                        <c:if test="${currentPage <= 1}">
                            <a href="#" class="page-btn disabled">&laquo;</a>
                        </c:if>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="notifications?page=${i}"
                               class="page-btn ${currentPage == i ? 'active' : ''}">
                               ${i}
                            </a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="notifications?page=${currentPage + 1}" class="page-btn">&raquo;</a>
                        </c:if>
                        <c:if test="${currentPage >= totalPages}">
                            <a href="#" class="page-btn disabled">&raquo;</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </main>
    </div>

<script src="../assets/js/admin/main.js"></script>
</body>

</html>