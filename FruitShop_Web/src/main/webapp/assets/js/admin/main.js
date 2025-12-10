// Dán vào file: main.js

/* =================================== */
/* === SCRIPT CHUNG (MAIN.JS) === */
/* =================================== */

// Đợi DOM sẵn sàng
document.addEventListener("DOMContentLoaded", () => {
  // Helper
  const $ = (sel) => document.querySelector(sel);
  const $$ = (sel) => document.querySelectorAll(sel);

  //--- 1. Menu bar toggle (Sidebar) ---
  const menuBar = $(".content nav .bx.bx-menu");
  const sideBar = $(".sidebar");
  if (menuBar && sideBar) {
    menuBar.addEventListener("click", () => {
      sideBar.classList.toggle("close");
    });
  }

  //--- 2. Search toggle (small screens) ---
  const searchBtn = $(".content nav form .form-input button");
  const searchBtnIcon = $(".content nav form .form-input button .bx");
  const searchForm = $(".content nav form");
  if (searchBtn && searchForm && searchBtnIcon) {
    searchBtn.addEventListener("click", function (e) {
      if (window.innerWidth < 576) {
        e.preventDefault();
        searchForm.classList.toggle("show");
        if (searchForm.classList.contains("show")) {
          searchBtnIcon.classList.replace("bx-search", "bx-x");
        } else {
          searchBtnIcon.classList.replace("bx-x", "bx-search");
        }
      }
    });
  }

  //--- 3. Debounce helper ---
  function debounce(fn, wait = 100) {
    let t;
    return (...args) => {
      clearTimeout(t);
      t = setTimeout(() => fn(...args), wait);
    };
  }

  //--- 4. Responsive handler (Resize) ---
  window.addEventListener(
    "resize",
    debounce(() => {
      if (sideBar) {
        if (window.innerWidth < 768) sideBar.classList.add("close");
        else sideBar.classList.remove("close");
      }
      if (searchForm && searchBtnIcon) {
        if (window.innerWidth > 576) {
          searchBtnIcon.classList.replace("bx-x", "bx-search");
          searchForm.classList.remove("show");
        }
      }
    }, 120)
  );

  //--- 5. Theme toggler (Dark Mode) ---
  const toggler = document.getElementById("theme-toggle");
  if (toggler) {
    const saved = localStorage.getItem("theme");
    if (saved === "dark") {
      document.body.classList.add("dark");
      toggler.checked = true;
    }
    toggler.addEventListener("change", function () {
      if (this.checked) {
        document.body.classList.add("dark");
        localStorage.setItem("theme", "dark");
      } else {
        document.body.classList.remove("dark");
        localStorage.setItem("theme", "light");
      }
    });
  }

  //--- 6. Notification Dropdown ---
  const notifBtn = document.getElementById("notifBtn");
  const notifDropdown = document.getElementById("notifDropdown");
  if (notifBtn && notifDropdown) {
    notifBtn.addEventListener("click", (e) => {
      e.preventDefault();
      notifDropdown.classList.toggle("show");
    });
    window.addEventListener("click", (e) => {
      if (!notifBtn.contains(e.target) && !notifDropdown.contains(e.target)) {
        notifDropdown.classList.remove("show");
      }
    });
  }

  //--- 7. Profile Dropdown ---
  const profileBtn = document.getElementById("profileBtn");
  const profileDropdown = document.getElementById("profileDropdown");
  if (profileBtn && profileDropdown) {
    profileBtn.addEventListener("click", (e) => {
      e.preventDefault();
      profileDropdown.classList.toggle("show");
    });
    window.addEventListener("click", (e) => {
      if (
        !profileBtn.contains(e.target) &&
        !profileDropdown.contains(e.target)
      ) {
        profileDropdown.classList.remove("show");
      }
    });
  }

  //--- 8. Logout Button ---
  const logoutBtn = $(".sidebar .logout");
  if (logoutBtn) {
    logoutBtn.addEventListener("click", (e) => {
      e.preventDefault();
      const isConfirmed = confirm("Bạn có chắc chắn muốn đăng xuất không?");
      if (isConfirmed) {
        localStorage.removeItem("authToken");
        alert("Đã đăng xuất thành công!");
        window.location.href = "/admin/login.jsp"; // Sửa lại đường dẫn nếu cần
      }
    });
  }
});

/* === SCRIPT TRANG CHI TIẾT KHÁCH HÀNG (user-detail.html) === */
document.addEventListener("DOMContentLoaded", () => {
  // Chỉ chạy nếu chúng ta ở trang user-detail (kiểm tra bằng 1 ID)
  const userDetailMain = document.querySelector(".user-detail__main");

  if (userDetailMain) {
    const urlParams = new URLSearchParams(window.location.search);
    const userId = urlParams.get("id");

    if (userId) {
      // (Trong tương lai, bạn sẽ dùng fetch(API_URL + userId) ở đây
      // để tải dữ liệu thật và điền vào form)

      // Ví dụ: Lấy tên từ card (sau khi đã tải)
      const userName = document.querySelector(".user-detail__name").innerText;

      // Cập nhật tiêu đề
      const pageTitle = document.getElementById("pageTitle");
      const breadcrumbTitle = document.getElementById("breadcrumbTitle");

      if (pageTitle) pageTitle.innerText = userName;
      if (breadcrumbTitle) breadcrumbTitle.innerText = userName;
    }
  }
});
