<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${sessionScope.account == null}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Tài Khoản Của Tôi — The Organic Harvest</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css"/>
</head>
<body>
<div class="main">
    <jsp:include page="header.jsp"></jsp:include>

    <div class="breadcrumb">
        <div class="container">
            <a href="index.jsp">Trang chủ</a> &gt; <span>Hồ sơ của tôi</span>
        </div>
    </div>

    <section class="profile-section">
        <div class="container">
            <div class="profile-container">
                <aside class="profile-sidebar">
                    <div class="profile-user-brief">
                        <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="Avatar" class="brief-avatar" id="briefAvatar"/>
                        <div class="brief-info">
                            <span class="brief-name">${sessionScope.account.fullName}</span>
                            <a href="#" class="brief-edit"><i class="fa-solid fa-pen"></i> Sửa hồ sơ</a>
                        </div>
                    </div>

                    <ul class="profile-menu">
                        <li class="profile-menu-item active">
                            <a href="profile.jsp"><i class="fa-regular fa-user"></i> Hồ sơ của tôi</a>
                        </li>
                        <li class="profile-menu-item">
                            <a href="orders.jsp"><i class="fa-solid fa-box-open"></i> Đơn mua</a>
                        </li>
                        <li class="profile-menu-item">
                            <a href="addresses.jsp"><i class="fa-solid fa-location-dot"></i> Địa chỉ</a>
                        </li>
                        <li class="profile-menu-item">
                            <a href="change-password.jsp"><i class="fa-solid fa-key"></i> Đổi mật khẩu</a>
                        </li>
                        <li class="profile-menu-item">
                            <a href="wishlist.jsp"><i class="fa-regular fa-heart"></i> Yêu thích</a>
                        </li>
                        <li class="profile-menu-item">
                            <a href="logout" style="color: red;"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
                        </li>
                    </ul>
                </aside>

                <main class="profile-content">
                    <div class="profile-header">
                        <h3>Hồ sơ của tôi</h3>
                        <p>Quản lý thông tin hồ sơ để bảo mật tài khoản</p>

                        <c:if test="${not empty requestScope.mess}">
                            <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-top: 10px;">
                                <i class="fa-solid fa-check-circle"></i> ${requestScope.mess}
                            </div>
                        </c:if>
                    </div>

                    <form class="profile-form" action="update-profile" method="post">
                        <div class="profile-form-left">

                            <div class="form-group">
                                <label>Email đăng nhập</label>
                                <input type="text" class="form-input" value="${sessionScope.account.email}" disabled style="background-color: #f9f9f9; color: #666;">
                            </div>

                            <div class="form-group">
                                <label>Họ và tên</label>
                                <input type="text" name="fullname" class="form-input" value="${sessionScope.account.fullName}" required>
                            </div>

                            <div class="form-group">
                                <label>Số điện thoại</label>
                                <input type="text" name="phone" class="form-input" value="${sessionScope.account.phone}" placeholder="Thêm số điện thoại">
                            </div>

                            <div class="form-group">
                                <label>Giới tính</label>
                                <div class="radio-group">
                                    <label class="radio-label"><input type="radio" name="gender" value="male" checked/> Nam</label>
                                    <label class="radio-label"><input type="radio" name="gender" value="female"/> Nữ</label>
                                    <label class="radio-label"><input type="radio" name="gender" value="other"/> Khác</label>
                                </div>
                                <small style="color: orange; font-style: italic;">(Tính năng đang cập nhật)</small>
                            </div>

                            <div class="form-group">
                                <label>Ngày sinh</label>
                                <input type="date" class="form-input" value="2000-01-01">
                                <small style="color: orange; font-style: italic;">(Tính năng đang cập nhật)</small>
                            </div>

                            <button type="submit" class="btn btn-save">Lưu thay đổi</button>
                        </div>

                        <div class="profile-form-right">
                            <div class="avatar-uploader">
                                <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png" alt="User Avatar" id="profileAvatarPreview"/>
                                <label for="fileInput" class="btn btn-outline-light">Chọn ảnh</label>
                                <input type="file" id="fileInput" accept=".jpg,.jpeg,.png" hidden/>
                                <div class="avatar-note">
                                    Dụng lượng file tối đa 1 MB<br/>Định dạng:.JPEG, .PNG
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