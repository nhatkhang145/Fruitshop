<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="vi">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Quản lý Danh mục | Admin</title>

      <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />

      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/Categories.css" />
    </head>

    <body>
      <jsp:include page="sidebar.jsp"></jsp:include>

      <div class="content">
        <jsp:include page="header.jsp"></jsp:include>

        <main>
          <div class="header-title">
            <div class="left">
              <h1>Danh Mục Sản Phẩm</h1>
              <ul class="breadcrumb">
                <li><a href="#">Quản lý</a></li>
                <li><i class='bx bx-chevron-right'></i></li>
                <li><a href="#" class="active">Danh mục</a></li>
              </ul>
            </div>

            <a href="#" class="btn-create" onclick="openModal('add')">
              <i class='bx bx-plus'></i>
              <span>Tạo danh mục</span>
            </a>
          </div>

          <div class="toolbar-section">
            <div class="search-box">
              <i class='bx bx-search'></i>
              <input type="text" id="searchInput" onkeyup="searchCategory()" placeholder="Tìm kiếm danh mục...">
            </div>

            <div class="stats-badge">
              <span class="label">Tổng số danh mục:</span>
              <span class="count">${listC.size()}</span>
            </div>
          </div>

          <div class="category-list-container" id="categoryContainer">

            <!-- Hiển thị Danh mục Cha -->
            <c:forEach items="${parentC}" var="parent">
              <div class="category-card root-card">
                <div class="card-info">
                  <div class="icon-box">
                    <i class='bx bxs-folder-open'></i>
                  </div>
                  <div class="text-content">
                    <h3 class="cate-name">${parent.name}</h3>
                    <p class="cate-desc">${parent.description != null && !parent.description.isEmpty() ?
                      parent.description : '...'}</p>
                  </div>
                </div>

                <div class="card-meta">
                  <span class="meta-badge">ID: #${parent.id}</span>
                </div>

                <div class="card-status">
                  <c:choose>
                    <c:when test="${parent.status == 1}">
                      <span class="status-pill active">Hoạt động</span>
                    </c:when>
                    <c:otherwise>
                      <span class="status-pill inactive">Đang ẩn</span>
                    </c:otherwise>
                  </c:choose>
                </div>

                <div class="card-actions">
                  <button
                    onclick="editCategory(${parent.id}, '${parent.name}', '${parent.description}', ${parent.status}, ${parent.parentId})"
                    class="btn-icon edit" title="Sửa">
                    <i class='bx bx-edit-alt'></i>
                  </button>
                  <a href="delete-category?id=${parent.id}" onclick="return confirm('Bạn chắc chắn muốn xóa?')"
                    class="btn-icon delete" title="Xóa">
                    <i class='bx bx-trash'></i>
                  </a>
                </div>
              </div>

              <!-- Hiển thị Danh mục Con của Danh mục Cha này -->
              <c:forEach items="${listC}" var="child">
                <c:if test="${child.parentId == parent.id}">
                  <div class="category-card sub-card">
                    <div class="card-info">
                      <div class="icon-box">
                        <i class='bx bx-subdirectory-right'></i>
                      </div>
                      <div class="text-content">
                        <h3 class="cate-name">${child.name}</h3>
                        <p class="cate-desc">${child.description != null && !child.description.isEmpty() ?
                          child.description : '...'}</p>
                      </div>
                    </div>

                    <div class="card-meta">
                      <span class="meta-badge">ID: #${child.id}</span>
                      <span class="meta-badge parent-badge">Cha: ID #${child.parentId}</span>
                    </div>

                    <div class="card-status">
                      <c:choose>
                        <c:when test="${child.status == 1}">
                          <span class="status-pill active">Hoạt động</span>
                        </c:when>
                        <c:otherwise>
                          <span class="status-pill inactive">Đang ẩn</span>
                        </c:otherwise>
                      </c:choose>
                    </div>

                    <div class="card-actions">
                      <button
                        onclick="editCategory(${child.id}, '${child.name}', '${child.description}', ${child.status}, ${child.parentId})"
                        class="btn-icon edit" title="Sửa">
                        <i class='bx bx-edit-alt'></i>
                      </button>
                      <a href="delete-category?id=${child.id}" onclick="return confirm('Bạn chắc chắn muốn xóa?')"
                        class="btn-icon delete" title="Xóa">
                        <i class='bx bx-trash'></i>
                      </a>
                    </div>
                  </div>
                </c:if>
              </c:forEach>
            </c:forEach>

            <c:if test="${empty listC}">
              <div class="empty-state">
                <p>Chưa có danh mục nào. Hãy tạo mới ngay!</p>
              </div>
            </c:if>

          </div>
        </main>
      </div>

      <div id="categoryModal" class="modal">
        <div class="modal-content">
          <div class="modal-header">
            <h2 id="modalTitle">Thêm Danh Mục</h2>
            <span class="close" onclick="closeModal()">&times;</span>
          </div>
          <div class="modal-body">
            <form action="category-servlet" method="POST" id="categoryForm">
              <input type="hidden" name="action" id="formAction" value="add">
              <input type="hidden" name="id" id="catId" value="">

              <div class="form-group">
                <label>Tên danh mục <span style="color:red">*</span></label>
                <input type="text" name="name" id="catName" required placeholder="Nhập tên...">
              </div>

              <div class="form-group">
                <label>Danh mục cha</label>
                <select name="parentId" id="catParent">
                  <option value="0">-- Là Danh Mục Gốc --</option>
                  <c:forEach items="${listC}" var="parent">
                    <c:if test="${parent.parentId == 0}">
                      <option value="${parent.id}">${parent.name}</option>
                    </c:if>
                  </c:forEach>
                </select>
              </div>

              <div class="form-group">
                <label>Mô tả</label>
                <textarea name="description" id="catDesc" rows="3"></textarea>
              </div>

              <div class="form-group">
                <label>Trạng thái</label>
                <select name="status" id="catStatus">
                  <option value="1">Hiển thị</option>
                  <option value="0">Ẩn</option>
                </select>
              </div>

              <div class="modal-footer">
                <button type="button" class="btn-cancel" onclick="closeModal()">Hủy</button>
                <button type="submit" class="btn-save">Lưu lại</button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <script src="${pageContext.request.contextPath}/assets/js/admin/main.js"></script>

      <script>
        /* JS Logic cho Modal và Search */
        const modal = document.getElementById("categoryModal");
        const modalTitle = document.getElementById("modalTitle");
        const formAction = document.getElementById("formAction");

        function openModal(mode) {
          modal.classList.add("show");
          if (mode === 'add') {
            modalTitle.innerText = "Thêm Danh Mục Mới";
            formAction.value = "add";
            document.getElementById("categoryForm").reset();
          }
        }

        function editCategory(id, name, desc, status, parentId) {
          modal.classList.add("show");
          modalTitle.innerText = "Cập Nhật Danh Mục";
          formAction.value = "edit";
          document.getElementById("catId").value = id;
          document.getElementById("catName").value = name;
          document.getElementById("catDesc").value = desc;
          document.getElementById("catStatus").value = status;
          document.getElementById("catParent").value = parentId;
        }

        function closeModal() { modal.classList.remove("show"); }
        window.onclick = function (e) { if (e.target == modal) closeModal(); }

        function searchCategory() {
          let input = document.getElementById('searchInput').value.toLowerCase();
          let cards = document.getElementsByClassName('category-card');
          for (let i = 0; i < cards.length; i++) {
            let name = cards[i].getElementsByClassName('cate-name')[0].innerText.toLowerCase();
            cards[i].style.display = name.includes(input) ? "flex" : "none";
          }
        }
        // --- LOGIC PHÂN TRANG (PAGINATION) ---
        document.addEventListener("DOMContentLoaded", function () {
          const itemsPerPage = 100;
          const container = document.getElementById('categoryContainer');
          const items = container.getElementsByClassName('category-card');
          const pagination = document.getElementById('pagination');
          let currentPage = 1;

          function showPage(page) {
            const totalPages = Math.ceil(items.length / itemsPerPage);

            // Xử lý biên (Không nhỏ hơn 1, không lớn hơn max)
            if (page < 1) page = 1;
            if (page > totalPages) page = totalPages;
            currentPage = page;

            // 1. Ẩn/Hiện các thẻ Card
            const start = (page - 1) * itemsPerPage;
            const end = start + itemsPerPage;

            for (let i = 0; i < items.length; i++) {
              if (i >= start && i < end) {
                items[i].style.display = "flex"; // Hiện
              } else {
                items[i].style.display = "none"; // Ẩn
              }
            }

            // 2. Vẽ lại nút phân trang
            renderPagination(totalPages);
          }

          function renderPagination(totalPages) {
            pagination.innerHTML = ""; // Xóa nút cũ

            // Nút Prev (<)
            const prevBtn = document.createElement("button");
            prevBtn.innerHTML = "<i class='bx bx-chevron-left'></i>";
            prevBtn.className = 'page-btn ' + (currentPage === 1 ? 'disabled' : '');
            prevBtn.onclick = () => showPage(currentPage - 1);
            pagination.appendChild(prevBtn);

            // Các nút số (1, 2, 3...)
            // Logic rút gọn: Nếu quá nhiều trang, chỉ hiện 1 vài trang (Basic version: hiện hết)
            for (let i = 1; i <= totalPages; i++) {
              const btn = document.createElement("button");
              btn.innerText = i;
              btn.className = 'page-btn ' + (i === currentPage ? 'active' : '');
              btn.onclick = () => showPage(i);
              pagination.appendChild(btn);
            }

            // Nút Next (>)
            const nextBtn = document.createElement("button");
            nextBtn.innerHTML = "<i class='bx bx-chevron-right'></i>";
            nextBtn.className = 'page-btn ' + (currentPage === totalPages ? 'disabled' : '');
            nextBtn.onclick = () => showPage(currentPage + 1);
            pagination.appendChild(nextBtn);
          }

          // Khởi chạy lần đầu nếu có dữ liệu
          if (items.length > 0) {
            showPage(1);
          }

          // --- CẬP NHẬT LOGIC TÌM KIẾM ---
          // Khi tìm kiếm thì phải Reset lại phân trang (hoặc ẩn phân trang đi)
          window.searchCategory = function () {
            let input = document.getElementById('searchInput').value.toLowerCase();
            let hasResult = false;

            // Nếu ô tìm kiếm trống -> Quay lại chế độ phân trang
            if (input === "") {
              showPage(1);
              pagination.style.display = "flex";
              return;
            }

            // Nếu đang tìm kiếm -> Ẩn thanh phân trang, hiện tất cả kết quả khớp
            pagination.style.display = "none";

            for (let i = 0; i < items.length; i++) {
              let name = items[i].getElementsByClassName('cate-name')[0].innerText.toLowerCase();
              if (name.includes(input)) {
                items[i].style.display = "flex";
                hasResult = true;
              } else {
                items[i].style.display = "none";
              }
            }
          }
        });
      </script>
    </body>

    </html>