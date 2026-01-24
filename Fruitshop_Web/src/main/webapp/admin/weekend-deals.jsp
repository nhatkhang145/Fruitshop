<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Weekend Deals - Admin</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css">
    <style>
        /* Weekend Deals Styles */
        .btn-add {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: var(--primary-brand-color, #4CAF50);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-add:hover {
            background: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 175, 80, 0.3);
        }
        .alert {
            padding: 15px 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideDown 0.3s ease;
        }
        .alert i { font-size: 24px; }
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .filter-select {
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: white;
            cursor: pointer;
            font-size: 14px;
        }
        .product-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .product-info img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 8px;
        }
        .product-name {
            font-weight: 600;
            margin: 0;
        }
        .product-code {
            font-size: 12px;
            color: #666;
            margin: 4px 0 0 0;
        }
        .deal-title-cell .title {
            font-weight: 600;
            margin: 0 0 4px 0;
        }
        .deal-title-cell .subtitle {
            font-size: 12px;
            color: #666;
            margin: 0;
        }
        .discount-badge {
            background: linear-gradient(135deg, #ff6b6b, #ee5a6f);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 14px;
            display: inline-block;
        }
        .price-original {
            text-decoration: line-through;
            color: #999;
            font-size: 13px;
            margin: 4px 0;
        }
        .price-sale {
            color: #d81e1e;
            font-weight: 700;
            font-size: 16px;
            margin: 0;
        }
        .datetime-cell {
            display: flex;
            flex-direction: column;
            gap: 6px;
            font-size: 13px;
        }
        .datetime-cell p {
            display: flex;
            align-items: center;
            gap: 6px;
            margin: 0;
        }
        .countdown {
            background: #fff3cd;
            padding: 4px 8px;
            border-radius: 6px;
            color: #856404;
            font-weight: 600;
        }
        .status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .status.active {
            background: #d4edda;
            color: #155724;
        }
        .status.inactive {
            background: #f8d7da;
            color: #721c24;
        }
        .status.upcoming {
            background: #d1ecf1;
            color: #0c5460;
        }
        .status.expired {
            background: #e2e3e5;
            color: #383d41;
        }
        .action-buttons {
            display: flex;
            gap: 8px;
        }
        .btn-action {
            width: 36px;
            height: 36px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        .btn-action i { font-size: 18px; }
        .btn-edit {
            background: #e3f2fd;
            color: #1976d2;
        }
        .btn-edit:hover {
            background: #1976d2;
            color: white;
        }
        .btn-toggle {
            background: #fff3cd;
            color: #856404;
        }
        .btn-toggle:hover {
            background: #ffc107;
            color: white;
        }
        .btn-delete {
            background: #ffebee;
            color: #c62828;
        }
        .btn-delete:hover {
            background: #c62828;
            color: white;
        }
        .no-data {
            text-align: center;
            padding: 60px 20px !important;
        }
        .no-data i {
            font-size: 64px;
            color: #ccc;
            display: block;
            margin-bottom: 16px;
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
                    <h1>🔥 Quản lý Weekend Deals</h1>
                    <ul class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/admin/index.jsp">Dashboard</a></li>
                        <li><i class='bx bx-chevron-right'></i></li>
                        <li><a class="active" href="#">Weekend Deals</a></li>
                    </ul>
                </div>
                <a href="${pageContext.request.contextPath}/admin/weekend-deal-edit" class="btn-add">
                    <i class='bx bx-plus-circle'></i>
                    <span class="text">Thêm Deal Mới</span>
                </a>
            </div>

            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success">
                    <i class='bx bx-check-circle'></i>
                    ${sessionScope.successMessage}
                </div>
                <c:remove var="successMessage" scope="session" />
            </c:if>

            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-error">
                    <i class='bx bx-error-circle'></i>
                    ${sessionScope.errorMessage}
                </div>
                <c:remove var="errorMessage" scope="session" />
            </c:if>

            <div class="table-data">
                <div class="order">
                    <div class="head">
                        <h3>Danh sách Weekend Deals</h3>
                        <select class="filter-select" onchange="filterDeals(this.value)">
                            <option value="all">Tất cả trạng thái</option>
                            <option value="active">Đang hoạt động</option>
                            <option value="upcoming">Sắp diễn ra</option>
                            <option value="expired">Đã hết hạn</option>
                        </select>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Sản phẩm</th>
                                <th>Tiêu đề</th>
                                <th>Giảm giá</th>
                                <th>Thời gian</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty deals}">
                                    <c:forEach items="${deals}" var="deal">
                                        <c:set var="now" value="<%= System.currentTimeMillis() %>" />
                                        <c:set var="isExpired" value="${deal.endDate.time < now}" />
                                        <c:set var="isUpcoming" value="${deal.startDate.time > now}" />
                                        <c:set var="isActive" value="${!isExpired && !isUpcoming && deal.status == 1}" />
                                        
                                        <tr class="deal-row" data-status="${isActive ? 'active' : (isUpcoming ? 'upcoming' : 'expired')}">
                                            <td>${deal.id}</td>
                                            <td>
                                                <div class="product-info">
                                                    <img src="${pageContext.request.contextPath}/${deal.product.image}" alt="${deal.product.name}">
                                                    <div>
                                                        <p class="product-name">${deal.product.name}</p>
                                                        <p class="product-code">${deal.product.productCode}</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="deal-title-cell">
                                                    <p class="title">${deal.title}</p>
                                                    <p class="subtitle">${deal.subtitle}</p>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="discount-cell">
                                                    <span class="discount-badge">-${deal.discountPercent}%</span>
                                                    <p class="price-original">
                                                        <fmt:formatNumber value="${deal.product.price}" type="number" groupingUsed="true" />đ
                                                    </p>
                                                    <p class="price-sale">
                                                        <fmt:formatNumber value="${deal.discountedPrice}" type="number" groupingUsed="true" />đ
                                                    </p>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="datetime-cell">
                                                    <p><i class='bx bx-time-five'></i> 
                                                        <fmt:formatDate value="${deal.startDate}" pattern="dd/MM/yyyy HH:mm" />
                                                    </p>
                                                    <p><i class='bx bx-timer'></i> 
                                                        <fmt:formatDate value="${deal.endDate}" pattern="dd/MM/yyyy HH:mm" />
                                                    </p>
                                                    <c:if test="${isActive}">
                                                        <p class="countdown" data-end-time="${deal.endDate.time}">
                                                            <i class='bx bx-hourglass'></i> 
                                                            <span class="countdown-text">Đang tính...</span>
                                                        </p>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${deal.status == 0}">
                                                        <span class="status inactive">
                                                            <i class='bx bx-x-circle'></i> Tắt
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${isActive}">
                                                        <span class="status active">
                                                            <i class='bx bx-check-circle'></i> Đang chạy
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${isUpcoming}">
                                                        <span class="status upcoming">
                                                            <i class='bx bx-time'></i> Sắp diễn ra
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status expired">
                                                            <i class='bx bx-x'></i> Đã hết hạn
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="action-buttons">
                                                    <a href="${pageContext.request.contextPath}/admin/weekend-deal-edit?id=${deal.id}" 
                                                       class="btn-action btn-edit" title="Chỉnh sửa">
                                                        <i class='bx bx-edit'></i>
                                                    </a>
                                                    <button onclick="toggleStatus(${deal.id}, ${deal.status})" 
                                                            class="btn-action btn-toggle" 
                                                            title="${deal.status == 1 ? 'Tắt' : 'Bật'}">
                                                        <i class='bx ${deal.status == 1 ? "bx-toggle-right" : "bx-toggle-left"}'></i>
                                                    </button>
                                                    <button onclick="deleteDeal(${deal.id})" 
                                                            class="btn-action btn-delete" title="Xóa">
                                                        <i class='bx bx-trash'></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="no-data">
                                            <i class='bx bx-error-circle'></i>
                                            <p>Chưa có deal nào</p>
                                            <a href="${pageContext.request.contextPath}/admin/weekend-deal-edit" class="btn-add">
                                                Thêm deal đầu tiên
                                            </a>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </section>

    <script src="${pageContext.request.contextPath}/assets/js/admin/script.js"></script>
    <script>
        function filterDeals(status) {
            const rows = document.querySelectorAll('.deal-row');
            rows.forEach(row => {
                row.style.display = (status === 'all' || row.dataset.status === status) ? '' : 'none';
            });
        }

        function toggleStatus(dealId, currentStatus) {
            if (confirm(`Bạn có chắc muốn ${currentStatus == 1 ? 'TẮT' : 'BẬT'} deal này?`)) {
                window.location.href = '${pageContext.request.contextPath}/admin/weekend-deals?action=toggle&id=' + dealId;
            }
        }

        function deleteDeal(dealId) {
            if (confirm('Bạn có chắc muốn XÓA deal này? Hành động này không thể hoàn tác!')) {
                window.location.href = '${pageContext.request.contextPath}/admin/weekend-deals?action=delete&id=' + dealId;
            }
        }

        function updateCountdowns() {
            document.querySelectorAll('.countdown').forEach(countdown => {
                const endTime = parseInt(countdown.dataset.endTime);
                const now = Date.now();
                const remaining = endTime - now;

                if (remaining > 0) {
                    const days = Math.floor(remaining / (1000 * 60 * 60 * 24));
                    const hours = Math.floor((remaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    const minutes = Math.floor((remaining % (1000 * 60 * 60)) / (1000 * 60));
                    
                    const text = countdown.querySelector('.countdown-text');
                    text.textContent = `Còn ${days}d ${hours}h ${minutes}m`;
                } else {
                    countdown.innerHTML = '<i class="bx bx-time"></i> Đã hết hạn';
                }
            });
        }

        setInterval(updateCountdowns, 60000);
        updateCountdowns();
    </script>
</body>
</html>
