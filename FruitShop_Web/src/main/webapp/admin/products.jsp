<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

  <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/products.css" />
    <title>Quản lý Sản phẩm</title>
  </head>

  <body>

    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="products" />
    </jsp:include>

    <div class="content">

      <jsp:include page="header.jsp" />
      <main>
        <div class="header">
          <div class="left">
            <h1>Quản lý sản phẩm</h1>
            <ul class="breadcrumb">
              <li><a href="#">Quản lý</a></li>
              <li>/</li>
              <li><a href="#" class="active">Sản phẩm</a></li>
            </ul>
          </div>
          <a href="/admin/product-edit.jsp" class="report">
            <i class="bx bx-plus"></i>
            <span>Thêm sản phẩm</span>
          </a>
        </div>

        <ul class="insights">
          <li>
            <i class="bx bx-box"></i>
            <span class="info">
              <h3>1,204</h3>
              <p>Tổng sản phẩm</p>
            </span>
          </li>
          <li>
            <i class="bx bx-show"></i>
            <span class="info">
              <h3>1,150</h3>
              <p>Đang hoạt động</p>
            </span>
          </li>
          <li>
            <i class="bx bx-hide"></i>
            <span class="info">
              <h3>54</h3>
              <p>Sản phẩm ẩn</p>
            </span>
          </li>
          <li>
            <i class="bx bxs-error-circle"></i>
            <span class="info">
              <h3>28</h3>
              <p>Sắp hết hàng</p>
            </span>
          </li>
        </ul>

        <div class="bottom-data">
          <div class="orders">
            <div class="header">
              <h3>Danh sách sản phẩm</h3>
              <div class="filters">
                <i class="bx bx-filter"></i>
                <select id="categoryFilter">
                  <option value="">Tất cả danh mục</option>
                  <option value="fruit-vn">Trái cây Việt Nam</option>
                  <option value="fruit-import">Trái cây nhập khẩu</option>
                  <option value="vegetable">Rau củ</option>
                </select>
                <select id="statusFilter">
                  <option value="">Tất cả trạng thái</option>
                  <option value="active">Đang hoạt động</option>
                  <option value="hidden">Ẩn</option>
                </select>
              </div>
            </div>
            <table>
              <thead>
                <tr>
                  <th>Ảnh</th>
                  <th>Tên sản phẩm</th>
                  <th>SKU</th>
                  <th>Giá</th>
                  <th>Tồn kho</th>
                  <th>Trạng thái</th>
                  <th>Hành động</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/40x40" alt="Táo Envy" />
                  </td>
                  <td>Táo Envy New Zealand (Size L)</td>
                  <td>T-ENVY-NZ-01</td>
                  <td>250,000đ</td>
                  <td>120</td>
                  <td><span class="status active">Hoạt động</span></td>
                  <td>
                    <a href="/admin/product-edit.jsp?id=1" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/40x40" alt="Nho Úc" />
                  </td>
                  <td>Nho không hạt Úc</td>
                  <td>N-KH-AUC-05</td>
                  <td>320,000đ</td>
                  <td>80</td>
                  <td><span class="status active">Hoạt động</span></td>
                  <td>
                    <a href="/admin/product-edit.jsp?id=2" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/40x40" alt="Dâu Hàn" />
                  </td>
                  <td>Dâu tây Hàn Quốc (Hộp 500g)</td>
                  <td>D-HQ-02</td>
                  <td>450,000đ</td>
                  <td>15</td>
                  <td><span class="status low-stock">Sắp hết</span></td>
                  <td>
                    <a href="/admin/product-edit.jsp?id=3" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td>
                    <img src="https://via.placeholder.com/40x40" alt="Cam Mỹ" />
                  </td>
                  <td>Cam Vàng Mỹ (Ngừng bán)</td>
                  <td>C-VANG-MY-99</td>
                  <td>180,000đ</td>
                  <td>0</td>
                  <td><span class="status hidden">Ẩn</span></td>
                  <td>
                    <a href="/admin/product-edit.jsp?id=4" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
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
    <script src="${pageContext.request.contextPath}/assets/js/admin/datatables-config.js"></script>
    <script>
      $(document).ready(function () {
        // Dùng lại config chung, chỉ cần trỏ đúng ID của bảng
        $('#productTable').DataTable(dataTableConfig);
      });
    </script>

  </body>

  </html>