<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Danh Mục Trái Cây</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/shop.css" />
      </head>

      <body>
        <div class="main">
          <!-- HEADER -->
          <jsp:include page="header.jsp"></jsp:include>
          <!-- CONTAINER -->
          <!-- page title -->
          <div class="breadcrumb">
            <div class="grid">
              <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
              <i class="fa-solid fa-angle-right"></i>
              <span>Sản phẩm</span>
            </div>
          </div>
          <!--  -->
          <div class="app__container">
            <div class="grid">
              <div class="grid__row app__content">
                <!-- CỘT 2 -->
                <div class="grid__column-2">
                  <nav class="category">
                      <h3 class="category_heading">
                          <i class="category__heading-icon fas fa-list"></i>
                          Danh Mục
                      </h3>

                      <ul class="category-list">
                          <c:forEach items="${listC}" var="c">
                              <c:if test="${c.parentId == 0}">
                                  <li class="category-item">
                                      <details>
                                          <summary>${c.name}</summary>
                                          <ul class="subcategory-list">
                                              <c:forEach items="${listC}" var="sub">
                                                  <c:if test="${sub.parentId == c.id}">
                                                      <li>
                                                          <a href="shop?cid=${sub.id}"
                                                             style="${tag == sub.id ? 'color: var(--primary-color); font-weight: bold;' : ''}">
                                                              ${sub.name}
                                                          </a>
                                                      </li>
                                                  </c:if>
                                              </c:forEach>
                                          </ul>
                                      </details>
                                  </li>
                              </c:if>
                          </c:forEach>
                      </ul>
                  </nav>

                  <!-- BỘ LỌC -->
                  <nav class="filter">
                    <h3 class="category_heading">
                      <i class="fa-solid fa-filter"></i>
                      Bộ Lọc Tìm Kiếm
                    </h3>
                    <ul class="category-list">
                      <li class="category-item">
                        <details open>
                          <summary>Quốc Gia</summary>
                          <ul class="subcategory-list">
                            <li><a href="#">Mỹ</a></li>
                            <li><a href="#">Úc</a></li>
                            <li><a href="#">Hàn Quốc</a></li>
                            <li><a href="#">New Zealand</a></li>
                          </ul>
                        </details>
                      </li>

                      <li class="category-item">
                        <details>
                          <summary>Mức giá</summary>
                          <ul class="subcategory-list">
                            <li><a href="#">Dưới 200.000đ/kg</a></li>
                            <li><a href="#">200.000đ - 500.000đ/kg</a></li>
                            <li><a href="#">500.000đ - 1.000.000đ/kg</a></li>
                            <li><a href="#">Trên 1.000.000đ/kg</a></li>
                          </ul>
                        </details>
                      </li>
                    </ul>
                  </nav>
                </div>
                <!-- KẾT THÚC CỘT 2 -->

                <!-- CỘT 10 -->
                <div class="grid__column-10">
                  <!-- Hiển thị thông báo tìm kiếm -->
                  <c:if test="${isSearch}">
                    <div style="padding: 15px; background: #f8f9fa; border-left: 4px solid #28a745; margin-bottom: 20px;">
                      <strong>Kết quả tìm kiếm:</strong> "<em>${searchKeyword}</em>" - Tìm thấy <strong>${listP.size()}</strong> sản phẩm
                    </div>
                  </c:if>
                  
                  <div class="sort-filter">
                    <span class="sort-filter__label">Sắp xếp theo </span>
                    <button class="sort-filter__btn btn">Phổ biến</button>
                    <button class="sort-filter__btn btn btn--primary">
                      Mới nhất
                    </button>
                    <button class="sort-filter__btn btn">Bán chạy</button>

                    <div class="select-cost">
                      <span class="select-cost__label">Giá</span>
                      <i class="select-cost__icon fa-solid fa-arrow-down"></i>

                      <ul class="select-cost__list">
                        <li class="select-cost__item">
                          <a href="" class="select-cost__link">Giá: từ thấp đến cao</a>
                        </li>
                        <li class="select-cost__item">
                          <a href="" class="select-cost__link">Giá: từ cao đến thấp</a>
                        </li>
                      </ul>
                    </div>

                    <div class="sort-filter__page">
                      <span class="sort-filter__page-num"></span>
                      <span class="sort-filter__page-current">1</span>
                      <span class="sort-filter__page-total">/14 </span>

                      <div class="sort-filter__page-control">
                        <a href="" class="sort-filter__page-btn sort-filter__page-btn--disabled">
                          <i class="sort-filter__page-icon fa-solid fa-arrow-left"></i>
                        </a>
                        <a href="" class="sort-filter__page-btn">
                          <i class="sort-filter__page-icon fa-solid fa-arrow-right"></i>
                        </a>
                      </div>
                    </div>
                  </div>
                  <!-- Product item -->
                  <div class="home-product">
                    <div class="grid__row">
                      <c:forEach items="${listP}" var="p">
                        <div class="grid__column-2-4">
                          <div class="product-card">
                            <div class="product-image">
                              <a href="product-detail?pid=${p.id}">
                                <img src="${p.image}" alt="${p.name}" loading="lazy" />
                              </a>

                              <div class="product-badge sale">-10%</div>

                              <div class="product-actions">
                                <c:set var="isLiked" value="${likedIds.contains(p.id)}" />

                                <a href="wishlist?action=${isLiked ? 'remove' : 'add'}&pid=${p.id}"
                                   class="action-btn"
                                   title="${isLiked ? 'Bỏ yêu thích' : 'Thêm vào yêu thích'}">

                                    <i class="${isLiked ? 'fas fa-heart' : 'far fa-heart'}"
                                       style="${isLiked ? 'color: red;' : ''}"></i>
                                </a>

                                <a href="product-detail?pid=${p.id}" class="action-btn" title="Xem nhanh">
                                  <i class="far fa-eye"></i>
                                </a>

                                <button class="action-btn add-to-cart-btn" data-id="${p.id}" title="Thêm vào giỏ">
                                  <i class="fas fa-shopping-basket"></i>
                                </button>
                              </div>
                            </div>

                            <div class="product-info">
                              <div class="category">Trái cây nhập khẩu</div>

                              <h3>
                                <a href="product-detail?pid=${p.id}" title="${p.name}">${p.name}</a>
                              </h3>

                              <div class="rating" style="color: #ffc107; font-size: 0.8rem; margin-bottom: 5px;">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                                <span style="color: #999;">(15)</span>
                              </div>

                              <div class="price">
                                <span class="current">
                                  <fmt:formatNumber value="${p.price}" pattern="#,###" />đ
                                </span>
                                <span class="original">
                                  <fmt:formatNumber value="${p.price * 1.1}" pattern="#,###" />đ
                                </span>
                                <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                              </div>
                            </div>
                          </div>
                        </div>
                      </c:forEach>
                    </div>
                    <div class="col-12">
                      <div class="pagination d-flex justify-content-center mt-5">
                        <c:if test="${endP > 1}">
                          <c:forEach begin="1" end="${endP}" var="i">
                            <a href="shop?index=${i}" class="rounded ${tag == i ? 'active' : ''}">
                              ${i}
                            </a>
                          </c:forEach>
                        </c:if>
                      </div>
                    </div>
                  </div>
                </div>
                <!-- KẾT THÚC CỘT 10 -->
              </div>
            </div>
          </div>
        </div>
        </div>
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
                    <a href="https://www.themedevhub.com/hire-experts" target="_blank" class="footer__link">Sản
                      phẩm</a>
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
                    <a href="https://www.themedevhub.com/hire-experts" target="_blank" class="footer__link">Chính sách
                      bảo
                      mật</a>
                  </li>
                  <li class="footer__link-item">
                    <div class="footer__link-dot"></div>
                    <a href="https://www.themedevhub.com/themes" target="_blank" class="footer__link">Điều khoản dịch
                      vụ</a>
                  </li>
                  <li class="footer__link-item">
                    <div class="footer__link-dot"></div>
                    <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Hướng dẫn kiểm
                      tra
                      đơn hàng</a>
                  </li>
                  <li class="footer__link-item">
                    <div class="footer__link-dot"></div>
                    <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Chính sách giao
                      nhận</a>
                  </li>
                  <li class="footer__link-item">
                    <div class="footer__link-dot"></div>
                    <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Chính sách
                      thanh
                      toán</a>
                  </li>
                  <li class="footer__link-item">
                    <div class="footer__link-dot"></div>
                    <a href="https://www.themedevhub.com/contact" target="_blank" class="footer__link">Chính sách đổi
                      trả</a>
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
                  <a href="https://www.themedevhub.com/about-us" target="_blank" class="footer__bottom-link">About
                    us</a>
                </li>
                <li>
                  <a href="https://www.themedevhub.com/privacy-policy" target="_blank"
                    class="footer__bottom-link">Terms</a>
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
        </div>
      </body>

      </html>