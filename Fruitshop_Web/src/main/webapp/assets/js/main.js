// // ================================
//         // STICKY MENU ON SCROLL
//         // ================================
//         const header = document.querySelector('.header');
//         const navbarMenu = document.querySelector('.navbar__menu');
//         const menuPlaceholder = document.querySelector('.menu-placeholder');
        
//         // Lấy vị trí ban đầu của menu
//         const menuOffsetTop = navbarMenu.offsetTop;
        
//         // Ngưỡng scroll để kích hoạt sticky (có thể điều chỉnh)
//         const scrollThreshold = 150; // 150px
        
//         let isSticky = false;
        
//         window.addEventListener('scroll', () => {
//             const scrollPosition = window.scrollY;
            
//             // Khi scroll vượt qua ngưỡng
//             if (scrollPosition > scrollThreshold && !isSticky) {
//                 // Kích hoạt sticky menu
//                 navbarMenu.classList.add('sticky');
//                 menuPlaceholder.classList.add('active');
//                 isSticky = true;
                
//                 // Log để debug (có thể xóa sau)
//                 console.log('Menu is now sticky');
//             } 
//             // Khi scroll lên trên ngưỡng
//             else if (scrollPosition <= scrollThreshold && isSticky) {
//                 // Hủy sticky menu
//                 navbarMenu.classList.remove('sticky');
//                 menuPlaceholder.classList.remove('active');
//                 isSticky = false;
                
//                 console.log('Menu is back to normal');
//             }
//         });

//         // ================================
//         // SEARCH FORM ANIMATION
//         // ================================
//         const searchInput = document.querySelector('.search-input');
//         const searchBtn = document.querySelector('.search-btn');
        
//         searchInput.addEventListener('focus', () => {
//             searchBtn.style.transform = 'scale(1.05)';
//         });
        
//         searchInput.addEventListener('blur', () => {
//             searchBtn.style.transform = 'scale(1)';
//         });

//         // ================================
//         // UPDATE BADGE FUNCTION
//         // ================================
//         function updateBadge(selector, count) {
//             const badge = document.querySelector(selector);
//             if (badge) {
//                 badge.textContent = count;
//                 badge.style.animation = 'pulse 0.5s ease-in-out';
//                 setTimeout(() => {
//                     badge.style.animation = '';
//                 }, 500);
//             }
//         }

//         // ================================
//         // DEMO: UPDATE BADGES ON CLICK
//         // ================================
//         document.querySelector('.wishlist-btn').addEventListener('click', (e) => {
//             e.preventDefault();
//             const currentCount = parseInt(document.querySelector('.wishlist-btn .badge').textContent);
//             updateBadge('.wishlist-btn .badge', currentCount + 1);
//         });

//         document.querySelector('.cart-btn').addEventListener('click', (e) => {
//             e.preventDefault();
//             const currentCount = parseInt(document.querySelector('.cart-btn .badge').textContent);
//             updateBadge('.cart-btn .badge', currentCount + 1);
//         });

//         // ================================
//         // SMOOTH SCROLL FOR NAVIGATION
//         // ================================
//         document.querySelectorAll('.main-nav-links a').forEach(link => {
//             link.addEventListener('click', (e) => {
//                 // Chỉ áp dụng smooth scroll nếu link có href bắt đầu bằng #
//                 if (link.getAttribute('href').startsWith('#')) {
//                     e.preventDefault();
//                     const targetId = link.getAttribute('href');
//                     const targetElement = document.querySelector(targetId);
                    
//                     if (targetElement) {
//                         const offsetTop = targetElement.offsetTop - 100; // Trừ đi chiều cao menu
//                         window.scrollTo({
//                             top: offsetTop,
//                             behavior: 'smooth'
//                         });
//                     }
//                 }
//             });
//         });

//         // ================================
//         // SCROLL TO TOP WHEN CLICK LOGO
//         // ================================
//         document.querySelector('.navbar__menu-logo a').addEventListener('click', (e) => {
//             if (window.scrollY > 0) {
//                 e.preventDefault();
//                 window.scrollTo({
//                     top: 0,
//                     behavior: 'smooth'
//                 });
//             }
//         });

//         // ================================
//         // SHOW/HIDE SCROLL PROGRESS (Optional)
//         // ================================
//         function updateScrollProgress() {
//             const windowHeight = window.innerHeight;
//             const documentHeight = document.documentElement.scrollHeight;
//             const scrollTop = window.scrollY;
//             const scrollPercent = (scrollTop / (documentHeight - windowHeight)) * 100;
            
//             // Có thể sử dụng để tạo progress bar
//             // document.querySelector('.scroll-progress').style.width = scrollPercent + '%';
//         }

//         window.addEventListener('scroll', updateScrollProgress);

//         // ================================
//         // INITIALIZATION
//         // ================================
//         console.log('Header JavaScript initialized');
//         console.log('Scroll threshold:', scrollThreshold + 'px');
// =================================================================================================================================
// slider chính
document.addEventListener('DOMContentLoaded', function() {
  let currentSlide = 0;
  const slideWrapper = document.querySelector(".slide-wrapper");
  const slides = document.querySelectorAll(".slide-item");
  const totalSlides = slides.length;
  const dots = document.querySelectorAll(".indicator-dot");
  const prevButton = document.querySelector(".prev-button");
  const nextButton = document.querySelector(".next-button");
  const slideContainer = document.querySelector(".slide-container");
  const slideIndicators = document.querySelector('.slide-indicators');

  // Kiểm tra xem có slideWrapper không
  if (!slideWrapper || !slideContainer) {
    console.log('Slider elements not found');
    return;
  }

  console.log('Total slides:', totalSlides);

  // Ẩn controls nếu chỉ có 1 slide
  if (totalSlides <= 1) {
    if (prevButton) prevButton.style.display = 'none';
    if (nextButton) nextButton.style.display = 'none';
    if (slideIndicators) slideIndicators.style.display = 'none';
    console.log('Only 1 slide, controls hidden');
    return; // Không cần chạy code slider nếu chỉ có 1 slide
  }

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
  window.goToSlide = function(index) {
    currentSlide = index;
    updateSlide();
  }

  // Tự động chuyển slide sau 5 giây
  let autoSlide = setInterval(nextSlide, 5000);
  console.log('Auto-slide started');

  // Dừng auto-slide khi hover vào slider
  slideContainer.addEventListener("mouseenter", () => {
    clearInterval(autoSlide);
    console.log('Auto-slide paused');
  });

  // Tiếp tục auto-slide khi rời khỏi slider
  slideContainer.addEventListener("mouseleave", () => {
    autoSlide = setInterval(nextSlide, 5000);
    console.log('Auto-slide resumed');
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

  // Xử lý click nút prev/next
  if (prevButton) {
    prevButton.addEventListener('click', prevSlide);
  }
  if (nextButton) {
    nextButton.addEventListener('click', nextSlide);
  }
});



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
// Xử lý button "Yêu thích"
document.addEventListener('DOMContentLoaded', function() {
    // Lấy tất cả button/link yêu thích
    const wishlistButtons = document.querySelectorAll('.action-btn[href*="wishlist"]');
    
    wishlistButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            
            const url = new URL(this.href);
            const action = url.searchParams.get('action');
            const productId = url.searchParams.get('pid');
            
            if (!productId) {
                alert('Không tìm thấy ID sản phẩm');
                return;
            }
            
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
            const requestUrl = `${contextPath}/wishlist?action=${action}&pid=${productId}`;
            
            fetch(requestUrl, {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Cập nhật icon trái tim
                    const icon = this.querySelector('i');
                    if (data.action === 'added') {
                        icon.className = 'fas fa-heart';
                        icon.style.color = 'red';
                        this.title = 'Bỏ yêu thích';
                        // Cập nhật href để lần click sau sẽ remove
                        url.searchParams.set('action', 'remove');
                        this.href = url.toString();
                        showNotification('Đã thêm vào danh sách yêu thích!', 'success');
                    } else {
                        icon.className = 'far fa-heart';
                        icon.style.color = '';
                        this.title = 'Thêm vào yêu thích';
                        // Cập nhật href để lần click sau sẽ add
                        url.searchParams.set('action', 'add');
                        this.href = url.toString();
                        showNotification('Đã bỏ khỏi danh sách yêu thích!', 'success');
                    }
                    
                    // Cập nhật badge wishlist
                    const wishlistBadge = document.querySelector('.wishlist-btn .badge');
                    if (wishlistBadge) {
                        wishlistBadge.textContent = data.count;
                        wishlistBadge.style.animation = 'pulse 0.5s ease-in-out';
                        setTimeout(() => {
                            wishlistBadge.style.animation = '';
                        }, 500);
                    }
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Vui lòng đăng nhập để sử dụng chức năng này!', 'error');
            });
        });
    });
});

// ----------------------------------------------
// Xử lý button "Thêm vào giỏ hàng"
document.addEventListener('DOMContentLoaded', function() {
    // Lấy tất cả button "Thêm vào giỏ hàng"
    const addToCartButtons = document.querySelectorAll('.add-to-cart-btn');
    
    addToCartButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            
            const productId = this.getAttribute('data-id');
            
            if (!productId) {
                alert('Không tìm thấy ID sản phẩm');
                return;
            }
            
            // Gửi request AJAX để thêm vào giỏ hàng
            const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
            const url = `${contextPath}/add-to-cart?pid=${productId}&quantity=1`;
            
            fetch(url, {
                method: 'GET',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(response => {
                if (response.ok) {
                    // Cập nhật badge giỏ hàng
                    const cartBadge = document.querySelector('.cart-btn .badge');
                    if (cartBadge) {
                        const currentCount = parseInt(cartBadge.textContent) || 0;
                        cartBadge.textContent = currentCount + 1;
                        
                        // Hiệu ứng animation
                        cartBadge.style.animation = 'pulse 0.5s ease-in-out';
                        setTimeout(() => {
                            cartBadge.style.animation = '';
                        }, 500);
                    }
                    
                    // Hiển thị thông báo thành công
                    showNotification('Đã thêm sản phẩm vào giỏ hàng!', 'success');
                } else {
                    showNotification('Có lỗi xảy ra, vui lòng thử lại!', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Có lỗi xảy ra, vui lòng thử lại!', 'error');
            });
        });
    });
});

// Hàm hiển thị thông báo
function showNotification(message, type) {
    // Tạo element thông báo
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 80px;
        right: 20px;
        background: ${type === 'success' ? '#4CAF50' : '#f44336'};
        color: white;
        padding: 15px 25px;
        border-radius: 5px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.2);
        z-index: 9999;
        animation: slideIn 0.3s ease-out;
    `;
    
    document.body.appendChild(notification);
    
    // Tự động xóa sau 3 giây
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease-out';
        setTimeout(() => {
            document.body.removeChild(notification);
        }, 300);
    }, 3000);
}

// Thêm CSS animation cho notification
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(400px);
            opacity: 0;
        }
    }
    
    @keyframes pulse {
        0%, 100% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.2);
        }
    }
`;
document.head.appendChild(style);
