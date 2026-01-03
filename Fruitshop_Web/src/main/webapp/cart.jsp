<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Giỏ hàng</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cart.css" />
      </head>

      <body>
        <div class="main">
          <jsp:include page="header.jsp"></jsp:include>

          <div class="breadcrumb">
            <div class="grid">
              <a href="index.jsp">Trang chủ</a>
              <i class="fa-solid fa-angle-right"></i>
              <span>Giỏ hàng</span>
            </div>
          </div>

          <div class="page-container">
            <main class="cart-wrapper">
              <div class="cart-main">

                <c:if test="${empty sessionScope.cart}">
                  <div style="text-align: center; margin: 50px 0;">
                    <i class="fa-solid fa-cart-arrow-down" style="font-size: 50px; color: #ccc;"></i>
                    <p style="margin-top: 20px;">Giỏ hàng của bạn đang trống!</p>
                    <a href="shop" class="btn"
                      style="margin-top: 10px; display: inline-block; background: var(--primary-color); color: #fff; padding: 10px 20px; border-radius: 5px; text-decoration: none;">Tiếp
                      tục mua sắm</a>
                  </div>
                </c:if>

                <c:if test="${not empty sessionScope.cart}">
                  <div class="shipping-progress-bar">
                    <p>
                      Đơn hàng của bạn đang được xử lý!
                    </p>
                    <div class="progress-track">
                      <div class="progress-filled" style="width: 50%"></div>
                    </div>
                  </div>

                  <table class="cart-table">
                    <thead>
                      <tr>
                        <th class="product-col">Sản Phẩm</th>
                        <th class="price-col">Giá</th>
                        <th class="quantity-col">Số Lượng</th>
                        <th class="subtotal-col">Thành Tiền</th>
                        <th class="remove-col">&nbsp;</th>
                      </tr>
                    </thead>
                    <tbody>

                      <c:forEach items="${sessionScope.cart}" var="item">
                        <tr>
                          <td class="product-cell">
                            <img src="${item.product.image}" alt="${item.product.name}" />
                            <span>${item.product.name}</span>
                          </td>
                          <td>
                            <fmt:formatNumber value="${item.product.price}" pattern="#,###" />đ
                          </td>
                          <td>
                            <div class="quantity-selector">
                              <button type="button" class="quantity-btn"
                                onclick="location.href='update-cart?pid=${item.product.id}&mode=minus'">-</button>

                              <input type="number" value="${item.quantity}" min="1" readonly />

                              <button type="button" class="quantity-btn"
                                onclick="location.href='update-cart?pid=${item.product.id}&mode=plus'">+</button>
                            </div>
                          </td>
                          <td>
                            <strong>
                              <fmt:formatNumber value="${item.totalPrice}" pattern="#,###" />đ
                            </strong>
                          </td>
                          <td>
                            <a href="remove-cart?pid=${item.product.id}" class="remove-btn"
                              onclick="return confirm('Bạn có chắc muốn xoá sản phẩm này?');">
                              <i class="fa-solid fa-trash-can"></i>
                            </a>
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>

                  <div class="cart-actions">
                    <div class="coupon-area">
                      <input type="text" class="coupon-input" placeholder="Mã giảm giá" />
                      <button class="apply-coupon-btn">ÁP DỤNG MÃ GIẢM GIÁ</button>
                    </div>
                    <a href="shop" class="update-cart-btn" style="text-decoration: none; text-align: center;">TIẾP TỤC
                      MUA HÀNG</a>
                  </div>
                </c:if>
              </div>

              <c:if test="${not empty sessionScope.cart}">
                <aside class="cart-sidebar">
                  <div class="cart-totals">
                    <h2>THÀNH TIỀN</h2>

                    <div class="totals-row">
                      <span>Tạm tính</span>
                      <span>
                        <fmt:formatNumber value="${sessionScope.totalMoney}" pattern="#,###" />đ
                      </span>
                    </div>

                    <div class="shipping-section">
                      <h3>Phương Thức Vận Chuyển</h3>
                      <label class="shipping-option">
                        <input type="radio" name="shipping" checked />
                        Tiêu chuẩn: <strong>Miễn phí</strong>
                      </label>
                      <p class="shipping-note">
                        Phí vận chuyển thực tế sẽ được tính tại trang thanh toán.
                      </p>
                    </div>

                    <div class="totals-row final-total">
                      <span>Tổng cộng</span>
                      <span>
                        <fmt:formatNumber value="${sessionScope.totalMoney}" pattern="#,###" />đ
                      </span>
                    </div>
                    <a href="${pageContext.request.contextPath}/checkout">
                      <button class="checkout-btn">THANH TOÁN</button>
                    </a>
                  </div>
                </aside>
              </c:if>
            </main>
          </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        
        <script src="./assets/js/main.js"></script>
      </body>

      </html>