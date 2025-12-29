<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
              <h3>1,074</h3>
              <p>Đơn hàng hoàn thành</p>
            </span>
          </li>
          <li>
            <i class="bx bx-show-alt"></i>
            <span class="info">
              <h3>3,944</h3>
              <p>Lượt truy cập</p>
            </span>
          </li>
          <li>
            <i class="bx bx-line-chart"></i>
            <span class="info">
              <h3>14,721</h3>
              <p>Lượt tìm kiếm</p>
            </span>
          </li>
          <li>
            <i class="bx bx-dollar-circle"></i>
            <span class="info">
              <h3>$6,742</h3>
              <p>Tổng doanh thu</p>
            </span>
          </li>
        </ul>

        <div class="bottom-data">
          <div class="orders">
            <div class="header">
              <h3>Biểu đồ doanh thu</h3>
              <i class="bx bx-filter"></i>
              <i class="bx bx-search"></i>
            </div>
            <div class="chart-container-sm">
              <canvas id="salesChart7Days"></canvas>
            </div>
          </div>

          <div class="reminders">
            <div class="header">
              <h3>Sản phẩm sắp hết hàng</h3>
              <a href="${pageContext.request.contextPath}/admin/products.jsp" class="view-all">
                Xem tất cả <i class="bx bx-right-arrow-alt"></i>
              </a>
            </div>
            <ul class="task-list">
              <li class="low-stock">
                <div class="task-title">
                  <img src="https://via.placeholder.com/36x36" alt="Icon" />
                  <p>Dâu tây Hàn Quốc (Hộp 500g)</p>
                </div>
                <span class="stock-count">Còn 5</span>
              </li>
              <li class="low-stock">
                <div class="task-title">
                  <img src="https://via.placeholder.com/36x36" alt="Icon" />
                  <p>Cam Vàng Mỹ</p>
                </div>
                <span class="stock-count">Còn 8</span>
              </li>
              <li class="completed">
                <div class="task-title">
                  <img src="https://via.placeholder.com/36x36" alt="Icon" />
                  <p>Táo Envy New Zealand</p>
                </div>
                <span class="stock-count">Còn 120</span>
              </li>
            </ul>
          </div>
        </div>
      </main>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>
    <script>
      // Code biểu đồ doanh thu (Giữ nguyên logic JS của bạn)
      const ctx = document.getElementById('salesChart7Days').getContext('2d');
      new Chart(ctx, {
        type: 'line',
        data: {
          labels: ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN'],
          datasets: [{
            label: 'Doanh thu (Triệu VNĐ)',
            data: [12, 19, 3, 5, 2, 3, 10],
            borderColor: '#388E3C',
            backgroundColor: 'rgba(56, 142, 60, 0.2)',
            borderWidth: 2,
            tension: 0.4
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false
        }
      });
    </script>
  </body>

  </html>