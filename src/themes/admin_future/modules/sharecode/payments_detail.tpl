<div class="page-header">
    <h1 class="page-title">Chi tiết đơn hàng</h1>
    <div class="page-header-actions">
        <a href="{$FORM_ACTION}" class="btn btn-secondary">
            <i class="fa fa-arrow-left"></i> Quay lại danh sách
        </a>
        <button type="button" class="btn btn-danger" onclick="deletePayment('{$PAYMENT.id}', '{$PAYMENT.delete_url}')">
            <i class="fa fa-trash"></i> Xóa
        </button>
    </div>
</div>

<div class="row">
    <!-- Thông tin khách hàng và đơn hàng -->
    <div class="col-lg-8">
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-user"></i> Thông tin khách hàng và đơn hàng
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <table class="table table-borderless">
                            <tr>
                                <td width="40%" class="text-muted">Mã đơn hàng:</td>
                                <td><strong>{$PAYMENT.id}</strong></td>
                            </tr>
                            <tr>
                                <td class="text-muted">Tên khách hàng:</td>
                                <td><strong>{$PAYMENT.full_name}</strong></td>
                            </tr>
                            {if !empty($PAYMENT.username)}
                            <tr>
                                <td class="text-muted">Tên đăng nhập:</td>
                                <td><strong>{$PAYMENT.username}</strong></td>
                            </tr>
                            {/if}
                            {if !empty($PAYMENT.email)}
                            <tr>
                                <td class="text-muted">Email:</td>
                                <td><strong>{$PAYMENT.email}</strong></td>
                            </tr>
                            {/if}
                            <tr>
                                <td class="text-muted">Thời gian đặt mua:</td>
                                <td><strong>{$PAYMENT.purchase_time_formatted}</strong></td>
                            </tr>
                            {if !empty($PAYMENT.payment_time_formatted)}
                            <tr>
                                <td class="text-muted">Thời gian thanh toán:</td>
                                <td><strong class="text-success">{$PAYMENT.payment_time_formatted}</strong></td>
                            </tr>
                            {/if}
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table class="table table-borderless">
                            {if !empty($PAYMENT.transaction_id)}
                            <tr>
                                <td width="40%" class="text-muted">Mã giao dịch:</td>
                                <td><strong>{$PAYMENT.transaction_id}</strong></td>
                            </tr>
                            {/if}
                            {if !empty($PAYMENT.payment_method)}
                            <tr>
                                <td class="text-muted">Phương thức thanh toán:</td>
                                <td><span class="badge bg-info">{$PAYMENT.payment_method}</span></td>
                            </tr>
                            {/if}
                            <tr>
                                <td class="text-muted">Số tiền:</td>
                                <td><strong class="text-success fs-5">{$PAYMENT.amount_formatted}</strong></td>
                            </tr>
                            <tr>
                                <td class="text-muted">Trạng thái:</td>
                                <td>
                                    <span class="badge bg-{$PAYMENT.status_info.class} fs-6">
                                        {$PAYMENT.status_info.title}
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thông tin mã nguồn -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-code"></i> Thông tin mã nguồn
                </h5>
            </div>
            <div class="card-body">
                {if !empty($PAYMENT.source_title)}
                <div class="row">
                    <div class="col-md-8">
                        <h6 class="mb-2">
                            {if !empty($PAYMENT.source_url)}
                            <a href="{$PAYMENT.source_url}" target="_blank" class="text-decoration-none">
                                {$PAYMENT.source_title}
                            </a>
                            {else}
                            <span>{$PAYMENT.source_title}</span>
                            {/if}
                        </h6>
                        <p class="text-muted mb-2">
                            <small>Đường dẫn: {$PAYMENT.source_alias}</small>
                        </p>
                        <p class="text-muted mb-0">
                            <small>Giá: <strong>{$PAYMENT.source_price_formatted}</strong></small>
                        </p>
                    </div>
                    <div class="col-md-4 text-end">
                        {if !empty($PAYMENT.source_url)}
                        <a href="{$PAYMENT.source_url}" target="_blank" class="btn btn-outline-primary btn-sm">
                            <i class="fa fa-external-link"></i> Xem mã nguồn
                        </a>
                        {/if}
                    </div>
                </div>
                {else}
                <div class="alert alert-warning">
                    <i class="fa fa-exclamation-triangle"></i> Mã nguồn liên quan đến đơn hàng này đã bị xóa khỏi hệ thống
                </div>
                {/if}
            </div>
        </div>

        <!-- Ghi chú -->
        {if !empty($PAYMENT.notes)}
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-sticky-note"></i> Ghi chú
                </h5>
            </div>
            <div class="card-body">
                <div class="bg-light p-3 rounded">
                    {$PAYMENT.notes}
                </div>
            </div>
        </div>
        {/if}
    </div>

    <!-- Sidebar - Hành động -->
    <div class="col-lg-4">
        <!-- Cập nhật trạng thái -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-cogs"></i> Hành động
                </h5>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label">Cập nhật trạng thái</label>
                    <select class="form-select" id="status-select">
                        {foreach from=$STATUS_LIST key=status_key item=status_info}
                        <option value="{$status_key}" {if $PAYMENT.status == $status_key}selected{/if}>{$status_info.title}</option>
                        {/foreach}
                    </select>
                </div>
                <button type="button" class="btn btn-primary w-100" onclick="updateStatus()">
                    <i class="fa fa-save"></i> Cập nhật trạng thái
                </button>
            </div>
        </div>

        <!-- Thông tin bổ sung -->
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-info-circle"></i> Thông tin bổ sung
                </h5>
            </div>
            <div class="card-body">
                <div class="row text-center">
                    <div class="col-6">
                        <div class="border-end">
                            <h6 class="text-muted mb-1">Loại tiền</h6>
                            <strong>{$PAYMENT.currency}</strong>
                        </div>
                    </div>
                    <div class="col-6">
                        <h6 class="text-muted mb-1">ID người dùng</h6>
                        <strong>{$PAYMENT.userid}</strong>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    // Khởi tạo các thành phần
    $('[data-bs-toggle="tooltip"]').tooltip();
});

// Hàm cập nhật trạng thái
function updateStatus() {
    var newStatus = $('#status-select').val();
    var currentStatus = '{$PAYMENT.status}';

    if (newStatus === currentStatus) {
        nukeviet.toast('Trạng thái không thay đổi', 'warning');
        return;
    }

    if (confirm('Bạn có chắc chắn muốn cập nhật trạng thái?')) {
        $.ajax({
            url: '{$FORM_ACTION}',
            type: 'POST',
            data: {
                update_status: 1,
                id: '{$PAYMENT.id}',
                status: newStatus,
                checkss: '{$CHECKSS}'
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
                        window.location.href = '{$FORM_ACTION}';
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
