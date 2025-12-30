<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/user-detail.css" />
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
            <h1 id="pageTitle">Nguyễn Văn A</h1>
            <ul class="breadcrumb">
              <li><a href="/admin/users.jsp">Khách hàng</a></li>
              <li>/</li>
              <li><a href="#" class="active" id="breadcrumbTitle">Nguyễn Văn A</a></li>
            </ul>
          </div>
        </div>

        <div class="bottom-data">
          <div class="user-detail">
            <div class="user-detail__main">
              <div class="user-detail__card">
                <legend class="user-detail__legend">Lịch sử Đơn hàng</legend>
                <table class="user-detail__order-table">
                  <thead>
                    <tr>
                      <th>Mã Đơn hàng</th>
                      <th>Ngày</th>
                      <th>Trạng thái</th>
                      <th>Tổng tiền</th>
                      <th>Hành động</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr>
                      <td><strong>#12345</strong></td>
                      <td>15-11-2025</td>
                      <td><span class="status completed">Hoàn thành</span></td>
                      <td>450,000đ</td>
                      <td>
                        <a href="/admin/order-detail.jsp?id=12345" class="action-btn view"><i
                            class="bx bx-show"></i></a>
                      </td>
                    </tr>
                    <tr>
                      <td><strong>#12301</strong></td>
                      <td>05-11-2025</td>
                      <td><span class="status completed">Hoàn thành</span></td>
                      <td>1,200,000đ</td>
                      <td>
                        <a href="/admin/order-detail.jsp?id=12301" class="action-btn view"><i
                            class="bx bx-show"></i></a>
                      </td>
                    </tr>
                    <tr>
                      <td><strong>#12250</strong></td>
                      <td>20-10-2025</td>
                      <td><span class="status cancelled">Đã hủy</span></td>
                      <td>300,000đ</td>
                      <td>
                        <a href="/admin/order-detail.jsp?id=12250" class="action-btn view"><i
                            class="bx bx-show"></i></a>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>

              <div class="user-detail__card">
                <legend class="user-detail__legend">Ghi chú Nội bộ</legend>
                <div class="user-detail__notes-list">
                  <div class="note-item">
                    <p>Khách hàng VIP, cần ưu tiên hỗ trợ.</p>
                    <small>Admin A - 15/11/2025</small>
                  </div>
                </div>
                <form class="user-detail__note-form">
                  <textarea id="internalNote" class="user-detail__textarea" rows="3"
                    placeholder="Thêm ghi chú (khách không thấy)..."></textarea>
                  <button class="btn-submit user-detail__save-btn">
                    Lưu Ghi chú
                  </button>
                </form>
              </div>
            </div>

            <div class="user-detail__sidebar">
              <div class="user-detail__card text-center">
                <img src="https://via.placeholder.com/100x100" alt="Avatar" class="user-detail__avatar" />
                <h3 class="user-detail__name">Nguyễn Văn A</h3>
                <p class="user-detail__member-since">
                  Là khách hàng từ 10-01-2024
                </p>
              </div>

              <div class="user-detail__card">
                <legend class="user-detail__legend">Thống kê</legend>
                <ul class="user-detail__stats">
                  <li>
                    <span>Tổng chi tiêu</span>
                    <strong>15,200,000đ</strong>
                  </li>
                  <li>
                    <span>Tổng số đơn</span>
                    <strong>25</strong>
                  </li>
                </ul>
              </div>

              <div class="user-detail__card">
                <legend class="user-detail__legend">Thông tin Liên hệ</legend>
                <div class="user-detail__contact">
                  <p><strong>Email:</strong> nguyenvana@gmail.com</p>
                  <p><strong>Phone:</strong> 0905.123.456</p>
                  <hr />
                  <p>
                    <strong>Địa chỉ:</strong><br />
                    123 Đường ABC, Phường 1, Quận 2, TP. Hồ Chí Minh
                  </p>
                </div>
              </div>

              <div class="user-detail__card">
                <legend class="user-detail__legend">Hành động</legend>
                <ul class="user-detail__actions">
                  <li>
                    <a href="#" class="action-link">
                      <i class="bx bx-mail-send"></i> Gửi email Đặt lại Mật khẩu
                    </a>
                  </li>
                  <li>
                    <a href="#" class="action-link action-link--danger">
                      <i class="bx bx-lock"></i> Khóa Tài khoản
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>

    <script src="../assets/js/admin/main.js"></script>
  </body>

  </html>