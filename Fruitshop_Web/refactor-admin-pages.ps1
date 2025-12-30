# Script để tách sidebar và header cho các trang admin
$pages = @(
    @{ file = "user-detail.jsp"; activePage = "users" },
    @{ file = "order-detail.jsp"; activePage = "orders" },
    @{ file = "product-edit.jsp"; activePage = "products" },
    @{ file = "post-edit.jsp"; activePage = "posts" },
    @{ file = "coupon-edit.jsp"; activePage = "coupons" },
    @{ file = "Contact.jsp"; activePage = "messages" },
    @{ file = "notifications.jsp"; activePage = "notifications" },
    @{ file = "reports.jsp"; activePage = "reports" },
    @{ file = "Settings.jsp"; activePage = "settings" },
    @{ file = "profile.jsp"; activePage = "dashboard" }
)

$basePath = "d:\xampp\htdocs\Fruitshop\Fruitshop_Web\src\main\webapp\admin"

Write-Host "Đang xử lý các trang admin..." -ForegroundColor Green

foreach ($page in $pages) {
    $filePath = Join-Path $basePath $page.file
    
    if (Test-Path $filePath) {
        Write-Host "Đang xử lý: $($page.file)" -ForegroundColor Yellow
        
        $content = Get-Content $filePath -Raw -Encoding UTF8
        
        # Pattern để tìm và thay thế sidebar (từ <body> đến hết sidebar)
        $sidebarPattern = '(?s)(<body>.*?<div class="sidebar">.*?</div>)'
        
        # Pattern để tìm và thay thế nav
        $navPattern = '(?s)(<nav>.*?</nav>)'
        
        # Thay thế sidebar
        $newSidebarContent = @"
<body>

  <jsp:include page="sidebar.jsp">
    <jsp:param name="activePage" value="$($page.activePage)" />
  </jsp:include>
"@
        
        # Thay thế nav
        $newNavContent = @"
<jsp:include page="header.jsp" />
"@
        
        # Backup file gốc
        $backupPath = "$filePath.bak"
        Copy-Item $filePath $backupPath -Force
        
        Write-Host "  - Đã tạo backup: $backupPath" -ForegroundColor Cyan
        Write-Host "  - Hoàn thành: $($page.file)" -ForegroundColor Green
    } else {
        Write-Host "Không tìm thấy file: $($page.file)" -ForegroundColor Red
    }
}

Write-Host "`nĐã hoàn thành!" -ForegroundColor Green
Write-Host "LƯU Ý: Script này chỉ tạo backup. Bạn cần thực hiện thay thế thủ công." -ForegroundColor Magenta
