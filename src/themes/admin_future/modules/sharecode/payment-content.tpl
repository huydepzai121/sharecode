<div class="page-header">
    <h1 class="page-title">Thanh toán hộ user</h1>
    <div class="page-header-actions">
        <a class="btn btn-secondary" href="{$FORM_ACTION}&op=payments">
            <i class="fa fa-arrow-left"></i> Quay lại danh sách đơn hàng
        </a>
    </div>
</div>

{if $errors}
    {foreach $errors as $error}
    <div class="alert alert-danger">
        <i class="fa fa-exclamation-triangle"></i> {$error}
    </div>
    {/foreach}
{/if}

{if $success}
<div class="alert alert-success">
    <i class="fa fa-check-circle"></i> {$success}
</div>
{/if}

<form method="post" action="{$FORM_ACTION}">
    <div class="card">
        <div class="card-header">
            <h5 class="card-title mb-0">Thông tin thanh toán hộ</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Chọn User <span class="text-danger">*</span></label>
                        <div class="input-group d-inline-flex w-auto">
                            <input type="text" class="form-control" id="element_userid" name="userid" value="{$data.userid}" maxlength="20" aria-describedby="element_userid_btn" required>
                            <button class="btn btn-secondary" type="button" id="element_userid_btn" data-filtersql="{$FILTERSQL}">Chọn</button>
                        </div>
                        <small class="form-text text-muted">Nhập User ID hoặc click "Chọn" để tìm kiếm</small>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Chọn mã nguồn <span class="text-danger">*</span></label>
                        <select name="source_id" class="form-control" required>
                            <option value="">-- Chọn mã nguồn --</option>
                            {foreach $sources as $source}
                            <option value="{$source.id}" {if $source.id == $data.source_id}selected{/if} data-fee="{$source.fee_amount}">
                                {$source.title} {if $source.fee_amount > 0}({$source.fee_amount|number_format} VNĐ){else}(Miễn phí){/if}
                            </option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Số tiền thanh toán <span class="text-danger">*</span></label>
                        <input type="number" name="amount" value="{$data.amount}" class="form-control" step="0.01" min="0" required>
                        <small class="form-text text-muted">Số tiền thực tế user phải trả</small>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Ghi chú</label>
                        <textarea name="notes" class="form-control" rows="3" placeholder="Ghi chú về giao dịch này...">{$data.notes}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <button type="submit" name="submit" class="btn btn-primary">
                <i class="fa fa-save"></i> Thực hiện thanh toán
            </button>
        </div>
    </div>
</form>

<script>
$(document).ready(function() {
    // Auto fill amount when source is selected
    $('select[name="source_id"]').change(function() {
        var fee = $(this).find(':selected').data('fee');
        if (fee > 0) {
            $('input[name="amount"]').val(fee);
        }
    });

    // Handle user selection popup
    $('#element_userid_btn').click(function() {
        var filtersql = $(this).data('filtersql');
        var url = script_name + '?language=' + nv_lang_data + '&nv=users&op=getuserid&area=element_userid&return=username&filtersql=' + filtersql;
        window.open(url, 'userselect', 'width=800,height=600,scrollbars=yes,resizable=yes');
    });
});

// Function to be called from popup window
function selectUser(userid, username) {
    $('#element_userid').val(userid);
    // Close popup if it exists
    if (window.opener) {
        window.close();
    }
}
</script>