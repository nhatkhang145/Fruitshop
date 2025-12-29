<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

    <!-- Main Content -->
    <div class="content">
      <jsp:include page="header.jsp" />

      <!-- End of Navbar -->
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
            <span class="info">
              <h3>15</h3>
              <p>Chờ xử lý</p>
            </span>
          </li>
          <li>
            <i class="bx bx-package"></i>
            <span class="info">
              <h3>8</h3>
              <p>Đang xử lý</p>
            </span>
          </li>
          <li>
            <i class="bx bxs-truck"></i>
            <span class="info">
              <h3>22</h3>
              <p>Đang giao</p>
            </span>
          </li>
          <li>
            <i class="bx bx-check-circle"></i>
            <span class="info">
              <h3>1,020</h3>
              <p>Đã hoàn thành</p>
            </span>
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
                <input type="date" id="dateFilter" />
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
                <tr>
                  <td>#12345</td>
                  <td>Nguyễn Văn A</td>
                  <td>15-11-2025</td>
                  <td>450,000đ</td>
                  <td><span class="status completed">Hoàn thành</span></td>
                  <td>
                    <a href="/admin/order-detail.jsp" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
                  </td>
                </tr>
                <tr>
                  <td>#12344</td>
                  <td>Trần Thị B</td>
                  <td>15-11-2025</td>
                  <td>1,200,000đ</td>
                  <td><span class="status shipped">Đang giao</span></td>
                  <td>
                    <a href="#" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
                  </td>
                </tr>
                <tr>
                  <td>#12343</td>
                  <td>Lê Văn C</td>
                  <td>14-11-2025</td>
                  <td>780,000đ</td>
                  <td><span class="status processing">Đang xử lý</span></td>
                  <td>
                    <a href="#" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
                  </td>
                </tr>
                <tr>
                  <td>#12342</td>
                  <td>Phạm Hữu D</td>
                  <td>14-11-2025</td>
                  <td>320,000đ</td>
                  <td><span class="status pending">Chờ xử lý</span></td>
                  <td>
                    <a href="#" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
                  </td>
                </tr>
                <tr>
                  <td>#12341</td>
                  <td>Hoàng Thị E</td>
                  <td>13-11-2025</td>
                  <td>500,000đ</td>
                  <td><span class="status cancelled">Đã hủy</span></td>
                  <td>
                    <a href="#" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="pagination">
            <a href="#" class="page-btn disabled">&laquo;</a>
            <a href="#" class="page-btn active">1</a>
            <a href="#" class="page-btn">2</a>
            <a href="#" class="page-btn">3</a>
            <a href="#" class="page-btn">&raquo;</a>
          </div>
        </div>
      </main>
    </div>

    <script src="../assets/js/admin/main.js"></script>
  </body>

  </html>