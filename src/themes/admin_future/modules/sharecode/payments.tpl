
{if isset($SUCCESS_MESSAGE) and !empty($SUCCESS_MESSAGE)}
<div class="alert alert-success" role="alert"><i class="fa-solid fa-check-circle"></i> {$SUCCESS_MESSAGE}</div>
{/if}

{if isset($ERRORS) and !empty($ERRORS)}
<div class="alert alert-danger" role="alert">{$ERRORS|join:"<br />"}</div>
{/if}

<div class="card">
    <div class="card-header text-bg-primary rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium"><i class="fa-solid fa-credit-card"></i> Quản lý thanh toán <span class="badge bg-light text-dark ms-2">{$TOTAL_RECORDS}</span></div>
        <button type="button" class="btn btn-sm btn-secondary" data-bs-toggle="modal" data-bs-target="#paymentModal" title="Thanh toán hộ user">
            <i class="fa-solid fa-plus"></i> Tạo đơn hàng
        </button>
    </div>
    <div class="card-body">
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" id="form-search-payments">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="payments">

            <div class="row g-3 flex-xl-nowrap">
                <div class="col-md-3 flex-lg-fill">
                    <label for="element_search" class="form-label">Tìm kiếm</label>
                    <input type="text" class="form-control" name="search" id="element_search" value="{if isset($SEARCH.search)}{$SEARCH.search}{elseif isset($SEARCH) and !isset($SEARCH.search)}{$SEARCH}{/if}" placeholder="Mã đơn hàng, tên khách hàng, email...">
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-3">
                    <label for="element_status" class="form-label">Trạng thái</label>
                    <select name="status" id="element_status" class="form-select">
                        {if isset($STATUS_SEARCH)}
                        {foreach from=$STATUS_SEARCH key=key item=status}
                        <option value="{$key}"{if $STATUS_FILTER eq $key} selected{/if}>{$status}</option>
                        {/foreach}
                        {/if}
                    </select>
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-2">
                    <label for="element_date_from" class="form-label">Từ ngày</label>
                    <input type="date" class="form-control" name="date_from" id="element_date_from" value="{if isset($SEARCH.date_from)}{$SEARCH.date_from}{/if}">
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-2">
                    <label for="element_date_to" class="form-label">Đến ngày</label>
                    <input type="date" class="form-control" name="date_to" id="element_date_to" value="{if isset($SEARCH.date_to)}{$SEARCH.date_to}{/if}">
                </div>
                <div class="flex-grow-0 flex-shrink-1 w-auto">
                    <label for="submit_search" class="form-label d-none d-sm-block">&nbsp;</label>
                    <button id="submit_search" type="submit" class="btn btn-primary text-nowrap"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                </div>
            </div>
        </form>
    </div>
    <div class="card-body">

        <div class="table-responsive-lg table-card pb-1" id="list-payments-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted">
                    <tr>
                        <th class="text-nowrap" style="width: 1%;">
                            <input type="checkbox" data-toggle="checkAll" name="checkAll[]" class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                        </th>
                        <th class="text-nowrap" style="width: 5%;">ID</th>
                        <th class="text-nowrap" style="width: 12%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'id' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'desc'}&amp;of=id{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'id' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Mã đơn hàng</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'id' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Mã đơn hàng</span>
                            {/if}
                        </th>
                        <th class="text-nowrap" style="width: 15%;">Khách hàng</th>
                        <th class="text-nowrap" style="width: 20%;">Mã nguồn</th>
                        <th class="text-nowrap text-center" style="width: 10%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'amount' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'desc'}&amp;of=amount{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'amount' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-center">
                                <span class="me-1">Số tiền</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'amount' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Số tiền</span>
                            {/if}
                        </th>
                        <th class="text-nowrap text-center" style="width: 10%;">Phương thức</th>
                        <th class="text-nowrap text-center" style="width: 10%;">Trạng thái</th>
                        <th class="text-nowrap" style="width: 12%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'purchase_time' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'desc'}&amp;of=purchase_time{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'purchase_time' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Thời gian</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'purchase_time' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Thời gian</span>
                            {/if}
                        </th>
                        <th class="text-nowrap text-center" style="width: 1%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {if isset($PAYMENTS) and !empty($PAYMENTS)}
                    {foreach from=$PAYMENTS item=payment}
                    <tr class="indicator-{$payment.status_class}">
                        <td>
                            <input type="checkbox" data-toggle="checkSingle" name="checkSingle[]" value="{$payment.id}" class="form-check-input m-0 align-middle" aria-label="Chọn mục này">
                        </td>
                        <td class="text-center fw-medium">#{$payment.id}</td>
                        <td>
                            <div class="fw-medium">
                                <a href="{$payment.view_url}" class="text-decoration-none">{$payment.id}</a>
                            </div>
                            {if $payment.transaction_id}<small class="text-muted">Mã GD: {$payment.transaction_id}</small>{/if}
                        </td>
                        <td>
                            <div class="fw-medium">{$payment.full_name}</div>
                            {if $payment.username}<small class="text-muted">@{$payment.username}</small>{/if}
                            {if $payment.email}<br><small class="text-muted">{$payment.email}</small>{/if}
                        </td>
                        <td>
                            <div class="text-truncate-2">
                                {if $payment.source_title}
                                    {if $payment.source_url}
                                    <a href="{$payment.source_url}" target="_blank" class="fw-medium">{$payment.source_title}</a>
                                    {else}
                                    <span class="fw-medium">{$payment.source_title}</span>
                                    {/if}
                                {else}
                                <span class="text-muted">Mã nguồn đã bị xóa</span>
                                {/if}
                            </div>
                        </td>
                        <td class="text-center">
                            <span class="fw-medium text-success">{$payment.amount_formatted}</span>
                        </td>
                        <td class="text-center">
                            {if $payment.payment_method}
                            <span class="badge bg-info">{$payment.payment_method}</span>
                            {else}
                            <span class="text-muted">-</span>
                            {/if}
                        </td>
                        <td class="text-center">
                            <span class="badge bg-{$payment.status_class}">{$payment.status_text}</span>
                        </td>
                        <td class="text-nowrap">
                            <div>{$payment.purchase_time_formatted}</div>
                            {if $payment.payment_time_formatted}<small class="text-success">Đã TT: {$payment.payment_time_formatted}</small>{/if}
                        </td>
                        <td>
                            <div class="input-group flex-nowrap">
                                <a href="{$payment.view_url}" class="btn btn-sm btn-secondary text-nowrap">
                                    <i class="fa-solid fa-eye"></i> Xem
                                </a>
                                <button type="button" class="btn btn-sm btn-secondary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="visually-hidden">Thao tác</span>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><button type="button" class="dropdown-item" data-toggle="deletePayment" data-id="{$payment.id}" data-checksess="{$payment.checksess}"><i class="fa-solid fa-trash fa-fw text-center text-danger" data-icon="fa-trash"></i> Xóa</button></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                    {else}
                    <tr>
                        <td colspan="10" class="text-center py-4">
                            <div class="alert alert-info mb-0">
                                <i class="fa-solid fa-inbox fa-2x mb-2"></i>
                                <div><strong>Chưa có đơn hàng nào</strong></div>
                                <small class="text-muted">Hiện tại chưa có đơn hàng nào trong hệ thống</small>
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
                    <button class="btn btn-primary" type="button" id="element_action_btn" data-toggle="actionPayment" data-ctn="#list-payments-items">Thực hiện</button>
                </div>
            </div>
            <div class="pagination-wrap">
                {if isset($PAGINATION)}{$PAGINATION}{/if}
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    // Khởi tạo các thành phần
    $('[data-bs-toggle="tooltip"]').tooltip();
    
    // Xử lý form lọc
    $('form').on('submit', function(e) {
        // Loại bỏ các field trống
        $(this).find('input, select').each(function() {
            if ($(this).val() === '') {
                $(this).prop('disabled', true);
            }
        });
    });

    // Xử lý bulk actions
    $('#element_action_btn').click(function() {
        var action = $('#element_action').val();
        var selectedIds = [];

        // Lấy các checkbox đã chọn
        $('input[name="checkSingle[]"]:checked').each(function() {
            selectedIds.push($(this).val());
        });

        if (!action) {
            nukeviet.toast('Vui lòng chọn thao tác', 'warning');
            return;
        }

        if (selectedIds.length === 0) {
            nukeviet.toast('Vui lòng chọn ít nhất 1 mục', 'warning');
            return;
        }

        var actionText = $('#element_action option:selected').text();

        // Xử lý export Excel riêng
        if (action === 'export_selected') {
            if (confirm('Bạn có chắc chắn muốn xuất Excel cho ' + selectedIds.length + ' mục đã chọn?')) {
                // Tạo form ẩn để submit và download file
                var form = $('<form>', {
                    'method': 'POST',
                    'action': '{$FORM_ACTION}'
                });

                form.append($('<input>', {
                    'type': 'hidden',
                    'name': 'bulk_action',
                    'value': '1'
                }));

                form.append($('<input>', {
                    'type': 'hidden',
                    'name': 'action',
                    'value': action
                }));

                // Thêm các selected_ids
                selectedIds.forEach(function(id) {
                    form.append($('<input>', {
                        'type': 'hidden',
                        'name': 'selected_ids[]',
                        'value': id
                    }));
                });

                $('body').append(form);
                form.submit();
                form.remove();

                nukeviet.toast('Đang xuất file Excel...', 'info');
            }
        } else {
            // Xử lý các action khác
            if (confirm('Bạn có chắc chắn muốn thực hiện "' + actionText + '" cho ' + selectedIds.length + ' mục đã chọn?')) {
                $.ajax({
                    url: '{$FORM_ACTION}',
                    type: 'POST',
                    data: {
                        bulk_action: 1,
                        action: action,
                        selected_ids: selectedIds
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
                        nukeviet.toast('Có lỗi hệ thống xảy ra', 'error');
                    }
                });
            }
        }
    });
});

// Hàm xóa đơn hàng
function deletePayment(paymentId, deleteUrl) {
    if (confirm('Bạn có chắc chắn muốn xóa đơn hàng này?')) {
        $.ajax({
            url: deleteUrl,
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    nukeviet.toast(response.mess, 'success');
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                } else {
                    nukeviet.toast(response.mess, 'error');
                }
            },
            error: function() {
                nukeviet.toast('Có lỗi hệ thống xảy ra', 'error');
            }
        });
    }
}

// Hàm cập nhật trạng thái
function updateStatus(paymentId, newStatus, checkss) {
    if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái?')) {
        $.ajax({
            url: '{$FORM_ACTION}',
            type: 'POST',
            data: {
                update_status: 1,
                id: paymentId,
                status: newStatus,
                checkss: checkss
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
                }
            },
            error: function() {
                nukeviet.toast('Có lỗi hệ thống xảy ra', 'error');
            }
        });
    }
}
</script>

<!-- Modal Thanh toán hộ user -->
<div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="paymentModalLabel">Thanh toán hộ user</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="paymentForm" method="post" action="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}=payments">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Chọn User <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="element_userid" name="userid" required placeholder="Nhập User ID hoặc click Chọn">
                            <button class="btn btn-outline-secondary" type="button" id="element_userid_btn" data-filtersql="{$FILTERSQL}">Chọn</button>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Chọn mã nguồn <span class="text-danger">*</span></label>
                        <select name="source_id" class="form-select" id="source_select" required>
                            <option value="">-- Chọn mã nguồn --</option>
                            {foreach $sources as $source}
                            <option value="{$source.id}" data-fee="{$source.fee_amount}" data-fee-type="{$source.fee_type}">
                                {$source.title} {if $source.fee_amount > 0}({$source.fee_amount|number_format} VNĐ){else}(Miễn phí){/if}
                            </option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Số tiền thanh toán <span class="text-danger">*</span></label>
                        <input type="number" name="amount" id="amount_input" class="form-control" step="0.01" min="0" required readonly>
                        <div class="form-text">Số tiền được tự động cập nhật theo mã nguồn đã chọn</div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ghi chú</label>
                        <textarea name="notes" class="form-control" rows="3" placeholder="Ghi chú về giao dịch này..."></textarea>
                    </div>

                    <input type="hidden" name="action" value="admin_payment">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-save"></i> Thực hiện thanh toán
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Auto fill amount when source is selected
    $('#source_select').change(function() {
        var fee = $(this).find(':selected').data('fee');
        var fee_type = $(this).find(':selected').data('fee-type');
        if (fee_type == 'contact') {
            $('#amount_input').val('0');
        } else {
            if (fee > 0) {
                $('#amount_input').val(fee);
            } else {
                $('#amount_input').val('0');
            }
        }
    });

    $('#element_userid_btn').click(function() {
        var filtersql = $(this).data('filtersql');
        var url = script_name + '?language=' + nv_lang_data + '&nv=users&op=getuserid&area=element_userid&return=userid&filtersql=' + filtersql;
        window.open(url, 'userselect', 'width=800,height=600,scrollbars=yes,resizable=yes');
    });

    // Handle form submission
    $('#paymentForm').submit(function(e) {
        e.preventDefault();

        var formData = $(this).serialize();

        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    nukeviet.toast(response.message, 'success');
                    $('#paymentModal').modal('hide');
                    $('#paymentForm')[0].reset();
                    location.reload(); // Reload để cập nhật danh sách
                } else {
                    nukeviet.toast(response.message || 'Có lỗi xảy ra', 'error');
                }
            },
            error: function() {
                nukeviet.toast('Có lỗi hệ thống xảy ra', 'error');
            }
        });
    });
});
</script>
