<!-- BEGIN: main -->
<div class="search-results-section">
    <div class="container">
            <!-- Page Header -->
            <div class="page-header-section">
                <div class="row">
                    <div class="col-sm-24">
                        <div class="page-title-wrapper">
                            <div class="page-info">
                                <h1 class="page-title">Lịch sử mua code</h1>
                                <p class="page-subtitle">Quản lý và tải lại các mã nguồn đã mua</p>
                            </div>
                            <div class="stats-badge-wrapper">
                                <span class="stats-badge">
                                    <i class="fa fa-shopping-cart"></i>
                                    <span>{TOTAL_PURCHASES} sản phẩm</span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Section -->
            <div class="panel panel-default stats-panel">
                <div class="panel-body">
                    <div class="row text-center">
                        <div class="col-sm-6">
                            <div class="stats-box">
                                <div class="stats-icon">
                                    <i class="fa fa-shopping-cart fa-2x text-primary"></i>
                                </div>
                                <div class="stats-content">
                                    <h3 class="stats-number">{STATS.total_items}</h3>
                                    <span class="stats-label">Tổng mã nguồn</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="stats-box">
                                <div class="stats-icon">
                                    <i class="fa fa-money fa-2x text-success"></i>
                                </div>
                                <div class="stats-content">
                                    <h3 class="stats-number">{STATS.total_spent_format}</h3>
                                    <span class="stats-label">Tổng chi tiêu</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="stats-box">
                                <div class="stats-icon">
                                    <i class="fa fa-gift fa-2x text-info"></i>
                                </div>
                                <div class="stats-content">
                                    <h3 class="stats-number">{STATS.free_items}</h3>
                                    <span class="stats-label">Miễn phí</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="stats-box">
                                <div class="stats-icon">
                                    <i class="fa fa-credit-card fa-2x text-warning"></i>
                                </div>
                                <div class="stats-content">
                                    <h3 class="stats-number">{STATS.paid_items}</h3>
                                    <span class="stats-label">Có phí</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Empty State -->
            <!-- BEGIN: no_purchases -->
            <div class="panel panel-default">
                <div class="panel-body text-center">
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="fa fa-shopping-cart fa-5x text-muted"></i>
                        </div>
                        <h3 class="empty-title">Chưa có mã nguồn nào</h3>
                        <p class="empty-description text-muted">
                            Bạn chưa mua mã nguồn nào. Hãy khám phá và tìm kiếm những mã nguồn phù hợp!
                        </p>
                        <a href="{MODULE_URL}" class="btn btn-primary btn-lg empty-action">
                            <i class="fa fa-search"></i> Khám phá ngay
                        </a>
                    </div>
                </div>
            </div>
            <!-- END: no_purchases -->
        <!-- BEGIN: purchases -->
        <!-- Sources List -->
        <div class="sources-list">
            <!-- BEGIN: purchase -->
            <div class="source-item">
                <div class="source-image">
                    <div class="source-price">
                        <span class="price-badge badge-success">
                            <i class="fa fa-tag"></i> {PURCHASE.amount_format}
                        </span>
                    </div>
                    <a href="{PURCHASE.detail_url}">
                        <img src="{PURCHASE.image_url}" alt="{PURCHASE.title}" class="img-responsive">
                    </a>
                </div>

                <div class="source-content">
                    <div class="source-header">
                        <h3 class="source-title">
                            <a href="{PURCHASE.detail_url}">{PURCHASE.title}</a>
                        </h3>
                    </div>

                    <div class="source-meta">
                        <span class="source-category">
                            <i class="fa fa-folder"></i> {PURCHASE.category_title}
                        </span>
                        <span class="source-date">
                            <i class="fa fa-calendar"></i> {PURCHASE.purchase_time_format}
                        </span>
                    </div>

                    <!-- Star Rating -->
                    <div class="star-rating">
                        <i class="fa fa-star star filled"></i>
                        <i class="fa fa-star star filled"></i>
                        <i class="fa fa-star star filled"></i>
                        <i class="fa fa-star star filled"></i>
                        <i class="fa fa-star star filled"></i>
                        <span class="rating-text">(Đã mua)</span>
                    </div>

                    <div class="source-stats">
                        <span class="stat-item">
                            <i class="fa fa-barcode"></i> {PURCHASE.transaction_id}
                        </span>
                        <span class="stat-item">
                            <i class="fa fa-credit-card"></i> {PURCHASE.payment_method_text}
                        </span>
                    </div>

                    <div class="source-actions">
                        <button onclick="downloadFromHistory({PURCHASE.source_id}); return false;" class="btn btn-success">
                            <i class="fa fa-download"></i> Tải xuống
                        </button>
                        <a href="{PURCHASE.detail_url}" class="btn btn-primary">
                            <i class="fa fa-info-circle"></i> Chi tiết
                        </a>
                    </div>
                </div>
            </div>
            <!-- END: purchase -->
        </div>
        <!-- END: purchases -->
    </div>
</div>
<!-- END: main -->

<script>
// History page functionality
$(document).ready(function() {
    // Add animation classes
    $('.stats-box').each(function(index) {
        $(this).css('animation-delay', (index * 0.1) + 's');
        $(this).addClass('fadeInUp');
    });

    $('.source-item').each(function(index) {
        $(this).css('animation-delay', (index * 0.1) + 's');
        $(this).addClass('fadeInUp');
    });
});

function downloadFromHistory(sourceId) {
    // Show loading state
    var $btn = $('.download-btn[onclick*="' + sourceId + '"]');
    var originalText = $btn.html();
    $btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang tải...');

    // Send AJAX request
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
                // Download directly
                window.location.href = response.download_url;

                // Show success message
                showNotification('Đang tải xuống file...', 'success');
            } else {
                showNotification('Lỗi: ' + response.message, 'error');
            }
        },
        error: function() {
            showNotification('Có lỗi xảy ra khi tải file!', 'error');
        },
        complete: function() {
            // Restore button state
            setTimeout(function() {
                $btn.prop('disabled', false).html(originalText);
            }, 2000);
        }
    });
}

// Show notification function
function showNotification(message, type) {
    var alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
    var icon = type === 'success' ? 'fa-check-circle' : 'fa-exclamation-triangle';

    var notification = $('<div class="alert ' + alertClass + ' alert-dismissible notification-toast" style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px;">' +
        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
        '<i class="fa ' + icon + '"></i> ' + message +
        '</div>');

    $('body').append(notification);

    // Auto hide after 3 seconds
    setTimeout(function() {
        notification.fadeOut(function() {
            $(this).remove();
        });
    }, 3000);
}
</script>

<style>
/* ===== HISTORY PAGE STYLES ===== */

/* Page Header Section */
.page-header-section {
    margin-bottom: 30px;
    background: #ffffff;
    padding: 40px 30px;
    border: 1px solid #e9ecef;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
}

/* Override for history page header */
.page-header-section .page-title {
    color: #2c3e50;
    text-shadow: none;
}

.page-header-section .page-subtitle {
    color: #6c757d;
}

.page-header-section .stats-badge {
    background: #f8f9fa;
    color: #2c3e50;
    border: 2px solid #e9ecef;
    padding: 10px 20px;
    border-radius: 25px;
    font-weight: 600;
    font-size: 15px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.stats-badge {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    background: #f8f9fa;
    padding: 12px 24px;
    border-radius: 30px;
    font-weight: 700;
    font-size: 16px;
    color: #2c3e50;
    border: 2px solid #e9ecef;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.stats-badge i {
    font-size: 18px;
}

/* Stats Panel */
.stats-panel {
    margin-bottom: 30px;
}

.stats-box {
    padding: 20px;
    text-align: center;
    transition: all 0.3s ease;
}

.stats-box:hover {
    transform: translateY(-5px);
}

.stats-icon {
    margin-bottom: 15px;
}

.stats-content {
    display: flex;
    flex-direction: column;
    gap: 5px;
}

.stats-number {
    font-size: 28px;
    font-weight: 700;
    color: #333;
    margin: 0;
}

.stats-label {
    font-size: 13px;
    color: #666;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* Empty State */
.empty-state {
    padding: 60px 20px;
    text-align: center;
}

.empty-icon {
    margin-bottom: 25px;
    transition: all 0.3s ease;
}

.empty-state:hover .empty-icon {
    transform: scale(1.05);
}

.empty-title {
    color: #333;
    font-weight: 600;
    margin-bottom: 15px;
}

.empty-description {
    margin-bottom: 25px;
    max-width: 500px;
    margin-left: auto;
    margin-right: auto;
    line-height: 1.6;
}

.empty-action {
    font-weight: 600;
    padding: 12px 30px;
    border-radius: 25px;
    transition: all 0.3s ease;
}

.empty-action:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3);
}



/* Notification Toast */
.notification-toast {
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    animation: slideInRight 0.3s ease;
}

@keyframes slideInRight {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}

/* Responsive Design */
@media (max-width: 768px) {
    .page-header-section {
        margin-bottom: 20px;
        padding: 20px;
    }

    .page-title-wrapper {
        flex-wrap: wrap;
        gap: 15px;
    }

    .page-icon {
        width: 50px;
        height: 50px;
    }

    .page-icon i {
        font-size: 24px !important;
    }

    .page-title {
        font-size: 24px;
    }

    .page-subtitle {
        font-size: 13px;
    }

    .stats-badge-wrapper {
        width: 100%;
        order: 3;
    }

    .stats-badge {
        padding: 10px 20px;
        font-size: 14px;
        width: 100%;
        justify-content: center;
    }

    .stats-badge i {
        font-size: 16px;
    }

    .stats-panel {
        margin-bottom: 20px;
    }

    .stats-box {
        padding: 15px;
    }

    .stats-number {
        font-size: 24px;
    }

    .stats-label {
        font-size: 12px;
    }

    .empty-state {
        padding: 40px 15px;
    }

    .empty-title {
        font-size: 20px;
    }

    .empty-description {
        font-size: 14px;
    }
}

@media (max-width: 480px) {
    .page-header-section {
        padding: 15px;
    }

    .page-icon {
        width: 45px;
        height: 45px;
    }

    .page-icon i {
        font-size: 20px !important;
    }

    .page-title {
        font-size: 20px;
    }

    .page-subtitle {
        font-size: 12px;
    }

    .stats-badge {
        padding: 8px 16px;
        font-size: 13px;
    }

    .stats-number {
        font-size: 20px;
    }
}

/* Animations */
.fadeInUp {
    animation: fadeInUp 0.6s ease forwards;
    opacity: 0;
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
</style>
