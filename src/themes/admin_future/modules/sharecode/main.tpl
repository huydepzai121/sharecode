<div class="page-header">
    <h1><i class="fa fa-dashboard"></i> {$LANG->getModule('admin_main')} <small class="text-muted">Tổng quan hệ thống</small></h1>
</div>

{* Statistics Cards *}
<div class="row mb-4">
    <div class="col-md-3">
        <div class="card text-bg-primary">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="card-title mb-1">{$STATS.total_sources}</h5>
                        <p class="card-text">Tổng mã nguồn</p>
                    </div>
                    <div class="text-primary-emphasis">
                        <i class="fa fa-code fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-bg-success">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="card-title mb-1">{$STATS.active_sources}</h5>
                        <p class="card-text">Đã phê duyệt</p>
                    </div>
                    <div class="text-success-emphasis">
                        <i class="fa fa-check-circle fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-bg-warning">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="card-title mb-1">{$STATS.pending_sources}</h5>
                        <p class="card-text">Chờ phê duyệt</p>
                    </div>
                    <div class="text-warning-emphasis">
                        <i class="fa fa-clock-o fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card text-bg-info">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5 class="card-title mb-1">{$STATS.total_categories}</h5>
                        <p class="card-text">Danh mục</p>
                    </div>
                    <div class="text-info-emphasis">
                        <i class="fa fa-folder fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row mb-4">
    <div class="col-md-3">
        <div class="card border-primary">
            <div class="card-body text-center">
                <h4 class="text-primary">{$STATS.total_views}</h4>
                <p class="card-text">Tổng lượt xem</p>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card border-success">
            <div class="card-body text-center">
                <h4 class="text-success">{$STATS.total_downloads}</h4>
                <p class="card-text">Tổng lượt tải</p>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card border-info">
            <div class="card-body text-center">
                <h4 class="text-info">{$STATS.total_reviews}</h4>
                <p class="card-text">Tổng đánh giá</p>
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card border-warning">
            <div class="card-body text-center">
                <h4 class="text-warning">{$STATS.total_revenue|number_format} VNĐ</h4>
                <p class="card-text">Tổng doanh thu</p>
            </div>
        </div>
    </div>
</div>

{* Quick Actions *}
<div class="card mb-4">
    <div class="card-header">
        <h5 class="mb-0"><i class="fa fa-bolt"></i> Thao tác nhanh</h5>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-3 mb-3">
                <a href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}=sources&action=add" class="btn btn-success w-100">
                    <i class="fa fa-plus"></i> Thêm mã nguồn mới
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}=pending" class="btn btn-warning w-100">
                    <i class="fa fa-check"></i> Duyệt mã nguồn
                    {if $STATS.pending_sources > 0}
                    <span class="badge bg-danger ms-1">{$STATS.pending_sources}</span>
                    {/if}
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}=categories" class="btn btn-info w-100">
                    <i class="fa fa-folder"></i> Quản lý danh mục
                </a>
            </div>
            <div class="col-md-3 mb-3">
                <a href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}=config" class="btn btn-secondary w-100">
                    <i class="fa fa-cog"></i> Cấu hình
                </a>
            </div>
        </div>
    </div>
</div>

{* Recent Sources *}
<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0"><i class="fa fa-list"></i> Mã nguồn mới nhất</h5>
        <a href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}=sources" class="btn btn-sm btn-outline-primary">
            <i class="fa fa-eye"></i> Xem tất cả
        </a>
    </div>
    <div class="card-body">
        {if $SOURCES}
        <div class="table-responsive">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th width="50">ID</th>
                        <th>Tiêu đề</th>
                        <th width="120">Loại phí</th>
                        <th width="100">Lượt xem</th>
                        <th width="100">Lượt tải</th>
                        <th width="120">Trạng thái</th>
                        <th width="150">Ngày tạo</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $SOURCES as $source}
                    <tr>
                        <td><strong>#{$source.id}</strong></td>
                        <td>
                            <div class="fw-bold">{$source.title}</div>
                            {if $source.description}
                            <small class="text-muted">{$source.description|truncate:60}</small>
                            {/if}
                        </td>
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
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        {else}
        <div class="text-center py-4">
            <i class="fa fa-inbox fa-3x text-muted mb-3"></i>
            <h4 class="text-muted">Chưa có mã nguồn nào</h4>
            <p class="text-muted">Hãy thêm mã nguồn đầu tiên cho hệ thống.</p>
            <a href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}=sources&action=add" class="btn btn-primary">
                <i class="fa fa-plus"></i> Thêm mã nguồn mới
            </a>
        </div>
        {/if}
    </div>
</div>
