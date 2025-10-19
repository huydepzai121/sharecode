<link rel="stylesheet" href="{$ASSETS_STATIC_URL}/css/dataTables.bootstrap5.min.css">
<script src="{$ASSETS_STATIC_URL}/js/datatable/jquery.dataTables.min.js"></script>
<script src="{$ASSETS_STATIC_URL}/js/datatable/dataTables.bootstrap5.min.js"></script>
<link type="text/css" href="{$ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<div class="row">
    <div class="col-xxl-12">
        <div class="card">
            <div class="card-body">
                {* Hiển thị thông tin người dùng nếu có *}
                {if !empty($VIEW_USER_INFO)}
                <div class="alert alert-info">
                    <p>{$LANG->getModule('filter_user')}: <strong>{$VIEW_USER_NAME}</strong> <a href="{$VIEW_USER_CANCEL}" class="btn btn-default btn-xs">{$LANG->getModule('filter_cancel')}</a></p>
                </div>
                {/if}

                {* Hiển thị thông tin đơn hàng nếu có *}
                {if !empty($VIEW_ORDER_INFO)}
                <div class="alert alert-info">
                    <p>{$LANG->getModule('filter_order')}: <strong>{$VIEW_ORDER_NAME}</strong> <a href="{$VIEW_ORDER_CANCEL}" class="btn btn-default btn-xs">{$LANG->getModule('filter_cancel')}</a></p>
                </div>
                {/if}

                {* Form tìm kiếm *}
                <div class="mb-3">
                    <button class="btn btn-primary" type="button" data-bs-toggle="collapse" data-bs-target="#searchForm" aria-expanded="{$COLLAPSE1|default:'false'}" aria-controls="searchForm">
                        <i class="fas fa-search me-2"></i>{$LANG->getModule('search')}
                    </button>
                </div>

                <div class="collapse{$COLLAPSE2|default:''}" id="searchForm">
                    <form action="{$NV_BASE_ADMINURL}index.php" method="get" class="form-inline" role="form">
                        <input type="hidden" name="{$NV_LANG_VARIABLE}" value="{$NV_LANG_DATA}"/>
                        <input type="hidden" name="{$NV_NAME_VARIABLE}" value="{$MODULE_NAME}"/>
                        <input type="hidden" name="{$NV_OP_VARIABLE}" value="{$OP}"/>

                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="q" value="{$DATA_SEARCH.q|default:''}" placeholder="{$LANG->getModule('search_key')}"/>
                                    <select class="form-select w-25" name="are">
                                        <option value="">{$LANG->getModule('search_field')}</option>
                                        {foreach from=$FIELDS_SEARCH item=FIELD}
                                        <option value="{$FIELD.key}"{$FIELD.selected|default:''}>
                                            {$FIELD.title}
                                        </option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <select class="form-select" name="st">
                                    <option value="">---{$LANG->getModule('search_status')}---</option>
                                    {foreach from=$ST item=STATUS}
                                    <option value="{$STATUS.key}"{$STATUS.selected|default:''}>
                                        {$STATUS.title}
                                    </option>
                                    {/foreach}
                                </select>
                            </div>

                            <div class="col-md-3">
                                <select class="form-select" name="mo">
                                    <option value="">---{$LANG->getModule('search_money')}---</option>
                                    {foreach from=$MONEY_SYS item=MONEY}
                                    <option value="{$MONEY.key}"{$MONEY.selected|default:''}>
                                        {$MONEY.title}
                                    </option>
                                    {/foreach}
                                </select>
                            </div>

                            <div class="col-md-3">
                                <select class="form-select" name="tty">
                                    <option value="">---{$LANG->getModule('search_type')}---</option>
                                    {foreach from=$TTY item=TYPE}
                                    <option value="{$TYPE.key}"{$TYPE.selected|default:''}>
                                        {$TYPE.title}
                                    </option>
                                    {/foreach}
                                </select>
                            </div>

                            <div class="col-md-3">
                                <select class="form-select" name="tst">
                                    <option value="">---{$LANG->getModule('search_status')}---</option>
                                    {foreach from=$TST item=STATUS}
                                    <option value="{$STATUS.key}"{$STATUS.selected|default:''}>
                                        {$STATUS.title}
                                    </option>
                                    {/foreach}
                                </select>
                            </div>

                            <div class="col-md-3">
                                <select class="form-select" name="tpa">
                                    <option value="">---{$LANG->getModule('search_payment')}---</option>
                                    {foreach from=$TPA item=PAYMENT}
                                    <option value="{$PAYMENT.key}"{$PAYMENT.selected|default:''}>
                                        {$PAYMENT.title}
                                    </option>
                                    {/foreach}
                                </select>
                            </div>

                            <div class="col-md-12">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>{$LANG->getModule('search')}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>

                {* Bảng danh sách giao dịch *}
                <div class="table-responsive">
                    <table class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th class="text-center">STT</th>
                                <th>{$LANG->getModule('transaction_code')}</th>
                                <th>Thời gian tạo</th>
                                <th class="text-right">Số tiền giao dịch</th>
                                <th>{$LANG->getModule('money_unit')}</th>
                                <th>Tài khoản</th>
                                <th>{$LANG->getModule('customer_name')}</th>
                                <th>{$LANG->getModule('transaction_status')}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {assign var="i" value=1}
                            {foreach from=$TRANSACTIONS item=row}
                            <tr>
                                <td class="text-center">{$i++}</td>
                                <td>
                                    <a href="{$row.view_transaction}">{$row.code}</a>
                                </td>
                                <td>{$row.created_time}</td>
                                <td class="text-right">{$row.status}{$row.money_total}</td>
                                <td>{$row.money_unit}</td>
                                <td>
                                    <a href="{$row.view_user}">{$row.accounttran}</a>
                                </td>
                                <td>{$row.customer_name}</td>
                                <td>
                                    {if !empty($row.is_expired)}
                                        {$LANG->getModule('transaction_expired')}
                                    {elseif $row.transaction_status != 4 && ($IS_FULL_ADMIN || !empty($PERMISSION_ADMIN.is_mtransaction))}
                                        <select class="form-select form-select-sm transaction-status" onchange="nv_change_status(this, {$row.id})">
                                            {foreach from=$global_array_transaction_status key=key item=value}
                                            <option value="{$key}"{if $key == $row.transaction_status} selected="selected"{/if}{if $key == 0} disabled="disabled"{/if}>
                                                {$value}
                                            </option>
                                            {/foreach}
                                        </select>
                                    {else}
                                        {$global_array_transaction_status[$row.transaction_status]|default:'N/A'}
                                    {/if}
                                </td>
                            </tr>
                            {/foreach}
                        </tbody>
                        {if !empty($GENERATE_PAGE)}
                        <tfoot>
                            <tr>
                                <td colspan="9">{$GENERATE_PAGE}</td>
                            </tr>
                        </tfoot>
                        {/if}
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

function nv_change_status(obj, transactionid) {
    if (confirm('{$LANG->getModule('change_status_confirm')}')) {
        var new_vid = $(obj).val();
        $.post(
            script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '={$OP}&nocache=' + new Date().getTime(),
            'ajax_action=1&transactionid=' + transactionid + '&new_vid=' + new_vid,
            function(res) {
                var r_split = res.split('_');
                if (r_split[0] != 'OK') {
                    alert('{$LANG->getModule('status_error')}');
                }
                location.reload();
            }
        );
    }
    return false;
}
</script>
