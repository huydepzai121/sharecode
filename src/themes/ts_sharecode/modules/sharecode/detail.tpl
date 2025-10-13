<!-- BEGIN: main -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/assets/vendor/boxicons/css/boxicons.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/assets/vendor/remixicon/remixicon.css">
<link rel="stylesheet" href="{LINK_URL}/css/swiper-bundle.min.css">
<link rel="stylesheet" href="{LINK_URL}/css/picbox.css">
<link rel="stylesheet" href="{LINK_URL}/css/lightgallery.css">
<link rel="stylesheet" href="{LINK_URL}/css/gallery-fix.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/css/sharecode-detail.css">
<script src="{LINK_URL}/js/swiper-bundle.min.js"></script>
<script src="{LINK_URL}/js/picbox.js"></script>
<script type="text/javascript" src="{LINK_URL}/js/custom_swiper.js"></script>
<div id="sharecode-detail" class="container">
    <div class="detail-wrapper">
        <div class="row">
            <div class="col-lg-8">
                <div class="sharecode-image-gallery">
                    <div class="main-image-container">
                        <div class="product-image-block relative">
                            <div class="swiper-image">
                                <div class="swiper-container gallery-top">
                                    <div class="swiper-wrapper" id="lightgallery">
                                        <div class="swiper-slide swiper-slide-active demo-image-slide" data-hash="0" data-src="{SOURCE.image_url}" title="{SOURCE.title}" style="cursor: pointer;">
                                            <img itemprop="image" src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-responsive mx-auto d-block swiper-lazy swiper-lazy-loaded imgage__slide_first">
                                        </div>
                                        <!-- Demo images slides -->
                                        <!-- BEGIN: demo_images -->
                                        <!-- BEGIN: demo_image_others -->
                                        <div class="swiper-slide demo-image-slide" data-hash="{DEMO_IMAGE.index}" data-src="{DEMO_IMAGE.url}" title="Demo {SOURCE.title}" style="cursor: pointer;">
                                            <img src="{DEMO_IMAGE.url}" alt="Demo {SOURCE.title}" class="img-responsive mx-auto d-block swiper-lazy">
                                        </div>
                                        <!-- END: demo_image_others -->
                                        <!-- END: demo_images -->
                                    </div>
                                    <div class="swiper-button-next swiper-button-white"></div>
                                    <div class="swiper-button-prev swiper-button-white"></div>
                                </div>

                                <div class="swiper-container gallery-thumbs">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide active demo-thumb-slide" style="cursor: pointer;">
                                            <img height="80" width="80" src="{SOURCE.image_url}" alt="{SOURCE.title}" data-image="{SOURCE.image_url}" class="swiper-lazy">
                                        </div>
                                        <!-- Demo images thumbnails -->
                                        <!-- BEGIN: demo_images_thumbs -->
                                        <!-- BEGIN: demo_image_thumb -->
                                        <div class="swiper-slide demo-thumb-slide" style="cursor: pointer;">
                                            <img height="80" width="80" src="{DEMO_IMAGE.url}" alt="Demo {SOURCE.title}" data-image="{DEMO_IMAGE.url}" class="swiper-lazy">
                                        </div>
                                        <!-- END: demo_image_thumb -->
                                        <!-- END: demo_images_thumbs -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>



                <!-- Additional Info Section Below Gallery -->
                <div class="sharecode-additional-info mt-3">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="info-item">
                                <span class="info-label"><i class="fa fa-eye"></i></span>
                                <span class="info-value">{SOURCE.num_view}</span>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="info-item">
                                <span class="info-label"><i class="ri-download-line"></i></span>
                                <span class="info-value">{SOURCE.num_download}</span>
                            </div>
                        </div>
                        <!-- BEGIN: demo_link -->
                        <div class="col-md-4">
                            <div class="info-item">
                                <span class="info-label"><i class="ri-play-circle-line"></i></span>
                                <span class="info-value">
                                    <a href="{DEMO_LINK}" target="_blank" class="demo-link">
                                         Xem demo
                                    </a>
                                </span>
                            </div>
                        </div>
                        <!-- END: demo_link -->
                    </div>
                </div>
            </div>

            <div class="col-lg-4 col-md-5">
                <div class="sharecode-info-card">
                    <div class="sharecode-header">
                        <h1 class="sharecode-title">{SOURCE.title}</h1>
                    </div>

                    <div class="box-stars">
                        <i class="fa fa-star" aria-hidden="true"></i>
                        <i class="fa fa-star" aria-hidden="true"></i>
                        <i class="fa fa-star" aria-hidden="true"></i>
                        <i class="fa fa-star" aria-hidden="true"></i>
                        <i class="fa fa-star" aria-hidden="true"></i>
                    </div>

                    <div class="sharecode-price-section">
                        <!-- BEGIN: free_price -->
                        <div class="price-normal">
                            <span class="price-current free"><i class="fa fa-money" aria-hidden="true"></i> Phí tải: MIỄN PHÍ</span>
                        </div>
                        <!-- END: free_price -->

                        <!-- BEGIN: contact_price -->
                        <div class="price-normal">
                            <span class="price-current contact"><i class="fa fa-money" aria-hidden="true"></i> Phí tải: {SOURCE.price_text}</span>
                        </div>
                        <!-- END: contact_price -->
                         
                        <!-- BEGIN: paid_price -->
                        <div class="price-normal">
                            <span class="price-current paid"><i class="fa fa-money" aria-hidden="true"></i> Phí tải: {SOURCE.price_text}</span>
                        </div>
                        <!-- END: paid_price -->
                    </div>

                    <!-- Quick Specs -->
                    <div class="sharecode-quick-specs">
                        <div class="spec-item">
                            <i class="ri-folder-line"></i>
                            <span class="spec-value">Danh mục: {SOURCE.category_title}</span>
                        </div>

                        <div class="spec-item">
                            <i class="ri-money-dollar-circle-line"></i>
                            <span class="spec-value">Loại phí: {SOURCE.fee_type_display}</span>
                        </div>

                        <div class="spec-item">
                            <i class="ri-calendar-line"></i>
                            <span class="spec-value">Ngày đăng: {SOURCE.add_time_format}</span>
                        </div>

                        <div class="spec-item">
                            <i class="ri-file-line"></i>
                            <span class="spec-value">Loại file: {SOURCE.file_type_display}</span>
                        </div>

                        <div class="spec-item">
                            <i class="ri-hard-drive-line"></i>
                            <span class="spec-value">Dung lượng: {SOURCE.file_size_format}</span>
                        </div>
                    </div>

                    <div class="sharecode-actions">
                        <!-- BEGIN: already_purchased -->
                        <button class="btn btn-success btn-lg btn-block download-btn" onclick="downloadFile('{SOURCE.id}'); return false;">
                            <i class="bx bx-download"></i> TẢI XUỐNG
                        </button>
                        <!-- END: already_purchased -->

                        <!-- BEGIN: can_download -->
                        <button class="btn btn-success btn-lg btn-block download-btn"
                                data-toggle="modal" data-target="#downloadModal" onclick="openDownloadModal()">
                            <i class="bx bx-download"></i> TẢI XUỐNG
                        </button>
                        <!-- END: can_download -->

                        <!-- BEGIN: need_contact -->
                        <button class="btn btn-primary btn-lg btn-block contact-btn" onclick="showContactInfo()">
                            <i class="bx bx-phone"></i> Liên hệ tư vấn
                        </button>
                        <!-- END: need_contact -->

                        <!-- BEGIN: need_login -->
                        <a href="{LOGIN_URL}" class="btn btn-outline-secondary btn-lg btn-block login-btn">
                            <i class="bx bx-log-in"></i> ĐĂNG NHẬP
                        </a>
                        <!-- END: need_login -->

                        <!-- BEGIN: favorite_button -->
                        <button class="btn btn-lg btn-block {FAVORITE.class}" id="favorite-btn"
                            data-source-id="{FAVORITE.source_id}"
                            data-action="{FAVORITE.action}"
                            data-checkss="{FAVORITE.checkss}"
                            data-ajax-url="{FAVORITE.ajax_url}">
                            <i class="bx {FAVORITE.icon}"></i> {FAVORITE.text}
                        </button>
                        <!-- END: favorite_button -->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-12 description-section">
                <h3 class="section-title">Mô tả ngắn</h3>
                <div class="description-content">
                    {SOURCE.description}
                </div>
            </div>

            <div class="mt-2 col-12 description-section">
                <h3 class="section-title">Mô tả chi tiết</h3>
                <div class="description-content">
                    {SOURCE.content}
                </div>
            </div>

            <!-- BEGIN: tags -->
            <div class="mt-2 col-12 description-section">
                <h3 class="section-title"><i class="fa fa-tags"></i> Thẻ liên quan</h3>
                <div class="description-content">
                    <div class="tags-list">
                        <!-- BEGIN: tag -->
                        <a href="{TAG.link}" class="tag-item">{TAG.name}</a>
                        <!-- END: tag -->
                    </div>
                </div>
            </div>
            <!-- END: tags -->

            <div class="mt-2 col-12 description-section">
                <h3 class="section-title"><i class="fa fa-user"></i> Thông tin tác giả</h3>
                <div class="description-content">
                    <div class="author-card">
                        <div class="author-layout">
                            <div class="author-avatar">
                                <img src="{AUTHOR.avatar_url}" alt="{AUTHOR.display_name}" class="img-circle">
                            </div>
                            <div class="author-info">
                                <div class="author-header">
                                    <h4 class="author-name">
                                        <a href="{AUTHOR.profile_url}">{AUTHOR.display_name}</a>
                                    </h4>
                                    <p class="author-username">@{AUTHOR.username}</p>
                                </div>
                                <div class="author-stats">
                                    <div class="stat-item">
                                        <span class="stat-number">{AUTHOR.total_codes}</span>
                                        <span class="stat-label">Mã nguồn</span>
                                    </div>
                                    <div class="stat-item">
                                        <span class="stat-number">{AUTHOR.total_downloads}</span>
                                        <span class="stat-label">Lượt tải</span>
                                    </div>
                                    <div class="stat-item">
                                        <span class="stat-number">{AUTHOR.avg_rating}</span>
                                        <span class="stat-label">Đánh giá TB</span>
                                    </div>
                                </div>
                            </div>
                            <div class="author-actions">
                                <a href="{AUTHOR.profile_url}" class="view-profile-btn">
                                    <i class="fa fa-user"></i>
                                    Xem trang cá nhân
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="mt-4">
        <div class="col-sm-24">
            <div class="reviews-comments-section">
                <div class="section-tabs">
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active">
                            <a href="#reviews-tab" aria-controls="reviews-tab" role="tab" data-toggle="tab">
                                <i class="fa fa-star"></i> Đánh giá
                            </a>
                        </li>
                        <li role="presentation">
                            <a href="#comments-tab" aria-controls="comments-tab" role="tab" data-toggle="tab">
                                <i class="fa fa-comments"></i> Bình luận
                            </a>
                        </li>
                    </ul>
                </div>

                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="reviews-tab">
                        <div class="reviews-section">

                            <!-- Reviews Summary -->
                            <!-- BEGIN: reviews_summary -->
                            <div class="reviews-summary">
                                <div class="summary-layout">
                                    <div class="summary-left">
                                        <div class="rating-overview">
                                            <div class="avg-rating-display">
                                                <span class="avg-rating-number">{AVG_RATING}</span>
                                                <div class="avg-rating-stars">{AVG_RATING_STARS}</div>
                                                <p class="avg-rating-text">Trung bình từ {TOTAL_REVIEWS} đánh giá</p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="summary-right">
                                        <div class="rating-breakdown">
                                            <div class="rating-bar">
                                                <span class="rating-label">5 sao</span>
                                                <div class="rating-progress">
                                                    <div class="rating-fill" style="width: {RATING_5_PERCENT}%"></div>
                                                </div>
                                                <span class="rating-count">{RATING_5_COUNT}</span>
                                            </div>
                                            <div class="rating-bar">
                                                <span class="rating-label">4 sao</span>
                                                <div class="rating-progress">
                                                    <div class="rating-fill" style="width: {RATING_4_PERCENT}%"></div>
                                                </div>
                                                <span class="rating-count">{RATING_4_COUNT}</span>
                                            </div>
                                            <div class="rating-bar">
                                                <span class="rating-label">3 sao</span>
                                                <div class="rating-progress">
                                                    <div class="rating-fill" style="width: {RATING_3_PERCENT}%"></div>
                                                </div>
                                                <span class="rating-count">{RATING_3_COUNT}</span>
                                            </div>
                                            <div class="rating-bar">
                                                <span class="rating-label">2 sao</span>
                                                <div class="rating-progress">
                                                    <div class="rating-fill" style="width: {RATING_2_PERCENT}%"></div>
                                                </div>
                                                <span class="rating-count">{RATING_2_COUNT}</span>
                                            </div>
                                            <div class="rating-bar">
                                                <span class="rating-label">1 sao</span>
                                                <div class="rating-progress">
                                                    <div class="rating-fill" style="width: {RATING_1_PERCENT}%"></div>
                                                </div>
                                                <span class="rating-count">{RATING_1_COUNT}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- END: reviews_summary -->

                            <!-- BEGIN: can_review -->
                            <div class="add-review-section">
                                <h4 class="add-review-title">
                                    <i class="fa fa-edit"></i> Viết đánh giá của bạn
                                </h4>
                                <form id="reviewForm" class="review-form">
                                    <div class="form-group">
                                        <label class="form-label">Đánh giá của bạn:</label>
                                        <div class="star-rating-input">
                                            <input type="radio" name="rating" value="5" id="star5">
                                            <label for="star5" class="star-label">★</label>
                                            <input type="radio" name="rating" value="4" id="star4">
                                            <label for="star4" class="star-label">★</label>
                                            <input type="radio" name="rating" value="3" id="star3">
                                            <label for="star3" class="star-label">★</label>
                                            <input type="radio" name="rating" value="2" id="star2">
                                            <label for="star2" class="star-label">★</label>
                                            <input type="radio" name="rating" value="1" id="star1">
                                            <label for="star1" class="star-label">★</label>
                                        </div>
                                        <span class="rating-text-display">Chọn số sao</span>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Nhận xét:</label>
                                        <textarea name="comment" class="review-textarea" rows="6" cols="100"
                                            placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."></textarea>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="submit-review-btn">
                                            <i class="fa fa-paper-plane"></i> Gửi đánh giá
                                        </button>
                                    </div>
                                </form>
                            </div>
                            <!-- END: can_review -->

                            <!-- BEGIN: need_login_review -->
                            <div class="login-to-review">
                                <div class="login-prompt">
                                    <i class="fa fa-user-circle"></i>
                                    <p>Đăng nhập để viết đánh giá về sản phẩm này</p>
                                    <a href="{LOGIN_URL}" class="login-review-btn">
                                        <i class="fa fa-sign-in"></i> Đăng nhập
                                    </a>
                                </div>
                            </div>
                            <!-- END: need_login_review -->

                            <!-- BEGIN: need_purchase_review -->
                            <div class="need-purchase-review">
                                <div class="purchase-prompt">
                                    <i class="fa fa-shopping-cart"></i>
                                    <h4>Mua sản phẩm để đánh giá</h4>
                                    <p>Bạn cần mua sản phẩm này trước khi có thể viết đánh giá</p>
                                    <div class="purchase-actions">
                                        <!-- BEGIN: can_download -->
                                        <button class="btn btn-success purchase-review-btn" data-toggle="modal" data-target="#downloadModal">
                                            <i class="fa fa-shopping-cart"></i> Mua ngay để đánh giá
                                        </button>
                                        <!-- END: can_download -->
                                        <!-- BEGIN: need_login -->
                                        <a href="{LOGIN_URL}" class="btn btn-primary purchase-review-btn">
                                            <i class="fa fa-sign-in"></i> Đăng nhập để mua
                                        </a>
                                        <!-- END: need_login -->
                                    </div>
                                </div>
                            </div>
                            <!-- END: need_purchase_review -->

                            <!-- Reviews List -->
                            <!-- BEGIN: reviews_list -->
                            <div class="reviews-list">
                                <p class="reviews-list-title">
                                    <i class="fa fa-comments"></i> Đánh giá gần đây
                                </p>
                                <!-- BEGIN: review -->
                                <div class="review-item">
                                    <div class="review-header">
                                        <div class="reviewer-info">
                                            <div class="reviewer-avatar">
                                                <i class="fa fa-user-circle"></i>
                                            </div>
                                            <div class="reviewer-details">
                                                <h5 class="reviewer-name">{REVIEW.username}</h5>
                                                <div class="review-rating">{REVIEW.rating_stars}</div>
                                                <span class="review-date">{REVIEW.created_time_format}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="review-content">
                                        <p>{REVIEW.content}</p>

                                        <!-- BEGIN: has_admin_reply -->
                                        <div class="admin-reply">
                                            <div class="admin-reply-header">
                                                <i class="fa fa-reply"></i>
                                                <strong>Phản hồi từ admin ({REVIEW.admin_reply_username}):</strong>
                                                <span class="admin-reply-date">{REVIEW.admin_reply_time_format}</span>
                                            </div>
                                            <div class="admin-reply-content">
                                                {REVIEW.admin_reply_display}
                                            </div>
                                            <!-- BEGIN: is_admin -->
                                            <div class="admin-reply-actions mt-2">
                                                <button type="button"
                                                    class="btn btn-sm btn-warning edit-admin-reply-btn"
                                                    data-review-id="{REVIEW.id}">
                                                    <i class="fa fa-edit"></i> Sửa phản hồi
                                                </button>
                                            </div>
                                            <!-- END: is_admin -->
                                        </div>
                                        <!-- END: has_admin_reply -->

                                        <!-- BEGIN: is_admin -->
                                        <!-- BEGIN: no_admin_reply -->
                                        <div class="admin-reply-actions mt-2">
                                            <button type="button" class="btn btn-sm btn-success admin-reply-btn"
                                                data-review-id="{REVIEW.id}">
                                                <i class="fa fa-reply"></i> Trả lời đánh giá
                                            </button>
                                        </div>
                                        <!-- END: no_admin_reply -->

                                        <div class="admin-reply-form mt-3" id="admin-reply-form-{REVIEW.id}"
                                            style="display:none;">
                                            <form class="admin-review-reply-form" data-review-id="{REVIEW.id}">
                                                <div class="form-group">
                                                    <label class="form-label">
                                                        <i class="fa fa-shield text-primary"></i>
                                                        <strong>Phản hồi của Admin:</strong>
                                                    </label>
                                                    <textarea class="form-control" name="admin_reply_content" rows="4"
                                                        placeholder="Nhập phản hồi của admin cho đánh giá này...">{REVIEW.admin_reply}</textarea>
                                                </div>
                                                <div class="form-group">
                                                    <button type="submit" class="btn btn-primary btn-sm">
                                                        <i class="fa fa-reply"></i> Gửi phản hồi
                                                    </button>
                                                    <button type="button"
                                                        class="btn btn-secondary btn-sm cancel-admin-reply">
                                                        <i class="fa fa-times"></i> Hủy
                                                    </button>
                                                </div>
                                                <input type="hidden" name="checksess" value="{NV_CHECK_SESSION}">
                                            </form>
                                        </div>
                                        <!-- END: is_admin -->
                                    </div>
                                </div>
                                <!-- END: review -->
                            </div>
                            <!-- END: reviews_list -->

                            <!-- BEGIN: no_reviews -->
                            <div class="no-reviews">
                                <div class="no-reviews-content">
                                    <i class="fa fa-comment-o fa-3x"></i>
                                    <h4>Chưa có đánh giá nào</h4>
                                    <p>Hãy là người đầu tiên đánh giá sản phẩm này!</p>
                                </div>
                            </div>
                            <!-- END: no_reviews -->
                        </div>
                    </div>

                    <!-- Comments Tab -->
                    <div role="tabpanel" class="tab-pane" id="comments-tab">
                        <div class="comments-section">
                            <p class="comments-title">
                                <i class="fa fa-comments"></i> Bình luận từ người dùng
                                <span class="comments-count">({TOTAL_COMMENTS} bình luận)</span>
                            </p>

                            <!-- Add Comment Form -->
                            <!-- BEGIN: can_comment -->
                            <div class="add-comment-section">
                                <h5 class="add-comment-title">
                                    <i class="fa fa-edit"></i> Viết bình luận của bạn
                                </h5>
                                <form id="commentForm" class="comment-form">
                                    <div class="form-group">
                                        <label class="form-label">Nội dung bình luận:</label>
                                        <textarea name="comment" class="comment-textarea" rows="4" cols="100"
                                            placeholder="Chia sẻ ý kiến của bạn về sản phẩm này..."></textarea>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="submit-comment-btn">
                                            <i class="fa fa-paper-plane"></i> Gửi bình luận
                                        </button>
                                    </div>
                                </form>
                            </div>
                            <!-- END: can_comment -->

                            <!-- BEGIN: need_login_comment -->
                            <div class="login-to-comment">
                                <div class="login-prompt">
                                    <i class="fa fa-user-circle"></i>
                                    <p>Đăng nhập để viết bình luận về sản phẩm này</p>
                                    <a href="{LOGIN_URL}" class="login-comment-btn">
                                        <i class="fa fa-sign-in"></i> Đăng nhập
                                    </a>
                                </div>
                            </div>
                            <!-- END: need_login_comment -->

                            <!-- Comments List -->
                            <!-- BEGIN: comments_list -->
                            <div class="comments-list">
                                <h5 class="comments-list-title">
                                    <i class="fa fa-comment"></i> Bình luận gần đây
                                </h5>
                                <!-- BEGIN: comment -->
                                <div class="comment-item" data-comment-id="{COMMENT.id}">
                                    <div class="comment-header">
                                        <div class="commenter-info">
                                            <div class="commenter-avatar">
                                                <i class="fa fa-user-circle"></i>
                                            </div>
                                            <div class="commenter-details">
                                                <h6 class="commenter-name">
                                                    {COMMENT.username}
                                                    <!-- BEGIN: is_own_comment -->
                                                    <span class="own-comment-badge">Bạn</span>
                                                    <!-- END: is_own_comment -->
                                                    <!-- BEGIN: is_admin_comment -->
                                                    <span class="admin-comment-badge">Admin</span>
                                                    <!-- END: is_admin_comment -->
                                                </h6>
                                                <span class="comment-date">{COMMENT.created_time_format}</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="comment-content">
                                        <p>{COMMENT.content}</p>

                                        <!-- Comment Actions -->
                                        <!-- BEGIN: can_reply_comment -->
                                        <div class="comment-actions">
                                            <button class="reply-btn btn btn-success btn-xs" data-comment-id="{COMMENT.id}"
                                                data-username="{COMMENT.username}">
                                                <i class="fa fa-reply"></i> Trả lời
                                            </button>
                                        </div>
                                        <!-- END: can_reply_comment -->

                                        <!-- BEGIN: has_admin_reply -->
                                        <div class="admin-reply">
                                            <div class="admin-reply-header">
                                                <i class="fa fa-reply"></i>
                                                <strong>Phản hồi từ admin<!-- BEGIN: admin_name -->
                                                    ({COMMENT.admin_reply_username})<!-- END: admin_name -->:</strong>
                                                <span class="admin-reply-date">{COMMENT.admin_reply_time_format}</span>
                                            </div>
                                            <div class="admin-reply-content">
                                                {COMMENT.admin_reply_display}
                                            </div>
                                        </div>
                                        <!-- END: has_admin_reply -->
                                    </div>

                                    <!-- Replies Section -->
                                    <!-- BEGIN: replies -->
                                    <div class="replies-section">
                                        <!-- BEGIN: reply -->
                                        <div class="reply-item" data-comment-id="{REPLY.id}">
                                            <div class="reply-header">
                                                <div class="replier-info">
                                                    <div class="replier-avatar">
                                                        <i class="fa fa-user-circle"></i>
                                                    </div>
                                                    <div class="replier-details">
                                                        <h6 class="replier-name">
                                                            {REPLY.username}
                                                            <!-- BEGIN: is_own_comment -->
                                                            <span class="own-comment-badge">Bạn</span>
                                                            <!-- END: is_own_comment -->
                                                            <!-- BEGIN: is_admin_comment -->
                                                            <span class="admin-comment-badge">Admin</span>
                                                            <!-- END: is_admin_comment -->
                                                        </h6>
                                                        <span class="reply-date">{REPLY.created_time_format}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="reply-content">
                                                <p>{REPLY.content}</p>

                                                <!-- Reply Actions -->
                                                <!-- BEGIN: can_reply_reply -->
                                                <div class="reply-actions">
                                                    <button class="reply-btn btn btn-success btn-xs" data-comment-id="{COMMENT.id}"
                                                        data-username="{REPLY.username}">
                                                        <i class="fa fa-reply"></i> Trả lời
                                                    </button>
                                                </div>
                                                <!-- END: can_reply_reply -->

                                                <!-- BEGIN: has_admin_reply -->
                                                <div class="admin-reply">
                                                    <div class="admin-reply-header">
                                                        <i class="fa fa-reply"></i>
                                                        <strong>Phản hồi từ admin<!-- BEGIN: admin_name -->
                                                            ({REPLY.admin_reply_username})<!-- END: admin_name -->:</strong>
                                                        <span
                                                            class="admin-reply-date">{REPLY.admin_reply_time_format}</span>
                                                    </div>
                                                    <div class="admin-reply-content">
                                                        {REPLY.admin_reply}
                                                    </div>
                                                </div>
                                                <!-- END: has_admin_reply -->
                                            </div>
                                        </div>
                                        <!-- END: reply -->
                                    </div>
                                    <!-- END: replies -->

                                    <!-- Reply forms will be dynamically added by JavaScript -->
                                </div>
                                <!-- END: comment -->
                            </div>
                            <!-- END: comments_list -->

                            <!-- BEGIN: no_comments -->
                            <div class="no-comments">
                                <div class="no-comments-content">
                                    <i class="fa fa-comment-o fa-3x"></i>
                                    <h4>Chưa có bình luận nào</h4>
                                    <p>Hãy là người đầu tiên bình luận về sản phẩm này!</p>
                                </div>
                            </div>
                            <!-- END: no_comments -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal" id="downloadModal" tabindex="-1" role="dialog" aria-labelledby="downloadModalLabel">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="closeDownloadModal()">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="downloadModalLabel">
                    <i class="fa fa-credit-card text-primary"></i> Xác nhận thanh toán
                </h4>
            </div>
            <div class="modal-body">
                <div class="panel panel-info">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-16">
                                <h5 class="text-primary"><strong>{SOURCE.title}</strong></h5>
                                <p class="text-muted">Bao gồm: Source code + Database + Hướng dẫn</p>
                            </div>
                            <div class="col-sm-8 text-right">
                                <h4 class="text-primary">
                                    <strong>
                                        <!-- BEGIN: free_modal -->
                                        0 VNĐ
                                        <!-- END: free_modal -->
                                        <!-- BEGIN: contact_modal -->
                                        Liên hệ để biết giá
                                        <!-- END: contact_modal -->
                                        <!-- BEGIN: paid_modal -->
                                        {SOURCE.price_text}
                                        <!-- END: paid_modal -->
                                    </strong>
                                </h4>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- BEGIN: user_balance -->
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-12">
                                <span>Số dư hiện tại:</span>
                            </div>
                            <div class="col-sm-12 text-right">
                                <strong class="text-success">{USER_BALANCE} VNĐ</strong>
                            </div>
                        </div>
                        <hr style="margin: 10px 0;">
                        <div class="row">
                            <div class="col-sm-12">
                                <span>Số dư sau thanh toán:</span>
                            </div>
                            <div class="col-sm-12 text-right">
                                <strong class="{BALANCE_AFTER_CLASS}">{BALANCE_AFTER} VNĐ</strong>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: user_balance -->

                <!-- BEGIN: insufficient_balance -->
                <div class="alert alert-warning">
                    <i class="fa fa-exclamation-triangle"></i>
                    <strong>Số dư không đủ!</strong> Bạn cần nạp thêm tiền để thực hiện giao dịch này.
                </div>
                <!-- END: insufficient_balance -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" onclick="closeDownloadModal()">Hủy bỏ</button>
                <!-- BEGIN: can_pay -->
                <button type="button" id="confirmPayment" class="btn btn-primary">
                    <i class="fa fa-credit-card"></i> Thanh toán
                </button>
                <!-- END: can_pay -->
                <!-- BEGIN: need_topup -->
                <a href="{TOPUP_URL}" class="btn btn-warning">
                    <i class="fa fa-plus"></i> Nạp tiền
                </a>
                <a href="/index.php?nv=vi&nv=sharecode&op=history" class="btn btn-info">
                    <i class="fa fa-history"></i> Lịch sử mua
                </a>
                <!-- END: need_topup -->
            </div>
        </div>
    </div>
</div>



<script>
    function openDownloadModal() {
        // Kiểm tra xem Bootstrap modal có sẵn không
        if (typeof $ !== 'undefined' && $.fn.modal) {
            $('#downloadModal').modal('show');
        } else {
            // Fallback: hiển thị modal bằng cách thay đổi CSS
            var modal = document.getElementById('downloadModal');
            if (modal) {
                modal.style.display = 'block';
                modal.classList.add('show');
                document.body.classList.add('modal-open');

                // Thêm backdrop
                var backdrop = document.createElement('div');
                backdrop.className = 'modal-backdrop fade show';
                backdrop.id = 'modal-backdrop';
                backdrop.onclick = closeDownloadModal;
                document.body.appendChild(backdrop);
            }
        }
    }

    function closeDownloadModal() {
        var modal = document.getElementById('downloadModal');
        if (modal) {
            modal.style.display = 'none';
            modal.classList.remove('show');
            document.body.classList.remove('modal-open');

            // Xóa backdrop
            var backdrop = document.getElementById('modal-backdrop');
            if (backdrop) {
                backdrop.remove();
            }
        }
    }

    // Đóng modal khi nhấn ESC
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            closeDownloadModal();
        }
    });

    function showContactInfo() {
        var contactData = {
            title: '{SOURCE.title}',
            phone: '{SOURCE.contact_phone}',
            email: '{SOURCE.contact_email}',
            zalo: '{SOURCE.contact_zalo}',
            facebook: '{SOURCE.contact_facebook}',
            telegram: '{SOURCE.contact_telegram}',
            skype: '{SOURCE.contact_skype}',
            website: '{SOURCE.contact_website}',
            address: '{SOURCE.contact_address}'
        };

        var modalContent = buildContactModalContent(contactData);

        modalShow('<i class="fa fa-phone text-primary"></i> Thông tin liên hệ', modalContent);

        setTimeout(function () {
            initCopyButtons();
            initContactTabs();
        }, 100);
    }

    function buildContactModalContent(data) {
        var html = '<div class="contact-modal-wrapper">';

        html += '<div class="contact-info-header">';
        html += '<h5 class="text-primary"><strong>' + data.title + '</strong></h5>';
        html += '<p class="text-muted">Vui lòng liên hệ trực tiếp với tác giả để biết thêm thông tin về giá cả và điều kiện sử dụng.</p>';
        html += '</div>';

        var tabs = [];
        var tabContent = [];
        var hasPhone = data.phone || data.zalo;
        var hasEmail = data.email;
        var hasSocial = data.facebook || data.telegram || data.skype;
        var hasOther = data.website || data.address;

        if (hasPhone) {
            tabs.push('<li class="nav-item"><a class="nav-link active" href="#phone-tab" data-toggle="tab"><i class="fa fa-phone"></i> Điện thoại</a></li>');
            var phoneContent = '<div class="tab-pane active" id="phone-tab">';

            if (data.phone) {
                phoneContent += '<div class="contact-item">';
                phoneContent += '<div class="contact-icon"><i class="fa fa-phone fa-2x text-success"></i></div>';
                phoneContent += '<div class="contact-details">';
                phoneContent += '<h6>Số điện thoại</h6>';
                phoneContent += '<div class="contact-value">';
                phoneContent += '<a href="tel:' + data.phone + '" class="contact-link phone-link">' + data.phone + '</a>';
                phoneContent += '<button class="btn btn-sm btn-outline-success copy-btn" data-copy="' + data.phone + '"><i class="fa fa-copy"></i> Sao chép</button>';
                phoneContent += '</div></div></div>';
            }

            if (data.zalo) {
                phoneContent += '<div class="contact-item">';
                phoneContent += '<div class="contact-icon"><i class="fa fa-comment fa-2x text-primary"></i></div>';
                phoneContent += '<div class="contact-details">';
                phoneContent += '<h6>Zalo</h6>';
                phoneContent += '<div class="contact-value">';
                phoneContent += '<span class="contact-text">' + data.zalo + '</span>';
                phoneContent += '<button class="btn btn-sm btn-outline-primary copy-btn" data-copy="' + data.zalo + '"><i class="fa fa-copy"></i> Sao chép</button>';
                phoneContent += '</div></div></div>';
            }

            phoneContent += '</div>';
            tabContent.push(phoneContent);
        }

        if (hasEmail) {
            var activeClass = !hasPhone ? ' active' : '';
            tabs.push('<li class="nav-item"><a class="nav-link' + activeClass + '" href="#email-tab" data-toggle="tab"><i class="fa fa-envelope"></i> Email</a></li>');

            var emailContent = '<div class="tab-pane' + activeClass + '" id="email-tab">';
            emailContent += '<div class="contact-item">';
            emailContent += '<div class="contact-icon"><i class="fa fa-envelope fa-2x text-danger"></i></div>';
            emailContent += '<div class="contact-details">';
            emailContent += '<h6>Địa chỉ email</h6>';
            emailContent += '<div class="contact-value">';
            emailContent += '<a href="mailto:' + data.email + '" class="contact-link email-link">' + data.email + '</a>';
            emailContent += '<button class="btn btn-sm btn-outline-danger copy-btn" data-copy="' + data.email + '"><i class="fa fa-copy"></i> Sao chép</button>';
            emailContent += '</div></div></div>';
            emailContent += '</div>';
            tabContent.push(emailContent);
        }

        if (hasSocial) {
            var activeClass = !hasPhone && !hasEmail ? ' active' : '';
            tabs.push('<li class="nav-item"><a class="nav-link' + activeClass + '" href="#social-tab" data-toggle="tab"><i class="fa fa-share-alt"></i> Mạng xã hội</a></li>');

            var socialContent = '<div class="tab-pane' + activeClass + '" id="social-tab">';

            if (data.facebook) {
                socialContent += '<div class="contact-item">';
                socialContent += '<div class="contact-icon"><i class="fa fa-facebook fa-2x text-primary"></i></div>';
                socialContent += '<div class="contact-details">';
                socialContent += '<h6>Facebook</h6>';
                socialContent += '<div class="contact-value">';
                socialContent += '<a href="' + data.facebook + '" target="_blank" class="contact-link facebook-link">' + data.facebook + '</a>';
                socialContent += '<button class="btn btn-sm btn-outline-primary copy-btn" data-copy="' + data.facebook + '"><i class="fa fa-copy"></i> Sao chép</button>';
                socialContent += '</div></div></div>';
            }

            if (data.telegram) {
                socialContent += '<div class="contact-item">';
                socialContent += '<div class="contact-icon"><i class="fa fa-telegram fa-2x text-info"></i></div>';
                socialContent += '<div class="contact-details">';
                socialContent += '<h6>Telegram</h6>';
                socialContent += '<div class="contact-value">';
                socialContent += '<span class="contact-text">' + data.telegram + '</span>';
                socialContent += '<button class="btn btn-sm btn-outline-info copy-btn" data-copy="' + data.telegram + '"><i class="fa fa-copy"></i> Sao chép</button>';
                socialContent += '</div></div></div>';
            }

            if (data.skype) {
                socialContent += '<div class="contact-item">';
                socialContent += '<div class="contact-icon"><i class="fa fa-skype fa-2x text-info"></i></div>';
                socialContent += '<div class="contact-details">';
                socialContent += '<h6>Skype</h6>';
                socialContent += '<div class="contact-value">';
                socialContent += '<a href="skype:' + data.skype + '?chat" class="contact-link skype-link">' + data.skype + '</a>';
                socialContent += '<button class="btn btn-sm btn-outline-info copy-btn" data-copy="' + data.skype + '"><i class="fa fa-copy"></i> Sao chép</button>';
                socialContent += '</div></div></div>';
            }

            socialContent += '</div>';
            tabContent.push(socialContent);
        }

        if (hasOther) {
            var activeClass = !hasPhone && !hasEmail && !hasSocial ? ' active' : '';
            tabs.push('<li class="nav-item"><a class="nav-link' + activeClass + '" href="#other-tab" data-toggle="tab"><i class="fa fa-info-circle"></i> Khác</a></li>');

            var otherContent = '<div class="tab-pane' + activeClass + '" id="other-tab">';

            if (data.website) {
                otherContent += '<div class="contact-item">';
                otherContent += '<div class="contact-icon"><i class="fa fa-globe fa-2x text-success"></i></div>';
                otherContent += '<div class="contact-details">';
                otherContent += '<h6>Website</h6>';
                otherContent += '<div class="contact-value">';
                otherContent += '<a href="' + data.website + '" target="_blank" class="contact-link website-link">' + data.website + '</a>';
                otherContent += '<button class="btn btn-sm btn-outline-success copy-btn" data-copy="' + data.website + '"><i class="fa fa-copy"></i> Sao chép</button>';
                otherContent += '</div></div></div>';
            }

            if (data.address) {
                otherContent += '<div class="contact-item">';
                otherContent += '<div class="contact-icon"><i class="fa fa-map-marker fa-2x text-warning"></i></div>';
                otherContent += '<div class="contact-details">';
                otherContent += '<h6>Địa chỉ</h6>';
                otherContent += '<div class="contact-value">';
                otherContent += '<span class="contact-text">' + data.address + '</span>';
                otherContent += '<button class="btn btn-sm btn-outline-warning copy-btn" data-copy="' + data.address + '"><i class="fa fa-copy"></i> Sao chép</button>';
                otherContent += '</div></div></div>';
            }

            otherContent += '</div>';
            tabContent.push(otherContent);
        }

        if (tabs.length > 1) {
            html += '<div class="contact-tabs">';
            html += '<ul class="nav nav-tabs">' + tabs.join('') + '</ul>';
            html += '<div class="tab-content">' + tabContent.join('') + '</div>';
            html += '</div>';
        } else if (tabContent.length > 0) {
            html += '<div class="single-contact-content">' + tabContent[0].replace('tab-pane active', 'contact-content') + '</div>';
        }

        html += '<div class="contact-tips text-center" style="margin-top: 20px; padding-top: 15px; border-top: 1px solid #dee2e6;">';
        html += '<small class="text-muted"><i class="fa fa-info-circle"></i> Tip: Nhấn vào số điện thoại hoặc email để liên hệ trực tiếp</small>';
        html += '</div>';

        html += '</div>';
        return html;
    }

    function initCopyButtons() {
        $(document).off('click', '.copy-btn').on('click', '.copy-btn', function (e) {
            e.preventDefault();
            var textToCopy = $(this).data('copy');

            if (navigator.clipboard) {
                navigator.clipboard.writeText(textToCopy).then(function () {
                    showCopySuccess($(e.target).closest('.copy-btn'));
                });
            } else {
                var tempInput = $('<input>');
                $('body').append(tempInput);
                tempInput.val(textToCopy).select();
                document.execCommand('copy');
                tempInput.remove();
                showCopySuccess($(e.target).closest('.copy-btn'));
            }
        });
    }

    function showCopySuccess(btn) {
        var originalHtml = btn.html();
        var originalClass = btn.attr('class');

        btn.html('<i class="fa fa-check"></i> Đã sao chép!');
        btn.removeClass('btn-outline-success btn-outline-primary btn-outline-danger btn-outline-info btn-outline-warning').addClass('btn-success');

        setTimeout(function () {
            btn.html(originalHtml);
            btn.attr('class', originalClass);
        }, 2000);
    }



    function initContactTabs() {
        $(document).off('click', '.nav-link[data-toggle="tab"]').on('click', '.nav-link[data-toggle="tab"]', function (e) {
            e.preventDefault();
            var target = $(this).attr('href');

            $('.nav-link').removeClass('active');
            $('.tab-pane').removeClass('active');

            $(this).addClass('active');
            $(target).addClass('active');
        });
    }

    function downloadFile(sourceId) {
        var token = '';

        $.ajax({
            url: location.href,
            type: 'POST',
            data: {
                get_download_token: 1,
                source_id: sourceId
            },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    var downloadUrl = response.download_url;
                    window.location.href = downloadUrl;
                } else {
                    nukeviet.toast(response.message, 'error');
                }
            },
            error: function () {
                nukeviet.toast('Có lỗi xảy ra khi tải file!', 'error');
            }
        });
    }

    $(document).ready(function () {
        $('#confirmPayment').click(function () {
            var btn = $(this);
            btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý...');

            $.ajax({
                url: location.href,
                type: 'POST',
                data: {
                    process_payment: 1,
                    source_id: '{SOURCE.id}'
                },
                dataType: 'json',
                success: function (response) {
                    if (response.status === 'success') {
                        $('#downloadModal').modal('hide');
                        nukeviet.toast(response.message, 'success');
                        window.location.href = '{HISTORY_URL}';
                    } else {
                        nukeviet.toast(response.message, 'error');
                        btn.prop('disabled', false).html('<i class="fa fa-credit-card"></i> Thanh toán');
                    }
                },
                error: function () {
                    nukeviet.toast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
                    btn.prop('disabled', false).html('<i class="fa fa-credit-card"></i> Thanh toán');
                }
            });
        });

        $('.star-rating-input input[type="radio"]').change(function () {
            var rating = $(this).val();
            var ratingTexts = {
                '1': 'Rất tệ',
                '2': 'Tệ',
                '3': 'Bình thường',
                '4': 'Tốt',
                '5': 'Xuất sắc'
            };
            $('.rating-text-display').text(ratingTexts[rating] || 'Chọn số sao');

            $('.star-rating-input .star-label').removeClass('active');
            $(this).nextAll('.star-label').addBack().addClass('active');
        });

        $('#reviewForm').submit(function (e) {
            e.preventDefault();

            console.log('Review form submitted'); // Debug

            var rating = $('input[name="rating"]:checked').val();
            var comment = '';

            // Kiểm tra CKEditor trước
            if (typeof CKEDITOR !== 'undefined' && CKEDITOR.instances['comment-editor']) {
                comment = CKEDITOR.instances['comment-editor'].getData().trim();
                var textOnly = comment.replace(/<[^>]*>/g, '').trim();
                if (textOnly.length < 10) {
                    nukeviet.toast('Vui lòng nhập nhận xét ít nhất 10 ký tự', 'error');
                    return;
                }
            } else {
                // Sử dụng textarea thông thường
                var textarea = $('textarea[name="comment"]');
                console.log('Textarea found:', textarea.length); // Debug
                comment = textarea.val();
                if (comment) {
                    comment = comment.trim();
                }
                console.log('Comment content:', comment); // Debug

                if (!comment || comment.length < 10) {
                    nukeviet.toast('Vui lòng nhập nhận xét ít nhất 10 ký tự', 'error');
                    return;
                }
            }

            if (!rating) {
                nukeviet.toast('Vui lòng chọn số sao đánh giá', 'error');
                return;
            }

            if (!comment) {
                nukeviet.toast('Vui lòng nhập nhận xét', 'error');
                return;
            }

            var submitBtn = $('.submit-review-btn');
            submitBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang gửi...');

            $.ajax({
                url: location.href,
                type: 'POST',
                data: {
                    submit_review: 1,
                    source_id: '{SOURCE.id}',
                    rating: rating,
                    comment: comment,
                    checksess: '{NV_CHECK_SESSION}'
                },
                dataType: 'json',
                success: function (response) {
                    if (response.status === 'success') {
                        nukeviet.toast(response.message, 'success');
                        location.reload();
                    } else {
                        nukeviet.toast(response.message, 'error');
                        submitBtn.prop('disabled', false).html('<i class="fa fa-paper-plane"></i> Gửi đánh giá');
                    }
                },
                error: function () {
                    nukeviet.toast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
                    submitBtn.prop('disabled', false).html('<i class="fa fa-paper-plane"></i> Gửi đánh giá');
                }
            });
        });

        $('#commentForm').submit(function (e) {
            e.preventDefault();

            var comment = $('textarea[name="comment"]').val().trim();

            if (comment.length < 5) {
                nukeviet.toast('Vui lòng nhập bình luận ít nhất 5 ký tự', 'error');
                return;
            }

            var submitBtn = $('.submit-comment-btn');
            submitBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang gửi...');

            $.ajax({
                url: location.href,
                type: 'POST',
                data: {
                    submit_comment: 1,
                    source_id: '{SOURCE.id}',
                    comment: comment,
                    parent_id: 0
                },
                dataType: 'json',
                success: function (response) {
                    if (response.status === 'success') {
                        nukeviet.toast(response.message, 'success');
                        location.reload();
                    } else {
                        nukeviet.toast(response.message, 'error');
                        submitBtn.prop('disabled', false).html('<i class="fa fa-paper-plane"></i> Gửi bình luận');
                    }
                },
                error: function () {
                    nukeviet.toast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
                    submitBtn.prop('disabled', false).html('<i class="fa fa-paper-plane"></i> Gửi bình luận');
                }
            });
        });

        // Xử lý nút trả lời bình luận
        $(document).on('click', '.reply-btn', function(e) {
            e.preventDefault();

            var btn = $(this);
            var commentId = btn.data('comment-id');
            var username = btn.data('username') || 'người dùng';

            // Tìm form reply hoặc tạo mới
            var replyFormId = 'reply-form-' + commentId;
            var existingForm = $('#' + replyFormId);

            if (existingForm.length > 0) {
                // Nếu form đã tồn tại, toggle hiển thị
                existingForm.toggle();
                return;
            }

            // Tạo form reply mới
            var replyForm = $(`
                <div class="reply-form mt-3" id="${replyFormId}" style="background: #f8f9fa; padding: 15px; border-radius: 8px; border-left: 4px solid #667eea;">
                    <h6 style="color: #667eea; margin-bottom: 15px;">
                        <i class="fa fa-reply"></i> Trả lời ${username}
                    </h6>
                    <form class="comment-reply-form" data-comment-id="${commentId}">
                        <div class="form-group">
                            <textarea class="form-control reply-textarea" name="reply_content" rows="3"
                                placeholder="Nhập phản hồi của bạn..." required></textarea>
                        </div>
                        <div class="form-group d-flex gap-2">
                            <button type="submit" class="btn btn-success btn-sm">
                                <i class="fa fa-paper-plane"></i> Gửi trả lời
                            </button>
                            <button type="button" class="btn btn-secondary btn-sm cancel-reply">
                                <i class="fa fa-times"></i> Hủy
                            </button>
                        </div>
                        <input type="hidden" name="checksess" value="{NV_CHECK_SESSION}">
                    </form>
                </div>
            `);

            // Thêm form sau comment item
            btn.closest('.comment-item, .reply-item').after(replyForm);

            // Focus vào textarea
            replyForm.find('.reply-textarea').focus();
        });

        // Xử lý nút hủy reply
        $(document).on('click', '.cancel-reply', function() {
            $(this).closest('.reply-form').remove();
        });

        // Xử lý submit form reply
        $(document).on('submit', '.comment-reply-form', function(e) {
            e.preventDefault();

            var form = $(this);
            var commentId = form.data('comment-id');
            var content = form.find('textarea[name="reply_content"]').val().trim();
            var submitBtn = form.find('button[type="submit"]');

            if (!content) {
                nukeviet.toast('Vui lòng nhập nội dung trả lời', 'error');
                return;
            }

            if (content.length < 5) {
                nukeviet.toast('Nội dung trả lời phải có ít nhất 5 ký tự', 'error');
                return;
            }

            // Disable submit button
            submitBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang gửi...');

            $.ajax({
                url: location.href,
                type: 'POST',
                data: {
                    submit_reply: 1,
                    comment_id: commentId,
                    reply_content: content,
                    source_id: '{SOURCE.id}',
                    checksess: form.find('input[name="checksess"]').val()
                },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        nukeviet.toast(response.message, 'success');
                        // Reload trang để hiển thị reply mới
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    } else {
                        nukeviet.toast(response.message, 'error');
                        submitBtn.prop('disabled', false).html('<i class="fa fa-paper-plane"></i> Gửi trả lời');
                    }
                },
                error: function() {
                    nukeviet.toast('Có lỗi xảy ra, vui lòng thử lại!', 'error');
                    submitBtn.prop('disabled', false).html('<i class="fa fa-paper-plane"></i> Gửi trả lời');
                }
            });
        });


        $('.copy-btn').click(function () {
            var textToCopy = $(this).data('copy');
            var tempInput = $('<input>');
            $('body').append(tempInput);
            tempInput.val(textToCopy).select();
            document.execCommand('copy');
            tempInput.remove();

            var btn = $(this);
            var originalText = btn.html();
            btn.html('<i class="fa fa-check"></i> Đã sao chép!');
            btn.addClass('btn-success').removeClass('btn-outline-success btn-outline-primary btn-outline-danger btn-outline-info btn-outline-warning');

            setTimeout(function () {
                btn.html(originalText);
                btn.removeClass('btn-success').addClass(btn.hasClass('copy-btn') ? 'btn-outline-success' : '');
            }, 2000);
        });

        $('#favorite-btn').click(function (e) {
            e.preventDefault();

            var $btn = $(this);
            var sourceId = $btn.data('source-id');
            var action = $btn.data('action');
            var checkss = $btn.data('checkss');
            var ajaxUrl = $btn.data('ajax-url');



            $btn.prop('disabled', true);
            var originalHtml = $btn.html();
            $btn.html('<i class="fa fa-spinner fa-spin"></i> <span>Đang xử lý...</span>');

            $.ajax({
                url: ajaxUrl,
                type: 'POST',
                dataType: 'json',
                data: {
                    ajax: 1,
                    source_id: sourceId,
                    action: action,
                    checkss: checkss
                },
                success: function (response) {

                    if (response.status === 'success') {
                        $btn.data('action', response.action);
                        $btn.removeClass('btn-danger btn-outline-danger').addClass(response.class);

                        $btn.html('<i class="bx ' + response.icon + '"></i> <span>' + response.text + '</span>');

                        $btn.data('checkss', response.checkss);

                        nukeviet.toast(response.message, 'success');
                    } else {
                        nukeviet.toast(response.message, 'error');
                        $btn.html(originalHtml);
                    }

                    $btn.prop('disabled', false);
                },
                error: function (xhr, status, error) {

                    nukeviet.toast('Có lỗi xảy ra, vui lòng thử lại', 'error');
                    $btn.html(originalHtml);
                    $btn.prop('disabled', false);
                }
            });
        });
    });
</script>
<script>
    $(document).ready(function () {
        if (!$('input[name="source_id"]').length) {
            $('body').append('<input type="hidden" name="source_id" value="{SOURCE.id}">');
        }

        $('body').addClass('admin-logged-in');
    });
</script>
<!-- END: main -->