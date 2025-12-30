<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/settings.css" />
    <title>Cài đặt</title>
  </head>

  <body>

    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="settings" />
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
            <h1>Cài đặt</h1>
            <ul class="breadcrumb">
              <li><a href="#">Quản lý</a></li>
              <li>/</li>
              <li><a href="#" class="active">Cài đặt</a></li>
            </ul>
          </div>
        </div>

        <div class="bottom-data">
          <div class="settings-page">
            <div class="settings-page__header">
              <h3>Thiết lập Cửa hàng</h3>
            </div>

            <form id="settingsForm" class="settings-page__form">
              <fieldset class="settings-page__group">
                <legend class="settings-page__legend">Cài đặt chung</legend>

                <div class="settings-page__form-group">
                  <label for="storeName" class="settings-page__label">Tên cửa hàng</label>
                  <input type="text" id="storeName" value="Organic Harvest" class="settings-page__input" />
                </div>

                <div class="settings-page__form-group">
                  <label for="storeSlogan" class="settings-page__label">Slogan (Khẩu hiệu)</label>
                  <input type="text" id="storeSlogan" value="Trái cây nhập khẩu" class="settings-page__input" />
                </div>

                <div class="settings-page__form-group">
                  <label for="storeEmail" class="settings-page__label">Email liên hệ</label>
                  <input type="email" id="storeEmail" value="contact@shop.com" class="settings-page__input" />
                </div>

                <div class="settings-page__form-group">
                  <label for="storeLogo" class="settings-page__label">Tải lên Logo</label>
                  <input type="file" id="storeLogo" class="settings-page__file-input" />
                </div>
              </fieldset>

              <fieldset class="settings-page__group">
                <legend class="settings-page__legend">Cổng thanh toán</legend>

                <div class="settings-page__form-group-toggle">
                  <label class="settings-page__label">Thanh toán khi nhận hàng (COD)</label>
                  <label class="toggle-switch">
                    <input type="checkbox" class="toggle-switch__input" checked />
                    <span class="toggle-switch__slider"></span>
                  </label>
                </div>

                <div class="settings-page__form-group-toggle">
                  <label class="settings-page__label">Chuyển khoản Ngân hàng</label>
                  <label class="toggle-switch">
                    <input type="checkbox" class="toggle-switch__input" checked />
                    <span class="toggle-switch__slider"></span>
                  </label>
                </div>

                <div class="settings-page__form-group">
                  <label for="bankInstructions" class="settings-page__label">Hướng dẫn Chuyển khoản</label>
                  <textarea id="bankInstructions" rows="4" class="settings-page__textarea">
Nội dung: [Tên] + [Mã đơn hàng]
STK: 123456789
Ngân hàng: Vietcombank
</textarea>
                </div>
              </fieldset>

              <fieldset class="settings-page__group">
                <legend class="settings-page__legend">Vận chuyển</legend>

                <div class="settings-page__form-group">
                  <label for="shippingFee" class="settings-page__label">Phí vận chuyển đồng giá (VNĐ)</label>
                  <input type="number" id="shippingFee" value="30000" class="settings-page__input" />
                </div>

                <div class="settings-page__form-group">
                  <label for="freeShippingMin" class="settings-page__label">Miễn phí cho đơn hàng trên (VNĐ)</label>
                  <input type="number" id="freeShippingMin" value="500000" class="settings-page__input" />
                </div>
              </fieldset>

              <div class="settings-page__footer">
                <button type="submit" class="btn-submit">Lưu Cài đặt</button>
              </div>
            </form>
          </div>
        </div>
      </main>
    </div>

    <script src="../assets/js/admin/main.js"></script>
    <script src="../assets/js/admin/settings.js"></script>
  </body>

  </html>