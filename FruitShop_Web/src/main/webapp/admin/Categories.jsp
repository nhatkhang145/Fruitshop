<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/Categories.css" />
    <title>Quản lý danh mục</title>
  </head>

  <body>

    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="categories" />
    </jsp:include>

    <!-- Main Content -->
    <div class="content">

      <jsp:include page="header.jsp" />

      <!-- End of Navbar -->
      <main>
        <div class="header">
          <div class="left">
            <h1>Quản lý danh mục</h1>
            <ul class="breadcrumb">
              <li><a href="#">Quản lý</a></li>
              <li>/</li>
              <li><a href="#" class="active">Danh mục</a></li>
            </ul>
          </div>
        </div>

        <div class="bottom-data">
          <div class="add-category-form">
            <div class="header">
              <h3>Thêm danh mục mới</h3>
            </div>
            <form id="categoryForm">
              <div class="form-group">
                <label for="categoryName">Tên danh mục</label>
                <input type="text" id="categoryName" placeholder="Ví dụ: Táo New Zealand" required />
              </div>

              <!-- Slug field removed: slugs are auto-generated from the name -->

              <div class="form-group">
                <label for="categoryParent">Danh mục cha</label>
                <select id="categoryParent">
                  <option value="0">— Không có —</option>
                  <option value="1">Trái cây</option>
                  <option value="2">&nbsp;&nbsp;— Trái cây nhập khẩu</option>
                  <option value="5">&nbsp;&nbsp;— Trái cây Việt Nam</option>
                  <option value="6">Rau củ</option>
                </select>
              </div>

              <div class="form-group">
                <label for="categoryDesc">Mô tả</label>
                <textarea id="categoryDesc" rows="4" placeholder="Mô tả ngắn về danh mục..."></textarea>
              </div>

              <div class="form-group">
                <label for="categoryImage">Hình ảnh</label>
                <input type="file" id="categoryImage" accept="image/*" />
              </div>

              <button type="submit" class="btn-submit">Thêm danh mục</button>
            </form>
          </div>

          <div class="orders category-list">
            <div class="header">
              <h3>Danh sách danh mục</h3>
              <i class="bx bx-search"></i>
            </div>
            <table>
              <thead>
                <tr>
                  <th>Tên</th>
                  <th>Mô tả</th>
                  <th>Số lượng</th>
                  <th>Hành động</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><strong>Trái cây</strong></td>
                  <td>trai-cay</td>
                  <td>15</td>
                  <td>
                    <a href="#" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td>
                    <span class="indent-1">— Trái cây nhập khẩu</span>
                  </td>
                  <td>trai-cay-nhap-khau</td>
                  <td>10</td>
                  <td>
                    <a href="#" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td><span class="indent-2">— — Táo</span></td>
                  <td>tao</td>
                  <td>7</td>
                  <td>
                    <a href="#" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td><span class="indent-1">— Trái cây Việt Nam</span></td>
                  <td>trai-cay-viet-nam</td>
                  <td>5</td>
                  <td>
                    <a href="#" class="action-btn edit"><i class="bx bx-edit"></i></a>
                    <a href="#" class="action-btn delete"><i class="bx bx-trash"></i></a>
                  </td>
                </tr>
                <tr>
                  <td><strong>Rau củ</strong></td>
                  <td>rau-cu</td>
                  <td>12</td>
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

    <script src="../assets/js/admin/main.js"></script>
  </body>

  </html>