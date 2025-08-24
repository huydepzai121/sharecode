<!-- BEGIN: main -->
<div id="sharecode-history" class="container">
    <div class="row">
        <div class="col-sm-24">
            <!-- Page Header -->
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <i class="fa fa-history"></i> Lịch sử mua code
                    </h3>
                </div>
                <div class="panel-body">
                    <!-- Statistics -->
                    <div class="row text-center">
                        <div class="col-sm-6">
                            <div class="stats-box">
                                <div class="stats-icon">
                                    <i class="fa fa-shopping-cart"></i>
                                </div>
                                <div class="stats-content">
                                    <h4>{STATS.total_items}</h4>
                                    <span>Tổng mã nguồn</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="stats-box">
                                <div class="stats-icon">
                                    <i class="fa fa-money"></i>
                                </div>
                                <div class="stats-content">
                                    <h4>{STATS.total_spent_format}</h4>
                                    <span>Tổng chi tiêu</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="stats-box">
                                <div class="stats-icon">
                                    <i class="fa fa-gift"></i>
                                </div>
                                <div class="stats-content">
                                    <h4>{STATS.free_items}</h4>
                                    <span>Miễn phí</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="stats-box">
                                <div class="stats-icon">
                                    <i class="fa fa-credit-card"></i>
                                </div>
                                <div class="stats-content">
                                    <h4>{STATS.paid_items}</h4>
                                    <span>Có phí</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Purchase List -->
            <!-- BEGIN: empty_list -->
            <div class="panel panel-default">
                <div class="panel-body text-center">
                    <div class="empty-state">
                        <i class="fa fa-shopping-cart fa-5x text-muted"></i>
                        <h3>Chưa có mã nguồn nào</h3>
                        <p class="text-muted">Bạn chưa mua mã nguồn nào. Hãy khám phá và tìm kiếm những mã nguồn phù hợp!</p>
                        <a href="{MODULE_URL}" class="btn btn-primary">
                            <i class="fa fa-search"></i> Khám phá ngay
                        </a>
                    </div>
                </div>
            </div>
            <!-- END: empty_list -->

            <!-- BEGIN: purchase_list -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <i class="fa fa-list"></i> Danh sách mã nguồn đã mua ({TOTAL_PURCHASES} mục)
                    </h4>
                </div>
                <div class="panel-body">
                    <!-- BEGIN: purchase -->
                    <div class="purchase-item">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="purchase-image">
                                    <img src="{PURCHASE.image_url}" alt="{PURCHASE.title}" class="img-responsive">
                                </div>
                            </div>
                            <div class="col-sm-20">
                                <div class="purchase-info">
                                    <h4 class="purchase-title">
                                        <a href="{PURCHASE.detail_url}">{PURCHASE.title}</a>
                                    </h4>
                                    <p class="purchase-description">{PURCHASE.description}</p>
                                    
                                    <div class="purchase-meta">
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="meta-item">
                                                    <strong>Danh mục:</strong> {PURCHASE.category_title}
                                                </div>
                                                <div class="meta-item">
                                                    <strong>Thời gian mua:</strong> {PURCHASE.purchase_time_format}
                                                </div>
                                                <div class="meta-item">
                                                    <strong>Phương thức:</strong> {PURCHASE.payment_method_text}
                                                </div>
                                            </div>
                                            <div class="col-sm-12">
                                                <div class="meta-item">
                                                    <strong>Giá:</strong> 
                                                    <span class="price-tag">{PURCHASE.amount_format}</span>
                                                </div>
                                                <div class="meta-item">
                                                    <strong>Mã giao dịch:</strong> {PURCHASE.transaction_id}
                                                </div>
                                                <div class="meta-item">
                                                    <strong>Trạng thái:</strong> 
                                                    <span class="status-completed">Hoàn thành</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="purchase-actions">
                                        <a href="#" onclick="downloadFromHistory({PURCHASE.source_id}); return false;" class="btn btn-success">
                                            <i class="fa fa-download"></i> Tải xuống
                                        </a>
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
            <!-- END: purchase_list -->
        </div>
    </div>
</div>

<script>
function downloadFromHistory(sourceId) {
    // Gửi AJAX để lấy download link trực tiếp
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
                // Download trực tiếp
                window.location.href = response.download_url;
            } else {
                alert('Lỗi: ' + response.message);
            }
        },
        error: function() {
            alert('Có lỗi xảy ra khi tải file!');
        }
    });
}
</script>

<style>


.stats-box {
    background: white;
    border: 2px solid #f1f3f4;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 15px;
    transition: all 0.3s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.stats-box:hover {
    border-color: #667eea;
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(102, 126, 234, 0.15);
}

.stats-icon {
    font-size: 32px;
    color: #667eea;
    margin-bottom: 10px;
}

.stats-content h4 {
    color: #2c3e50;
    font-weight: 700;
    margin: 5px 0;
    font-size: 24px;
}

.stats-content span {
    color: #6c757d;
    font-size: 14px;
    font-weight: 500;
}

.purchase-item {
    border: 1px solid #e9ecef;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
    background: white;
    transition: all 0.3s ease;
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.purchase-item:hover {
    border-color: #667eea;
    box-shadow: 0 4px 15px rgba(102, 126, 234, 0.1);
    transform: translateY(-2px);
}

.purchase-image img {
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    width: 100%;
    height: 120px;
    object-fit: cover;
}

.purchase-title {
    margin: 0 0 10px 0;
    font-weight: 600;
}

.purchase-title a {
    color: #2c3e50;
    text-decoration: none;
    transition: color 0.3s ease;
}

.purchase-title a:hover {
    color: #667eea;
    text-decoration: none;
}

.purchase-description {
    color: #6c757d;
    margin-bottom: 15px;
    font-size: 14px;
    line-height: 1.5;
}

.purchase-meta {
    margin-bottom: 15px;
    padding: 15px;
    background: #f8f9fa;
    border-radius: 6px;
}

.meta-item {
    margin-bottom: 8px;
    font-size: 13px;
}

.meta-item strong {
    color: #495057;
    display: inline-block;
    width: 100px;
}

.price-tag {
    color: #28a745;
    font-weight: 600;
}

.status-completed {
    color: #28a745;
    font-weight: 600;
    background: rgba(40, 167, 69, 0.1);
    padding: 2px 8px;
    border-radius: 4px;
    font-size: 12px;
}

.purchase-actions {
    margin-top: 15px;
}

.purchase-actions .btn {
    margin-right: 10px;
    margin-bottom: 5px;
    border-radius: 6px;
    font-weight: 500;
    padding: 8px 16px;
    transition: all 0.3s ease;
}

.empty-state {
    padding: 60px 20px;
}

.empty-state i {
    margin-bottom: 20px;
}

.empty-state h3 {
    color: #495057;
    margin-bottom: 15px;
}

.empty-state .btn {
    background: linear-gradient(45deg, #667eea, #764ba2);
    border: none;
    padding: 12px 30px;
    border-radius: 25px;
    font-weight: 600;
    transition: all 0.3s ease;
}

.empty-state .btn:hover {
    background: linear-gradient(45deg, #764ba2, #667eea);
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
}

/* Responsive */
@media (max-width: 768px) {
    #sharecode-history .col-sm-6 {
        width: 100%;
        margin-bottom: 10px;
    }
    
    #sharecode-history .col-sm-4,
    #sharecode-history .col-sm-20 {
        width: 100%;
    }chaof
    
    #sharecode-history .purchase-image {
        margin-bottom: 15px;
        text-align: center;
    }
    
    #sharecode-history .purchase-image img {
        max-width: 200px;
        height: auto;
    }
    
    #sharecode-history .meta-item strong {
        width: auto;
        display: block;
        margin-bottom: 2px;
    }
    
    #sharecode-history .purchase-actions .btn {
        width: 100%;
        margin-bottom: 10px;
        margin-right: 0;
    }
}

/* Animation */
.purchase-item {
    animation: fadeInUp 0.5s ease;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

</style>
<!-- END: main -->