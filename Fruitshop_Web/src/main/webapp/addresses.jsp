<%@page contentType="text/html" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Sổ địa chỉ - Organic Harvest</title>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css" />
      <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/addresses.css" />
      <style>
        .alert {
          padding: 10px 15px;
          margin-bottom: 15px;
          border-radius: 4px;
        }

        .alert-success {
          background-color: #d4edda;
          color: #155724;
          border: 1px solid #c3e6cb;
        }

        .alert-danger {
          background-color: #f8d7da;
          color: #721c24;
          border: 1px solid #f5c6cb;
        }

        .empty-addresses {
          text-align: center;
          padding: 40px;
          color: #888;
        }

        .empty-addresses i {
          font-size: 48px;
          margin-bottom: 15px;
          color: #ccc;
        }
      </style>
    </head>

    <body>
      <!-- HEADER -->
      <jsp:include page="header.jsp"></jsp:include>
      <div class="breadcrumb">
        <div class="container">
          <a href="${pageContext.request.contextPath}/">Trang chủ</a> &gt;
          <a href="${pageContext.request.contextPath}/profile">Tài khoản</a> &gt; <span>Địa chỉ</span>
        </div>
      </div>

      <section class="profile-section">
        <div class="container">
          <div class="profile-container">
            <aside class="profile-sidebar">
              <div class="profile-user-brief">
                <img
                  src="${sessionScope.account.avatar != null ? sessionScope.account.avatar : 'https://cdn-icons-png.flaticon.com/512/149/149071.png'}"
                  alt="Avatar" class="brief-avatar" />
                <div class="brief-info">
                  <span class="brief-name">${sessionScope.account.fullName}</span>
                  <a href="${pageContext.request.contextPath}/profile" class="brief-edit">
                    <i class="fa-solid fa-pen"></i> Sửa hồ sơ
                  </a>
                </div>
              </div>

              <ul class="profile-menu">
                    <li class="profile-menu-item active">
                      <a href="profile"><i class="fa-regular fa-user"></i> Hồ sơ của tôi</a>
                    </li>
                    <li class="profile-menu-item">
                      <a href="orders.jsp"><i class="fa-solid fa-box-open"></i> Đơn mua</a>
                    </li>
                    <li class="profile-menu-item">
                      <a href="addresses"><i class="fa-solid fa-location-dot"></i> Địa chỉ</a>
                    </li>
                    <li class="profile-menu-item ">
                      <a href="change-password.jsp"><i class="fa-solid fa-key"></i> Đổi mật khẩu</a>
                    </li>
                    <li class="profile-menu-item">
                      <a href="wishlist.jsp"><i class="fa-regular fa-heart"></i> Yêu thích</a>
                    </li>
                    <li class="profile-menu-item">
                      <a href="logout" style="color: red;"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a>
                    </li>
                  </ul>
            </aside>

            <main class="profile-content">
              <div class="address-header">
                <h3>Địa chỉ của tôi</h3>
                <button class="btn btn-primary" id="btnAddAddress">
                  <i class="fa-solid fa-plus"></i> Thêm địa chỉ mới
                </button>
              </div>

              <!-- Thông báo -->
              <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
              </c:if>
              <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
              </c:if>

              <div class="address-list">
                <!-- Nếu chưa có địa chỉ nào -->
                <c:if test="${empty addresses}">
                  <div class="empty-addresses">
                    <i class="fa-solid fa-location-dot"></i>
                    <p>Bạn chưa có địa chỉ nào</p>
                    <p>Hãy thêm địa chỉ để thuận tiện cho việc giao hàng</p>
                  </div>
                </c:if>

                <!-- Danh sách địa chỉ -->
                <c:forEach var="addr" items="${addresses}">
                  <div class="address-card ${addr.defaultAddress ? 'default' : ''}">
                    <div class="address-info">
                      <div class="info-row">
                        <span class="info-name">${addr.receiverName}</span>
                        <span class="info-divider">|</span>
                        <span class="info-phone">${addr.phoneNumber}</span>
                      </div>
                      <div class="info-address">
                        <p>${addr.address}</p>
                        <p>${addr.city}</p>
                      </div>
                      <div class="info-tags">
                        <c:if test="${addr.defaultAddress}">
                          <span class="tag tag-default">Mặc định</span>
                        </c:if>
                      </div>
                    </div>
                    <div class="address-actions">
                      <div class="action-links">
                        <button class="btn-text btn-edit" data-id="${addr.id}" data-name="${addr.receiverName}"
                          data-phone="${addr.phoneNumber}" data-address="${addr.address}" data-city="${addr.city}"
                          data-default="${addr.defaultAddress}">Cập nhật</button>
                        <c:choose>
                          <c:when test="${addr.defaultAddress}">
                            <button class="btn-text disabled" disabled>Xóa</button>
                          </c:when>
                          <c:otherwise>
                            <form action="${pageContext.request.contextPath}/addresses" method="post"
                              style="display:inline;">
                              <input type="hidden" name="action" value="delete" />
                              <input type="hidden" name="addressId" value="${addr.id}" />
                              <button type="submit" class="btn-text text-danger"
                                onclick="return confirm('Bạn có chắc muốn xóa địa chỉ này?')">Xóa</button>
                            </form>
                          </c:otherwise>
                        </c:choose>
                      </div>
                      <c:if test="${!addr.defaultAddress}">
                        <form action="${pageContext.request.contextPath}/addresses" method="post"
                          style="display:inline;">
                          <input type="hidden" name="action" value="setDefault" />
                          <input type="hidden" name="addressId" value="${addr.id}" />
                          <button type="submit" class="btn btn-outline btn-sm">Thiết lập mặc định</button>
                        </form>
                      </c:if>
                      <c:if test="${addr.defaultAddress}">
                        <button class="btn btn-outline btn-sm disabled" disabled>Thiết lập mặc định</button>
                      </c:if>
                    </div>
                  </div>
                </c:forEach>
              </div>
            </main>
          </div>
        </div>
      </section>

      <!-- Modal Thêm/Sửa Địa chỉ -->
      <div class="modal" id="addressModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3 id="modalTitle">Địa chỉ mới</h3>
            <span class="close-modal">&times;</span>
          </div>
          <div class="modal-body">
            <form class="address-form" action="${pageContext.request.contextPath}/addresses" method="post">
              <input type="hidden" name="action" id="formAction" value="add" />
              <input type="hidden" name="addressId" id="addressId" value="" />

              <div class="form-row">
                <input type="text" name="receiverName" id="receiverName" class="form-input" placeholder="Họ và tên"
                  required />
                <input type="text" name="phoneNumber" id="phoneNumber" class="form-input" placeholder="Số điện thoại"
                  required />
              </div>
              <div class="form-group">
                <input type="text" name="city" id="city" class="form-input"
                  placeholder="Tỉnh/Thành phố, Quận/Huyện, Phường/Xã" required />
              </div>
              <div class="form-group">
                <textarea name="address" id="address" class="form-input"
                  placeholder="Địa chỉ cụ thể (Số nhà, tên đường...)" rows="2" required></textarea>
              </div>

              <div class="form-group">
                <label class="checkbox-label">
                  <input type="checkbox" name="isDefault" id="isDefault" /> Đặt làm địa chỉ mặc định
                </label>
              </div>

              <div class="modal-footer">
                <button type="button" class="btn btn-outline close-modal-btn">Trở lại</button>
                <button type="submit" class="btn btn-primary">Hoàn thành</button>
              </div>
            </form>
          </div>
        </div>
      </div>

      <!-- FOOTER -->
      <jsp:include page="footer.jsp"></jsp:include>

      <script>
        const modal = document.getElementById("addressModal");
        const btnAdd = document.getElementById("btnAddAddress");
        const spanClose = document.getElementsByClassName("close-modal")[0];
        const btnClose = document.getElementsByClassName("close-modal-btn")[0];

        // Reset form
        function resetForm() {
          document.getElementById("modalTitle").textContent = "Địa chỉ mới";
          document.getElementById("formAction").value = "add";
          document.getElementById("addressId").value = "";
          document.getElementById("receiverName").value = "";
          document.getElementById("phoneNumber").value = "";
          document.getElementById("city").value = "";
          document.getElementById("address").value = "";
          document.getElementById("isDefault").checked = false;
        }

        // Mở modal thêm mới
        btnAdd.onclick = function () {
          resetForm();
          modal.style.display = "flex";
        };

        // Đóng modal
        const closeModal = () => {
          modal.style.display = "none";
        };
        spanClose.onclick = closeModal;
        btnClose.onclick = closeModal;

        // Click ra ngoài thì đóng
        window.onclick = function (event) {
          if (event.target == modal) {
            closeModal();
          }
        };

        // Xử lý nút Cập nhật
        document.querySelectorAll('.btn-edit').forEach(btn => {
          btn.onclick = function () {
            document.getElementById("modalTitle").textContent = "Cập nhật địa chỉ";
            document.getElementById("formAction").value = "update";
            document.getElementById("addressId").value = this.dataset.id;
            document.getElementById("receiverName").value = this.dataset.name;
            document.getElementById("phoneNumber").value = this.dataset.phone;
            document.getElementById("city").value = this.dataset.city;
            document.getElementById("address").value = this.dataset.address;
            document.getElementById("isDefault").checked = this.dataset.default === "true";
            modal.style.display = "flex";
          };
        });
      </script>
    </body>

    </html>