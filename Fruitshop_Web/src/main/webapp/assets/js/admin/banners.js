$(document).ready(function() {
    // 1. Khởi tạo DataTables
    $('#bannerTable').DataTable({
        "pageLength": 5,
        "lengthMenu": [[5, 10, 25, -1], [5, 10, 25, "Tất cả"]],
        "language": {
            "search": "Tìm kiếm:",
            "lengthMenu": "Hiển thị _MENU_ mục",
            "info": "Hiển thị _START_ đến _END_ trong _TOTAL_ banner",
            "paginate": {
                "next": "<i class='bx bx-chevron-right'></i>",
                "previous": "<i class='bx bx-chevron-left'></i>"
            },
            "emptyTable": "Chưa có banner nào",
            "zeroRecords": "Không tìm thấy kết quả"
        },
        "drawCallback": function() {
            // Style lại nút phân trang sau khi bảng vẽ lại (nếu cần)
        }
    });

    // 2. Xử lý Xem trước ảnh khi chọn file (Preview Image)
    $('#imageInput').change(function() {
        const file = this.files[0];
        if (file) {
            let reader = new FileReader();
            reader.onload = function(event) {
                $('#previewImg').attr('src', event.target.result);
                $('#imagePreview').show();
            }
            reader.readAsDataURL(file);
        }
    });
});

// =========================================
// CÁC HÀM XỬ LÝ MODAL (POPUP)
// =========================================

const modal = document.getElementById("bannerModal");
const modalTitle = document.getElementById("modalTitle");
const formAction = document.getElementById("formAction");

// Mở Modal Thêm mới
function openAddModal() {
    document.getElementById("bannerForm").reset();

    modalTitle.innerText = "Thêm Banner Mới";
    formAction.value = "add";

    // Mặc định hiển thị
    document.getElementById("status").checked = true;

    // Ẩn preview ảnh cũ
    document.getElementById("imagePreview").style.display = "none";
    document.getElementById("previewImg").src = "";

    showModal();
}

// Mở Modal Sửa (Đổ dữ liệu cũ vào form)
// Lưu ý: imgUrl là đường dẫn ảnh
function openEditModal(id, title, desc, link, order, status, imgUrl) {
    modalTitle.innerText = "Cập nhật Banner #" + id;
    formAction.value = "update";

    document.getElementById("bannerId").value = id;
    document.getElementById("title").value = title;
    document.getElementById("description").value = desc;
    document.getElementById("link").value = link;
    document.getElementById("displayOrder").value = order;
    document.getElementById("status").checked = (status == 1);

    // Xử lý ảnh cũ
    document.getElementById("oldImage").value = imgUrl;

    // Hiển thị ảnh cũ để user biết
    const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 1));
    // Lưu ý: Logic lấy contextPath này có thể cần chỉnh tùy cấu hình server,
    // cách an toàn nhất là truyền full path từ JSP hoặc dùng relative path nếu ảnh nằm trong assets.
    // Ở đây ta giả định imgUrl đã đúng đường dẫn tương đối.

    let fullImgSrc = imgUrl;
    if(!imgUrl.startsWith("http") && !imgUrl.startsWith("/")) {
         // Nếu imgUrl là "assets/...", thêm "/" vào đầu để trỏ về root
         fullImgSrc =  "/" + contextPath.replace("/","") + "/" + imgUrl;
    }

    document.getElementById("previewImg").src = imgUrl; // JSTL đã xử lý path ở JSP, ở đây chỉ nhận string
    document.getElementById("imagePreview").style.display = "block";

    showModal();
}

// Hàm hiển thị Modal chung
function showModal() {
    modal.style.display = "block";
    // Thêm class show sau 10ms để có hiệu ứng transition
    setTimeout(() => {
        modal.classList.add("show");
    }, 10);
}

// Đóng Modal
function closeModal() {
    modal.classList.remove("show");
    setTimeout(() => {
        modal.style.display = "none";
    }, 300); // Chờ hiệu ứng mờ dần kết thúc
}

// Đóng khi click ra ngoài vùng modal
window.onclick = function(event) {
    if (event.target == modal) {
        closeModal();
    }
}