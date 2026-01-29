<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Quản lý Banner</title>

    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/banners.css" />

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
</head>

<body>

    <jsp:include page="sidebar.jsp">
        <jsp:param name="activePage" value="banners" />
    </jsp:include>

    <div class="content">
        <jsp:include page="header.jsp" />

        <main>
            <div class="header">
                <div class="left">
                    <h1>Quản lý Banner</h1>
                    <ul class="breadcrumb">
                        <li><a href="index.jsp">Dashboard</a></li>
                        <li>/</li>
                        <li><a href="#" class="active">Banner Quảng Cáo</a></li>
                    </ul>
                </div>
                <a href="#" class="report" onclick="openAddModal()">
                    <i class="bx bx-plus"></i>
                    <span>Thêm Banner</span>
                </a>
            </div>

            <div class="bottom-data">
                <div class="orders">
                    <div class="header">
                        <h3>Danh sách Banner</h3>
                    </div>

                    <table id="bannerTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Hình ảnh</th>
                                <th>Tiêu đề / Mô tả</th>
                                <th>Liên kết</th>
                                <th>Thứ tự</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${banners}" var="b">
                                <tr>
                                    <td>#${b.id}</td>
                                    <td>
                                        <c:choose>
                                          <c:when test="${fn:startsWith(b.imageUrl, 'http')}">
                                            <img src="${b.imageUrl}" alt="banner" class="banner-img"
                                                 onerror="this.src='https://via.placeholder.com/120x60'"/>
                                          </c:when>
                                          <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/${b.imageUrl}" alt="banner" class="banner-img"
                                                 onerror="this.src='https://via.placeholder.com/120x60'"/>
                                          </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <strong>${b.title}</strong><br>
                                        <small style="color: #888;">${b.description}</small>
                                    </td>
                                    <td><a href="${b.link}" target="_blank" style="color: var(--primary);">${b.link}</a></td>
                                    <td style="text-align: center;">${b.displayOrder}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${b.status == 1}"><span class="status active">Hiển thị</span></c:when>
                                            <c:otherwise><span class="status hidden">Đã ẩn</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="#" class="action-btn edit"
                                           data-id="${b.id}"
                                           data-title="${b.title}"
                                           data-desc="${b.description}"
                                           data-link="${b.link}"
                                           data-linktype="${not empty b.linkType ? b.linkType : 'none'}"
                                           data-linktarget="${not empty b.linkTarget ? b.linkTarget : ''}"
                                           data-order="${b.displayOrder}"
                                           data-status="${b.status}"
                                           data-img="${pageContext.request.contextPath}/${b.imageUrl}"
                                           data-imageurl="${b.imageUrl}">
                                            <i class="bx bx-edit"></i>
                                        </a>
                                        <a href="banners?action=delete&id=${b.id}" class="action-btn delete"
                                           onclick="return confirm('Bạn có chắc muốn xóa banner này?');">
                                            <i class="bx bx-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <div id="bannerModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="closeModal()" style="float:right; font-size:24px; cursor:pointer;">&times;</span>
            <h2 id="modalTitle">Thêm Banner Mới</h2>

            <form action="banners" method="post" enctype="multipart/form-data" id="bannerForm">
                <input type="hidden" name="action" id="formAction" value="add">
                <input type="hidden" name="id" id="bannerId">
                <input type="hidden" name="oldImage" id="oldImage">

                <div class="form-group">
                    <label>Tiêu đề</label>
                    <input type="text" name="title" id="title" required class="form-control" placeholder="Nhập tiêu đề banner">
                </div>

                <div class="form-group">
                    <label>Mô tả ngắn</label>
                    <textarea name="description" id="description" rows="2" class="form-control"></textarea>
                </div>

                <div class="form-group">
                    <label>Loại liên kết</label>
                    <select name="linkType" id="linkType" class="form-control" onchange="handleLinkTypeChange()">
                        <option value="none">Không có link (Chỉ hiển thị)</option>
                        <option value="internal">Trang nội bộ</option>
                        <option value="product">Sản phẩm cụ thể</option>
                        <option value="category">Danh mục sản phẩm</option>
                        <option value="external">Link bên ngoài</option>
                    </select>
                </div>

                <div class="form-group" id="linkTargetGroup">
                    <label id="linkTargetLabel">Đường dẫn</label>
                    <input type="text" name="linkTarget" id="linkTarget" class="form-control" placeholder="">
                    <small id="linkTargetHint" style="color: #666; font-size: 12px; margin-top: 5px; display: block;"></small>
                </div>

                <!-- Giữ field link cũ để backward compatibility -->
                <input type="hidden" name="link" id="link" value="">

                <div class="form-group-row" style="display:flex; gap:20px; margin-top:15px;">
                    <div class="form-group">
                        <label>Thứ tự hiển thị</label>
                        <input type="number" name="displayOrder" id="displayOrder" value="0" class="form-control" style="width:100px;">
                    </div>

                    <div class="form-group" style="display: flex; align-items: center; padding-top: 30px;">
                        <input type="checkbox" name="status" id="status" value="1" style="width: 20px; height: 20px; margin-right: 10px;">
                        <label for="status" style="margin: 0; cursor: pointer;">Hiển thị ngay</label>
                    </div>
                </div>

                <div class="form-group" style="margin-top:15px;">
                    <label>Hình ảnh</label>
                    <input type="file" name="image" id="imageInput" accept="image/*" class="form-control">
                    <div id="imagePreview" style="display: none;">
                        <img src="" id="previewImg">
                    </div>
                </div>

                <button type="submit" class="btn-submit" style="margin-top:20px; width:100%; padding:10px; background:var(--primary); color:white; border:none; border-radius:6px; cursor:pointer;">Lưu Banner</button>
            </form>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/admin/banners.js"></script>

</body>
</html>