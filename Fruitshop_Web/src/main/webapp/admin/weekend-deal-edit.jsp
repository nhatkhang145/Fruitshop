<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty deal ? 'Thêm' : 'Sửa'} Weekend Deal - Admin</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css">
    <style>
        .deal-form-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 20px;
        }
        .form-group {
            display: flex;
            flex-direction: column;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        .form-group label {
            font-weight: 600;
            margin-bottom: 8px;
            color: #2d3436;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .form-group label i {
            color: var(--primary-brand-color, #4CAF50);
        }
        .required {
            color: #e74c3c;
        }
        .form-control {
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--primary-brand-color, #4CAF50);
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.1);
        }
        .form-help {
            font-size: 12px;
            color: #7f8c8d;
            margin-top: 4px;
        }
        .preview-card {
            background: linear-gradient(135deg, #fff5f5 0%, #ffffff 100%);
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            margin-top: 30px;
        }
        .preview-card h3 {
            color: #2d3436;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .preview-content {
            display: flex;
            gap: 30px;
            align-items: center;
        }
        .preview-image {
            flex: 0 0 200px;
        }
        .preview-image img {
            width: 100%;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        .preview-info h4 {
            font-size: 24px;
            color: #2d3436;
            margin-bottom: 10px;
        }
        .preview-badge {
            display: inline-block;
            background: linear-gradient(135deg, #ff6b6b, #ee5a6f);
            color: white;
            padding: 6px 16px;
            border-radius: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .preview-price {
            font-size: 32px;
            color: #ff6b6b;
            font-weight: 800;
            margin-bottom: 10px;
        }
        .preview-original {
            text-decoration: line-through;
            color: #b2bec3;
            font-size: 18px;
        }
        .preview-timer {
            background: #fff3cd;
            padding: 12px;
            border-radius: 10px;
            margin-top: 15px;
            display: inline-block;
        }
        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 30px;
        }
        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        .toggle-slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 30px;
        }
        .toggle-slider:before {
            position: absolute;
            content: "";
            height: 22px;
            width: 22px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        .toggle-switch input:checked + .toggle-slider {
            background-color: #4CAF50;
        }
        .toggle-switch input:checked + .toggle-slider:before {
            transform: translateX(30px);
        }
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .btn-primary {
            background: var(--primary-brand-color, #4CAF50);
            color: white;
        }
        .btn-primary:hover {
            background: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background: #5a6268;
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp" />

    <section id="content">
        <jsp:include page="header.jsp" />

        <main>
            <div class="head-title">
                <div class="left">
                    <h1>${empty deal ? '➕ Thêm' : '✏️ Sửa'} Weekend Deal</h1>
                    <ul class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/admin/index.jsp">Dashboard</a></li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li><a href="${pageContext.request.contextPath}/admin/weekend-deals">Weekend Deals</a></li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li><a class="active" href="#">${empty deal ? 'Thêm mới' : 'Chỉnh sửa'}</a></li>
                    </ul>
                </div>
            </div>

            <div class="deal-form-container">
                <form action="${pageContext.request.contextPath}/admin/weekend-deal-edit" method="POST" id="dealForm">
                    <input type="hidden" name="dealId" value="${deal.id}">

                    <div class="form-grid">
                        <!-- Chọn sản phẩm -->
                        <div class="form-group full-width">
                            <label for="productId">
                                <i class='bx bx-package'></i>
                                Sản phẩm <span class="required">*</span>
                            </label>
                            <select name="productId" id="productId" class="form-control" required onchange="updatePreview()">
                                <option value="">-- Chọn sản phẩm --</option>
                                <c:forEach items="${products}" var="product">
                                    <option value="${product.id}" 
                                            data-name="${product.name}"
                                            data-price="${product.price}"
                                            data-image="${product.image}"
                                            ${deal.productId == product.id ? 'selected' : ''}>
                                        ${product.name} - <fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" />đ
                                    </option>
                                </c:forEach>
                            </select>
                            <small class="form-help">Chọn sản phẩm muốn áp dụng deal</small>
                        </div>

                        <!-- Tiêu đề -->
                        <div class="form-group">
                            <label for="title">
                                <i class='bx bx-text'></i>
                                Tiêu đề <span class="required">*</span>
                            </label>
                            <input type="text" name="title" id="title" class="form-control" 
                                   value="${deal.title}" placeholder="VD: Ưu đãi cuối tuần" 
                                   required maxlength="255" oninput="updatePreview()">
                        </div>

                        <!-- Phụ đề -->
                        <div class="form-group">
                            <label for="subtitle">
                                <i class='bx bx-detail'></i>
                                Phụ đề
                            </label>
                            <input type="text" name="subtitle" id="subtitle" class="form-control" 
                                   value="${deal.subtitle}" placeholder="VD: Giảm giá đặc biệt" 
                                   maxlength="255" oninput="updatePreview()">
                        </div>

                        <!-- Phần trăm giảm giá -->
                        <div class="form-group">
                            <label for="discountPercent">
                                <i class='bx bx-purchase-tag'></i>
                                Giảm giá (%) <span class="required">*</span>
                            </label>
                            <input type="number" name="discountPercent" id="discountPercent" class="form-control" 
                                   value="${deal.discountPercent}" placeholder="0" 
                                   required min="1" max="99" oninput="updatePreview()">
                            <small class="form-help">Từ 1% đến 99%</small>
                        </div>

                        <!-- Thứ tự hiển thị -->
                        <div class="form-group">
                            <label for="sortOrder">
                                <i class='bx bx-sort'></i>
                                Thứ tự hiển thị
                            </label>
                            <input type="number" name="sortOrder" id="sortOrder" class="form-control" 
                                   value="${empty deal.sortOrder ? 0 : deal.sortOrder}" 
                                   min="0" placeholder="0">
                            <small class="form-help">Số càng nhỏ ưu tiên càng cao</small>
                        </div>

                        <!-- Ngày bắt đầu -->
                        <div class="form-group">
                            <label for="startDate">
                                <i class='bx bx-calendar-check'></i>
                                Ngày bắt đầu <span class="required">*</span>
                            </label>
                            <input type="datetime-local" name="startDate" id="startDate" class="form-control" 
                                   value="${not empty deal.startDate ? deal.startDate.toInstant().toString().substring(0, 16) : ''}" 
                                   required oninput="updatePreview()">
                        </div>

                        <!-- Ngày kết thúc -->
                        <div class="form-group">
                            <label for="endDate">
                                <i class='bx bx-calendar-x'></i>
                                Ngày kết thúc <span class="required">*</span>
                            </label>
                            <input type="datetime-local" name="endDate" id="endDate" class="form-control" 
                                   value="${not empty deal.endDate ? deal.endDate.toInstant().toString().substring(0, 16) : ''}" 
                                   required oninput="updatePreview()">
                        </div>

                        <!-- Trạng thái -->
                        <div class="form-group">
                            <label>
                                <i class='bx bx-toggle-left'></i>
                                Trạng thái
                            </label>
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <label class="toggle-switch">
                                    <input type="checkbox" name="status" value="1" 
                                           ${empty deal || deal.status == 1 ? 'checked' : ''}>
                                    <span class="toggle-slider"></span>
                                </label>
                                <span id="statusText">${empty deal || deal.status == 1 ? 'Bật' : 'Tắt'}</span>
                            </div>
                            <small class="form-help">Tắt để ẩn deal khỏi trang chủ</small>
                        </div>
                    </div>

                    <!-- Preview Card -->
                    <div class="preview-card" id="previewCard" style="display: none;">
                        <h3><i class='bx bx-show'></i> Xem trước Deal</h3>
                        <div class="preview-content">
                            <div class="preview-image">
                                <img id="previewImg" src="" alt="Product">
                            </div>
                            <div class="preview-info">
                                <span class="preview-badge" id="previewDiscount">-0%</span>
                                <h4 id="previewTitle">Tiêu đề deal</h4>
                                <p id="previewSubtitle">Phụ đề</p>
                                <div>
                                    <span class="preview-price" id="previewSalePrice">0đ</span>
                                    <span class="preview-original" id="previewOriginalPrice">0đ</span>
                                </div>
                                <div class="preview-timer">
                                    <i class='bx bx-time-five'></i>
                                    <span id="previewTime">Thời gian: - đến -</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="btn-group">
                        <button type="submit" class="btn btn-primary">
                            <i class='bx bx-save'></i>
                            ${empty deal ? 'Thêm Deal' : 'Cập nhật'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/weekend-deals" class="btn btn-secondary">
                            <i class='bx bx-x'></i>
                            Hủy
                        </a>
                    </div>
                </form>
            </div>
        </main>
    </section>

    <script src="${pageContext.request.contextPath}/assets/js/admin/script.js"></script>
    <script>
        // Toggle status text
        document.querySelector('input[name="status"]').addEventListener('change', function() {
            document.getElementById('statusText').textContent = this.checked ? 'Bật' : 'Tắt';
        });

        // Update preview
        function updatePreview() {
            const productSelect = document.getElementById('productId');
            const selectedOption = productSelect.options[productSelect.selectedIndex];
            
            if (!selectedOption.value) {
                document.getElementById('previewCard').style.display = 'none';
                return;
            }

            const productName = selectedOption.dataset.name;
            const productPrice = parseFloat(selectedOption.dataset.price);
            const productImage = selectedOption.dataset.image;
            const discount = parseInt(document.getElementById('discountPercent').value) || 0;
            const title = document.getElementById('title').value || 'Tiêu đề deal';
            const subtitle = document.getElementById('subtitle').value || 'Phụ đề';
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;

            const salePrice = productPrice * (1 - discount / 100);

            document.getElementById('previewCard').style.display = 'block';
            document.getElementById('previewImg').src = '${pageContext.request.contextPath}/' + productImage;
            document.getElementById('previewTitle').textContent = productName;
            document.getElementById('previewSubtitle').textContent = subtitle;
            document.getElementById('previewDiscount').textContent = '-' + discount + '%';
            document.getElementById('previewSalePrice').textContent = 
                Math.round(salePrice).toLocaleString('vi-VN') + 'đ';
            document.getElementById('previewOriginalPrice').textContent = 
                Math.round(productPrice).toLocaleString('vi-VN') + 'đ';
            
            if (startDate && endDate) {
                const start = new Date(startDate).toLocaleString('vi-VN');
                const end = new Date(endDate).toLocaleString('vi-VN');
                document.getElementById('previewTime').textContent = `${start} → ${end}`;
            }
        }

        // Validate form
        document.getElementById('dealForm').addEventListener('submit', function(e) {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);

            if (endDate <= startDate) {
                e.preventDefault();
                alert('❌ Ngày kết thúc phải sau ngày bắt đầu!');
                return false;
            }

            const discount = parseInt(document.getElementById('discountPercent').value);
            if (discount < 1 || discount > 99) {
                e.preventDefault();
                alert('❌ Giảm giá phải từ 1% đến 99%!');
                return false;
            }
        });

        // Initialize preview if editing
        <c:if test="${not empty deal}">
            updatePreview();
        </c:if>
    </script>
</body>
</html>
