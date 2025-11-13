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
