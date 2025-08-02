<!-- BEGIN: main -->
<div class="table-responsive">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                Quản lý Tags
                <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}=tag-content" class="btn btn-primary btn-sm pull-right">
                    <i class="fa fa-plus"></i> Thêm tag mới
                </a>
            </h3>
        </div>
        
        <!-- BEGIN: tags -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th width="50">STT</th>
                        <th>Tên tag</th>
                        <th>Alias</th>
                        <th>Mô tả</th>
                        <th width="80">Số sources</th>
                        <th width="80">Thứ tự</th>
                        <th width="100">Trạng thái</th>
                        <th width="120">Ngày tạo</th>
                        <th width="120">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: tag -->
                    <tr{TAG.class}>
                        <td class="text-center">{TAG.id}</td>
                        <td><strong>{TAG.name}</strong></td>
                        <td><code>{TAG.alias}</code></td>
                        <td>{TAG.description}</td>
                        <td class="text-center">
                            <span class="badge badge-info">{TAG.num_sources}</span>
                        </td>
                        <td class="text-center">
                            <input type="number" class="form-control input-sm text-center" style="width:60px;" value="{TAG.weight}" onchange="change_weight({TAG.id}, this.value);">
                        </td>
                        <td class="text-center">
                            <span class="label label-{TAG.status_class}" style="cursor:pointer;" onclick="change_status({TAG.id});">
                                {TAG.status_text}
                            </span>
                        </td>
                        <td class="text-center">{TAG.add_time_format}</td>
                        <td class="text-center">
                            <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}={MODULE_NAME}&amp;{NV_OP_VARIABLE}=tag-content&amp;id={TAG.id}" class="btn btn-warning btn-xs" title="Sửa">
                                <i class="fa fa-edit"></i>
                            </a>
                            <a href="javascript:void(0);" onclick="delete_tag({TAG.id}, '{TAG.name}');" class="btn btn-danger btn-xs" title="Xóa">
                                <i class="fa fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                    <!-- END: tag -->
                </tbody>
            </table>
        </div>
        <!-- END: tags -->
        
        <!-- BEGIN: generate_page -->
        <div class="panel-footer text-center">
            {GENERATE_PAGE}
        </div>
        <!-- END: generate_page -->
    </div>
</div>

<script>
function change_status(id) {
    if (confirm('Bạn có chắc chắn muốn thay đổi trạng thái?')) {
        $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=tags', {
            action: 'change_status',
            id: id
        }, function(res) {
            if (res == 'OK') {
                location.reload();
            } else {
                alert('Có lỗi xảy ra!');
            }
        });
    }
}

function change_weight(id, new_weight) {
    $.post(script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=tags', {
        action: 'change_weight',
        id: id,
        new_weight: new_weight
    }, function(res) {
        if (res != 'OK') {
            alert('Có lỗi xảy ra!');
            location.reload();
        }
    });
}

function delete_tag(id, name) {
    if (confirm('Bạn có chắc chắn muốn xóa tag "' + name + '"?\nLưu ý: Việc xóa tag sẽ xóa tất cả liên kết với các sources.')) {
        location.href = script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=tags&action=delete&id=' + id;
    }
}
</script>
<!-- END: main -->
