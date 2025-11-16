// helper: safe query
const $ = (sel) => document.querySelector(sel);

// Sidebar links
const sideLinks = document.querySelectorAll('.sidebar .side-menu li a:not(.logout)');
sideLinks.forEach(item => {
  const li = item.closest('li'); // an toàn hơn parentElement
  if (!li) return;
  item.addEventListener('click', (e) => {
    // nếu link là <a href="#">, có thể muốn prevent default?
    sideLinks.forEach(i => {
      const parent = i.closest('li');
      if (parent) parent.classList.remove('active');
    });
    li.classList.add('active');
  });
});

// Menu bar toggle
const menuBar = $('.content nav .bx.bx-menu');
const sideBar = $('.sidebar');
if (menuBar && sideBar) {
  menuBar.addEventListener('click', () => {
    sideBar.classList.toggle('close');
  });
}

// Search toggle (small screens)
const searchBtn = $('.content nav form .form-input button');
const searchBtnIcon = $('.content nav form .form-input button .bx');
const searchForm = $('.content nav form');
if (searchBtn && searchForm && searchBtnIcon) {
  searchBtn.addEventListener('click', function (e) {
    if (window.innerWidth < 576) {
      e.preventDefault(); // <<-- sửa lỗi ở code gốc
      searchForm.classList.toggle('show');
      if (searchForm.classList.contains('show')) {
        searchBtnIcon.classList.replace('bx-search', 'bx-x');
      } else {
        searchBtnIcon.classList.replace('bx-x', 'bx-search');
      }
    }
  });
}

// Debounced resize handler
function debounce(fn, wait = 100) {
  let t;
  return (...args) => {
    clearTimeout(t);
    t = setTimeout(() => fn(...args), wait);
  };
}

window.addEventListener('resize', debounce(() => {
  if (sideBar) {
    if (window.innerWidth < 768) sideBar.classList.add('close');
    else sideBar.classList.remove('close');
  }
  if (searchForm && searchBtnIcon) {
    if (window.innerWidth > 576) {
      searchBtnIcon.classList.replace('bx-x', 'bx-search');
      searchForm.classList.remove('show');
    }
  }
}, 120));

// Theme toggler with persistence
const toggler = document.getElementById('theme-toggle');
if (toggler) {
  // init from saved preference
  const saved = localStorage.getItem('theme');
  if (saved === 'dark') {
    document.body.classList.add('dark');
    toggler.checked = true;
  }
  toggler.addEventListener('change', function () {
    if (this.checked) {
      document.body.classList.add('dark');
      localStorage.setItem('theme', 'dark');
    } else {
      document.body.classList.remove('dark');
      localStorage.setItem('theme', 'light');
    }
  });
}

/* =================================== */
/* === SCRIPT CHO MODAL PHÂN QUYỀN === */
/* =================================== */

// Lấy các phần tử
const addRoleBtn = document.getElementById("addRoleBtn");
const roleModal = document.getElementById("roleModal");

// Chỉ chạy nếu các phần tử này tồn tại (tức là ta đang ở trang Roles.html)
if (addRoleBtn && roleModal) {
  const closeRoleModalBtn = roleModal.querySelector(".close-btn");
  const modalRoleTitle = roleModal.querySelector("#modalTitle");
  const roleForm = roleModal.querySelector("#roleForm");

  // Mở modal khi nhấn nút "Thêm Vai trò"
  addRoleBtn.addEventListener("click", (e) => {
    e.preventDefault();
    modalRoleTitle.innerText = "Thêm Vai trò mới";
    roleForm.reset(); // Xóa trắng form
    roleModal.style.display = "block";
  });

  // Đóng modal khi nhấn nút "X"
  closeRoleModalBtn.addEventListener("click", () => {
    roleModal.style.display = "none";
  });

  // Đóng modal khi nhấn ra ngoài
  window.addEventListener("click", (e) => {
    if (e.target == roleModal) {
      roleModal.style.display = "none";
    }
  });

  // Xử lý khi nhấn nút "Sửa"
  const editRoleButtons = document.querySelectorAll(
    ".bottom-data .orders .action-btn.edit"
  );
  editRoleButtons.forEach((btn) => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      modalRoleTitle.innerText = "Chỉnh sửa Vai trò";
      // (Logic để điền dữ liệu cũ vào form sẽ ở đây)
      // Ví dụ: Lấy tên vai trò
      // const roleName = btn.closest('tr').children[0].innerText;
      // document.getElementById('roleName').value = roleName;
      // ... (Tương tự cho việc check các checkbox)
      roleModal.style.display = "block";
    });
  });
}



/* =================================== */
/* === SCRIPT CHO MODAL TÀI KHOẢN ADMIN === */
/* =================================== */

// Lấy các phần tử
const addAdminBtn = document.getElementById("addAdminBtn");
const adminAccountModal = document.getElementById("adminAccountModal");

// Chỉ chạy nếu các phần tử này tồn tại (tức là ta đang ở trang AdminAccounts.html)
if (addAdminBtn && adminAccountModal) {
  const closeAdminModalBtn = adminAccountModal.querySelector(".close-btn");
  const modalAdminTitle = adminAccountModal.querySelector("#modalTitle");
  const adminAccountForm = adminAccountModal.querySelector("#adminAccountForm");
  const passwordInput = adminAccountModal.querySelector("#adminPassword");

  // Mở modal khi nhấn nút "Thêm Tài khoản"
  addAdminBtn.addEventListener("click", (e) => {
    e.preventDefault();
    modalAdminTitle.innerText = "Thêm Tài khoản Admin";
    adminAccountForm.reset();
    passwordInput.placeholder = "Nhập mật khẩu (Bắt buộc)";
    adminAccountModal.style.display = "block";
  });

  // Đóng modal khi nhấn nút "X"
  closeAdminModalBtn.addEventListener("click", () => {
    adminAccountModal.style.display = "none";
  });

  // Đóng modal khi nhấn ra ngoài
  window.addEventListener("click", (e) => {
    if (e.target == adminAccountModal) {
      adminAccountModal.style.display = "none";
    }
  });

  // Xử lý khi nhấn nút "Sửa"
  const editAdminButtons = document.querySelectorAll(
    ".bottom-data .orders .action-btn.edit"
  );
  editAdminButtons.forEach((btn) => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      modalAdminTitle.innerText = "Chỉnh sửa Tài khoản Admin";
      passwordInput.placeholder = "Để trống nếu không muốn thay đổi";

      // (Logic để điền dữ liệu cũ vào form sẽ ở đây)
      // Ví dụ:
      // const row = btn.closest('tr');
      // document.getElementById('adminName').value = row.children[0].innerText;
      // document.getElementById('adminEmail').value = row.children[1].innerText;
      // ... (Chọn đúng <option> cho vai trò và trạng thái)

      adminAccountModal.style.display = "block";
    });
  });
}


/* =================================== */
/* === SCRIPT CHO TRANG CÀI ĐẶT (TABS) === */
/* =================================== */

// Chỉ chạy nếu chúng ta đang ở trang Settings
const settingsTabs = document.querySelectorAll(".settings-container .tab-link");
const settingsPanes = document.querySelectorAll(
  ".settings-content .tab-pane"
);

if (settingsTabs.length > 0) {
  settingsTabs.forEach((tab) => {
    tab.addEventListener("click", (e) => {
      e.preventDefault(); // Ngăn hành vi default của thẻ <a>

      const tabId = tab.dataset.tab; // Lấy data-tab (ví dụ: "general")

      // 1. Xóa class 'active' khỏi tất cả các tab link
      settingsTabs.forEach((t) => t.classList.remove("active"));
      // 2. Thêm class 'active' vào tab vừa click
      tab.classList.add("active");

      // 3. Ẩn tất cả các tab-pane
      settingsPanes.forEach((pane) => pane.classList.remove("active"));
      // 4. Hiển thị tab-pane tương ứng
      const activePane = document.getElementById(tabId);
      if (activePane) {
        activePane.classList.add("active");
      }
    });
  });
}





/* =================================== */
/* === SCRIPT CHO NOTIFICATION DROPDOWN === */
/* =================================== */

// Lấy các phần tử
const notifBtn = document.getElementById("notifBtn");
const notifDropdown = document.getElementById("notifDropdown");

if (notifBtn && notifDropdown) {
  // Bật/Tắt khi nhấn vào chuông
  notifBtn.addEventListener("click", (e) => {
    e.preventDefault();
    notifDropdown.classList.toggle("show");
  });

  // Tắt khi nhấn ra ngoài
  window.addEventListener("click", (e) => {
    // Kiểm tra xem có nhấn vào nút chuông hoặc vào dropdown không
    if (
      !notifBtn.contains(e.target) &&
      !notifDropdown.contains(e.target)
    ) {
      notifDropdown.classList.remove("show");
    }
  });
}



/* =================================== */
/* === SCRIPT TRANG SỬA SẢN PHẨM === */
/* =================================== */

// Chỉ chạy nếu chúng ta ở trang product-edit
const productForm = document.getElementById("productForm");

if (productForm) {
  // Lấy ID từ URL (nếu là "Sửa")
  const urlParams = new URLSearchParams(window.location.search);
  const productId = urlParams.get("id");

  // Lấy các element tiêu đề
  const pageTitle = document.getElementById("pageTitle");
  const breadcrumbTitle = document.getElementById("breadcrumbTitle");

  if (productId) {
    // Đây là trang "Sửa"
    pageTitle.innerText = "Chỉnh sửa sản phẩm";
    breadcrumbTitle.innerText = "Sửa";
    // (Bạn sẽ cần code để tải dữ liệu sản phẩm `productId` và điền vào form)
  } else {
    // Đây là trang "Thêm mới"
    pageTitle.innerText = "Thêm sản phẩm mới";
    breadcrumbTitle.innerText = "Thêm mới";
  }

  // Xử lý link "Lên lịch khuyến mãi"
  const scheduleLink = document.getElementById("scheduleSaleLink");
  const scheduleFields = document.querySelector(
    ".product-edit__schedule-fields"
  );
  
  if(scheduleLink) {
    scheduleLink.addEventListener("click", (e) => {
      e.preventDefault();
      if (scheduleFields.style.display === "none") {
        scheduleFields.style.display = "block";
        scheduleLink.innerText = "- Ẩn lịch";
      } else {
        scheduleFields.style.display = "none";
        scheduleLink.innerText = "+ Lên lịch khuyến mãi";
      }
    });
  }

  // (Thêm code xử lý upload ảnh, v.v...)
}




/* =================================== */
/* === SCRIPT CHO PROFILE DROPDOWN === */
/* =================================== */

// Lấy các phần tử
const profileBtn = document.getElementById("profileBtn");
const profileDropdown = document.getElementById("profileDropdown");

if (profileBtn && profileDropdown) {
  // Bật/Tắt khi nhấn vào ảnh
  profileBtn.addEventListener("click", (e) => {
    e.preventDefault();
    profileDropdown.classList.toggle("show");
  });

  // Tắt khi nhấn ra ngoài
  window.addEventListener("click", (e) => {
    // Kiểm tra xem có nhấn vào nút profile hoặc vào dropdown không
    if (
      !profileBtn.contains(e.target) &&
      !profileDropdown.contains(e.target)
    ) {
      profileDropdown.classList.remove("show");
    }
  });
}