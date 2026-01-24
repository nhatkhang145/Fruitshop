<jsp:useBean id="product" scope="request" type="model.Product" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <!DOCTYPE html>
      <html lang="vi">

      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>${product.id > 0 ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm mới'}</title>

        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/product-edit.css" />

        <style>
          /* CSS bổ sung để fix một số lỗi hiển thị khi nhúng JSP */
          .product-edit__image-uploader img {
            max-width: 100%;
            max-height: 200px;
            object-fit: contain;
            margin-bottom: 10px;
            display: block;
          }
        </style>
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
                <h1 id="pageTitle">${product.id > 0 ? 'Cập nhật sản phẩm' : 'Thêm sản phẩm mới'}</h1>
                <ul class="breadcrumb">
                  <li><a href="products">Sản phẩm</a></li>
                  <li>/</li>
                  <li>
                    <a href="#" class="active" id="breadcrumbTitle">${product.id > 0 ? 'Sửa' : 'Thêm mới'}</a>
                  </li>
                </ul>
              </div>
            </div>

            <div class="bottom-data">
              <div class="product-edit">
                <form id="productForm" action="${pageContext.request.contextPath}/admin/product-save" method="post" enctype="multipart/form-data">
                  
                  <input type="hidden" name="id" value="${product.id > 0 ? product.id : 0}">
                  <input type="hidden" name="currentImage" value="${product.image}">

                  <!-- Left Column: Form Inputs -->
                  <div class="product-edit__form-left">
                    
                    <!-- Tên sản phẩm -->
                    <div class="form-input">
                      <label class="form-label" for="productName">Tên sản phẩm</label>
                      <input type="text" id="productName" name="name" class="form-control"
                        value="${product.name}" placeholder="Ví dụ: Táo Fuji Nhật Bản" required autocomplete="off" />
                    </div>

                    <!-- Danh mục -->
                    <div class="form-input">
                      <label class="form-label" for="category">Danh mục</label>
                      <select id="category" name="categoryId" class="form-control">
                        <option value="">-- Chọn Danh mục --</option>
                        <c:forEach items="${categories}" var="c">
                          <option value="${c.id}" ${product.categoryId==c.id ? 'selected' : '' }>
                            ${c.name}
                          </option>
                        </c:forEach>
                      </select>
                    </div>

                    <!-- Giá bán & Giá khuyến mãi -->
                    <div class="form-input-row">
                      <div class="form-input">
                        <label class="form-label" for="regularPrice">Giá bán (VNĐ)</label>
                        <input type="number" id="regularPrice" name="price" class="form-control"
                          value="<fmt:formatNumber value='${product.price}' pattern='#'/>" 
                          placeholder="Ví dụ: 125000" required autocomplete="off" />
                      </div>
                      <div class="form-input">
                        <label class="form-label" for="salePrice">Giá khuyến mãi (VNĐ)</label>
                        <input type="number" id="salePrice" name="salePrice" class="form-control"
                          value="<fmt:formatNumber value='${product.salePrice}' pattern='#'/>" 
                          placeholder="Ví dụ: 100000" autocomplete="off" />
                      </div>
                    </div>

                    <!-- Mã sản phẩm (SKU) & Số lượng -->
                    <div class="form-input-row">
                      <div class="form-input">
                        <label class="form-label" for="productCode">Mã sản phẩm</label>
                        <input type="text" id="productCode" name="productCode" class="form-control" 
                          value="${product.productCode}" 
                          placeholder="Ví dụ: TAOFU01" autocomplete="off" />
                      </div>
                      <div class="form-input">
                        <label class="form-label" for="productStock">Số lượng tồn kho</label>
                        <input type="number" id="productStock" name="quantity" class="form-control"
                          value="${product.quantity}" placeholder="Ví dụ: 20" required autocomplete="off" />
                      </div>
                    </div>

                    <!-- Trạng thái hiển thị -->
                    <div class="form-input">
                      <label class="form-label">Trạng thái sản phẩm</label>
                      <div class="status-toggle-wrapper">
                        <label class="status-toggle">
                          <input type="checkbox" name="status" value="1" id="statusCheckbox"
                                 ${product.status == 1 ? 'checked' : ''} />
                          <span class="status-slider"></span>
                        </label>
                        <span class="status-text" id="statusText">
                          ${product.status == 1 ? 'Hiển thị' : 'Ẩn'}
                        </span>
                      </div>
                    </div>

                    <!-- Mô tả sản phẩm -->
                    <div class="form-input form-input-full">
                      <label class="form-label" for="productDesc">Mô tả sản phẩm</label>
                      <textarea id="productDesc" name="description" class="form-textarea" 
                        rows="6" autocomplete="off">${product.description}</textarea>
                    </div>

                  </div>

                  <!-- Right Column: Images -->
                  <div class="product-edit__form-right">
                    <p class="section-title">Thêm ảnh cho sản phẩm</p>
                    
                    <!-- Main Image -->
                    <div class="image-group">
                      <p class="image-group-title">1. Chọn ảnh chính cho sản phẩm (Tối đa 1)</p>
                      <div class="main-image-wrapper">
                        <c:choose>
                          <c:when test="${not empty product.image}">
                            <img src="${pageContext.request.contextPath}/${product.image}" 
                                 alt="Ảnh sản phẩm" id="mainImagePreview" class="main-image" />
                          </c:when>
                          <c:otherwise>
                            <img src="https://via.placeholder.com/200x200?text=Ch%C6%B0a+c%C3%B3+%E1%BA%A3nh" 
                                 alt="Chưa có ảnh" id="mainImagePreview" class="main-image" />
                          </c:otherwise>
                        </c:choose>
                        <input type="file" name="image" id="mainImage" accept="image/*" 
                               style="display: none;" onchange="previewImage(this);" />
                        <label for="mainImage" class="upload-label">
                          <i class='bx bx-upload'></i> Tải ảnh lên
                        </label>
                      </div>
                    </div>

                    <!-- Secondary Images -->
                    <div class="image-group">
                      <p class="image-group-title">2. Chọn ảnh phụ cho sản phẩm (Tối đa 4)</p>
                      <div class="secondary-images-wrapper">
                        <div class="secondary-image-item">
                          <img src="https://via.placeholder.com/80x80" alt="Ảnh phụ 1" />
                        </div>
                        <div class="secondary-image-item">
                          <img src="https://via.placeholder.com/80x80" alt="Ảnh phụ 2" />
                        </div>
                        <div class="secondary-image-item">
                          <img src="https://via.placeholder.com/80x80" alt="Ảnh phụ 3" />
                        </div>
                        <div class="add-image-btn">
                          <i class='bx bx-plus'></i>
                        </div>
                      </div>
                    </div>

                  </div>

                </form>

                <!-- Bottom Actions -->
                <div class="product-edit__bottom">
                  <p class="bottom-notice">Đảm bảo rằng sản phẩm của bạn là hợp pháp và không gây hậu quả nào</p>
                  <div class="bottom-buttons">
                    <a href="products" class="btn-cancel">
                      <i class='bx bx-x'></i> Hủy
                    </a>
                    <button type="submit" form="productForm" class="btn-save">
                      <i class='bx bx-check'></i> ${product.id > 0 ? 'Cập nhật' : 'Đưa vào danh sách'}
                    </button>
                  </div>
                </div>

              </div>
            </div>
          </main>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>

        <script>
          // 1. Script xem trước ảnh khi chọn file
          function previewImage(input) {
            if (input.files && input.files[0]) {
              var reader = new FileReader();
              reader.onload = function (e) {
                document.getElementById('mainImagePreview').src = e.target.result;
              }
              reader.readAsDataURL(input.files[0]);
            }
          }

          // 2. Script toggle status text
          const statusCheckbox = document.querySelector('input[type="checkbox"][name="status"]');
          const statusText = document.querySelector('.status-text');
          
          if (statusCheckbox && statusText) {
            statusCheckbox.addEventListener('change', function() {
              statusText.textContent = this.checked ? 'Hiển thị' : 'Ẩn';
            });
          }
        </script>
      </body>

      </html>