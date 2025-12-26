<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                                    <a href="${pageContext.request.contextPath}/faqs.jsp" class="navbar-item__link">
                                        <span class="navbar-icon__link">
                                            <i class="navbar-icon fa-regular fa-circle-question"></i>
                                        </span>
                                        Hỗ trợ
                                    </a>
                                </li>
                                <c:choose>
                                    <c:when test="${empty sessionScope.user}">
                                        <!-- Hiển thị khi chưa đăng nhập -->
                                        <li class="navbar-item">
                                            <a href="${pageContext.request.contextPath}/register.jsp"
                                                class="navbar-item__link">Đăng ký</a>
                                        </li>
                                        <li class="navbar-item">
                                            <a href="${pageContext.request.contextPath}/login.jsp"
                                                class="navbar-item__link">Đăng nhập</a>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Hiển thị khi đã đăng nhập -->
                                        <li class="navbar-item">
                                            <span class="navbar-item__link" style="cursor: default;">
                                                <i class="fa-regular fa-user"></i> ${sessionScope.user.username}
                                            </span>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
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
                                <form class="search-form" action="${pageContext.request.contextPath}/shop.jsp"
                                    method="get" role="search">
                                    <select name="category" class="search-cat" aria-label="Category">
                                        <option value="all">Danh mục</option>
                                        <option value="fruits">Trái cây</option>
                                        <option value="vegetables">táo</option>
                                    </select>
                                    <input name="q" class="search-input" type="search"
                                        placeholder="Tìm kiếm sản phẩm..." aria-label="Search" />
                                    <button type="submit" class="search-btn" aria-label="Search">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>
                                </form>
                            </div>

                            <div class="navbar__menu-actions">
                                <a href="${pageContext.request.contextPath}/wishlist.jsp" class="icon-btn wishlist-btn"
                                    title="Yêu thích">
                                    <i class="fa-solid fa-heart"></i>
                                    <span class="badge">3</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/cart.jsp" class="icon-btn cart-btn"
                                    title="Giỏ hàng">
                                    <i class="fa-solid fa-basket-shopping"></i>
                                    <span class="badge">2</span>
                                </a>
                                <div class="header__account">
                                    <div class="header__account-user"
                                        style="display: flex; align-items: center; gap: 8px; cursor: pointer; padding: 10px 0;">
                                        <i class="fa-solid fa-user" style="font-size: 20px;"></i>
                                        <span style="font-size: 1.4rem; font-weight: 500;">
                                           
                                        </span>
                                    </div>

                                    <div class="account-dropdown">
                                        <c:if test="${sessionScope.account == null}">
                                            <div class="account-auth">
                                                <span class="auth-text">Chào khách, vui lòng:</span>
                                                <div class="auth-buttons">
                                                    <a href="login.jsp" class="btn--primary"
                                                        style="display: block; text-align: center; text-decoration: none; margin-bottom: 8px;">Đăng
                                                        nhập</a>
                                                    <a href="register.jsp" class="btn--outline"
                                                        style="display: block; text-align: center; text-decoration: none;">Đăng
                                                        ký</a>
                                                </div>
                                            </div>
                                        </c:if>

                                        <c:if test="${sessionScope.account != null}">
                                            <div class="account-user">
                                                <div class="user-info">
                                                    <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                                                        alt="User Avatar" class="user-avatar">
                                                    <div class="user-details">
                                                        <%-- SỬA CẢ Ở ĐÂY NỮA --%>
                                                            <span
                                                                class="user-name">${sessionScope.account.fullName}</span>
                                                            <span
                                                                class="user-email">${sessionScope.account.email}</span>
                                                    </div>
                                                </div>
                                                <ul class="account-menu">
                                                    <li><a href="profile.jsp"><i class="fa-solid fa-id-card"></i> Hồ sơ
                                                            cá nhân</a></li>
                                                    <li><a href="orders.jsp"><i class="fa-solid fa-box-open"></i> Đơn
                                                            hàng</a></li>
                                                    <li><a href="change-password.jsp"><i class="fa-solid fa-key"></i>
                                                            Đổi mật khẩu</a></li>
                                                    <li class="border-top">
                                                        <a href="logout" class="text-danger">
                                                            <i class="fa-solid fa-arrow-right-from-bracket"></i> Đăng
                                                            xuất
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </nav>
            </header>