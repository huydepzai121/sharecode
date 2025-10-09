<!-- BEGIN: main -->
<div class="tag-page py-4">
    <div class="container">
        <!-- Related Tags Section -->
        <!-- BEGIN: related_tags -->
        <div class="related-tags-section mb-5">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="fa fa-tags text-primary me-2"></i>
                        Tags liên quan
                    </h5>
                </div>
                <div class="card-body p-4">
                    <div class="tag-cloud-modern d-flex flex-wrap gap-2">
                        <!-- BEGIN: tag -->
                        <a href="{RELATED_TAG.link}" class="tag-item btn btn-primary rounded-pill">
                            <span class="tag-name me-2">{RELATED_TAG.name}</span>
                            <span class="tag-count badge bg-primary rounded-pill">{RELATED_TAG.total_sources}</span>
                        </a>
                        <!-- END: tag -->
                    </div>
                </div>
            </div>
        </div>
        <!-- END: related_tags -->

        <!-- Sort & Filter Toolbar -->
        <!-- BEGIN: sort_links -->
        <div class="marketplace-toolbar mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-3">
                    <div class="row align-items-center">
                        <div class="col-12 col-md-6">
                            <div class="results-info">
                                <span class="results-count fw-semibold text-dark">
                                    <i class="fa fa-list-ul text-primary me-2"></i>
                                    {TOTAL_SOURCES} sản phẩm được tìm thấy
                                </span>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 text-md-end mt-3 mt-md-0">
                            <div class="sort-controls d-flex align-items-center justify-content-md-end">
                                <span class="sort-label fw-semibold text-dark me-3">Sắp xếp:</span>
                                <div class="btn-group" role="group">
                                    <!-- BEGIN: sort -->
                                    <a href="{SORT.link}" class="btn btn-sm <!-- BEGIN: active -->btn-primary<!-- END: active --><!-- BEGIN: inactive -->btn-secondary<!-- END: inactive -->">{SORT.name}</a>
                                    <!-- END: sort -->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END: sort_links -->

        <!-- Sources Grid -->
        <!-- BEGIN: sources -->
        <div class="sources-grid mb-5">
            <div class="row g-4">
                <!-- BEGIN: source -->
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="source-card card h-100 border-0 shadow-sm">
                        <div class="source-image position-relative overflow-hidden">
                            <a href="{SOURCE.link}" class="d-block">
                                <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="card-img-top"
                                    style="height: 200px; object-fit: cover;">
                            </a>
                            <div class="source-price position-absolute top-0 end-0 m-2">
                                <!-- BEGIN: free_price -->
                                <span class="badge bg-success rounded-pill">Miễn phí</span>
                                <!-- END: free_price -->
                                <!-- BEGIN: paid_price -->
                                <span class="badge bg-primary rounded-pill">{SOURCE.price_text}</span>
                                <!-- END: paid_price -->
                                <!-- BEGIN: contact_price -->
                                <span class="badge bg-info rounded-pill">
                                    <i class="fa fa-phone me-1"></i> LIÊN HỆ
                                </span>
                                <!-- END: contact_price -->
                            </div>
                        </div>

                        <div class="card-body d-flex flex-column">
                            <h5 class="source-title card-title">
                                <a href="{SOURCE.link}" class="text-decoration-none text-dark">{SOURCE.title}</a>
                            </h5>

                            <div class="source-meta mb-3">
                                <div class="source-category mb-2">
                                    <i class="fa fa-folder text-primary me-1"></i>
                                    <a href="{SOURCE.category_link}" class="text-decoration-none small text-muted">{SOURCE.category_title}</a>
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
                                        <i class="fa fa-download text-success me-1"></i>
                                        {SOURCE.num_download}
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
        <!-- END: sources -->

        <!-- BEGIN: no_sources -->
        <div class="no-sources text-center py-5">
            <div class="mb-4">
                <i class="fa fa-tags display-1 text-muted"></i>
            </div>
            <h3 class="h4 text-dark mb-3">Không có mã nguồn nào</h3>
            <p class="text-muted">Hiện tại chưa có mã nguồn nào có tag này.</p>
        </div>
        <!-- END: no_sources -->

        <!-- Pagination -->
        <!-- BEGIN: pagination -->
        <div class="pagination-wrapper text-center mt-5">
            {GENERATE_PAGE}
        </div>
        <!-- END: pagination -->
    </div>
</div>

<script>
// Tag page functionality with AOS
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

    // Add stagger effect to product cards - Tắt để tối ưu hiệu suất
    // const productCards = document.querySelectorAll('.product-card');
    // productCards.forEach((card, index) => {
    //     if (card.closest('[data-aos]')) {
    //         card.closest('[data-aos]').setAttribute('data-aos-delay', (index % 6) * 100);
    //     }
    // });
});

$(document).ready(function() {
    // Buy now button handler
    $('.btn-buy').click(function() {
        var sourceId = $(this).data('id');
        var price = $(this).data('price');

        // Check if user is logged in
        if (typeof nv_is_user === 'undefined' || !nv_is_user) {
            showNotification('Vui lòng đăng nhập để mua sản phẩm', 'warning');
            window.location.href = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_op_variable + '=login';
            return;
        }

        // Call wallet API to process payment
        purchaseSource(sourceId, price);
    });

    // Contact button handler
    $('.btn-contact').click(function() {
        var sourceId = $(this).data('id');
        var sourceTitle = $(this).data('title');
        showContactModal(sourceId, sourceTitle);
    });

    // Preview handler
    $('.btn-quick-view').click(function(e) {
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
    btn.html('<i class="fa fa-spinner fa-spin me-2"></i> Đang xử lý...');
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
                showNotification('Lỗi: ' + response.message, 'error');
                btn.html(originalText);
                btn.prop('disabled', false);
            }
        },
        error: function() {
            showNotification('Có lỗi xảy ra, vui lòng thử lại', 'error');
            btn.html(originalText);
            btn.prop('disabled', false);
        }
    });
}

// Show preview modal
function showPreview(sourceId) {
    // Implementation for preview modal
    showNotification('Tính năng xem trước đang được phát triển', 'info');
}

// Show contact modal for contact pricing
function showContactModal(sourceId, sourceTitle) {
    var modalContent = '<div class="modal fade" id="contactModal" tabindex="-1">' +
        '<div class="modal-dialog modal-dialog-centered">' +
        '<div class="modal-content border-0 shadow">' +
        '<div class="modal-header border-0">' +
        '<h5 class="modal-title fw-bold"><i class="fa fa-phone text-info me-2"></i> Liên hệ để biết giá</h5>' +
        '<button type="button" class="btn-close" data-bs-dismiss="modal"></button>' +
        '</div>' +
        '<div class="modal-body p-4">' +
        '<div class="alert alert-light border-0 mb-4">' +
        '<p class="mb-0"><strong>Sản phẩm:</strong> ' + sourceTitle + '</p>' +
        '</div>' +
        '<p class="mb-4">Vui lòng liên hệ với chúng tôi qua các phương thức sau để biết giá chi tiết:</p>' +
        '<div class="contact-methods">' +
        '<div class="contact-item d-flex align-items-center p-3 mb-2 bg-light rounded">' +
        '<i class="fa fa-phone text-primary me-3"></i> <strong class="me-2">Hotline:</strong> 0123-456-789' +
        '</div>' +
        '<div class="contact-item d-flex align-items-center p-3 mb-2 bg-light rounded">' +
        '<i class="fa fa-envelope text-primary me-3"></i> <strong class="me-2">Email:</strong> contact@sharecode.local' +
        '</div>' +
        '<div class="contact-item d-flex align-items-center p-3 mb-2 bg-light rounded">' +
        '<i class="fa fa-skype text-primary me-3"></i> <strong class="me-2">Skype:</strong> sharecode.support' +
        '</div>' +
        '<div class="contact-item d-flex align-items-center p-3 mb-2 bg-light rounded">' +
        '<i class="fa fa-facebook text-primary me-3"></i> <strong class="me-2">Facebook:</strong> fb.com/sharecode' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="modal-footer border-0">' +
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

    // Show modal
    var modal = new bootstrap.Modal(document.getElementById('contactModal'));
    modal.show();
}

// Show notification using Bootstrap 5 Toast
function showNotification(message, type) {
    var toastClass = type === 'success' ? 'text-bg-success' :
                    type === 'warning' ? 'text-bg-warning' :
                    type === 'info' ? 'text-bg-info' : 'text-bg-danger';
    var toastId = 'toast-' + Date.now();

    var toastHtml = '<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;">' +
        '<div id="' + toastId + '" class="toast ' + toastClass + '" role="alert" aria-live="assertive" aria-atomic="true">' +
        '<div class="toast-header">' +
        '<i class="fa fa-' + (type === 'success' ? 'check-circle' : type === 'warning' ? 'exclamation-triangle' : type === 'info' ? 'info-circle' : 'exclamation-triangle') + ' me-2"></i>' +
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

<style>
/* ===== TAG PAGE STYLES - BOOTSTRAP 5 ===== */

/* Related Tags Section */
.related-tags-section .card {
    border-radius: 16px !important;
}

.tag-item {
    transition: all 0.3s ease;
    text-decoration: none;
}

.tag-item:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
}

/* Marketplace Toolbar */
.marketplace-toolbar .card {
    border-radius: 12px !important;
}

.sort-controls .btn-group .btn {
    border-radius: 6px;
    font-weight: 600;
    font-size: 0.875rem;
}

/* Fix cho button inactive - màu chữ đen */
.sort-controls .btn-group .btn:not(.btn-primary) {
    color: #212529 !important;
    background-color: #f8f9fa;
    border-color: #dee2e6;
}

.sort-controls .btn-group .btn:not(.btn-primary):hover {
    color: #fff !important;
    background-color: #6c757d;
    border-color: #6c757d;
}

/* Button active - giữ nguyên màu primary */
.sort-controls .btn-group .btn-primary {
    color: #fff !important;
    background-color: #0d6efd;
    border-color: #0d6efd;
}

/* Source Cards */
.source-card {
    transition: all 0.3s ease;
    border-radius: 16px !important;
}

.source-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
}

.source-image img {
    transition: transform 0.3s ease;
}

.source-card:hover .source-image img {
    transform: scale(1.05);
}

.source-title a {
    transition: color 0.3s ease;
}

.source-card:hover .source-title a {
    color: var(--bs-primary) !important;
}

/* Empty State */
.no-sources {
    padding: 4rem 2rem;
}

.no-sources i {
    transition: all 0.3s ease;
}

.no-sources:hover i {
    transform: scale(1.1);
}

/* Responsive Design */
@media (max-width: 767.98px) {
    .sort-controls {
        flex-direction: column;
        align-items: flex-start !important;
    }

    .sort-label {
        margin-bottom: 0.5rem;
    }

    .btn-group {
        width: 100%;
    }

    .btn-group .btn {
        flex: 1;
    }

    .source-image img {
        height: 180px !important;
    }

    .no-sources {
        padding: 3rem 1rem;
    }
}

</style>
<!-- END: main -->