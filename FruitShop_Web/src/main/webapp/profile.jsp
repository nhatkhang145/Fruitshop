<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Tài Khoản Của Tôi — The Organic Harvest</title>

    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css"
    />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css" />
  </head>
  <body>
    <div class="main">
       <!-- HEADER -->
      <jsp:include page="header.jsp"></jsp:include>
      <div class="breadcrumb">
        <div class="container">
          <a href="/">Trang chủ</a> &gt; <span>Hồ sơ của tôi</span>
        </div>
      </div>

      <section class="profile-section">
        <div class="container">
          <div class="profile-container">
            <aside class="profile-sidebar">
              <div class="profile-user-brief">
                <img
                  src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                  alt="Avatar"
                  class="brief-avatar"
                  id="briefAvatar"
                />
                <div class="brief-info">
                  <span class="brief-name">Nguyễn Văn A</span>
                  <a href="#" class="brief-edit"
                    ><i class="fa-solid fa-pen"></i> Sửa hồ sơ</a
                  >
                </div>
              </div>

              <ul class="profile-menu">
                <li class="profile-menu-item active">
                  <a href="/profile.jsp">
                    <i class="fa-regular fa-user"></i> Hồ sơ của tôi
                  </a>
                </li>
                <li class="profile-menu-item">
                  <a href="/orders.jsp">
                    <i class="fa-solid fa-box-open"></i> Đơn mua
                  </a>
                </li>
                <li class="profile-menu-item">
                  <a href="/addresses.jsp">
                    <i class="fa-solid fa-location-dot"></i> Địa chỉ
                  </a>
                </li>
                <li class="profile-menu-item">
                  <a href="/change-password.jsp">
                    <i class="fa-solid fa-key"></i> Đổi mật khẩu
                  </a>
                </li>
                <li class="profile-menu-item">
                  <a href="/wishlist.jsp">
                    <i class="fa-regular fa-heart"></i> Yêu thích
                  </a>
                </li>
              </ul>
            </aside>

            <main class="profile-content">
              <div class="profile-header">
                <h3>Hồ sơ của tôi</h3>
                <p>Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
              </div>

              <form class="profile-form">
                <div class="profile-form-left">
                  <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <p class="static-text">nguyenvana123</p>
                  </div>
                  <div class="form-group">
                    <label>Họ và tên</label>
                    <input
                      type="text"
                      class="form-input"
                      value="Nguyễn Văn A"
                    />
                  </div>
                  <div class="form-group">
                    <label>Email</label>
                    <div class="input-with-link">
                      <span class="text-masked">ng*****@gmail.com</span>
                      <a href="#">Thay đổi</a>
                    </div>
                  </div>
                  <div class="form-group">
                    <label>Số điện thoại</label>
                    <div class="input-with-link">
                      <span class="text-masked">*******456</span>
                      <a href="#">Thay đổi</a>
                    </div>
                  </div>
                  <div class="form-group">
                    <label>Giới tính</label>
                    <div class="radio-group">
                      <label class="radio-label"
                        ><input
                          type="radio"
                          name="gender"
                          value="male"
                          checked
                        />
                        Nam</label
                      >
                      <label class="radio-label"
                        ><input type="radio" name="gender" value="female" />
                        Nữ</label
                      >
                      <label class="radio-label"
                        ><input type="radio" name="gender" value="other" />
                        Khác</label
                      >
                    </div>
                  </div>
                  <div class="form-group">
              <label>Ngày sinh</label>
              <input type="date" class="form-input" value="2000-01-01">
            </div>

                  <button type="button" class="btn btn-save">Lưu</button>
                </div>

                <div class="profile-form-right">
                  <div class="avatar-uploader">
                    <img
                      src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                      alt="User Avatar"
                      id="profileAvatarPreview"
                    />
                    <label for="fileInput" class="btn btn-outline-light"
                      >Chọn ảnh</label
                    >
                    <input
                      type="file"
                      id="fileInput"
                      accept=".jpg,.jpeg,.png"
                      hidden
                    />
                    <div class="avatar-note">
                      Dụng lượng file tối đa 1 MB<br />Định dạng:.JPEG, .PNG
                    </div>
                  </div>
                </div>
              </form>
            </main>
          </div>
        </div>
      </section>
      <footer class="footer">
        <div class="footer__main">
          <div class="footer__grid">
            <!-- Company Info -->
            <div class="footer__company">
              <div class="footer__brand">
                <a href="/">
                  <img
                    class="navbar__menu-logo-img"
                    src="https://ik.imagekit.io/8tm3umulk/image/logonew_fG_70DXF8?updatedAt=1762866381508"
                    alt="Organic Harvest Logo"
                  />
                </a>
                <!-- <div class="footer__logo">T</div>
                <h3 class="footer__company-name">Company</h3> -->
              </div>
              <p class="footer__description">
                Địa chỉ: khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam
              </p>
              <div class="footer__social">
                <a
                  href="https://www.themedevhub.com"
                  target="_blank"
                  class="footer__social-link footer__social-link--facebook"
                >
                  <svg class="footer__social-icon" viewBox="0 0 24 24">
                    <path
                      d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"
                    />
                  </svg>
                </a>
                <a
                  href="https://www.themedevhub.com"
                  target="_blank"
                  class="footer__social-link footer__social-link--twitter"
                >
                  <svg class="footer__social-icon" viewBox="0 0 24 24">
                    <path
                      d="M23.953 4.57a10 10 0 01-2.825.775 4.958 4.958 0 002.163-2.723c-.951.555-2.005.959-3.127 1.184a4.92 4.92 0 00-8.384 4.482C7.69 8.095 4.067 6.13 1.64 3.162a4.822 4.822 0 00-.666 2.475c0 1.71.87 3.213 2.188 4.096a4.904 4.904 0 01-2.228-.616v.06a4.923 4.923 0 003.946 4.827 4.996 4.996 0 01-2.212.085 4.936 4.936 0 004.604 3.417 9.867 9.867 0 01-6.102 2.105c-.39 0-.779-.023-1.17-.067a13.995 13.995 0 007.557 2.209c9.053 0 13.998-7.496 13.998-13.985 0-.21 0-.42-.015-.63A9.935 9.935 0 0024 4.59z"
                    />
                  </svg>
                </a>
                <a
                  href="https://www.themedevhub.com"
                  target="_blank"
                  class="footer__social-link footer__social-link--telegram"
                >
                  <svg class="footer__social-icon" viewBox="0 0 24 24">
                    <path
                      d="M12 0C5.373 0 0 5.373 0 12s5.373 12 12 12 12-5.373 12-12S18.627 0 12 0zm5.894 8.221l-1.97 9.28c-.145.658-.537.818-1.084.508l-3-2.21-1.446 1.394c-.16.16-.295.295-.605.295l.213-3.053 5.56-5.023c.242-.213-.054-.333-.373-.121l-6.871 4.326-2.962-.924c-.643-.204-.657-.643.136-.953l11.56-4.458c.538-.196 1.006.128.832.941z"
                    />
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
                  <a
                    href="https://www.themedevhub.com/about-us"
                    target="_blank"
                    class="footer__link"
                    >Trang chủ</a
                  >
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/hire-experts"
                    target="_blank"
                    class="footer__link"
                    >Sản phẩm</a
                  >
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/themes"
                    target="_blank"
                    class="footer__link"
                    >Giới thiệu</a
                  >
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/contact"
                    target="_blank"
                    class="footer__link"
                    >Bài viết</a
                  >
                </li>
              </ul>
            </div>

            <!-- Hổ trợ khách hàng -->
            <div class="footer__section">
              <h3 class="footer__title">Hổ trợ khách hàng</h3>
              <ul class="footer__links">
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/about-us"
                    target="_blank"
                    class="footer__link"
                    >Tìm kiếm
                  </a>
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/hire-experts"
                    target="_blank"
                    class="footer__link"
                    >Chính sách bảo mật</a
                  >
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/themes"
                    target="_blank"
                    class="footer__link"
                    >Điều khoản dịch vụ</a
                  >
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/contact"
                    target="_blank"
                    class="footer__link"
                    >Hướng dẫn kiểm tra đơn hàng</a
                  >
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/contact"
                    target="_blank"
                    class="footer__link"
                    >Chính sách giao nhận</a
                  >
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/contact"
                    target="_blank"
                    class="footer__link"
                    >Chính sách thanh toán</a
                  >
                </li>
                <li class="footer__link-item">
                  <div class="footer__link-dot"></div>
                  <a
                    href="https://www.themedevhub.com/contact"
                    target="_blank"
                    class="footer__link"
                    >Chính sách đổi trả</a
                  >
                </li>
              </ul>
            </div>

            <!-- Newsletter -->
            <div class="footer__section">
              <h3 class="footer__title">Đăng kí nhận tin</h3>

              <form class="footer__newsletter-form">
                <input
                  type="email"
                  placeholder="Nhập địa chỉ email"
                  class="footer__newsletter-input"
                  required
                />
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
                <a
                  href="https://www.themedevhub.com/about-us"
                  target="_blank"
                  class="footer__bottom-link"
                  >About us</a
                >
              </li>
              <li>
                <a
                  href="https://www.themedevhub.com/privacy-policy"
                  target="_blank"
                  class="footer__bottom-link"
                  >Terms</a
                >
              </li>
              <li>
                <a
                  href="https://www.themedevhub.com/terms-and-conditions"
                  target="_blank"
                  class="footer__bottom-link"
                  >Privacy</a
                >
              </li>
            </ul>
          </div>
        </div>
      </footer>
    </div>
  </body>
</html>
