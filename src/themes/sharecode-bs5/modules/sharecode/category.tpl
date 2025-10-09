<!-- BEGIN: main -->
<!-- Main category header -->
<div class="marketplace-header py-4 py-md-5">
    <div class="container">
        <div class="row g-4 align-items-center">
            <div class="col-12 col-lg-8">
                <div class="d-flex align-items-center mb-3">
                    <div class="category-icon me-3">
                        <i class="fa fa-folder-open fa-2x text-primary"></i>
                    </div>
                    <div>
                        <h1 class="category-title h2 fw-bold text-dark mb-1">{CATEGORY.title}</h1>
                        <div class="category-breadcrumb">
                            <span class="badge bg-primary bg-opacity-10 text-primary border border-primary border-opacity-25">
                                <i class="fa fa-tag me-1"></i> {TOTAL_SOURCES} sản phẩm
                            </span>
                        </div>
                    </div>
                </div>
                <!-- BEGIN: category_description -->
                <div class="category-description">
                    <p class="text-muted mb-0 fs-6 lh-base">{CATEGORY.description}</p>
                </div>
                <!-- END: category_description -->
            </div>
            <div class="col-12 col-lg-4">
                <div class="category-stats d-flex justify-content-lg-end justify-content-center">
                    <div class="stat-card card border-0 shadow-sm" style="min-width: 200px;">
                        <div class="card-body text-center p-4">
                            <div class="stat-icon mb-3">
                                <i class="fa fa-cubes fa-2x text-primary opacity-75"></i>
                            </div>
                            <div class="stat-number h2 fw-bold text-dark mb-1">{TOTAL_SOURCES}</div>
                            <div class="stat-label text-muted small text-uppercase fw-semibold tracking-wide">Sản phẩm có sẵn</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Subcategories section -->
<!-- BEGIN: subcategories -->
<div class="subcategories-section bg-light py-5">
    <div class="container">
        <h3 class="section-title h4 fw-bold text-dark mb-4">
            <i class="fa fa-sitemap text-primary me-2"></i> Danh mục con
        </h3>
        <div class="row g-4">
            <!-- BEGIN: subcat -->
            <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                <a href="{SUBCAT.link}" class="subcat-card text-decoration-none">
                    <div class="card h-100 border-0 shadow-sm hover-lift">
                        <div class="card-body text-center p-4">
                            <div class="subcat-icon mb-3">
                                <i class="fa fa-folder fa-2x text-primary"></i>
                            </div>
                            <div class="subcat-info">
                                <h5 class="subcat-name h6 fw-semibold text-dark mb-2">{SUBCAT.title}</h5>
                                <span class="subcat-count badge bg-primary-subtle text-primary">{SUBCAT.total_sources} sản phẩm</span>
                            </div>
                            <div class="subcat-arrow mt-3">
                                <i class="fa fa-chevron-right text-primary"></i>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <!-- END: subcat -->
        </div>
    </div>
</div>
<!-- END: subcategories -->
<!-- Toolbar with sorting -->
<div class="marketplace-toolbar bg-white py-4 border-bottom">
    <div class="container">
        <div class="row g-3 align-items-center">
            <div class="col-12 col-md-6">
                <div class="toolbar-left">
                    <span class="results-count fw-semibold text-dark">
                        <i class="fa fa-search text-primary me-2"></i>
                        {TOTAL_SOURCES} sản phẩm được tìm thấy
                    </span>
                </div>
            </div>
            <div class="col-12 col-md-6 text-md-end">
                <div class="toolbar-right">
                    <div class="sort-controls d-flex align-items-center justify-content-md-end gap-3">
                        <span class="sort-label fw-semibold text-dark">Sắp xếp:</span>
                        <div class="btn-group sort-dropdown" role="group">
                            <!-- BEGIN: sort_links -->
                            <!-- BEGIN: sort -->
                            <!-- BEGIN: active -->
                            <a href="{SORT.link}" class="btn btn-primary btn-sm active">{SORT.name}</a>
                            <!-- END: active -->
                            <!-- BEGIN: inactive -->
                            <a href="{SORT.link}" class="btn btn-secondary btn-sm">{SORT.name}</a>
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
<div class="marketplace-products py-5">
    <div class="container">
        <div class="row g-4">
            <!-- BEGIN: source -->
            <div class="col-12 col-md-6 col-lg-4">
                <div class="source-card card h-100 border-0 shadow-sm">
                    <div class="source-image position-relative overflow-hidden">
                        <a href="{SOURCE.link}" class="d-block">
                            <img src="{SOURCE.image_url}" alt="{SOURCE.title}"
                                 class="card-img-top" style="height: 200px; object-fit: cover;">
                        </a>
                        <div class="source-price position-absolute top-0 end-0 m-2">
                            <!-- BEGIN: badge_free -->
                            <span class="badge bg-success rounded-pill">Miễn phí</span>
                            <!-- END: badge_free -->
                            <!-- BEGIN: badge_paid -->
                            <span class="badge bg-primary rounded-pill">{SOURCE.fee_amount_formatted}</span>
                            <!-- END: badge_paid -->
                            <!-- BEGIN: badge_contact -->
                            <span class="badge bg-info rounded-pill">Liên hệ</span>
                            <!-- END: badge_contact -->
                        </div>
                    </div>

                    <div class="card-body d-flex flex-column">
                        <h5 class="source-title card-title">
                            <a href="{SOURCE.link}" class="text-decoration-none text-dark">{SOURCE.title}</a>
                        </h5>

                        <div class="source-meta mb-3">
                            <div class="source-category mb-2">
                                <i class="fa fa-folder text-primary me-1"></i>
                                <span class="text-decoration-none small text-muted">{SOURCE.category_title}</span>
                            </div>
                            <div class="source-date">
                                <i class="fa fa-calendar text-secondary me-1"></i>
                                <span class="small text-muted">{SOURCE.add_time_format}</span>
                            </div>
                        </div>

                        <!-- BEGIN: rating -->
                        <div class="source-rating mb-3">
                            <span class="rating-stars text-warning">{SOURCE.rating_stars}</span>
                            <span class="rating-count text-muted small">({SOURCE.total_reviews})</span>
                        </div>
                        <!-- END: rating -->

                        <div class="source-stats mt-auto">
                            <div class="d-flex justify-content-between text-muted small">
                                <span class="downloads">
                                    <i class="fa fa-download text-success me-1"></i> {SOURCE.num_download}
                                </span>
                                <span class="views">
                                    <i class="fa fa-eye text-info me-1"></i> {SOURCE.num_view}
                                </span>
                            </div>
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
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            <div class="text-center">
                <div class="mb-4">
                    <i class="fa fa-code display-1 text-muted"></i>
                </div>
                <h4 class="h5 fw-semibold text-dark mb-3">Không có mã nguồn nào</h4>
                <p class="text-muted">Hiện tại chưa có mã nguồn nào trong danh mục này.</p>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}=sharecode" class="btn btn-primary">
                    <i class="fa fa-arrow-left me-2"></i> Quay lại trang chủ
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END: no_sources -->

<!-- Pagination -->
<!-- BEGIN: pagination -->
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="d-flex justify-content-center">
                {GENERATE_PAGE}
            </div>
        </div>
    </div>
</div>
<!-- END: pagination -->
<!-- END: main -->
<style>
/* ===== CATEGORY PAGE STYLES - BOOTSTRAP 5 ===== */

/* Marketplace Header */
.marketplace-header {
    border-bottom: 1px solid rgba(0,0,0,0.08);
}

.category-icon {
    transition: all 0.3s ease;
}

.category-icon:hover {
    transform: scale(1.1);
}

.category-title {
    line-height: 1.2;
}

.category-breadcrumb .badge {
    font-size: 0.75rem;
    padding: 0.5rem 0.75rem;
}

.category-description {
    max-width: 600px;
}

.stat-card {
    transition: all 0.3s ease;
    border-radius: 16px !important;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.15) !important;
}

.stat-icon {
    transition: all 0.3s ease;
}

.stat-card:hover .stat-icon {
    transform: scale(1.1);
}

.tracking-wide {
    letter-spacing: 0.05em;
}

/* Subcategories */
.subcategories-section {
    border-bottom: 1px solid #e9ecef;
}

.subcat-card {
    transition: all 0.3s ease;
    position: relative;
}

.subcat-card:hover {
    text-decoration: none;
}

.subcat-card .card {
    transition: all 0.3s ease;
    border: 1px solid #e9ecef;
}

.subcat-card:hover .card {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important;
    border-color: var(--bs-primary);
}

.subcat-arrow {
    transition: all 0.3s ease;
    opacity: 0.6;
}

.subcat-card:hover .subcat-arrow {
    opacity: 1;
    transform: translateX(3px);
}

.hover-lift {
    transition: all 0.3s ease;
}

.hover-lift:hover {
    transform: translateY(-5px);
}

/* Toolbar */
.marketplace-toolbar {
    box-shadow: 0 2px 4px rgba(0,0,0,0.04);
}

.sort-controls {
    flex-wrap: wrap;
}

.btn-group .btn {
    transition: all 0.3s ease;
}

.btn-group .btn:hover {
    transform: translateY(-1px);
}

@media (max-width: 767.98px) {
    .sort-controls {
        justify-content: center !important;
        flex-direction: column;
        gap: 1rem !important;
    }

    .sort-label {
        text-align: center;
    }
}

/* Source Cards - Copy from author.tpl */
.source-card {
    transition: all 0.3s ease;
    border-radius: 12px;
    overflow: hidden;
}

.source-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
}

.source-card .source-image {
    position: relative;
    overflow: hidden;
}

.source-card .source-image img {
    transition: transform 0.3s ease;
}

.source-card:hover .source-image img {
    transform: scale(1.05);
}

.source-card .card-title a {
    transition: color 0.3s ease;
}

.source-card:hover .card-title a {
    color: #007bff !important;
}



/* Responsive Design */
@media (max-width: 767.98px) {
    .marketplace-header {
        text-align: center;
    }

    .category-title {
        font-size: 1.5rem;
    }

    .product-image {
        height: 180px;
    }

    .price-actions {
        flex-direction: column !important;
        gap: 0.5rem !important;
    }

    .btn-cart {
        width: 100% !important;
    }
}

</style>

<script>
// Category page functionality with AOS
document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations - Tắt để tối ưu hiệu suất
    // if (typeof AOS !== 'undefined') {
    //     AOS.init({
    //         duration: 800,
    //         easing: 'ease-in-out',
    //         once: true,
    //         offset: 100,
    //         delay: 0,
    //         disable: function() {
    //             return window.innerWidth < 768;
    //         }
    //     });
    // }

    // Add stagger effect to source cards - Tắt để tối ưu hiệu suất
    // const sourceCards = document.querySelectorAll('.source-card');
    // sourceCards.forEach((card, index) => {
    //     if (card.closest('[data-aos]')) {
    //         card.closest('[data-aos]').setAttribute('data-aos-delay', (index % 6) * 100);
    //     }
    // });

    // Buy now button handler
    $(document).on('click', '.btn-buy', function() {
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
    $(document).on('click', '.btn-cart', function() {
        var sourceId = $(this).data('id');
        addToCart(sourceId);
    });

    // Contact button handler
    $(document).on('click', '.btn-contact', function() {
        var sourceId = $(this).data('id');
        var sourceTitle = $(this).data('title');
        showContactModal(sourceId, sourceTitle);
    });

    // Quick view handler
    $(document).on('click', '.btn-quick-view', function(e) {
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

// Show contact modal for contact pricing (Bootstrap 5)
function showContactModal(sourceId, sourceTitle) {
    var modalContent = '<div class="modal fade" id="contactModal" tabindex="-1" aria-labelledby="contactModalLabel" aria-hidden="true">' +
        '<div class="modal-dialog modal-dialog-centered">' +
        '<div class="modal-content">' +
        '<div class="modal-header">' +
        '<h5 class="modal-title" id="contactModalLabel"><i class="fa fa-phone me-2"></i> Liên hệ để biết giá</h5>' +
        '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>' +
        '</div>' +
        '<div class="modal-body">' +
        '<div class="alert alert-info">' +
        '<strong>Sản phẩm:</strong> ' + sourceTitle +
        '</div>' +
        '<p class="mb-3">Vui lòng liên hệ với chúng tôi qua các phương thức sau để biết giá chi tiết:</p>' +
        '<div class="contact-methods">' +
        '<div class="d-flex align-items-center mb-3 p-3 bg-light rounded">' +
        '<i class="fa fa-phone text-primary me-3"></i>' +
        '<div><strong>Hotline:</strong><br><span class="text-muted">0123-456-789</span></div>' +
        '</div>' +
        '<div class="d-flex align-items-center mb-3 p-3 bg-light rounded">' +
        '<i class="fa fa-envelope text-primary me-3"></i>' +
        '<div><strong>Email:</strong><br><span class="text-muted">contact@sharecode.local</span></div>' +
        '</div>' +
        '<div class="d-flex align-items-center mb-3 p-3 bg-light rounded">' +
        '<i class="fa fa-comments text-primary me-3"></i>' +
        '<div><strong>Skype:</strong><br><span class="text-muted">sharecode.support</span></div>' +
        '</div>' +
        '<div class="d-flex align-items-center p-3 bg-light rounded">' +
        '<i class="fa fa-facebook text-primary me-3"></i>' +
        '<div><strong>Facebook:</strong><br><span class="text-muted">fb.com/sharecode</span></div>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="modal-footer">' +
        '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>' +
        '<a href="' + nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=contact" class="btn btn-primary">Gửi tin nhắn</a>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>';

    // Remove existing modal
    $('#contactModal').remove();

    // Add new modal to body
    $('body').append(modalContent);

    // Show modal using Bootstrap 5
    var contactModal = new bootstrap.Modal(document.getElementById('contactModal'));
    contactModal.show();
}

// Update cart count
function updateCartCount() {
    var cart = JSON.parse(localStorage.getItem('sharecode_cart') || '[]');
    $('.cart-count').text(cart.length);
}

// Show notification using Bootstrap 5 Toast
function showNotification(message, type) {
    var toastClass = type === 'success' ? 'text-bg-success' : 'text-bg-warning';
    var toastId = 'toast-' + Date.now();

    var toastHtml = '<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;">' +
        '<div id="' + toastId + '" class="toast ' + toastClass + '" role="alert" aria-live="assertive" aria-atomic="true">' +
        '<div class="toast-header">' +
        '<i class="fa fa-' + (type === 'success' ? 'check-circle' : 'exclamation-triangle') + ' me-2"></i>' +
        '<strong class="me-auto">Thông báo</strong>' +
        '<button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>' +
        '</div>' +
        '<div class="toast-body">' + message + '</div>' +
        '</div>' +
        '</div>';

    $('body').append(toastHtml);

    var toastElement = document.getElementById(toastId);
    var toast = new bootstrap.Toast(toastElement, {
        autohide: true,
        delay: 3000
    });

    toast.show();

    // Remove toast element after it's hidden
    toastElement.addEventListener('hidden.bs.toast', function() {
        $(this).parent().remove();
    });
}
</script>
