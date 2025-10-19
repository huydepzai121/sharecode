<!-- CSS -->
<link rel="stylesheet" href="{ASSETS_STATIC_URL}/css/dataTables.bootstrap5.min.css">

<!-- JavaScript -->
<script src="{ASSETS_STATIC_URL}/js/datatable/jquery.dataTables.min.js"></script>
<script src="{ASSETS_STATIC_URL}/js/datatable/dataTables.bootstrap5.min.js"></script>
<link type="text/css" href="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/i18n/{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/language/jquery.ui.datepicker-{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/clipboard/clipboard.min.js"></script>

<div class="row">
    <div class="col-xxl-12">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalAddBank">
                    <i class="fas fa-plus"></i> Thêm tài khoản
                </button>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered" id="bankTable">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Ngân hàng</th>
                                <th>Chủ tài khoản</th>
                                <th>Số tài khoản</th>
                                <th>Logo</th>
                                <th>Ghi chú</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach from=$BANK_LIST item=bank}
                            <tr>
                                <td>{$bank.id}</td>
                                <td>{$bank.title}</td>
                                <td>{$bank.account_holder}</td>
                                <td>{$bank.account_number}</td>
                                <td>
                                    <img src="{$bank.bank_name}" class="img-thumbnail" style="max-height: 50px">
                                </td>
                                <td>{$bank.note}</td>
                                <td>
                                    <div class="form-check form-switch">
                                        <input class="form-check-input" type="checkbox" role="switch"
                                            onchange="changeStatus({$bank.id}, this.checked)"
                                            {if $bank.status == 1}checked{/if}>
                                    </div>
                                </td>
                                <td>
                                    <button class="btn btn-sm btn-info me-1" onclick="editBank({$bank.id})">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn btn-sm btn-danger" onclick="deleteBank({$bank.id})">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Thêm/Sửa -->
<div class="modal fade" id="modalAddBank" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Thêm tài khoản ngân hàng</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="bankForm" onsubmit="return false;">
                <div class="modal-body">
                    <input type="hidden" name="id" id="bank_id">

                    <div class="mb-3">
                        <label class="form-label">Tên ngân hàng</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Chủ tài khoản</label>
                        <input type="text" class="form-control" name="account_holder" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số tài khoản</label>
                        <input type="text" class="form-control" name="account_number" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Logo ngân hàng</label>
                        <div class="input-group">
                            <input type="text" class="form-control" name="bank_logo" id="bank_logo" maxlength="255">
                            <button class="btn btn-default" type="button"
                                onclick="nv_open_browse('{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}=upload&popup=1&area=bank_logo&path={NV_UPLOADS_DIR}/wallet&currentpath={NV_UPLOADS_DIR}/wallet&type=image', 'NVImg', '850', '500', 'resizable=no,scrollbars=no,toolbar=no,location=no,status=no');">
                                <em class="fa fa-folder-open-o fa-fix">&nbsp;</em>
                            </button>
                        </div>
                        <div id="preview_image" class="mt-2"></div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Nội dung chuyển khoản</label>
                        <input type="text" class="form-control" name="description_content">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ghi chú</label>
                        <textarea class="form-control" name="note" rows="3"></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Trạng thái</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" name="status" value="1" checked>
                            <label class="form-check-label">Kích hoạt</label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary" onclick="saveBank()">Lưu</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#bankTable').DataTable({
        language: {
            url: '{ASSETS_STATIC_URL}/js/datatable/Vietnamese.json'
        }
    });

    // Xử lý preview ảnh khi chọn file từ trình quản lý
    $('#bank_logo').on('change', function() {
        var imageUrl = $(this).val();
        if (imageUrl) {
            $('#preview_image').html('<img src="{NV_BASE_SITEURL}' + imageUrl + '" class="img-thumbnail" style="max-height: 100px">');
        } else {
            $('#preview_image').html('');
        }
    });

    // Reset form khi đóng modal
    $('#modalAddBank').on('hidden.bs.modal', function () {
        $('#bankForm')[0].reset();
        $('#bank_id').val('');
        $('#preview_image').html('');
        $('#modalTitle').text('Thêm tài khoản ngân hàng');
    });
});

function editBank(id) {
    $.ajax({
        url: '{$BASE_URL}',
        type: 'POST',
        data: {
            action: 'get_bank',
            id: id
        },
        dataType: 'json',
        success: function(response) {
            if (response.status == 'success') {
                var data = response.data;
                $('#bank_id').val(data.id);
                $('#modalTitle').text('Sửa tài khoản ngân hàng');
                $('input[name="title"]').val(data.title);
                $('input[name="account_holder"]').val(data.account_holder);
                $('input[name="account_number"]').val(data.account_number);
                $('input[name="description_content"]').val(data.description_content);
                $('textarea[name="note"]').val(data.note);
                $('input[name="status"]').prop('checked', data.status == 1);

                if (data.bank_name) {
                    $('#bank_logo').val(data.bank_name);
                    $('#preview_image').html('<img src="' + data.bank_name + '" class="img-thumbnail" style="max-height: 100px">');
                }

                $('#modalAddBank').modal('show');
            } else {
                alert(response.message);
            }
        }
    });
}

function saveBank() {
    var formData = new FormData($('#bankForm')[0]);
    formData.append('action', $('#bank_id').val() ? 'edit_bank' : 'add_bank');

    $.ajax({
        url: '{$BASE_URL}',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        dataType: 'json',
        success: function(response) {
            if (response.status == 'success') {
                alert(response.message);
                location.reload();
            } else {
                alert(response.message);
            }
        }
    });
}

function deleteBank(id) {
    if (confirm('Bạn có chắc muốn xóa tài khoản này?')) {
        $.ajax({
            url: '{$BASE_URL}',
            type: 'POST',
            data: {
                action: 'delete_bank',
                id: id
            },
            dataType: 'json',
            success: function(response) {
                if (response.status == 'success') {
                    alert(response.message);
                    location.reload();
                } else {
                    alert(response.message);
                }
            }
        });
    }
}

function changeStatus(id, status) {
    $.ajax({
        url: '{$BASE_URL}',
        type: 'POST',
        data: {
            action: 'change_status',
            id: id,
            status: status ? 1 : 0
        },
        dataType: 'json',
        success: function(response) {
            if (response.status != 'success') {
                alert(response.message);
                location.reload();
            }
        }
    });
}
</script>
