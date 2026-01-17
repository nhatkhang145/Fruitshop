<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Chi tiết người dùng</title>
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/product-edit.css">

  <style>
    /* CSS chỉnh sửa riêng cho form user */
    .form-group input[readonly] {
      background-color: #f0f0f0; /* Xám nhẹ cho ô không được sửa */
      cursor: not-allowed;
    }
    .user-avatar {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      object-fit: cover;
      margin-bottom: 20px;
      border: 3px solid var(--primary);
    }
    .avatar-container {
      display: flex;
      flex-direction: column;
      align-items: center;
      margin-bottom: 30px;
    }
  </style>
</head>
<body>

<jsp:include page="sidebar.jsp">
  <jsp:param name="activePage" value="users"/>
</jsp:include>

<div class="content">
  <jsp:include page="header.jsp"/>

  <main>
    <div class="header">
      <div class="left">
        <h1>Chi tiết tài khoản</h1>
        <ul class="breadcrumb">
          <li><a href="users">Người dùng</a></li>
          <li>/</li>
          <li><a href="#" class="active">Chỉnh sửa</a></li>
        </ul>
      </div>
    </div>

    <div class="bottom-data">
      <div class="orders">
        <div class="header">
          <h3>Thông tin thành viên: ${user.fullname}</h3>
        </div>

        <form action="user-detail" method="post" class="add-product-form">

          <input type="hidden" name="id" value="${user.id}">

          <div class="avatar-container">
            <img src="${user.avatar != null ? user.avatar : pageContext.request.contextPath.concat('/assets/images/logo.jpg')}"
                 alt="Avatar" class="user-avatar">
            <p>ID: <strong>#${user.id}</strong></p>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Họ và Tên (Chỉ xem)</label>
              <input type="text" value="${user.fullname}" readonly>
            </div>
            <div class="form-group">
              <label>Email (Tên đăng nhập)</label>
              <input type="email" value="${user.email}" readonly>
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Số điện thoại</label>
              <input type="text" value="${user.phone}" readonly>
            </div>
            <div class="form-group">
              <label>Địa chỉ</label>
              <input type="text" value="${user.address}" readonly>
            </div>
          </div>

          <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eee;">
          <h4>Phân quyền & Trạng thái (Admin chỉnh sửa tại đây)</h4>
          <br>

          <div class="form-row">
            <div class="form-group">
              <label for="role">Vai trò (Role)</label>
              <select name="role" id="role" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;">
                <option value="0" ${user.role == 0 ? 'selected' : ''}>Khách hàng (User)</option>
                <option value="1" ${user.role == 1 ? 'selected' : ''}>Quản trị viên (Admin)</option>
              </select>
            </div>

            <div class="form-group">
              <label for="status">Trạng thái tài khoản</label>
              <select name="status" id="status" style="width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px;">
                <option value="active" ${user.status != 'banned' ? 'selected' : ''} style="color: green; font-weight: bold;">Hoạt động</option>
                <option value="banned" ${user.status == 'banned' ? 'selected' : ''} style="color: red; font-weight: bold;">Đã khóa (Banned)</option>
              </select>
            </div>
          </div>

          <div class="form-actions" style="margin-top: 30px; text-align: right;">
            <a href="users" class="btn-cancel" style="padding: 10px 20px; background: #eee; color: #333; text-decoration: none; border-radius: 5px; margin-right: 10px;">Hủy bỏ</a>
            <button type="submit" class="btn-submit" style="padding: 10px 20px; background: var(--primary); color: #fff; border: none; border-radius: 5px; cursor: pointer;">
              <i class='bx bx-save'></i> Lưu thay đổi
            </button>
          </div>
        </form>
      </div>
    </div>
  </main>
</div>

<script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>
</body>
</html>