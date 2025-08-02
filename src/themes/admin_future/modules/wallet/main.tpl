<style>
.ui-datepicker {
    z-index: 1056 !important;
}
.money-total {
    color: #dc3545;
    font-weight: bold;
    font-size: 1.2rem;
}
.edit-form {
    display: none;
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    margin: 15px 0;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.edit-form.active {
    display: block;
}

</style>
<link rel="stylesheet" href="{ASSETS_STATIC_URL}/css/dataTables.bootstrap5.min.css">
<link rel="stylesheet" href="{$URL_THEMES}css_custom/sweetalert.css">
<script src="{ASSETS_STATIC_URL}/js/datatable/jquery.dataTables.min.js"></script>
<script src="{ASSETS_STATIC_URL}/js/datatable/dataTables.bootstrap5.min.js"></script>
<link type="text/css" href="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/i18n/{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/language/jquery.ui.datepicker-{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/clipboard/clipboard.min.js"></script>
<script type="text/javascript" src="{$URL_THEMES}js/sweetalert.min.js"></script>
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-body">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <form method="get" action="{NV_BASE_ADMINURL}index.php" class="search-form">
                            <input type="hidden" name="{NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}"/>
                            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{$MODULE_NAME}"/>
                            <div class="row g-3">
                                <div class="col-md-5">
                                    <input type="text" name="q" value="{$SEARCH.q}" class="form-control" placeholder="{$LANG->getModule('search_title')}"/>
                                </div>
                                <div class="col-md-4">
                                    <select class="form-control" name="f">
                                        <option value="">{$LANG->getModule('search_field')}</option>
                                        {foreach $METHODS key=k item=v}
                                        <option value="{$v.key}"{$v.selected}>{$v.value}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="fas fa-search me-2"></i>{$LANG->getModule('submit')}
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <!-- <div class="col-md-4 text-end">
                        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#updateAccountModal">
                            <i class="fas fa-plus-circle me-2"></i>{$LANG->getModule('creataccount')}
                        </button>
                    </div> -->
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <div class="row align-items-center">
                    <h3>Danh sách tài khoản</h3>
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover" id="tbWallet">
                                <caption>{$TABLE_CAPTION}</caption>
                                <thead>
                                    <tr>
                                        <th>{$LANG->getModule('account')}</th>
                                        <th>{$LANG->getModule('user_full_name')}</th>
                                        <th>{$LANG->getModule('user_email')}</th>
                                        <th>{$LANG->getModule('whocreate')}</th>
                                        <th class="w150">{$LANG->getModule('datecreate')}</th>
                                        <th class="text-right w200">{$LANG->getModule('money_total')}</th>
                                        <th class="text-center w150">{$LANG->getModule('function')}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {if !empty($ACCOUNTS)}
                                        {foreach from=$ACCOUNTS item=account}
                                            <tr>
                                                <td><a href="{$account.view_url}">
                                                    <b>{$account.username}</b></a>
                                                    <p>{$account.url_config}</p>
                                                </td>
                                                <td>{$account.full_name}</td>
                                                <td>{$account.email}</td>
                                                <td>{$account.created_userid}</td>
                                                <td>{$account.created_time}</td>
                                                <td class="text-right"><strong class="text-danger">{$account.money_total} {$account.money_unit}</strong></td>
                                                <td class="text-center">
                                                    <button type="button" class="btn btn-info btn-sm" onclick="loadAccountInfo('{$account.userid}', '{$account.username}')">
                                                        <i class="fa fa-fw fa-pencil"></i>{$LANG->getModule('editacount')}
                                                    </button>
                                                </td>
                                            </tr>
                                        {/foreach}
                                    {else}
                                    <tr>
                                        <td colspan="7" class="text-center"> 
                                            <p class="alert alert-warning">Không có dữ liệu</p>
                                        </td>
                                    </tr>
                                    {/if}
                                </tbody>
                                {if !empty($GENERATE_PAGE)}
                                    <tfoot>
                                        <tr>
                                            <td colspan="7">{$GENERATE_PAGE}</td>
                                        </tr>
                                    </tfoot>
                                {/if}
                            </table>
                        </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal Cập nhật tài khoản -->
<div class="modal fade" id="updateAccountModal" tabindex="-1" aria-labelledby="updateAccountModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="updateAccountModalLabel">Cập nhật tài khoản: <span id="account_username"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form method="post" method="post" onsubmit="nv_check_form_add(this);return false;" class="form-horizontal" id="form-update-account">
                    <input type="hidden" name="userid" id="userid" value="">
                    <div class="mb-3">
                        <label class="form-label"><strong>Nhập số tiền</strong></label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <select name="typeadd" class="form-select border-0 bg-transparent">
                                    <option value="+">+</option>
                                    <option value="-">-</option>
                                </select>
                            </span>
                            <input type="text" class="form-control" name="money" id="f_money" onkeyup="this.value=FormatNumber(this.value);" placeholder="Nhập số tiền">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Loại tiền tệ</strong></label>
                        <select class="form-control" name="typemoney" id="typemoney">
                            <option selected="selected" value="VND">VND</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Loại giao dịch</strong></label>
                        <select class="form-control" name="transaction_type" id="transaction_type">
                            <!-- <option value="0">Khởi tạo tài khoản</option> -->
                            <option value="1" selected="selected">Xử lí số liệu lệch</option>
                            <!-- <option value="2">Trả lại tiền</option> -->
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Thông báo ngoài site</strong></label>
                        <select class="form-select" id="status_tb" name="status_tb">
                            <option value="1">Có</option>
                            <option value="0">Không</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Ghi chú</strong></label>
                        <textarea class="form-control" rows="3" name="notice" id="notice"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                <button type="button" class="btn btn-primary" onclick="nv_check_form_add(document.getElementById('form-update-account'))">
                    Cập nhật
                </button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    // Khởi tạo DataTable chính
    let dataTable = $('#tbWallet').DataTable({
        paging: true,
        searching: true,
        info: true,
        "pageLength": 50,
        lengthChange: true,
        order: [[0, 'ASCS']], // Sắp xếp cột đầu tiên (ID) theo DESC
        language: {
            search: "Tìm kiếm:",
            lengthMenu: "Hiển thị _MENU_ dòng",
            info: "Đang xem từ _START_ đến _END_ của _TOTAL_ mục",
            paginate: {
                first: "Đầu",
                last: "Cuối",
                next: "Tiếp",
                previous: "Trước"
            }
        }
    });

    function loadAccountInfo(userid, username) {
        // Cập nhật thông tin vào modal
        $('#userid').val(userid);
        $('#account_username').text(username);

        // Reset form
        $('#form-update-account')[0].reset();

        // Mở modal
        var modal = new bootstrap.Modal(document.getElementById('updateAccountModal'));
        modal.show();
    }
</script>

