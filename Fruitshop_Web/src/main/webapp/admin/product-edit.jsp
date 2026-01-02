<jsp:useBean id="product" scope="request" type="com.sun.org.apache.xml.internal.security.signature.Manifest"/>
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
      <a href="#" class="report" id="saveProductBtnHeader">
        <i class="bx bx-save"></i>
        <span>Lưu sản phẩm</span>
      </a>
    </div>

    <div class="bottom-data">
      <div class="product-edit">
        <form id="productForm" action="product-save" method="post" enctype="multipart/form-data" class="product-edit__form">

          <input type="hidden" name="id" value="${product.id > 0 ? product.id : 0}">
          <input type="hidden" name="currentImage" value="${product.image}">

          <div class="product-edit__main">
            <div class="product-edit__card">
              <div class="product-edit__group">
                <label for="productName" class="product-edit__label">Tên sản phẩm</label>
                <input type="text" id="productName" name="name" class="product-edit__input"
                       value="${product.name}" placeholder="Ví dụ: Táo Envy New Zealand" required />
              </div>
            </div>

            <div class="product-edit__card">
              <div class="product-edit__group">
                <label for="productDesc" class="product-edit__label">Mô tả chi tiết</label>
                <textarea id="productDesc" name="description" class="product-edit__textarea" rows="10">${product.description}</textarea>
              </div>
            </div>

            <div class="product-edit__card">
              <legend class="product-edit__legend">Giá bán</legend>
              <div class="product-edit__price-row">
                <div class="product-edit__group">
                  <label for="regularPrice" class="product-edit__label">Giá gốc (VNĐ)</label>
                  <input type="number" id="regularPrice" name="price" class="product-edit__input"
                         value="<fmt:formatNumber value='${product.price}' pattern='#'/>" placeholder="0" required />
                </div>
                <div class="product-edit__group">
                  <label for="salePrice" class="product-edit__label">Giá khuyến mãi (VNĐ)</label>
                  <input type="number" id="salePrice" name="salePrice" class="product-edit__input"
                         value="<fmt:formatNumber value='${product.salePrice}' pattern='#'/>" placeholder="0" />
                </div>
              </div>
            </div>

            <div class="product-edit__card">
              <legend class="product-edit__legend">Kho hàng</legend>
              <div class="product-edit__price-row">
                <div class="product-edit__group">
                  <label for="productSKU" class="product-edit__label">Mã sản phẩm (ID)</label>
                  <input type="text" id="productSKU" class="product-edit__input"
                         value="${product.id > 0 ? product.id : 'Tự động tạo'}" readonly style="background-color: #f0f0f0;" />
                </div>
                <div class="product-edit__group">
                  <label for="productStock" class="product-edit__label">Số lượng tồn kho</label>
                  <input type="number" id="productStock" name="quantity" class="product-edit__input"
                         value="${product.quantity}" placeholder="0" required />
                </div>
              </div>
            </div>
          </div>

          <div class="product-edit__sidebar">
            <div class="product-edit__card">
              <legend class="product-edit__legend">Hành động</legend>
              <div class="product-edit__group">
                <button type="submit" class="btn-submit product-edit__save-btn" style="width: 100%; margin-top: 10px;">
                  <i class='bx bx-save'></i> Lưu thay đổi
                </button>
                <a href="products" style="display: block; text-align: center; margin-top: 10px; color: #666;">Hủy bỏ</a>
              </div>
            </div>

            <div class="product-edit__card">
              <legend class="product-edit__legend">Danh mục</legend>
              <div class="product-edit__group">
                <select name="categoryId" class="product-edit__input" style="padding: 10px;">
                  <c:forEach items="${categories}" var="c">
                    <option value="${c.id}" ${product.categoryId == c.id ? 'selected' : ''}>
                        ${c.name}
                    </option>
                  </c:forEach>
                </select>
              </div>
            </div>

            <div class="product-edit__card">
              <legend class="product-edit__legend">Ảnh đại diện</legend>
              <div class="product-edit__image-uploader">
                <c:choose>
                  <c:when test="${not empty product.image}">
                    <img src="${pageContext.request.contextPath}/${product.image}" alt="Ảnh sản phẩm" id="mainImagePreview" />
                  </c:when>
                  <c:otherwise>
                    <img src="https://via.placeholder.com/150" alt="Chưa có ảnh" id="mainImagePreview" />
                  </c:otherwise>
                </c:choose>

                <input type="file" name="image" id="mainImage" accept="image/*" style="display: none;" onchange="previewImage(this);" />

                <label for="mainImage" id="setMainImageLink" style="cursor: pointer; color: blue; display: block; text-align: center; margin-top: 10px;">
                  <i class='bx bx-upload'></i> Tải ảnh lên
                </label>
              </div>
            </div>

          </div>
        </form>
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
      reader.onload = function(e) {
        document.getElementById('mainImagePreview').src = e.target.result;
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  // 2. Script để nút Lưu ở Header hoạt động như nút Submit form
  document.getElementById('saveProductBtnHeader').addEventListener('click', function(e) {
    e.preventDefault(); // Ngăn chặn hành vi mặc định của thẻ a
    document.getElementById('productForm').submit(); // Submit form
  });
</script>
</body>

</html>