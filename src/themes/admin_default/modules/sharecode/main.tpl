<!-- BEGIN: main -->
<div class="row">
    <div class="col-md-12">
        <div class="page-header">
            <h1>Quản lý ShareCode <small>Trang chủ</small></h1>
        </div>
    </div>
</div>

<!-- Thống kê -->
<div class="row">
    <div class="col-md-3">
        <div class="card bg-primary text-white mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">{STATS.total_categories}</h4>
                        <p class="card-text">Tổng danh mục</p>
                    </div>
                    <div class="align-self-center">
                        <i class="fa fa-folder fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-success text-white mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">{STATS.total_sources}</h4>
                        <p class="card-text">Tổng mã nguồn</p>
                    </div>
                    <div class="align-self-center">
                        <i class="fa fa-code fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-info text-white mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">{STATS.total_downloads}</h4>
                        <p class="card-text">Tổng lượt tải</p>
                    </div>
                    <div class="align-self-center">
                        <i class="fa fa-download fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card bg-warning text-white mb-4">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">{STATS.total_views}</h4>
                        <p class="card-text">Tổng lượt xem</p>
                    </div>
                    <div class="align-self-center">
                        <i class="fa fa-eye fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Mã nguồn mới nhất -->
<!-- BEGIN: sources -->
<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-list"></i> Mã nguồn mới nhất
                </h5>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th width="50">ID</th>
                                <th>Tên mã nguồn</th>
                                <th width="150">Danh mục</th>
                                <th width="100">Loại phí</th>
                                <th width="100">Lượt xem</th>
                                <th width="100">Lượt tải</th>
                                <th width="100">Trạng thái</th>
                                <th width="120">Ngày tạo</th>
                                <th width="80">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- BEGIN: source -->
                            <tr>
                                <td>{SOURCE.id}</td>
                                <td>
                                    <strong>{SOURCE.title}</strong>
                                    <br><small class="text-muted">{SOURCE.alias}</small>
                                </td>
                                <td>{SOURCE.category_title}</td>
                                <td>
                                    <!-- BEGIN: free -->
                                    <span class="badge bg-success">Miễn phí</span>
                                    <!-- END: free -->
                                    <!-- BEGIN: paid -->
                                    <span class="badge bg-warning">{SOURCE.fee_text}</span>
                                    <!-- END: paid -->
                                </td>
                                <td>
                                    <span class="badge bg-info">{SOURCE.num_view}</span>
                                </td>
                                <td>
                                    <span class="badge bg-primary">{SOURCE.num_download}</span>
                                </td>
                                <td>
                                    <!-- BEGIN: active -->
                                    <span class="badge bg-success">Hoạt động</span>
                                    <!-- END: active -->
                                    <!-- BEGIN: inactive -->
                                    <span class="badge bg-secondary">Không hoạt động</span>
                                    <!-- END: inactive -->
                                </td>
                                <td>{SOURCE.add_time_format}</td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=sources&id={SOURCE.id}" class="btn btn-primary btn-sm" title="Sửa">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <a href="javascript:void(0);" onclick="nv_del_source({SOURCE.id});" class="btn btn-danger btn-sm" title="Xóa">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <!-- END: source -->
                        </tbody>
                    </table>
                </div>
                <div class="text-center mt-3">
                    <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=sources" class="btn btn-primary">
                        <i class="fa fa-list"></i> Xem tất cả mã nguồn
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: sources -->

<!-- Menu nhanh -->
<div class="row mt-4">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-cogs"></i> Quản lý nhanh
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=categories" class="btn btn-outline-primary btn-lg w-100 mb-3">
                            <i class="fa fa-folder fa-2x d-block mb-2"></i>
                            Quản lý danh mục
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=sources" class="btn btn-outline-success btn-lg w-100 mb-3">
                            <i class="fa fa-code fa-2x d-block mb-2"></i>
                            Quản lý mã nguồn
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=reviews" class="btn btn-outline-info btn-lg w-100 mb-3">
                            <i class="fa fa-star fa-2x d-block mb-2"></i>
                            Quản lý đánh giá
                        </a>
                    </div>
                    <div class="col-md-3">
                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=logs" class="btn btn-outline-warning btn-lg w-100 mb-3">
                            <i class="fa fa-history fa-2x d-block mb-2"></i>
                            Nhật ký hoạt động
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function nv_del_source(id) {
    if (confirm('Bạn có chắc chắn muốn xóa mã nguồn này?')) {
        window.location.href = '{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=sources&action=delete&id=' + id + '&confirm=' + nv_md5_check(id + '{NV_CHECK_SESSION}');
    }
}
</script>
<!-- END: main -->
