

<!-- Bộ lọc -->
<div class="card mb-4">
    <div class="card-header">
        <h5 class="card-title mb-0">
            <i class="fa fa-filter"></i> Bộ lọc
        </h5>
    </div>
    <div class="card-body">
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" class="row g-3">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="payments">

            <div class="col-md-3">
                <label class="form-label">Tìm kiếm</label>
                <input type="text" class="form-control" name="search" value="{$SEARCH}" placeholder="Nhập mã đơn hàng, tên khách hàng, email...">
            </div>

            <div class="col-md-2">
                <label class="form-label">Trạng thái</label>
                <select name="status" class="form-select">
                    <option value="">Tất cả trạng thái</option>
                    {foreach from=$STATUS_LIST key=status_key item=status_info}
                    <option value="{$status_key}" {if $STATUS_FILTER == $status_key}selected{/if}>{$status_info.title}</option>
                    {/foreach}
                </select>
            </div>

            <div class="col-md-2">
                <label class="form-label">Từ ngày</label>
                <input type="date" class="form-control" name="date_from" value="{$DATE_FROM}">
            </div>

            <div class="col-md-2">
                <label class="form-label">Đến ngày</label>
                <input type="date" class="form-control" name="date_to" value="{$DATE_TO}">
            </div>

            <div class="col-md-3">
                <label class="form-label">&nbsp;</label>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-search"></i> Tìm kiếm
                    </button>
                    <a href="{$FORM_ACTION}" class="btn btn-secondary">
                        <i class="fa fa-times"></i> Đặt lại
                    </a>
                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#paymentModal" title="Thanh toán hộ user">
                        <i class="fa fa-cart-plus"></i>
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Thống kê -->
<div class="row mb-4">
    <div class="col-md-12">
        <div class="alert alert-info">
            <i class="fa fa-info-circle"></i>
            Tổng số bản ghi: <strong>{$TOTAL_RECORDS}</strong>
        </div>
    </div>
</div>

<!-- Danh sách đơn hàng -->
<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">
            <i class="fa fa-list"></i> Danh sách đơn hàng
        </h5>
    </div>
    <div class="card-body p-0">
        {if !empty($PAYMENTS)}
        <div class="table-responsive">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th width="5%">#</th>
                        <th width="15%">Mã đơn hàng</th>
                        <th width="15%">Khách hàng</th>
                        <th width="20%">Mã nguồn</th>
                        <th width="10%">Số tiền</th>
                        <th width="10%">Phương thức</th>
                        <th width="10%">Trạng thái</th>
                        <th width="10%">Thời gian</th>
                        <th width="5%">Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$PAYMENTS item=payment}
                    <tr>
                        <td>{$payment.stt}</td>
                        <td>
                            <a href="{$payment.view_url}" class="text-decoration-none">
                                <strong>{$payment.id}</strong>
                            </a>
                            {if !empty($payment.transaction_id)}
                            <br><small class="text-muted">Mã GD: {$payment.transaction_id}</small>
                            {/if}
                        </td>
                        <td>
                            <div>
                                <strong>{$payment.full_name}</strong>
                                {if !empty($payment.username)}
                                <br><small class="text-muted">@{$payment.username}</small>
                                {/if}
                                {if !empty($payment.email)}
                                <br><small class="text-muted">{$payment.email}</small>
                                {/if}
                            </div>
                        </td>
                        <td>
                            {if !empty($payment.source_title)}
                                {if !empty($payment.source_url)}
                                <a href="{$payment.source_url}" target="_blank" class="text-decoration-none">
                                    {$payment.source_title}
                                </a>
                                {else}
                                <span class="text-decoration-none">{$payment.source_title}</span>
                                {/if}
                            {else}
                            <span class="text-muted">Mã nguồn đã bị xóa</span>
                            {/if}
                        </td>
                        <td>
                            <strong class="text-success">{$payment.amount_formatted}</strong>
                        </td>
                        <td>
                            {if !empty($payment.payment_method)}
                            <span class="badge bg-info">{$payment.payment_method}</span>
                            {else}
                            <span class="text-muted">-</span>
                            {/if}
                        </td>
                        <td>
                            <span class="badge bg-{$payment.status_info.class}">
                                {$payment.status_info.title}
                            </span>
                        </td>
                        <td>
                            <small>{$payment.purchase_time_formatted}</small>
                            {if !empty($payment.payment_time_formatted)}
                            <br><small class="text-success">Đã TT: {$payment.payment_time_formatted}</small>
                            {/if}
                        </td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <a href="{$payment.view_url}" class="btn btn-outline-primary" title="Xem chi tiết">
                                    <i class="fa fa-eye"></i>
                                </a>
                                <button type="button" class="btn btn-outline-danger" onclick="deletePayment('{$payment.id}', '{$payment.delete_url}')" title="Xóa">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        {else}
        <div class="text-center py-5">
            <i class="fa fa-inbox fa-3x text-muted mb-3"></i>
            <h5 class="text-muted">Chưa có đơn hàng nào</h5>
            <p class="text-muted">Hiện tại chưa có đơn hàng nào trong hệ thống</p>
        </div>
        {/if}
    </div>
</div>

{if !empty($GENERATE_PAGE)}
<div class="d-flex justify-content-center mt-4">
    {$GENERATE_PAGE}
</div>
{/if}

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
