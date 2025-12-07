<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- HEADER -->
<jsp:include page="header.jsp"></jsp:include>
    <!-- slide -->
    <div id="slide">
      <div class="slide-container">
        <div class="slide-wrapper">
          <!-- Slide 1 -->
          <div class="slide-item">
            <img src="https://i.pinimg.com/1200x/25/54/15/255415908ab241b565a5dbe42795519f.jpg" alt="Fresh Fruit" />
            <div class="slide-caption">
              <h2>Trái Cây Nhập Khẩu</h2>
              <p>Những loại trái cây tươi ngon từ khắp nơi trên thế giới</p>
            </div>
          </div>

          <!-- Slide 2 -->
          <div class="slide-item">
            <img src="https://i.pinimg.com/736x/ba/cc/a7/bacca77883505e3fa726612bb78951ee.jpg" alt="Clear Origin" />
            <div class="slide-caption">
              <h2>Nguồn Gốc Rõ Ràng</h2>
              <p>Trái cây có nguồn gốc rõ ràng và minh bạch</p>
            </div>
          </div>

          <!-- Slide 3 -->
          <div class="slide-item">
            <img src="https://bloganchoi.com/wp-content/uploads/2018/06/cac-loai-trai-cay.jpg" alt="City Lights" />
            <div class="slide-caption">
              <h2>Trái Cây Tươi Sạch</h2>
              <p>Cam kết mang đến sản phẩm sạch và an toàn cho sức khỏe</p>
            </div>
          </div>

          <!-- Slide 4 -->
          <div class="slide-item">
            <img src="https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=900&h=500&fit=crop"
              alt="Forest Path" />
            <div class="slide-caption">
              <h2>Trái Cây Tươi Sạch</h2>
              <p>Cam kết mang đến sản phẩm sạch và an toàn cho sức khỏe</p>
            </div>
          </div>

          <!-- Slide 5 -->
          <div class="slide-item">
            <img src="https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=900&h=500&fit=crop"
              alt="Sunset View" />
            <div class="slide-caption">
              <h2>Trái Cây Tươi Sạch</h2>
              <p>Cam kết mang đến sản phẩm sạch và an toàn cho sức khỏe</p>
            </div>
          </div>
        </div>

        <!-- Nút Previous -->
        <button class="nav-button prev-button" onclick="prevSlide()">
          &#10094;
        </button>

        <!-- Nút Next -->
        <button class="nav-button next-button" onclick="nextSlide()">
          &#10095;
        </button>

        <!-- Chỉ báo dots -->
        <div class="slide-indicators">
          <span class="indicator-dot active" onclick="goToSlide(0)"></span>
          <span class="indicator-dot" onclick="goToSlide(1)"></span>
          <span class="indicator-dot" onclick="goToSlide(2)"></span>
          <span class="indicator-dot" onclick="goToSlide(3)"></span>
          <span class="indicator-dot" onclick="goToSlide(4)"></span>
        </div>
      </div>
    </div>
    <!-- main -->
    <section id="main">
      <section id="content">
        <section id="top-offers">
          <div class="container">
            <div class="section-header">
              <h2>Ưu đãi trong tuần này</h2>
              <div class="header-icons">
                <button class="home-icon">
                  <i class="fas fa-home"></i>
                </button>
              </div>
            </div>

            <div class="offers-carousel">
              <button class="arrow prev" aria-label="Previous products">
                <i class="fas fa-chevron-left"></i>
              </button>
              <button class="arrow next" aria-label="Next products">
                <i class="fas fa-chevron-right"></i>
              </button>
              <div class="carousel-container">
                <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              </div>
            </div>
          </div>
        </section>

        <!-- -------------------------------------------------------------------------- -->

        <section id="weekend-deals">
          <div class="deal-container">
            <!-- Countdown -->
            <div class="countdown">
              <div>
                <span>0</span>
                <p>Ngày</p>
              </div>
              <div>
                <span>19</span>
                <p>Giờ</p>
              </div>
              <div>
                <span>50</span>
                <p>Phút</p>
              </div>
              <div>
                <span>57</span>
                <p>Giây</p>
              </div>
            </div>

            <!-- Deal item -->
            <div class="deal-item">
              <div class="deal-left">
                <p class="sub-title">Ưu đãi cuối tuần</p>
                <h2 class="product-title">Dừa sáp</h2>
                <p class="product-desc">Thơm ngon mọng nước</p>
                <p class="product-price">10.000 Đ</p>
                <a href="#" class="shop-now">
                  MUA NGAY <span class="arrow">→</span>
                </a>
              </div>

              <div class="deal-right">
                <img src="https://botanica.risingbamboo.com/wp-content/uploads/2023/06/bn6-1.png" alt="Fresh Coconut" />
              </div>
            </div>

            <!-- Buttons -->
            <button class="deal-btn prev-btn">❮</button>
            <button class="deal-btn next-btn">❯</button>
          </div>
        </section>
        <section id="top-trending">
          <div class="container">
            <div class="section-header">
              <h2>Xu hướng</h2>
              <div class="header-icons">
                <button class="home-icon">
                  <i class="fas fa-fire"></i>
                </button>
              </div>
            </div>

            <div class="trending-grid">
              <!-- Giữ nguyên product-card của bạn -->
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>
              <div class="product-card">
                <div class="product-image">
                  <a href="/product-detail.html?id=1">
                    <img
                      src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
                      alt="Dưa" loading="lazy" />
                  </a>

                  <div class="product-badge sale">-10%</div>

                  <div class="product-actions">
                    <a href="#" class="action-btn" title="Thêm vào yêu thích">
                      <i class="far fa-heart"></i>
                    </a>

                    <a href="/product-detail.html?id=1" class="action-btn" title="Xem nhanh">
                      <i class="far fa-eye"></i>
                    </a>

                    <button class="action-btn add-to-cart-btn" data-id="1" title="Thêm vào giỏ">
                      <i class="fas fa-shopping-basket"></i>
                    </button>
                  </div>
                </div>

                <div class="product-info">
                  <div class="category">Trái cây nhập khẩu</div>

                  <h3>
                    <a href="/product-detail.html?id=1" title="Dừa">Dừa</a>
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
                    <span class="current">120,000đ</span> <span class="original">200,000đ</span>
                    <span class="unit" style="font-size: 12px; color: #666;">/ Kg</span>
                  </div>
                </div>
              </div>

              <!-- Thêm 8 sản phẩm khác giống vậy để có 3×3 -->
            </div>
          </div>
        </section>
      </section>
    </section>
    <!-- video -->
    <section class="hero-video">
      <video autoplay muted loop class="hero-video__video">
        <source src="https://botanica.risingbamboo.com/wp-content/uploads/2023/06/Video-HD.mp4" type="video/mp4" />
        Your browser does not support the video tag.
      </video>
      <div class="hero-video__overlay">
        <h1>HÀNH TRÌNH TỪ NÔNG TRẠI ĐẾN BÀN ĂN</h1>
        <p>Tươi ngon – An toàn – Dinh dưỡng mỗi ngày</p>
        <span>Cam kết chất lượng trong từng sản phẩm</span>
      </div>
    </section>
    <!-- blog -->
    <section class="blog">
      <div class="blog__container">
        <!-- Tiêu đề section -->
        <span class="blog__subtitle">Tin mới nhất</span>
        <h2 class="blog__title">Bài viết</h2>

        <!-- Grid bài viết -->
        <div class="blog__grid">
          <!-- Bài viết 1 -->
          <div class="blog__item">
            <img src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
              alt="Blog 1" class="blog__image" />
            <div class="blog__content">
              <div class="blog__meta">
                <span class="blog__author">Đăng bởi Admin</span>
                <span class="blog__date">7/3/2025</span>
              </div>
              <h3 class="blog__post-title">
                12 loại trái cây và rau củ bạn nhất định nên có...
              </h3>
              <a href="#" class="blog__link">Xem thêm →</a>
            </div>
          </div>

          <!-- Bài viết 2 -->
          <div class="blog__item">
            <img src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
              alt="Blog 2" class="blog__image" />
            <div class="blog__content">
              <div class="blog__meta">
                <span class="blog__author">Đăng bởi Admin</span>
                <span class="blog__date">29/6/2025</span>
              </div>
              <h3 class="blog__post-title">
                Dinh dưỡng & calo trong nước cam tươi...
              </h3>
              <a href="#" class="blog__link">Xem thêm →</a>
            </div>
          </div>

          <!-- Bài viết 3 -->
          <div class="blog__item">
            <img src="https://ik.imagekit.io/8tm3umulk/image/s%E1%BA%A3n%20ph%E1%BA%A9m/dua?updatedAt=1762455965231"
              alt="Blog 3" class="blog__image" />
            <div class="blog__content">
              <div class="blog__meta">
                <span class="blog__author">Đăng bởi Admin</span>
                <span class="blog__date">16/11/2025</span>
              </div>
              <h3 class="blog__post-title">
                Những công thức nấu ăn số lượng lớn giúp bạn...
              </h3>
              <a href="#" class="blog__link">Xem thêm →</a>
            </div>
          </div>
        </div>
      </div>
    </section>
<!-- FOOTER -->
<jsp:include page="footer.jsp"></jsp:include>