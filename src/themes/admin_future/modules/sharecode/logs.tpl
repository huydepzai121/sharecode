<!-- BEGIN: main -->
<div class="row">
    <div class="col-md-12">
        <div class="page-header">
            <h1>Nhật ký hoạt động <small>ShareCode</small></h1>
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
                        <div class="col-md-2">
                            <div class="mb-3">
                                <label for="action_filter" class="form-label">Loại hoạt động</label>
                                <select class="form-select" name="action_filter" id="action_filter">
                                    <option value="">-- Tất cả --</option>
                                    <!-- BEGIN: action_option -->
                                    <option value="{ACTION_OPTION.value}" {ACTION_OPTION.selected}>{ACTION_OPTION.text}</option>
                                    <!-- END: action_option -->
                                </select>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="mb-3">
                                <label for="user_filter" class="form-label">Người dùng</label>
                                <input type="text" class="form-control" name="user_filter" id="user_filter" value="{USER_FILTER}" placeholder="Tên người dùng">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="mb-3">
                                <label for="from_date" class="form-label">Từ ngày</label>
                                <input type="date" class="form-control" name="from_date" id="from_date" value="{FROM_DATE}">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="mb-3">
                                <label for="to_date" class="form-label">Đến ngày</label>
                                <input type="date" class="form-control" name="to_date" id="to_date" value="{TO_DATE}">
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="mb-3">
                                <label class="form-label">&nbsp;</label>
                                <div>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fa fa-search"></i> Lọc
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <div class="mb-3">
                                <label class="form-label">&nbsp;</label>
                                <div>
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

<!-- Logs List -->
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0">
                    <i class="fa fa-history"></i> Nhật ký hoạt động ({TOTAL} bản ghi)
                </h5>
                <div class="btn-group">
                    <button type="button" class="btn btn-warning dropdown-toggle" data-bs-toggle="dropdown">
                        <i class="fa fa-trash"></i> Xóa log cũ
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="javascript:void(0);" onclick="nv_clear_logs(7);">Xóa log > 7 ngày</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0);" onclick="nv_clear_logs(30);">Xóa log > 30 ngày</a></li>
                        <li><a class="dropdown-item" href="javascript:void(0);" onclick="nv_clear_logs(90);">Xóa log > 90 ngày</a></li>
                    </ul>
                </div>
            </div>
            <div class="card-body">
                <!-- BEGIN: logs -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th width="50">ID</th>
                                <th width="120">Người dùng</th>
                                <th width="120">Hoạt động</th>
                                <th>Mô tả</th>
                                <th width="100">IP</th>
                                <th width="140">Thời gian</th>
                                <th width="80">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- BEGIN: log -->
                            <tr>
                                <td>{LOG.id}</td>
                                <td>
                                    <strong>{LOG.username}</strong>
                                </td>
                                <td>
                                    <span class="badge bg-info">{LOG.action_text}</span>
                                </td>
                                <td>
                                    {LOG.description}
                                    <!-- BEGIN: reference_link -->
                                    <br><a href="{LOG.reference_link}" target="_blank" class="text-primary">
                                        <i class="fa fa-external-link"></i> {LOG.reference_title}
                                    </a>
                                    <!-- END: reference_link -->
                                </td>
                                <td>
                                    <small class="text-muted">{LOG.ip_address}</small>
                                </td>
                                <td>
                                    <small>{LOG.created_time_format}</small>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-sm btn-danger" onclick="nv_delete_log({LOG.id});" title="Xóa log này">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <!-- END: log -->
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <div class="text-center mt-3">
                    {GENERATE_PAGE}
                </div>
                <!-- END: logs -->
                
                <!-- BEGIN: no_logs -->
                <div class="alert alert-info">
                    <i class="fa fa-info-circle"></i> Chưa có nhật ký hoạt động nào.
                </div>
                <!-- END: no_logs -->
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function nv_clear_logs(days) {
    if (confirm('Bạn có chắc chắn muốn xóa tất cả log cũ hơn ' + days + ' ngày?')) {
        var confirmToken = btoa('clear_logs' + '{NV_CHECK_SESSION}').replace(/[^a-zA-Z0-9]/g, '').substring(0, 32);

        // Hiển thị loading
        var btn = document.querySelector('.btn.btn-warning.dropdown-toggle');
        var originalText = btn.innerHTML;
        btn.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Đang xóa...';
        btn.disabled = true;

        $.ajax({
            url: location.href,
            type: 'POST',
            data: {
                action: 'clear_logs',
                days: days,
                confirm: confirmToken
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    nukeviet.toast(response.mess, 'success');
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                } else {
                    nukeviet.toast(response.mess || 'Không thể xóa log', 'error');
                }
            },
            error: function(xhr, status, error) {
                nukeviet.toast('Có lỗi xảy ra: ' + error, 'error');
            },
            complete: function() {
                // Khôi phục nút
                btn.innerHTML = originalText;
                btn.disabled = false;
            }
        });
    }
}

function nv_delete_log(logId) {
    if (confirm('Bạn có chắc chắn muốn xóa log này?')) {
        var btn = event.target.closest('button');
        var originalText = btn.innerHTML;
        btn.innerHTML = '<i class="fa fa-spinner fa-spin"></i>';
        btn.disabled = true;

        $.ajax({
            url: location.href,
            type: 'POST',
            data: {
                action: 'delete',
                id: logId
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    nukeviet.toast(response.mess || 'Đã xóa log thành công', 'success');
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                } else {
                    nukeviet.toast(response.mess || 'Không thể xóa log', 'error');
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            },
            error: function(xhr, status, error) {
                nukeviet.toast('Có lỗi xảy ra: ' + error, 'error');
                btn.innerHTML = originalText;
                btn.disabled = false;
            }
        });
    }
}
</script>
<!-- END: main -->
