// assets/js/admin/coupon.js
document.addEventListener("DOMContentLoaded", () => {
  const urlParams = new URLSearchParams(window.location.search);
  const couponId = urlParams.get("id");
  
  // Nếu có ID trên URL -> Chế độ Sửa
  if (couponId) {
    document.querySelector(".header .left h1").innerText = "Cập nhật mã giảm giá";
    document.querySelector(".breadcrumb .active").innerText = "Cập nhật";
    // Tại đây bạn sẽ gọi API để lấy dữ liệu mã giảm giá cũ và điền vào form
  }
});