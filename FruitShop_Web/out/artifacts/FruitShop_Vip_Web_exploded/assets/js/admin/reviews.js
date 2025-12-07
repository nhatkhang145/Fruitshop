document.addEventListener("DOMContentLoaded", () => {
  // 1. Xử lý Modal Trả lời
  const replyModal = document.getElementById("replyModal");
  const replyButtons = document.querySelectorAll(".reply-trigger");
  const closeBtn = replyModal.querySelector(".close-btn");
  const replyForm = document.getElementById("replyForm");
  const originalReviewBox = replyModal.querySelector(".original-review");

  if (replyModal && replyButtons) {
    // Mở modal khi bấm nút Reply
    replyButtons.forEach(btn => {
      btn.addEventListener("click", (e) => {
        e.preventDefault();
        
        // Lấy nội dung comment từ dòng tương ứng để hiện trong modal
        const row = btn.closest("tr");
        const commentText = row.querySelector(".comment").innerText;
        originalReviewBox.innerText = commentText;

        replyModal.style.display = "block";
      });
    });

    // Đóng modal
    closeBtn.addEventListener("click", () => {
      replyModal.style.display = "none";
    });

    window.addEventListener("click", (e) => {
      if (e.target == replyModal) {
        replyModal.style.display = "none";
      }
    });

    // Xử lý submit form (Giả lập)
    replyForm.addEventListener("submit", (e) => {
      e.preventDefault();
      alert("Đã gửi câu trả lời thành công!");
      replyModal.style.display = "none";
      replyForm.reset();
    });
  }

  // 2. Xử lý nút Duyệt / Ẩn / Xóa (Giả lập)
  const actionButtons = document.querySelectorAll(".action-btn");
  actionButtons.forEach(btn => {
    btn.addEventListener("click", (e) => {
      if (btn.classList.contains("approve")) {
        if(confirm("Duyệt đánh giá này?")) {
            // Logic gọi API duyệt
            // Đổi UI:
            const statusSpan = btn.closest("tr").querySelector(".status");
            statusSpan.className = "status completed";
            statusSpan.innerText = "Đã duyệt";
        }
      } else if (btn.classList.contains("hide")) {
        if(confirm("Ẩn đánh giá này khỏi trang web?")) {
             const statusSpan = btn.closest("tr").querySelector(".status");
             statusSpan.className = "status hidden";
             statusSpan.innerText = "Đã ẩn";
        }
      } else if (btn.classList.contains("delete")) {
        if(confirm("Bạn có chắc chắn muốn XÓA VĨNH VIỄN đánh giá này?")) {
            btn.closest("tr").remove();
        }
      }
    });
  });
});