<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/users.css" />
    <title>Khách hàng</title>
  </head>

  <body>
    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="users" />
    </jsp:include>

    <!-- Main Content -->
    <div class="content">
      <jsp:include page="header.jsp" />

      <!-- End of Navbar -->
      <main>
        <div class="header">
          <div class="left">
            <h1>Quản lý khách hàng</h1>
            <ul class="breadcrumb">
              <li><a href="#">Quản lý</a></li>
              <li>/</li>
              <li><a href="#" class="active">Khách hàng</a></li>
            </ul>
          </div>
          <a href="#" class="report" id="exportCsvBtn">
            <i class="bx bx-download"></i>
            <span>Xuất Excel/CSV</span>
          </a>
        </div>

        <ul class="insights">
          <li>
            <i class="bx bx-group"></i>
            <span class="info">
              <h3>5,780</h3>
              <p>Tổng khách hàng</p>
            </span>
          </li>
          <li>
            <i class="bx bx-user-plus"></i>
            <span class="info">
              <h3>120</h3>
              <p>Khách hàng mới (Tháng này)</p>
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
              <h3>Danh sách khách hàng</h3>
              <div class="filters">
                <i class="bx bx-filter"></i>
                <select id="groupFilter">
                  <option value="">Tất cả các nhóm</option>
                  <option value="vip">VIP</option>
                  <option value="new">Khách hàng mới</option>
                  <option value="regular">Khách hàng thân thiết</option>
                  <option value="banned">Bị khóa</option>
                </select>
              </div>
            </div>
            <table>
              <thead>
                <tr>
                  <th>Khách hàng</th>
                  <th>Email / SĐT</th>
                  <th>Ngày đăng ký</th>
                  <th>Số đơn hàng</th>
                  <th>Tổng chi tiêu</th>
                  <th>Trạng thái</th>
                  <th>Hành động</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/40x40" alt="Avatar" />
                    <p>Nguyễn Văn A</p>
                  </td>
                  <td>nguyenvana@gmail.com</td>
                  <td>10-01-2024</td>
                  <td>25</td>
                  <td>15,200,000đ</td>
                  <td><span class="status active">Hoạt động</span></td>
                  <td>
                    <a href="/admin/user-detail.jsp" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
                  </td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/40x40" alt="Avatar" />
                    <p>Trần Thị B</p>
                  </td>
                  <td>0905123456</td>
                  <td>14-11-2025</td>
                  <td>1</td>
                  <td>350,000đ</td>
                  <td><span class="status active">Hoạt động</span></td>
                  <td>
                    <a href="#" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
                  </td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/40x40" alt="Avatar" />
                    <p>Lê Văn C</p>
                  </td>
                  <td>levanc@gmail.com</td>
                  <td>05-03-2024</td>
                  <td>8</td>
                  <td>4,500,000đ</td>
                  <td><span class="status banned">Bị khóa</span></td>
                  <td>
                    <a href="#" class="action-btn view"><i class="bx bx-show"></i> Xem</a>
                  </td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/40x40" alt="Avatar" />
                    <p>Phạm Hữu D</p>
                  </td>
                  <td>phamhuud@gmail.com</td>
                  <td>22-07-2024</td>
                  <td>12</td>
                  <td>8,120,000đ</td>
                  <td><span class="status active">Hoạt động</span></td>
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