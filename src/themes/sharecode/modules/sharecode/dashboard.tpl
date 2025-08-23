<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="page-header">
                <h2><i class="fa fa-dashboard text-primary"></i> {LANG.my_dashboard}</h2>
                <p class="text-muted">Chào mừng, <strong>{USER.username}</strong>!</p>
            </div>

            <!-- Stats Cards -->
            <div class="row mb-4">
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card bg-primary text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <div class="h4 mb-0">{STATS.total_sources}</div>
                                    <div>{LANG.total_sources}</div>
                                </div>
                                <div class="align-self-center">
                                    <i class="fa fa-code fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card bg-success text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <div class="h4 mb-0">{STATS.approved_sources}</div>
                                    <div>{LANG.approved_sources}</div>
                                </div>
                                <div class="align-self-center">
                                    <i class="fa fa-check-circle fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card bg-warning text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <div class="h4 mb-0">{STATS.pending_sources}</div>
                                    <div>{LANG.pending_sources}</div>
                                </div>
                                <div class="align-self-center">
                                    <i class="fa fa-clock-o fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card bg-info text-white">
                        <div class="card-body">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <div class="h4 mb-0">{STATS.total_views}</div>
                                    <div>{LANG.total_views}</div>
                                </div>
                                <div class="align-self-center">
                                    <i class="fa fa-eye fa-2x"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Secondary Stats -->
            <div class="row mb-4">
                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card">
                        <div class="card-body text-center">
                            <i class="fa fa-download fa-3x text-secondary mb-3"></i>
                            <h4>{STATS.total_downloads}</h4>
                            <p class="text-muted">{LANG.total_downloads}</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card">
                        <div class="card-body text-center">
                            <i class="fa fa-heart fa-3x text-danger mb-3"></i>
                            <h4>{STATS.favorites_count}</h4>
                            <p class="text-muted">{LANG.favorites_count}</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card">
                        <div class="card-body text-center">
                            <i class="fa fa-bell fa-3x text-warning mb-3"></i>
                            <h4>{STATS.unread_notifications}</h4>
                            <p class="text-muted">{LANG.unread_notifications}</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 mb-3">
                    <div class="card">
                        <div class="card-body text-center">
                            <i class="fa fa-money fa-3x text-success mb-3"></i>
                            <h4>{STATS.total_revenue} VND</h4>
                            <p class="text-muted">{LANG.total_revenue}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row mb-4">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fa fa-bolt"></i> Thao tác nhanh</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-3 mb-2">
                                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=submit" class="btn btn-primary btn-block">
                                        <i class="fa fa-plus"></i> {LANG.add_new_product}
                                    </a>
                                </div>
                                <div class="col-md-3 mb-2">
                                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=author&userid={USER.userid}" class="btn btn-outline-primary btn-block">
                                        <i class="fa fa-list"></i> {LANG.manage_products}
                                    </a>
                                </div>
                                <div class="col-md-3 mb-2">
                                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=favorites" class="btn btn-outline-danger btn-block">
                                        <i class="fa fa-heart"></i> {LANG.favorites}
                                    </a>
                                </div>
                                <div class="col-md-3 mb-2">
                                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=notifications" class="btn btn-outline-warning btn-block">
                                        <i class="fa fa-bell"></i> {LANG.notifications}
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="row">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fa fa-clock-o"></i> {LANG.recent_sources}</h5>
                        </div>
                        <div class="card-body">
                            <!-- BEGIN: recent_sources -->
                            <div class="list-group list-group-flush">
                                <!-- BEGIN: source -->
                                <div class="list-group-item d-flex justify-content-between align-items-start">
                                    <div class="ms-2 me-auto">
                                        <div class="fw-bold">
                                            <a href="{SOURCE.detail_url}" class="text-decoration-none">{SOURCE.title}</a>
                                        </div>
                                        <small class="text-muted">{SOURCE.add_time_format}</small>
                                    </div>
                                    <div class="text-end">
                                        <span class="badge bg-{SOURCE.status_class} mb-1">{SOURCE.status_text}</span>
                                        <br>
                                        <div class="btn-group btn-group-sm">
                                            <a href="{SOURCE.edit_url}" class="btn btn-outline-primary btn-sm" title="{LANG.edit_product}">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-outline-danger btn-sm delete-source" 
                                                    data-id="{SOURCE.id}" title="{LANG.delete_product}">
                                                <i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <!-- END: source -->
                            </div>
                            <!-- END: recent_sources -->

                            <!-- BEGIN: no_recent_sources -->
                            <div class="text-center py-3">
                                <i class="fa fa-code fa-3x text-muted mb-2"></i>
                                <p class="text-muted">{LANG.no_recent_sources}</p>
                                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=submit" class="btn btn-primary">
                                    <i class="fa fa-plus"></i> {LANG.add_new_product}
                                </a>
                            </div>
                            <!-- END: no_recent_sources -->
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0"><i class="fa fa-star"></i> {LANG.recent_reviews}</h5>
                        </div>
                        <div class="card-body">
                            <!-- BEGIN: recent_reviews -->
                            <div class="list-group list-group-flush">
                                <!-- BEGIN: review -->
                                <div class="list-group-item">
                                    <div class="d-flex w-100 justify-content-between">
                                        <h6 class="mb-1">
                                            <a href="{REVIEW.source_url}" class="text-decoration-none">{REVIEW.source_title}</a>
                                        </h6>
                                        <small>{REVIEW.add_time_format}</small>
                                    </div>
                                    <p class="mb-1">{REVIEW.content}</p>
                                    <div class="d-flex justify-content-between">
                                        <small>Bởi: <strong>{REVIEW.username}</strong></small>
                                        <div>
                                            <!-- BEGIN: stars -->
                                            <i class="fa fa-star text-warning"></i>
                                            <!-- END: stars -->
                                            <span class="ms-1">{REVIEW.rating}/5</span>
                                        </div>
                                    </div>
                                </div>
                                <!-- END: review -->
                            </div>
                            <!-- END: recent_reviews -->

                            <!-- BEGIN: no_recent_reviews -->
                            <div class="text-center py-3">
                                <i class="fa fa-star-o fa-3x text-muted mb-2"></i>
                                <p class="text-muted">{LANG.no_recent_reviews}</p>
                            </div>
                            <!-- END: no_recent_reviews -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Xử lý xóa sản phẩm
    $('.delete-source').click(function(e) {
        e.preventDefault();
        
        var sourceId = $(this).data('id');
        var listItem = $(this).closest('.list-group-item');
        
        if (confirm('Bạn có chắc muốn xóa sản phẩm này? Hành động này không thể hoàn tác!')) {
            $.post('{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=dashboard', {
                ajax_delete_source: 1,
                source_id: sourceId
            }, function(response) {
                if (response.status === 'success') {
                    listItem.fadeOut(300, function() {
                        $(this).remove();
                        // Kiểm tra nếu không còn item nào
                        if ($('.list-group-item').length === 0) {
                            location.reload();
                        }
                    });
                    
                    // Cập nhật stats
                    var currentTotal = parseInt($('.bg-primary .h4').text());
                    $('.bg-primary .h4').text(currentTotal - 1);
                } else {
                    alert(response.message || 'Có lỗi xảy ra');
                }
            }, 'json').fail(function() {
                alert('Có lỗi xảy ra khi kết nối với máy chủ');
            });
        }
    });
});
</script>
<!-- END: main -->