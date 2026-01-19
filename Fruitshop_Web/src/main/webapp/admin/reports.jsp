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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/reports.css" />
  <title>Thống kê báo cáo</title>
</head>

<body>

<jsp:include page="sidebar.jsp">
  <jsp:param name="activePage" value="reports" />
</jsp:include>

<div class="content">
  <jsp:include page="header.jsp" />

  <main>
    <div class="header">
      <div class="left">
        <h1>Thống kê</h1>
        <ul class="breadcrumb">
          <li><a href="#">Quản lý</a></li>
          <li>/</li>
          <li><a href="#" class="active">Thống kê</a></li>
        </ul>
      </div>

      <div class="date-range-filter">
        <i class="bx bx-calendar"></i>
        <input type="date" id="dateStart" />
        <span>đến</span>
        <input type="date" id="dateEnd" />
        <button class="btn-primary">Lọc dữ liệu</button>
      </div>
    </div>

    <ul class="insights">
      <li>
        <i class="bx bx-dollar-circle"></i>
        <span class="info">
                        <h3><fmt:formatNumber value="${totalRevenue}" type="currency" currencySymbol="đ"/></h3>
                        <p>Tổng Doanh thu</p>
                    </span>
      </li>
      <li>
        <i class="bx bx-receipt"></i>
        <span class="info">
                        <h3>${totalOrders}</h3>
                        <p>Tổng Đơn hàng</p>
                    </span>
      </li>
      <li>
        <i class="bx bx-line-chart"></i>
        <span class="info">
                        <h3>
                            <c:choose>
                              <c:when test="${totalOrders > 0}">
                                <fmt:formatNumber value="${totalRevenue / totalOrders}" type="currency" currencySymbol="đ"/>
                              </c:when>
                              <c:otherwise>0đ</c:otherwise>
                            </c:choose>
                        </h3>
                        <p>Giá trị TB / Đơn</p>
                    </span>
      </li>
      <li>
        <i class="bx bx-user-plus"></i>
        <span class="info">
                        <h3>${totalUsers}</h3>
                        <p>Tổng Thành viên</p>
                    </span>
      </li>
    </ul>

    <div class="bottom-data" style="margin-bottom: 20px;">

      <div class="orders" style="flex: 1; min-width: 300px;">
        <div class="header">
          <h3>Doanh thu theo thời gian</h3>
          <i class="bx bx-refresh"></i>
        </div>
        <div class="chart-container" style="position: relative; height: 350px; width: 100%;">
          <canvas id="salesChart"></canvas>
        </div>
      </div>

      <div class="orders" style="flex: 1; min-width: 300px;">
        <div class="header">
          <h3>Tỷ lệ Danh mục</h3>
          <i class="bx bx-dots-vertical-rounded"></i>
        </div>
        <div class="chart-container" style="position: relative; height: 350px; display: flex; justify-content: center;">
          <canvas id="categoryChart"></canvas>
        </div>
      </div>
    </div>

    <div class="bottom-data">

      <div class="orders" style="flex: 1; min-width: 45%;">
        <div class="header">
          <h3>Top sản phẩm bán chạy</h3>
          <i class="bx bx-download"></i>
        </div>
        <table>
          <thead>
          <tr>
            <th>Sản phẩm</th>
            <th>Đã bán</th>
            <th>Doanh thu</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>
              <img src="${pageContext.request.contextPath}/assets/images/apple.jpg" alt="Img" />
              <p>Táo Envy New Zealand</p>
            </td>
            <td>120</td>
            <td><span class="status completed">30.000.000đ</span></td>
          </tr>
          <tr>
            <td>
              <img src="${pageContext.request.contextPath}/assets/images/9.jpg" alt="Img" />
              <p>Dâu tây Hàn Quốc</p>
            </td>
            <td>85</td>
            <td><span class="status completed">25.500.000đ</span></td>
          </tr>
          <tr>
            <td>
              <img src="${pageContext.request.contextPath}/assets/images/chuối.jpg" alt="Img" />
              <p>Chuối Laba Đà Lạt</p>
            </td>
            <td>200</td>
            <td><span class="status completed">10.000.000đ</span></td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="orders" style="flex: 1; min-width: 45%;">
        <div class="header">
          <h3>Top khách hàng chi tiêu</h3>
          <i class="bx bx-filter"></i>
        </div>
        <table>
          <thead>
          <tr>
            <th>Khách hàng</th>
            <th>Tổng đơn</th>
            <th>Tổng chi</th>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td>
              <img src="${pageContext.request.contextPath}/assets/images/logo.jpg" class="avatar" alt="Ava" />
              <p>Nguyễn Văn A</p>
            </td>
            <td>12</td>
            <td><span class="status completed">15.200.000đ</span></td>
          </tr>
          <tr>
            <td>
              <img src="${pageContext.request.contextPath}/assets/images/logo.jpg" class="avatar" alt="Ava" />
              <p>Trần Thị B</p>
            </td>
            <td>8</td>
            <td><span class="status completed">8.500.000đ</span></td>
          </tr>
          <tr>
            <td>
              <img src="${pageContext.request.contextPath}/assets/images/logo.jpg" class="avatar" alt="Ava" />
              <p>Lê Văn C</p>
            </td>
            <td>5</td>
            <td><span class="status completed">4.100.000đ</span></td>
          </tr>
          </tbody>
        </table>
      </div>

    </div>
  </main>
</div>

<script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
  // Cấu hình Biểu đồ Doanh thu (Bar Chart)
  const ctxSales = document.getElementById('salesChart').getContext('2d');
  new Chart(ctxSales, {
    type: 'bar',
    data: {
      labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8'],
      datasets: [{
        label: 'Doanh thu',
        data: [12, 19, 3, 5, 2, 3, 15, 10],
        backgroundColor: '#3C91E6',
        borderRadius: 4,
        barPercentage: 0.5
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false, // Quan trọng để khớp height 350px
      plugins: {
        legend: { display: false }
      }
    }
  });

  // Cấu hình Biểu đồ Tròn (Doughnut)
  const ctxCategory = document.getElementById('categoryChart').getContext('2d');
  new Chart(ctxCategory, {
    type: 'doughnut',
    data: {
      labels: ['Trái cây', 'Rau củ', 'Hạt', 'Khác'],
      datasets: [{
        data: [55, 30, 10, 5],
        backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0'],
        borderWidth: 0
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false, // Quan trọng
      plugins: {
        legend: { position: 'bottom' }
      }
    }
  });
</script>
</body>
</html>