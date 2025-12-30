<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/reports.css" />
    <title>Thống kê</title>
  </head>

  <body>

    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="reports" />
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
            <h1>Thống kê</h1>
            <ul class="breadcrumb">
              <li><a href="#">Quản lý</a></li>
              <li>/</li>
              <li><a href="#" class="active">Thống kê</a></li>
            </ul>
          </div>
          <div class="date-range-filter">
            <i class="bx bx-calendar"></i>
            <input type="date" id="dateStart" />
            <span>đến</span>
            <input type="date" id="dateEnd" />
            <button class="btn-primary">Lọc</button>
          </div>
        </div>

        <ul class="insights">
          <li>
            <i class="bx bx-dollar-circle"></i>
            <span class="info">
              <h3>15,230,000đ</h3>
              <p>Tổng Doanh thu</p>
            </span>
          </li>
          <li>
            <i class="bx bx-receipt"></i>
            <span class="info">
              <h3>1,020</h3>
              <p>Tổng Đơn hàng</p>
            </span>
          </li>
          <li>
            <i class="bx bx-line-chart"></i>
            <span class="info">
              <h3>14,931đ</h3>
              <p>Giá trị TB / Đơn</p>
            </span>
          </li>
          <li>
            <i class="bx bx-user-plus"></i>
            <span class="info">
              <h3>120</h3>
              <p>Khách hàng mới</p>
            </span>
          </li>
        </ul>

        <div class="bottom-data">
          <div class="orders">
            <div class="header">
              <h3>Doanh thu theo thời gian</h3>
              <i class="bx bx-refresh"></i>
            </div>
            <div class="chart-container">
              <canvas id="salesChart"></canvas>
            </div>
          </div>

          <div class="reminders chart-box-small">
            <div class="header">
              <h3>Doanh thu theo Danh mục</h3>
              <i class="bx bx-dots-vertical-rounded"></i>
            </div>
            <div class="chart-container pie-chart">
              <canvas id="categoryChart"></canvas>
            </div>
          </div>

          <div class="orders">
            <div class="header">
              <h3>Top sản phẩm bán chạy</h3>
              <i class="bx bx-download"></i>
            </div>
            <table>
              <thead>
                <tr>
                  <th>Sản phẩm</th>
                  <th>Số lượng bán</th>
                  <th>Doanh thu</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/36x36" alt="Táo" />
                    <p>Táo Envy New Zealand</p>
                  </td>
                  <td>120</td>
                  <td>30,000,000đ</td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/36x36" alt="Nho" />
                    <p>Nho không hạt Úc</p>
                  </td>
                  <td>95</td>
                  <td>28,500,000đ</td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/36x36" alt="Dâu" />
                    <p>Dâu tây Hàn Quốc</p>
                  </td>
                  <td>80</td>
                  <td>25,000,000đ</td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="orders">
            <div class="header">
              <h3>Top khách hàng chi tiêu</h3>
              <i class="bx bx-download"></i>
            </div>
            <table>
              <thead>
                <tr>
                  <th>Khách hàng</th>
                  <th>Số đơn hàng</th>
                  <th>Tổng chi tiêu</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/36x36" alt="Avatar" />
                    <p>Nguyễn Văn A</p>
                  </td>
                  <td>25</td>
                  <td>15,200,000đ</td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/36x36" alt="Avatar" />
                    <p>Trần Thị B</p>
                  </td>
                  <td>18</td>
                  <td>11,050,000đ</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </main>
    </div>

    <script src="../assets/js/admin/main.js"></script>
  </body>

  </html>