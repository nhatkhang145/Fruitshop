// ...existing code...
(function(){
  const loginForm = document.getElementById('loginForm');
  const registerForm = document.getElementById('registerForm');

  function showMessage(el, text, type){
    if(!el) return;
    el.textContent = text;
    el.className = 'fm-message ' + (type === 'error' ? 'error' : '');
  }

  async function postJson(url, data){
    try{
      const res = await fetch(url, {
        method:'POST',
        headers:{'Content-Type':'application/json'},
        body: JSON.stringify(data),
        credentials: 'include'
      });
      const json = await res.json().catch(()=>null);
      return { status: res.status, ok: res.ok, body: json };
    }catch(err){
      return { status:0, ok:false, body: { message: 'Không thể kết nối tới server' } };
    }
  }

  if(loginForm){
    loginForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      const btn = loginForm.querySelector('button[type="submit"]');
      const msg = document.getElementById('loginMessage');
      btn.disabled = true;
      showMessage(msg, 'Đang đăng nhập...', 'info');

      const data = {
        email: loginForm.email.value.trim(),
        password: loginForm.password.value
      };

      if(!data.email || !data.password){
        showMessage(msg, 'Vui lòng nhập email và mật khẩu', 'error'); btn.disabled = false; return;
      }

      const res = await postJson('/api/auth/login', data);
      if(res.ok){
        showMessage(msg, 'Đăng nhập thành công, chuyển hướng...', 'info');
        const redirect = (res.body && res.body.redirect) || '/';
        setTimeout(()=> window.location.href = redirect, 700);
      } else {
        const reason = (res.body && (res.body.message || res.body.error)) || 'Đăng nhập thất bại';
        showMessage(msg, reason, 'error');
        btn.disabled = false;
      }
    });
  }

  if(registerForm){
    registerForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      const btn = registerForm.querySelector('button[type="submit"]');
      const msg = document.getElementById('registerMessage');
      btn.disabled = true;
      showMessage(msg, 'Đang tạo tài khoản...', 'info');

      const name = registerForm.name.value.trim();
      const email = registerForm.email.value.trim();
      const password = registerForm.password.value;
      const confirm = registerForm.confirmPassword.value;

      if(!name || !email || !password){
        showMessage(msg, 'Vui lòng điền đầy đủ thông tin', 'error'); btn.disabled = false; return;
      }
      if(password.length < 6){
        showMessage(msg, 'Mật khẩu phải có ít nhất 6 ký tự', 'error'); btn.disabled = false; return;
      }
      if(password !== confirm){
        showMessage(msg, 'Mật khẩu xác nhận không khớp', 'error'); btn.disabled = false; return;
      }

      const res = await postJson('/api/auth/register', { name, email, password });
      if(res.ok){
        showMessage(msg, 'Đăng ký thành công. Chuyển sang trang đăng nhập...', 'info');
        setTimeout(()=> window.location.href = (res.body && res.body.redirect) || 'login.jsp', 900);
      } else {
        const reason = (res.body && (res.body.message || res.body.error)) || 'Đăng ký thất bại';
        showMessage(msg, reason, 'error');
        btn.disabled = false;
      }
    });
  }
})();