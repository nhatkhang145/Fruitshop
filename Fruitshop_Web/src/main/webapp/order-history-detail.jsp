<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Chi tiết đơn hàng #${order.id} - Organic Harvest</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/orders.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order-history-detail.css" />
</head>

<body>
  <jsp:include page="header.jsp"></jsp:include>
  
  <div class="breadcrumb">
    <div class="container">
      <a href="${pageContext.request.contextPath}/">Trang chủ</a> &gt;
      <a href="${pageContext.request.contextPath}/profile">Tài khoản</a> &gt;
      <a href="${pageContext.request.contextPath}/orders">Đơn mua</a> &gt; <span>Chi tiết đơn hàng</span>
    </div>
  </div>

  <section class="profile-section">
    <div class="container">
      <div class="profile-container">
        <aside class="profile-sidebar">
          <div class="profile-user-brief">
            <img src="${user.avatar != null ? pageContext.request.contextPath.concat('/').concat(user.avatar) : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}" 
                 alt="Avatar" class="brief-avatar" />
            <div class="brief-info">
              <span class="brief-name">${user.fullname}</span>
              <a href="${pageContext.request.contextPath}/profile" class="brief-edit">
                <i class="fa-solid fa-pen"></i> Sửa hồ sơ
              </a>
            </div>
          </div>

          <ul class="profile-menu">
            <li class="profile-menu-item">
              <a href="${pageContext.request.contextPath}/profile"><i class="fa-regular fa-user"></i> Hồ sơ của tôi</a>
            </li>
            <li class="profile-menu-item active">
              <a href="${pageContext.request.contextPath}/orders"><i class="fa-solid fa-box-open"></i> Đơn mua</a>
            </li>
            <li class="profile-menu-item">
              <a href="${pageContext.request.contextPath}/addresses"><i class="fa-solid fa-location-dot"></i> Địa chỉ</a>
            </li>
            <li class="profile-menu-item">
              <a href="${pageContext.request.contextPath}/change-password.jsp"><i class="fa-solid fa-key"></i> Đổi mật khẩu</a>
            </li>
            <li class="profile-menu-item">
              <a href="${pageContext.request.contextPath}/wishlist"><i class="fa-regular fa-heart"></i> Yêu thích</a>
            </li>
          </ul>
        </aside>

        <main class="profile-content order-detail-content">
          <div class="detail-header">
            <div class="header-left">
              <a href="${pageContext.request.contextPath}/orders" class="btn-back">
                <i class="fa-solid fa-chevron-left"></i> Trở lại
              </a>
              <span class="detail-id">Đơn hàng #${order.id}</span>
              <span class="detail-divider">|</span>
              <span class="detail-status status-${order.status}">${order.statusDisplay}</span>
            </div>
          </div>

          <div class="order-stepper">
            <div class="step-item ${order.status == 'pending' || order.status == 'processing' || order.status == 'shipped' || order.status == 'completed' ? 'completed' : ''}">
              <div class="step-icon">
                <i class="fa-solid fa-file-invoice"></i>
              </div>
              <div class="step-text">
                <p>Đơn hàng đã đặt</p>
                <small><fmt:formatDate value="${order.createdAt}" pattern="HH:mm dd/MM/yyyy" /></small>
              </div>
            </div>
            <div class="step-item ${order.status == 'processing' || order.status == 'shipped' || order.status == 'completed' ? 'completed' : ''}">
              <div class="step-icon">
                <i class="fa-solid fa-box-open"></i>
              </div>
              <div class="step-text">
                <p>Đã xác nhận</p>
                <small>${order.status == 'pending' ? 'Đang chờ...' : 'Đã xác nhận'}</small>
              </div>
            </div>
            <div class="step-item ${order.status == 'shipped' || order.status == 'completed' ? 'completed' : ''}">
              <div class="step-icon">
                <i class="fa-solid fa-truck-fast"></i>
              </div>
              <div class="step-text">
                <p>Đang giao hàng</p>
                <small>${order.status == 'shipped' || order.status == 'completed' ? 'Đang giao' : 'Chưa giao'}</small>
              </div>
            </div>
            <div class="step-item ${order.status == 'completed' ? 'completed active' : ''}">
              <div class="step-icon"><i class="fa-solid fa-star"></i></div>
              <div class="step-text">
                <p>Hoàn thành</p>
                <small>${order.status == 'completed' ? 'Đã hoàn thành' : 'Chưa hoàn thành'}</small>
              </div>
            </div>
          </div>

          <div class="detail-info-grid">
            <div class="info-card">
              <h4>Địa chỉ nhận hàng</h4>
              <div class="info-content">
                <p class="name">${order.fullname}</p>
                <p class="phone">${order.phone}</p>
                <p class="address">${order.address}</p>
              </div>
            </div>
            <div class="info-card">
              <h4>Hình thức giao hàng</h4>
              <div class="info-content">
                <p>Giao hàng tiêu chuẩn</p>
                <p class="shipping-carrier">Phí ship: <fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true" />₫</p>
                <p class="payment-method">Thanh toán: ${order.paymentMethodDisplay}</p>
              </div>
            </div>
          </div>

          <div class="order-card detail-product-list">
            <div class="order-card__body" style="padding-top: 10px; padding-bottom: 10px">
              <c:forEach items="${order.orderDetails}" var="item">
                <div class="order-item">
                  <img src="${pageContext.request.contextPath}/${item.product.image}" 
                       alt="${item.productName}" class="item-thumb" 
                       onerror="this.src='${pageContext.request.contextPath}/assets/images/default-product.png'" />
                  <div class="item-info">
                    <h4 class="item-name">${item.productName}</h4>
                    <p class="item-qty">x${item.quantity}</p>
                  </div>
                  <div class="item-price">
                    <span class="new-price">
                      <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true" />₫
                    </span>
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>

          <div class="detail-summary">
            <div class="summary-row">
              <span>Tổng tiền hàng</span>
              <span><fmt:formatNumber value="${order.totalProductsMoney}" type="number" groupingUsed="true" />₫</span>
            </div>
            <div class="summary-row">
              <span>Phí vận chuyển</span>
              <span><fmt:formatNumber value="${order.shippingFee}" type="number" groupingUsed="true" />₫</span>
            </div>
            <c:if test="${order.discountAmount > 0}">
              <div class="summary-row">
                <span>Giảm giá</span>
                <span>-<fmt:formatNumber value="${order.discountAmount}" type="number" groupingUsed="true" />₫</span>
              </div>
            </c:if>
            <div class="summary-row total">
              <span>Thành tiền</span>
              <span class="total-price">
                <fmt:formatNumber value="${order.finalAmount}" type="number" groupingUsed="true" />₫
              </span>
            </div>
            <div class="payment-method">
              <i class="fa-solid fa-money-bill-wave"></i> Phương thức thanh toán: ${order.paymentMethodDisplay}
            </div>
            <c:if test="${not empty order.note}">
              <div class="order-note" style="margin-top: 10px; padding: 10px; background: #f8f9fa; border-radius: 5px;">
                <strong>Ghi chú:</strong> ${order.note}
              </div>
            </c:if>
          </div>

          <div class="detail-actions">
            <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-outline">Liên hệ Shop</a>
            <c:if test="${order.status == 'completed'}">
              <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary">Mua lại</a>
            </c:if>
          </div>
        </main>
      </div>
    </div>
  </section>
  
  <jsp:include page="footer.jsp"></jsp:include>
  <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>

</html>
