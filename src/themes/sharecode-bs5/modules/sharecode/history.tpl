<!-- BEGIN: main -->
<div id="sharecode-history" class="py-4">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header mb-5">
            <div class="row align-items-center">
                <div class="col-12">
                    <div class="d-flex align-items-center">
                        <div class="header-icon me-3">
                            <i class="fa fa-history fa-2x text-primary"></i>
                        </div>
                        <div>
                            <h1 class="h2 fw-bold text-dark mb-1">Lịch sử mua code</h1>
                            <p class="text-muted mb-0">Quản lý và tải lại các mã nguồn đã mua</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Section -->
        <div class="stats-section mb-5">
            <div class="row g-4">
                <div class="col-6 col-md-3">
                    <div class="stats-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="stats-icon mb-3">
                                <i class="fa fa-shopping-cart fa-2x text-primary"></i>
                            </div>
                            <div class="stats-content">
                                <h4 class="h3 fw-bold text-dark mb-1">{STATS.total_items}</h4>
                                <span class="text-muted small">Tổng mã nguồn</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stats-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="stats-icon mb-3">
                                <i class="fa fa-money fa-2x text-success"></i>
                            </div>
                            <div class="stats-content">
                                <h4 class="h3 fw-bold text-dark mb-1">{STATS.total_spent_format}</h4>
                                <span class="text-muted small">Tổng chi tiêu</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stats-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="stats-icon mb-3">
                                <i class="fa fa-gift fa-2x text-info"></i>
                            </div>
                            <div class="stats-content">
                                <h4 class="h3 fw-bold text-dark mb-1">{STATS.free_items}</h4>
                                <span class="text-muted small">Miễn phí</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="stats-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="stats-icon mb-3">
                                <i class="fa fa-credit-card fa-2x text-warning"></i>
                            </div>
                            <div class="stats-content">
                                <h4 class="h3 fw-bold text-dark mb-1">{STATS.paid_items}</h4>
                                <span class="text-muted small">Có phí</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Empty State -->
        <!-- BEGIN: no_purchases -->
        <div class="empty-state text-center py-5">
            <div class="empty-icon mb-4">
                <i class="fa fa-shopping-cart display-1 text-muted opacity-50"></i>
            </div>
            <h3 class="h4 text-dark mb-3">Chưa có mã nguồn nào</h3>
            <p class="text-muted mb-4 mx-auto" style="max-width: 500px;">
                Bạn chưa mua mã nguồn nào. Hãy khám phá và tìm kiếm những mã nguồn phù hợp!
            </p>
            <a href="{MODULE_URL}" class="btn btn-primary btn-lg">
                <i class="fa fa-search me-2"></i> Khám phá ngay
            </a>
        </div>
        <!-- END: no_purchases -->
        <!-- Purchases List -->
        <!-- BEGIN: purchases -->
        <div class="purchases-section">
            <div class="section-header mb-4">
                <h4 class="h5 fw-bold text-dark">
                    <i class="fa fa-list text-primary me-2"></i>
                    Danh sách mã nguồn đã mua ({TOTAL_PURCHASES} mục)
                </h4>
            </div>

            <div class="purchases-list">
                <!-- BEGIN: purchase -->
                <div class="purchase-item card border-0 shadow-sm mb-4">
                    <div class="card-body p-4">
                        <div class="row g-4">
                            <div class="col-12 col-md-3">
                                <div class="purchase-image">
                                    <img src="{PURCHASE.image_url}" alt="{PURCHASE.title}"
                                         class="img-fluid rounded" style="width: 100%; height: 150px; object-fit: cover;">
                                </div>
                            </div>
                            <div class="col-12 col-md-9">
                                <div class="purchase-info">
                                    <h5 class="purchase-title mb-3">
                                        <a href="{PURCHASE.detail_url}" class="text-decoration-none text-dark fw-semibold">{PURCHASE.title}</a>
                                    </h5>
                                    <p class="purchase-description text-muted mb-3">{PURCHASE.description}</p>

                                    <div class="purchase-meta mb-4">
                                        <div class="row g-3">
                                            <div class="col-12 col-lg-6">
                                                <div class="meta-group">
                                                    <div class="meta-item d-flex align-items-center mb-2">
                                                        <i class="fa fa-folder text-primary me-2"></i>
                                                        <span class="text-muted small">Danh mục:</span>
                                                        <span class="fw-semibold ms-2">{PURCHASE.category_title}</span>
                                                    </div>
                                                    <div class="meta-item d-flex align-items-center mb-2">
                                                        <i class="fa fa-calendar text-primary me-2"></i>
                                                        <span class="text-muted small">Thời gian mua:</span>
                                                        <span class="fw-semibold ms-2">{PURCHASE.purchase_time_format}</span>
                                                    </div>
                                                    <div class="meta-item d-flex align-items-center">
                                                        <i class="fa fa-credit-card text-primary me-2"></i>
                                                        <span class="text-muted small">Phương thức:</span>
                                                        <span class="fw-semibold ms-2">{PURCHASE.payment_method_text}</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 col-lg-6">
                                                <div class="meta-group">
                                                    <div class="meta-item d-flex align-items-center mb-2">
                                                        <i class="fa fa-tag text-success me-2"></i>
                                                        <span class="text-muted small">Giá:</span>
                                                        <span class="price-tag fw-bold text-success ms-2">{PURCHASE.amount_format}</span>
                                                    </div>
                                                    <div class="meta-item d-flex align-items-center mb-2">
                                                        <i class="fa fa-barcode text-primary me-2"></i>
                                                        <span class="text-muted small">Mã giao dịch:</span>
                                                        <span class="fw-semibold ms-2 font-monospace">{PURCHASE.transaction_id}</span>
                                                    </div>
                                                    <div class="meta-item d-flex align-items-center">
                                                        <i class="fa fa-check-circle text-success me-2"></i>
                                                        <span class="text-muted small">Trạng thái:</span>
                                                        <span class="badge bg-success ms-2">Hoàn thành</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="purchase-actions d-flex gap-2 flex-wrap">
                                        <button onclick="downloadFromHistory({PURCHASE.source_id}); return false;"
                                                class="btn btn-success">
                                            <i class="fa fa-download me-2"></i> Tải xuống
                                        </button>
                                        <a href="{PURCHASE.detail_url}" class="btn btn-primary">
                                            <i class="fa fa-eye me-2"></i> Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: purchase -->
            </div>
        </div>
        <!-- END: purchases -->

        <!-- Pagination -->
        <!-- BEGIN: pagination -->
        <div class="pagination-wrapper text-center mt-5">
            {PAGINATION}
        </div>
        <!-- END: pagination -->
    </div>
</div>
<!-- END: main -->

<script>
// History page functionality with AOS
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

    // Add stagger effect to purchase items - Tắt để tối ưu hiệu suất
    // const purchaseItems = document.querySelectorAll('.purchase-item');
    // purchaseItems.forEach((item, index) => {
    //     if (item.closest('[data-aos]')) {
    //         item.closest('[data-aos]').setAttribute('data-aos-delay', (index % 4) * 100);
    //     }
    // });

    // Add stagger effect to stats cards - Tắt để tối ưu hiệu suất
    // const statsCards = document.querySelectorAll('.stats-card');
    // statsCards.forEach((card, index) => {
    //     if (card.closest('.col-6')) {
    //         card.closest('.col-6').setAttribute('data-aos', 'fade-up');
    //         card.closest('.col-6').setAttribute('data-aos-duration', '600');
    //         card.closest('.col-6').setAttribute('data-aos-delay', index * 100);
    //     }
    // });
});

function downloadFromHistory(sourceId) {
    // Show loading state
    const button = event.target.closest('button');
    const originalText = button.innerHTML;
    button.innerHTML = '<i class="fa fa-spinner fa-spin me-2"></i> Đang tải...';
    button.disabled = true;

    // Send AJAX request
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
                // Download directly
                window.location.href = response.download_url;

                // Show success notification
                showNotification('Đang tải xuống file...', 'success');
            } else {
                showNotification('Lỗi: ' + response.message, 'error');
            }
        },
        error: function () {
            showNotification('Có lỗi xảy ra khi tải file!', 'error');
        },
        complete: function() {
            // Restore button state
            setTimeout(() => {
                button.innerHTML = originalText;
                button.disabled = false;
            }, 2000);
        }
    });
}

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
/* ===== HISTORY PAGE STYLES - BOOTSTRAP 5 ===== */

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

/* Stats Cards */
.stats-card {
    transition: all 0.3s ease;
    border-radius: 16px !important;
}

.stats-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
}

.stats-icon {
    transition: all 0.3s ease;
}

.stats-card:hover .stats-icon {
    transform: scale(1.1);
}

/* Purchase Items */
.purchase-item {
    transition: all 0.3s ease;
    border-radius: 16px !important;
}

.purchase-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
}

.purchase-title a {
    transition: color 0.3s ease;
}

.purchase-item:hover .purchase-title a {
    color: var(--bs-primary) !important;
}

.purchase-meta {
    background: rgba(13, 110, 253, 0.03);
    border-radius: 12px;
    padding: 1.5rem;
}

.meta-item {
    font-size: 0.875rem;
}

.price-tag {
    font-size: 1rem;
}

/* Actions */
.purchase-actions .btn {
    transition: all 0.3s ease;
    border-radius: 8px;
    font-weight: 600;
}

.purchase-actions .btn:hover {
    transform: translateY(-2px);
}

.purchase-actions .btn-success:hover {
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
}

.purchase-actions .btn-primary:hover {
    box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
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

    .purchase-meta {
        padding: 1rem;
    }

    .meta-item {
        flex-direction: column !important;
        align-items: flex-start !important;
        margin-bottom: 0.75rem !important;
    }

    .meta-item span:first-of-type {
        margin-bottom: 0.25rem;
    }

    .purchase-actions {
        flex-direction: column !important;
    }

    .purchase-actions .btn {
        width: 100%;
        margin-bottom: 0.5rem;
    }

    .empty-state {
        padding: 3rem 1rem;
    }
}
</style>