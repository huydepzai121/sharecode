<div class="card mb-3">
    <div class="card-body">
        <div class="row g-1">
            <div class="col-auto">
                <a class="btn btn-primary" href="{$FORM_ACTION}">Tất cả từ khóa</a>
            </div>
            <div class="col-auto">
                <a class="btn btn-secondary" href="#" data-toggle="add_keywords" data-fc="addKeyword" data-mtitle="Thêm từ khóa" data-kid="0">Thêm từ khóa</a>
            </div>
            <div class="col-auto">
                <a class="btn btn-secondary" href="#" data-bs-toggle="modal" data-bs-target="#mdKeywordMulti">Thêm nhiều từ khóa</a>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header text-bg-primary rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium"><i class="fa-solid fa-key"></i> Quản lý từ khóa</div>
        <a href="#" class="btn btn-sm btn-secondary" data-toggle="add_keywords" data-fc="addKeyword" data-mtitle="Thêm từ khóa" data-kid="0"><i class="fa-solid fa-plus"></i> Thêm từ khóa</a>
    </div>
    <div class="card-body">
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" id="form-search-keywords">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="keywords">

            <div class="row g-3 flex-xl-nowrap">
                <div class="col-md-6 flex-lg-fill">
                    <label for="element_search" class="form-label">Tìm kiếm từ khóa</label>
                    <input type="text" class="form-control" name="search" id="element_search" value="{$SEARCH}" maxlength="64" placeholder="Nhập từ khóa...">
                </div>
                <div class="flex-grow-0 flex-shrink-1 w-auto">
                    <label for="submit_search" class="form-label d-none d-sm-block">&nbsp;</label>
                    <button id="submit_search" type="submit" class="btn btn-primary text-nowrap"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                </div>
                <div class="col-auto">
                    <label class="form-label d-none d-sm-block">&nbsp;</label>
                    <div class="text-muted">
                        Tổng số từ khóa: <strong class="text-primary">{$TOTAL}</strong>
                    </div>
                </div>
            </div>
        </form>
    </div>


    {if not empty($DATA)}
    <div class="card-body">
        <div class="table-responsive-lg table-card pb-1" id="list-keywords-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted">
                    <tr>
                        <th class="text-nowrap" style="width: 1%;">
                            <input type="checkbox" data-toggle="checkAll" name="checkAll[]" class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                        </th>
                        <th class="text-nowrap text-center" style="width: 8%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'weight' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'asc'}&amp;of=weight{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'weight' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-center">
                                <span class="me-1">Thứ tự</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'weight' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Thứ tự</span>
                            {/if}
                        </th>
                        <th class="text-nowrap" style="width: 25%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'name' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'asc'}&amp;of=name{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'name' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Tên từ khóa</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'name' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Tên từ khóa</span>
                            {/if}
                        </th>
                        <th class="text-nowrap" style="width: 20%;">Liên kết tĩnh</th>
                        <th class="text-nowrap" style="width: 25%;">Mô tả</th>
                        <th class="text-nowrap text-center" style="width: 8%;">Trạng thái</th>
                        <th class="text-nowrap text-center" style="width: 12%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'add_time' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'desc'}&amp;of=add_time{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'add_time' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-center">
                                <span class="me-1">Ngày tạo</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'add_time' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Ngày tạo</span>
                            {/if}
                        </th>
                        <th class="text-nowrap text-center" style="width: 1%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$DATA item=keyword}
                    <tr>
                        <td>
                            <input type="checkbox" data-toggle="checkSingle" name="checkSingle[]" value="{$keyword.id}" class="form-check-input m-0 align-middle" aria-label="Chọn mục này">
                        </td>
                        <td class="text-center">
                            <span class="badge bg-primary change-weight-btn"
                                  style="cursor: pointer;"
                                  data-id="{$keyword.id}"
                                  data-current="{$keyword.weight}"
                                  data-max="{$TOTAL}">{$keyword.weight}</span>
                        </td>
                        <td>
                            <div class="fw-medium">{$keyword.name}</div>
                            <small class="text-muted">ID: {$keyword.id}</small>
                        </td>
                        <td>
                            <code class="text-muted">{$keyword.alias}</code>
                        </td>
                        <td>
                            <div class="text-truncate-2">{$keyword.description|default:'<span class="text-muted">Chưa có mô tả</span>'}</div>
                        </td>
                        <td class="text-center">
                            <div class="form-check form-switch">
                                <input type="checkbox" class="form-check-input status-switch"
                                       id="status_{$keyword.id}" data-id="{$keyword.id}"
                                       {if $keyword.status == 1}checked{/if}>
                            </div>
                        </td>
                        <td class="text-center text-nowrap">{$keyword.add_time_format}</td>
                        <td>
                            <div class="input-group flex-nowrap">
                                <button type="button" class="btn btn-sm btn-secondary text-nowrap" data-toggle="add_keywords" data-fc="editKeyword" data-mtitle="Sửa từ khóa" data-kid="{$keyword.id}">
                                    <i class="fa-solid fa-pen"></i> Sửa
                                </button>
                                <button type="button" class="btn btn-sm btn-secondary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="visually-hidden">Thao tác</span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><button type="button" class="dropdown-item delete-btn" data-id="{$keyword.id}" data-name="{$keyword.name}"><i class="fa-solid fa-trash fa-fw text-center text-danger" data-icon="fa-trash"></i> Xóa</button></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
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
                    <button class="btn btn-primary" type="button" id="element_action_btn" data-toggle="actionKeyword" data-ctn="#list-keywords-items">Thực hiện</button>
                </div>
            </div>
            <div class="pagination-wrap">
                {if isset($PAGINATION)}{$PAGINATION}{/if}
            </div>
        </div>
    </div>
    {else}
    <div class="card-body">
        <div class="alert alert-info mb-0 text-center">
            <i class="fa-solid fa-info-circle"></i> Chưa có từ khóa nào.
            <br><a href="#" class="btn btn-sm btn-primary mt-2" data-toggle="add_keywords" data-fc="addKeyword" data-mtitle="Thêm từ khóa" data-kid="0">
                <i class="fa-solid fa-plus"></i> Thêm từ khóa đầu tiên
            </a>
        </div>
    </div>
    {/if}
</div>

<!-- Modal thêm nhiều từ khóa -->
<div class="modal fade" id="mdKeywordMulti" tabindex="-1" aria-labelledby="mdKeywordMultiLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title fs-5 fw-medium" id="mdKeywordMultiLabel">Thêm nhiều từ khóa</div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <form action="{$FORM_ACTION}" method="post" class="keyword-ajax-submit">
                    <input name="savemultikeywords" type="hidden" value="1">
                    <input name="checkss" type="hidden" value="{$smarty.const.NV_CHECK_SESSION}">
                    <div class="mb-3">
                        <label for="element_mkeyword_mtitle" class="form-label">Nhập từ khóa (mỗi dòng một từ khóa):</label>
                        <textarea name="keywords_multi" id="element_mkeyword_mtitle" class="form-control" rows="10" placeholder="PHP&#10;JavaScript&#10;HTML&#10;CSS&#10;Bootstrap"></textarea>
                        <div class="form-text">Mỗi dòng một từ khóa. Hệ thống sẽ tự động tạo liên kết tĩnh.</div>
                    </div>
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">Thêm từ khóa</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal thêm/sửa từ khóa đơn -->
<div class="modal fade" id="mdKeywordSingle" tabindex="-1" aria-labelledby="mdKeywordSingleLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title fs-5 fw-medium" id="mdKeywordSingleLabel"></div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <form action="{$FORM_ACTION}" method="post" class="keyword-ajax-submit">
                    <input name="savekeyword" type="hidden" value="1">
                    <input name="checkss" type="hidden" value="{$smarty.const.NV_CHECK_SESSION}">
                    <input name="id" type="hidden" value="0">
                    <div class="mb-3">
                        <label for="element_keyword_name" class="form-label">Tên từ khóa <span class="text-danger">*</span>:</label>
                        <input type="text" name="name" id="element_keyword_name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="element_keyword_alias" class="form-label">Liên kết tĩnh:</label>
                        <div class="input-group">
                            <input type="text" name="alias" id="element_keyword_alias" class="form-control" placeholder="Tự động tạo từ tên từ khóa...">
                            <button type="button" class="btn btn-outline-secondary" id="btn-generate-alias" title="Tạo lại từ tên từ khóa">
                                <i class="fa fa-magic"></i>
                            </button>
                        </div>
                        <div class="form-text">
                            <i class="fa fa-magic text-primary"></i>
                            Tự động tạo từ tên từ khóa. Bạn có thể chỉnh sửa nếu muốn tùy chỉnh
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="element_keyword_description" class="form-label">Mô tả:</label>
                        <textarea name="description" id="element_keyword_description" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <div class="form-check form-switch">
                            <input type="checkbox" name="status" id="element_keyword_status" class="form-check-input" value="1" checked>
                            <label for="element_keyword_status" class="form-check-label">Hoạt động</label>
                        </div>
                    </div>
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">Lưu từ khóa</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Change Weight -->
<div class="modal fade" id="modal-change-weight" tabindex="-1" aria-labelledby="modal-change-weight-label" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-change-weight-label">
                    <i class="fa-solid fa-sort"></i> Thay đổi thứ tự
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="weight-input" class="form-label">Thứ tự mới:</label>
                    <div class="input-group">
                        <button type="button" class="btn btn-outline-secondary" id="weight-down">
                            <i class="fa fa-minus"></i>
                        </button>
                        <input type="number" class="form-control text-center" id="weight-input" min="1" value="1">
                        <button type="button" class="btn btn-outline-secondary" id="weight-up">
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                    <div class="form-text">Nhập thứ tự từ 1 đến <span id="max-weight">1</span></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btn-save-weight">
                    <i class="fa-solid fa-check"></i> Cập nhật
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i> Hủy
                </button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    // Biến để ngăn chặn double submit
    var isSubmitting = false;

    // Add keyword modal
    $(document).on('click', '[data-toggle="add_keywords"]', function(e) {
        e.preventDefault();
        var kid = $(this).data('kid') || 0;
        var title = $(this).data('mtitle') || 'Thêm từ khóa';
        var fc = $(this).data('fc') || 'addKeyword';

        $('#mdKeywordSingle .modal-title').text(title);
        $('#mdKeywordSingle input[name="id"]').val(kid);

        if (fc === 'editKeyword' && kid > 0) {
            // Load keyword data for editing
            $.post('{$FORM_ACTION}', {
                getkeyword: 1,
                id: kid,
                checkss: '{$smarty.const.NV_CHECK_SESSION}'
            }, function(res) {
                console.log('Edit keyword response:', res);
                if (res.success && res.data) {
                    // Điền dữ liệu vào form
                    $('#mdKeywordSingle input[name="id"]').val(res.data.id);
                    $('#mdKeywordSingle input[name="name"]').val(res.data.name);
                    $('#mdKeywordSingle input[name="alias"]').val(res.data.alias);
                    $('#mdKeywordSingle textarea[name="description"]').val(res.data.description || '');
                    $('#mdKeywordSingle input[name="status"]').prop('checked', res.data.status == 1);

                    // Đánh dấu alias không tự động tạo nữa
                    $('#mdKeywordSingle input[name="alias"]').data('auto-generated', false);
                } else {
                    alert(res.text || 'Có lỗi xảy ra khi tải dữ liệu từ khóa');
                }
            }, 'json').fail(function() {
                alert('Có lỗi xảy ra khi tải dữ liệu từ khóa');
            });
        } else {
            // Clear form for new keyword
            $('#mdKeywordSingle form')[0].reset();
            $('#mdKeywordSingle input[name="id"]').val(0);
            $('#mdKeywordSingle input[name="status"]').prop('checked', true);
            $('#mdKeywordSingle input[name="alias"]').data('auto-generated', true);
        }

        $('#mdKeywordSingle').modal('show');
    });

    // Auto generate alias from keyword name
    function generateAlias(text) {
        if (!text) return '';

        // Vietnamese to ASCII conversion map
        var vietnameseMap = {
            'à': 'a', 'á': 'a', 'ạ': 'a', 'ả': 'a', 'ã': 'a',
            'â': 'a', 'ầ': 'a', 'ấ': 'a', 'ậ': 'a', 'ẩ': 'a', 'ẫ': 'a',
            'ă': 'a', 'ằ': 'a', 'ắ': 'a', 'ặ': 'a', 'ẳ': 'a', 'ẵ': 'a',
            'è': 'e', 'é': 'e', 'ẹ': 'e', 'ẻ': 'e', 'ẽ': 'e',
            'ê': 'e', 'ề': 'e', 'ế': 'e', 'ệ': 'e', 'ể': 'e', 'ễ': 'e',
            'ì': 'i', 'í': 'i', 'ị': 'i', 'ỉ': 'i', 'ĩ': 'i',
            'ò': 'o', 'ó': 'o', 'ọ': 'o', 'ỏ': 'o', 'õ': 'o',
            'ô': 'o', 'ồ': 'o', 'ố': 'o', 'ộ': 'o', 'ổ': 'o', 'ỗ': 'o',
            'ơ': 'o', 'ờ': 'o', 'ớ': 'o', 'ợ': 'o', 'ở': 'o', 'ỡ': 'o',
            'ù': 'u', 'ú': 'u', 'ụ': 'u', 'ủ': 'u', 'ũ': 'u',
            'ư': 'u', 'ừ': 'u', 'ứ': 'u', 'ự': 'u', 'ử': 'u', 'ữ': 'u',
            'ỳ': 'y', 'ý': 'y', 'ỵ': 'y', 'ỷ': 'y', 'ỹ': 'y',
            'đ': 'd'
        };

        // Convert Vietnamese characters
        text = text.toLowerCase();
        for (var char in vietnameseMap) {
            var regex = new RegExp(char, 'g');
            text = text.replace(regex, vietnameseMap[char]);
        }

        return text
            .replace(/[^a-z0-9\s-]/g, '') // Remove special characters
            .replace(/\s+/g, '-') // Replace spaces with hyphens
            .replace(/-+/g, '-') // Replace multiple hyphens with single
            .replace(/^-|-$/g, ''); // Remove leading/trailing hyphens
    }

    // Auto-generate alias when typing keyword name
    $(document).on('input', '#element_keyword_name', function() {
        var name = $(this).val();
        var aliasField = $('#element_keyword_alias');
        var isAutoGenerated = aliasField.data('auto-generated') !== false;

        // Only auto-generate if field is empty or was auto-generated before
        if (isAutoGenerated || aliasField.val() === '') {
            var alias = generateAlias(name);
            aliasField.val(alias).data('auto-generated', true);
        }
    });

    // Mark alias as manually edited when user types in it
    $(document).on('input', '#element_keyword_alias', function() {
        $(this).data('auto-generated', false);
    });

    // Manual generate alias button
    $(document).on('click', '#btn-generate-alias', function() {
        var name = $('#element_keyword_name').val();
        var alias = generateAlias(name);
        $('#element_keyword_alias').val(alias).data('auto-generated', true);
    });

    // Handle AJAX form submission với cơ chế ngăn chặn double submit
    $(document).on('submit', '.keyword-ajax-submit', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation(); // Ngăn chặn các event handler khác

        if (isSubmitting) {
            return false;
        }

        var form = $(this);
        var btn = form.find('button[type="submit"]');
        var originalText = btn.html();

        isSubmitting = true;
        btn.html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý...').prop('disabled', true);

        $.ajax({
            url: location.href,
            type: 'POST',
            data: form.serialize(),
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    $('#mdKeywordSingle').modal('hide');
                    $('#mdKeywordMulti').modal('hide');
                    nukeviet.toast(response.mess, 'success');
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                } else {
                    nukeviet.toast(response.mess, 'error');
                }
            },
            error: function() {
                nukeviet.toast('Có lỗi xảy ra khi xử lý yêu cầu', 'error');
            },
            complete: function() {
                isSubmitting = false;
                btn.html(originalText).prop('disabled', false);
            }
        });

        return false;
    });
    $('.delete-btn').click(function() {
        var id = $(this).data('id');
        var name = $(this).data('name');

        if (confirm('Bạn có chắc chắn muốn xóa từ khóa "' + name + '"?')) {
            var btn = $(this);
            var originalText = btn.html();
            btn.html('<i class="fa fa-spinner fa-spin"></i>').prop('disabled', true);

            $.ajax({
                url: '{$FORM_ACTION}',
                type: 'POST',
                data: {
                    ajax: 1,
                    ajax_action: 'delete',
                    id: id
                },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        nukeviet.toast(response.mess, 'success');
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    } else {
                        nukeviet.toast(response.mess, 'error');
                        btn.html(originalText).prop('disabled', false);
                    }
                },
                error: function() {
                    nukeviet.toast('Có lỗi xảy ra khi xóa từ khóa', 'error');
                    btn.html(originalText).prop('disabled', false);
                }
            });
        }
    });

    // Change status
    $('.status-switch').change(function() {
        var id = $(this).data('id');
        var status = $(this).is(':checked') ? 1 : 0;
        var switchElement = $(this);

        $.ajax({
            url: '{$FORM_ACTION}',
            type: 'POST',
            data: {
                ajax: 1,
                ajax_action: 'change_status',
                id: id,
                status: status
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    nukeviet.toast(response.mess, 'success');
                } else {
                    nukeviet.toast(response.mess, 'error');
                    // Revert switch
                    switchElement.prop('checked', !switchElement.is(':checked'));
                }
            },
            error: function() {
                nukeviet.toast('Có lỗi xảy ra khi cập nhật trạng thái', 'error');
                // Revert switch
                switchElement.prop('checked', !switchElement.is(':checked'));
            }
        });
    });

    // Weight change functionality using modal
    var currentWeightData = {};

    // Handle click on weight badge
    $('body').on('click', '.change-weight-btn', function() {
        var id = $(this).data('id');
        var current = $(this).data('current');
        var max = $(this).data('max');

        currentWeightData = {
            id: id,
            current: current,
            max: max
        };

        $('#weight-input').val(current).attr('max', max);
        $('#max-weight').text(max);
        $('#modal-change-weight').modal('show');
    });

    // Handle weight up/down buttons in modal
    $('#weight-up').on('click', function() {
        var input = $('#weight-input');
        var current = parseInt(input.val()) || 1;
        var max = parseInt(input.attr('max'));

        if (current < max) {
            input.val(current + 1);
        }
    });

    $('#weight-down').on('click', function() {
        var input = $('#weight-input');
        var current = parseInt(input.val()) || 1;

        if (current > 1) {
            input.val(current - 1);
        }
    });

    // Handle save weight
    $('#btn-save-weight').on('click', function() {
        var new_weight = parseInt($('#weight-input').val());
        var id = currentWeightData.id;
        var current_weight = currentWeightData.current;
        var max = currentWeightData.max;

        // Validation
        if (isNaN(new_weight) || new_weight < 1 || new_weight > max) {
            $('#weight-input').addClass('is-invalid');
            nukeviet.toast('Thứ tự phải từ 1 đến ' + max, 'error');
            return false;
        }

        $('#weight-input').removeClass('is-invalid');

        if (new_weight != current_weight) {
            $(this).prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang lưu...');

            $.ajax({
                url: '{$FORM_ACTION}',
                type: 'POST',
                data: {
                    action: 'change_weight',
                    id: id,
                    new_weight: new_weight,
                    checkss: '{$smarty.const.NV_CHECK_SESSION}'
                },
                success: function(res) {
                    if (res.indexOf('OK_') === 0) {
                        $('#modal-change-weight').modal('hide');
                        nukeviet.toast('Cập nhật thứ tự thành công', 'success');
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    } else {
                        nukeviet.toast('Lỗi khi cập nhật thứ tự: ' + res, 'error');
                    }
                },
                error: function() {
                    nukeviet.toast('Lỗi kết nối', 'error');
                },
                complete: function() {
                    $('#btn-save-weight').prop('disabled', false).html('<i class="fa-solid fa-check"></i> Cập nhật');
                }
            });
        } else {
            $('#modal-change-weight').modal('hide');
        }
    });

    // Bulk actions handler
    $('[data-toggle="actionKeyword"]').on('click', function() {
        var container = $($(this).data('ctn'));
        var selectedIds = [];
        var actionType = $('#element_action').val();

        // Collect selected IDs
        container.find('input[data-toggle="checkSingle"]:checked').each(function() {
            selectedIds.push($(this).val());
        });

        if (selectedIds.length === 0) {
            nukeviet.toast('Vui lòng chọn ít nhất một từ khóa', 'warning');
            return false;
        }

        if (!actionType) {
            nukeviet.toast('Vui lòng chọn thao tác cần thực hiện', 'warning');
            return false;
        }

        var actionText = $('#element_action option:selected').text();
        var confirmMessage = 'Bạn có chắc chắn muốn ' + actionText.toLowerCase() + ' ' + selectedIds.length + ' từ khóa đã chọn?';

        if (actionType === 'delete') {
            confirmMessage = 'Bạn có chắc chắn muốn xóa ' + selectedIds.length + ' từ khóa đã chọn? Hành động này không thể hoàn tác!';
        }

        if (confirm(confirmMessage)) {
            var $button = $(this);
            var originalText = $button.html();
            $button.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý...');

            $.ajax({
                url: '{$FORM_ACTION}',
                type: 'POST',
                data: {
                    bulk_action: 1,
                    action_type: actionType,
                    selected_ids: selectedIds,
                    checkss: '{$smarty.const.NV_CHECK_SESSION}'
                },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        nukeviet.toast(response.message, 'success');
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    } else {
                        nukeviet.toast(response.message, 'error');
                    }
                },
                error: function() {
                    nukeviet.toast('Có lỗi xảy ra khi thực hiện thao tác', 'error');
                },
                complete: function() {
                    $button.prop('disabled', false).html(originalText);
                }
            });
        }
    });

    // Check all functionality
    $('[data-toggle="checkAll"]').on('change', function() {
        var isChecked = $(this).is(':checked');
        var container = $('#list-keywords-items');
        container.find('input[data-toggle="checkSingle"]').prop('checked', isChecked);
    });

    // Individual checkbox change
    $(document).on('change', 'input[data-toggle="checkSingle"]', function() {
        var container = $('#list-keywords-items');
        var totalCheckboxes = container.find('input[data-toggle="checkSingle"]').length;
        var checkedCheckboxes = container.find('input[data-toggle="checkSingle"]:checked').length;

        // Update "check all" checkbox state
        var checkAllBox = $('[data-toggle="checkAll"]');
        if (checkedCheckboxes === 0) {
            checkAllBox.prop('indeterminate', false).prop('checked', false);
        } else if (checkedCheckboxes === totalCheckboxes) {
            checkAllBox.prop('indeterminate', false).prop('checked', true);
        } else {
            checkAllBox.prop('indeterminate', true).prop('checked', false);
        }
    });
});
</script>