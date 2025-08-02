<!-- BEGIN: main -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
            <i class="fa fa-star"></i> Quản lý đánh giá 
            <span class="badge">{TOTAL}</span>
        </h3>
    </div>
    
    <div class="panel-body">
        <!-- Filter Form -->
        <form method="get" class="form-inline" style="margin-bottom: 20px;">
            <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}">
            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}">
            <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}">
            
            <div class="form-group">
                <label>Sản phẩm:</label>
                <select name="source_id" class="form-control">
                    <option value="">-- Tất cả sản phẩm --</option>
                    <!-- BEGIN: source_option -->
                    <option value="{SOURCE_OPTION.id}" {SOURCE_OPTION.selected}>{SOURCE_OPTION.title}</option>
                    <!-- END: source_option -->
                </select>
            </div>
            
            <div class="form-group">
                <label>Trạng thái:</label>
                <select name="status_filter" class="form-control">
                    <!-- BEGIN: status_option -->
                    <option value="{STATUS_OPTION.value}" {STATUS_OPTION.selected}>{STATUS_OPTION.text}</option>
                    <!-- END: status_option -->
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">
                <i class="fa fa-filter"></i> Lọc
            </button>
        </form>
        
        <!-- Reviews List -->
        <!-- BEGIN: reviews -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered table-hover">
                <thead>
                    <tr>
                        <th width="5%">ID</th>
                        <th width="15%">Người đánh giá</th>
                        <th width="20%">Sản phẩm</th>
                        <th width="10%">Đánh giá</th>
                        <th width="30%">Nội dung</th>
                        <th width="10%">Thời gian</th>
                        <th width="10%">Trạng thái</th>
                        <th width="10%">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: review -->
                    <tr>
                        <td>{REVIEW.id}</td>
                        <td>
                            <strong>{REVIEW.username}</strong>
                            <br><small class="text-muted">ID: {REVIEW.userid}</small>
                        </td>
                        <td>
                            <a href="{REVIEW.source_link}" target="_blank">{REVIEW.source_title}</a>
                        </td>
                        <td>
                            <div class="rating-display">
                                <span class="rating-stars text-warning">{REVIEW.rating_stars}</span>
                                <br><small>({REVIEW.rating}/5)</small>
                            </div>
                        </td>
                        <td>
                            <div style="max-height: 60px; overflow-y: auto;">
                                {REVIEW.content}
                            </div>
                        </td>
                        <td>
                            <small>{REVIEW.created_time_format}</small>
                        </td>
                        <td>
                            <!-- BEGIN: approved -->
                            <span class="label label-success">Đã duyệt</span>
                            <!-- END: approved -->
                            <!-- BEGIN: pending -->
                            <span class="label label-warning">Chờ duyệt</span>
                            <!-- END: pending -->
                        </td>
                        <td>
                            <div class="btn-group">
                                <!-- BEGIN: approve_btn -->
                                <button type="button" class="btn btn-xs btn-success" 
                                        onclick="changeReviewStatus({REVIEW.id}, 1)">
                                    <i class="fa fa-check"></i> Duyệt
                                </button>
                                <!-- END: approve_btn -->
                                <!-- BEGIN: reject_btn -->
                                <button type="button" class="btn btn-xs btn-warning" 
                                        onclick="changeReviewStatus({REVIEW.id}, 0)">
                                    <i class="fa fa-pause"></i> Chờ
                                </button>
                                <!-- END: reject_btn -->
                                <button type="button" class="btn btn-xs btn-danger" 
                                        onclick="deleteReview({REVIEW.id})">
                                    <i class="fa fa-trash"></i> Xóa
                                </button>
                            </div>
                        </td>
                    </tr>
                    <!-- END: review -->
                </tbody>
            </table>
        </div>
        <!-- END: reviews -->
        
        <!-- BEGIN: no_reviews -->
        <div class="alert alert-info text-center">
            <i class="fa fa-info-circle"></i> Không có đánh giá nào phù hợp với điều kiện lọc.
        </div>
        <!-- END: no_reviews -->
        
        <!-- Pagination -->
        <div class="text-center">
            {GENERATE_PAGE}
        </div>
    </div>
</div>

<script>
function changeReviewStatus(reviewId, status) {
    if (confirm('Bạn có chắc chắn muốn thay đổi trạng thái đánh giá này?')) {
        $.ajax({
            url: '',
            type: 'GET',
            data: {
                action: 'change_status',
                id: reviewId,
                status: status
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    location.reload();
                } else {
                    alert('Lỗi: ' + response.mess);
                }
            },
            error: function() {
                alert('Có lỗi xảy ra khi thay đổi trạng thái');
            }
        });
    }
}

function deleteReview(reviewId) {
    if (confirm('Bạn có chắc chắn muốn xóa đánh giá này? Hành động này không thể hoàn tác.')) {
        var confirmCode = prompt('Nhập "DELETE" để xác nhận xóa:');
        if (confirmCode === 'DELETE') {
            var confirmHash = '{REVIEW.id}' + '{CHECK_SESSION}';
            confirmHash = btoa(confirmHash); // Simple encoding, replace with MD5 if needed
            
            $.ajax({
                url: '',
                type: 'GET',
                data: {
                    action: 'delete',
                    id: reviewId,
                    confirm: confirmHash
                },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        location.reload();
                    } else {
                        alert('Lỗi: ' + response.mess);
                    }
                },
                error: function() {
                    alert('Có lỗi xảy ra khi xóa đánh giá');
                }
            });
        }
    }
}
</script>

<style>
.rating-display .rating-stars {
    font-size: 16px;
}

.panel-title .badge {
    background-color: #337ab7;
}

.btn-group .btn {
    margin-right: 2px;
}

.table td {
    vertical-align: middle;
}

.form-inline .form-group {
    margin-right: 15px;
}

.form-inline label {
    margin-right: 5px;
    font-weight: normal;
}
</style>
<!-- END: main -->