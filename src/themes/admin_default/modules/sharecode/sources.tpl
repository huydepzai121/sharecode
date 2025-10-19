<!-- BEGIN: main -->
<div class="row">
    <div class="col-md-12">
        <div class="page-header">
            <h1>Quản lý mã nguồn <small>ShareCode</small></h1>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="card-title mb-0">
                    <i class="fa fa-list"></i> Danh sách mã nguồn
                </h5>
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}" class="btn btn-success">
                    <i class="fa fa-plus"></i> Thêm mã nguồn mới
                </a>
            </div>
            <div class="card-body">
                <!-- BEGIN: sources -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th width="50">ID</th>
                                <th>Tên mã nguồn</th>
                                <th width="150">Danh mục</th>
                                <th width="100">Loại phí</th>
                                <th width="80">Lượt xem</th>
                                <th width="80">Lượt tải</th>
                                <th width="100">Trạng thái</th>
                                <th width="120">Ngày tạo</th>
                                <th width="120">Thao tác</th>
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
                                        <a href="{SOURCE.edit_url}" class="btn btn-primary btn-sm" title="Sửa">
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
                <!-- END: sources -->
                
                <!-- BEGIN: no_sources -->
                <div class="alert alert-info">
                    Chưa có mã nguồn nào. Vui lòng thêm mã nguồn mới.
                </div>
                <!-- END: no_sources -->
            </div>
        </div>
    </div>
</div>

<!-- Form thêm/sửa mã nguồn -->
<!-- BEGIN: form -->
<div class="row mt-4">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <!-- BEGIN: add -->
                    <i class="fa fa-plus"></i> Thêm mã nguồn mới
                    <!-- END: add -->
                    <!-- BEGIN: edit -->
                    <i class="fa fa-edit"></i> Sửa mã nguồn
                    <!-- END: edit -->
                </h5>
            </div>
            <div class="card-body">
                <!-- BEGIN: error -->
                <div class="alert alert-danger">
                    {ERROR}
                </div>
                <!-- END: error -->
                
                <form action="{FORM_ACTION}" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label for="title" class="form-label">Tên mã nguồn <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="title" id="title" value="{DATA.title}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="alias" class="form-label">Liên kết tĩnh</label>
                                <input type="text" class="form-control" name="alias" id="alias" value="{DATA.alias}">
                                <small class="form-text text-muted">Để trống sẽ tự động tạo</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label>
                                <textarea class="form-control" name="description" id="description" rows="5">{DATA.description}</textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="keywords" class="form-label">Từ khóa</label>
                                <input type="text" class="form-control" name="keywords" id="keywords" value="{DATA.keywords}">
                                <small class="form-text text-muted">Các từ khóa cách nhau bằng dấu phẩy</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="download_link_type" class="form-label">Loại link download</label>
                                <select class="form-select" name="download_link_type" id="download_link_type">
                                    <option value="internal" {DATA.download_link_type_internal_selected}>File nội bộ</option>
                                    <option value="external" {DATA.download_link_type_external_selected}>Link bên ngoài</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="download_link" class="form-label">Link download</label>
                                <input type="text" class="form-control" name="download_link" id="download_link" value="{DATA.download_link}">
                                <small class="form-text text-muted">Đường dẫn file hoặc URL</small>
                            </div>
                            
                            <div class="mb-3">
                                <label for="demo_link" class="form-label">Link demo</label>
                                <input type="url" class="form-control" name="demo_link" id="demo_link" value="{DATA.demo_link}">
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="mb-3">
                                <label for="catid" class="form-label">Danh mục <span class="text-danger">*</span></label>
                                <select class="form-select" name="catid" id="catid" required>
                                    {CATEGORY_OPTIONS}
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="image" class="form-label">Hình ảnh</label>
                                <input type="file" class="form-control" name="image" id="image" accept="image/*">
                                <!-- BEGIN: current_image -->
                                <div class="mt-2">
                                    <img src="{DATA.image_url}" alt="Current image" class="img-thumbnail" style="max-width: 150px;">
                                </div>
                                <!-- END: current_image -->
                            </div>
                            
                            <div class="mb-3">
                                <label for="fee_type" class="form-label">Loại phí</label>
                                <select class="form-select" name="fee_type" id="fee_type" onchange="toggleFeeAmount()">
                                    <option value="free" {DATA.fee_type_free_selected}>Miễn phí</option>
                                    <option value="paid" {DATA.fee_type_paid_selected}>Có phí</option>
                                </select>
                            </div>
                            
                            <div class="mb-3" id="fee_amount_group" style="display: {DATA.fee_amount_display};">
                                <label for="fee_amount" class="form-label">Số tiền (VNĐ)</label>
                                <input type="number" class="form-control" name="fee_amount" id="fee_amount" value="{DATA.fee_amount}" min="0">
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
                        </div>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary" name="save">
                            <i class="fa fa-save"></i> Lưu mã nguồn
                        </button>
                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}" class="btn btn-danger">
                            <i class="fa fa-ban"></i> Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- END: form -->

<script type="text/javascript">
function nv_del_source(id) {
    if (confirm('Bạn có chắc chắn muốn xóa mã nguồn này?')) {
        window.location.href = '{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}={OP}&action=delete&id=' + id + '&confirm=' + nv_md5_check(id + '{NV_CHECK_SESSION}');
    }
}

function toggleFeeAmount() {
    var feeType = document.getElementById('fee_type').value;
    var feeAmountGroup = document.getElementById('fee_amount_group');
    
    if (feeType === 'paid') {
        feeAmountGroup.style.display = 'block';
    } else {
        feeAmountGroup.style.display = 'none';
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    toggleFeeAmount();
});
</script>
<!-- END: main -->
