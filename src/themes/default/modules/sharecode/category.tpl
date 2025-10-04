<!-- BEGIN: main -->
<!-- Main category header -->
<div class="marketplace-header">
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-24 col-md-16">
                <h1 class="category-title">
                    <i class="fa fa-folder-open"></i> {CATEGORY.title}
                    <span class="item-count">({TOTAL_SOURCES} sản phẩm)</span>
                </h1>
                <!-- BEGIN: category_description -->
                <p class="category-description">{CATEGORY.description}</p>
                <!-- END: category_description -->
            </div>
            <div class="col-xs-24 col-md-8 text-right">
                <div class="category-stats">
                    <div class="stat-item">
                        <span class="stat-number">{TOTAL_SOURCES}</span>
                        <span class="stat-label">Sản phẩm</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Subcategories section -->
<!-- BEGIN: subcategories -->
<div class="subcategories-section">
    <div class="container-fluid">
        <h3 class="section-title">
            <i class="fa fa-sitemap"></i> Danh mục con
        </h3>
        <div class="row">
            <!-- BEGIN: subcat -->
            <div class="col-xs-24 col-sm-8 col-md-6">
                <a href="{SUBCAT.link}" class="subcat-card">
                    <div class="subcat-icon">
                        <i class="fa fa-folder"></i>
                    </div>
                    <div class="subcat-info">
                        <h5 class="subcat-name">{SUBCAT.title}</h5>
                        <span class="subcat-count">{SUBCAT.total_sources} sản phẩm</span>
                    </div>
                    <div class="subcat-arrow">
                        <i class="fa fa-chevron-right"></i>
                    </div>
                </a>
            </div>
            <!-- END: subcat -->
        </div>
    </div>
</div>
<!-- END: subcategories -->
<!-- Toolbar with sorting -->
<div class="marketplace-toolbar">
    <div class="container-fluid">
        <div class="row">
            <div class="col-xs-24 col-md-12">
                <div class="toolbar-left">
                    <span class="results-count">{TOTAL_SOURCES} sản phẩm được tìm thấy</span>
                </div>
            </div>
            <div class="col-xs-24 col-md-12">
                <div class="toolbar-right">
                    <div class="sort-controls">
                        <span class="sort-label">Sắp xếp:</span>
                        <div class="btn-group sort-dropdown">
                            <!-- BEGIN: sort_links -->
                            <!-- BEGIN: sort -->
                            <!-- BEGIN: active -->
                            <a href="{SORT.link}" class="btn btn-sort active">{SORT.name}</a>
                            <!-- END: active -->
                            <!-- BEGIN: inactive -->
                            <a href="{SORT.link}" class="btn btn-sort">{SORT.name}</a>
                            <!-- END: inactive -->
                            <!-- END: sort -->
                            <!-- END: sort_links -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Sources listing -->
<!-- BEGIN: sources -->
<div class="marketplace-products">
    <div class="container-fluid">
        <div class="row">
            <!-- BEGIN: source -->
            <div class="col-xs-24 col-sm-8 col-md-6">
                <div class="product-card">
                    <div class="product-image">
                        <a href="{SOURCE.link}">
                            <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-responsive">
                            <div class="product-overlay">
                                <div class="overlay-buttons">
                                    <button class="btn btn-overlay btn-quick-view" data-id="{SOURCE.id}">
                                        <i class="fa fa-search-plus"></i> Chi tiết
                                    </button>
                                </div>
                            </div>
                        </a>
                        <!-- BEGIN: free_price -->
                        <div class="product-badge badge-free">
                            <i class="fa fa-download"></i> MIỄN PHÍ
                        </div>
                        <!-- END: free_price -->
                        <!-- BEGIN: paid_price -->
                        <div class="product-badge badge-price">
                            <i class="fa fa-tag"></i> {SOURCE.fee_amount_formatted}
                        </div>
                        <!-- END: paid_price -->
                    </div>

                    <div class="product-info">
                        <div class="product-header">
                            <h4 class="product-title">
                                <a href="{SOURCE.link}">{SOURCE.title}</a>
                            </h4>
                            <!-- BEGIN: rating -->
                            <div class="product-rating">
                                <div class="stars">
                                    {SOURCE.rating_stars}
                                </div>
                                <span class="rating-count">({SOURCE.total_reviews})</span>
                            </div>
                            <!-- END: rating -->
                        </div>

                        <p class="product-description">{SOURCE.description}</p>

                        <div class="product-stats">
                            <div class="stat-item">
                                <i class="fa fa-download"></i>
                                <span class="stat-number">{SOURCE.num_download}</span>
                                <span class="stat-label">Tải về</span>
                            </div>
                            <div class="stat-item">
                                <i class="fa fa-eye"></i>
                                <span class="stat-number">{SOURCE.num_view}</span>
                                <span class="stat-label">Lượt xem</span>
                            </div>
                        </div>

                        <div class="product-category">
                            <small class="category-tag">
                                <i class="fa fa-folder-o"></i> {SOURCE.category_title}
                            </small>
                        </div>

                        <div class="product-actions">
                            <!-- BEGIN: free_price --> 
                            <a href="{SOURCE.link}" class="btn btn-success btn-block btn-download">
                                <i class="fa fa-download"></i> Tải miễn phí
                            </a>
                            <!-- END: free_price -->
                            <!-- BEGIN: paid_price -->
                            <div class="price-display">
                                <div class="price-amount">{SOURCE.fee_amount_formatted}</div>
                            </div>
                            <div class="price-actions">
                                <button class="btn btn-success btn-buy" data-id="{SOURCE.id}" data-price="{SOURCE.fee_amount}">
                                    <i class="fa fa-shopping-cart"></i> Mua ngay
                                </button>
                                <button class="btn btn-cart" data-id="{SOURCE.id}">
                                    <i class="fa fa-cart-plus"></i>
                                </button>
                            </div>
                            <!-- END: paid_price -->
                            <button class="btn btn-info btn-block btn-contact" data-id="{SOURCE.id}" data-title="{SOURCE.title}">
                                <i class="fa fa-phone"></i> Liên hệ để biết giá
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END: source -->
        </div>
    </div>
</div>
<!-- END: sources -->
<!-- No sources message -->
<!-- BEGIN: no_sources -->
<div class="alert alert-info text-center">
    <h4><i class="fa fa-info-circle"></i> Không có mã nguồn nào</h4>
    <p>Hiện tại chưa có mã nguồn nào trong danh mục này.</p>
</div>
<!-- END: no_sources -->

<!-- Pagination -->
<!-- BEGIN: pagination -->
<div class="text-center">
    {GENERATE_PAGE}
</div>
<!-- END: pagination -->
<!-- END: main -->
<style>
/* Marketplace Theme Styles */
.marketplace-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px 0;
    margin-bottom: 30px;
}

.category-title {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 10px;
}

.item-count {
    font-size: 18px;
    font-weight: 400;
    opacity: 0.9;
}

.category-description {
    font-size: 16px;
    opacity: 0.9;
    margin-bottom: 0;
}

.category-stats {
    text-align: center;
}

.stat-item {
    background: rgba(255,255,255,0.2);
    padding: 20px;
    border-radius: 10px;
    backdrop-filter: blur(10px);
}

.stat-number {
    display: block;
    font-size: 32px;
    font-weight: 700;
}

.stat-label {
    font-size: 14px;
    opacity: 0.9;
}

/* Subcategories */
.subcategories-section {
    background: #f8f9fa;
    padding: 30px 0;
    margin-bottom: 30px;
}

.section-title {
    color: #2c3e50;
    font-weight: 600;
    margin-bottom: 25px;
}

.subcat-card {
    display: block;
    background: white;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
    text-decoration: none;
    color: inherit;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
    border: 2px solid transparent;
}

.subcat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    border-color: #667eea;
    text-decoration: none;
    color: inherit;
}

.subcat-icon {
    text-align: center;
    margin-bottom: 15px;
}

.subcat-icon i {
    font-size: 32px;
    color: #667eea;
}

.subcat-name {
    font-weight: 600;
    margin-bottom: 5px;
    color: #2c3e50;
}

.subcat-count {
    color: #7f8c8d;
    font-size: 14px;
}

.subcat-arrow {
    position: absolute;
    top: 50%;
    right: 15px;
    transform: translateY(-50%);
    color: #667eea;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.subcat-card:hover .subcat-arrow {
    opacity: 1;
}

/* Toolbar */
.marketplace-toolbar {
    background: white;
    border-bottom: 1px solid #e9ecef;
    padding: 20px 0;
    margin-bottom: 30px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.04);
}

.results-count {
    font-weight: 600;
    color: #495057;
}

.sort-controls {
    display: flex;
    align-items: center;
    gap: 15px;
}

.sort-label {
    font-weight: 600;
    color: #495057;
}

.btn-sort {
    background: #f8f9fa;
    border: 1px solid #dee2e6;
    color: #495057;
    padding: 8px 16px;
    border-radius: 6px;
    transition: all 0.3s ease;
}

.btn-sort:hover {
    background: #667eea;
    color: white;
    border-color: #667eea;
}

.btn-sort.active {
    background: #667eea;
    color: white;
    border-color: #667eea;
}

/* Product Cards */
.marketplace-products {
    padding: 20px 0;
}

.product-card {
    background: white;
    border-radius: 16px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    transition: all 0.4s ease;
    margin-bottom: 30px;
    border: 1px solid #f1f3f4;
}

.product-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 40px rgba(0,0,0,0.15);
}

.product-image {
    position: relative;
    overflow: hidden;
    height: 200px;
}

.product-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease;
}

.product-card:hover .product-image img {
    transform: scale(1.05);
}

.product-overlay {
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

.product-card:hover .product-overlay {
    opacity: 1;
}

.overlay-buttons {
    display: flex;
    gap: 10px;
}

.btn-overlay {
    background: white;
    color: #333;
    border: none;
    padding: 12px 20px;
    border-radius: 25px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-overlay:hover {
    background: #667eea;
    color: white;
    transform: scale(1.05);
}

.product-badge {
    position: absolute;
    top: 15px;
    right: 15px;
    padding: 8px 12px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
}

.badge-free {
    background: linear-gradient(45deg, #4CAF50, #45a049);
    color: white;
}

.badge-contact {
    background: linear-gradient(45deg, #17a2b8, #138496);
    color: white;
}

.badge-price {
    background: linear-gradient(45deg, #ff6b6b, #ee5a24);
    color: white;
}

.product-info {
    padding: 25px;
}

.product-header {
    margin-bottom: 15px;
}

.product-title {
    font-size: 18px;
    font-weight: 600;
    margin-bottom: 8px;
    line-height: 1.3;
}

.product-title a {
    color: #2c3e50;
    text-decoration: none;
    transition: color 0.3s ease;
}

.product-title a:hover {
    color: #667eea;
    text-decoration: none;
}

.product-rating {
    display: flex;
    align-items: center;
    gap: 8px;
}

.stars {
    color: #ffc107;
    font-size: 14px;
}

.rating-count {
    color: #6c757d;
    font-size: 13px;
}

.product-description {
    color: #6c757d;
    font-size: 14px;
    line-height: 1.5;
    margin-bottom: 20px;
    height: 42px;
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    line-clamp: 3;
    -webkit-box-orient: vertical;
}

.product-stats {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
    padding: 15px 0;
    border-top: 1px solid #f1f3f4;
    border-bottom: 1px solid #f1f3f4;
}

.stat-item {
    display: flex;
    align-items: center;
    gap: 6px;
    color: #6c757d;
    font-size: 13px;
}

.stat-item i {
    color: #667eea;
}

.product-actions .btn-download {
    background: linear-gradient(45deg, #667eea, #764ba2);
    border: none;
    border-radius: 8px;
    padding: 12px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.product-actions .btn-download:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
}

.price-actions {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.price-display {
    text-align: center;
    padding: 10px;
    background: #f8f9fa;
    border-radius: 8px;
}

.price-amount {
    font-size: 20px;
    font-weight: 700;
    color: #e74c3c;
}

.btn-buy {
    background: linear-gradient(45deg, #28a745, #20c997);
    border: none;
    border-radius: 8px;
    padding: 12px;
    font-weight: 600;
    color: white;
    flex: 1;
}

.btn-cart {
    background: transparent;
    border: 2px solid #667eea;
    color: #667eea;
    border-radius: 8px;
    padding: 10px;
    width: 50px;
    transition: all 0.3s ease;
}

.btn-cart:hover {
    background: #667eea;
    color: white;
}

.btn-contact {
    background: linear-gradient(45deg, #17a2b8, #138496);
    border: none;
    border-radius: 8px;
    padding: 12px;
    font-weight: 600;
    color: white;
    transition: all 0.3s ease;
}

.btn-contact:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(23, 162, 184, 0.4);
    color: white;
}

/* Contact Modal Styles */
.contact-methods {
    margin: 20px 0;
}

.contact-item {
    display: flex;
    align-items: center;
    padding: 10px 0;
    border-bottom: 1px solid #eee;
}

.contact-item:last-child {
    border-bottom: none;
}

.contact-item i {
    width: 25px;
    margin-right: 10px;
    color: #667eea;
    font-size: 16px;
}

.contact-item strong {
    margin-right: 8px;
    min-width: 80px;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .marketplace-header {
        padding: 20px 0;
    }

    .category-title {
        font-size: 24px;
    }

    .product-card {
        margin-bottom: 20px;
    }

    .price-actions {
        flex-direction: row;
        align-items: center;
    }

    .btn-cart {
        width: auto;
        min-width: 50px;
    }
}
</style>

<script>
// Marketplace functionality
$(document).ready(function() {
    // Buy now button handler
    $('.btn-buy').click(function() {
        var sourceId = $(this).data('id');
        var price = $(this).data('price');

        // Check if user is logged in
        if (typeof nv_is_user === 'undefined' || !nv_is_user) {
            alert('Vui lòng đăng nhập để mua sản phẩm');
            window.location.href = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_op_variable + '=login';
            return;
        }

        // Call wallet API to process payment
        purchaseSource(sourceId, price);
    });

    // Add to cart handler
    $('.btn-cart').click(function() {
        var sourceId = $(this).data('id');
        addToCart(sourceId);
    });

    // Contact button handler
    $('.btn-contact').click(function() {
        var sourceId = $(this).data('id');
        var sourceTitle = $(this).data('title');
        showContactModal(sourceId, sourceTitle);
    });

    // Preview handler
    $('.btn-preview').click(function(e) {
        e.preventDefault();
        var sourceId = $(this).data('id');
        showPreview(sourceId);
    });
});

// Purchase source using wallet API
function purchaseSource(sourceId, price) {
    // Show loading
    var btn = $('.btn-buy[data-id="' + sourceId + '"]');
    var originalText = btn.html();
    btn.html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý...');
    btn.prop('disabled', true);

    // Call wallet API
    $.ajax({
        url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=wallet&' + nv_op_variable + '=purchase',
        type: 'POST',
        data: {
            source_id: sourceId,
            amount: price,
            type: 'sharecode_purchase'
        },
        success: function(response) {
            if (response.status === 'success') {
                // Payment successful, redirect to download
                window.location.href = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=sharecode&' + nv_op_variable + '=download&id=' + sourceId;
            } else {
                alert('Lỗi: ' + response.message);
                btn.html(originalText);
                btn.prop('disabled', false);
            }
        },
        error: function() {
            alert('Có lỗi xảy ra, vui lòng thử lại');
            btn.html(originalText);
            btn.prop('disabled', false);
        }
    });
}

// Add to shopping cart
function addToCart(sourceId) {
    // Get cart from localStorage
    var cart = JSON.parse(localStorage.getItem('sharecode_cart') || '[]');

    // Check if item already in cart
    if (cart.indexOf(sourceId) === -1) {
        cart.push(sourceId);
        localStorage.setItem('sharecode_cart', JSON.stringify(cart));

        // Update cart count in UI
        updateCartCount();

        // Show notification
        showNotification('Đã thêm vào giỏ hàng', 'success');
    } else {
        showNotification('Sản phẩm đã có trong giỏ hàng', 'warning');
    }
}

// Show preview modal
function showPreview(sourceId) {
    // Implementation for preview modal
    alert('Tính năng xem trước đang được phát triển');
}

// Show contact modal for contact pricing
function showContactModal(sourceId, sourceTitle) {
    var modalContent = '<div class="modal fade" id="contactModal" tabindex="-1">' +
        '<div class="modal-dialog">' +
        '<div class="modal-content">' +
        '<div class="modal-header">' +
        '<h4 class="modal-title"><i class="fa fa-phone"></i> Liên hệ để biết giá</h4>' +
        '<button type="button" class="close" data-dismiss="modal">&times;</button>' +
        '</div>' +
        '<div class="modal-body">' +
        '<p><strong>Sản phẩm:</strong> ' + sourceTitle + '</p>' +
        '<p>Vui lòng liên hệ với chúng tôi qua các phương thức sau để biết giá chi tiết:</p>' +
        '<div class="contact-methods">' +
        '<div class="contact-item">' +
        '<i class="fa fa-phone"></i> <strong>Hotline:</strong> 0123-456-789' +
        '</div>' +
        '<div class="contact-item">' +
        '<i class="fa fa-envelope"></i> <strong>Email:</strong> contact@sharecode.local' +
        '</div>' +
        '<div class="contact-item">' +
        '<i class="fa fa-skype"></i> <strong>Skype:</strong> sharecode.support' +
        '</div>' +
        '<div class="contact-item">' +
        '<i class="fa fa-facebook"></i> <strong>Facebook:</strong> fb.com/sharecode' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="modal-footer">' +
        '<button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>' +
        '<a href="' + nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=contact" class="btn btn-primary">Gửi tin nhắn</a>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>';

    // Remove existing modal
    $('#contactModal').remove();

    // Add new modal to body
    $('body').append(modalContent);

    // Show modal
    $('#contactModal').modal('show');
}

// Update cart count
function updateCartCount() {
    var cart = JSON.parse(localStorage.getItem('sharecode_cart') || '[]');
    $('.cart-count').text(cart.length);
}

// Show notification
function showNotification(message, type) {
    // Simple notification - you can integrate with a toast library
    var alertClass = type === 'success' ? 'alert-success' : 'alert-warning';
    var notification = $('<div class="alert ' + alertClass + ' alert-dismissible" style="position: fixed; top: 20px; right: 20px; z-index: 9999;">' +
        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
        message + '</div>');

    $('body').append(notification);
    setTimeout(function() {
        notification.fadeOut();
    }, 3000);
}
</script>
