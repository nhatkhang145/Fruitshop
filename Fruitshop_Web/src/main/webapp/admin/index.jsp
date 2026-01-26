<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dal.ProductDAO" %>
<%@ page import="model.Order" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%
    dal.OrderDAO orderDAO = new dal.OrderDAO();
    dal.ProductDAO productDAO = new dal.ProductDAO();

    int totalOrders = orderDAO.countTotalOrders();
    int totalUsers = orderDAO.countTotalUsers();
    double totalRevenue = orderDAO.getTotalRevenue();
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    if (startDate == null || endDate == null) {
            endDate = java.time.LocalDate.now().toString();
            startDate = java.time.LocalDate.now().minusDays(6).toString();
    }

    List<Double> revenueData = orderDAO.getRevenueByPeriod(startDate, endDate);
    List<String> revenueLabels = orderDAO.getLabelsByPeriod(startDate, endDate);
    List<Order> recentOrders = orderDAO.getTop5RecentOrders();
    List<Product> lowStockProducts = productDAO.getLowStockProducts(10);

    request.setAttribute("totalOrders", totalOrders);
    request.setAttribute("totalUsers", totalUsers);
    request.setAttribute("totalRevenue", totalRevenue);
    request.setAttribute("recentOrders", recentOrders);
    request.setAttribute("lowStockProducts", lowStockProducts);
    request.setAttribute("revenueData", revenueData);
    request.setAttribute("revenueLabels", revenueLabels);
%>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Tổng quan - Admin</title>

    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/dashboard.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  </head>

  <body>

    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="dashboard" />
    </jsp:include>

    <div class="content">

      <jsp:include page="header.jsp" />

      <main>
        <div class="header">
          <div class="left">
            <h1>Tổng quan</h1>
            <ul class="breadcrumb">
              <li><a href="#">Thống kê</a></li>
              <li>/</li>
              <li><a href="#" class="active">Tổng quan</a></li>
            </ul>
          </div>
          <a href="#" class="report" id="exportBtn">
            <i class="bx bx-cloud-download"></i>
            <span>Tải báo cáo</span>
          </a>
        </div>

        <ul class="insights">
          <li>
            <i class="bx bx-calendar-check"></i>
            <span class="info">
              <h3>${totalOrders}</h3>
              <p>Tổng đơn hàng</p>
            </span>
          </li>
          <li>
            <i class="bx bx-show-alt"></i>
            <span class="info">
              <h3>${totalUsers}</h3>
              <p>Khách hàng</p>
            </span>
          </li>
          <li>
            <i class="bx bx-dollar-circle"></i>
            <span class="info">
              <h3><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="đ"/></h3>
              <p>Tổng doanh thu</p>
            </span>
          </li>
        </ul>

        <div class="bottom-data">
          <div class="orders">
            <div class="header">
                <h3>Biểu đồ doanh thu</h3>
                <form action="index.jsp" method="GET" class="filter-form" style="display: flex; gap: 10px; align-items: center;">
                    <input type="date" name="startDate" value="${param.startDate != null ? param.startDate : defaultStartDate}" class="form-control">
                    <span>đến</span>
                    <input type="date" name="endDate" value="${param.endDate != null ? param.endDate : defaultEndDate}" class="form-control">
                    <button type="submit" class="btn-filter" style="background: var(--primary); color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;">Lọc</button>
                </form>
            </div>
            <div class="chart-container-sm">
              <canvas id="salesChart7Days"></canvas>
            </div>
          </div>

          <div class="reminders">
            <div class="header">
              <h3>Sản phẩm sắp hết hàng</h3>
              <a href="${pageContext.request.contextPath}/admin/products" class="view-all">
                Xem tất cả <i class="bx bx-right-arrow-alt"></i>
              </a>
            </div>
            <ul class="task-list">
              <c:forEach items="${lowStockProducts}" var="p">
                <li class="low-stock">
                  <div class="task-title">
                    <img src="${pageContext.request.contextPath}/${p.image}" alt="${p.name}" />
                    <p>${p.name}</p>
                  </div>
                  <span class="stock-count" style="color: var(--danger);">Còn ${p.quantity}</span>
                </li>
              </c:forEach>
              <c:if test="${empty lowStockProducts}">
                <p style="padding: 20px; text-align: center;">Không có sản phẩm nào sắp hết hàng.</p>
              </c:if>
            </ul>
          </div>
        </div>
      </main>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>
    <script>
      const ctx = document.getElementById('salesChart7Days').getContext('2d');
      new Chart(ctx, {
        type: 'line',
        data: {
          // JSTL đổ dữ liệu nhãn ngày từ Java vào JS
          labels: [
              <c:forEach items="${revenueLabels}" var="label" varStatus="loop">
                  "${label}"${!loop.last ? ',' : ''}
              </c:forEach>
          ],
          datasets: [{
            label: 'Doanh thu (VNĐ)',
            // JSTL đổ mảng số liệu từ Java vào JS
            data: ${revenueData},
            borderColor: '#388E3C',
            backgroundColor: 'rgba(56, 142, 60, 0.2)',
            borderWidth: 2,
            tension: 0.4,
            fill: true
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            y: {
              beginAtZero: true,
              ticks: {
                callback: function(value) {
                  return value.toLocaleString('vi-VN') + ' đ';
                }
              }
            }
          }
        }
      });
    </script>
  </body>

  </html>