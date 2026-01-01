const replyModal = document.getElementById("replyModal");
const replyUserSpan = document.getElementById("replyUser");
const replyProductSpan = document.getElementById("replyProduct");
const replyIdInput = document.getElementById("replyReviewId");
const replyTextarea = document.getElementById("replyText");

/**
 * Hàm mở Modal trả lời
 * Được gọi từ sự kiện onclick ở nút "Trả lời" trong file JSP
 * @param {string} reviewId - ID của đánh giá
 * @param {string} userName - Tên khách hàng
 * @param {string} productName - Tên sản phẩm
 */
function openReplyModal(reviewId, userName, productName) {
    if (replyModal) {
        // Điền dữ liệu vào Modal
        replyUserSpan.innerText = userName;
        replyProductSpan.innerText = productName;
        replyIdInput.value = reviewId;

        // Reset nội dung textarea (hoặc có thể fetch nội dung cũ nếu muốn sửa)
        replyTextarea.value = "";

        // Hiển thị Modal
        replyModal.style.display = "block";

        replyTextarea.focus();
    }
}

/**
 * Hàm đóng Modal
 */
function closeReplyModal() {
    if (replyModal) {
        replyModal.style.display = "none";
    }
}
document.addEventListener("DOMContentLoaded", () => {

    // Xử lý đóng Modal khi click ra vùng ngoài
    window.addEventListener("click", (e) => {
        if (e.target == replyModal) {
            closeReplyModal();
        }
    });

    // Xử lý logic validate form trước khi gửi
    const replyForm = document.querySelector("form[action='review-action']");
    if (replyForm) {
        replyForm.addEventListener("submit", (e) => {
            const content = replyTextarea.value.trim();
            if (content === "") {
                e.preventDefault(); // Chặn gửi nếu rỗng
                alert("Vui lòng nhập nội dung trả lời!");
                replyTextarea.focus();
            }
        });
    }
});