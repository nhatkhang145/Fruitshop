<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/Order.css" />
  <title>Quản lý đơn hàng</title>
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
            <select id="statusFilter">
              <option value="">Tất cả trạng thái</option>
              <option value="pending">Chờ xử lý</option>
              <option value="processing">Đang xử lý</option>
              <option value="shipped">Đang giao</option>
              <option value="completed">Hoàn thành</option>
              <option value="cancelled">Đã hủy</option>
            </select>
          </div>
        </div>
        <table>
          <thead>
          <tr>
            <th>Mã Đơn Hàng</th>
            <th>Khách hàng</th>
            <th>Ngày đặt</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
          </tr>
          </thead>
          <tbody>
          <%-- Vòng lặp hiển thị đơn hàng từ Servlet --%>
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
                  <%-- Hiển thị trạng thái với màu sắc tương ứng --%>
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
          <%-- Nếu danh sách trống --%>
          <c:if test="${empty orders}">
            <tr>
              <td colspan="6" style="text-align: center;">Không có đơn hàng nào.</td>
            </tr>
          </c:if>
          </tbody>
        </table>
      </div>

      <div class="pagination">
        <a href="#" class="page-btn disabled">&laquo;</a>
        <a href="#" class="page-btn active">1</a>
        <a href="#" class="page-btn">2</a>
        <a href="#" class="page-btn">&raquo;</a>
      </div>
    </div>
  </main>
</div>

<script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>
</body>
</html>