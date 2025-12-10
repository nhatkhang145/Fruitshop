<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!-- HEADER -->
<jsp:include page="header.jsp"></jsp:include>
<div class="main">

  <main class="fm-auth" style="margin-top: 40px; margin-bottom: 60px;">
    <div class="fm-card">
      <aside class="fm-left">
        <a href="" style="text-decoration: none;">
          <img class="fm-logo-img"
               src="https://ik.imagekit.io/8tm3umulk/image/logonew_fG_70DXF8?updatedAt=1762866381508"
               alt="Organic Harvest Logo" style="height: 70px; width: auto; margin-bottom: 30px;" />
        </a>
        <h2>Chào mừng đến với Organic Harvest</h2>
        <p>Mua trái cây tươi sạch — giao tận nhà nhanh chóng.</p>
        <div class="fm-illustration" aria-hidden="true"></div>
      </aside>

      <section class="fm-right">
        <div class="fm-form-wrap">
          <div class="fm-tabs" role="tablist" aria-label="Auth tabs">
            <button id="tab-login" class="fm-tab active" role="tab" aria-selected="true"
                    aria-controls="loginPanel">
              Đăng nhập
            </button>

            <button id="tab-register" class="fm-tab" role="tab" aria-selected="false"
                    aria-controls="registerPanel">
              Đăng ký
            </button>
          </div>

          <div id="loginPanel" class="fm-panel" role="tabpanel" aria-labelledby="tab-login">
            <form action="login" method="post">

              <c:if test="${not empty registerSuccess}">
                <div class="fm-message success"
                     style="color: green; text-align: center; margin-bottom: 10px;">
                  ${registerSuccess}
                </div>
              </c:if>

              <c:if test="${not empty error}">
                <p style="color: red; text-align: center">${error}</p>
              </c:if>

              <label class="fm-label">Email
                <input name="user" type="text" required placeholder="Nhập Email của bạn" />
              </label>

              <label class="fm-label">Mật khẩu
                <input name="pass" type="password" required
                       placeholder="Vui lòng nhập mật khẩu" />
              </label>

              <div class="fm-row">
                <label class="fm-check">
                  <input name="remember" type="checkbox" /> Ghi nhớ tôi
                </label>
                <a class="fm-link" href="forget_pass.html">Quên mật khẩu?</a>
              </div>

              <button type="submit" class="fm-btn">Đăng nhập</button>
              <div class="social-login">
                <p style="text-align: center; margin: 15px 0; color: #666;">Hoặc đăng nhập bằng
                </p>
                <div style="display: flex; gap: 10px; justify-content: center;">
                  <a href="#" class="btn-social facebook"
                     style="background: #3b5998; color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none;">
                    <i class="fa-brands fa-facebook-f"></i> Facebook
                  </a>
                  <a href="#" class="btn-social google"
                     style="background: #db4437; color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none;">
                    <i class="fa-brands fa-google"></i> Google
                  </a>
                </div>
              </div>
              <div id="loginMessage" class="fm-message" role="status" aria-live="polite"></div>

              <p class="fm-or">
                Bạn chưa có tài khoản?
                <a href="#register" id="gotoRegister">Tạo tài khoản</a>
              </p>
            </form>
          </div>

          <div id="registerPanel" class="fm-panel hidden" role="tabpanel"
               aria-labelledby="tab-register">
            <form action="register" method="post">

              <c:if test="${not empty registerError}">
                <div class="fm-message error"
                     style="color: red; text-align: center; margin-bottom: 10px;">
                  ${registerError}
                </div>
              </c:if>

              <label class="fm-label">Email
                <input name="user" type="text" required placeholder="Nhập Email của bạn" />
              </label>

              <label class="fm-label">Email
                <input name="email" type="email" required placeholder="Email" />
              </label>

              <label class="fm-label">Mật khẩu
                <input name="pass" type="password" required minlength="6"
                       placeholder="Mật khẩu" />
              </label>

              <label class="fm-label">Xác nhận mật khẩu
                <input name="re_pass" type="password" required
                       placeholder="Xác nhận mật khẩu" />
              </label>

              <button type="submit" class="fm-btn">Tạo tài khoản</button>

              <p class="fm-or">
                Đã có tài khoản? <a href="#login" id="gotoLogin">Đăng nhập</a>
              </p>
            </form>
          </div>
        </div>
      </section>
    </div>
  </main>
  <script>
    const loginTab = document.getElementById('tab-login');
    const registerTab = document.getElementById('tab-register');
    const loginPanel = document.getElementById('loginPanel');
    const registerPanel = document.getElementById('registerPanel');

    // Nếu có lỗi đăng ký → mở tab đăng ký
    // Nếu đăng ký thành công → giữ tab login (để user đăng nhập luôn)
    <% if (request.getAttribute("registerError") != null) { %>
      registerTab.click();
      <% } %>
    // registerSuccess → giữ nguyên tab login (mặc định)

    loginTab.addEventListener('click', () => {
      loginTab.classList.add('active');
      registerTab.classList.remove('active');
      loginPanel.classList.remove('hidden');
      registerPanel.classList.add('hidden');
    });

    registerTab.addEventListener('click', () => {
      registerTab.classList.add('active');
      loginTab.classList.remove('active');
      registerPanel.classList.remove('hidden');
      loginPanel.classList.add('hidden');
    });

    // Nút chuyển nhỏ bên dưới
    document.getElementById('gotoRegister').addEventListener('click', (e) => {
      e.preventDefault();
      registerTab.click();
    });
    document.getElementById('gotoLogin').addEventListener('click', (e) => {
      e.preventDefault();
      loginTab.click();
    });
  </script>
</div>
<!-- FOOTER -->
<jsp:include page="footer.jsp"></jsp:include>