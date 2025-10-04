<!-- BEGIN: main -->
<div class="favorites-page py-4">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header mb-5" data-aos="fade-down" data-aos-duration="800">
            <div class="row align-items-center">
                <div class="col-12 col-md-8">
                    <div class="d-flex align-items-center">
                        <div class="header-icon me-3">
                            <i class="fa fa-heart fa-2x text-danger"></i>
                        </div>
                        <div>
                            <h1 class="h2 fw-bold text-dark mb-1">Sản phẩm yêu thích</h1>
                            <p class="text-muted mb-0">Quản lý danh sách sản phẩm bạn quan tâm</p>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-4 text-md-end text-center mt-3 mt-md-0">
                    <div class="stats-badge">
                        <span class="badge bg-danger bg-opacity-10 text-danger border border-danger border-opacity-25 fs-6 px-3 py-2">
                            <i class="fa fa-heart me-1"></i> {TOTAL_FAVORITES} sản phẩm
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Favorites List -->
        <!-- BEGIN: favorites -->
        <div class="favorites-grid">
            <div class="row g-4">
                <!-- BEGIN: favorite -->
                <div class="col-12 col-md-6 col-lg-4" data-aos="fade-up" data-aos-duration="600">
                    <div class="favorite-card card h-100 border-0 shadow-sm">
                        <div class="favorite-image position-relative overflow-hidden">
                            <a href="{FAVORITE.link}" class="d-block">
                                <img src="{FAVORITE.image_url}" alt="{FAVORITE.title}"
                                     class="card-img-top" style="height: 200px; object-fit: cover;">
                            </a>
                            <div class="price-badge position-absolute top-0 end-0 m-2">
                                <span class="badge {FAVORITE.price_class} rounded-pill">{FAVORITE.price_display}</span>
                            </div>
                            <div class="favorite-overlay position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center">
                                <button type="button" class="btn btn-danger btn-sm rounded-pill shadow remove-favorite"
                                        data-source-id="{FAVORITE.id}"
                                        data-checkss="{FAVORITE.remove_checkss}"
                                        title="Xóa khỏi yêu thích">
                                    <i class="fa fa-heart-o me-1"></i> Xóa
                                </button>
                            </div>
                        </div>

                        <div class="card-body d-flex flex-column">
                            <h5 class="favorite-title card-title">
                                <a href="{FAVORITE.link}" class="text-decoration-none text-dark">{FAVORITE.title}</a>
                            </h5>

                            <div class="favorite-meta mb-3">
                                <div class="favorite-category mb-2">
                                    <i class="fa fa-folder text-primary me-1"></i>
                                    <a href="{FAVORITE.category_link}" class="text-decoration-none small text-muted">{FAVORITE.category_title}</a>
                                </div>
                                <div class="favorite-date">
                                    <i class="fa fa-calendar text-secondary me-1"></i>
                                    <span class="small text-muted">Thêm: {FAVORITE.add_time_format}</span>
                                </div>
                            </div>

                            <!-- BEGIN: rating -->
                            <div class="favorite-rating mb-3">
                                <span class="rating-stars text-warning">{FAVORITE.rating_stars}</span>
                                <span class="rating-score text-muted small">({FAVORITE.avg_rating})</span>
                            </div>
                            <!-- END: rating -->

                            <div class="favorite-stats mt-auto">
                                <div class="d-flex justify-content-between text-muted small">
                                    <span class="downloads">
                                        <i class="fa fa-download text-success me-1"></i> {FAVORITE.num_download}
                                    </span>
                                    <span class="views">
                                        <i class="fa fa-eye text-info me-1"></i> {FAVORITE.num_view}
                                    </span>
                                </div>
                            </div>

                            <div class="favorite-actions mt-3">
                                <a href="{FAVORITE.link}" class="btn btn-primary w-100">
                                    <i class="fa fa-eye me-2"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: favorite -->
            </div>
        </div>
        <!-- END: favorites -->

        <!-- Empty State -->
        <!-- BEGIN: no_favorites -->
        <div class="empty-state text-center py-5" data-aos="fade-up" data-aos-duration="600">
            <div class="empty-icon mb-4">
                <i class="fa fa-heart-o display-1 text-muted opacity-50"></i>
            </div>
            <h3 class="h4 text-dark mb-3">Chưa có sản phẩm yêu thích nào</h3>
            <p class="text-muted mb-4 mx-auto" style="max-width: 500px;">
                Bạn chưa có sản phẩm yêu thích nào. Hãy khám phá và thêm những sản phẩm bạn quan tâm vào danh sách yêu thích.
            </p>
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary btn-lg">
                <i class="fa fa-search me-2"></i> Khám phá sản phẩm
            </a>
        </div>
        <!-- END: no_favorites -->

        <!-- Pagination -->
        <!-- BEGIN: pagination -->
        <div class="pagination-wrapper text-center mt-5">
            {GENERATE_PAGE}
        </div>
        <!-- END: pagination -->
    </div>
</div>

<script>
// Favorites page functionality with AOS
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

    // Add stagger effect to favorite cards - Tắt để tối ưu hiệu suất
    // const favoriteCards = document.querySelectorAll('.favorite-card');
    // favoriteCards.forEach((card, index) => {
    //     if (card.closest('[data-aos]')) {
    //         card.closest('[data-aos]').setAttribute('data-aos-delay', (index % 6) * 100);
    //     }
    // });

    // Handle remove from favorites
    $(document).on('click', '.remove-favorite', function(e) {
        e.preventDefault();

        var $btn = $(this);
        var sourceId = $btn.data('source-id');
        var checkss = $btn.data('checkss');
        var $card = $btn.closest('.col-12');

        if (confirm('Bạn có chắc chắn muốn xóa khỏi danh sách yêu thích?')) {
            // Show loading state
            const originalText = $btn.html();
            $btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin me-1"></i> Đang xử lý');

            $.ajax({
                url: '{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=favorites&remove=' + sourceId + '&checkss=' + checkss,
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        // Fade out effect and remove
                        $card.fadeOut(300, function() {
                            $(this).remove();

                            // Update total count
                            var currentTotal = parseInt($('.stats-badge .badge').text().match(/\d+/)[0]);
                            var newTotal = Math.max(0, currentTotal - 1);
                            $('.stats-badge .badge').html('<i class="fa fa-heart me-1"></i> ' + newTotal + ' sản phẩm');

                            // Check if no favorites left
                            if ($('.favorite-card').length === 0) {
                                location.reload();
                            }
                        });

                        // Show success notification
                        showNotification(response.message || 'Đã xóa khỏi danh sách yêu thích', 'success');
                    } else {
                        showNotification(response.message || 'Có lỗi xảy ra', 'error');
                        $btn.prop('disabled', false).html(originalText);
                    }
                },
                error: function() {
                    showNotification('Lỗi hệ thống, vui lòng thử lại', 'error');
                    $btn.prop('disabled', false).html(originalText);
                }
            });
        }
    });
});

// Show notification using Bootstrap 5 Toast
function showNotification(message, type) {
    var toastClass = type === 'success' ? 'text-bg-success' : 'text-bg-danger';
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

<style>
/* ===== FAVORITES PAGE STYLES - BOOTSTRAP 5 ===== */

/* Page Header */
.page-header {
    border-bottom: 1px solid rgba(0,0,0,0.08);
    padding-bottom: 2rem;
}

.header-icon {
    transition: all 0.3s ease;
}

.header-icon:hover {
    transform: scale(1.1);
}

.stats-badge .badge {
    font-size: 0.875rem;
    padding: 0.75rem 1rem;
}

/* Favorite Cards */
.favorite-card {
    transition: all 0.3s ease;
    border-radius: 16px !important;
    overflow: hidden;
}

.favorite-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
}

.favorite-image {
    position: relative;
    overflow: hidden;
}

.favorite-image img {
    transition: transform 0.3s ease;
}

.favorite-card:hover .favorite-image img {
    transform: scale(1.05);
}

.favorite-overlay {
    background: rgba(0,0,0,0.7);
    opacity: 0;
    transition: opacity 0.3s ease;
}

.favorite-card:hover .favorite-overlay {
    opacity: 1;
}

.favorite-title a {
    transition: color 0.3s ease;
}

.favorite-card:hover .favorite-title a {
    color: var(--bs-primary) !important;
}

/* Price Badge */
.price-badge .badge {
    font-size: 0.75rem;
    padding: 0.5rem 0.75rem;
}

/* Actions */
.favorite-actions .btn {
    transition: all 0.3s ease;
    border-radius: 8px;
}

.favorite-actions .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
}

.remove-favorite {
    transition: all 0.3s ease;
}

.remove-favorite:hover {
    transform: scale(1.05);
}

/* Empty State */
.empty-state {
    padding: 4rem 2rem;
}

.empty-icon {
    transition: all 0.3s ease;
}

.empty-state:hover .empty-icon {
    transform: scale(1.1);
}

/* Responsive Design */
@media (max-width: 767.98px) {
    .page-header {
        text-align: center;
        padding-bottom: 1.5rem;
    }

    .header-icon {
        margin-bottom: 1rem;
    }

    .favorite-image img {
        height: 180px !important;
    }

    .empty-state {
        padding: 3rem 1rem;
    }
}
</style>
<!-- END: main -->
