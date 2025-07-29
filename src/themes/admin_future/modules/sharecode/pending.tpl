<link type="text/css" href="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet">
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>
<script src="{$smarty.const.ASSETS_STATIC_URL}/js/select2/i18n/{$smarty.const.NV_LANG_INTERFACE}.js"></script>
<script type="text/javascript" src="{$smarty.const.ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>

<div class="page-header">
    <h1>{$LANG->getModule('admin_pending')} <small class="text-muted">({$TOTAL_ITEMS} sản phẩm)</small></h1>
</div>

{* Search Form *}
<div class="card mb-4">
    <div class="card-header">
        <h5 class="mb-0"><i class="fa fa-search"></i> Tìm kiếm & Lọc</h5>
    </div>
    <div class="card-body">
        <form method="get" action="{$BASE_URL}" class="row g-3">
            <div class="col-md-3">
                <label class="form-label">Từ khóa</label>
                <input type="text" name="q" value="{$SEARCH.q}" class="form-control" placeholder="Tìm theo tên, mô tả...">
            </div>
            <div class="col-md-2">
                <label class="form-label">Danh mục</label>
                <select name="catid" class="form-select">
                    <option value="0">Tất cả danh mục</option>
                    {foreach $CATEGORIES as $cat}
                    <option value="{$cat.id}" {if $SEARCH.catid == $cat.id}selected{/if}>{$cat.title}</option>
                    {/foreach}
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label">Loại giá</label>
                <select name="fee_type" class="form-select">
                    <option value="">Tất cả</option>
                    <option value="free" {if $SEARCH.fee_type == 'free'}selected{/if}>Miễn phí</option>
                    <option value="paid" {if $SEARCH.fee_type == 'paid'}selected{/if}>Có phí</option>
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label">User ID</label>
                <input type="number" name="userid" value="{$SEARCH.userid}" class="form-control" placeholder="ID người dùng">
            </div>
            <div class="col-md-3">
                <label class="form-label">&nbsp;</label>
                <div class="d-flex gap-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-search"></i> Tìm kiếm
                    </button>
                    <a href="{$BASE_URL}" class="btn btn-outline-secondary">
                        <i class="fa fa-refresh"></i> Reset
                    </a>
                </div>
            </div>
        </form>
    </div>
</div>

{* Results Table *}
<div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
        <h5 class="mb-0">
            <i class="fa fa-list"></i> Danh sách sản phẩm chờ duyệt
            <span class="badge bg-warning ms-2">{$TOTAL_ITEMS}</span>
        </h5>
        <div class="btn-group">
            <button type="button" class="btn btn-sm btn-outline-success" onclick="bulkApprove()">
                <i class="fa fa-check"></i> Duyệt hàng loạt
            </button>
            <button type="button" class="btn btn-sm btn-outline-danger" onclick="bulkReject()">
                <i class="fa fa-times"></i> Từ chối hàng loạt
            </button>
        </div>
    </div>
    
    <div class="card-body p-0">
        {if $SOURCES}
        <div class="table-responsive">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-dark">
                    <tr>
                        <th width="40">
                            <input type="checkbox" id="check-all" class="form-check-input">
                        </th>
                        <th width="60">ID</th>
                        <th>Tiêu đề</th>
                        <th width="150">Danh mục</th>
                        <th width="120">Tác giả</th>
                        <th width="100">Loại</th>
                        <th width="120">Ngày gửi</th>
                        <th width="180">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $SOURCES as $source}
                    <tr id="row-{$source.id}">
                        <td>
                            <input type="checkbox" name="selected_ids[]" value="{$source.id}" class="form-check-input source-checkbox">
                        </td>
                        <td><strong>#{$source.id}</strong></td>
                        <td>
                            <div class="fw-bold">{$source.title}</div>
                            <div class="text-muted small">{$source.description|truncate:80}</div>
                            {if $source.keywords_array}
                            <div class="mt-1">
                                {foreach $source.keywords_array as $keyword}
                                <span class="badge bg-light text-dark me-1">{$keyword}</span>
                                {/foreach}
                            </div>
                            {/if}
                        </td>
                        <td>
                            <span class="badge bg-info">{$source.category_title|default:'Chưa phân loại'}</span>
                        </td>
                        <td>
                            <div class="fw-bold">{$source.username}</div>
                            <small class="text-muted">ID: {$source.userid}</small>
                        </td>
                        <td>
                            {if $source.fee_type == 'free'}
                            <span class="badge bg-success">Miễn phí</span>
                            {else}
                            <span class="badge bg-warning">{$source.price_format}</span>
                            {/if}
                        </td>
                        <td>
                            <div>{$source.add_time_format}</div>
                            <small class="text-muted">{$source.add_time_hour}</small>
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-sm btn-outline-info" onclick="viewSource({$source.id})" title="Xem chi tiết">
                                    <i class="fa fa-eye"></i>
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-success" onclick="approveSource({$source.id})" title="Phê duyệt">
                                    <i class="fa fa-check"></i>
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="rejectSource({$source.id})" title="Từ chối">
                                    <i class="fa fa-times"></i>
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
            <i class="fa fa-inbox fa-4x text-muted mb-3"></i>
            <h4 class="text-muted">Không có sản phẩm nào chờ duyệt</h4>
            <p class="text-muted">Tất cả sản phẩm đã được xử lý hoặc chưa có sản phẩm mới nào.</p>
        </div>
        {/if}
    </div>
    
    {if $GENERATE_PAGE}
    <div class="card-footer">
        <div class="d-flex justify-content-between align-items-center">
            <div class="text-muted">
                Hiển thị từ {$START_ITEM} đến {$END_ITEM} trong tổng số {$TOTAL_ITEMS} sản phẩm
            </div>
            <div>
                {$GENERATE_PAGE}
            </div>
        </div>
    </div>
    {/if}
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
                    <textarea id="approveNote" class="form-control" rows="3" placeholder="Nhập ghi chú sẽ được gửi đến tác giả..."></textarea>
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
                    <textarea id="rejectNote" class="form-control" rows="3" placeholder="Nhập lý do từ chối để gửi đến tác giả..." required></textarea>
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
$(document).ready(function() {
    var currentSourceId = 0;
    
    // Check all functionality
    $('#check-all').change(function() {
        $('.source-checkbox').prop('checked', $(this).prop('checked'));
    });
    
    $('.source-checkbox').change(function() {
        var allChecked = $('.source-checkbox:checked').length === $('.source-checkbox').length;
        $('#check-all').prop('checked', allChecked);
    });
    
    // View source details
    window.viewSource = function(id) {
        $('#sourceDetailModal').modal('show');
        
        $.get('{$BASE_URL}&action=view&id=' + id, function(data) {
            $('#sourceDetailContent').html(data);
        }).fail(function() {
            $('#sourceDetailContent').html('<div class="alert alert-danger">Không thể tải thông tin sản phẩm</div>');
        });
    };
    
    // Approve source
    window.approveSource = function(id) {
        currentSourceId = id;
        $('#approveNote').val('');
        $('#approveModal').modal('show');
    };
    
    window.confirmApprove = function() {
        var note = $('#approveNote').val();
        
        $.post('{$BASE_URL}&action=approve&id=' + currentSourceId, {
            checksess: '{$CHECKSESS}' + currentSourceId,
            note: note
        }, function(response) {
            if (response.status === 'OK') {
                $('#approveModal').modal('hide');
                $('#row-' + currentSourceId).fadeOut(300, function() {
                    $(this).remove();
                    updateCounts();
                });
                toastr.success(response.mess);
            } else {
                toastr.error(response.mess);
            }
        }, 'json').fail(function() {
            toastr.error('Có lỗi xảy ra khi kết nối với máy chủ');
        });
    };
    
    // Reject source
    window.rejectSource = function(id) {
        currentSourceId = id;
        $('#rejectNote').val('');
        $('#rejectModal').modal('show');
    };
    
    window.confirmReject = function() {
        var note = $('#rejectNote').val();
        
        if (!note.trim()) {
            toastr.error('Vui lòng nhập lý do từ chối');
            return;
        }
        
        $.post('{$BASE_URL}&action=reject&id=' + currentSourceId, {
            checksess: '{$CHECKSESS}' + currentSourceId,
            note: note
        }, function(response) {
            if (response.status === 'OK') {
                $('#rejectModal').modal('hide');
                $('#row-' + currentSourceId).fadeOut(300, function() {
                    $(this).remove();
                    updateCounts();
                });
                toastr.success(response.mess);
            } else {
                toastr.error(response.mess);
            }
        }, 'json').fail(function() {
            toastr.error('Có lỗi xảy ra khi kết nối với máy chủ');
        });
    };
    
    // Bulk operations
    window.bulkApprove = function() {
        var selected = $('.source-checkbox:checked').map(function() {
            return $(this).val();
        }).get();
        
        if (selected.length === 0) {
            toastr.warning('Vui lòng chọn ít nhất một sản phẩm');
            return;
        }
        
        if (confirm('Bạn có chắc muốn phê duyệt ' + selected.length + ' sản phẩm đã chọn?')) {
            var completed = 0;
            var total = selected.length;
            
            selected.forEach(function(id) {
                $.post('{$BASE_URL}&action=approve&id=' + id, {
                    checksess: '{$CHECKSESS}' + id,
                    note: 'Phê duyệt hàng loạt'
                }, function(response) {
                    completed++;
                    if (response.status === 'OK') {
                        $('#row-' + id).fadeOut(300, function() {
                            $(this).remove();
                        });
                    }
                    
                    if (completed === total) {
                        toastr.success('Đã hoàn thành xử lý hàng loạt');
                        updateCounts();
                        $('#check-all').prop('checked', false);
                    }
                }, 'json');
            });
        }
    };
    
    window.bulkReject = function() {
        var selected = $('.source-checkbox:checked').map(function() {
            return $(this).val();
        }).get();
        
        if (selected.length === 0) {
            toastr.warning('Vui lòng chọn ít nhất một sản phẩm');
            return;
        }
        
        var reason = prompt('Nhập lý do từ chối (sẽ áp dụng cho tất cả sản phẩm đã chọn):');
        if (!reason) return;
        
        if (confirm('Bạn có chắc muốn từ chối ' + selected.length + ' sản phẩm đã chọn?')) {
            var completed = 0;
            var total = selected.length;
            
            selected.forEach(function(id) {
                $.post('{$BASE_URL}&action=reject&id=' + id, {
                    checksess: '{$CHECKSESS}' + id,
                    note: reason
                }, function(response) {
                    completed++;
                    if (response.status === 'OK') {
                        $('#row-' + id).fadeOut(300, function() {
                            $(this).remove();
                        });
                    }
                    
                    if (completed === total) {
                        toastr.success('Đã hoàn thành xử lý hàng loạt');
                        updateCounts();
                        $('#check-all').prop('checked', false);
                    }
                }, 'json');
            });
        }
    };
    
    function updateCounts() {
        setTimeout(function() {
            var remainingRows = $('tbody tr').length;
            $('.badge').text(remainingRows);
            
            if (remainingRows === 0) {
                $('tbody').html('<tr><td colspan="8" class="text-center py-4"><i class="fa fa-check-circle fa-3x text-success mb-2"></i><br>Đã xử lý hết tất cả sản phẩm chờ duyệt!</td></tr>');
            }
        }, 500);
    }
});
</script>