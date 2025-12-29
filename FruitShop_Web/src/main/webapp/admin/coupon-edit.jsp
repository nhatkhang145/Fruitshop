<%@ page contentType="text/html;charset=UTF-8" language="java" %>
  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/product-edit.css" />
    <title>Tạo/Sửa Mã giảm giá</title>
  </head>

  <body>

    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="coupons" />
    </jsp:include>

    <div class="content">

      <jsp:include page="header.jsp" />

      <main>
        <div class="header">
          <div class="left">
            <h1>Tạo mã giảm giá</h1>
            <ul class="breadcrumb">
              <li><a href="/admin/coupons.jsp">Mã giảm giá</a></li>
              <li>/</li>
              <li><a href="#" class="active">Thêm mới</a></li>
            </ul>
          </div>
          <a href="#" class="report" onclick="document.getElementById('couponForm').submit()">
            <i class="bx bx-save"></i>
            <span>Lưu mã</span>
          </a>
        </div>

        <div class="bottom-data">
          <div class="product-edit">
            <form id="couponForm" class="product-edit__form">

              <div class="product-edit__main">
                <div class="product-edit__card">
                  <div class="product-edit__group">
                    <label class="product-edit__label">Mã Code (Viết liền, không dấu)</label>
                    <input type="text" class="product-edit__input" placeholder="Ví dụ: TET2025, SALE50"
                      style="text-transform: uppercase;" required />
                  </div>
                  <div class="product-edit__group">
                    <label class="product-edit__label">Mô tả chương trình</label>
                    <textarea class="product-edit__textarea" rows="3"
                      placeholder="Ví dụ: Giảm giá mừng xuân Ất Tỵ..."></textarea>
                  </div>
                </div>

                <div class="product-edit__card">
                  <legend class="product-edit__legend">Thiết lập mức giảm</legend>
                  <div class="product-edit__price-row">
                    <div class="product-edit__group">
                      <label class="product-edit__label">Loại giảm giá</label>
                      <select class="product-edit__select">
                        <option value="percent">Theo phần trăm (%)</option>
                        <option value="fixed">Số tiền cố định (VNĐ)</option>
                      </select>
                    </div>
                    <div class="product-edit__group">
                      <label class="product-edit__label">Giá trị giảm</label>
                      <input type="number" class="product-edit__input"
                        placeholder="VD: 10 (cho %) hoặc 50000 (cho tiền)" />
                    </div>
                  </div>
                  <div class="product-edit__group" style="margin-top: 15px;">
                    <label class="product-edit__label">Đơn hàng tối thiểu để áp dụng (VNĐ)</label>
                    <input type="number" class="product-edit__input" value="0" />
                    <small style="color: #888;">Nhập 0 nếu áp dụng cho mọi đơn hàng.</small>
                  </div>
                </div>
              </div>

              <div class="product-edit__sidebar">
                <div class="product-edit__card">
                  <legend class="product-edit__legend">Thời gian áp dụng</legend>
                  <div class="product-edit__group">
                    <label class="product-edit__label">Ngày bắt đầu</label>
                    <input type="datetime-local" class="product-edit__input" />
                  </div>
                  <div class="product-edit__group">
                    <label class="product-edit__label">Ngày kết thúc</label>
                    <input type="datetime-local" class="product-edit__input" />
                  </div>
                </div>

                <div class="product-edit__card">
                  <legend class="product-edit__legend">Giới hạn sử dụng</legend>
                  <div class="product-edit__group">
                    <label class="product-edit__label">Số lượng mã tối đa</label>
                    <input type="number" class="product-edit__input" placeholder="VD: 100" />
                    <small style="color: #888;">Để trống nếu không giới hạn.</small>
                  </div>
                  <div class="product-edit__group">
                    <label class="product-edit__label">Trạng thái</label>
                    <select class="product-edit__select">
                      <option value="1">Đang hoạt động</option>
                      <option value="0">Tạm khóa</option>
                    </select>
                  </div>
                  <button type="submit" class="btn-submit product-edit__save-btn">Lưu Mã</button>
                </div>
              </div>

            </form>
          </div>
        </div>
      </main>
    </div>
    <script src="../assets/js/admin/main.js"></script>
  </body>

  </html>