<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Quản lý Sản phẩm</title>

  <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
  
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/products.css" />

  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
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
        <a href="${pageContext.request.contextPath}/admin/product-edit.jsp" class="report">
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
            </div>
          
          <table id="productTable">
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
                <td>Táo Envy New Zealand</td>
                <td>T-ENVY-01</td>
                <td>250,000đ</td>
                <td>120</td>
                <td><span class="status active">Hoạt động</span></td>
                <td>
                  <a href="#" class="action-btn edit"><i class="bx bx-edit"></i></a>
                  <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                </td>
              </tr>
              <tr>
                <td>
                  <img src="https://via.placeholder.com/40x40" alt="Cam Mỹ" />
                </td>
                <td>Cam Vàng Mỹ</td>
                <td>C-USA-02</td>
                <td>180,000đ</td>
                <td>0</td>
                <td><span class="status hidden">Ẩn</span></td>
                <td>
                  <a href="#" class="action-btn edit"><i class="bx bx-edit"></i></a>
                  <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                </td>
              </tr>
              </tbody>
          </table>
        </div>
      </div>
    </main>
  </div>

  <script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>
  
  <script src="${pageContext.request.contextPath}/assets/js/admin/datatables-config.js"></script>
  <script>
    $(document).ready(function() {
        $('#productTable').DataTable(dataTableConfig);
    });
  </script>
</body>
</html>