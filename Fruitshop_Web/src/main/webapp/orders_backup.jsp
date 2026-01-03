<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Đơn mua - Organic Harvest</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/orders.css" />
</head>

<body>
  <!-- HEADER -->
  <jsp:include page="header.jsp"></jsp:include>
  <div class="breadcrumb">
    <div class="container">
      <a href="/">Trang chủ</a> &gt;
      <a href="/profile.jsp">Tài khoản</a> &gt; <span>Đơn mua</span>
    </div>
  </div>

  <section class="profile-section">
    <div class="container">
      <div class="profile-container">
        <aside class="profile-sidebar">
          <div class="profile-user-brief">
            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="Avatar" class="brief-avatar" />
            <div class="brief-info">
              <span class="brief-name">Nguyễn Văn A</span>
              <a href="/profile.jsp" class="brief-edit"><i class="fa-solid fa-pen"></i> Sửa hồ sơ</a>
            </div>
          </div>

          <ul class="profile-menu">
            <li class="profile-menu-item">
              <a href="/profile.jsp"><i class="fa-regular fa-user"></i> Hồ sơ của tôi</a>
            </li>
            <li class="profile-menu-item active">
              <a href="/orders.jsp"><i class="fa-solid fa-box-open"></i> Đơn mua</a>
            </li>
            <li class="profile-menu-item">
              <a href="/addresses.jsp"><i class="fa-solid fa-location-dot"></i> Địa chỉ</a>
            </li>
            <li class="profile-menu-item">
              <a href="/change-password.jsp"><i class="fa-solid fa-key"></i> Đổi mật khẩu</a>
            </li>
            <li class="profile-menu-item">
              <a href="/wishlist.jsp"><i class="fa-regular fa-heart"></i> Yêu thích</a>
            </li>
          </ul>
        </aside>

        <main class="profile-content order-content">
          <div class="order-tabs">
            <a href="#" class="order-tab active">Tất cả</a>
            <a href="#" class="order-tab">Chờ thanh toán</a>
            <a href="#" class="order-tab">Vận chuyển</a>
            <a href="#" class="order-tab">Hoàn thành</a>
            <a href="#" class="order-tab">Đã hủy</a>
          </div>

          <div class="order-search-bar">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Tìm kiếm theo ID đơn hàng hoặc Tên sản phẩm" />
          </div>

          <div class="order-list">
            <div class="order-card">
              <div class="order-card__header">
                <div class="shop-info">
                  <span class="shop-name">Organic Harvest</span>
                  <button class="btn-chat">
                    <i class="fa-regular fa-comment"></i> Chat
                  </button>
                </div>
                <span class="order-status status-completed">HOÀN THÀNH</span>
              </div>

              <div class="order-card__body">
                <div class="order-item">
                  <img
                    src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                    alt="Product" class="item-thumb" />
                  <div class="item-info">
                    <h4 class="item-name">
                      Dừa sáp Trà Vinh (Loại 1) - Thơm ngon béo ngậy
                    </h4>
                    <p class="item-variant">Phân loại: Trái to</p>
                    <p class="item-qty">x2</p>
                  </div>
                  <div class="item-price">
                    <span class="old-price">200.000đ</span>
                    <span class="new-price">150.000đ</span>
                  </div>
                </div>
                <div class="order-item">
                  <img src="https://botanica.risingbamboo.com/wp-content/uploads/2023/06/bn6-1.png" alt="Product"
                    class="item-thumb" />
                  <div class="item-info">
                    <h4 class="item-name">Cam Sành Vĩnh Long mọng nước</h4>
                    <p class="item-variant">Phân loại: Túi 1kg</p>
                    <p class="item-qty">x1</p>
                  </div>
                  <div class="item-price">
                    <span class="new-price">30.000đ</span>
                  </div>
                </div>
              </div>

              <div class="order-card__footer">
                <div class="total-money">
                  Thành tiền: <span>330.000đ</span>
                </div>
                <div class="action-buttons">
                  <a href="cart.jsp" class="btn btn-primary">Mua lại</a>
                  <a href="order-history-detail.jsp" class="btn btn-outline">Xem chi tiết</a>
                </div>
              </div>
            </div>

            <div class="order-card">
              <div class="order-card__header">
                <div class="shop-info">
                  <span class="shop-name">Organic Harvest</span>
                  <button class="btn-chat">
                    <i class="fa-regular fa-comment"></i> Chat
                  </button>
                </div>
                <span class="order-status status-shipping"><i class="fa-solid fa-truck"></i> ĐANG GIAO HÀNG</span>
              </div>

              <div class="order-card__body">
                <div class="order-item">
                  <img src="https://via.placeholder.com/80" alt="Product" class="item-thumb" />
                  <div class="item-info">
                    <h4 class="item-name">Táo Envy Mỹ nhập khẩu size lớn</h4>
                    <p class="item-variant">Phân loại: 1kg</p>
                    <p class="item-qty">x1</p>
                  </div>
                  <div class="item-price">
                    <span class="new-price">120.000đ</span>
                  </div>
                </div>
              </div>

              <div class="order-card__footer">
                <div class="total-money">
                  Thành tiền: <span>120.000đ</span>
                </div>
                <div class="action-buttons">
                  <button class="btn btn-disabled" disabled>
                    Đã nhận được hàng
                  </button>
                  <a href="order-history-detail.jsp" class="btn btn-outline">Xem chi tiết</a>
                </div>
              </div>
            </div>

            <div class="order-card">
              <div class="order-card__header">
                <div class="shop-info">
                  <span class="shop-name">Organic Harvest</span>
                </div>
                <span class="order-status status-cancelled">ĐÃ HỦY</span>
              </div>

              <div class="order-card__body">
                <div class="order-item">
                  <img src="https://via.placeholder.com/80" alt="Product" class="item-thumb" />
                  <div class="item-info">
                    <h4 class="item-name">
                      Nho Mẫu Đơn Hàn Quốc (Shine Muscat)
                    </h4>
                    <p class="item-variant">Phân loại: Hộp 500g</p>
                    <p class="item-qty">x1</p>
                  </div>
                  <div class="item-price">
                    <span class="new-price">450.000đ</span>
                  </div>
                </div>
              </div>

              <div class="order-card__footer">
                <div class="total-money">
                  Thành tiền: <span>450.000đ</span>
                </div>
                <div class="action-buttons">
                  <a href="cart.jsp" class="btn btn-primary">Mua lại</a>
                  <a href="order-history-detail.jsp" class="btn btn-outline">Xem chi tiết</a>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    </div>
  </section>
  <!-- FOOTER -->
  <footer class="footer">
    <div class="footer__main">
      <div class="footer__grid">
        <!-- Company Info -->
        <div class="footer__company">
          <div class="footer__brand">
            <a href="/">
              <img class="navbar__menu-logo-img"
                src="https://ik.imagekit.io/8tm3umulk/image/logonew_fG_70DXF8?updatedAt=1762866381508"
                alt="Organic Harvest Logo" />
            </a>
            <!-- <div class="footer__logo">T</div>
                <h3 class="footer__company-name">Company</h3> -->
          </div>
          <p class="footer__description">
            Địa chỉ: khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam
          </p>
          <div class="footer__social">
            <a href="https://www.themedevhub.com" target="_blank"
              class="footer__social-link footer__social-link--facebook">
              <svg class="footer__social-icon" viewBox="0 0 24 24">
                <path
                  d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" />
              </svg>
            </a>
            <a href="https://www.themedevhub.com" target="_blank"
              class="footer__social-link footer__social-link--twitter">
              <svg class="footer__social-icon" viewBox="0 0 24 24">
                <path
                  d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z" />
              </svg>
            </a>
            <a href="https://www.themedevhub.com" target="_blank"
              class="footer__social-link footer__social-link--telegram">
              <svg class="footer__social-icon" viewBox="0 0 24 24">
                <path
                  d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.894 8.221l-1.97 9.28c-.145.658-.537.818-1.084.508l-3-2.21-1.446 1.394c-.16.16-.295.295-.605.295l.213-3.053 5.56-5.023c.242-.213-.054-.333-.373-.121l-6.871 4.326-2.962-.924c-.643-.204-.657-.643.136-.953l11.56-4.458c.538-.196 1.006.128.832.941z" />
              </svg>
            </a>
          </div>
        </div>

        <!-- Quick Links -->
        <div class="footer__section">
          <h3 class="footer__title">Chính sách</h3>
          <ul class="footer__links">
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/about-us" target="_blank" class="footer__link">Trang chủ</a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/hire-experts" target="_blank" class="footer__link">Sản phẩm</a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/themes" target="_blank" class="footer__link">Giới thiệu</a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Bài viết</a>
            </li>
          </ul>
        </div>

        <!-- Hổ trợ khách hàng -->
        <div class="footer__section">
          <h3 class="footer__title">Hổ trợ khách hàng</h3>
          <ul class="footer__links">
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/about-us" target="_blank" class="footer__link">Tìm kiếm
              </a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/hire-experts" target="_blank" class="footer__link">Chính sách bảo
                mật</a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/themes" target="_blank" class="footer__link">Điều khoản dịch vụ</a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Hướng dẫn kiểm tra đơn
                hàng</a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Chính sách giao
                nhận</a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Chính sách thanh
                toán</a>
            </li>
            <li class="footer__link-item">
              <div class="footer__link-dot"></div>
              <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Chính sách đổi trả</a>
            </li>
          </ul>
        </div>

        <!-- Newsletter -->
        <div class="footer__section">
          <h3 class="footer__title">Đăng kí nhận tin</h3>

          <form class="footer__newsletter-form">
            <input type="email" placeholder="Nhập địa chỉ email" class="footer__newsletter-input" required />
            <button type="submit" class="footer__newsletter-button">
              Đăng kí
            </button>
          </form>
        </div>
      </div>
    </div>

    <!-- Footer Bottom -->
    <div class="footer__bottom">
      <div class="footer__bottom-content">
        <p class="footer__copyright">
          &copy; 2025 Company. All rights reserved.
        </p>
        <ul class="footer__bottom-links">
          <li>
            <a href="https://www.themedevhub.com/about-us" target="_blank" class="footer__bottom-link">About us</a>
          </li>
          <li>
            <a href="https://www.themedevhub.com/privacy-policy" target="_blank" class="footer__bottom-link">Terms</a>
          </li>
          <li>
            <a href="https://www.themedevhub.com/terms-and-conditions" target="_blank"
              class="footer__bottom-link">Privacy</a>
          </li>
        </ul>
      </div>
    </div>
  </footer>
  <script src="./assets/js/main.js"></script>
</body>

</html>