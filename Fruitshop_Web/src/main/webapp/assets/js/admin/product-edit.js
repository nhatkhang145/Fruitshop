// Dán vào file: product-edit.js
document.addEventListener("DOMContentLoaded", () => {
  const productForm = document.getElementById("productForm");
  if (!productForm) return; // Thoát nếu không phải trang này

  const urlParams = new URLSearchParams(window.location.search);
  const productId = urlParams.get("id");
  const pageTitle = document.getElementById("pageTitle");
  const breadcrumbTitle = document.getElementById("breadcrumbTitle");

  if (productId) {
    pageTitle.innerText = "Chỉnh sửa sản phẩm";
    breadcrumbTitle.innerText = "Sửa";
    // (Code tải dữ liệu sản phẩm...)
  } else {
    pageTitle.innerText = "Thêm sản phẩm mới";
    breadcrumbTitle.innerText = "Thêm mới";
  }

  const scheduleLink = document.getElementById("scheduleSaleLink");
  const scheduleFields = document.querySelector(".product-edit__schedule-fields");
  if (scheduleLink) {
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
});