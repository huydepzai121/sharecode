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
<form id="source-form" method="post" action="{$FORM_ACTION}" enctype="multipart/form-data" novalidate>
    <div class="row g-3">
        <div class="col-lg-8 col-xxl-9">
            <div class="alert alert-danger d-none" id="show_error"></div>
            
            {if isset($ERRORS) and !empty($ERRORS)}
            <div class="alert alert-danger">
                <ul class="mb-0">
                    {foreach from=$ERRORS item=error}
                    <li>{$error}</li>
                    {/foreach}
                </ul>
            </div>
            {/if}
            
            <div class="card mb-3">
                <div class="card-body">
                    <div class="mb-3">
                        <label for="title" class="form-label">Tên mã nguồn <span class="text-danger">(*)</span>:</label>
                        <div class="position-relative">
                            <input type="text" class="form-control required" id="title" name="title" value="{$DATA.title}" maxlength="250" required>
                            <div class="invalid-tooltip">Vui lòng nhập tên mã nguồn</div>
                        </div>
                        <div class="form-text">Độ dài ký tự: <span id="titlelength" class="fw-bold text-danger">0</span>. Tên mã nguồn nên ngắn gọn và mô tả chính xác.</div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="alias" class="form-label">Liên kết tĩnh:</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="alias" name="alias" value="{$DATA.alias}" maxlength="250">
                            <button class="btn btn-secondary" type="button" aria-label="Tạo liên kết tĩnh" data-toggle="getaliaspost" data-auto-alias="{empty($DATA.alias) ? '1' : '0'}" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-title="Tạo liên kết tĩnh từ tiêu đề"><i class="fa-solid fa-rotate"></i></button>
                        </div>
                    </div>
                    
                    <div class="row g-3">
                        <div class="col-md-7">
                            <div class="mb-3">
                                <label for="avatar" class="form-label">Hình đại diện:</label>
                                <div class="input-group">
                                    <input class="form-control" type="text" name="avatar" id="avatar" value="{$DATA.avatar|default:''}">
                                    <button type="button" class="btn btn-secondary" aria-label="Chọn hình ảnh" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-title="Chọn hình ảnh" onclick="nv_open_file_manager('avatar')"><i class="fa-solid fa-file-image"></i></button>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <div class="mb-3">
                                <label for="background_image" class="form-label">Hình nền:</label>
                                <div class="input-group">
                                    <input class="form-control" type="text" name="background_image" id="background_image" value="{$DATA.background_image|default:''}">
                                    <button type="button" class="btn btn-secondary" aria-label="Chọn hình nền" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-title="Chọn hình nền" onclick="nv_open_file_manager('background_image')"><i class="fa-solid fa-image"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="short_description" class="form-label">Mô tả ngắn <span class="text-danger">(*)</span>:</label>
                        <div class="position-relative">
                            <textarea class="form-control required" name="description" id="short_description" rows="3" required>{$DATA.description|default:''}</textarea>
                            <div class="invalid-tooltip">Vui lòng nhập mô tả ngắn</div>
                        </div>
                        <div class="form-text">Mô tả ngắn gọn về mã nguồn (tối thiểu 10 ký tự)</div>
                    </div>
                    
                    <div class="mb-0">
                        <label for="detailed_description" class="form-label">Mô tả chi tiết:</label>
                        <div class="position-relative">
                            <textarea class="form-control ckeditor" name="content" id="detailed_description" rows="8">{$DATA.content|default:''}</textarea>
                        </div>
                        <div class="form-text">Mô tả chi tiết về tính năng, cách sử dụng, yêu cầu hệ thống</div>
                    </div>
                </div>
            </div>
            
            <div class="row g-3 mb-3">
                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header fw-medium fs-5">
                            Liên kết & Demo
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label for="external_source_link" class="form-label">Link mã nguồn bên ngoài:</label>
                                <input type="url" class="form-control" name="external_source_link" id="external_source_link" value="{$DATA.external_source_link|default:''}" placeholder="https://github.com/user/repo">
                                <div class="form-text">Link đến repository GitHub, GitLab hoặc trang web mã nguồn</div>
                            </div>
                            
                            <div class="mb-0">
                                <label for="demo_link" class="form-label">Link demo:</label>
                                <input type="url" class="form-control" name="demo_link" id="demo_link" value="{$DATA.demo_link}" placeholder="https://demo.example.com">
                                <div class="form-text">Link xem demo trực tiếp của mã nguồn</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="card h-100">
                        <div class="card-header fw-medium fs-5">
                            Tập tin & Download
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label for="download_link_type" class="form-label">Loại link download:</label>
                                <select class="form-select" name="download_link_type" id="download_link_type">
                                    <option value="external" selected>Link download bên ngoài</option>
                                </select>
                            </div>
                            
                            <div class="mb-0">
                                <label for="download_link" class="form-label">Link download <span class="text-danger">(*)</span>:</label>
                                <input type="url" class="form-control" name="download_link" id="download_link" value="{$DATA.download_link}" placeholder="https://example.com/file.zip" required>
                                <div class="form-text">URL trực tiếp đến file tải về (Google Drive, Dropbox, GitHub, v.v.)</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4 col-xxl-3">
            <div class="card mb-3">
                <div class="card-header fw-medium fs-5">
                    Danh mục <span class="text-danger">(*)</span>
                </div>
                <div class="card-body">
                    <div class="position-relative">
                        <select class="form-select required" name="catid" id="catid" required>
                            {$CATEGORY_OPTIONS}
                        </select>
                        <div class="invalid-tooltip">Vui lòng chọn danh mục</div>
                    </div>
                </div>
            </div>
            
            <div class="card mb-3">
                <div class="card-header py-2">
                    <div class="d-flex gap-2 justify-content-between align-items-center">
                        <div class="fw-medium fs-5 text-truncate">Từ khóa tìm kiếm</div>
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-title="Tạo tự động từ khóa từ nội dung" aria-label="Tạo tự động từ khóa từ nội dung" data-toggle="keywords_auto_create">
                            <i class="fa-solid fa-key" data-icon="fa-key"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <select id="sourcecontent_keywords" class="form-control" aria-label="Từ khóa tìm kiếm" name="keywords[]" multiple data-placeholder="Chọn từ khóa...">
                        {if isset($KEYWORDS)}
                            {foreach from=$KEYWORDS item=keyword}
                            <option value="{$keyword.title}" {if isset($DATA.keywords_array) && in_array($keyword.title, $DATA.keywords_array)}selected{/if}>{$keyword.title}</option>
                            {/foreach}
                        {/if}
                    </select>
                </div>
            </div>
            
            <div class="card mb-3">
                <div class="card-header py-2">
                    <div class="d-flex gap-2 justify-content-between align-items-center">
                        <div class="fw-medium fs-5 text-truncate">Tags cho mã nguồn</div>
                        <button type="button" class="btn btn-secondary btn-sm" data-bs-toggle="tooltip" data-bs-trigger="hover" data-bs-title="Tạo tự động tags dựa vào nội dung mã nguồn" aria-label="Tạo tự động tags dựa vào nội dung mã nguồn" data-toggle="tags_auto_create">
                            <i class="fa-solid fa-tags" data-icon="fa-tags"></i>
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <select id="sourcecontent_tags" class="form-control" aria-label="Tags cho mã nguồn" name="tags[]" multiple data-placeholder="Nhập tag...">
                        {if isset($AVAILABLE_TAGS)}
                            {foreach from=$AVAILABLE_TAGS item=tag}
                            <option value="{$tag.name}"{if $tag.selected} selected{/if}>{$tag.name}</option>
                            {/foreach}
                        {/if}
                    </select>
                </div>
            </div>
            
            <div class="card mb-3">
                <div class="card-header fw-medium fs-5">
                    Thông tin giá cả
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label for="fee_type" class="form-label">Loại phí:</label>
                        <select class="form-select" name="fee_type" id="fee_type" onchange="toggleFeeFields()">
                            <option value="free"{if $DATA.fee_type eq 'free'} selected{/if}>Miễn phí</option>
                            <option value="paid"{if $DATA.fee_type eq 'paid'} selected{/if}>Có phí</option>
                            <option value="contact"{if $DATA.fee_type eq 'contact'} selected{/if}>Liên hệ để biết giá</option>
                        </select>
                    </div>
                    
                    <div class="mb-0" id="fee_amount_group" style="display: {if $DATA.fee_type eq 'paid'}block{else}none{/if};">
                        <label for="fee_amount" class="form-label">Số tiền (VNĐ):</label>
                        <input type="number" class="form-control" name="fee_amount" id="fee_amount" value="{$DATA.fee_amount}" min="0">
                    </div>
                </div>
            </div>
            
            <div class="card mb-3" id="contact_fields_card" style="display: {if $DATA.fee_type eq 'contact'}block{else}none{/if};">
                <div class="card-header fw-medium fs-5">
                    Thông tin liên hệ
                </div>
                <div class="card-body">
                    <div class="row g-2">
                        <div class="col-6">
                            <label for="contact_phone" class="form-label">Số điện thoại:</label>
                            <input type="text" class="form-control" name="contact_phone" id="contact_phone" value="{$DATA.contact_phone}" placeholder="0123456789">
                        </div>
                        <div class="col-6">
                            <label for="contact_email" class="form-label">Email:</label>
                            <input type="email" class="form-control" name="contact_email" id="contact_email" value="{$DATA.contact_email}" placeholder="email@example.com">
                        </div>
                        <div class="col-6">
                            <label for="contact_skype" class="form-label">Skype:</label>
                            <input type="text" class="form-control" name="contact_skype" id="contact_skype" value="{$DATA.contact_skype}" placeholder="username">
                        </div>
                        <div class="col-6">
                            <label for="contact_telegram" class="form-label">Telegram:</label>
                            <input type="text" class="form-control" name="contact_telegram" id="contact_telegram" value="{$DATA.contact_telegram}" placeholder="@username">
                        </div>
                        <div class="col-6">
                            <label for="contact_zalo" class="form-label">Zalo:</label>
                            <input type="text" class="form-control" name="contact_zalo" id="contact_zalo" value="{$DATA.contact_zalo}" placeholder="0123456789">
                        </div>
                        <div class="col-6">
                            <label for="contact_facebook" class="form-label">Facebook:</label>
                            <input type="url" class="form-control" name="contact_facebook" id="contact_facebook" value="{$DATA.contact_facebook}" placeholder="https://facebook.com/username">
                        </div>
                        <div class="col-12">
                            <label for="contact_website" class="form-label">Website:</label>
                            <input type="url" class="form-control" name="contact_website" id="contact_website" value="{$DATA.contact_website}" placeholder="https://example.com">
                        </div>
                        <div class="col-12">
                            <label for="contact_address" class="form-label">Địa chỉ:</label>
                            <textarea class="form-control" name="contact_address" id="contact_address" rows="2" placeholder="Địa chỉ liên hệ">{$DATA.contact_address}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="card mb-3">
                <div class="card-header fw-medium fs-5">
                    Cài đặt khác
                </div>
                <div class="card-body">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" role="switch" name="status" value="1" id="status"{if $DATA.status eq 1} checked{/if}>
                        <label class="form-check-label" for="status">
                            Kích hoạt mã nguồn
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="text-center mt-4">
        <button type="submit" class="btn btn-primary" name="save">
            <i class="fa-solid fa-save"></i> {if $IS_EDIT}Cập nhật mã nguồn{else}Thêm mã nguồn{/if}
        </button>
        <a href="{$BASE_URL}" class="btn btn-secondary">
            <i class="fa-solid fa-ban"></i> Hủy bỏ
        </a>
    </div>
</form>
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
                <i class="fa-solid fa-list"></i> Danh sách mã nguồn
            </h5>
            <a href="{$BASE_URL}&action=add" class="btn btn-success">
                <i class="fa-solid fa-plus"></i> Thêm mã nguồn mới
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
                                <strong><a href="{$source.link_detail}" target="_blank" title="Xem chi tiết ngoài site">{$source.title}</a></strong>
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
// Function to toggle fee fields based on fee type
function toggleFeeFields() {
    const feeTypeElement = document.getElementById('fee_type');
    const feeAmountGroup = document.getElementById('fee_amount_group');
    const contactFieldsCard = document.getElementById('contact_fields_card');

    if (!feeTypeElement || !feeAmountGroup || !contactFieldsCard) {
        return; // Elements not found, exit gracefully
    }

    const feeType = feeTypeElement.value;

    if (feeType === 'paid') {
        feeAmountGroup.style.display = 'block';
        contactFieldsCard.style.display = 'none';
    } else if (feeType === 'contact') {
        feeAmountGroup.style.display = 'none';
        contactFieldsCard.style.display = 'block';
    } else {
        feeAmountGroup.style.display = 'none';
        contactFieldsCard.style.display = 'none';
    }
}

// Download link is always required now (no file upload)
// Function removed - only external links supported

// Modern NukeViet UI handlers
$(document).ready(function() {
    // Initialize select2
    $('.select2').select2({
        language: '{$smarty.const.NV_LANG_INTERFACE}',
        width: '100%'
    });
    
    // Initialize Select2 for keywords (using keywords table)
    $('#sourcecontent_keywords').select2({
        language: '{$smarty.const.NV_LANG_INTERFACE}',
        width: '100%',
        tags: true,
        tokenSeparators: [',', ' '],
        placeholder: 'Chọn từ khóa...',
        allowClear: true,
        maximumSelectionLength: 15,
        createTag: function (params) {
            var term = $.trim(params.term);
            if (term === '') {
                return null;
            }
            return {
                id: term,
                text: term,
                newTag: true
            };
        },
        templateResult: function (data) {
            var $result = $('<span></span>');
            $result.text(data.text);
            if (data.newTag) {
                $result.append(' <em>(tạo mới)</em>');
            }
            return $result;
        }
    });
    
    // Initialize Select2 for tags (similar to news module)
    $('#sourcecontent_tags').select2({
        language: '{$smarty.const.NV_LANG_INTERFACE}',
        width: '100%',
        tags: true,
        tokenSeparators: [',', ' '],
        placeholder: 'Nhập tag...',
        allowClear: true,
        maximumSelectionLength: 20,
        createTag: function (params) {
            var term = $.trim(params.term);
            if (term === '') {
                return null;
            }
            return {
                id: term,
                text: term,
                newTag: true
            };
        },
        templateResult: function (data) {
            var $result = $('<span></span>');
            $result.text(data.text);
            if (data.newTag) {
                $result.append(' <em>(tạo mới)</em>');
            }
            return $result;
        }
    });
    
    // Initialize field visibility
    if (typeof toggleFeeFields === 'function') {
        toggleFeeFields();
    }
    // Download fields no longer need toggling - always external
    
    // Title length counter
    $('#title').on('input keyup', function() {
        var length = $(this).val().length;
        $('#titlelength').text(length);
        
        // Auto-fill alias from title
        var aliasField = $('#alias');
        var isEditMode = {if $IS_EDIT}true{else}false{/if};
        
        if (!isEditMode || aliasField.val() === '') {
            var title = $(this).val();
            var alias = nv_create_alias(title);
            aliasField.val(alias);
        }
    });
    
    // Alias button functionality
    $('[data-toggle="getaliaspost"]').on('click', function() {
        var title = $('#title').val().trim();
        if (title) {
            var alias = nv_create_alias(title);
            $('#alias').val(alias);
        }
    });
    
    // Auto-create keywords button functionality
    $('[data-toggle="keywords_auto_create"]').on('click', function() {
        var title = $('#title').val().trim();
        var shortDesc = $('#short_description').val().trim();
        var detailedDesc = '';
        
        // Get content from CKEditor if available
        if (typeof CKEDITOR !== 'undefined' && CKEDITOR.instances.detailed_description) {
            detailedDesc = CKEDITOR.instances.detailed_description.getData();
            detailedDesc = $('<div>').html(detailedDesc).text(); // Strip HTML
        } else {
            detailedDesc = $('#detailed_description').val().trim();
        }
        
        var content = title + ' ' + shortDesc + ' ' + detailedDesc;
        var autoKeywords = extractKeywordsFromContent(content);
        
        if (autoKeywords.length > 0) {
            // Add auto-generated keywords to select2
            var currentKeywords = $('#sourcecontent_keywords').val() || [];
            var newKeywords = [...new Set([...currentKeywords, ...autoKeywords])]; // Remove duplicates
            
            // Add new options if they don't exist
            autoKeywords.forEach(function(keyword) {
                if ($('#sourcecontent_keywords option[value="' + keyword + '"]').length === 0) {
                    var newOption = new Option(keyword, keyword, false, false);
                    $('#sourcecontent_keywords').append(newOption);
                }
            });
            
            $('#sourcecontent_keywords').val(newKeywords).trigger('change');
            nukeviet.toast('Đã tạo ' + autoKeywords.length + ' từ khóa tự động: ' + autoKeywords.join(', '), 'success');
        } else {
            nukeviet.toast('Không thể tạo từ khóa tự động. Vui lòng nhập thêm nội dung.', 'warning');
        }
    });
    
    // Auto-create tags button functionality
    $('[data-toggle="tags_auto_create"]').on('click', function() {
        var title = $('#title').val().trim();
        var shortDesc = $('#short_description').val().trim();
        var detailedDesc = '';
        
        // Get content from CKEditor if available
        if (typeof CKEDITOR !== 'undefined' && CKEDITOR.instances.detailed_description) {
            detailedDesc = CKEDITOR.instances.detailed_description.getData();
            detailedDesc = $('<div>').html(detailedDesc).text(); // Strip HTML
        } else {
            detailedDesc = $('#detailed_description').val().trim();
        }
        
        var content = title + ' ' + shortDesc + ' ' + detailedDesc;
        var autoTags = extractTagsFromContent(content);
        
        if (autoTags.length > 0) {
            // Add auto-generated tags to select2
            var currentTags = $('#sourcecontent_tags').val() || [];
            var newTags = [...new Set([...currentTags, ...autoTags])]; // Remove duplicates
            
            // Add new options if they don't exist
            autoTags.forEach(function(tag) {
                if ($('#sourcecontent_tags option[value="' + tag + '"]').length === 0) {
                    var newOption = new Option(tag, tag, false, false);
                    $('#sourcecontent_tags').append(newOption);
                }
            });
            
            $('#sourcecontent_tags').val(newTags).trigger('change');
            nukeviet.toast('Đã tạo ' + autoTags.length + ' tags tự động: ' + autoTags.join(', '), 'success');
        } else {
            nukeviet.toast('Không thể tạo tags tự động. Vui lòng nhập thêm nội dung.', 'warning');
        }
    });
    
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
    
    // Initialize CKEditor for detailed description
    if (typeof CKEDITOR !== 'undefined') {
        CKEDITOR.replace('detailed_description', {
            height: 300,
            filebrowserBrowseUrl: script_name + '?' + nv_name_variable + '=upload&' + nv_fc_variable + '=ckeditor',
            filebrowserImageBrowseUrl: script_name + '?' + nv_name_variable + '=upload&' + nv_fc_variable + '=ckeditor&type=image',
            filebrowserFlashBrowseUrl: script_name + '?' + nv_name_variable + '=upload&' + nv_fc_variable + '=ckeditor&type=flash'
        });
    }
    
    // Initialize page on load
    $('#title').trigger('input');
});

{literal}
function extractKeywordsFromContent(content) {
    if (!content || content.length < 10) return [];
    
    var techKeywords = [
        'php', 'mysql', 'javascript', 'html', 'css', 'bootstrap', 'jquery', 'ajax', 'json', 'xml',
        'cms', 'nukeviet', 'wordpress', 'laravel', 'codeigniter', 'framework', 'api', 'rest',
        'mobile', 'responsive', 'admin', 'dashboard', 'ecommerce', 'shop', 'cart', 'payment',
        'user', 'login', 'register', 'authentication', 'authorization', 'security', 'seo',
        'blog', 'news', 'article', 'content', 'management', 'template', 'theme', 'plugin',
        'module', 'extension', 'widget', 'slider', 'gallery', 'portfolio', 'contact', 'form',
        'website', 'web', 'online', 'digital', 'system', 'software', 'application', 'tool'
    ];
    
    var keywords = [];
    content = content.toLowerCase();
    
    // Extract tech keywords
    techKeywords.forEach(function(keyword) {
        if (content.includes(keyword) && keywords.indexOf(keyword) === -1) {
            keywords.push(keyword);
        }
    });
    
    return keywords.slice(0, 10); 
}

// Function to extract tags from content
function extractTagsFromContent(content) {
    if (!content || content.length < 10) return [];
    
    // Common programming and technology keywords
    var techKeywords = [
        'php', 'mysql', 'javascript', 'html', 'css', 'bootstrap', 'jquery', 'ajax', 'json', 'xml',
        'cms', 'nukeviet', 'wordpress', 'laravel', 'codeigniter', 'framework', 'api', 'rest',
        'mobile', 'responsive', 'admin', 'dashboard', 'ecommerce', 'shop', 'cart', 'payment',
        'user', 'login', 'register', 'authentication', 'authorization', 'security', 'seo',
        'blog', 'news', 'article', 'content', 'management', 'template', 'theme', 'plugin',
        'module', 'extension', 'widget', 'slider', 'gallery', 'portfolio', 'contact', 'form',
        'website', 'web', 'online', 'digital', 'system', 'software', 'application', 'tool'
    ];
    
    var tags = [];
    content = content.toLowerCase();
    
    // Extract tech keywords
    techKeywords.forEach(function(keyword) {
        if (content.includes(keyword) && tags.indexOf(keyword) === -1) {
            tags.push(keyword);
        }
    });
    
    // Extract words that might be tags (2-15 characters, alphanumeric)
    var words = content.match(/\b[a-zA-Z][a-zA-Z0-9]{1,14}\b/g) || [];
    var commonWords = ['the', 'and', 'for', 'are', 'but', 'not', 'you', 'all', 'can', 'had', 'her', 'was', 'one', 'our', 'out', 'day', 'get', 'has', 'him', 'how', 'man', 'new', 'now', 'old', 'see', 'two', 'way', 'who', 'boy', 'did', 'its', 'let', 'put', 'say', 'she', 'too', 'use', 'that', 'with', 'have', 'this', 'will', 'your', 'from', 'they', 'know', 'want', 'been', 'good', 'much', 'some', 'time', 'very', 'when', 'come', 'here', 'just', 'like', 'long', 'make', 'many', 'over', 'such', 'take', 'than', 'them', 'well', 'were'];
    
    words.forEach(function(word) {
        if (word.length >= 3 && word.length <= 15 && 
            commonWords.indexOf(word.toLowerCase()) === -1 && 
            tags.indexOf(word.toLowerCase()) === -1 &&
            tags.length < 8) {
            tags.push(word.toLowerCase());
        }
    });
    
    return tags.slice(0, 8); // Limit to 8 auto-generated tags
}

// Vietnamese alias creation function
function nv_create_alias(text) {
    if (!text) return '';
    
    // Vietnamese character map
    var map = {
        'à': 'a', 'á': 'a', 'ạ': 'a', 'ả': 'a', 'ã': 'a', 'â': 'a', 'ầ': 'a', 'ấ': 'a', 'ậ': 'a', 'ẩ': 'a', 'ẫ': 'a', 'ă': 'a', 'ằ': 'a', 'ắ': 'a', 'ặ': 'a', 'ẳ': 'a', 'ẵ': 'a',
        'è': 'e', 'é': 'e', 'ẹ': 'e', 'ẻ': 'e', 'ẽ': 'e', 'ê': 'e', 'ề': 'e', 'ế': 'e', 'ệ': 'e', 'ể': 'e', 'ễ': 'e',
        'ì': 'i', 'í': 'i', 'ị': 'i', 'ỉ': 'i', 'ĩ': 'i',
        'ò': 'o', 'ó': 'o', 'ọ': 'o', 'ỏ': 'o', 'õ': 'o', 'ô': 'o', 'ồ': 'o', 'ố': 'o', 'ộ': 'o', 'ổ': 'o', 'ỗ': 'o', 'ơ': 'o', 'ờ': 'o', 'ớ': 'o', 'ợ': 'o', 'ở': 'o', 'ỡ': 'o',
        'ù': 'u', 'ú': 'u', 'ụ': 'u', 'ủ': 'u', 'ũ': 'u', 'ư': 'u', 'ừ': 'u', 'ứ': 'u', 'ự': 'u', 'ử': 'u', 'ữ': 'u',
        'ỳ': 'y', 'ý': 'y', 'ỵ': 'y', 'ỷ': 'y', 'ỹ': 'y',
        'đ': 'd'
    };
    
    // Convert to lowercase and replace Vietnamese characters
    text = text.toLowerCase();
    for (var char in map) {
        text = text.replace(new RegExp(char, 'g'), map[char]);
    }
    
    // Remove special characters and replace spaces with hyphens
    text = text.replace(/[^a-z0-9\s-]/g, '');
    text = text.replace(/\s+/g, '-');
    text = text.replace(/-+/g, '-');
    text = text.replace(/^-|-$/g, '');
    
    return text;
}
{/literal}

// NukeViet file manager integration
function nv_open_file_manager(field_id) {
    var url = script_name + '?' + nv_name_variable + '=upload&popup=1&area=' + field_id + '&path=uploads/sharecode&currentpath=uploads/sharecode&type=image';
    window.open(url, 'fileManager', 'width=900,height=600,resizable=yes,scrollbars=yes');
}

// File manager callback function
function nv_select_file(file_path, field_id) {
    $('#' + field_id).val(file_path);
    // Update preview if exists
    var preview_img = $('#' + field_id).siblings('.mt-2').find('img');
    if (preview_img.length) {
        preview_img.attr('src', NV_BASE_SITEURL + file_path);
    }
}

// Enhanced form validation
$('#source-form').on('submit', function(e) {
    var errors = [];
    
    // Validate title
    var title = $('#title').val().trim();
    if (title.length < 3) {
        errors.push('Tên mã nguồn phải có ít nhất 3 ký tự');
    }
    
    // Validate short description
    var shortDesc = $('#short_description').val().trim();
    if (shortDesc.length < 10) {
        errors.push('Mô tả ngắn phải có ít nhất 10 ký tự');
    }
    
    // Validate category
    if ($('#catid').val() == '0') {
        errors.push('Vui lòng chọn danh mục');
    }
    
    // Validate download link for external type
    var downloadType = $('#download_link_type').val();
    if (downloadType === 'external') {
        var downloadLink = $('#download_link').val().trim();
        if (downloadLink === '') {
            errors.push('Vui lòng nhập link download bên ngoài');
        } else if (!isValidUrl(downloadLink)) {
            errors.push('Link download không hợp lệ');
        }
    }
    
    // Validate fee amount for paid type
    var feeType = $('#fee_type').val();
    if (feeType === 'paid') {
        var feeAmount = parseFloat($('#fee_amount').val());
        if (isNaN(feeAmount) || feeAmount <= 0) {
            errors.push('Vui lòng nhập số tiền hợp lệ');
        }
    }
    
    if (errors.length > 0) {
        e.preventDefault();
        var errorMsg = 'Vui lòng kiểm tra lại:\n\n' + errors.join('\n');
        nukeviet.alert(errorMsg);
        return false;
    }
});

// URL validation helper function
function isValidUrl(string) {
    try {
        new URL(string);
        return true;
    } catch (_) {
        return false;
    }
}
</script>