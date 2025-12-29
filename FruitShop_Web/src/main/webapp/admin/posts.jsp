<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/products.css" />

        <title>Quản lý Bài viết</title>
        <style>
            /* CSS thêm riêng cho trang bài viết để đẹp hơn */
            .post-thumb {
                width: 60px;
                height: 40px;
                object-fit: cover;
                border-radius: 4px;
            }

            .post-title {
                font-weight: 600;
                color: var(--dark);
                max-width: 300px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .post-meta {
                font-size: 12px;
                color: var(--dark-grey);
            }
        </style>
    </head>

    <body>

        <jsp:include page="sidebar.jsp">
            <jsp:param name="activePage" value="posts" />
        </jsp:include>

        <div class="content">

            <jsp:include page="header.jsp" />

            <main>
                <div class="header">
                    <div class="left">
                        <h1>Quản lý Bài viết</h1>
                        <ul class="breadcrumb">
                            <li><a href="#">Quản lý</a></li>
                            <li>/</li>
                            <li><a href="#" class="active">Tin tức</a></li>
                        </ul>
                    </div>
                    <a href="/admin/post-edit.jsp" class="report">
                        <i class="bx bx-plus"></i>
                        <span>Viết bài mới</span>
                    </a>
                </div>

                <div class="bottom-data">
                    <div class="orders">
                        <div class="header">
                            <h3>Danh sách bài viết</h3>
                            <div class="filters">
                                <select>
                                    <option>Tất cả danh mục</option>
                                    <option>Dinh dưỡng</option>
                                    <option>Mẹo vặt</option>
                                </select>
                                <select>
                                    <option>Tất cả trạng thái</option>
                                    <option>Đã xuất bản</option>
                                    <option>Bản nháp</option>
                                </select>
                            </div>
                        </div>

                        <table>
                            <thead>
                                <tr>
                                    <th>Hình ảnh</th>
                                    <th>Tiêu đề bài viết</th>
                                    <th>Danh mục</th>
                                    <th>Tác giả</th>
                                    <th>Ngày đăng</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><img src="https://images.unsplash.com/photo-1610832958506-aa56368176cf?q=80&w=200"
                                            class="post-thumb" alt=""></td>
                                    <td>
                                        <p class="post-title">12 Loại Trái Cây Tốt Cho Sức Khỏe</p>
                                        <span class="post-meta">1.2k lượt xem</span>
                                    </td>
                                    <td>Dinh dưỡng</td>
                                    <td>Admin A</td>
                                    <td>15-11-2025</td>
                                    <td><span class="status completed">Xuất bản</span></td>
                                    <td>
                                        <a href="/admin/post-edit.jsp?id=1" class="action-btn edit"><i
                                                class="bx bx-edit"></i></a>
                                        <button class="action-btn delete"><i class="bx bx-trash"></i></button>
                                    </td>
                                </tr>

                                <tr>
                                    <td><img src="https://images.unsplash.com/photo-1528825871115-3581a5387919?q=80&w=200"
                                            class="post-thumb" alt=""></td>
                                    <td>
                                        <p class="post-title">Cách làm Salad trái cây mùa hè</p>
                                        <span class="post-meta">850 lượt xem</span>
                                    </td>
                                    <td>Công thức</td>
                                    <td>Admin B</td>
                                    <td>14-11-2025</td>
                                    <td><span class="status completed">Xuất bản</span></td>
                                    <td>
                                        <a href="/admin/post-edit.jsp?id=2" class="action-btn edit"><i
                                                class="bx bx-edit"></i></a>
                                        <button class="action-btn delete"><i class="bx bx-trash"></i></button>
                                    </td>
                                </tr>

                                <tr>
                                    <td><img src="https://images.unsplash.com/photo-1595475207225-428b62bda831?q=80&w=200"
                                            class="post-thumb" alt=""></td>
                                    <td>
                                        <p class="post-title">Ăn sầu riêng có béo không?</p>
                                        <span class="post-meta">0 lượt xem</span>
                                    </td>
                                    <td>Sức khỏe</td>
                                    <td>Admin A</td>
                                    <td>--</td>
                                    <td><span class="status pending">Bản nháp</span></td>
                                    <td>
                                        <a href="/admin/post-edit.jsp?id=3" class="action-btn edit"><i
                                                class="bx bx-edit"></i></a>
                                        <button class="action-btn delete"><i class="bx bx-trash"></i></button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                        <div class="pagination">
                            <a href="#" class="page-btn active">1</a>
                            <a href="#" class="page-btn">2</a>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="../assets/js/admin/main.js"></script>
    </body>

    </html>