{if isset($SUCCESS_MESSAGE) and !empty($SUCCESS_MESSAGE)}
<div class="alert alert-success" role="alert"><i class="fa-solid fa-check-circle"></i> {$SUCCESS_MESSAGE}</div>
{/if}

{if isset($ERRORS) and !empty($ERRORS)}
<div class="alert alert-danger" role="alert">{$ERRORS|join:"<br />"}</div>
{/if}

<div class="card">
    <div class="card-header text-bg-primary rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium"><i class="fa-solid fa-history"></i> Nhật ký hoạt động</div>
        <div class="btn-group">
            <button type="button" class="btn btn-sm btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fa-solid fa-trash"></i> Xóa log cũ
            </button>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#" data-toggle="clearLogs" data-days="7"><i class="fa-solid fa-trash fa-fw text-center text-warning"></i> Xóa log > 7 ngày</a></li>
                <li><a class="dropdown-item" href="#" data-toggle="clearLogs" data-days="30"><i class="fa-solid fa-trash fa-fw text-center text-warning"></i> Xóa log > 30 ngày</a></li>
                <li><a class="dropdown-item" href="#" data-toggle="clearLogs" data-days="90"><i class="fa-solid fa-trash fa-fw text-center text-danger"></i> Xóa log > 90 ngày</a></li>
            </ul>
        </div>
    </div>
    <div class="card-body">
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" id="form-search-logs">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="logs">

            <div class="row g-3 flex-xl-nowrap">
                <div class="col-md-3 flex-lg-fill">
                    <label for="element_action" class="form-label">Loại hoạt động</label>
                    <select class="form-select" name="action_filter" id="element_action">
                        {foreach from=$ACTION_OPTIONS item=action}
                        <option value="{$action.value}"{if isset($SEARCH.action_filter) and $action.value eq $SEARCH.action_filter} selected{/if}>{$action.title}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-3 flex-lg-fill">
                    <label for="element_user" class="form-label">Người dùng</label>
                    <input type="text" class="form-control" name="user_filter" id="element_user" value="{if isset($SEARCH.user_filter)}{$SEARCH.user_filter}{/if}" placeholder="Tên người dùng">
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-2">
                    <label for="element_from_date" class="form-label">Từ ngày</label>
                    <input type="date" class="form-control" name="from_date" id="element_from_date" value="{if isset($SEARCH.from_date)}{$SEARCH.from_date}{/if}">
                </div>
                <div class="col-sm-auto flex-sm-grow-1 flex-sm-shrink-1 flex-xl-grow-0 flex-xl-shrink-0 col-xl-2">
                    <label for="element_to_date" class="form-label">Đến ngày</label>
                    <input type="date" class="form-control" name="to_date" id="element_to_date" value="{if isset($SEARCH.to_date)}{$SEARCH.to_date}{/if}">
                </div>
                <div class="flex-grow-0 flex-shrink-1 w-auto">
                    <label for="submit_search" class="form-label d-none d-sm-block">&nbsp;</label>
                    <button id="submit_search" type="submit" class="btn btn-primary text-nowrap"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                </div>
                <div class="col-auto">
                    <label class="form-label d-none d-sm-block">&nbsp;</label>
                    <div class="text-muted">
                        Tổng số log: <strong class="text-primary">{$TOTAL}</strong>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-body">

        <div class="table-responsive-lg table-card pb-1" id="list-logs-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted">
                    <tr>
                        <th class="text-nowrap" style="width: 1%;">
                            <input type="checkbox" data-toggle="checkAll" name="checkAll[]" class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                        </th>
                        <th class="text-nowrap" style="width: 5%;">ID</th>
                        <th class="text-nowrap" style="width: 12%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'username' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'asc'}&amp;of=username{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'username' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Người dùng</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'username' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Người dùng</span>
                            {/if}
                        </th>
                        <th class="text-nowrap" style="width: 12%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'action' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'asc'}&amp;of=action{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'action' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Hoạt động</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'action' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Hoạt động</span>
                            {/if}
                        </th>
                        <th class="text-nowrap" style="width: 40%;">Mô tả</th>
                        <th class="text-nowrap text-center" style="width: 10%;">IP</th>
                        <th class="text-nowrap" style="width: 15%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'created_time' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'desc'}&amp;of=created_time{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'created_time' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Thời gian</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'created_time' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Thời gian</span>
                            {/if}
                        </th>
                        <th class="text-nowrap text-center" style="width: 1%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {if isset($LOGS) and !empty($LOGS)}
                    {foreach from=$LOGS item=log}
                    <tr>
                        <td>
                            <input type="checkbox" data-toggle="checkSingle" name="checkSingle[]" value="{$log.id}" class="form-check-input m-0 align-middle" aria-label="Chọn mục này">
                        </td>
                        <td class="text-center fw-medium">#{$log.id}</td>
                        <td>
                            <div class="fw-medium">{$log.username}</div>
                            {if $log.userid}<small class="text-muted">ID: {$log.userid}</small>{/if}
                        </td>
                        <td>
                            <span class="badge bg-primary">{$log.action_text}</span>
                        </td>
                        <td>
                            <div class="text-truncate-3">
                                {$log.details}
                                {if $log.reference_link}
                                <br><a href="{$log.reference_link}" target="_blank" class="text-primary small">
                                    <i class="fa-solid fa-external-link"></i> {$log.reference_title}
                                </a>
                                {/if}
                            </div>
                        </td>
                        <td class="text-center">
                            <small class="text-muted">{$log.ip}</small>
                        </td>
                        <td class="text-nowrap">{$log.created_time_format}</td>
                        <td class="text-center">
                            <div class="input-group flex-nowrap">
                                <button type="button" class="btn btn-sm btn-secondary text-nowrap" data-toggle="deleteLog" data-id="{$log.id}" data-checksess="{$log.checksess}" title="Xóa">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                    {else}
                    <tr>
                        <td colspan="8" class="text-center py-4">
                            <div class="alert alert-info mb-0">
                                <i class="fa-solid fa-info-circle"></i> Chưa có nhật ký hoạt động nào.
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
                        <option value="delete">Xóa đã chọn</option>
                    </select>
                    <button class="btn btn-primary" type="button" id="element_action_btn" data-toggle="actionLog" data-ctn="#list-logs-items">Thực hiện</button>
                </div>
            </div>
            <div class="pagination-wrap">
                {if isset($GENERATE_PAGE)}{$GENERATE_PAGE}{/if}
            </div>
        </div>
    </div>
</div>

