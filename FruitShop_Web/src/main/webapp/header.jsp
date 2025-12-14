
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Organic Harvest</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/profile.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/orders.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order-history-detail.css" />

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/auth.css" />
</head>

<body>
<!-- HEADER -->
<header class="header">
    <nav class="navbar">
        <div class="navbar__wrapper">
            <div class="navbar__content">
                <ul class="navbar-list">
                    <li class="navbar-item navbar-item--no-click">
                        Kết nối :
                        <a href="#" class="navbar-icon__link">
                            <i class="navbar-icon fa-brands fa-facebook"></i>
                        </a>
                        <a href="#" class="navbar-icon__link">
                            <i class="navbar-icon fa-brands fa-instagram"></i>
                        </a>
                    </li>
                </ul>
                <ul class="navbar-list">
                    <li class="navbar-item">
                        <a href="${pageContext.request.contextPath}faqs.jsp" class="navbar-item__link">
                <span class="navbar-icon__link">
                  <i class="navbar-icon fa-regular fa-circle-question"></i>
                </span>
                            Hỗ trợ
                        </a>
                    </li>
                    <li class="navbar-item">
                        <a href="${pageContext.request.contextPath}register.jsp" class="navbar-item__link">Đăng ký</a>
                    </li>
                    <li class="navbar-item">
                        <a href="${pageContext.request.contextPath}login.jsp" class="navbar-item__link">Đăng nhập</a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="navbar__menu">
            <div class="navbar__menu-inner">
                <div class="navbar__menu-logo">
                    <a href="${pageContext.request.contextPath}/index.jsp">
                        <img class="navbar__menu-logo-img"
                             src="https://ik.imagekit.io/8tm3umulk/image/logonew_fG_70DXF8?updatedAt=1762866381508"
                             alt="Organic Harvest Logo" />
                    </a>
                </div>

                <ul class="main-nav-links subnav-links">
                    <li><a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
                    <li><a href="${pageContext.request.contextPath}/shop.jsp">Sản Phẩm</a></li>
                    <li><a href="${pageContext.request.contextPath}/about.jsp">Giới thiệu</a></li>
                    <li><a href="${pageContext.request.contextPath}/blog.jsp">Bài viết</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.jsp">Liên hệ</a></li>
                </ul>

                <div class="navbar__menu-search">
                    <form class="search-form" action="/shop.jsp" method="get" role="search">
                        <select name="category" class="search-cat" aria-label="Category">
                            <option value="all">Danh mục</option>
                            <option value="fruits">Trái cây</option>
                            <option value="vegetables">táo</option>
                        </select>
                        <input name="q" class="search-input" type="search" placeholder="Tìm kiếm sản phẩm..."
                               aria-label="Search" />
                        <button type="submit" class="search-btn" aria-label="Search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                </div>

                <div class="navbar__menu-actions">
                    <a href="${pageContext.request.contextPath}/wishlist.jsp" class="icon-btn wishlist-btn" title="Yêu thích">
                        <i class="fa-solid fa-heart"></i>
                        <span class="badge">3</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/cart.jsp" class="icon-btn cart-btn" title="Giỏ hàng">
                        <i class="fa-solid fa-basket-shopping"></i>
                        <span class="badge">2</span>
                    </a>
                    <div class="header__account">
                        <a class="icon-btn account-btn" title="Tài khoản">
                            <i class="fa-regular fa-user"></i>
                        </a>

                        <div class="account-dropdown">
                            <div class="account-user">
                                <div class="user-info">
                                    <img src="https://via.placeholder.com/100" alt="User Avatar" class="user-avatar" />
                                    <div class="user-details">
                                        <span class="user-name">Nguyễn Văn A</span>
                                        <span class="user-email">nguyenvana@gmail.com</span>
                                    </div>
                                </div>

                                <ul class="account-menu">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/profile.jsp">
                                            <i class="fa-regular fa-id-card"></i> Hồ sơ của tôi
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/orders.jsp">
                                            <i class="fa-solid fa-box-open"></i> Đơn mua
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/wishlist.jsp">
                                            <i class="fa-regular fa-heart"></i> Sản phẩm yêu thích
                                        </a>
                                    </li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/change-password.jsp">
                                            <i class="fa-solid fa-key"></i> Đổi mật khẩu
                                        </a>
                                    </li>

                                    <li class="border-top">
                                        <a href="#" class="text-danger">
                                            <i class="fa-solid fa-arrow-right-from-bracket"></i>
                                            Đăng xuất
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</header>


