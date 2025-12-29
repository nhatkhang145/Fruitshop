<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/products.css" />
    <title>Quản lý Mã giảm giá</title>
  </head>

  <body>

    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="coupons" />
    </jsp:include>

    <div class="content">

      <jsp:include page="header.jsp" />

      <main>
        <div class="header">
          <div class="left">
            <h1>Mã giảm giá</h1>
            <ul class="breadcrumb">
              <li><a href="#">Quản lý</a></li>
              <li>/</li>
              <li><a href="#" class="active">Mã giảm giá</a></li>
            </ul>
          </div>
          <a href="/admin/coupon-edit.jsp" class="report">
            <i class="bx bx-plus"></i>
            <span>Tạo mã mới</span>
          </a>
        </div>

        <div class="bottom-data">
          <div class="orders">
            <div class="header">
              <h3>Danh sách Voucher</h3>
              <div class="filters">
                <select>
                  <option value="">Tất cả trạng thái</option>
                  <option value="active">Đang hoạt động</option>
                  <option value="expired">Đã hết hạn</option>
                </select>
              </div>
            </div>
            <table>
              <thead>
                <tr>
                  <th>Mã Code</th>
                  <th>Loại giảm</th>
                  <th>Giá trị</th>
                  <th>Đơn tối thiểu</th>
                  <th>Hạn sử dụng</th>
                  <th>Lượt dùng</th>
                  <th>Trạng thái</th>
                  <th>Hành động</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><strong>TET2025</strong></td>
                  <td>Phần trăm</td>
                  <td>10%</td>
                  <td>500.000đ</td>
                  <td>30-01-2025</td>
                  <td>15/100</td>
                  <td><span class="status completed">Hoạt động</span></td>
                  <td>
                    <a href="/admin/coupon-edit.jsp?id=1" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td><strong>FREESHIP</strong></td>
                  <td>Tiền mặt</td>
                  <td>30.000đ</td>
                  <td>300.000đ</td>
                  <td>31-12-2025</td>
                  <td>50/200</td>
                  <td><span class="status expired">Hết hạn</span></td>
                  <td>
                    <a href="/admin/coupon-edit.jsp?id=2" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td><strong>CHAOBANMOI</strong></td>
                  <td>Tiền mặt</td>
                  <td>50.000đ</td>
                  <td>0đ</td>
                  <td>01-01-2024</td>
                  <td>100/100</td>
                  <td><span class="status cancelled">Đã hủy</span></td>
                  <td>
                    <a href="/admin/coupon-edit.jsp?id=3" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </main>
    </div>
    <script src="../assets/js/admin/main.js"></script>
  </body>

  </html>