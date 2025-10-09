<link type="text/css" href="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/i18n/{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>

{if isset($SUCCESS_MESSAGE) and !empty($SUCCESS_MESSAGE)}
<div class="alert alert-success" role="alert"><i class="fa-solid fa-check-circle"></i> {$SUCCESS_MESSAGE}</div>
{/if}

{if isset($ERRORS) and !empty($ERRORS)}
<div class="alert alert-danger" role="alert">{$ERRORS|join:"<br />"}</div>
{/if}

<div class="card">
    <div class="card-header text-bg-warning rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium"><i class="fa-solid fa-clock"></i> Sản phẩm chờ duyệt <span
                class="badge bg-light text-dark ms-2">{$TOTAL_ITEMS}</span></div>
        <div class="btn-group">
            <button type="button" class="btn btn-sm btn-secondary" data-toggle="bulkApprove">
                <i class="fa-solid fa-check"></i> Duyệt hàng loạt
            </button>
            <button type="button" class="btn btn-sm btn-secondary" data-toggle="bulkReject">
                <i class="fa-solid fa-times"></i> Từ chối hàng loạt
            </button>
        </div>
    </div>
    <div class="card-body">
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" id="form-search-pending">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="pending">

            <div class="row g-3 flex-xl-nowrap">
                <div class="col-md-3 flex-lg-fill">
                    <label for="element_q" class="form-label">Từ khóa tìm kiếm</label>
                    <input type="text" class="form-control" name="q" id="element_q"
                        value="{if isset($SEARCH.q)}{$SEARCH.q}{/if}" maxlength="64"
                        placeholder="Tìm theo tên, mô tả...">
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-3">
                    <label for="element_catid" class="form-label">Danh mục</label>
                    <select class="form-select select2" name="catid" id="element_catid">
                        {if isset($CATEGORIES)}
                        {foreach from=$CATEGORIES item=cat}
                        <option value="{if isset($cat.value)}{$cat.value}{elseif isset($cat.id)}{$cat.id}{else}0{/if}"
                            {if (isset($cat.value) and isset($SEARCH.catid) and $cat.value eq $SEARCH.catid) or
                            (isset($cat.id) and isset($SEARCH.catid) and $cat.id eq $SEARCH.catid)} selected{/if}>{if
                            isset($cat.title)}{$cat.title}{elseif isset($cat.name)}{$cat.name}{else}Không xác định{/if}
                        </option>
                        {/foreach}
                        {/if}
                    </select>
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-2">
                    <label for="element_fee_type" class="form-label">Loại phí</label>
                    <select class="form-select" name="fee_type" id="element_fee_type">
                        {foreach from=$FEE_TYPE_SEARCH key=key item=fee_type}
                        <option value="{$key}" {if isset($SEARCH.fee_type) and $key eq $SEARCH.fee_type} selected{/if}>
                            {$fee_type}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-2">
                    <label for="element_userid" class="form-label">User ID</label>
                    <input type="number" class="form-control" name="userid" id="element_userid"
                        value="{if isset($SEARCH.userid)}{$SEARCH.userid}{/if}" placeholder="ID người dùng">
                </div>
                <div class="flex-grow-0 flex-shrink-1 w-auto">
                    <label for="submit_search" class="form-label d-none d-sm-block">&nbsp;</label>
                    <button id="submit_search" type="submit" class="btn btn-primary text-nowrap"><i
                            class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                </div>
            </div>
        </form>
    </div>
    <div class="card-body">

        <div class="table-responsive-lg table-card pb-1" id="list-pending-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted">
                    <tr>
                        <th class="text-nowrap" style="width: 1%;">
                            <input type="checkbox" data-toggle="checkAll" name="checkAll[]"
                                class="form-check-input m-0 align-middle"
                                aria-label="{$LANG->getGlobal('toggle_checkall')}">
                        </th>
                        <th class="text-nowrap" style="width: 5%;">ID</th>
                        <th class="text-nowrap" style="width: 30%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'title' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'asc'}&amp;of=title{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'title' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}"
                                class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Tiêu đề</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'title' or
                                empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq
                                'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i
                                    class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Tiêu đề</span>
                            {/if}
                        </th>
                        <th class="text-nowrap" style="width: 15%;">Danh mục</th>
                        <th class="text-nowrap" style="width: 12%;">Tác giả</th>
                        <th class="text-nowrap text-center" style="width: 8%;">Loại phí</th>
                        <th class="text-nowrap" style="width: 12%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'add_time' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'desc'}&amp;of=add_time{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'add_time' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}"
                                class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Ngày gửi</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'add_time' or
                                empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq
                                'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i
                                    class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Ngày gửi</span>
                            {/if}
                        </th>
                        <th class="text-nowrap text-center" style="width: 1%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {if isset($SOURCES) and !empty($SOURCES)}
                    {foreach from=$SOURCES item=source}
                    <tr id="row-{$source.id}" class="indicator-warning">
                        <td>
                            <input type="checkbox" data-toggle="checkSingle" name="checkSingle[]" value="{$source.id}"
                                class="form-check-input m-0 align-middle"
                                aria-label="{$LANG->getGlobal('toggle_checksingle')}">
                        </td>
                        <td class="text-center fw-medium">#{$source.id}</td>
                        <td>
                            <div class="text-truncate-2">
                                <strong>{$source.title}</strong>
                                {if $source.description}<br><small
                                    class="text-muted">{$source.description|truncate:80}</small>{/if}
                                {if $source.keywords_array}
                                <div class="mt-1">
                                    {foreach from=$source.keywords_array item=keyword}
                                    <span class="badge bg-light text-dark me-1">{$keyword}</span>
                                    {/foreach}
                                </div>
                                {/if}
                            </div>
                        </td>
                        <td>
                            <span class="badge bg-info">{$source.category_title|default:'Chưa phân loại'}</span>
                        </td>
                        <td>
                            <div class="fw-medium">{$source.username}</div>
                            <small class="text-muted">ID: {$source.userid}</small>
                        </td>
                        <td class="text-center">
                            <span class="badge bg-{$source.fee_class}">{$source.fee_text}</span>
                        </td>
                        <td class="text-nowrap">
                            <div>{$source.add_time_format}</div>
                            <small class="text-muted">{$source.add_time_hour}</small>
                        </td>
                        <td>
                            <div class="input-group flex-nowrap">
                                <button type="button" class="btn btn-sm btn-secondary text-nowrap"
                                    data-toggle="approveSource" data-id="{$source.id}"
                                    data-checksess="{$source.checksess}">
                                    <i class="fa-solid fa-check"></i> Duyệt
                                </button>
                                <button type="button"
                                    class="btn btn-sm btn-secondary dropdown-toggle dropdown-toggle-split"
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="visually-hidden">Thao tác</span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><button type="button" class="dropdown-item" data-toggle="viewSource"
                                            data-id="{$source.id}"><i
                                                class="fa-solid fa-eye fa-fw text-center text-info"
                                                data-icon="fa-eye"></i> Xem chi tiết</button></li>
                                    <li><button type="button" class="dropdown-item" data-toggle="rejectSource"
                                            data-id="{$source.id}" data-checksess="{$source.checksess}"><i
                                                class="fa-solid fa-times fa-fw text-center text-warning"
                                                data-icon="fa-times"></i> Từ chối</button></li>
                                    <li><button type="button" class="dropdown-item" data-toggle="deleteSource"
                                            data-id="{$source.id}" data-checksess="{$source.checksess}"><i
                                                class="fa-solid fa-trash fa-fw text-center text-danger"
                                                data-icon="fa-trash"></i> {$LANG->getGlobal('delete')}</button></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                    {else}
                    <tr>
                        <td colspan="8" class="text-center py-4">
                            <div class="alert alert-info mb-0">
                                <i class="fa-solid fa-inbox fa-2x mb-2"></i>
                                <div><strong>Không có sản phẩm nào chờ duyệt</strong></div>
                                <small class="text-muted">Tất cả sản phẩm đã được xử lý hoặc chưa có sản phẩm mới
                                    nào.</small>
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
                    <input type="checkbox" data-toggle="checkAll" name="checkAll[]"
                        class="form-check-input m-0 align-middle" aria-label="{$LANG->getGlobal('toggle_checkall')}">
                </div>
                <div class="input-group me-1 my-1">
                    <select id="element_action" class="form-select fw-150" aria-label="Chọn thao tác"
                        aria-describedby="element_action_btn">
                        {if isset($ACTIONS)}
                        {foreach from=$ACTIONS item=action}
                        <option value="{$action.value}">{$action.title}</option>
                        {/foreach}
                        {/if}
                    </select>
                    <button class="btn btn-primary" type="button" id="element_action_btn" data-toggle="actionPending"
                        data-ctn="#list-pending-items">Thực hiện</button>
                </div>
            </div>
            <div class="pagination-wrap">
                {if isset($PAGINATION)}{$PAGINATION}{/if}
            </div>
        </div>
    </div>
</div>

{* Modals *}
{* Modal chi tiết sản phẩm *}
<div class="modal fade" id="sourceDetailModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Chi tiết sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="sourceDetailContent">
                <div class="text-center">
                    <div class="spinner-border" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{* Modal phê duyệt *}
<div class="modal fade" id="approveModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Phê duyệt sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Ghi chú cho tác giả (tùy chọn):</label>
                    <textarea id="approveNote" class="form-control" rows="3"
                        placeholder="Nhập ghi chú sẽ được gửi đến tác giả..."></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-success" onclick="confirmApprove()">
                    <i class="fa fa-check"></i> Phê duyệt
                </button>
            </div>
        </div>
    </div>
</div>

{* Modal từ chối *}
<div class="modal fade" id="rejectModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Từ chối sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="form-label">Lý do từ chối <span class="text-danger">*</span>:</label>
                    <textarea id="rejectNote" class="form-control" rows="3"
                        placeholder="Nhập lý do từ chối để gửi đến tác giả..." required></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-danger" onclick="confirmReject()">
                    <i class="fa fa-times"></i> Từ chối
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        var currentSourceId = 0;

        // Check all functionality
        $('#check-all').change(function () {
            $('.source-checkbox').prop('checked', $(this).prop('checked'));
        });

        $('.source-checkbox').change(function () {
            var allChecked = $('.source-checkbox:checked').length === $('.source-checkbox').length;
            $('#check-all').prop('checked', allChecked);
        });

        // View source details
        window.viewSource = function (id) {
            $('#sourceDetailModal').modal('show');

            $.get('{$BASE_URL}&action=view&id=' + id, function (data) {
                $('#sourceDetailContent').html(data);
            }).fail(function () {
                $('#sourceDetailContent').html('<div class="alert alert-danger">Không thể tải thông tin sản phẩm</div>');
            });
        };

        // Approve source
        window.approveSource = function (id) {
            currentSourceId = id;
            $('#approveNote').val('');
            $('#approveModal').modal('show');
        };

        window.confirmApprove = function () {
            var note = $('#approveNote').val();

            $.post('{$BASE_URL}&action=approve&id=' + currentSourceId, {
                checksess: '{$smarty.const.NV_CHECK_SESSION}',
                note: note
            }, function (response) {
                if (response.status === 'OK') {
                    $('#approveModal').modal('hide');
                    $('#row-' + currentSourceId).fadeOut(300, function () {
                        $(this).remove();
                        updateCounts();
                    });
                    nukeviet.toast(response.mess || 'Phê duyệt thành công', 'success');
                } else {
                    nukeviet.toast(response.mess || 'Có lỗi xảy ra khi phê duyệt', 'error');
                }
            }, 'json').fail(function () {
                nukeviet.toast('Có lỗi xảy ra khi kết nối với máy chủ', 'error');
            });
        };

        // Reject source
        window.rejectSource = function (id) {
            currentSourceId = id;
            $('#rejectNote').val('');
            $('#rejectModal').modal('show');
        };

        // Event listeners for data-toggle buttons
        $(document).on('click', '[data-toggle="approveSource"]', function () {
            var id = $(this).data('id');
            approveSource(id);
        });

        $(document).on('click', '[data-toggle="rejectSource"]', function () {
            var id = $(this).data('id');
            rejectSource(id);
        });

        $(document).on('click', '[data-toggle="viewSource"]', function () {
            var id = $(this).data('id');
            viewSource(id);
        });

        $(document).on('click', '[data-toggle="deleteSource"]', function () {
            var id = $(this).data('id');
            deleteSource(id);
        });

        // Delete source
        window.deleteSource = function (id) {
            if (confirm('Bạn có chắc chắn muốn xóa sản phẩm này? Thao tác này không thể hoàn tác!')) {
                $.post('{$BASE_URL}&action=delete&id=' + id, {
                    checksess: '{$smarty.const.NV_CHECK_SESSION}'
                }, function (response) {
                    if (response.status === 'OK') {
                        $('#row-' + id).fadeOut(300, function () {
                            $(this).remove();
                            updateCounts();
                        });
                        nukeviet.toast(response.mess || 'Xóa thành công', 'success');
                    } else {
                        nukeviet.toast(response.mess || 'Có lỗi xảy ra khi xóa', 'error');
                    }
                }, 'json').fail(function () {
                    nukeviet.toast('Có lỗi xảy ra khi kết nối với máy chủ', 'error');
                });
            }
        };

        window.confirmReject = function () {
            var note = $('#rejectNote').val();

            if (!note.trim()) {
                nukeviet.toast('Vui lòng nhập lý do từ chối', 'error');
                return;
            }

            $.post('{$BASE_URL}&action=reject&id=' + currentSourceId, {
                checksess: '{$smarty.const.NV_CHECK_SESSION}',
                note: note
            }, function (response) {
                if (response.status === 'OK') {
                    $('#rejectModal').modal('hide');
                    $('#row-' + currentSourceId).fadeOut(300, function () {
                        $(this).remove();
                        updateCounts();
                    });
                    nukeviet.toast(response.mess || 'Từ chối thành công', 'success');
                } else {
                    nukeviet.toast(response.mess || 'Có lỗi xảy ra khi từ chối', 'error');
                }
            }, 'json').fail(function () {
                nukeviet.toast('Có lỗi xảy ra khi kết nối với máy chủ', 'error');
            });
        };

        // Bulk operations
        window.bulkApprove = function () {
            var selected = $('.source-checkbox:checked').map(function () {
                return $(this).val();
            }).get();

            if (selected.length === 0) {
                nukeviet.toast('Vui lòng chọn ít nhất một sản phẩm', 'warning');
                return;
            }

            if (confirm('Bạn có chắc muốn phê duyệt ' + selected.length + ' sản phẩm đã chọn?')) {
                var completed = 0;
                var total = selected.length;

                selected.forEach(function (id) {
                    $.post('{$BASE_URL}&action=approve&id=' + id, {
                        checksess: '{$smarty.const.NV_CHECK_SESSION}',
                        note: 'Phê duyệt hàng loạt'
                    }, function (response) {
                        completed++;
                        if (response.status === 'OK') {
                            $('#row-' + id).fadeOut(300, function () {
                                $(this).remove();
                            });
                        }

                        if (completed === total) {
                            nukeviet.toast('Đã hoàn thành xử lý hàng loạt', 'success');
                            updateCounts();
                            $('#check-all').prop('checked', false);
                        }
                    }, 'json');
                });
            }
        };

        window.bulkReject = function () {
            var selected = $('.source-checkbox:checked').map(function () {
                return $(this).val();
            }).get();

            if (selected.length === 0) {
                nukeviet.toast('Vui lòng chọn ít nhất một sản phẩm', 'warning');
                return;
            }

            var reason = prompt('Nhập lý do từ chối (sẽ áp dụng cho tất cả sản phẩm đã chọn):');
            if (!reason) return;

            if (confirm('Bạn có chắc muốn từ chối ' + selected.length + ' sản phẩm đã chọn?')) {
                var completed = 0;
                var total = selected.length;

                selected.forEach(function (id) {
                    $.post('{$BASE_URL}&action=reject&id=' + id, {
                        checksess: '{$smarty.const.NV_CHECK_SESSION}',
                        note: reason
                    }, function (response) {
                        completed++;
                        if (response.status === 'OK') {
                            $('#row-' + id).fadeOut(300, function () {
                                $(this).remove();
                            });
                        }

                        if (completed === total) {
                            nukeviet.toast('Đã hoàn thành xử lý hàng loạt', 'success');
                            updateCounts();
                            $('#check-all').prop('checked', false);
                        }
                    }, 'json');
                });
            }
        };

        function updateCounts() {
            setTimeout(function () {
                var remainingRows = $('tbody tr').length;
                $('.badge').text(remainingRows);

                if (remainingRows === 0) {
                    $('tbody').html('<tr><td colspan="8" class="text-center py-4"><i class="fa fa-check-circle fa-3x text-success mb-2"></i><br>Đã xử lý hết tất cả sản phẩm chờ duyệt!</td></tr>');
                }
            }, 500);
        }

        // Bulk actions handler
        $('#element_action_btn').click(function () {
            var action = $('#element_action').val();
            var selectedIds = [];

            // Lấy các checkbox được chọn (sử dụng checkSingle)
            $('input[data-toggle="checkSingle"]:checked').each(function () {
                selectedIds.push($(this).val());
            });

            if (!action) {
                alert('Vui lòng chọn thao tác!');
                return;
            }

            if (selectedIds.length === 0) {
                alert('Vui lòng chọn ít nhất một sản phẩm!');
                return;
            }

            var actionText = '';
            switch (action) {
                case 'approve':
                    actionText = 'phê duyệt';
                    break;
                case 'reject':
                    actionText = 'từ chối';
                    break;
                case 'delete':
                    actionText = 'xóa';
                    break;
            }

            if (confirm('Bạn có chắc chắn muốn ' + actionText + ' ' + selectedIds.length + ' sản phẩm đã chọn?')) {
                // Sử dụng AJAX thay vì form submit
                $.post('{$BASE_URL}', {
                    bulk_action: action,
                    selected_ids: selectedIds,
                    checksess: '{$smarty.const.NV_CHECK_SESSION}'
                }, function (response) {
                    console.log('Bulk action response:', response);

                    // Reload trang để cập nhật danh sách
                    location.reload();
                }).fail(function (xhr, status, error) {
                    console.error('Bulk action failed:', error);
                    alert('Có lỗi xảy ra: ' + error);
                });
            }
        });
    });
</script>