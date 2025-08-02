<!-- BEGIN: main -->
<div class="row">
    <div class="col-md-12">
        <div class="page-header">
            <h1>Quản lý danh mục <small>ShareCode</small></h1>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-5">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <!-- BEGIN: add -->
                    <i class="fa fa-plus"></i> Thêm danh mục mới
                    <!-- END: add -->
                    <!-- BEGIN: edit -->
                    <i class="fa fa-edit"></i> Sửa danh mục
                    <!-- END: edit -->
                </h5>
            </div>
            <div class="card-body">
                <!-- BEGIN: error -->
                <div class="alert alert-danger">
                    {ERROR}
                </div>
                <!-- END: error -->
                
                <form action="{FORM_ACTION}" method="post">
                    <div class="mb-3">
                        <label for="title" class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="title" id="title" value="{DATA.title}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="alias" class="form-label">Liên kết tĩnh</label>
                        <input type="text" class="form-control" name="alias" id="alias" value="{DATA.alias}">
                        <small class="form-text text-muted">Để trống sẽ tự động tạo</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="parent_id" class="form-label">Danh mục cha</label>
                        <select class="form-select" name="parent_id" id="parent_id">
                            {PARENT_OPTIONS}
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description" id="description" rows="3">{DATA.description}</textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="weight" class="form-label">Thứ tự</label>
                        <input type="number" class="form-control" name="weight" id="weight" value="{DATA.weight}" min="0">
                    </div>
                    
                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="status" id="status" value="1" {DATA.status_checked}>
                            <label class="form-check-label" for="status">
                                Hoạt động
                            </label>
                        </div>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary" name="save">
                            <i class="fa fa-save"></i> Lưu danh mục
                        </button>
                        <!-- BEGIN: cancel -->
                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}" class="btn btn-danger">
                            <i class="fa fa-ban"></i> Hủy
                        </a>
                        <!-- END: cancel -->
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-md-7">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-list"></i> Danh sách danh mục
                </h5>
            </div>
            <div class="card-body">
                <!-- BEGIN: categories -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th width="50">ID</th>
                                <th>Tên danh mục</th>
                                <th width="100">Thứ tự</th>
                                <th width="100">Trạng thái</th>
                                <th width="120">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- BEGIN: category -->
                            <tr>
                                <td>{CATEGORY.id}</td>
                                <td>
                                    {CATEGORY.level_prefix} <strong>{CATEGORY.title}</strong>
                                    <br><small class="text-muted">{CATEGORY.alias}</small>
                                </td>
                                <td>{CATEGORY.weight}</td>
                                <td>
                                    <!-- BEGIN: active -->
                                    <span class="badge bg-success">Hoạt động</span>
                                    <!-- END: active -->
                                    <!-- BEGIN: inactive -->
                                    <span class="badge bg-secondary">Không hoạt động</span>
                                    <!-- END: inactive -->
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <a href="{CATEGORY.edit_url}" class="btn btn-primary btn-sm" title="Sửa">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <a href="javascript:void(0);" onclick="nv_del_category({CATEGORY.id});" class="btn btn-danger btn-sm" title="Xóa">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            <!-- END: category -->
                        </tbody>
                    </table>
                </div>
                <!-- END: categories -->
                
                <!-- BEGIN: no_categories -->
                <div class="alert alert-info">
                    Chưa có danh mục nào. Vui lòng thêm danh mục mới.
                </div>
                <!-- END: no_categories -->
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function nv_del_category(id) {
    if (confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
        window.location.href = '{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}&action=delete&id=' + id + '&confirm=' + nv_md5(id + '{NV_CHECK_SESSION}');
    }
}
</script>
<!-- END: main -->
