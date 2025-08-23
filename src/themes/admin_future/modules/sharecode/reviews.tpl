<!-- BEGIN: main -->
<div class="row">
    <div class="col-md-12">
        <div class="page-header">
            <h1>Quản lý đánh giá <small>ShareCode</small></h1>
        </div>
    </div>
</div>

<!-- Filter Form -->
<div class="row">
    <div class="col-md-12">
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-filter"></i> Bộ lọc
                </h5>
            </div>
            <div class="card-body">
                <form method="get" action="{NV_BASE_ADMINURL}index.php">
                    <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}"/>
                    <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}"/>
                    <input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}"/>
                    
                    <div class="row">
                        <div class="col-md-3">
                            <div class="mb-3">
                                <label for="source_id" class="form-label">Mã nguồn</label>
                                <select class="form-select" name="source_id" id="source_id">
                                    <option value="0">-- Tất cả --</option>
                                    <!-- BEGIN: source_option -->
                                    <option value="{SOURCE_OPTION.id}" {SOURCE_OPTION.selected}>{SOURCE_OPTION.title}</option>
                                    <!-- END: source_option -->
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="mb-3">
                                <label for="status_filter" class="form-label">Trạng thái</label>
                                <select class="form-select" name="status_filter" id="status_filter">
                                    <!-- BEGIN: status_option -->
                                    <option value="{STATUS_OPTION.value}" {STATUS_OPTION.selected}>{STATUS_OPTION.text}</option>
                                    <!-- END: status_option -->
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="mb-3">
                                <label class="form-label">&nbsp;</label>
                                <div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-search"></i> Lọc
                                    </button>
                                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}" class="btn btn-secondary">
                                        <i class="fa fa-refresh"></i> Làm mới
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Reviews List -->
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0">
                    <i class="fa fa-star"></i> Danh sách đánh giá ({TOTAL} bản ghi)
                </h5>
            </div>
            <div class="card-body">
                <!-- BEGIN: reviews -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th width="50">ID</th>
                                <th>Mã nguồn</th>
                                <th width="120">Người đánh giá</th>
                                <th width="100">Điểm</th>
                                <th>Nhận xét</th>
                                <th width="100">Trạng thái</th>
                                <th width="120">Ngày tạo</th>
                                <th width="120">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- BEGIN: review -->
                            <tr>
                                <td>{REVIEW.id}</td>
                                <td>
                                    <a href="{REVIEW.source_link}" target="_blank" class="text-decoration-none">
                                        <strong>{REVIEW.source_title}</strong>
                                    </a>
                                </td>
                                <td>{REVIEW.username}</td>
                                <td>
                                    <span class="text-warning">{REVIEW.rating_stars}</span>
                                    <br><small>({REVIEW.rating}/5)</small>
                                </td>
                                <td>
                                    <div style="max-width: 200px; overflow: hidden; text-overflow: ellipsis;">
                                        {REVIEW.comment}
                                    </div>
                                </td>
                                <td>
                                    <!-- BEGIN: approved -->
                                    <span class="badge bg-success">Đã duyệt</span>
                                    <!-- END: approved -->
                                    <!-- BEGIN: pending -->
                                    <span class="badge bg-warning">Chờ duyệt</span>
                                    <!-- END: pending -->
                                </td>
                                <td>{REVIEW.created_time_format}</td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <!-- BEGIN: approve_btn -->
                                        <a href="javascript:void(0);" onclick="nv_change_status({REVIEW.id}, 1);" class="btn btn-success btn-sm" title="Duyệt">
                                            <i class="fa fa-check"></i>
                                        </a>
                                        <!-- END: approve_btn -->
                                        <!-- BEGIN: reject_btn -->
                                        <a href="javascript:void(0);" onclick="nv_change_status({REVIEW.id}, 0);" class="btn btn-warning btn-sm" title="Từ chối">
                                            <i class="fa fa-times"></i>
                                        </a>
                                        <!-- END: reject_btn -->
                                        <a href="javascript:void(0);" onclick="nv_del_review({REVIEW.id});" class="btn btn-danger btn-sm" title="Xóa">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <!-- END: review -->
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <div class="text-center mt-3">
                    {GENERATE_PAGE}
                </div>
                <!-- END: reviews -->
                
                <!-- BEGIN: no_reviews -->
                <div class="alert alert-info">
                    <i class="fa fa-info-circle"></i> Chưa có đánh giá nào.
                </div>
                <!-- END: no_reviews -->
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function nv_del_review(id) {
    if (confirm('Bạn có chắc chắn muốn xóa đánh giá này?')) {
        window.location.href = '{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}&action=delete&id=' + id + '&confirm={NV_CHECK_SESSION}';
    }
}

function nv_change_status(id, status) {
    var action_text = status == 1 ? 'duyệt' : 'từ chối';
    if (confirm('Bạn có chắc chắn muốn ' + action_text + ' đánh giá này?')) {
        window.location.href = location.reload();
    }
}
</script>
<!-- END: main -->
