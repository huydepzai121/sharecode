<link type="text/css" href="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/i18n/{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/language/jquery.ui.datepicker-{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/clipboard/clipboard.min.js"></script>

{if $SUCCESS_MESSAGE}
<div class="alert alert-success alert-dismissible fade show">
    <i class="fa-solid fa-check-circle"></i> {$SUCCESS_MESSAGE}
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</div>
{/if}

{if $IS_FORM}
<div class="card">
    <div class="card-header text-bg-primary rounded-top-2">
        <div class="fw-medium">
            <i class="fa-solid fa-{if $IS_EDIT}edit{else}plus{/if}"></i> 
            {if $IS_EDIT}Sửa mã nguồn{else}Thêm mã nguồn mới{/if}
        </div>
    </div>
    <div class="card-body">
        {if isset($ERRORS) and !empty($ERRORS)}
        <div class="alert alert-danger">
            <ul class="mb-0">
                {foreach from=$ERRORS item=error}
                <li>{$error}</li>
                {/foreach}
            </ul>
        </div>
        {/if}
        
        <form action="{$FORM_ACTION}" method="post" enctype="multipart/form-data" id="source-form">
            <div class="row">
                <div class="col-md-8">
                    <div class="mb-3">
                        <label for="title" class="form-label">Tên mã nguồn <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="title" id="title" value="{$DATA.title}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="alias" class="form-label">Liên kết tĩnh</label>
                        <input type="text" class="form-control" name="alias" id="alias" value="{$DATA.alias}">
                        <small class="form-text text-muted">Để trống sẽ tự động tạo</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description" id="description" rows="5">{$DATA.description}</textarea>
                    </div>
                    
                    <div class="mb-3">
                        <label for="keywords" class="form-label">Từ khóa</label>
                        <input type="text" class="form-control" name="keywords" id="keywords" value="{$DATA.keywords}">
                        <small class="form-text text-muted">Các từ khóa cách nhau bằng dấu phẩy</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="download_link_type" class="form-label">Loại link download</label>
                        <select class="form-select" name="download_link_type" id="download_link_type">
                            <option value="internal"{if $DATA.download_link_type eq 'internal'} selected{/if}>File nội bộ</option>
                            <option value="external"{if $DATA.download_link_type eq 'external'} selected{/if}>Link bên ngoài</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="download_link" class="form-label">Link download</label>
                        <input type="text" class="form-control" name="download_link" id="download_link" value="{$DATA.download_link}">
                        <small class="form-text text-muted">Đường dẫn file hoặc URL</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="demo_link" class="form-label">Link demo</label>
                        <input type="url" class="form-control" name="demo_link" id="demo_link" value="{$DATA.demo_link}">
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="mb-3">
                        <label for="catid" class="form-label">Danh mục <span class="text-danger">*</span></label>
                        <select class="form-select" name="catid" id="catid" required>
                            {$CATEGORY_OPTIONS}
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="image" class="form-label">Hình ảnh</label>
                        <input type="file" class="form-control" name="image" id="image" accept="image/*">
                        {if isset($DATA.image_url) and !empty($DATA.image_url)}
                        <div class="mt-2">
                            <img src="{$DATA.image_url}" alt="Current image" class="img-thumbnail" style="max-width: 150px;">
                        </div>
                        {/if}
                    </div>
                    
                    <div class="mb-3">
                        <label for="source_file" class="form-label">File mã nguồn <span class="text-danger">*</span></label>
                        <input type="file" class="form-control" name="source_file" id="source_file" accept=".zip,.rar,.7z,.tar,.gz,.tar.gz">
                        <small class="form-text text-muted">Chỉ chấp nhận file nén: zip, rar, 7z, tar, gz</small>
                        {if isset($DATA.file_name) and !empty($DATA.file_name)}
                        <div class="mt-2 alert alert-info">
                            <i class="fa fa-file-archive"></i> File hiện tại: <strong>{$DATA.file_name}</strong>
                            {if isset($DATA.file_size_text)}<small class="d-block">Kích thước: {$DATA.file_size_text}</small>{/if}
                        </div>
                        {/if}
                    </div>
                    
                    <div class="mb-3">
                        <label for="fee_type" class="form-label">Loại phí</label>
                        <select class="form-select" name="fee_type" id="fee_type" onchange="toggleFeeFields()">
                            <option value="free"{if $DATA.fee_type eq 'free'} selected{/if}>Miễn phí</option>
                            <option value="paid"{if $DATA.fee_type eq 'paid'} selected{/if}>Có phí</option>
                            <option value="contact"{if $DATA.fee_type eq 'contact'} selected{/if}>Liên hệ để biết giá</option>
                        </select>
                    </div>
                    
                    <div class="mb-3" id="fee_amount_group" style="display: {if $DATA.fee_type eq 'paid'}block{else}none{/if};">
                        <label for="fee_amount" class="form-label">Số tiền (VNĐ)</label>
                        <input type="number" class="form-control" name="fee_amount" id="fee_amount" value="{$DATA.fee_amount}" min="0">
                    </div>

                    <div class="mb-3" id="contact_fields_group" style="display: {if $DATA.fee_type eq 'contact'}block{else}none{/if};">
                        <label class="form-label">Thông tin liên hệ</label>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <label for="contact_phone" class="form-label text-sm">Số điện thoại</label>
                                    <input type="text" class="form-control" name="contact_phone" id="contact_phone" value="{$DATA.contact_phone}" placeholder="0123456789">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <label for="contact_email" class="form-label text-sm">Email</label>
                                    <input type="email" class="form-control" name="contact_email" id="contact_email" value="{$DATA.contact_email}" placeholder="email@example.com">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <label for="contact_skype" class="form-label text-sm">Skype</label>
                                    <input type="text" class="form-control" name="contact_skype" id="contact_skype" value="{$DATA.contact_skype}" placeholder="username">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <label for="contact_telegram" class="form-label text-sm">Telegram</label>
                                    <input type="text" class="form-control" name="contact_telegram" id="contact_telegram" value="{$DATA.contact_telegram}" placeholder="@username">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <label for="contact_zalo" class="form-label text-sm">Zalo</label>
                                    <input type="text" class="form-control" name="contact_zalo" id="contact_zalo" value="{$DATA.contact_zalo}" placeholder="0123456789">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <label for="contact_facebook" class="form-label text-sm">Facebook</label>
                                    <input type="url" class="form-control" name="contact_facebook" id="contact_facebook" value="{$DATA.contact_facebook}" placeholder="https://facebook.com/username">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <label for="contact_website" class="form-label text-sm">Website</label>
                                    <input type="url" class="form-control" name="contact_website" id="contact_website" value="{$DATA.contact_website}" placeholder="https://example.com">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <label for="contact_address" class="form-label text-sm">Địa chỉ</label>
                                    <textarea class="form-control" name="contact_address" id="contact_address" rows="2" placeholder="Địa chỉ liên hệ">{$DATA.contact_address}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    {if isset($TAGS) and !empty($TAGS)}
                    <div class="mb-3">
                        <label class="form-label">Tags liên quan</label>
                        <div class="row">
                            {foreach from=$TAGS item=tag}
                            <div class="col-md-4 col-sm-6">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" name="tag_ids[]" id="tag_{$tag.id}" value="{$tag.id}"{if $tag.checked} checked{/if}>
                                    <label class="form-check-label" for="tag_{$tag.id}">
                                        {$tag.name}
                                    </label>
                                </div>
                            </div>
                            {/foreach}
                        </div>
                        <small class="form-text text-muted">Chọn các tags phù hợp với mã nguồn</small>
                    </div>
                    {/if}

                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="status" id="status" value="1"{if $DATA.status eq 1} checked{/if}>
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
                <a href="{$BASE_URL}" class="btn btn-secondary">
                    <i class="fa fa-ban"></i> Hủy
                </a>
            </div>
        </form>
    </div>
</div>
{else}
<div class="card">
    <div class="card-body">
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" id="form-search-sources">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="sources">
            
            <div class="row g-3 flex-xl-nowrap">
                <div class="col-md-6 flex-lg-fill">
                    <label for="element_q" class="form-label">Từ khóa tìm kiếm</label>
                    <input type="text" class="form-control" name="q" id="element_q" value="{$SEARCH.q}" maxlength="64" placeholder="Nhập từ khóa...">
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-3">
                    <label for="element_catid" class="form-label">Danh mục</label>
                    <select class="form-select select2" name="catid" id="element_catid">
                        {foreach from=$LIST_CAT item=cat}
                        <option value="{$cat.value}"{if $cat.value eq $SEARCH.catid} selected{/if}>{$cat.title}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-2">
                    <label for="element_status" class="form-label">Trạng thái</label>
                    <select class="form-select" name="status" id="element_status">
                        {foreach from=$STATUS_SEARCH key=key item=status}
                        <option value="{$key}"{if $key eq $SEARCH.status} selected{/if}>{$status}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-2">
                    <label for="element_fee_type" class="form-label">Loại phí</label>
                    <select class="form-select" name="fee_type" id="element_fee_type">
                        {foreach from=$FEE_TYPE_SEARCH key=key item=fee_type}
                        <option value="{$key}"{if $key eq $SEARCH.fee_type} selected{/if}>{$fee_type}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="flex-grow-0 flex-shrink-1 w-auto">
                    <label for="submit_search" class="form-label d-none d-sm-block">&nbsp;</label>
                    <button id="submit_search" type="submit" class="btn btn-primary text-nowrap"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                </div>
            </div>
        </form>
    </div>
    
    <div class="card-body">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="mb-0">
                <i class="fa fa-list"></i> Danh sách mã nguồn
            </h5>
            <a href="{$BASE_URL}&action=add" class="btn btn-success">
                <i class="fa fa-plus"></i> Thêm mã nguồn mới
            </a>
        </div>
        
        <div class="table-responsive-lg table-card" id="list-sources-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted">
                    <tr>
                        <th class="text-nowrap" style="width: 1%;">
                            <input type="checkbox" data-toggle="checkAll" name="checkAll[]" class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                        </th>
                        <th class="text-nowrap" style="width: 30%;">Tên mã nguồn</th>
                        <th class="text-nowrap" style="width: 15%;">Danh mục</th>
                        <th class="text-nowrap" style="width: 10%;">Loại phí</th>
                        <th class="text-nowrap" style="width: 10%;">Lượt xem</th>
                        <th class="text-nowrap" style="width: 10%;">Lượt tải</th>
                        <th class="text-nowrap" style="width: 10%;">Trạng thái</th>
                        <th class="text-nowrap" style="width: 12%;">Ngày tạo</th>
                        <th class="text-nowrap" style="width: 1%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {if isset($SOURCES) and !empty($SOURCES)}
                    {foreach from=$SOURCES item=source}
                    <tr>
                        <td>
                            <input type="checkbox" data-toggle="checkSingle" name="checkSingle[]" value="{$source.id}" class="form-check-input m-0 align-middle" aria-label="Chọn mục này">
                        </td>
                        <td>
                            <div class="text-truncate-2">
                                <strong>{$source.title}</strong>
                                <br><small class="text-muted">{$source.alias}</small>
                            </div>
                        </td>
                        <td>{$source.category_title}</td>
                        <td>
                            <span class="badge bg-{$source.fee_class}">{$source.fee_text}</span>
                        </td>
                        <td class="text-center">
                            <span class="badge bg-info">{$source.num_view}</span>
                        </td>
                        <td class="text-center">
                            <span class="badge bg-primary">{$source.num_download}</span>
                        </td>
                        <td>
                            <span class="badge bg-{$source.status_class}">{$source.status_text}</span>
                        </td>
                        <td>{$source.add_time_format}</td>
                        <td>
                            <div class="input-group flex-nowrap">
                                <a href="{$source.edit_url}" class="btn btn-sm btn-secondary text-nowrap">
                                    <i class="fa-solid fa-pen"></i> Sửa
                                </a>
                                <button type="button" class="btn btn-sm btn-secondary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="visually-hidden">Thao tác</span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#" data-toggle="deleteSource" data-id="{$source.id}" data-checksess="{$source.checksess}">
                                        <i class="fa-solid fa-trash fa-fw text-center text-danger"></i> Xóa
                                    </a></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                    {else}
                    <tr>
                        <td colspan="9" class="text-center py-4">
                            <div class="alert alert-info mb-0">
                                Chưa có mã nguồn nào. Vui lòng thêm mã nguồn mới.
                            </div>
                        </td>
                    </tr>
                    {/if}
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="card-footer border-top">
        <div class="d-flex flex-wrap justify-content-between align-items-center">
            <div class="d-flex flex-wrap flex-sm-nowrap align-items-center">
                <div class="me-2">
                    <input type="checkbox" data-toggle="checkAll" name="checkAll[]" class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                </div>
                <div class="input-group me-1 my-1">
                    <select id="element_action" class="form-select fw-150" aria-label="Chọn thao tác" aria-describedby="element_action_btn">
                        {if isset($ACTIONS)}
                        {foreach from=$ACTIONS item=action}
                        <option value="{$action.value}">{$action.title}</option>
                        {/foreach}
                        {/if}
                    </select>
                    <button class="btn btn-primary" type="button" id="element_action_btn" data-toggle="actionSource" data-ctn="#list-sources-items">Thực hiện</button>
                </div>
            </div>
            <div class="pagination-wrap">
                {if isset($PAGINATION)}{$PAGINATION}{/if}
            </div>
        </div>
    </div>
</div>
{/if}

<script type="text/javascript">
function toggleFeeFields() {
    const feeType = document.getElementById('fee_type').value;
    const feeAmountGroup = document.getElementById('fee_amount_group');
    const contactFieldsGroup = document.getElementById('contact_fields_group');
    
    if (feeType === 'paid') {
        feeAmountGroup.style.display = 'block';
        contactFieldsGroup.style.display = 'none';
    } else if (feeType === 'contact') {
        feeAmountGroup.style.display = 'none';
        contactFieldsGroup.style.display = 'block';
    } else {
        feeAmountGroup.style.display = 'none';
        contactFieldsGroup.style.display = 'none';
    }
}

// Modern NukeViet UI handlers
$(document).ready(function() {
    // Initialize select2
    $('.select2').select2({
        language: '{$smarty.const.NV_LANG_INTERFACE}',
        width: '100%'
    });
    
    // Initialize fee field visibility
    if (typeof toggleFeeFields === 'function') {
        toggleFeeFields();
    }
    
    // Check all functionality
    $('[data-toggle="checkAll"]').on('change', function() {
        const isChecked = $(this).prop('checked');
        $('[data-toggle="checkSingle"]').prop('checked', isChecked);
    });
    
    // Delete source handler
    $('[data-toggle="deleteSource"]').on('click', function(e) {
        e.preventDefault();
        const id = $(this).data('id');
        const checksess = $(this).data('checksess');
        
        nukeviet.confirm('Bạn có chắc chắn muốn xóa mã nguồn này?', function() {
            $.ajax({
                url: '{$BASE_URL}',
                type: 'POST',
                data: {
                    action: 'delete',
                    id: id,
                    checksess: checksess
                },
                success: function(response) {
                    if (response.status === 'OK') {
                        nukeviet.toast(response.mess, 'success');
                        location.reload();
                    } else {
                        nukeviet.toast(response.mess, 'error');
                    }
                },
                error: function() {
                    nukeviet.toast('Có lỗi xảy ra', 'error');
                }
            });
        });
    });
    
    // Bulk action handler  
    $('[data-toggle="actionSource"]').on('click', function() {
        const action = $('#element_action').val();
        const checkedItems = $('[data-toggle="checkSingle"]:checked');
        
        if (checkedItems.length === 0) {
            nukeviet.alert('Vui lòng chọn ít nhất một mục');
            return;
        }
        
        const ids = [];
        checkedItems.each(function() {
            ids.push($(this).val());
        });
        
        const actionText = $('#element_action option:selected').text();
        nukeviet.confirm('Bạn có chắc chắn muốn ' + actionText.toLowerCase() + ' ' + ids.length + ' mã nguồn đã chọn?', function() {
            $.ajax({
                url: '{$BASE_URL}',
                type: 'POST',
                data: {
                    bulk_action: 1,
                    action_type: action,
                    ids: ids
                },
                success: function(response) {
                    if (response.status === 'OK') {
                        nukeviet.toast(response.mess, 'success');
                        location.reload();
                    } else {
                        nukeviet.toast(response.mess, 'error');
                    }
                },
                error: function() {
                    nukeviet.toast('Có lỗi xảy ra', 'error');
                }
            });
        });
    });
});
</script>