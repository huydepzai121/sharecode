<!-- BEGIN: main -->
<div id="sharecode-detail" class="container-fluid px-0">
    <!-- Hero Section - Modern E-commerce Layout -->
    <section class="product-hero bg-light py-5">
        <div class="container">
            <div class="row g-4">
                <!-- Swiper Image Gallery - Left Column -->
                <div class="col-12 col-lg-6">
                    <div class="product-gallery-wrapper">
                        <!-- Main Swiper Gallery -->
                        <div class="swiper product-gallery-main mb-3">
                            <div class="swiper-wrapper">
                                <!-- Main Product Image -->
                                <div class="swiper-slide">
                                    <div class="gallery-image-container position-relative">
                                        <img src="{SOURCE.image_url}" alt="{SOURCE.title}"
                                            class="img-fluid rounded-3 shadow-sm w-100">
                                        <!-- BEGIN: demo_link -->
                                        <div
                                            class="demo-overlay position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center">
                                            <a href="{DEMO_LINK}" target="_blank"
                                                class="btn btn-primary btn-lg rounded-pill demo-btn">
                                                <i class="fa fa-play me-2"></i>
                                                DEMO TRỰC TIẾP
                                            </a>
                                        </div>
                                        <!-- END: demo_link -->
                                    </div>
                                </div>
                                <!-- BEGIN: demo_images -->
                                <!-- BEGIN: demo_image -->
                                <div class="swiper-slide">
                                    <div class="gallery-image-container">
                                        <img src="{DEMO_IMAGE.url}" alt="Demo {SOURCE.title}"
                                            class="img-fluid rounded-3 shadow-sm w-100">
                                    </div>
                                </div>
                                <!-- END: demo_image -->
                                <!-- END: demo_images -->
                            </div>
                            <!-- Navigation arrows -->
                            <div class="swiper-button-next"></div>
                            <div class="swiper-button-prev"></div>
                            <!-- Pagination dots -->
                            <div class="swiper-pagination"></div>
                        </div>

                        <!-- Thumbnail Gallery -->
                        <div class="swiper product-gallery-thumbs">
                            <div class="swiper-wrapper">
                                <!-- Main Product Thumbnail -->
                                <div class="swiper-slide">
                                    <div class="thumb-container">
                                        <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-fluid rounded-2">
                                    </div>
                                </div>
                                <!-- BEGIN: demo_images -->
                                <!-- BEGIN: demo_image -->
                                <div class="swiper-slide">
                                    <div class="thumb-container">
                                        <img src="{DEMO_IMAGE.url}" alt="Demo {SOURCE.title}"
                                            class="img-fluid rounded-2">
                                    </div>
                                </div>
                                <!-- END: demo_image -->
                                <!-- END: demo_images -->
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Integrated Product Information Panel - Right Column -->
                <div class="col-12 col-lg-6">
                    <div class="product-info-panel sticky-top" style="top: 2rem;">
                        <!-- Product Header -->
                        <div class="product-header mb-4">
                            <h1 class="product-title h2 fw-bold text-dark mb-3">{SOURCE.title}</h1>
                        </div>

                        <!-- Price Section -->
                        <div class="price-section mb-4 p-3 bg-white rounded-3 border">
                            <!-- BEGIN: free_price -->
                            <div class="price-display">
                                <span class="price-label text-muted small d-block mb-1">Giá sản phẩm</span>
                                <span class="price-value h3 mb-0 text-success fw-bold">
                                    <i class="{SOURCE.price_icon} me-2"></i>MIỄN PHÍ
                                </span>
                            </div>
                            <!-- END: free_price -->
                            <!-- BEGIN: contact_price -->
                            <div class="price-display">
                                <span class="price-label text-muted small d-block mb-1">Giá sản phẩm</span>
                                <span class="price-value h3 mb-0 text-warning fw-bold">
                                    <i class="{SOURCE.price_icon} me-2"></i>{SOURCE.price_text}
                                </span>
                            </div>
                            <!-- END: contact_price -->
                            <!-- BEGIN: paid_price -->
                            <div class="price-display">
                                <span class="price-label text-muted small d-block mb-1">Giá sản phẩm</span>
                                <span class="price-value h3 mb-0 text-primary fw-bold">
                                    <i class="{SOURCE.price_icon} me-2"></i>{SOURCE.price_text}
                                </span>
                            </div>
                            <!-- END: paid_price -->
                        </div>

                        <!-- Integrated Product Specifications -->
                        <div class="product-specifications mb-4">
                            <h5 class="spec-title fw-bold mb-3 text-dark">
                                <i class="fa fa-info-circle text-primary me-2"></i>Thông số kỹ thuật
                            </h5>
                            <div class="spec-list">
                                <div
                                    class="spec-item d-flex justify-content-between align-items-center py-2 border-bottom">
                                    <span class="spec-label text-muted">
                                        <i class="fa fa-folder me-2 text-primary"></i>Danh mục
                                    </span>
                                    <span class="spec-value fw-medium">{SOURCE.category_title}</span>
                                </div>
                                <div
                                    class="spec-item d-flex justify-content-between align-items-center py-2 border-bottom">
                                    <span class="spec-label text-muted">
                                        <i class="fa fa-tag me-2 text-success"></i>Loại phí
                                    </span>
                                    <span class="spec-value fw-medium">{SOURCE.fee_type_display}</span>
                                </div>
                                <!-- BEGIN: has_fee_amount -->
                                <div
                                    class="spec-item d-flex justify-content-between align-items-center py-2 border-bottom">
                                    <span class="spec-label text-muted">
                                        <i class="fa fa-money me-2 text-warning"></i>Giá
                                    </span>
                                    <span class="spec-value fw-medium text-primary">{SOURCE.fee_amount} VND</span>
                                </div>
                                <!-- END: has_fee_amount -->
                                <div
                                    class="spec-item d-flex justify-content-between align-items-center py-2 border-bottom">
                                    <span class="spec-label text-muted">
                                        <i class="fa fa-calendar me-2 text-info"></i>Ngày đăng
                                    </span>
                                    <span class="spec-value fw-medium">{SOURCE.add_time_format}</span>
                                </div>
                                <div
                                    class="spec-item d-flex justify-content-between align-items-center py-2 border-bottom">
                                    <span class="spec-label text-muted">
                                        <i class="fa fa-file me-2 text-secondary"></i>Loại file
                                    </span>
                                    <span class="spec-value fw-medium">{SOURCE.file_type_display}</span>
                                </div>
                                <div class="spec-item d-flex justify-content-between align-items-center py-2">
                                    <span class="spec-label text-muted">
                                        <i class="fa fa-hdd-o me-2 text-dark"></i>Dung lượng
                                    </span>
                                    <span class="spec-value fw-medium">{SOURCE.file_size_format}</span>
                                </div>
                            </div>
                        </div>

                        <!-- Source Link Section -->
                        <!-- BEGIN: source_link_purchased -->
                        <div class="source-link-section mb-4 p-3 bg-light rounded-3">
                            <h6 class="fw-bold mb-2 text-dark">
                                <i class="fa fa-external-link text-primary me-2"></i>Link mã nguồn
                            </h6>
                            <a href="{SOURCE.external_source_link}" target="_blank" class="btn btn-primary btn-sm">
                                <i class="fa fa-external-link me-2"></i>Xem mã nguồn trực tuyến
                            </a>
                        </div>
                        <!-- END: source_link_purchased -->

                        <!-- Action Buttons Section -->
                        <!--
                            Cấu trúc XTemplate blocks đã được tách riêng để tránh duplicate content:
                            - special_messages: Chứa thông báo cho tác giả/admin (hiển thị 1 lần)
                            - download_button: Nút tải xuống riêng biệt (hiển thị 1 lần)
                            - can_download: Nút mua hàng cho user chưa mua
                            - need_login/need_contact: Các trạng thái khác
                        -->
                        <div class="action-buttons-section">
                            <!-- Special Messages - Hiển thị thông báo đặc biệt cho tác giả/admin -->
                            <!-- BEGIN: special_messages -->
                            <!-- BEGIN: author_message -->
                            <div class="alert alert-info d-flex align-items-center mb-3">
                                <i class="fa fa-user-circle me-2"></i>
                                <span>{SPECIAL_MESSAGE}</span>
                            </div>
                            <!-- END: author_message -->
                            <!-- BEGIN: admin_message -->
                            <div class="alert alert-warning d-flex align-items-center mb-3">
                                <i class="fa fa-shield me-2"></i>
                                <span>{SPECIAL_MESSAGE}</span>
                            </div>
                            <!-- END: admin_message -->
                            <!-- END: special_messages -->

                            <!-- Primary Action Buttons - Các nút hành động chính -->
                            <div class="primary-actions mb-3">
                                <!-- BEGIN: can_download -->
                                <button class="btn btn-primary btn-lg w-100 mb-2 modern-btn" data-bs-toggle="modal"
                                    data-bs-target="#downloadModal">
                                    <i class="fa fa-shopping-cart me-2"></i>
                                    MUA NGAY
                                </button>
                                <!-- END: can_download -->
                                <!-- BEGIN: download_button -->
                                <button class="btn btn-success btn-lg w-100 mb-2 modern-btn"
                                    onclick="downloadFile('{SOURCE.id}'); return false;">
                                    <i class="fa fa-download me-2"></i>
                                    TẢI XUỐNG
                                </button>
                                <!-- END: download_button -->
                                <!-- BEGIN: need_contact -->
                                <button class="btn btn-warning btn-lg w-100 mb-2 modern-btn"
                                    onclick="showContactInfo()">
                                    <i class="fa fa-phone me-2"></i>
                                    LIÊN HỆ TƯ VẤN
                                </button>
                                <!-- END: need_contact -->
                                <!-- BEGIN: need_login -->
                                <a href="{LOGIN_URL}" class="btn btn-primary btn-lg w-100 mb-2 modern-btn">
                                    <i class="fa fa-sign-in me-2"></i>
                                    ĐĂNG NHẬP ĐỂ TẢI
                                </a>
                                <!-- END: need_login -->
                            </div>

                            <!-- Secondary Actions -->
                            <div class="secondary-actions">
                                <!-- BEGIN: favorite_button -->
                                <button class="btn btn-danger w-100 modern-btn {FAVORITE.class}" id="favorite-btn"
                                    data-source-id="{FAVORITE.source_id}" data-action="{FAVORITE.action}"
                                    data-checkss="{FAVORITE.checkss}" data-ajax-url="{FAVORITE.ajax_url}">
                                    <i class="fa {FAVORITE.icon} me-2"></i>
                                    {FAVORITE.text}
                                </button>
                                <!-- END: favorite_button -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <!-- Product Description -->
    <section class="product-description py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <ul class="nav nav-tabs car-tabs" id="carTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="description-tab" data-bs-toggle="tab"
                                data-bs-target="#description" type="button" role="tab" aria-controls="description"
                                aria-selected="true">
                                <i class="fa fa-info-circle"></i> Mô tả ngắn
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="detailed-description-tab" data-bs-toggle="tab"
                                data-bs-target="#detailed-description" type="button" role="tab"
                                aria-controls="detailed-description" aria-selected="false">
                                <i class="fa fa-file-text-o"></i> Mô tả chi tiết
                            </button>
                        </li>
                    </ul>
                    <div class="tab-content car-tab-content" id="carTabsContent">
                        <div class="tab-pane fade show active" id="description" role="tabpanel"
                            aria-labelledby="description-tab" tabindex="0">
                            <div class="description-content">
                                <div class="car-overview">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="description-text">
                                                {SOURCE.description}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="detailed-description" role="tabpanel"
                            aria-labelledby="detailed-description-tab" tabindex="0">
                            <div class="detailed-description-content">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="description-text">
                                            {SOURCE.content}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Tags -->
            <!-- BEGIN: tags -->
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    <div class="card-header bg-white border-bottom">
                        <h4 class="card-title h5 mb-0 d-flex align-items-center">
                            <i class="fa fa-tags text-danger me-2"></i>
                            Thẻ liên quan
                        </h4>
                    </div>
                    <div class="card-body">
                        <div class="d-flex flex-wrap gap-2">
                            <!-- BEGIN: tag -->
                            <a href="{TAG.link}" class="badge bg-primary text-decoration-none px-3 py-2 rounded-pill">
                                <i class="fa fa-tag me-1"></i>{TAG.name}
                            </a>
                            <!-- END: tag -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- END: tags -->
        </div>
</div>
</section>

<!-- Author Information Section -->
<section class="author-section py-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <!-- Section Title -->
                <div class="section-header mb-4">
                    <h3 class="section-title h3 text-dark mb-0 d-flex align-items-center">
                        <i class="fa fa-user text-primary me-3 fs-4"></i>
                        Thông tin tác giả
                    </h3>
                </div>

                <!-- Author Card -->
                <div class="author-card border-0 p-0">
                    <div class="row g-4 align-items-center">
                        <!-- Author Avatar -->
                        <div class="col-12 col-md-auto text-center">
                            <div class="position-relative d-inline-block">
                                <img src="{AUTHOR.avatar_url}" alt="{AUTHOR.display_name}"
                                     class="rounded-circle border border-4 border-white shadow-lg"
                                     width="120" height="120"
                                     style="object-fit: cover;">
                                <span class="position-absolute bottom-0 end-0 bg-success rounded-circle d-flex align-items-center justify-content-center border border-3 border-white"
                                      style="width: 28px; height: 28px;">
                                    <i class="fa fa-check text-white" style="font-size: 12px;"></i>
                                </span>
                            </div>
                        </div>

                        <!-- Author Info -->
                        <div class="col-12 col-md text-center text-md-start">
                            <div class="mb-3">
                                <h4 class="h3 mb-2 fw-bold">
                                    <a href="{AUTHOR.profile_url}" class="text-decoration-none text-dark">
                                        {AUTHOR.display_name}
                                    </a>
                                </h4>
                                <p class="text-muted mb-0 fs-5">@{AUTHOR.username}</p>
                            </div>

                            <!-- Author Stats -->
                            <div class="row g-3 text-center text-md-start mb-3">
                                <div class="col-4 col-md-auto">
                                    <div class="p-3 bg-light rounded-3">
                                        <div class="h4 fw-bold text-primary mb-1">{AUTHOR.total_codes}</div>
                                        <div class="small text-muted text-uppercase fw-semibold">Mã nguồn</div>
                                    </div>
                                </div>
                                <div class="col-4 col-md-auto">
                                    <div class="p-3 bg-light rounded-3">
                                        <div class="h4 fw-bold text-success mb-1">{AUTHOR.total_downloads}</div>
                                        <div class="small text-muted text-uppercase fw-semibold">Lượt tải</div>
                                    </div>
                                </div>
                                <div class="col-4 col-md-auto">
                                    <div class="p-3 bg-light rounded-3">
                                        <div class="h4 fw-bold text-warning mb-1">{AUTHOR.avg_rating}</div>
                                        <div class="small text-muted text-uppercase fw-semibold">Đánh giá TB</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Author Actions -->
                        <div class="col-12 col-md-auto text-center">
                            <a href="{AUTHOR.profile_url}" class="btn btn-primary btn-lg px-4 py-3 rounded-pill shadow-sm">
                                <i class="fa fa-user me-2"></i>
                                Xem trang cá nhân
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Reviews and Comments Section -->
<section class="reviews-comments-section py-5 bg-light">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="reviews-comments-wrapper bg-white rounded-3 shadow-sm">
                    <!-- Tab Navigation -->
                    <div class="section-tabs border-bottom">
                        <ul class="nav nav-tabs border-0" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active border-0 px-4 py-3" id="reviews-tab-btn"
                                    data-bs-toggle="tab" data-bs-target="#reviews-tab" type="button" role="tab"
                                    aria-controls="reviews-tab" aria-selected="true">
                                    <i class="fa fa-star me-2"></i>Đánh giá
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link border-0 px-4 py-3" id="comments-tab-btn" data-bs-toggle="tab"
                                    data-bs-target="#comments-tab" type="button" role="tab" aria-controls="comments-tab"
                                    aria-selected="false">
                                    <i class="fa fa-comments me-2"></i>Bình luận
                                </button>
                            </li>
                        </ul>
                    </div>

                    <!-- Tab Content -->
                    <div class="tab-content p-4">
                        <div class="tab-pane fade show active" id="reviews-tab" role="tabpanel"
                            aria-labelledby="reviews-tab-btn" tabindex="0">
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
                                                    <p class="avg-rating-text">Trung bình từ {TOTAL_REVIEWS} đánh giá
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="summary-right">
                                            <div class="rating-breakdown">
                                                <div class="rating-bar">
                                                    <span class="rating-label">5 sao</span>
                                                    <div class="rating-progress">
                                                        <div class="rating-fill" style="width: {RATING_5_PERCENT}%">
                                                        </div>
                                                    </div>
                                                    <span class="rating-count">{RATING_5_COUNT}</span>
                                                </div>
                                                <div class="rating-bar">
                                                    <span class="rating-label">4 sao</span>
                                                    <div class="rating-progress">
                                                        <div class="rating-fill" style="width: {RATING_4_PERCENT}%">
                                                        </div>
                                                    </div>
                                                    <span class="rating-count">{RATING_4_COUNT}</span>
                                                </div>
                                                <div class="rating-bar">
                                                    <span class="rating-label">3 sao</span>
                                                    <div class="rating-progress">
                                                        <div class="rating-fill" style="width: {RATING_3_PERCENT}%">
                                                        </div>
                                                    </div>
                                                    <span class="rating-count">{RATING_3_COUNT}</span>
                                                </div>
                                                <div class="rating-bar">
                                                    <span class="rating-label">2 sao</span>
                                                    <div class="rating-progress">
                                                        <div class="rating-fill" style="width: {RATING_2_PERCENT}%">
                                                        </div>
                                                    </div>
                                                    <span class="rating-count">{RATING_2_COUNT}</span>
                                                </div>
                                                <div class="rating-bar">
                                                    <span class="rating-label">1 sao</span>
                                                    <div class="rating-progress">
                                                        <div class="rating-fill" style="width: {RATING_1_PERCENT}%">
                                                        </div>
                                                    </div>
                                                    <span class="rating-count">{RATING_1_COUNT}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END: reviews_summary -->

                                <!-- Add Review Form -->
                                <!-- BEGIN: can_review -->
                                <div class="add-review-section mb-5">
                                    <div class="card border-0 shadow-sm">
                                        <div class="card-header bg-primary text-white">
                                            <h4 class="card-title mb-0">
                                                <i class="fa fa-edit me-2"></i>Viết đánh giá của bạn
                                            </h4>
                                        </div>
                                        <div class="card-body">
                                            <form id="reviewForm" class="review-form">
                                                <!-- Rating Section -->
                                                <div class="mb-4">
                                                    <label class="form-label fw-semibold mb-3">
                                                        <i class="fa fa-star text-warning me-2"></i>Đánh giá của bạn:
                                                    </label>
                                                    <div class="star-rating-input d-flex align-items-center gap-2 mb-2">
                                                        <div class="rating-stars">
                                                            <input type="radio" name="rating" value="5" id="star5" class="d-none">
                                                            <label for="star5" class="star-label fs-3 text-muted cursor-pointer">★</label>
                                                            <input type="radio" name="rating" value="4" id="star4" class="d-none">
                                                            <label for="star4" class="star-label fs-3 text-muted cursor-pointer">★</label>
                                                            <input type="radio" name="rating" value="3" id="star3" class="d-none">
                                                            <label for="star3" class="star-label fs-3 text-muted cursor-pointer">★</label>
                                                            <input type="radio" name="rating" value="2" id="star2" class="d-none">
                                                            <label for="star2" class="star-label fs-3 text-muted cursor-pointer">★</label>
                                                            <input type="radio" name="rating" value="1" id="star1" class="d-none">
                                                            <label for="star1" class="star-label fs-3 text-muted cursor-pointer">★</label>
                                                        </div>
                                                        <span class="rating-text-display text-muted ms-3">Chọn số sao</span>
                                                    </div>
                                                    <div class="form-text">Click vào sao để đánh giá từ 1-5 sao</div>
                                                </div>

                                                <!-- Comment Section -->
                                                <div class="mb-4">
                                                    <label class="form-label fw-semibold">
                                                        <i class="fa fa-comment text-info me-2"></i>Nhận xét chi tiết:
                                                    </label>
                                                    <textarea name="comment" class="form-control" rows="6"
                                                        placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này... (tối thiểu 10 ký tự)"
                                                        style="resize: vertical;"></textarea>
                                                    <div class="form-text">
                                                        <i class="fa fa-info-circle me-1"></i>
                                                        Hãy chia sẻ chi tiết về chất lượng, tính năng, và trải nghiệm sử dụng sản phẩm
                                                    </div>
                                                </div>

                                                <!-- Submit Button -->
                                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                                    <button type="submit" class="btn btn-primary btn-lg submit-review-btn">
                                                        <i class="fa fa-paper-plane me-2"></i>Gửi đánh giá
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- END: can_review -->

                                <!-- BEGIN: need_login_review -->
                                <div class="login-to-review mb-5">
                                    <div class="card border-0 shadow-sm">
                                        <div class="card-body text-center py-5">
                                            <div class="login-prompt">
                                                <div class="mb-4">
                                                    <i class="fa fa-user-circle fa-4x text-primary"></i>
                                                </div>
                                                <h4 class="mb-3">Đăng nhập để viết đánh giá</h4>
                                                <p class="text-muted mb-4">
                                                    Bạn cần đăng nhập để có thể chia sẻ đánh giá và nhận xét về sản phẩm này
                                                </p>
                                                <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                                                    <a href="{LOGIN_URL}" class="btn btn-primary btn-lg">
                                                        <i class="fa fa-sign-in-alt me-2"></i>Đăng nhập ngay
                                                    </a>
                                                    <a href="{REGISTER_URL}" class="btn btn-secondary btn-lg">
                                                        <i class="fa fa-user-plus me-2"></i>Đăng ký tài khoản
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END: need_login_review -->

                                <!-- Reviews List -->
                                <!-- BEGIN: reviews_list -->
                                <div class="reviews-list">
                                    <h4 class="reviews-list-title">
                                        <i class="fa fa-comments"></i> Đánh giá gần đây
                                    </h4>
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
                                                    <span
                                                        class="admin-reply-date">{REVIEW.admin_reply_time_format}</span>
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
                                                        <textarea class="form-control" name="admin_reply_content"
                                                            rows="4"
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
                        <div class="tab-pane fade" id="comments-tab" role="tabpanel" aria-labelledby="comments-tab-btn"
                            tabindex="0">
                            <div class="comments-section">
                                <h4 class="comments-title">
                                    <i class="fa fa-comments"></i> Bình luận từ người dùng
                                    <span class="comments-count">({TOTAL_COMMENTS} bình luận)</span>
                                </h4>

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
                                                <button class="reply-btn" data-comment-id="{COMMENT.id}"
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
                                                    <span
                                                        class="admin-reply-date">{COMMENT.admin_reply_time_format}</span>
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
                                                        <button class="reply-btn" data-comment-id="{COMMENT.id}"
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
</section>
</div>

<div class="modal fade" id="downloadModal" tabindex="-1" aria-labelledby="downloadModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="downloadModalLabel">
                    <i class="fa fa-credit-card text-primary me-2"></i>Xác nhận thanh toán
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="card border-primary">
                    <div class="card-body">
                        <div class="row align-items-center">
                            <div class="col-8">
                                <h6 class="text-primary fw-bold mb-1">{SOURCE.title}</h6>
                                <p class="text-muted small mb-0">Bao gồm: Source code + Database + Hướng dẫn</p>
                            </div>
                            <div class="col-4 text-end">
                                <div class="price-display">
                                    <!-- BEGIN: free_modal -->
                                    <span class="h5 text-success fw-bold mb-0">0 VNĐ</span>
                                    <!-- END: free_modal -->
                                    <!-- BEGIN: contact_modal -->
                                    <span class="h6 text-warning fw-bold mb-0">Liên hệ để biết giá</span>
                                    <!-- END: contact_modal -->
                                    <!-- BEGIN: paid_modal -->
                                    <span class="h5 text-primary fw-bold mb-0">{SOURCE.price_text}</span>
                                    <!-- END: paid_modal -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- BEGIN: user_balance -->
                <div class="card border-secondary mt-3">
                    <div class="card-body">
                        <div class="row align-items-center mb-2">
                            <div class="col-6">
                                <span class="text-muted">Số dư hiện tại:</span>
                            </div>
                            <div class="col-6 text-end">
                                <strong class="text-success">{USER_BALANCE} VNĐ</strong>
                            </div>
                        </div>
                        <hr class="my-2">
                        <div class="row align-items-center">
                            <div class="col-6">
                                <span class="text-muted">Số dư sau thanh toán:</span>
                            </div>
                            <div class="col-6 text-end">
                                <strong class="{BALANCE_AFTER_CLASS}">{BALANCE_AFTER} VNĐ</strong>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: user_balance -->

                <!-- BEGIN: insufficient_balance -->
                <div class="alert alert-warning d-flex align-items-center mt-3">
                    <i class="fa fa-exclamation-triangle me-2"></i>
                    <div>
                        <strong>Số dư không đủ!</strong> Bạn cần nạp thêm tiền để thực hiện giao dịch này.
                    </div>
                </div>
                <!-- END: insufficient_balance -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy bỏ</button>
                <!-- BEGIN: can_pay -->
                <button type="button" id="confirmPayment" class="btn btn-primary">
                    <i class="fa fa-credit-card me-2"></i>Thanh toán
                </button>
                <!-- END: can_pay -->
                <!-- BEGIN: need_topup -->
                <a href="{TOPUP_URL}" class="btn btn-warning">
                    <i class="fa fa-plus me-2"></i>Nạp tiền
                </a>
                <a href="/index.php?nv=vi&nv=sharecode&op=history" class="btn btn-info">
                    <i class="fa fa-history me-2"></i>Lịch sử mua
                </a>
                <!-- END: need_topup -->
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="imageModalLabel">
                    <i class="fa fa-image text-primary"></i> Xem ảnh demo
                </h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <img id="modalImage" src="" alt="Demo Image" class="img-responsive"
                    style="max-width: 100%; height: auto;">
            </div>
        </div>
    </div>
</div>

<script>
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
                phoneContent += '<button class="btn btn-sm btn-success copy-btn" data-copy="' + data.phone + '"><i class="fa fa-copy"></i> Sao chép</button>';
                phoneContent += '</div></div></div>';
            }

            if (data.zalo) {
                phoneContent += '<div class="contact-item">';
                phoneContent += '<div class="contact-icon"><i class="fa fa-comment fa-2x text-primary"></i></div>';
                phoneContent += '<div class="contact-details">';
                phoneContent += '<h6>Zalo</h6>';
                phoneContent += '<div class="contact-value">';
                phoneContent += '<span class="contact-text">' + data.zalo + '</span>';
                phoneContent += '<button class="btn btn-sm btn-primary copy-btn" data-copy="' + data.zalo + '"><i class="fa fa-copy"></i> Sao chép</button>';
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
            emailContent += '<button class="btn btn-sm btn-danger copy-btn" data-copy="' + data.email + '"><i class="fa fa-copy"></i> Sao chép</button>';
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
                socialContent += '<button class="btn btn-sm btn-primary copy-btn" data-copy="' + data.facebook + '"><i class="fa fa-copy"></i> Sao chép</button>';
                socialContent += '</div></div></div>';
            }

            if (data.telegram) {
                socialContent += '<div class="contact-item">';
                socialContent += '<div class="contact-icon"><i class="fa fa-telegram fa-2x text-info"></i></div>';
                socialContent += '<div class="contact-details">';
                socialContent += '<h6>Telegram</h6>';
                socialContent += '<div class="contact-value">';
                socialContent += '<span class="contact-text">' + data.telegram + '</span>';
                socialContent += '<button class="btn btn-sm btn-info copy-btn" data-copy="' + data.telegram + '"><i class="fa fa-copy"></i> Sao chép</button>';
                socialContent += '</div></div></div>';
            }

            if (data.skype) {
                socialContent += '<div class="contact-item">';
                socialContent += '<div class="contact-icon"><i class="fa fa-skype fa-2x text-info"></i></div>';
                socialContent += '<div class="contact-details">';
                socialContent += '<h6>Skype</h6>';
                socialContent += '<div class="contact-value">';
                socialContent += '<a href="skype:' + data.skype + '?chat" class="contact-link skype-link">' + data.skype + '</a>';
                socialContent += '<button class="btn btn-sm btn-info copy-btn" data-copy="' + data.skype + '"><i class="fa fa-copy"></i> Sao chép</button>';
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
                otherContent += '<button class="btn btn-sm btn-success copy-btn" data-copy="' + data.website + '"><i class="fa fa-copy"></i> Sao chép</button>';
                otherContent += '</div></div></div>';
            }

            if (data.address) {
                otherContent += '<div class="contact-item">';
                otherContent += '<div class="contact-icon"><i class="fa fa-map-marker fa-2x text-warning"></i></div>';
                otherContent += '<div class="contact-details">';
                otherContent += '<h6>Địa chỉ</h6>';
                otherContent += '<div class="contact-value">';
                otherContent += '<span class="contact-text">' + data.address + '</span>';
                otherContent += '<button class="btn btn-sm btn-warning copy-btn" data-copy="' + data.address + '"><i class="fa fa-copy"></i> Sao chép</button>';
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
        btn.removeClass('btn-success btn-primary btn-danger btn-info btn-warning').addClass('btn-success');

        setTimeout(function () {
            btn.html(originalHtml);
            btn.attr('class', originalClass);
        }, 2000);
    }

    function showImageModal(imageUrl) {
        $('#modalImage').attr('src', imageUrl);
        $('#imageModal').modal('show');
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

        // Enhanced star rating functionality
        $('.star-rating-input .star-label').on('click', function() {
            var $input = $(this).prev('input[type="radio"]');
            var rating = $input.val();

            // Check the radio button
            $input.prop('checked', true);

            var ratingTexts = {
                '1': '⭐ Rất tệ',
                '2': '⭐⭐ Tệ',
                '3': '⭐⭐⭐ Bình thường',
                '4': '⭐⭐⭐⭐ Tốt',
                '5': '⭐⭐⭐⭐⭐ Xuất sắc'
            };

            $('.rating-text-display').text(ratingTexts[rating] || 'Chọn số sao')
                .addClass('has-rating');

            // Update star colors
            $('.star-rating-input .star-label').removeClass('active');
            $input.nextAll('.star-label').addBack().addClass('active');
        });

        // Hover effects for stars
        $('.star-rating-input .star-label').on('mouseenter', function() {
            var $this = $(this);
            $('.star-rating-input .star-label').removeClass('hover');
            $this.nextAll('.star-label').addBack().addClass('hover');
        });

        $('.star-rating-input').on('mouseleave', function() {
            $('.star-rating-input .star-label').removeClass('hover');
        });

        $('#reviewForm').submit(function (e) {
            e.preventDefault();

            var rating = $('input[name="rating"]:checked').val();
            var comment = '';

            if (typeof CKEDITOR !== 'undefined' && CKEDITOR.instances['comment-editor']) {
                comment = CKEDITOR.instances['comment-editor'].getData().trim();
                var textOnly = comment.replace(/<[^>]*>/g, '').trim();
                if (textOnly.length < 10) {
                    nukeviet.toast('Vui lòng nhập nhận xét ít nhất 10 ký tự', 'error');
                    return;
                }
            } else {
                comment = $('textarea[name="comment"]').val().trim();
                if (comment.length < 10) {
                    nukeviet.toast('Vui lòng nhập nhận xét ít nhất 10 ký tự', 'error');
                    return;
                }
            }

            // Enhanced validation with Bootstrap 5 styling
            var isValid = true;

            if (!rating) {
                $('.star-rating-input').addClass('is-invalid');
                nukeviet.toast('⭐ Vui lòng chọn số sao đánh giá', 'error');
                isValid = false;
            } else {
                $('.star-rating-input').removeClass('is-invalid');
            }

            if (!comment || comment.length < 10) {
                $('textarea[name="comment"]').addClass('is-invalid');
                nukeviet.toast('💬 Vui lòng nhập nhận xét ít nhất 10 ký tự', 'error');
                isValid = false;
            } else {
                $('textarea[name="comment"]').removeClass('is-invalid').addClass('is-valid');
            }

            if (!isValid) {
                return;
            }

            var submitBtn = $('.submit-review-btn');
            submitBtn.prop('disabled', true)
                .html('<i class="fa fa-spinner fa-spin me-2"></i>Đang gửi đánh giá...')
                .addClass('loading');

            $.ajax({
                url: location.href,
                type: 'POST',
                data: {
                    submit_review: 1,
                    source_id: '{SOURCE.id}',
                    rating: rating,
                    comment: comment
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
            btn.addClass('btn-success').removeClass('btn-success btn-primary btn-danger btn-info btn-warning');

            setTimeout(function () {
                btn.html(originalText);
                btn.removeClass('btn-success').addClass(btn.hasClass('copy-btn') ? 'btn-success' : '');
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
                        $btn.removeClass('btn-danger btn-danger').addClass(response.class);

                        $btn.html('<i class="fa ' + response.icon + '"></i> <span>' + response.text + '</span>');

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

<script src="{NV_BASE_SITEURL}themes/default/js/sharecode-admin-reply.js"></script>
<script>
    $(document).ready(function () {
        if (!$('input[name="source_id"]').length) {
            $('body').append('<input type="hidden" name="source_id" value="{SOURCE.id}">');
        }

        $('body').addClass('admin-logged-in');
    });

    // Initialize AOS (Animate On Scroll) animations - Tắt để tối ưu hiệu suất
    // if (typeof AOS !== 'undefined') {
    //     AOS.init({
    //         duration: 800,
    //         easing: 'ease-in-out',
    //         once: true,
    //         offset: 100,
    //         delay: 0,
    //         disable: function() {
    //             // Disable AOS on mobile devices for better performance
    //             return window.innerWidth < 768;
    //         }
    //     });
    // }

    // Initialize Swiper Gallery
    // Initialize thumbnail gallery first
    const galleryThumbs = new Swiper('.product-gallery-thumbs', {
        spaceBetween: 10,
        slidesPerView: 4,
        freeMode: true,
        watchSlidesProgress: true,
        breakpoints: {
            320: {
                slidesPerView: 3,
                spaceBetween: 8
            },
            768: {
                slidesPerView: 4,
                spaceBetween: 10
            },
            1024: {
                slidesPerView: 5,
                spaceBetween: 12
            }
        }
    });

    // Initialize main gallery
    const galleryMain = new Swiper('.product-gallery-main', {
        spaceBetween: 10,
        effect: 'fade',
        fadeEffect: {
            crossFade: true
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        thumbs: {
            swiper: galleryThumbs,
        },
        keyboard: {
            enabled: true,
        },
        mousewheel: {
            enabled: false,
        },
        loop: false,
        autoplay: false,
        speed: 300,
    });

    // Add loading states for buttons
    document.querySelectorAll('.modern-btn').forEach(button => {
        button.addEventListener('click', function (e) {
            if (!this.classList.contains('loading')) {
                this.classList.add('loading');
                const originalText = this.innerHTML;
                this.innerHTML = '<i class="fa fa-spinner fa-spin me-2"></i>Đang xử lý...';

                // Remove loading state after 2 seconds (adjust as needed)
                setTimeout(() => {
                    this.classList.remove('loading');
                    this.innerHTML = originalText;
                }, 2000);
            }
        });
    });

    // Add ripple effect to buttons
    document.querySelectorAll('.modern-btn').forEach(button => {
        button.addEventListener('click', function (e) {
            const ripple = document.createElement('span');
            const rect = this.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = e.clientX - rect.left - size / 2;
            const y = e.clientY - rect.top - size / 2;

            ripple.style.width = ripple.style.height = size + 'px';
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';
            ripple.classList.add('ripple');

            this.appendChild(ripple);

            setTimeout(() => {
                ripple.remove();
            }, 600);
        });
    });
</script>

<style>
    /* Ripple effect styles */
    .modern-btn {
        position: relative;
        overflow: hidden;
    }

    .ripple {
        position: absolute;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.6);
        transform: scale(0);
        animation: ripple-animation 0.6s linear;
        pointer-events: none;
    }

    @keyframes ripple-animation {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }

    /* Loading state styles */
    .modern-btn.loading {
        pointer-events: none;
        opacity: 0.7;
    }

    /* Star Rating Styles */
    .star-rating-input {
        display: flex;
        align-items: center;
        gap: 4px;
    }

    .star-rating-input .rating-stars {
        display: flex;
        flex-direction: row-reverse;
        gap: 2px;
    }

    .star-rating-input .star-label {
        color: #dee2e6;
        font-size: 2rem;
        cursor: pointer;
        transition: all 0.2s ease;
        user-select: none;
        line-height: 1;
        margin: 0;
    }

    .star-rating-input .star-label:hover,
    .star-rating-input .star-label.hover {
        color: #ffc107;
        transform: scale(1.1);
    }

    .star-rating-input input[type="radio"]:checked ~ .star-label,
    .star-rating-input .star-label.active {
        color: #ffc107;
    }

    .star-rating-input .star-label.hover {
        color: #ffed4e !important;
    }

    .star-rating-input .star-label:active {
        transform: scale(0.95);
    }

    /* Rating text display */
    .rating-text-display {
        font-weight: 500;
        color: #6c757d;
        transition: color 0.2s ease;
    }

    .rating-text-display.has-rating {
        color: #495057;
        font-weight: 600;
    }

    /* Review form enhancements */
    .add-review-section .card {
        border: 1px solid #e9ecef;
        transition: box-shadow 0.2s ease;
    }

    .add-review-section .card:hover {
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
    }

    .add-review-section .card-header {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        border-bottom: none;
    }

    .add-review-section .form-control:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    .add-review-section .submit-review-btn {
        background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
        border: none;
        transition: all 0.2s ease;
        box-shadow: 0 2px 4px rgba(0, 123, 255, 0.3);
    }

    .add-review-section .submit-review-btn:hover {
        transform: translateY(-1px);
        box-shadow: 0 4px 8px rgba(0, 123, 255, 0.4);
    }

    .add-review-section .submit-review-btn:active {
        transform: translateY(0);
    }

    /* Login prompt styles */
    .login-to-review .card {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border: 1px solid #dee2e6;
    }

    .login-to-review .fa-user-circle {
        opacity: 0.7;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .star-rating-input .star-label {
            font-size: 1.5rem;
        }

        .add-review-section .card-body {
            padding: 1rem;
        }

        .rating-text-display {
            font-size: 0.9rem;
        }
    }
</style>

<!-- END: main -->