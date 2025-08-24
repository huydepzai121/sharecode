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
                            <!-- BEGIN: has_sources -->
                            <a href="javascript:void(0);" onclick="showTagLinks({TAG.id}, '{TAG.name}');" class="badge badge-info" title="Xem danh sách mã nguồn">
                                <i class="fa fa-link"></i> {TAG.num_sources}
                            </a>
                            <!-- END: has_sources -->
                            <!-- BEGIN: no_sources -->
                            <span class="badge badge-secondary" title="Chưa có mã nguồn nào">0</span>
                            <!-- END: no_sources -->
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

<!-- Modal hiển thị danh sách mã nguồn của tag -->
<div class="modal fade" id="tagLinksModal" tabindex="-1" role="dialog" aria-labelledby="tagLinksModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="tagLinksModalLabel">
                    <i class="fa fa-link"></i> Danh sách mã nguồn sử dụng tag: <span id="tagName" class="text-primary"></span>
                </h4>
            </div>
            <div class="modal-body" id="tagLinksContent">
                <div class="text-center">
                    <i class="fa fa-spinner fa-spin fa-2x"></i>
                    <p class="mt-2">Đang tải dữ liệu...</p>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <i class="fa fa-times"></i> Đóng
                </button>
            </div>
        </div>
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

function showTagLinks(tagId, tagName) {
    $('#tagName').text(tagName);
    $('#tagLinksContent').html('<div class="text-center"><i class="fa fa-spinner fa-spin fa-2x"></i><p class="mt-2">Đang tải dữ liệu...</p></div>');
    $('#tagLinksModal').modal('show');

    $.ajax({
        url: script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=tags',
        type: 'POST',
        data: {
            tagLinks: 1,
            id: tagId,
            checkss: nv_check_session
        },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                $('#tagLinksContent').html(response.html);
            } else {
                $('#tagLinksContent').html('<div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> ' + response.text + '</div>');
            }
        },
        error: function() {
            $('#tagLinksContent').html('<div class="alert alert-danger"><i class="fa fa-exclamation-triangle"></i> Có lỗi xảy ra khi tải dữ liệu!</div>');
        }
    });
}

function removeTagLink(tagId, sourceId) {
    if (confirm('Bạn có chắc chắn muốn xóa liên kết này?')) {
        $.ajax({
            url: script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=tags',
            type: 'POST',
            data: {
                removeTagLink: 1,
                tag_id: tagId,
                source_id: sourceId,
                checkss: nv_check_session
            },
            dataType: 'json',
            success: function(response) {
                if (response.success) {
                    // Reload modal content
                    var tagName = $('#tagName').text();
                    showTagLinks(tagId, tagName);
                    // Reload page to update count
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                } else {
                    alert('Có lỗi xảy ra: ' + response.text);
                }
            },
            error: function() {
                alert('Có lỗi xảy ra khi xóa liên kết!');
            }
        });
    }
}
</script>
<!-- END: main -->
