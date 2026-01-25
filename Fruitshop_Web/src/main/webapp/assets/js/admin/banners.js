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
            // Re-attach click handlers sau khi DataTables re-draw
            attachEditHandlers();
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
    
    // 3. Khởi tạo link type change handler
    handleLinkTypeChange();
    
    // 4. Attach edit button handlers
    attachEditHandlers();
});

// =========================================
// ATTACH EVENT HANDLERS CHO BUTTON EDIT
// =========================================
function attachEditHandlers() {
    $('.action-btn.edit').off('click').on('click', function(e) {
        e.preventDefault();
        
        const id = $(this).data('id');
        const title = $(this).data('title');
        const desc = $(this).data('desc');
        const link = $(this).data('link');
        const linkType = $(this).data('linktype');
        const linkTarget = $(this).data('linktarget');
        const order = $(this).data('order');
        const status = $(this).data('status');
        const imgUrl = $(this).data('img');
        const imageUrl = $(this).data('imageurl');
        
        openEditModal(id, title, desc, link, linkType, linkTarget, order, status, imgUrl, imageUrl);
    });
}

// =========================================
// XỬ LÝ THAY ĐỔI LOẠI LINK
// =========================================
function handleLinkTypeChange() {
    const linkType = document.getElementById('linkType').value;
    const linkTargetGroup = document.getElementById('linkTargetGroup');
    const linkTargetLabel = document.getElementById('linkTargetLabel');
    const linkTargetInput = document.getElementById('linkTarget');
    const linkTargetHint = document.getElementById('linkTargetHint');
    
    if (linkType === 'none') {
        linkTargetGroup.style.display = 'none';
        linkTargetInput.required = false;
    } else {
        linkTargetGroup.style.display = 'block';
        linkTargetInput.required = true;
        
        switch(linkType) {
            case 'internal':
                linkTargetLabel.innerText = 'Đường dẫn nội bộ';
                linkTargetInput.placeholder = '/shop hoặc /about';
                linkTargetHint.innerText = 'Ví dụ: /shop, /contact, /blog';
                break;
            case 'product':
                linkTargetLabel.innerText = 'ID Sản phẩm';
                linkTargetInput.placeholder = '123';
                linkTargetHint.innerText = 'Nhập ID của sản phẩm (VD: 5, 12, 25)';
                break;
            case 'category':
                linkTargetLabel.innerText = 'ID Danh mục';
                linkTargetInput.placeholder = '5';
                linkTargetHint.innerText = 'Nhập ID của danh mục (VD: 1, 2, 3)';
                break;
            case 'external':
                linkTargetLabel.innerText = 'URL bên ngoài';
                linkTargetInput.placeholder = 'https://example.com';
                linkTargetHint.innerText = 'Nhập URL đầy đủ (bắt đầu với http:// hoặc https://)';
                break;
        }
    }
}

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
    
    // Reset link type về mặc định
    document.getElementById('linkType').value = 'none';
    handleLinkTypeChange();

    // Mặc định hiển thị
    document.getElementById("status").checked = true;

    // Ẩn preview ảnh cũ
    document.getElementById("imagePreview").style.display = "none";
    document.getElementById("previewImg").src = "";

    showModal();
}

// Mở Modal Sửa (Đổ dữ liệu cũ vào form)
// Lưu ý: imgUrl là đường dẫn ảnh có contextPath để hiển thị, imageUrl là đường dẫn thuần túy để lưu
function openEditModal(id, title, desc, link, linkType, linkTarget, order, status, imgUrl, imageUrl) {
    modalTitle.innerText = "Cập nhật Banner #" + id;
    formAction.value = "update";

    document.getElementById("bannerId").value = id;
    document.getElementById("title").value = title;
    document.getElementById("description").value = desc;
    document.getElementById("link").value = link || "";
    
    // Set linkType và linkTarget
    document.getElementById("linkType").value = linkType || "none";
    document.getElementById("linkTarget").value = linkTarget || "";
    handleLinkTypeChange();
    
    document.getElementById("displayOrder").value = order;
    document.getElementById("status").checked = (status == 1);

    // Xử lý ảnh cũ - lưu imageUrl thuần túy (không có contextPath)
    document.getElementById("oldImage").value = imageUrl || imgUrl;

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