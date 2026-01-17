<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quản lý người dùng</title>

  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/users.css" />
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
</head>

<body>

<jsp:include page="sidebar.jsp">
  <jsp:param name="activePage" value="users" />
</jsp:include>

<div class="content">
  <jsp:include page="header.jsp" />

  <main>
    <div class="header">
      <div class="left">
        <h1>Quản lý người dùng</h1>
        <ul class="breadcrumb">
          <li><a href="#">Quản lý</a></li>
          <li>/</li>
          <li><a href="#" class="active">Người dùng</a></li>
        </ul>
      </div>
      <a href="#" class="report" style="background: var(--primary);">
        <i class="bx bx-user-plus"></i>
        <span>Thêm quản trị viên</span>
      </a>
    </div>

    <ul class="insights">
      <li>
        <i class="bx bx-group"></i>
        <span class="info">
                    <h3>${fn:length(users)}</h3>
                    <p>Tổng thành viên</p>
                </span>
      </li>
      <li>
        <i class="bx bx-user-plus"></i>
        <span class="info">
                    <h3>120</h3> <p>Khách hàng mới</p>
                </span>
      </li>
      <li>
        <i class="bx bx-star"></i>
        <span class="info">
                    <h3>85</h3> <p>Khách hàng VIP</p>
                </span>
      </li>
      <li>
        <i class="bx bx-user-x"></i>
        <span class="info">
                    <h3>12</h3> <p>Tài khoản bị khóa</p>
                </span>
      </li>
    </ul>
    <div class="bottom-data">
      <div class="orders">
        <div class="header">
          <h3>Danh sách tài khoản</h3>
        </div>

        <table id="usersTable">
          <thead>
          <tr>
            <th>Avatar</th>
            <th>Họ và Tên</th>
            <th>Email</th>
            <th>SĐT</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach items="${users}" var="u">
            <tr>
              <td>
                <img src="${u.avatar != null ? u.avatar : pageContext.request.contextPath.concat('/assets/images/logo.jpg')}" alt="User Avatar">
              </td>
              <td>${u.fullname}</td>
              <td>${u.email}</td>
              <td>${u.phone}</td>
              <td>
                <c:choose>
                  <c:when test="${u.role == 1}">
                    <span class="status completed">Admin</span>
                  </c:when>
                  <c:otherwise>
                    <span class="status process">Khách hàng</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <c:choose>
                  <c:when test="${u.status == 'banned'}">
                    <span class="status pending">Đã khóa</span>
                  </c:when>
                  <c:otherwise>
                    <span class="status completed">Hoạt động</span>
                  </c:otherwise>
                </c:choose>
              </td>
              <td>
                <a href="user-detail?id=${u.id}" class="action-btn view">
                  <i class='bx bx-edit'></i> Sửa
                </a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </main>
</div>

<script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

<script>
  $(document).ready(function() {
    $('#usersTable').DataTable({
      "pageLength": 10,
      "language": {
        "search": "Tìm kiếm thành viên:",
        "lengthMenu": "Hiển thị _MENU_ người",
        "info": "Hiển thị _START_ - _END_ trong _TOTAL_ tài khoản",
        "paginate": { "next": "Sau", "previous": "Trước" },
        "zeroRecords": "Không tìm thấy người dùng nào"
      }
    });
  });
</script>

</body>
</html>