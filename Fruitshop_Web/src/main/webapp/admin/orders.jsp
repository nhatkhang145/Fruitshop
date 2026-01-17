<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quản lý đơn hàng</title>

  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/Order.css" />
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
</head>

<body>

<jsp:include page="sidebar.jsp">
  <jsp:param name="activePage" value="orders" />
</jsp:include>

<div class="content">

  <jsp:include page="header.jsp" />

  <main>
    <div class="header">
      <div class="left">
        <h1>Quản lý đơn hàng</h1>
        <ul class="breadcrumb">
          <li><a href="#">Quản lý</a></li>
          <li>/</li>
          <li><a href="#" class="active">Đơn hàng</a></li>
        </ul>
      </div>
    </div>

    <ul class="insights">
      <li>
        <i class="bx bx-loader-circle"></i>
        <span class="info"><h3>15</h3><p>Chờ xử lý</p></span>
      </li>
      <li>
        <i class="bx bx-package"></i>
        <span class="info"><h3>8</h3><p>Đang xử lý</p></span>
      </li>
      <li>
        <i class="bx bxs-truck"></i>
        <span class="info"><h3>22</h3><p>Đang giao</p></span>
      </li>
      <li>
        <i class="bx bx-check-circle"></i>
        <span class="info"><h3>1,020</h3><p>Đã hoàn thành</p></span>
      </li>
    </ul>

    <div class="bottom-data">
      <div class="orders">
        <div class="header">
          <h3>Danh sách đơn hàng</h3>
          <div class="filters">
            <i class="bx bx-filter"></i>
            <select id="statusFilter" onchange="filterOrders(this)">
              <option value="all">Tất cả trạng thái</option>
              <option value="pending" ${currentStatus == 'pending' ? 'selected' : ''}>Chờ xử lý</option>
              <option value="processing" ${currentStatus == 'processing' ? 'selected' : ''}>Đang xử lý</option>
              <option value="shipped" ${currentStatus == 'shipped' ? 'selected' : ''}>Đang giao</option>
              <option value="completed" ${currentStatus == 'completed' ? 'selected' : ''}>Hoàn thành</option>
              <option value="cancelled" ${currentStatus == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
            </select>
          </div>
        </div>

        <table id="ordersTable">
          <thead>
          <tr>
            <th>Mã Đơn</th>      <th>Khách hàng</th>   <th>Ngày đặt</th>     <th>Tổng tiền</th>    <th>Trạng thái</th>   <th>Hành động</th>    </tr>
          </thead>
          <tbody>
          <c:forEach items="${orders}" var="o">
            <tr>
              <td>#${o.id}</td>
              <td>
                <div class="user-info">
                  <p>${o.fullname}</p>
                  <small>${o.phone}</small>
                </div>
              </td>
              <td>
                <fmt:formatDate value="${o.createdAt}" pattern="dd-MM-yyyy HH:mm"/>
              </td>
              <td>
                <fmt:formatNumber value="${o.finalAmount}" type="currency" currencySymbol="đ"/>
              </td>
              <td>
                <span class="status ${o.status}">
                    <c:choose>
                      <c:when test="${o.status == 'pending'}">Chờ xử lý</c:when>
                      <c:when test="${o.status == 'processing'}">Đang xử lý</c:when>
                      <c:when test="${o.status == 'shipped'}">Đang giao</c:when>
                      <c:when test="${o.status == 'completed'}">Hoàn thành</c:when>
                      <c:when test="${o.status == 'cancelled'}">Đã hủy</c:when>
                      <c:otherwise>${o.status}</c:otherwise>
                    </c:choose>
                </span>
              </td>
              <td>
                <a href="order-detail?id=${o.id}" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
              </td>
            </tr>
          </c:forEach>
          <%-- Đã xóa đoạn c:if kiểm tra rỗng để tránh lỗi DataTables --%>
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
  // Hàm lọc khi chọn Dropdown
  function filterOrders(selectObject) {
    var value = selectObject.value;
    window.location.href = "orders?status=" + value;
  }

  // Cấu hình DataTables
  $(document).ready(function() {
    $('#ordersTable').DataTable({
      "order": [[ 0, "desc" ]], // Sắp xếp cột ID (cột đầu tiên) giảm dần
      "pageLength": 10,         // Mặc định hiện 10 dòng
      "language": {
        "search": "Tìm kiếm nhanh:",
        "lengthMenu": "Hiển thị _MENU_ đơn hàng",
        "info": "Đang xem _START_ đến _END_ trong tổng số _TOTAL_ đơn",
        "zeroRecords": "Không tìm thấy đơn hàng nào",
        "infoEmpty": "Chưa có đơn hàng",
        "infoFiltered": "(lọc từ _MAX_ đơn)",
        "paginate": {
          "next": "Sau",
          "previous": "Trước"
        }
      }
    });
  });
</script>
</body>
</html>