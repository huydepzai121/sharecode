<!-- BEGIN: main -->
<div id="sharecode-history" class="container">
    <div class="row">
        <div class="col-sm-24">
            <!-- Page Header -->
            <div class="page-header-section">
                <div class="row">
                    <div class="col-sm-18">
                        <div class="page-title-wrapper">
                            <div class="page-icon">
                                <i class="fa fa-history fa-2x text-primary"></i>
                            </div>
                            <div class="page-info">
                                <h1 class="page-title">Lịch sử mua code</h1>
                                <p class="page-subtitle text-muted">Quản lý và tải lại các mã nguồn đã mua</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 text-right">
                        <div class="stats-badge-wrapper">
                            <span class="stats-badge">
                                <i class="fa fa-shopping-cart"></i> {TOTAL_PURCHASES} sản phẩm
                            </span>
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
            <!-- Purchases List -->
            <!-- BEGIN: purchases -->
            <div class="panel panel-default purchases-panel">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <i class="fa fa-list text-primary"></i> Danh sách mã nguồn đã mua ({TOTAL_PURCHASES} mục)
                    </h4>
                </div>
                <div class="panel-body">
                    <!-- BEGIN: purchase -->
                    <div class="purchase-item">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="purchase-image">
                                    <img src="{PURCHASE.image_url}" alt="{PURCHASE.title}" class="img-responsive purchase-img">
                                </div>
                            </div>
                            <div class="col-sm-20">
                                <div class="purchase-info">
                                    <h4 class="purchase-title">
                                        <a href="{PURCHASE.detail_url}" class="purchase-link">{PURCHASE.title}</a>
                                    </h4>
                                    <p class="purchase-description">{PURCHASE.description}</p>

                                    <div class="purchase-meta">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="meta-group">
                                                    <div class="meta-item">
                                                        <i class="fa fa-folder text-primary"></i>
                                                        <strong>Danh mục:</strong> {PURCHASE.category_title}
                                                    </div>
                                                    <div class="meta-item">
                                                        <i class="fa fa-calendar text-primary"></i>
                                                        <strong>Thời gian mua:</strong> {PURCHASE.purchase_time_format}
                                                    </div>
                                                    <div class="meta-item">
                                                        <i class="fa fa-credit-card text-primary"></i>
                                                        <strong>Phương thức:</strong> {PURCHASE.payment_method_text}
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-12">
                                                <div class="meta-group">
                                                    <div class="meta-item">
                                                        <i class="fa fa-tag text-success"></i>
                                                        <strong>Giá:</strong>
                                                        <span class="price-tag">{PURCHASE.amount_format}</span>
                                                    </div>
                                                    <div class="meta-item">
                                                        <i class="fa fa-barcode text-primary"></i>
                                                        <strong>Mã giao dịch:</strong>
                                                        <span class="transaction-id">{PURCHASE.transaction_id}</span>
                                                    </div>
                                                    <div class="meta-item">
                                                        <i class="fa fa-check-circle text-success"></i>
                                                        <strong>Trạng thái:</strong>
                                                        <span class="status-completed">Hoàn thành</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="purchase-actions">
                                        <button onclick="downloadFromHistory({PURCHASE.source_id}); return false;"
                                                class="btn btn-success download-btn">
                                            <i class="fa fa-download"></i> Tải xuống
                                        </button>
                                        <a href="{PURCHASE.detail_url}" class="btn btn-info">
                                            <i class="fa fa-eye"></i> Xem chi tiết
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- END: purchase -->
                </div>

                <!-- Pagination -->
                <!-- BEGIN: pagination -->
                <div class="panel-footer">
                    <div class="text-center">
                        {PAGINATION}
                    </div>
                </div>
                <!-- END: pagination -->
            </div>
            <!-- END: purchases -->
        </div>
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

    $('.purchase-item').each(function(index) {
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
/* ===== HISTORY PAGE STYLES - BOOTSTRAP 3 ===== */

/* Page Header */
.page-header-section {
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 1px solid rgba(0,0,0,0.08);
}

.page-title-wrapper {
    display: table;
    width: 100%;
}

.page-icon {
    display: table-cell;
    vertical-align: middle;
    padding-right: 15px;
    transition: all 0.3s ease;
}

.page-icon:hover {
    transform: scale(1.1);
}

.page-info {
    display: table-cell;
    vertical-align: middle;
}

.page-title {
    margin: 0 0 5px 0;
    font-size: 28px;
    font-weight: bold;
    color: #333;
}

.page-subtitle {
    margin: 0;
    font-size: 14px;
}

.stats-badge-wrapper {
    margin-top: 15px;
}

.stats-badge {
    background: rgba(220, 53, 69, 0.1);
    color: #dc3545;
    border: 1px solid rgba(220, 53, 69, 0.25);
    padding: 8px 15px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 600;
}

/* Stats Panel */
.stats-panel {
    margin-bottom: 30px;
}

.stats-box {
    background: white;
    border: 1px solid #e9ecef;
    border-radius: 12px;
    padding: 25px 20px;
    margin-bottom: 15px;
    transition: all 0.3s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    text-align: center;
}

.stats-box:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.stats-icon {
    margin-bottom: 15px;
    transition: all 0.3s ease;
}

.stats-box:hover .stats-icon {
    transform: scale(1.1);
}

.stats-number {
    color: #333;
    font-weight: bold;
    margin: 10px 0 5px 0;
    font-size: 24px;
}

.stats-label {
    color: #6c757d;
    font-size: 13px;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

/* Purchase Items */
.purchases-panel {
    margin-bottom: 30px;
}

.purchase-item {
    border: 1px solid #e9ecef;
    border-radius: 12px;
    padding: 25px;
    margin-bottom: 25px;
    background: white;
    transition: all 0.3s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.purchase-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.purchase-img {
    border-radius: 8px;
    width: 100%;
    height: 150px;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.purchase-item:hover .purchase-img {
    transform: scale(1.05);
}

.purchase-title {
    margin: 0 0 15px 0;
    font-weight: 600;
    font-size: 18px;
}

.purchase-link {
    color: #333;
    text-decoration: none;
    transition: color 0.3s ease;
}

.purchase-item:hover .purchase-link {
    color: #007bff;
    text-decoration: none;
}

.purchase-description {
    color: #6c757d;
    margin-bottom: 20px;
    font-size: 14px;
    line-height: 1.6;
}

.purchase-meta {
    margin-bottom: 20px;
    padding: 20px;
    background: rgba(13, 110, 253, 0.03);
    border-radius: 8px;
    border: 1px solid rgba(13, 110, 253, 0.1);
}

.meta-group {
    margin-bottom: 0;
}

.meta-item {
    margin-bottom: 10px;
    font-size: 14px;
    display: flex;
    align-items: center;
}

.meta-item:last-child {
    margin-bottom: 0;
}

.meta-item i {
    width: 20px;
    margin-right: 8px;
}

.meta-item strong {
    color: #495057;
    margin-right: 8px;
    min-width: 120px;
}

.price-tag {
    color: #28a745;
    font-weight: bold;
    font-size: 15px;
}

.transaction-id {
    font-family: 'Courier New', monospace;
    font-size: 13px;
    background: rgba(0,0,0,0.05);
    padding: 2px 6px;
    border-radius: 3px;
}

.status-completed {
    color: #28a745;
    font-weight: 600;
    background: rgba(40, 167, 69, 0.1);
    padding: 4px 10px;
    border-radius: 15px;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.purchase-actions {
    margin-top: 20px;
}

.purchase-actions .btn {
    margin-right: 10px;
    margin-bottom: 10px;
    border-radius: 8px;
    font-weight: 600;
    padding: 10px 20px;
    transition: all 0.3s ease;
}

.purchase-actions .btn:hover {
    transform: translateY(-2px);
}

.download-btn:hover {
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
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
    transform: scale(1.1);
}

.empty-title {
    color: #333;
    margin-bottom: 15px;
    font-weight: 600;
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
    .page-title-wrapper {
        display: block;
        text-align: center;
    }

    .page-icon {
        display: block;
        text-align: center;
        padding-right: 0;
        margin-bottom: 15px;
    }

    .page-info {
        display: block;
        text-align: center;
    }

    .stats-badge-wrapper {
        text-align: center;
        margin-top: 20px;
    }

    #sharecode-history .col-sm-6 {
        width: 100%;
        margin-bottom: 15px;
    }

    #sharecode-history .col-sm-4,
    #sharecode-history .col-sm-20 {
        width: 100%;
    }

    .purchase-image {
        margin-bottom: 20px;
        text-align: center;
    }

    .purchase-img {
        max-width: 250px;
        height: auto;
    }

    .meta-item {
        flex-direction: column;
        align-items: flex-start;
        margin-bottom: 15px;
    }

    .meta-item strong {
        min-width: auto;
        margin-bottom: 5px;
    }

    .purchase-actions .btn {
        width: 100%;
        margin-right: 0;
        margin-bottom: 10px;
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
