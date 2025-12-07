/* === SCRIPT TRANG CHI TIẾT ĐƠN HÀNG (order-detail.html) === */
document.addEventListener("DOMContentLoaded", () => {
  // Chỉ chạy nếu chúng ta ở trang order-detail
  const orderDetailForm = document.getElementById("orderDetailForm");
  
  if (orderDetailForm) {
    const urlParams = new URLSearchParams(window.location.search);
    const orderId = urlParams.get("id");

    if (orderId) {
      // Cập nhật tiêu đề
      const pageTitle = document.getElementById("pageTitle");
      const breadcrumbTitle = document.getElementById("breadcrumbTitle");
      
      if(pageTitle) pageTitle.innerText = `Chi tiết Đơn hàng #${orderId}`;
      if(breadcrumbTitle) breadcrumbTitle.innerText = `#${orderId}`;
      
      // (Trong tương lai, bạn sẽ dùng fetch(API_URL + orderId) ở đây
      // để tải dữ liệu thật và điền vào form)
    }
  }
});