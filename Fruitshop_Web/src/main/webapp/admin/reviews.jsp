<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="dal.ReviewDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Review" %>

<%
    ReviewDAO reviewDAO = new ReviewDAO();
    List<Review> reviews = reviewDAO.getAllReviews();
    int totalReviews = reviewDAO.getTotalReviews();
    int unrepliedCount = reviewDAO.getUnrepliedReviews();
    double avgRating = reviewDAO.getAverageRating();

    request.setAttribute("reviews", reviews);
    request.setAttribute("totalReviews", totalReviews);
    request.setAttribute("unrepliedCount", unrepliedCount);
    request.setAttribute("avgRating", avgRating);
%>

  <!DOCTYPE html>
  <html lang="vi">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/base.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin/reviews.css" />
    <title>Quản lý Đánh giá</title>
  </head>

  <body>

    <jsp:include page="sidebar.jsp">
      <jsp:param name="activePage" value="reviews" />
    </jsp:include>

    <div class="content">

      <jsp:include page="header.jsp" />

      <main>
        <div class="header">
          <div class="left">
            <h1>Quản lý Đánh giá</h1>
            <ul class="breadcrumb">
              <li><a href="#">Quản lý</a></li>
              <li>/</li>
              <li><a href="#" class="active">Đánh giá</a></li>
            </ul>
          </div>
        </div>

        <ul class="insights review-insights">
          <li>
            <i class='bx bx-message-square-dots'></i>
            <span class="info">
              <h3>${totalReviews}</h3>
              <p>Tổng đánh giá</p>
            </span>
          </li>
          <li>
            <i class='bx bx-chat'></i>
            <span class="info">
              <h3>${unrepliedCount}</h3>
              <p>Chưa trả lời</p>
            </span>
          </li>
          <li>
            <i class='bx bxs-star'></i>
            <span class="info">
              <h3><fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/></h3>
              <p>Điểm trung bình</p>
            </span>
          </li>
        </ul>

        <div class="bottom-data">
          <div class="orders">
            <div class="header">
              <h3>Danh sách phản hồi khách hàng</h3>
              <div class="filters">
                <select id="ratingFilter">
                  <option value="">Tất cả sao</option>
                  <option value="5">5 Sao</option>
                  <option value="4">4 Sao</option>
                  <option value="3">3 Sao</option>
                  <option value="2">2 Sao</option>
                  <option value="1">1 Sao</option>
                </select>
                <select id="statusFilter">
                  <option value="">Tất cả trạng thái</option>
                  <option value="visible">Đang hiện</option>
                  <option value="hidden">Đã ẩn</option>
                  <option value="replied">Đã trả lời</option>
                  <option value="unreplied">Chưa trả lời</option>
                </select>
              </div>
            </div>

            <table>
              <thead>
                <tr>
                  <th>Khách hàng</th>
                  <th width="40%">Nội dung & Phản hồi</th>
                  <th>Sản phẩm</th>
                  <th>Trạng thái</th>
                  <th>Hành động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${reviews}" var="r">
                  <tr>
                    <td class="user-cell">
                      <img src="${(not empty userAvatar) ? (userAvatar.startsWith('http') ? userAvatar : pageContext.request.contextPath += '/' += userAvatar) : 'https://via.placeholder.com/40'}" alt="Avatar">
                      <div>
                        <p>${r.user.fullName}</p>
                        <small>${r.user.email}</small>
                        </div>
                    </td>

                    <td class="review-content-cell">
                      <div class="stars" style="color: #ffc107;">
                        <c:forEach begin="1" end="${r.rating}">
                          <i class='bx bxs-star'></i>
                        </c:forEach>
                        <c:forEach begin="1" end="${5 - r.rating}">
                          <i class='bx bx-star'></i>
                        </c:forEach>
                      </div>

                      <p class="comment" style="font-style: italic;">"${r.comment}"</p>

                      <c:if test="${not empty r.adminReply}">
                          <div class="admin-reply" style="margin-top: 8px; background: #f0f9ff; padding: 8px; border-radius: 4px; border-left: 3px solid #3d8b91;">
                            <strong style="color: #3d8b91; font-size: 12px;">Admin:</strong>
                            <span style="font-size: 13px;">${r.adminReply}</span>
                          </div>
                      </c:if>

                      <small class="date">
                          <fmt:formatDate value="${r.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                      </small>
                    </td>

                    <td>
                      <a href="${pageContext.request.contextPath}/product-detail?pid=${r.productId}" target="_blank" class="product-link">
                          ${r.product.name}
                      </a>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${r.status == 'hidden'}">
                                <span class="status cancelled" style="background: #eee; color: #333;">Đã ẩn</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status completed">Hiển thị</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                      <div class="action-group">
                        <button class="action-btn reply"
                                onclick="openReplyModal('${r.id}', '${r.user.fullName}', '${r.product.name}')"
                                title="Trả lời/Sửa">
                            <i class='bx bx-reply'></i>
                        </button>

                        <c:if test="${r.status != 'hidden'}">
                           <form action="review-action" method="post" style="display:inline;">
                               <input type="hidden" name="action" value="hide">
                               <input type="hidden" name="id" value="${r.id}">
                               <button class="action-btn hide" title="Ẩn bình luận" onclick="return confirm('Bạn muốn ẩn đánh giá này?')">
                                   <i class='bx bx-hide'></i>
                               </button>
                           </form>
                        </c:if>
                        <c:if test="${r.status == 'hidden'}">
                           <form action="review-action" method="post" style="display:inline;">
                               <input type="hidden" name="action" value="show">
                               <input type="hidden" name="id" value="${r.id}">
                               <button class="action-btn approve" title="Hiện lại" style="background: #28a745;">
                                   <i class='bx bx-show'></i>
                               </button>
                           </form>
                        </c:if>

                        <form action="review-action" method="post" style="display:inline;">
                           <input type="hidden" name="action" value="delete">
                           <input type="hidden" name="id" value="${r.id}">
                           <button class="action-btn delete" title="Xóa vĩnh viễn" onclick="return confirm('Xóa vĩnh viễn đánh giá này?')">
                               <i class='bx bx-trash'></i>
                           </button>
                        </form>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>

            <div class="pagination">
              <a href="#" class="page-btn disabled">&laquo;</a>
              <a href="#" class="page-btn active">1</a>
              <a href="#" class="page-btn">2</a>
              <a href="#" class="page-btn">&raquo;</a>
            </div>
          </div>
        </div>
      </main>
    </div>

    <div id="replyModal" class="modal">
      <div class="modal-content">
        <span class="close-btn" onclick="closeReplyModal()">&times;</span>
        <h2>Trả lời đánh giá</h2>
        <p>Đang phản hồi khách hàng: <strong id="replyUser" style="color: var(--primary);"></strong></p>
        <p style="margin-bottom: 15px; font-size: 13px; color: #666;">Sản phẩm: <span id="replyProduct"></span></p>

        <form action="review-action" method="post">
          <input type="hidden" name="action" value="reply">
          <input type="hidden" id="replyReviewId" name="id" value="">

          <div class="form-group">
            <textarea name="replyContent" id="replyText" rows="5" class="form-control"
              placeholder="Nhập nội dung cảm ơn hoặc giải thích..."></textarea>
          </div>
          <div style="text-align: right; margin-top: 15px;">
            <button type="button" class="btn-outline" onclick="closeReplyModal()"
              style="margin-right: 10px; padding: 8px 20px; border: 1px solid #ccc; background: #fff; border-radius: 4px; cursor: pointer;">Hủy</button>
            <button type="submit" class="btn-submit">Gửi phản hồi</button>
          </div>
        </form>
      </div>
    </div>

    <script src="../assets/js/admin/main.js"></script>
    <script src="../assets/js/admin/reviews.js"></script>
  </body>

  </html>