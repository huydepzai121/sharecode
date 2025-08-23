<!-- BEGIN: main -->
<!-- Load CKEditor -->
<script src="{NV_BASE_SITEURL}assets/js/ckeditor/ckeditor.js"></script>

<div id="sharecode-detail" class="container">
    <!-- Main Content -->
    <div class="row">
        <div class="col-sm-24">
            <div class="detail-container">
                <!-- Hero Section -->
                <div class="detail-hero">
                    <div class="hero-layout">
                        <div class="hero-image">
                            <div class="detail-image">
                                <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-responsive">
                                <!-- BEGIN: demo_link -->
                                <div class="demo-overlay">
                                    <a href="{DEMO_LINK}" target="_blank" class="demo-btn">
                                        <i class="fa fa-play"></i> DEMO TRỰC TIẾP
                                    </a>
                                </div>
                                <!-- END: demo_link -->
                            </div>
                        </div>
                        <div class="hero-content">
                            <div class="detail-info">
                                <!-- Title & Stats -->
                                <h1 class="detail-title">{SOURCE.title}</h1>
                                
                                <div class="detail-stats">
                                    <!-- BEGIN: has_reviews -->
                                    <div class="rating-section">
                                        <span class="rating-stars">{AVG_RATING_STARS}</span>
                                        <span class="rating-text">({TOTAL_REVIEWS} đánh giá)</span>
                                    </div>
                                    <!-- END: has_reviews -->
                                    <!-- BEGIN: no_reviews_hero -->
                                    <div class="rating-section">
                                        <span class="rating-stars">☆☆☆☆☆</span>
                                        <span class="rating-text">(Chưa có đánh giá)</span>
                                    </div>
                                    <!-- END: no_reviews_hero -->
                                    <div class="view-stats">
                                        <span class="stat-item">
                                            <i class="fa fa-eye"></i> {SOURCE.num_view} lượt xem
                                        </span>
                                        <span class="stat-item">
                                            <i class="fa fa-download"></i> {SOURCE.num_download} lượt tải
                                        </span>
                                    </div>
                                </div>

                                <!-- Price Section -->
                                <div class="price-section">
                                    <!-- BEGIN: free_price -->
                                    <div class="price-display free">
                                        <span class="price-label">Giá:</span>
                                        <span class="price-value"><i class="{SOURCE.price_icon}"></i> MIỄN PHÍ</span>
                                    </div>
                                    <!-- END: free_price -->
                                    <!-- BEGIN: contact_price -->
                                    <div class="price-display contact">
                                        <span class="price-label">Giá:</span>
                                        <span class="price-value"><i class="{SOURCE.price_icon}"></i> {SOURCE.price_text}</span>
                                    </div>
                                    <!-- END: contact_price -->
                                    <!-- BEGIN: paid_price -->
                                    <div class="price-display paid">
                                        <span class="price-label">Giá:</span>
                                        <span class="price-value"><i class="{SOURCE.price_icon}"></i> {SOURCE.price_text}</span>
                                    </div>
                                    <!-- END: paid_price -->
                                </div>

                                <!-- Action Buttons -->
                                <div class="action-buttons">
                                    <!-- BEGIN: can_download -->
                                    <button class="purchase-btn" data-toggle="modal" data-target="#downloadModal">
                                        <i class="fa fa-shopping-cart"></i>
                                        <span>MUA NGAY</span>
                                    </button>
                                    <!-- END: can_download -->
                                    <!-- BEGIN: already_purchased -->
                                    <button class="download-btn" onclick="downloadFile({SOURCE.id}); return false;">
                                        <i class="fa fa-download"></i>
                                        <span>TẢI XUỐNG</span>
                                    </button>
                                    <!-- END: already_purchased -->
                                    <!-- BEGIN: need_contact -->
                                    <div class="contact-buttons">
                                        <button class="contact-btn primary" onclick="showContactInfo()">
                                            <i class="fa fa-phone"></i>
                                            <span>LIÊN HỆ NGAY</span>
                                        </button>
                                    </div>
                                    <!-- END: need_contact -->
                                    <!-- BEGIN: need_login -->
                                    <a href="{LOGIN_URL}" class="login-btn">
                                        <i class="fa fa-sign-in"></i>
                                        <span>ĐĂNG NHẬP ĐỂ TẢI</span>
                                    </a>
                                    <!-- END: need_login -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product Details -->
                <div class="detail-specs">
                    <h3 class="specs-title">
                        <i class="fa fa-info-circle"></i> Thông tin sản phẩm
                    </h3>
                    <div class="specs-grid">
                        <div class="spec-item">
                            <span class="spec-label">Danh mục</span>
                            <span class="spec-value">{CATEGORY.title}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Thể loại</span>
                            <span class="spec-value">Website</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Nhóm code</span>
                            <span class="spec-value">Code thần thánh <span class="fire-icon">🔥</span></span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Ngày đăng</span>
                            <span class="spec-value">{SOURCE.add_time_format}</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Loại file</span>
                            <span class="spec-value">Full code</span>
                        </div>
                        <div class="spec-item">
                            <span class="spec-label">Dung lượng</span>
                            <span class="spec-value">1 MB</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Description Section -->
    <div class="row">
        <div class="col-sm-24">
            <div class="detail-description">
                <h3 class="description-title">
                    <i class="fa fa-file-text-o"></i> Mô tả chi tiết
                </h3>
                <div class="description-content">
                    {SOURCE.description}
                </div>

                <!-- Tags -->
                <!-- BEGIN: tags -->
                <div class="tags-section">
                    <h4 class="tags-title">
                        <i class="fa fa-tags"></i> Thẻ liên quan
                    </h4>
                    <div class="tags-list">
                        <!-- BEGIN: tag -->
                        <a href="{TAG.link}" class="tag-item">{TAG.name}</a>
                        <!-- END: tag -->
                    </div>
                </div>
                <!-- END: tags -->
            </div>
        </div>
    </div>

    <!-- Author Information Section -->
    <div class="row">
        <div class="col-sm-24">
            <div class="author-section">
                <h3 class="author-title">
                    <i class="fa fa-user"></i> Thông tin tác giả
                </h3>
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

    <!-- Reviews Section -->
    <div class="row">
        <div class="col-sm-24">
            <div class="reviews-section">
                <h3 class="reviews-title">
                    <i class="fa fa-star"></i> Đánh giá từ người dùng
                    <!-- BEGIN: has_reviews -->
                    <span class="reviews-count">({TOTAL_REVIEWS} đánh giá)</span>
                    <!-- END: has_reviews -->
                </h3>

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

                <!-- Add Review Form -->
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
                            <textarea name="comment" class="review-textarea" rows="6" cols="100" placeholder="Chia sẻ trải nghiệm của bạn về sản phẩm này..."></textarea>
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
    </div>
</div>

<!-- Download Modal -->
<div class="modal fade" id="downloadModal" tabindex="-1" role="dialog" aria-labelledby="downloadModalLabel">
    <div class="modal-dialog modal-md" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
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
                <button type="button" class="btn btn-default" data-dismiss="modal">Hủy bỏ</button>
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
// Function to show contact information using NukeViet modalShow
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
    
    // Initialize copy buttons after modal is shown
    setTimeout(function() {
        initCopyButtons();
        initContactTabs();
    }, 100);
}

function buildContactModalContent(data) {
    var html = '<div class="contact-modal-wrapper">';
    
    // Header
    html += '<div class="contact-info-header">';
    html += '<h5 class="text-primary"><strong>' + data.title + '</strong></h5>';
    html += '<p class="text-muted">Vui lòng liên hệ trực tiếp với tác giả để biết thêm thông tin về giá cả và điều kiện sử dụng.</p>';
    html += '</div>';
    
    // Build tabs
    var tabs = [];
    var tabContent = [];
    var hasPhone = data.phone || data.zalo;
    var hasEmail = data.email;
    var hasSocial = data.facebook || data.telegram || data.skype;
    var hasOther = data.website || data.address;
    
    // Phone tab
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
    
    // Email tab
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
    
    // Social tab
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
    
    // Other tab
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
    
    // Build complete tabs HTML
    if (tabs.length > 1) {
        html += '<div class="contact-tabs">';
        html += '<ul class="nav nav-tabs">' + tabs.join('') + '</ul>';
        html += '<div class="tab-content">' + tabContent.join('') + '</div>';
        html += '</div>';
    } else if (tabContent.length > 0) {
        // If only one tab, show content directly without tabs
        html += '<div class="single-contact-content">' + tabContent[0].replace('tab-pane active', 'contact-content') + '</div>';
    }
    
    // Footer tip
    html += '<div class="contact-tips text-center" style="margin-top: 20px; padding-top: 15px; border-top: 1px solid #dee2e6;">';
    html += '<small class="text-muted"><i class="fa fa-info-circle"></i> Tip: Nhấn vào số điện thoại hoặc email để liên hệ trực tiếp</small>';
    html += '</div>';
    
    html += '</div>';
    return html;
}

function initCopyButtons() {
    $(document).off('click', '.copy-btn').on('click', '.copy-btn', function(e) {
        e.preventDefault();
        var textToCopy = $(this).data('copy');
        
        // Modern copy method
        if (navigator.clipboard) {
            navigator.clipboard.writeText(textToCopy).then(function() {
                showCopySuccess($(e.target).closest('.copy-btn'));
            });
        } else {
            // Fallback for older browsers
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
    
    setTimeout(function() {
        btn.html(originalHtml);
        btn.attr('class', originalClass);
    }, 2000);
}

function initContactTabs() {
    // Simple tab switching
    $(document).off('click', '.nav-link[data-toggle="tab"]').on('click', '.nav-link[data-toggle="tab"]', function(e) {
        e.preventDefault();
        var target = $(this).attr('href');
        
        // Remove active from all tabs and contents
        $('.nav-link').removeClass('active');
        $('.tab-pane').removeClass('active');
        
        // Add active to clicked tab and corresponding content
        $(this).addClass('active');
        $(target).addClass('active');
    });
}

function downloadFile(sourceId) {
    // Tạo download token
    var token = '';
    
    $.ajax({
        url: location.href,
        type: 'POST',
        data: {
            get_download_token: 1,
            source_id: sourceId
        },
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                // Tạo download URL và tự động download
                var downloadUrl = response.download_url;
                window.location.href = downloadUrl;
            } else {
                alert('Lỗi: ' + response.message);
            }
        },
        error: function() {
            alert('Có lỗi xảy ra khi tải file!');
        }
    });
}

$(document).ready(function() {
    // Payment handler
    $('#confirmPayment').click(function() {
        var btn = $(this);
        btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý...');
        
        $.ajax({
            url: location.href,
            type: 'POST',
            data: {
                process_payment: 1,
                source_id: {SOURCE.id}
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    $('#downloadModal').modal('hide');
                    // Chuyển về trang lịch sử
                    window.location.href = '{HISTORY_URL}';
                } else {
                    alert('Lỗi: ' + response.message);
                    btn.prop('disabled', false).html('<i class="fa fa-credit-card"></i> Thanh toán');
                }
            },
            error: function() {
                alert('Có lỗi xảy ra, vui lòng thử lại!');
                btn.prop('disabled', false).html('<i class="fa fa-credit-card"></i> Thanh toán');
            }
        });
    });

    // Star rating handler
    $('.star-rating-input input[type="radio"]').change(function() {
        var rating = $(this).val();
        var ratingTexts = {
            '1': 'Rất tệ',
            '2': 'Tệ', 
            '3': 'Bình thường',
            '4': 'Tốt',
            '5': 'Xuất sắc'
        };
        $('.rating-text-display').text(ratingTexts[rating] || 'Chọn số sao');
        
        // Update star display
        $('.star-rating-input .star-label').removeClass('active');
        $(this).nextAll('.star-label').addBack().addClass('active');
    });

    // Review form submit
    $('#reviewForm').submit(function(e) {
        e.preventDefault();

        var rating = $('input[name="rating"]:checked').val();
        var comment = '';

        // Lấy nội dung từ CKEditor nếu có, nếu không thì từ textarea thường
        if (typeof CKEDITOR !== 'undefined' && CKEDITOR.instances['comment-editor']) {
            comment = CKEDITOR.instances['comment-editor'].getData().trim();
            // Loại bỏ HTML tags để kiểm tra độ dài text thuần
            var textOnly = comment.replace(/<[^>]*>/g, '').trim();
            if (textOnly.length < 10) {
                alert('Vui lòng nhập nhận xét ít nhất 10 ký tự');
                return;
            }
        } else {
            comment = $('textarea[name="comment"]').val().trim();
            if (comment.length < 10) {
                alert('Vui lòng nhập nhận xét ít nhất 10 ký tự');
                return;
            }
        }

        if (!rating) {
            alert('Vui lòng chọn số sao đánh giá');
            return;
        }

        if (!comment) {
            alert('Vui lòng nhập nhận xét');
            return;
        }
        
        var submitBtn = $('.submit-review-btn');
        submitBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang gửi...');
        
        $.ajax({
            url: location.href,
            type: 'POST',
            data: {
                submit_review: 1,
                source_id: {SOURCE.id},
                rating: rating,
                comment: comment
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert('Cảm ơn bạn đã đánh giá!');
                    location.reload(); // Reload để hiển thị đánh giá mới
                } else {
                    alert('Lỗi: ' + response.message);
                    submitBtn.prop('disabled', false).html('<i class="fa fa-paper-plane"></i> Gửi đánh giá');
                }
            },
            error: function() {
                alert('Có lỗi xảy ra, vui lòng thử lại!');
                submitBtn.prop('disabled', false).html('<i class="fa fa-paper-plane"></i> Gửi đánh giá');
            }
        });
    });
    
    // Copy functionality for contact modal
    $('.copy-btn').click(function() {
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
        
        setTimeout(function() {
            btn.html(originalText);
            btn.removeClass('btn-success').addClass(btn.hasClass('copy-btn') ? 'btn-outline-success' : '');
        }, 2000);
    });
});
</script>

<style>
/* ShareCode Detail Page Styles */
#sharecode-detail {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

#sharecode-detail .detail-container {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    overflow: hidden;
    margin-bottom: 30px;
}

#sharecode-detail .detail-hero {
    padding: 30px;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    border-bottom: 1px solid #dee2e6;
}

#sharecode-detail .hero-layout {
    display: flex;
    gap: 30px;
    align-items: flex-start;
}

#sharecode-detail .hero-image {
    flex: 0 0 300px;
}

#sharecode-detail .hero-content {
    flex: 1;
}

#sharecode-detail .detail-image {
    position: relative;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

#sharecode-detail .detail-image img {
    width: 100%;
    height: 250px;
    object-fit: cover;
    transition: transform 0.3s ease;
}

#sharecode-detail .detail-image:hover img {
    transform: scale(1.05);
}

#sharecode-detail .demo-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0,0,0,0.7);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.3s ease;
}

#sharecode-detail .detail-image:hover .demo-overlay {
    opacity: 1;
}

#sharecode-detail .demo-btn {
    background: #ff6b6b;
    color: white;
    padding: 12px 24px;
    border-radius: 25px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
    border: 2px solid #ff6b6b;
}

#sharecode-detail .demo-btn:hover {
    background: transparent;
    color: #ff6b6b;
    text-decoration: none;
}

#sharecode-detail .detail-info {
    padding-left: 30px;
}

#sharecode-detail .detail-title {
    color: #2c3e50;
    font-size: 28px;
    font-weight: 700;
    margin-bottom: 20px;
    line-height: 1.3;
}

#sharecode-detail .detail-stats {
    margin-bottom: 25px;
}

#sharecode-detail .rating-section {
    margin-bottom: 10px;
}

#sharecode-detail .rating-stars {
    color: #ffc107;
    font-size: 18px;
    margin-right: 8px;
}

#sharecode-detail .rating-text {
    color: #6c757d;
    font-size: 14px;
}

#sharecode-detail .view-stats {
    display: flex;
    gap: 20px;
}

#sharecode-detail .stat-item {
    color: #6c757d;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 5px;
}

#sharecode-detail .stat-item i {
    color: #667eea;
}

#sharecode-detail .price-section {
    margin-bottom: 30px;
}

#sharecode-detail .price-display {
    display: flex;
    align-items: baseline;
    gap: 10px;
}

#sharecode-detail .price-label {
    color: #6c757d;
    font-size: 16px;
}

#sharecode-detail .price-display.free .price-value {
    color: #28a745;
    font-size: 24px;
    font-weight: 700;
}

#sharecode-detail .price-display.paid .price-value {
    color: #fd7e14;
    font-size: 24px;
    font-weight: 700;
}

#sharecode-detail .action-buttons {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

#sharecode-detail .purchase-btn,
#sharecode-detail .download-btn,
#sharecode-detail .login-btn {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 15px 30px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 16px;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    min-width: 160px;
    justify-content: center;
}

#sharecode-detail .purchase-btn {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
}

#sharecode-detail .purchase-btn:hover {
    background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

#sharecode-detail .download-btn {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    color: white;
}

#sharecode-detail .download-btn:hover {
    background: linear-gradient(135deg, #20c997 0%, #28a745 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
}

#sharecode-detail .login-btn {
    background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
    color: white;
}

#sharecode-detail .login-btn:hover {
    background: linear-gradient(135deg, #fd7e14 0%, #ffc107 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(255, 193, 7, 0.4);
    text-decoration: none;
    color: white;
}

#sharecode-detail .detail-specs {
    padding: 30px;
    border-bottom: 1px solid #dee2e6;
}

#sharecode-detail .specs-title {
    color: #2c3e50;
    font-size: 20px;
    font-weight: 600;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
}

#sharecode-detail .specs-title i {
    color: #667eea;
}

#sharecode-detail .specs-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 15px;
}

#sharecode-detail .spec-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 16px;
    background: #f8f9fa;
    border-radius: 8px;
    border-left: 4px solid #667eea;
}

#sharecode-detail .spec-label {
    color: #495057;
    font-weight: 500;
}

#sharecode-detail .spec-value {
    color: #2c3e50;
    font-weight: 600;
}

#sharecode-detail .fire-icon {
    margin-left: 5px;
}

#sharecode-detail .detail-description {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    padding: 30px;
}

#sharecode-detail .description-title {
    color: #2c3e50;
    font-size: 20px;
    font-weight: 600;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
}

#sharecode-detail .description-title i {
    color: #667eea;
}

#sharecode-detail .description-content {
    color: #495057;
    line-height: 1.8;
    font-size: 15px;
    margin-bottom: 30px;
}

#sharecode-detail .tags-section {
    border-top: 1px solid #dee2e6;
    padding-top: 25px;
}

#sharecode-detail .tags-title {
    color: #2c3e50;
    font-size: 16px;
    font-weight: 600;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 8px;
}

#sharecode-detail .tags-title i {
    color: #667eea;
}

#sharecode-detail .tags-list {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

#sharecode-detail .tag-item {
    background: #e9ecef;
    color: #495057;
    padding: 6px 12px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 13px;
    font-weight: 500;
    transition: all 0.3s ease;
}

#sharecode-detail .tag-item:hover {
    background: #667eea;
    color: white;
    text-decoration: none;
    transform: translateY(-1px);
}

/* Modal Styles */
#downloadModal .modal-content {
    border-radius: 12px;
    border: none;
    box-shadow: 0 10px 40px rgba(0,0,0,0.2);
}

#downloadModal .modal-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border-radius: 12px 12px 0 0;
    border-bottom: none;
}

#downloadModal .modal-header .close {
    color: white;
    opacity: 1;
    text-shadow: none;
}

#downloadModal .panel-info > .panel-body {
    background: #f8f9fa;
    border-radius: 8px;
}

#downloadModal .text-primary {
    color: #667eea !important;
}

#downloadModal .text-success {
    color: #28a745 !important;
}

#downloadModal .text-danger {
    color: #dc3545 !important;
}

#downloadModal .btn-primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    border-radius: 8px;
    font-weight: 600;
}

#downloadModal .btn-primary:hover {
    background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
    transform: translateY(-1px);
}

/* Responsive */
@media (max-width: 768px) {
    #sharecode-detail .detail-hero {
        padding: 20px;
    }
    
    #sharecode-detail .hero-layout {
        flex-direction: column;
        gap: 20px;
    }
    
    #sharecode-detail .hero-image {
        flex: none;
        text-align: center;
    }
    
    #sharecode-detail .hero-content {
        flex: none;
    }
    
    #sharecode-detail .detail-title {
        font-size: 24px;
    }
    
    #sharecode-detail .action-buttons {
        flex-direction: column;
    }
    
    #sharecode-detail .purchase-btn,
    #sharecode-detail .download-btn,
    #sharecode-detail .login-btn {
        width: 100%;
    }
    
    #sharecode-detail .specs-grid {
        grid-template-columns: 1fr;
    }
    
    #sharecode-detail .detail-description {
        padding: 20px;
    }
}

/* Animation */
#sharecode-detail .detail-container {
    animation: fadeInUp 0.6s ease;
}

#sharecode-detail .detail-description {
    animation: fadeInUp 0.8s ease;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Reviews Section Styles */
#sharecode-detail .reviews-section {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    padding: 30px;
    margin-top: 30px;
}

#sharecode-detail .reviews-title {
    color: #2c3e50;
    font-size: 24px;
    font-weight: 600;
    margin-bottom: 25px;
    display: flex;
    align-items: center;
    gap: 10px;
}

#sharecode-detail .reviews-title i {
    color: #ffc107;
}

#sharecode-detail .reviews-count {
    color: #6c757d;
    font-size: 16px;
    font-weight: 400;
}

#sharecode-detail .reviews-summary {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 25px;
    margin-bottom: 30px;
    border: 1px solid #e9ecef;
}

#sharecode-detail .avg-rating-display {
    text-align: center;
}

#sharecode-detail .avg-rating-number {
    font-size: 48px;
    font-weight: 700;
    color: #2c3e50;
    line-height: 1;
}

#sharecode-detail .avg-rating-stars {
    color: #ffc107;
    font-size: 24px;
    margin: 10px 0;
}

#sharecode-detail .avg-rating-text {
    color: #6c757d;
    margin: 0;
    font-size: 14px;
}

#sharecode-detail .summary-layout {
    display: flex;
    gap: 30px;
    align-items: flex-start;
}

#sharecode-detail .summary-left {
    flex: 0 0 250px;
}

#sharecode-detail .summary-right {
    flex: 1;
}

#sharecode-detail .rating-breakdown {
    padding-left: 0;
}

#sharecode-detail .rating-bar {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 8px;
}

#sharecode-detail .rating-label {
    min-width: 50px;
    font-size: 14px;
    color: #495057;
}

#sharecode-detail .rating-progress {
    flex: 1;
    height: 8px;
    background: #e9ecef;
    border-radius: 4px;
    overflow: hidden;
}

#sharecode-detail .rating-fill {
    height: 100%;
    background: linear-gradient(90deg, #ffc107, #fd7e14);
    transition: width 0.3s ease;
}

#sharecode-detail .rating-count {
    min-width: 30px;
    text-align: right;
    font-size: 14px;
    color: #6c757d;
}

#sharecode-detail .add-review-section {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 25px;
    margin-bottom: 30px;
    border: 2px dashed #dee2e6;
}

#sharecode-detail .add-review-title {
    color: #2c3e50;
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 8px;
}

#sharecode-detail .add-review-title i {
    color: #667eea;
}

#sharecode-detail .review-form .form-group {
    margin-bottom: 20px;
}

#sharecode-detail .form-label {
    color: #495057;
    font-weight: 500;
    margin-bottom: 8px;
    display: block;
}

#sharecode-detail .star-rating-input {
    display: flex;
    flex-direction: row-reverse;
    gap: 5px;
    margin-bottom: 10px;
}

#sharecode-detail .star-rating-input input[type="radio"] {
    display: none;
}

#sharecode-detail .star-rating-input .star-label {
    font-size: 28px;
    color: #dee2e6;
    cursor: pointer;
    transition: all 0.2s ease;
    user-select: none;
}

#sharecode-detail .star-rating-input .star-label:hover,
#sharecode-detail .star-rating-input .star-label.active {
    color: #ffc107;
    transform: scale(1.1);
}

#sharecode-detail .star-rating-input input[type="radio"]:checked ~ .star-label,
#sharecode-detail .star-rating-input .star-label:hover ~ .star-label {
    color: #ffc107;
}

#sharecode-detail .rating-text-display {
    color: #6c757d;
    font-size: 14px;
    font-style: italic;
}

#sharecode-detail .review-textarea {
    border: 2px solid #dee2e6;
    border-radius: 8px;
    padding: 12px;
    font-size: 14px;
    line-height: 1.5;
    resize: vertical;
    transition: border-color 0.3s ease;
}

#sharecode-detail .review-textarea:focus {
    border-color: #667eea;
    outline: none;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

#sharecode-detail .submit-review-btn {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 12px 24px;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
}

#sharecode-detail .submit-review-btn:hover {
    background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

#sharecode-detail .submit-review-btn:disabled {
    opacity: 0.7;
    cursor: not-allowed;
    transform: none;
}

#sharecode-detail .login-to-review {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 30px;
    text-align: center;
    margin-bottom: 30px;
    border: 2px dashed #dee2e6;
}

#sharecode-detail .login-prompt i {
    font-size: 48px;
    color: #6c757d;
    margin-bottom: 15px;
}

#sharecode-detail .login-prompt p {
    color: #6c757d;
    margin-bottom: 20px;
    font-size: 16px;
}

#sharecode-detail .login-review-btn {
    background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
    color: white;
    padding: 12px 24px;
    border-radius: 8px;
    text-decoration: none;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
}

#sharecode-detail .login-review-btn:hover {
    background: linear-gradient(135deg, #fd7e14 0%, #ffc107 100%);
    text-decoration: none;
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(255, 193, 7, 0.4);
}

#sharecode-detail .reviews-list {
    margin-top: 30px;
}

#sharecode-detail .reviews-list-title {
    color: #2c3e50;
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 8px;
}

#sharecode-detail .reviews-list-title i {
    color: #667eea;
}

#sharecode-detail .review-item {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 15px;
    border: 1px solid #e9ecef;
    transition: all 0.3s ease;
}

#sharecode-detail .review-item:hover {
    border-color: #667eea;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.1);
}

#sharecode-detail .review-header {
    margin-bottom: 15px;
}

#sharecode-detail .reviewer-info {
    display: flex;
    align-items: center;
    gap: 15px;
}

#sharecode-detail .reviewer-avatar {
    font-size: 40px;
    color: #6c757d;
}

#sharecode-detail .reviewer-details h5 {
    color: #2c3e50;
    margin: 0 0 5px 0;
    font-weight: 600;
}

#sharecode-detail .review-rating {
    color: #ffc107;
    font-size: 16px;
    margin-bottom: 5px;
}

#sharecode-detail .review-date {
    color: #6c757d;
    font-size: 12px;
}

#sharecode-detail .review-content p {
    color: #495057;
    line-height: 1.6;
    margin: 0;
    font-size: 14px;
}

#sharecode-detail .no-reviews {
    text-align: center;
    padding: 50px 20px;
    background: #f8f9fa;
    border-radius: 12px;
    border: 2px dashed #dee2e6;
}

#sharecode-detail .no-reviews-content i {
    color: #6c757d;
    margin-bottom: 20px;
}

#sharecode-detail .no-reviews-content h4 {
    color: #495057;
    margin-bottom: 10px;
}

#sharecode-detail .no-reviews-content p {
    color: #6c757d;
    margin: 0;
}

/* Responsive Reviews */
@media (max-width: 768px) {
    #sharecode-detail .reviews-summary {
        padding: 20px;
    }
    
    #sharecode-detail .summary-layout {
        flex-direction: column;
        gap: 20px;
    }
    
    #sharecode-detail .summary-left {
        flex: none;
        text-align: center;
    }
    
    #sharecode-detail .summary-right {
        flex: none;
    }
    
    #sharecode-detail .avg-rating-number {
        font-size: 36px;
    }
    
    #sharecode-detail .star-rating-input .star-label {
        font-size: 24px;
    }
    
    #sharecode-detail .reviewer-info {
        gap: 10px;
    }
    
    #sharecode-detail .reviewer-avatar {
        font-size: 32px;
    }
}

/* Author Section Styles */
#sharecode-detail .author-section {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    margin-bottom: 30px;
}

#sharecode-detail .author-title {
    color: #2c3e50;
    font-size: 24px;
    font-weight: 600;
    margin: 0 0 20px 0;
    padding: 25px 25px 0;
    border-bottom: 2px solid #ecf0f1;
    padding-bottom: 15px;
}

#sharecode-detail .author-title i {
    color: #3498db;
    margin-right: 10px;
}

#sharecode-detail .author-card {
    padding: 25px;
}

#sharecode-detail .author-layout {
    display: flex;
    align-items: center;
    gap: 25px;
}

#sharecode-detail .author-avatar {
    flex-shrink: 0;
}

#sharecode-detail .author-avatar img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border: 3px solid #ecf0f1;
}

#sharecode-detail .author-info {
    flex: 1;
}

#sharecode-detail .author-header {
    margin-bottom: 15px;
}

#sharecode-detail .author-name {
    margin: 0 0 5px 0;
    font-size: 20px;
    font-weight: 600;
}

#sharecode-detail .author-name a {
    color: #2c3e50;
    text-decoration: none;
    transition: color 0.3s ease;
}

#sharecode-detail .author-name a:hover {
    color: #3498db;
}

#sharecode-detail .author-username {
    color: #7f8c8d;
    margin: 0;
    font-size: 14px;
}

#sharecode-detail .author-stats {
    display: flex;
    gap: 25px;
}

#sharecode-detail .author-stats .stat-item {
    text-align: center;
}

#sharecode-detail .author-stats .stat-number {
    display: block;
    font-size: 18px;
    font-weight: 700;
    color: #2c3e50;
    line-height: 1;
}

#sharecode-detail .author-stats .stat-label {
    display: block;
    font-size: 12px;
    color: #7f8c8d;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-top: 2px;
}

#sharecode-detail .author-actions {
    flex-shrink: 0;
}

#sharecode-detail .view-profile-btn {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    padding: 12px 20px;
    background: linear-gradient(135deg, #3498db, #2980b9);
    color: white;
    text-decoration: none;
    border-radius: 8px;
    font-weight: 500;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(52, 152, 219, 0.3);
}

#sharecode-detail .view-profile-btn:hover {
    background: linear-gradient(135deg, #2980b9, #21618c);
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(52, 152, 219, 0.4);
    color: white;
    text-decoration: none;
}

/* Responsive Author Section */
@media (max-width: 768px) {
    #sharecode-detail .author-layout {
        flex-direction: column;
        text-align: center;
        gap: 20px;
    }
    
    #sharecode-detail .author-stats {
        justify-content: center;
        gap: 20px;
    }
    
    #sharecode-detail .author-actions {
        align-self: center;
    }
    
    #sharecode-detail .author-title {
        font-size: 20px;
        padding: 20px 20px 0;
    }
    
    #sharecode-detail .author-card {
        padding: 20px;
    }
}

@media (max-width: 480px) {
    #sharecode-detail .author-stats {
        flex-direction: column;
        gap: 15px;
    }
    
    #sharecode-detail .author-stats .stat-item {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }
    
    #sharecode-detail .author-stats .stat-number,
    #sharecode-detail .author-stats .stat-label {
        display: inline;
        margin: 0;
    }
    
    #sharecode-detail .author-stats .stat-label {
        text-transform: none;
        font-size: 14px;
    }
}

/* Contact Modal Styles for NukeViet modalShow */
.contact-modal-wrapper {
    padding: 0;
}

.contact-info-header {
    margin-bottom: 20px;
    text-align: center;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 8px;
}

.contact-tabs .nav-tabs {
    border-bottom: 2px solid #dee2e6;
    margin-bottom: 20px;
}

.contact-tabs .nav-link {
    border: none;
    border-radius: 0;
    color: #6c757d;
    font-weight: 500;
    padding: 12px 20px;
    border-bottom: 3px solid transparent;
    transition: all 0.3s ease;
    cursor: pointer;
}

.contact-tabs .nav-link:hover {
    color: #667eea;
    border-bottom-color: #667eea;
    background: none;
    text-decoration: none;
}

.contact-tabs .nav-link.active {
    color: #667eea;
    border-bottom-color: #667eea;
    background: none;
    font-weight: 600;
}

.contact-item {
    display: flex;
    align-items: center;
    gap: 20px;
    padding: 20px;
    background: #f8f9fa;
    border-radius: 12px;
    margin-bottom: 15px;
    border: 1px solid #e9ecef;
    transition: all 0.3s ease;
}

.contact-item:hover {
    background: #fff;
    border-color: #667eea;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.1);
}

.contact-icon {
    flex-shrink: 0;
    width: 60px;
    text-align: center;
}

.contact-details {
    flex: 1;
}

.contact-details h6 {
    color: #2c3e50;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.contact-value {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}

.contact-link {
    color: #2c3e50;
    font-weight: 600;
    font-size: 16px;
    text-decoration: none;
    transition: color 0.3s ease;
}

.contact-link:hover {
    text-decoration: none;
}

.phone-link:hover {
    color: #28a745;
}

.email-link:hover {
    color: #dc3545;
}

.facebook-link:hover {
    color: #3b5998;
}

.skype-link:hover {
    color: #00aff0;
}

.website-link:hover {
    color: #28a745;
}

.contact-text {
    color: #2c3e50;
    font-weight: 600;
    font-size: 16px;
}

.copy-btn {
    font-size: 12px;
    padding: 4px 8px;
    transition: all 0.3s ease;
}

.copy-btn:hover {
    transform: translateY(-1px);
}

.tab-content {
    margin-top: 15px;
}

.tab-pane {
    display: none;
}

.tab-pane.active {
    display: block;
}

.single-contact-content .contact-content {
    display: block;
}

.contact-btn.primary {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 15px 30px;
    border-radius: 8px;
    font-weight: 600;
    font-size: 16px;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: all 0.3s ease;
    min-width: 160px;
    justify-content: center;
    display: flex;
    align-items: center;
    gap: 10px;
}

.contact-btn.primary:hover {
    background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
    color: white;
    text-decoration: none;
}

/* Responsive Contact Modal */
@media (max-width: 768px) {
    #contactModal .contact-item {
        flex-direction: column;
        text-align: center;
        gap: 15px;
    }
    
    #contactModal .contact-icon {
        width: auto;
    }
    
    #contactModal .contact-value {
        justify-content: center;
    }
    
    #contactModal .modal-footer {
        flex-direction: column;
        gap: 15px;
    }
    
    #contactModal .contact-tips {
        order: -1;
    }
}
</style>
<!-- END: main -->
