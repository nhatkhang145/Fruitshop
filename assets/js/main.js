// js cho navbar
(function () {
  function ready(fn) {
    if (document.readyState !== "loading") fn();
    else document.addEventListener("DOMContentLoaded", fn);
  }

  function debounce(fn, wait) {
    var t;
    return function () {
      var ctx = this,
        args = arguments;
      clearTimeout(t);
      t = setTimeout(function () {
        fn.apply(ctx, args);
      }, wait);
    };
  }

  // Track scroll direction and speed
  var lastScrollTop = 0;
  var scrollSpeed = 0;
  var lastScrollTime = Date.now();

  ready(function () {
    var menu = document.querySelector(".navbar__menu");
    var subnav = document.querySelector(".navbar__subnav");
    var wrapper = document.querySelector(".navbar__wrapper");
    if (!menu) return;

    // show the navbar with slide-in animation
    requestAnimationFrame(function () {
      menu.classList.add("visible");
    });

    // handle scroll direction and speed
    function handleScroll() {
      var st = window.scrollY;
      var now = Date.now();
      var timeDiff = now - lastScrollTime;

      // Calculate scroll speed (pixels per millisecond)
      if (timeDiff > 0) {
        scrollSpeed = Math.abs(st - lastScrollTop) / timeDiff;
      }

      // Determine scroll direction and apply classes
      if (st > 50) {
        // Only start hiding when scrolled a bit
        var scrollingDown = st > lastScrollTop;

        // Add shadow to menu when scrolled
        menu.classList.add("scrolled");

        // Hide everything when scrolling down fast enough
        if (scrollingDown && scrollSpeed > 0.5) {
          wrapper.classList.add("hidden");
          subnav.classList.add("hidden");
          document.body.classList.add("subnav-hidden");
          menu.classList.remove("visible");
        }
        // Show menu (only) when scrolling up
        else if (!scrollingDown) {
          wrapper.classList.add("hidden");
          subnav.classList.add("hidden");
          document.body.classList.add("subnav-hidden");
          menu.classList.add("visible");
        }
      } else {
        // At top - show everything
        menu.classList.remove("scrolled");
        wrapper.classList.remove("hidden");
        subnav.classList.remove("hidden");
        document.body.classList.remove("subnav-hidden");
        menu.classList.add("visible");
      }

      lastScrollTop = st;
      lastScrollTime = now;
    }

    var debounced = debounce(handleScroll, 30);
    window.addEventListener("scroll", handleScroll, { passive: true });
    // initial check
    handleScroll();
  });
})();

// slider chính
let currentSlide = 0;
const totalSlides = 5;
const slideWrapper = document.querySelector(".slide-wrapper");
const dots = document.querySelectorAll(".indicator-dot");

// Hàm cập nhật vị trí slide
function updateSlide() {
  slideWrapper.style.transform = `translateX(-${currentSlide * 100}%)`;

  // Cập nhật dots
  dots.forEach((dot, index) => {
    dot.classList.toggle("active", index === currentSlide);
  });
}

// Chuyển sang slide tiếp theo
function nextSlide() {
  currentSlide = (currentSlide + 1) % totalSlides;
  updateSlide();
}

// Chuyển về slide trước
function prevSlide() {
  currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
  updateSlide();
}

// Đi đến slide cụ thể
function goToSlide(index) {
  currentSlide = index;
  updateSlide();
}

// Tự động chuyển slide sau 5 giây
let autoSlide = setInterval(nextSlide, 5000);

// Dừng auto-slide khi hover vào slider
const slideContainer = document.querySelector(".slide-container");
slideContainer.addEventListener("mouseenter", () => {
  clearInterval(autoSlide);
});

// Tiếp tục auto-slide khi rời khỏi slider
slideContainer.addEventListener("mouseleave", () => {
  autoSlide = setInterval(nextSlide, 5000);
});

// Hỗ trợ phím mũi tên
document.addEventListener("keydown", (e) => {
  if (e.key === "ArrowLeft") {
    prevSlide();
  } else if (e.key === "ArrowRight") {
    nextSlide();
  }
});

// Hỗ trợ touch swipe trên mobile
let touchStartX = 0;
let touchEndX = 0;

slideContainer.addEventListener("touchstart", (e) => {
  touchStartX = e.changedTouches[0].screenX;
});

slideContainer.addEventListener("touchend", (e) => {
  touchEndX = e.changedTouches[0].screenX;
  handleSwipe();
});

function handleSwipe() {
  if (touchStartX - touchEndX > 50) {
    nextSlide();
  }
  if (touchEndX - touchStartX > 50) {
    prevSlide();
  }
}



// -----------------------------------
// js cho offers carousel
document.addEventListener('DOMContentLoaded', function() {
    const container = document.querySelector('.carousel-container');
    const prevBtn = document.querySelector('.arrow.prev');
    const nextBtn = document.querySelector('.arrow.next');
    let currentPosition = 0;
    let products = [];

    // Khởi tạo carousel
    function initCarousel() {
        // Lấy tất cả product cards
        products = Array.from(container.querySelectorAll('.product-card'));
        
        // Ẩn các sản phẩm ngoài viewport ban đầu (từ index 4 trở đi)
        products.forEach((product, index) => {
            if (index >= 4) {
                product.style.display = 'none';
            }
        });

        // Disable nút prev ban đầu
        updateNavigationButtons();
    }

    // Cập nhật trạng thái các nút điều hướng
    function updateNavigationButtons() {
        prevBtn.disabled = currentPosition === 0;
        nextBtn.disabled = currentPosition >= products.length - 4;
    }

    // Xử lý khi click nút next
    function handleNext() {
        if (currentPosition < products.length - 4) {
            // Ẩn sản phẩm đầu tiên của view hiện tại
            products[currentPosition].style.display = 'none';
            
            // Hiện sản phẩm tiếp theo
            products[currentPosition + 4].style.display = '';
            
            currentPosition++;
            updateNavigationButtons();
        }
    }

    // Xử lý khi click nút previous
    function handlePrev() {
        if (currentPosition > 0) {
            // Hiện lại sản phẩm trước đó
            products[currentPosition - 1].style.display = '';
            
            // Ẩn sản phẩm cuối của view hiện tại
            products[currentPosition + 3].style.display = 'none';
            
            currentPosition--;
            updateNavigationButtons();
        }
    }

    // Thêm event listeners
    nextBtn.addEventListener('click', handleNext);
    prevBtn.addEventListener('click', handlePrev);

    // Khởi tạo carousel khi trang load xong
    initCarousel();
});

// ----------------------------------------------

