<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Thanh toán - Organic Harvest</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/checkout.css" />
      </head>

      <body>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="breadcrumb">
          <div class="grid">
            <a href="${pageContext.request.contextPath}/cart.jsp">Giỏ hàng</a>
            <i class="fa-solid fa-angle-right"></i>
            <span>Thanh toán</span>
          </div>
        </div>

        <div class="container-checkout">
          <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
            <div class="checkout-layout">
              <!-- LEFT SIDE: SHIPPING INFO -->
              <div class="checkout-layout__form-wrapper">
                <c:if test="${not empty error}">
                  <div class="alert alert-danger"
                    style="background: #fee; color: #c00; padding: 12px; margin-bottom: 15px; border-radius: 5px;">
                    ${error}
                  </div>
                </c:if>

                <div class="checkout-section">
                  <h2 class="billing-form__title">Thông tin nhận hàng</h2>

                  <!-- Hiển thị danh sách địa chỉ nếu có -->
                  <c:if test="${not empty addresses}">
                    <div class="billing-form__group">
                      <label class="billing-form__label">Chọn địa chỉ đã lưu</label>
                      <select class="billing-form__input" id="addressSelect" onchange="fillAddressFromSelect(this)">
                        <option value="">-- Chọn địa chỉ --</option>
                        <c:forEach var="addr" items="${addresses}">
                          <option value="${addr.id}" data-name="${addr.receiverName}" data-phone="${addr.phoneNumber}"
                            data-address="${addr.address}, ${addr.city}" <c:if test="${addr.defaultAddress}">selected
                  </c:if>>${addr.receiverName} - ${addr.phoneNumber}</option>
                  </c:forEach>
                  </select>
                </div>
                </c:if>

                <div class="billing-form__group">
                  <label class="billing-form__label" for="fullname">Họ và tên *</label>
                  <input class="billing-form__input" type="text" id="fullname" name="fullname" value="${user.fullName}"
                    required />
                </div>

                <div class="billing-form__group">
                  <label class="billing-form__label" for="phone">Số điện thoại *</label>
                  <input class="billing-form__input" type="tel" id="phone" name="phone" value="${user.phone}"
                    required />
                </div>

                <div class="billing-form__group">
                  <label class="billing-form__label" for="address">Địa chỉ nhận hàng *</label>
                  <textarea class="billing-form__input billing-form__input--textarea" id="address" name="address"
                    rows="3" placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố" required></textarea>
                </div>

                <div class="billing-form__group" style="margin-top: 20px">
                  <label class="billing-form__label" for="note">Ghi chú đơn hàng (tùy chọn)</label>
                  <textarea class="billing-form__input billing-form__input--textarea" id="note" name="note"
                    placeholder="Ví dụ: Giao hàng trong giờ hành chính..."></textarea>
                </div>

                <c:if test="${not empty addresses}">
                  <div style="margin-top: 15px;">
                    <a href="${pageContext.request.contextPath}/addresses"
                      style="color: #5a9a5a; text-decoration: none; font-size: 14px;">
                      <i class="fa-solid fa-location-dot"></i> Quản lý sổ địa chỉ
                    </a>
                  </div>
                </c:if>
              </div>
            </div>

            <!-- RIGHT SIDE: ORDER SUMMARY -->
            <div class="checkout-layout__summary-wrapper">
              <div class="order-summary">
                <h2 class="order-summary__title">Đơn hàng của bạn</h2>

                <table class="order-summary__table">
                  <thead class="thead-border">
                    <tr class="order-summary__row order-summary__row--header">
                      <th class="order-summary__cell order-summary__cell--header">Sản phẩm</th>
                      <th class="order-summary__cell order-summary__cell--header">Tạm tính</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach items="${sessionScope.cart}" var="item">
                      <tr class="order-summary__row__item">
                        <td class="order-summary__cell">
                          <span class="order-summary__product-name">${item.product.name}</span>
                          &times; ${item.quantity}
                        </td>
                        <td class="order-summary__cell">
                          <span class="order-summary__price">
                            <fmt:formatNumber value="${item.product.salePrice * item.quantity}" type="number"
                              groupingUsed="true" /> ₫
                          </span>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                  <tfoot>
                    <tr class="order-summary__row order-summary__row--footer">
                      <th class="order-summary__cell order-summary__cell--label">Tạm tính</th>
                      <td class="order-summary__cell">
                        <span class="order-summary__price">
                          <fmt:formatNumber value="${totalProducts}" type="number" groupingUsed="true" /> ₫
                        </span>
                      </td>
                    </tr>
                    <tr class="order-summary__row order-summary__row--footer">
                      <th class="order-summary__cell order-summary__cell--label">Phí vận chuyển</th>
                      <td class="order-summary__cell">
                        <span class="order-summary__price--shipping">
                          <fmt:formatNumber value="${shippingFee}" type="number" groupingUsed="true" /> ₫
                        </span>
                      </td>
                    </tr>
                    <c:if test="${discount > 0}">
                      <tr class="order-summary__row order-summary__row--footer">
                        <th class="order-summary__cell order-summary__cell--label">Giảm giá</th>
                        <td class="order-summary__cell">
                          <span class="order-summary__price" style="color: #d9534f;">
                            -
                            <fmt:formatNumber value="${discount}" type="number" groupingUsed="true" /> ₫
                          </span>
                        </td>
                      </tr>
                    </c:if>
                    <tr class="order-summary__row order-summary__row--footer">
                      <th class="order-summary__cell order-summary__cell--label">Tổng cộng</th>
                      <td class="order-summary__cell">
                        <span class="order-summary__price order-summary__price--total">
                          <fmt:formatNumber value="${finalAmount}" type="number" groupingUsed="true" /> ₫
                        </span>
                      </td>
                    </tr>
                  </tfoot>
                </table>

                <div class="payment">
                  <ul class="payment__list">
                    <li class="payment__option">
                      <input class="payment__radio" type="radio" name="paymentMethod" id="payment-cod" value="COD"
                        checked />
                      <label class="payment__label" for="payment-cod">Trả tiền mặt khi nhận hàng (COD)</label>
                      <div class="payment__description">Thanh toán bằng tiền mặt khi giao hàng.</div>
                    </li>
                    <li class="payment__option">
                      <input class="payment__radio" type="radio" name="paymentMethod" id="payment-bank"
                        value="bank_transfer" />
                      <label class="payment__label" for="payment-bank">Chuyển khoản ngân hàng</label>
                      <div class="payment__description">Nội dung: [Tên] + [Mã đơn hàng] STK: 123456789 Ngân hàng:
                        Vietcombank</div>
                    </li>
                  </ul>
                  <p class="payment__privacy-text">
                    Thông tin cá nhân của bạn sẽ được sử dụng để xử lý đơn hàng, hỗ trợ trải nghiệm của bạn trên trang
                    web này và cho các mục đích khác được mô tả trong chính sách riêng tư của chúng tôi.
                  </p>
                  <button type="submit" class="button button--primary button--fullwidth">Đặt hàng</button>
                </div>
              </div>
            </div>
        </div>
        </form>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
        <script>
          function fillAddressFromSelect(select) {
            var selectedOption = select.options[select.selectedIndex];
            if (selectedOption.value) {
              document.getElementById('fullname').value = selectedOption.getAttribute('data-name') || '';
              document.getElementById('phone').value = selectedOption.getAttribute('data-phone') || '';
              document.getElementById('address').value = selectedOption.getAttribute('data-address') || '';
            }
          }

          // Auto-fill nếu có địa chỉ mặc định
          window.addEventListener('DOMContentLoaded', function () {
            var addressSelect = document.getElementById('addressSelect');
            if (addressSelect && addressSelect.selectedIndex > 0) {
              fillAddressFromSelect(addressSelect);
            }
          });
        </script>
      </body>

      </html>