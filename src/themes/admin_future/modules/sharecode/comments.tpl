
{* Quản lý bình luận ShareCode - Admin Future Theme *}

<div class="card">
    <div class="card-header text-bg-primary rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium"><i class="fa-solid fa-comments"></i> Quản lý bình luận</div>
    </div>
    
    <div class="card-body">
        <!-- Search Form -->
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" class="mb-4">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="{$OP}">
            
            <div class="row g-3 flex-xl-nowrap">
                <div class="col-md-6 flex-lg-fill">
                    <label for="element_source_id" class="form-label">Sản phẩm</label>
                    <select class="form-select select2" name="source_id" id="element_source_id">
                        {foreach from=$SOURCE_OPTIONS item=source}
                        <option value="{$source.value}"{if isset($SEARCH.source_id) and $source.value eq $SEARCH.source_id} selected{/if}>{$source.title}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-4 flex-lg-fill">
                    <label for="element_search" class="form-label">Tìm kiếm</label>
                    <input type="text" class="form-control" name="search" id="element_search" value="{if isset($SEARCH.search)}{$SEARCH.search}{/if}" placeholder="Tìm theo nội dung hoặc tên người dùng">
                </div>
                <div class="flex-grow-0 flex-shrink-1 w-auto">
                    <label for="submit_search" class="form-label d-none d-sm-block">&nbsp;</label>
                    <button id="submit_search" type="submit" class="btn btn-primary text-nowrap"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                </div>
                <div class="col-auto">
                    <label class="form-label d-none d-sm-block">&nbsp;</label>
                    <div class="text-muted">
                        Tổng số bình luận: <strong class="text-primary">{$TOTAL}</strong>
                    </div>
                </div>
            </div>
        </form>

        <!-- Comments Table -->
        {if $COMMENTS}
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="text-muted tableFloatingHeaderOriginal">
                    <tr>
                        <th class="text-nowrap" style="width: 1%;">
                            <input type="checkbox" class="form-check-input" id="checkAll">
                        </th>
                        <th class="text-nowrap" style="width: 15%;">Sản phẩm</th>
                        <th class="text-nowrap" style="width: 12%;">Người dùng</th>
                        <th class="text-nowrap" style="width: 35%;">Nội dung</th>
                        <th class="text-nowrap" style="width: 12%;">Ngày tạo</th>
                        <th class="text-nowrap" style="width: 15%;">Trả lời admin</th>
                        <th class="text-nowrap" style="width: 10%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody id="list-comments-items">
                    {foreach from=$COMMENTS item=comment}
                    <tr data-id="{$comment.id}">
                        <td>
                            <input type="checkbox" class="form-check-input item-checkbox" value="{$comment.id}">
                        </td>
                        <td>
                            <a href="{$comment.source_link}" target="_blank" class="text-decoration-none">
                                <strong>{$comment.source_title}</strong>
                            </a>
                        </td>
                        <td>
                            <div class="d-flex align-items-center">
                                <div>
                                    <div class="fw-medium">{$comment.username}</div>
                                    {if $comment.user_email}
                                    <small class="text-muted">{$comment.user_email}</small>
                                    {/if}
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="text-truncate-3" style="max-width: 350px;">
                                {$comment.content}
                            </div>
                        </td>
                        <td class="text-nowrap">{$comment.created_time_format}</td>
                        <td>
                            {if $comment.has_admin_reply}
                            <div class="text-success">
                                <i class="fa-solid fa-check-circle"></i> Đã trả lời
                                <br><small class="text-muted">bởi {$comment.admin_reply_username}</small>
                                <br><small class="text-muted">{$comment.admin_reply_time_format}</small>
                            </div>
                            {else}
                            <span class="text-muted">Chưa trả lời</span>
                            {/if}
                        </td>
                        <td>
                            <div class="btn-group" role="group">
                                <!-- <button type="button" class="btn btn-sm btn-info" data-toggle="replyComment" data-id="{$comment.id}" data-checksess="{$comment.checksess}" title="Trả lời">
                                    <i class="fa-solid fa-reply"></i>
                                </button> -->
                                <button type="button" class="btn btn-sm btn-danger" data-toggle="deleteComment" data-id="{$comment.id}" data-checksess="{$comment.checksess}" title="Xóa">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>

        <!-- Bulk Actions -->
        <div class="d-flex justify-content-between align-items-center mt-3">
            <div class="d-flex align-items-center">
                <div class="input-group me-1 my-1">
                    <select id="element_action" class="form-select fw-150" aria-label="Chọn thao tác" aria-describedby="element_action_btn">
                        <option value="delete">Xóa đã chọn</option>
                    </select>
                    <button class="btn btn-danger" type="button" id="element_action_btn" data-toggle="actionComment" data-ctn="#list-comments-items">Thực hiện</button>
                </div>
            </div>
            
            <!-- Pagination -->
            {if $GENERATE_PAGE}
            <div class="pagination-wrapper">
                {$GENERATE_PAGE}
            </div>
            {/if}
        </div>
        {else}
        <div class="text-center py-4">
            <div class="alert alert-info mb-0">
                <i class="fa-solid fa-info-circle"></i> Chưa có bình luận nào.
            </div>
        </div>
        {/if}
    </div>
</div>

<!-- Reply Modal -->
<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="replyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="replyModalLabel">Trả lời bình luận</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="replyForm">
                    <div class="mb-3">
                        <label for="replyContent" class="form-label">Nội dung trả lời</label>
                        <textarea class="form-control" id="replyContent" name="reply_content" rows="4" required></textarea>
                    </div>
                    <input type="hidden" id="replyCommentId" name="comment_id">
                    <input type="hidden" id="replyChecksess" name="checksess">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <button type="button" class="btn btn-primary" id="submitReply">Gửi trả lời</button>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Reply comment
    $('[data-toggle="replyComment"]').click(function() {
        var commentId = $(this).data('id');
        var checksess = $(this).data('checksess');
        
        $('#replyCommentId').val(commentId);
        $('#replyChecksess').val(checksess);
        $('#replyContent').val('');
        $('#replyModal').modal('show');
    });
    
    // Submit reply
    $('#submitReply').click(function() {
        var btn = $(this);
        var commentId = $('#replyCommentId').val();
        var checksess = $('#replyChecksess').val();
        var content = $('#replyContent').val().trim();
        
        if (!content) {
            alert('Vui lòng nhập nội dung trả lời');
            return;
        }
        
        btn.prop('disabled', true).text('Đang gửi...');
        
        $.ajax({
            url: location.href,
            type: 'POST',
            data: {
                action: 'reply',
                id: commentId,
                checksess: checksess,
                reply_content: content
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    alert(response.mess);
                    location.reload();
                } else {
                    alert('Lỗi: ' + response.mess);
                }
            },
            error: function() {
                alert('Có lỗi xảy ra, vui lòng thử lại!');
            },
            complete: function() {
                btn.prop('disabled', false).text('Gửi trả lời');
            }
        });
    });
    
    // Delete comment
    $('[data-toggle="deleteComment"]').click(function() {
        if (!confirm('Bạn có chắc chắn muốn xóa bình luận này?')) {
            return;
        }
        
        var commentId = $(this).data('id');
        var checksess = $(this).data('checksess');
        var row = $(this).closest('tr');
        
        $.ajax({
            url: location.href,
            type: 'POST',
            data: {
                action: 'delete',
                id: commentId,
                checksess: checksess
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    row.fadeOut(function() {
                        $(this).remove();
                    });
                } else {
                    alert('Lỗi: ' + response.mess);
                }
            },
            error: function() {
                alert('Có lỗi xảy ra, vui lòng thử lại!');
            }
        });
    });
    
    // Check all functionality
    $('#checkAll').change(function() {
        $('.item-checkbox').prop('checked', $(this).prop('checked'));
    });
    
    // Bulk actions
    $('#element_action_btn').click(function() {
        var action = $('#element_action').val();
        var checkedItems = $('.item-checkbox:checked');
        
        if (checkedItems.length === 0) {
            alert('Vui lòng chọn ít nhất một bình luận');
            return;
        }
        
        if (!confirm('Bạn có chắc chắn muốn thực hiện thao tác này?')) {
            return;
        }
        
        var ids = [];
        checkedItems.each(function() {
            ids.push($(this).val());
        });
        
        // Implement bulk delete
        if (action === 'delete') {
            // Process each delete individually for simplicity
            var processed = 0;
            var total = ids.length;
            
            ids.forEach(function(id) {
                $.ajax({
                    url: location.href,
                    type: 'POST',
                    data: {
                        action: 'delete',
                        id: id,
                        checksess: '{$smarty.const.NV_CHECK_SESSION}'
                    },
                    dataType: 'json',
                    success: function(response) {
                        processed++;
                        if (response.status === 'success') {
                            $('tr[data-id="' + id + '"]').fadeOut();
                        }
                        if (processed === total) {
                            setTimeout(function() {
                                location.reload();
                            }, 1000);
                        }
                    }
                });
            });
        }
    });
});
</script>
