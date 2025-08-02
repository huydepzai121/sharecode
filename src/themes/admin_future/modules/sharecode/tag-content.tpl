<!-- BEGIN: main -->
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
            {LANG.tag_content}
            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}=tags" class="btn btn-default btn-sm pull-right">
                <i class="fa fa-arrow-left"></i> {GLANG.back}
            </a>
        </h3>
    </div>
    
    <div class="panel-body">
        <!-- BEGIN: error -->
        <div class="alert alert-danger">
            {ERROR}
        </div>
        <!-- END: error -->
        
        <form method="post" action="">
            <div class="row">
                <div class="col-md-8">
                    <div class="form-group">
                        <label for="name">Tên tag <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" id="name" value="{TAG.name}" required maxlength="255">
                    </div>
                    
                    <div class="form-group">
                        <label for="alias">Alias</label>
                        <input type="text" class="form-control" name="alias" id="alias" value="{TAG.alias}" maxlength="255">
                        <small class="help-block">Để trống để tự động tạo từ tên tag</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Mô tả</label>
                        <textarea class="form-control" name="description" id="description" rows="4">{TAG.description}</textarea>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="weight">Thứ tự</label>
                        <input type="number" class="form-control" name="weight" id="weight" value="{TAG.weight}" min="0">
                        <small class="help-block">Số càng nhỏ càng ưu tiên hiển thị trước</small>
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Trạng thái</label>
                        <select class="form-control" name="status" id="status">
                            <!-- BEGIN: status_option -->
                            <option value="{STATUS_OPTION.value}" {STATUS_OPTION.selected}>{STATUS_OPTION.text}</option>
                            <!-- END: status_option -->
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <button type="submit" name="save" value="1" class="btn btn-primary">
                            <i class="fa fa-save"></i> {GLANG.save}
                        </button>
                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}=tags" class="btn btn-default">
                            <i class="fa fa-times"></i> {GLANG.cancel}
                        </a>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
$(document).ready(function() {
    // Auto generate alias from name
    $('#name').on('input', function() {
        if ($('#alias').val() == '') {
            var alias = change_alias($(this).val());
            $('#alias').val(alias);
        }
    });
});
</script>
<!-- END: main -->
