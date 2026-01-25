<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
      <jsp:useBean id="product" scope="request" class="model.Product" />

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
                  <li><i class='bx bx-chevron-right'></i></li>
                  <li>
                    <a href="#" class="active">${product.id > 0 ? 'Chỉnh sửa' : 'Tạo mới'}</a>
                  </li>
                </ul>
              </div>
            </div>

            <div class="bottom-data">
              <div class="product-edit">
                <form id="productForm" action="${pageContext.request.contextPath}/admin/product-save" method="post"
                  enctype="multipart/form-data">

                  <input type="hidden" name="id" value="${product.id > 0 ? product.id : 0}">
                  <input type="hidden" name="currentImage" value="${product.image}">

                  <div class="product-edit__form-left">

                    <div class="form-input">
                      <label class="form-label" for="productName">Tên sản phẩm <span style="color: red">*</span></label>
                      <input type="text" id="productName" name="name" class="form-control" value="${product.name}"
                        placeholder="Nhập tên sản phẩm..." required autocomplete="off" />
                    </div>

                    <div class="form-input">
                      <label class="form-label" for="category">Danh mục <span style="color: red">*</span></label>
                      <select id="category" name="categoryId" class="form-select" required>
                        <option value="">-- Chọn danh mục --</option>
                        <c:forEach items="${categories}" var="c">
                          <option value="${c.id}" ${product.categoryId==c.id ? 'selected' : '' }>
                            ${c.name}
                          </option>
                        </c:forEach>
                      </select>
                    </div>

                    <div class="form-input-row">
                      <div class="form-input">
                        <label class="form-label" for="regularPrice">Giá bán (VNĐ) <span
                            style="color: red">*</span></label>
                        <input type="number" id="regularPrice" name="price" class="form-control"
                          value="<fmt:formatNumber value='${product.price}' pattern='#'/>" placeholder="0" required />
                      </div>
                      <div class="form-input">
                        <label class="form-label" for="salePrice">Giá khuyến mãi (VNĐ)</label>
                        <input type="number" id="salePrice" name="salePrice" class="form-control"
                          value="<fmt:formatNumber value='${product.salePrice}' pattern='#'/>" placeholder="0" />
                      </div>
                    </div>

                    <div class="form-input-row">
                      <div class="form-input">
                        <label class="form-label" for="productCode">Mã SKU</label>
                        <input type="text" id="productCode" name="productCode" class="form-control"
                          value="${product.productCode}" placeholder="VD: SP001" />
                      </div>
                      <div class="form-input">
                        <label class="form-label" for="productStock">Số lượng kho <span
                            style="color: red">*</span></label>
                        <input type="number" id="productStock" name="quantity" class="form-control"
                          value="${product.quantity}" placeholder="0" required />
                      </div>
                    </div>

                    <div class="form-input">
                      <label class="form-label">Trạng thái hiển thị</label>
                      <div class="status-toggle-wrapper">
                        <span class="status-label-text">Cho phép hiển thị trên web</span>
                        <label class="status-toggle">
                          <input type="checkbox" name="status" value="1" id="statusCheckbox" ${product.status==1
                            ? 'checked' : '' } />
                          <span class="status-slider"></span>
                        </label>
                      </div>
                      <div style="margin-top: 5px; font-size: 13px; text-align: right;">
                        Trạng thái hiện tại: <span id="statusText"
                          style="font-weight: bold; color: ${product.status == 1 ? 'var(--success)' : 'var(--dark-grey)'}">
                          ${product.status == 1 ? 'Đang hiển thị' : 'Đang ẩn'}
                        </span>
                      </div>
                    </div>

                    <div class="form-input">
                      <label class="form-label" for="productDesc">Mô tả chi tiết</label>
                      <textarea id="productDesc" name="description" class="form-textarea"
                        placeholder="Nhập mô tả sản phẩm tại đây...">${product.description}</textarea>
                    </div>

                  </div>

                  <div class="product-edit__form-right">
                    <p class="section-title">Quản lý hình ảnh</p>

                    <div class="image-group">
                      <p class="image-group-title">Ảnh đại diện (Click để thay đổi)</p>

                      <input type="file" name="image" id="mainImageInput" accept="image/*" style="display: none;"
                        onchange="previewMainImage(this);" />

                      <div class="upload-area" onclick="document.getElementById('mainImageInput').click();">
                        <c:choose>
                          <c:when test="${not empty product.image}">
                            <img src="${pageContext.request.contextPath}/${product.image}" id="mainImagePreview"
                              alt="Main Image" />
                            <div class="upload-placeholder" id="placeholderIcon" style="display: none;">
                              <i class='bx bx-cloud-upload'></i>
                              <span>Nhấn để tải ảnh lên</span>
                            </div>
                          </c:when>
                          <c:otherwise>
                            <div class="upload-placeholder" id="placeholderIcon">
                              <i class='bx bx-cloud-upload'></i>
                              <span>Nhấn để tải ảnh lên</span>
                            </div>
                            <img src="" id="mainImagePreview" style="display: none;" alt="Preview" />
                          </c:otherwise>
                        </c:choose>
                      </div>
                    </div>

                    <div class="image-group">
                      <p class="image-group-title">Ảnh chi tiết (Chọn nhiều ảnh)</p>

                      <input type="file" name="subImages" id="subImagesInput" multiple accept="image/*"
                        style="display: none;" onchange="previewSubImages(this);" />

                      <label for="subImagesInput" class="btn-upload-sub">
                        <i class='bx bx-images'></i> Thêm ảnh chi tiết
                      </label>

                      <div class="secondary-images-container" id="subImagesContainer">
                        <c:if test="${not empty product.productImages}">
                          <c:forEach items="${product.productImages}" var="img">
                            <div class="sub-image-item">
                              <img src="${pageContext.request.contextPath}/${img.imageUrl}" alt="Ảnh chi tiết" />
                            </div>
                          </c:forEach>
                        </c:if>
                      </div>
                    </div>
                  </div>

                </form>
                <div class="product-edit__bottom">
                  <a href="products" class="btn-cancel">
                    <i class='bx bx-arrow-back'></i> Quay lại
                  </a>
                  <button type="submit" form="productForm" class="btn-save">
                    <i class='bx bx-save'></i> ${product.id > 0 ? 'Lưu thay đổi' : 'Thêm sản phẩm'}
                  </button>
                </div>

              </div>
            </div>
          </main>
        </div>

        <script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>

        <script>
          // === 1. XỬ LÝ PREVIEW ẢNH CHÍNH ===
          function previewMainImage(input) {
            const preview = document.getElementById('mainImagePreview');
            const placeholder = document.getElementById('placeholderIcon');

            if (input.files && input.files[0]) {
              var reader = new FileReader();
              reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'block';
                if (placeholder) placeholder.style.display = 'none';
              }
              reader.readAsDataURL(input.files[0]);
            }
          }

          const subImagesContainer = document.getElementById('subImagesContainer');
          const initialSubImagesHTML = subImagesContainer ? subImagesContainer.innerHTML : '';
          let selectedSubImages = [];

          // === 2. XỬ LÝ PREVIEW NHIỀU ẢNH PHỤ (CỘNG DỒN NHIỀU LẦN CHỌN) ===
          function previewSubImages(input) {
            if (!input) return;
            const container = document.getElementById('subImagesContainer');
            if (!container) return;

            const newFiles = Array.from(input.files || []);
            if (newFiles.length === 0) return;

            // Cộng dồn các file đã chọn trước đó
            selectedSubImages = selectedSubImages.concat(newFiles);

            // Gán lại FileList cho input bằng DataTransfer để giữ tất cả file đã chọn
            const dt = new DataTransfer();
            selectedSubImages.forEach(file => dt.items.add(file));
            input.files = dt.files;

            // Render lại: giữ ảnh cũ từ server, thêm preview cho toàn bộ file mới
            container.innerHTML = initialSubImagesHTML;

            selectedSubImages.forEach(file => {
              const reader = new FileReader();
              reader.onload = function (event) {
                const div = document.createElement('div');
                div.className = 'sub-image-item';
                div.dataset.new = 'true';

                const img = document.createElement('img');
                img.src = event.target.result;

                div.appendChild(img);
                container.appendChild(div);
              }
              reader.readAsDataURL(file);
            });
          }

          // === 3. XỬ LÝ TEXT TRẠNG THÁI ===
          const statusCheckbox = document.getElementById('statusCheckbox');
          const statusText = document.getElementById('statusText');

          if (statusCheckbox && statusText) {
            statusCheckbox.addEventListener('change', function () {
              if (this.checked) {
                statusText.innerText = 'Đang hiển thị';
                statusText.style.color = 'var(--success)';
              } else {
                statusText.innerText = 'Đang ẩn';
                statusText.style.color = 'var(--dark-grey)';
              }
            });
          }
        </script>

      </body>

      </html>