<!-- BEGIN: main -->
<div class="page-header">
    <h1>Quản lý sản phẩm chờ duyệt <small>({TOTAL_ITEMS} sản phẩm)</small></h1>
</div>

<!-- BEGIN: success -->
<div class="alert alert-success">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <i class="fa fa-check-circle"></i> {SUCCESS_MESSAGE}
</div>
<!-- END: success -->

<!-- Filters -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <i class="fa fa-filter"></i> Bộ lọc
        </h4>
    </div>
    <div class="panel-body">
        <form method="get" class="form-inline">
            <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}">
            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}">
            <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}">
            
            <div class="form-group">
                <label>Trạng thái:</label>
                <select name="status" class="form-control">
                    <!-- BEGIN: status_filter -->
                    <option value="{STATUS_OPTION.value}" {STATUS_OPTION.selected}>{STATUS_OPTION.text}</option>
                    <!-- END: status_filter -->
                </select>
            </div>
            
            <div class="form-group">
                <label>Danh mục:</label>
                <select name="category" class="form-control">
                    <option value="">Tất cả danh mục</option>
                    <!-- BEGIN: category_filter -->
                    <option value="{CATEGORY.id}" {CATEGORY.selected}>{CATEGORY.title}</option>
                    <!-- END: category_filter -->
                </select>
            </div>
            
            <div class="form-group">
                <label>Tác giả:</label>
                <input type="text" name="author" class="form-control" placeholder="Tên tác giả..." value="{AUTHOR_FILTER}">
            </div>
            
            <button type="submit" class="btn btn-primary">
                <i class="fa fa-search"></i> Lọc
            </button>
            
            <a href="{BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}" class="btn btn-default">
                <i class="fa fa-refresh"></i> Đặt lại
            </a>
        </form>
    </div>
</div>

<!-- Sources List -->
<!-- BEGIN: sources -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h4 class="panel-title">
            <i class="fa fa-list"></i> Danh sách sản phẩm
        </h4>
    </div>
    <div class="panel-body" style="padding: 0;">
        <div class="table-responsive">
            <table class="table table-hover table-striped">
                <thead>
                    <tr>
                        <th width="80">Hình ảnh</th>
                        <th>Thông tin sản phẩm</th>
                        <th width="120">Tác giả</th>
                        <th width="100">Giá</th>
                        <th width="120">Trạng thái</th>
                        <th width="100">Ngày tạo</th>
                        <th width="150">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: source -->
                    <tr>
                        <td>
                            <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-responsive" style="max-width: 60px; max-height: 60px; border-radius: 4px;">
                        </td>
                        <td>
                            <div>
                                <strong style="color: #2c3e50;">{SOURCE.title}</strong>
                                <br>
                                <small class="text-muted">Danh mục: {SOURCE.category_title}</small>
                                <br>
                                <small class="text-info">ID: {SOURCE.id}</small>
                            </div>
                        </td>
                        <td>
                            <div>
                                <strong>{SOURCE.author_display}</strong>
                                <!-- BEGIN: email -->
                                <br><small class="text-muted">{SOURCE.email}</small>
                                <!-- END: email -->
                            </div>
                        </td>
                        <td>
                            <span class="label {SOURCE.fee_type == 'free' ? 'label-success' : 'label-warning'}">
                                {SOURCE.price_text}
                            </span>
                        </td>
                        <td>
                            <span class="label label-{SOURCE.status_class}">
                                {SOURCE.status_text}
                            </span>
                        </td>
                        <td>
                            <small>{SOURCE.add_time_format}</small>
                        </td>
                        <td>
                            <!-- BEGIN: pending_actions -->
                            <div class="btn-group-vertical btn-group-xs">
                                <button type="button" class="btn btn-success" onclick="showApproveModal({SOURCE.id}, '{SOURCE.title}')">
                                    <i class="fa fa-check"></i> Duyệt
                                </button>
                                <button type="button" class="btn btn-danger" onclick="showRejectModal({SOURCE.id}, '{SOURCE.title}')">
                                    <i class="fa fa-times"></i> Từ chối
                                </button>
                                <a href="javascript:void(0)" onclick="viewDetails({SOURCE.id})" class="btn btn-info">
                                    <i class="fa fa-eye"></i> Xem
                                </a>
                            </div>
                            <!-- END: pending_actions -->
                            
                            <!-- BEGIN: completed_actions -->
                            <div class="btn-group-vertical btn-group-xs">
                                <a href="javascript:void(0)" onclick="viewDetails({SOURCE.id})" class="btn btn-info">
                                    <i class="fa fa-eye"></i> Xem chi tiết
                                </a>
                                <!-- BEGIN: can_revert -->
                                <button type="button" class="btn btn-warning btn-xs" onclick="revertStatus({SOURCE.id})">
                                    <i class="fa fa-undo"></i> Hoàn tác
                                </button>
                                <!-- END: can_revert -->
                            </div>
                            <!-- END: completed_actions -->
                        </td>
                    </tr>
                    <!-- END: source -->
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- END: sources -->

<!-- BEGIN: no_sources -->
<div class="panel panel-default">
    <div class="panel-body text-center">
        <i class="fa fa-inbox fa-3x text-muted"></i>
        <h4>Không có sản phẩm nào</h4>
        <p class="text-muted">Chưa có sản phẩm nào phù hợp với bộ lọc của bạn.</p>
    </div>
</div>
<!-- END: no_sources -->

<!-- Pagination -->
<!-- BEGIN: pagination -->
<div class="text-center">
    {PAGINATION}
</div>
<!-- END: pagination -->

<!-- Approve Modal -->
<div class="modal fade" id="approveModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">
                    <i class="fa fa-check-circle text-success"></i> Phê duyệt sản phẩm
                </h4>
            </div>
            <form method="post" id="approveForm">
                <div class="modal-body">
                    <input type="hidden" name="action" value="approve">
                    <input type="hidden" name="source_id" id="approve_source_id">
                    
                    <div class="alert alert-info">
                        <i class="fa fa-info-circle"></i>
                        Bạn có chắc chắn muốn phê duyệt sản phẩm: <strong id="approve_title"></strong>?
                    </div>
                    
                    <div class="form-group">
                        <label>Ghi chú (không bắt buộc):</label>
                        <textarea name="note" class="form-control" rows="3" placeholder="Ghi chú cho tác giả..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-success">
                        <i class="fa fa-check"></i> Phê duyệt
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Reject Modal -->
<div class="modal fade" id="rejectModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">
                    <i class="fa fa-times-circle text-danger"></i> Từ chối sản phẩm
                </h4>
            </div>
            <form method="post" id="rejectForm">
                <div class="modal-body">
                    <input type="hidden" name="action" value="reject">
                    <input type="hidden" name="source_id" id="reject_source_id">
                    
                    <div class="alert alert-warning">
                        <i class="fa fa-warning"></i>
                        Bạn có chắc chắn muốn từ chối sản phẩm: <strong id="reject_title"></strong>?
                    </div>
                    
                    <div class="form-group">
                        <label>Lý do từ chối <span class="text-danger">*</span>:</label>
                        <textarea name="note" class="form-control" rows="3" placeholder="Nhập lý do từ chối để tác giả biết và chỉnh sửa..." required></textarea>
                        <small class="help-block">Lý do từ chối sẽ được gửi thông báo cho tác giả</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">
                        <i class="fa fa-times"></i> Từ chối
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Details Modal -->
<div class="modal fade" id="detailsModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">
                    <i class="fa fa-info-circle"></i> Chi tiết sản phẩm
                </h4>
            </div>
            <div class="modal-body" id="details_content">
                <div class="text-center">
                    <i class="fa fa-spinner fa-spin fa-2x"></i>
                    <p>Đang tải...</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script>
function showApproveModal(sourceId, title) {
    $('#approve_source_id').val(sourceId);
    $('#approve_title').text(title);
    $('#approveModal').modal('show');
}

function showRejectModal(sourceId, title) {
    $('#reject_source_id').val(sourceId);
    $('#reject_title').text(title);
    $('#rejectModal').modal('show');
}

function viewDetails(sourceId) {
    $('#detailsModal').modal('show');
    
    // Load details via AJAX
    $.ajax({
        url: 'index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=get_details',
        method: 'POST',
        data: { source_id: sourceId },
        success: function(response) {
            $('#details_content').html(response);
        },
        error: function() {
            $('#details_content').html('<div class="alert alert-danger">Có lỗi xảy ra khi tải thông tin.</div>');
        }
    });
}

function revertStatus(sourceId) {
    if (confirm('Bạn có chắc chắn muốn hoàn tác trạng thái của sản phẩm này?')) {
        $.ajax({
            url: 'index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}',
            method: 'POST',
            data: { 
                action: 'revert',
                source_id: sourceId 
            },
            success: function(response) {
                location.reload();
            }
        });
    }
}

$(document).ready(function() {
    // Auto hide success alerts
    setTimeout(function() {
        $('.alert-success').fadeOut();
    }, 5000);
});
</script>

<style>
.table td {
    vertical-align: middle !important;
}

.btn-group-vertical .btn {
    margin-bottom: 2px;
}

.modal-body .alert {
    margin-bottom: 15px;
}

.panel-body {
    padding: 15px;
}

.form-inline .form-group {
    margin-right: 15px;
    margin-bottom: 10px;
}

.form-inline label {
    margin-right: 5px;
    font-weight: normal;
}

@media (max-width: 768px) {
    .form-inline .form-group {
        display: block;
        margin-bottom: 10px;
    }
    
    .btn-group-vertical .btn {
        display: block;
        width: 100%;
        margin-bottom: 2px;
    }
}
</style>
<!-- END: main -->