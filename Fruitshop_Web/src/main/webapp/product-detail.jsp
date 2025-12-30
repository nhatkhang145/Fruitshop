<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>${detail.name} — Organic Harvest</title>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/product-detail.css" />
      </head>

      <body>

        <main class="main product-detail-page">
          <jsp:include page="header.jsp"></jsp:include>

          <div class="breadcrumb">
            <div class="container">
              <a href="index.jsp">Trang chủ</a>
              <i class="fa-solid fa-angle-right"></i>
              <a href="shop">Cửa hàng</a>
              <i class="fa-solid fa-angle-right"></i>
              <span>${detail.name}</span>
            </div>
          </div>

          <div class="container">
            <div class="product-detail__container">
              <div class="product-detail__top">

                <div class="product-gallery">
                  <div class="product-gallery__thumbs">
                    <div class="thumb-item active" onclick="changeImage(this)">
                      <img src="${detail.image}" alt="${detail.name}">
                    </div>
                  </div>
                  <div class="product-gallery__main">
                    <img id="mainImage" src="${detail.image}" alt="${detail.name}">
                    <div class="product-badge sale">Hot</div>
                  </div>
                </div>

                <div class="product-info">
                  <h1 class="product-title">${detail.name}</h1>

                  <div class="product-meta-row">
                    <div class="product-rating">
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star"></i>
                      <i class="fa-solid fa-star-half-stroke"></i>
                      <span>(12 đánh giá)</span>
                    </div>
                    <span class="divider">|</span>
                    <span class="product-sku">Mã SP: <strong>#${detail.id}</strong></span>
                    <span class="divider">|</span>
                    <span class="stock-status in-stock">
                      ${detail.quantity > 0 ? 'Còn hàng' : 'Hết hàng'}
                    </span>
                  </div>

                  <div class="product-price-box">
                    <span class="current-price">
                      <fmt:formatNumber value="${detail.price}" pattern="#,###" />₫
                    </span>
                    <span class="old-price">
                      <fmt:formatNumber value="${detail.price * 1.1}" pattern="#,###" />₫
                    </span>
                  </div>

                  <div class="product-description-short">
                    <p>${detail.description}</p>
                  </div>

                  <hr class="product-divider">

                  <form action="add-to-cart" method="post" class="product-actions-wrapper">
                    <input type="hidden" name="pid" value="${detail.id}">

                    <div class="qty-wrapper">
                      <button type="button" class="qty-btn" onclick="decreaseQty()">-</button>
                      <input type="number" name="quantity" value="1" min="1" id="qtyInput" class="qty-input">
                      <button type="button" class="qty-btn" onclick="increaseQty()">+</button>
                    </div>

                    <div class="action-buttons">
                      <button type="submit" class="btn btn-add-cart">
                        <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ
                      </button>
                      <button type="button" class="btn btn-buy-now">Mua ngay</button>
                    </div>
                  </form>

                  <div class="product-policies">
                    <div class="policy-item">
                      <i class="fa-solid fa-truck-fast"></i>
                      <span>Giao hàng hỏa tốc trong 2H</span>
                    </div>
                    <div class="policy-item">
                      <i class="fa-solid fa-rotate-left"></i>
                      <span>Đổi trả trong 24H nếu hư hỏng</span>
                    </div>
                    <div class="policy-item">
                      <i class="fa-solid fa-shield-halved"></i>
                      <span>Cam kết 100% Sạch & An toàn</span>
                    </div>
                  </div>

                  <div class="product-share">
                    <span>Chia sẻ:</span>
                    <a href="#"><i class="fa-brands fa-facebook"></i></a>
                    <a href="#"><i class="fa-brands fa-twitter"></i></a>
                    <a href="#"><i class="fa-brands fa-pinterest"></i></a>
                  </div>

                </div>
              </div>

              <div class="product-detail__bottom">
                <div class="product-tabs">
                  <button class="tab-btn active" onclick="openTab(event, 'desc')">Mô tả chi tiết</button>
                  <button class="tab-btn" onclick="openTab(event, 'reviews')">Đánh giá (12)</button>
                  <button class="tab-btn" onclick="openTab(event, 'shipping')">Chính sách giao hàng</button>
                </div>

                <div id="desc" class="tab-content" style="display: block;">
                  <div class="content-inner">
                    <h3>Thông tin chi tiết</h3>
                    <p>${detail.description}</p>
                    <p><strong>Lưu ý:</strong> Bảo quản nơi khô ráo, thoáng mát.</p>
                  </div>
                </div>

                <div id="reviews" class="tab-content" style="display: none;">
                  <div class="review-list">
                    <div class="review-item">
                      <div class="review-header">
                        <strong>Người dùng mẫu</strong>
                        <div class="stars"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
                            class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
                            class="fa-solid fa-star"></i></div>
                      </div>
                      <p class="review-text">Sản phẩm rất tươi ngon!</p>
                      <small class="review-date">Vừa xong</small>
                    </div>
                  </div>
                </div>

                <div id="shipping" class="tab-content" style="display: none;">
                  <p>Nội dung chính sách giao hàng...</p>
                </div>
              </div>

              <div class="related-products-section">
                <h2 class="section-title">Sản phẩm liên quan</h2>
                <div class="trending-grid" style="display: flex; gap: 20px; flex-wrap: wrap;">

                  <c:forEach items="${relatedP}" var="rp">
                    <c:if test="${rp.id != detail.id}">
                      <div class="product-card" style="width: 250px;">
                        <div class="product-image">
                          <img src="${rp.image}" alt="${rp.name}"
                            style="width: 100%; height: 200px; object-fit: cover;">
                          <div class="product-actions">
                            <a href="product-detail?pid=${rp.id}"><button class="action-btn"><i
                                  class="fas fa-eye"></i></button></a>
                          </div>
                        </div>
                        <div class="product-info">
                          <h3><a href="product-detail?pid=${rp.id}">${rp.name}</a></h3>
                          <div class="price">
                            <span class="current">
                              <fmt:formatNumber value="${rp.price}" pattern="#,###" />₫
                            </span>
                          </div>
                        </div>
                      </div>
                    </c:if>
                  </c:forEach>
                </div>
              </div>

            </div>
          </div>

        </main>

        <jsp:include page="footer.jsp"></jsp:include>

        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>

        <script>
          // 1. Đổi ảnh gallery
          function changeImage(element) {
            document.querySelectorAll('.thumb-item').forEach(el => el.classList.remove('active'));
            element.classList.add('active');
            const newSrc = element.querySelector('img').src;
            document.getElementById('mainImage').src = newSrc;
          }

          // 2. Tăng giảm số lượng
          const qtyInput = document.getElementById('qtyInput');
          function increaseQty() {
            qtyInput.value = parseInt(qtyInput.value) + 1;
          }
          function decreaseQty() {
            if (parseInt(qtyInput.value) > 1) {
              qtyInput.value = parseInt(qtyInput.value) - 1;
            }
          }

          // 3. Chuyển Tabs
          function openTab(evt, tabName) {
            let i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tab-content");
            for (i = 0; i < tabcontent.length; i++) {
              tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tab-btn");
            for (i = 0; i < tablinks.length; i++) {
              tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
          }
        </script>
      </body>

      </html>