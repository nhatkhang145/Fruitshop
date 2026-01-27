<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Quản lý người dùng</title>

        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />

        <style>
          /* === BẮT BUỘC HEADER MÀU XANH === */
          /* Dùng selector cực mạnh để đè tất cả CSS khác */
          table.dataTable thead th,
          #usersTable thead th {
            background-color: #37878d !important;
            /* Màu xanh cổ vịt */
            color: #ffffff !important;
            /* Chữ trắng */
            border-bottom: none !important;
            padding: 15px 10px !important;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            white-space: nowrap;
          }

          /* Bo tròn góc header */
          table.dataTable thead th:first-child {
            border-top-left-radius: 10px;
          }

          table.dataTable thead th:last-child {
            border-top-right-radius: 10px;
          }

          /* Hover dòng */
          table.dataTable tbody tr:hover {
            background-color: #f1f8ff !important;
          }

          /* Chỉnh lại phân trang cho khớp màu */
          .dataTables_paginate .paginate_button.current,
          .dataTables_paginate .paginate_button.current:hover {
            background: #37878d !important;
            color: #fff !important;
            border: none;
          }

          /* Badge trạng thái */
          .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
          }

          .status.pending {
            background: #fef3c7;
            color: #b45309;
          }

          .status.processing {
            background: #e0f2fe;
            color: #0369a1;
          }

          .status.shipped {
            background: #ddd6fe;
            color: #6d28d9;
          }

          .status.completed {
            background: #d1fae5;
            color: #047857;
          }

          .status.cancelled {
            background: #fee2e2;
            color: #b91c1c;
          }

          /* Nút hành động */
          .action-btn {
            display: inline-flex;
            width: 35px;
            height: 35px;
            border-radius: 5px;
            align-items: center;
            justify-content: center;
            font-size: 18px;
          }

          .action-btn.view {
            background: #e0f2fe;
            color: #0369a1;
          }

          .action-btn.view:hover {
            background: #0369a1;
            color: #fff;
          }

          /* Wrapper DataTables font */
          .dataTables_wrapper {
            font-family: 'Roboto', sans-serif;
            font-size: 14px;
            margin-top: 10px;
          }

          .dataTables_filter input {
            border-radius: 20px;
            padding: 5px 10px;
            border: 1px solid #ddd;
            outline: none;
          }
        </style>
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
                  <h3>120</h3>
                  <p>Khách hàng mới</p>
                </span>
              </li>
              <li>
                <i class="bx bx-star"></i>
                <span class="info">
                  <h3>85</h3>
                  <p>Khách hàng VIP</p>
                </span>
              </li>
              <li>
                <i class="bx bx-user-x"></i>
                <span class="info">
                  <h3>12</h3>
                  <p>Tài khoản bị khóa</p>
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
                          <img
                            src="${u.avatar != null ? u.avatar : pageContext.request.contextPath.concat('/assets/images/logo.jpg')}"
                            alt="User Avatar">
                        </td>
                        <td>${u.fullName}</td>
                        <td>${u.email}</td>
                        <td>${u.phone}</td>
                        <td>
                          <c:choose>
                            <c:when test="${u.role == 1}">
                              <span class="status completed">Admin</span>
                            </c:when>
                            <c:otherwise>
                              <span class="status completed">Khách hàng</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${u.status == 0}">
                              <span class="status pending">Đã khóa</span>
                            </c:when>
                            <c:otherwise>
                              <span class="status completed">Hoạt động</span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <a href="user-detail?id=${u.id}" class="action-btn view" title="Xem">
                            <i class="bx bx-show"></i>
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
          $(document).ready(function () {
            $('#usersTable').DataTable({
              "order": [[0, "desc"]],
              "pageLength": 10,
              "language": {
                "search": "Tìm kiếm:",
                "lengthMenu": "Hiển thị _MENU_ dòng",
                "info": "Trang _PAGE_ / _PAGES_",
                "paginate": { "first": "«", "last": "»", "next": ">", "previous": "<" },
                "zeroRecords": "Không tìm thấy người dùng nào"
              }
            });
          });
        </script>

      </body>

      </html>