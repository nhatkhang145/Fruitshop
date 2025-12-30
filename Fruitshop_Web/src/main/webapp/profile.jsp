<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Tài Khoản Của Tôi — The Organic Harvest</title>

  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css" />

  <style>
    /* Thêm style cho thông báo */
    .alert { padding: 10px; margin-bottom: 15px; border-radius: 4px; }
    .alert-success { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
    .alert-danger { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
  </style>
  
</head>
<body>
<div class="main">
  <jsp:include page="header.jsp"></jsp:include>

  <div class="breadcrumb">
    <div class="container">
      <a href="${pageContext.request.contextPath}/">Trang chủ</a> &gt; <span>Hồ sơ của tôi</span>
    </div>
  </div>

  <section class="profile-section">
    <div class="container">
      <div class="profile-container">
        <aside class="profile-sidebar">
          <div class="profile-user-brief">
            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="Avatar" class="brief-avatar" id="briefAvatar" />
            <div class="brief-info">
              <span class="brief-name">${sessionScope.account.fullName}</span>
              <a href="#" class="brief-edit"><i class="fa-solid fa-pen"></i> Sửa hồ sơ</a>
            </div>
          </div>

          <ul class="profile-menu">
            <li class="profile-menu-item active">
              <a href="profile"><i class="fa-regular fa-user"></i> Hồ sơ của tôi</a>
            </li>
            <li class="profile-menu-item">
              <a href="orders.jsp"><i class="fa-solid fa-box-open"></i> Đơn mua</a>
            </li>
            <li class="profile-menu-item">
              <a href="change-password.jsp"><i class="fa-solid fa-key"></i> Đổi mật khẩu</a>
            </li>
            <li class="profile-menu-item">
              <a href="${pageContext.request.contextPath}/logout" class="text-danger">
                <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất
              </a>
            </li>
          </ul>
        </aside>

        <main class="profile-content">
          <div class="profile-header">
            <h3>Hồ sơ của tôi</h3>
            <p>Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
          </div>

          <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
          </c:if>
          <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
          </c:if>

          <form class="profile-form" action="profile" method="post">
            <div class="profile-form-left">

              <div class="form-group">
                <label>Email (Tên đăng nhập)</label>
                <div class="input-with-link">
                  <input type="text" class="form-input" value="${sessionScope.account.email}" readonly style="background-color: #f9f9f9; color: #666;">
                </div>
              </div>

              <div class="form-group">
                <label>Họ và tên</label>
                <input type="text" name="fullname" class="form-input" value="${sessionScope.account.fullName}" required />
              </div>

              <div class="form-group">
                <label>Số điện thoại</label>
                <input type="text" name="phone" class="form-input" value="${sessionScope.account.phone}" />
              </div>

              <div class="form-group">
                <label>Địa chỉ nhận hàng</label>
                <input type="text" name="address" class="form-input" value="${userAddress}" placeholder="Nhập địa chỉ giao hàng mặc định" />
              </div>

              <div class="form-group">
                <label>Giới tính</label>
                <div class="radio-group">
                  <label class="radio-label">
                    <input type="radio" name="gender" value="Nam" ${sessionScope.account.gender == 'Nam' ? 'checked' : ''} /> Nam
                  </label>
                  <label class="radio-label">
                    <input type="radio" name="gender" value="Nữ" ${sessionScope.account.gender == 'Nữ' ? 'checked' : ''} /> Nữ
                  </label>
                  <label class="radio-label">
                    <input type="radio" name="gender" value="Khác" ${sessionScope.account.gender == 'Khác' ? 'checked' : ''} /> Khác
                  </label>
                </div>
              </div>

              <button type="submit" class="btn btn-save">Lưu thay đổi</button>
            </div>

            <div class="profile-form-right">
              <div class="avatar-uploader">
                <img src="${sessionScope.account.avatar != null ? sessionScope.account.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                     alt="User Avatar" id="profileAvatarPreview" />
                <label for="fileInput" class="btn btn-outline-light">Chọn ảnh</label>
                <input type="file" id="fileInput" accept=".jpg,.jpeg,.png" hidden />
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

  <jsp:include page="footer.jsp"></jsp:include>
</div>
</body>
</html>