<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <span class="count">12</span>
          </a>

          <div class="notification-dropdown" id="notifDropdown">
            <h3 class="dropdown-header">Thông báo mới</h3>
            <ul class="notification-list">
              <li class="notification-item unread">
                <i class="bx bx-cart-add item-icon"></i>
                <div class="item-content">
                  <p><strong>Đơn hàng mới</strong></p>
                  <span>Bạn có đơn hàng #12350 từ Nguyễn Văn A.</span>
                  <small>2 phút trước</small>
                </div>
              </li>
              <li class="notification-item unread">
                <i class="bx bx-user-plus item-icon"></i>
                <div class="item-content">
                  <p><strong>Khách hàng mới</strong></p>
                  <span>Trần Thị B vừa đăng ký tài khoản.</span>
                  <small>1 giờ trước</small>
                </div>
              </li>
              <li class="notification-item">
                <i class="bx bxs-error-circle item-icon"></i>
                <div class="item-content">
                  <p><strong>Hết hàng</strong></p>
                  <span>Sản phẩm "Dâu tây Hàn Quốc" đã hết hàng.</span>
                  <small>Hôm qua</small>
                </div>
              </li>
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
              <a href="#" class="btn-primary" id="markAllAsReadBtn">
                <i class="bx bx-check-double"></i>
                <span>Đánh dấu tất cả là đã đọc</span>
              </a>
            </div>

            <ul class="notification-log">
              <li class="log-item unread">
                <i class="bx bx-cart-add item-icon"></i>
                <div class="item-content">
                  <p>
                    <strong>Đơn hàng mới:</strong> Bạn có đơn hàng
                    <strong>#12350</strong> từ Nguyễn Văn A.
                  </p>
                  <small>2 phút trước</small>
                </div>
              </li>

              <li class="log-item unread">
                <i class="bx bx-user-plus item-icon"></i>
                <div class="item-content">
                  <p>
                    <strong>Khách hàng mới:</strong> Trần Thị B vừa đăng ký tài
                    khoản.
                  </p>
                  <small>1 giờ trước</small>
                </div>
              </li>

              <li class="log-item">
                <i class="bx bxs-error-circle item-icon"></i>
                <div class="item-content">
                  <p>
                    <strong>Hết hàng:</strong> Sản phẩm
                    <strong>"Dâu tây Hàn Quốc"</strong> đã hết hàng.
                  </p>
                  <small>Hôm qua</small>
                </div>
              </li>

              <li class="log-item">
                <i class="bx bx-cart item-icon"></i>
                <div class="item-content">
                  <p>
                    <strong>Đơn hàng đã hoàn thành:</strong> Đơn hàng
                    <strong>#12344</strong> đã được giao thành công.
                  </p>
                  <small>2 ngày trước</small>
                </div>
              </li>

              <li class="log-item">
                <i class="bx bx-message-detail item-icon"></i>
                <div class="item-content">
                  <p>
                    <strong>Tin nhắn mới:</strong> Bạn có tin nhắn mới từ Lê Văn
                    C.
                  </p>
                  <small>3 ngày trước</small>
                </div>
              </li>
            </ul>

            <div class="pagination">
              <a href="#" class="page-btn disabled">&laquo;</a>
              <a href="#" class="page-btn active">1</a>
              <a href="#" class="page-btn">2</a>
              <a href="#" class="page-btn">&raquo;</a>
            </div>
          </div>
        </div>
      </main>
    </div>

    <script src="../assets/js/admin/main.js"></script>
  </body>

  </html>