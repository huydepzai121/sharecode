<div class="card">
    <div class="card-header">
        <h3 class="card-title">Quản lý Reviews ({$TOTAL} bản ghi)</h3>
    </div>
    
    <div class="card-body">
        <div class="row mb-3">
            <div class="col-12">
                <form class="row g-3" method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php">
                    <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}" />
                    <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}" />
                    <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="{$OP}" />
                    
                    <div class="col-md-6">
                        <input type="text" class="form-control" name="search" value="{$SEARCH}" placeholder="Tìm kiếm theo nội dung hoặc người dùng..." />
                    </div>

                    <div class="col-md-3">
                        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                    </div>
                </form>
            </div>
        </div>

        {if !empty($REVIEWS)}
        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 5%">ID</th>
                        <th style="width: 15%">Mã nguồn</th>
                        <th style="width: 12%">Người dùng</th>
                        <th style="width: 10%">Đánh giá</th>
                        <th style="width: 25%">Nội dung</th>
                        <th style="width: 20%">Admin Reply</th>
                        <th style="width: 10%">Thời gian</th>
                        <th style="width: 3%">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$REVIEWS item=review}
                    <tr id="review-{$review.id}">
                        <td>{$review.id}</td>
                        <td>
                            <a href="{$review.source_link}" target="_blank">{$review.source_title}</a>
                        </td>
                        <td>{$review.username}</td>
                        <td>
                            <span class="text-warning">{$review.rating_stars}</span>
                            <br><small>({$review.rating}/5)</small>
                        </td>
                        <td>
                            <div style="max-height: 100px; overflow-y: auto;">
                                <strong>{$review.title}</strong><br>
                                {$review.content}
                            </div>
                        </td>
                        <td>
                            {if $review.has_admin_reply}
                            <div class="admin-reply-display">
                                <div class="alert alert-info mb-2" style="padding: 8px; font-size: 12px;">
                                    <small><strong>{$review.admin_reply_username}</strong> - {$review.admin_reply_time_format}</small>
                                    <div>{$review.admin_reply}</div>
                                </div>
                                <button type="button" class="btn btn-sm btn-warning edit-reply-btn" data-id="{$review.id}">
                                    <i class="fa fa-edit"></i> Sửa
                                </button>
                            </div>
                            {else}
                            <button type="button" class="btn btn-sm btn-success add-reply-btn" data-id="{$review.id}">
                                <i class="fa fa-reply"></i> Trả lời
                            </button>
                            {/if}
                            
                            <div class="reply-form mt-2" id="reply-form-{$review.id}" style="display: none;">
                                <textarea class="form-control mb-2" rows="3" placeholder="Nhập phản hồi...">{$review.admin_reply}</textarea>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-sm btn-primary save-reply-btn" data-id="{$review.id}">
                                        <i class="fa fa-save"></i> Lưu
                                    </button>
                                    <button type="button" class="btn btn-sm btn-secondary cancel-reply-btn" data-id="{$review.id}">
                                        Hủy
                                    </button>
                                </div>
                            </div>
                        </td>
                        <td>
                            <small>{$review.created_time_format}</small>
                        </td>
                        <td>
                            <button type="button" class="btn btn-sm btn-danger delete-btn" data-id="{$review.id}" title="Xóa">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        {else}
        <div class="alert alert-info">
            <i class="fa fa-info-circle"></i> Không có review nào được tìm thấy.
        </div>
        {/if}
    </div>
    
    {if $GENERATE_PAGE}
    <div class="card-footer">
        {$GENERATE_PAGE}
    </div>
    {/if}
</div>

<script>
$(document).ready(function() {
    // Xử lý admin reply
    $(".add-reply-btn, .edit-reply-btn").click(function() {
        var reviewId = $(this).data("id");
        $("#reply-form-" + reviewId).show();
        $(this).hide();
    });
    
    $(".cancel-reply-btn").click(function() {
        var reviewId = $(this).data("id");
        $("#reply-form-" + reviewId).hide();
        $(".add-reply-btn[data-id='" + reviewId + "'], .edit-reply-btn[data-id='" + reviewId + "']").show();
    });
    
    $(".save-reply-btn").click(function() {
        var reviewId = $(this).data("id");
        var replyContent = $("#reply-form-" + reviewId + " textarea").val().trim();
        
        if (!replyContent) {
            alert("Vui lòng nhập nội dung phản hồi!");
            return;
        }
        
        $.ajax({
            url: "",
            type: "POST",
            data: {
                action: "admin_reply",
                review_id: reviewId,
                admin_reply: replyContent,
                checksess: "{$CHECKSESS}"
            },
            dataType: "json",
            success: function(response) {
                if (response.status === "success") {
                    alert(response.mess);
                    location.reload();
                } else {
                    alert(response.mess);
                }
            },
            error: function() {
                alert("Có lỗi xảy ra!");
            }
        });
    });
    
    // Bỏ chức năng thay đổi trạng thái vì giờ tự động approve
    
    // Xử lý xóa review
    $(".delete-btn").click(function() {
        var reviewId = $(this).data("id");
        
        if (confirm("Bạn có chắc chắn muốn xóa review này?")) {
            $.ajax({
                url: "",
                type: "POST",
                data: {
                    action: "delete",
                    id: reviewId,
                    checksess: "{$CHECKSESS}"
                },
                dataType: "json",
                success: function(response) {
                    if (response.status === "success") {
                        $("#review-" + reviewId).fadeOut();
                        alert(response.mess);
                    } else {
                        alert(response.mess);
                    }
                },
                error: function() {
                    alert("Có lỗi xảy ra!");
                }
            });
        }
    });
});
</script>
