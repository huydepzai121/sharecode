{if isset($SUCCESS_MESSAGE) and !empty($SUCCESS_MESSAGE)}
<div class="alert alert-success" role="alert"><i class="fa-solid fa-check-circle"></i> {$SUCCESS_MESSAGE}</div>
{/if}

{if isset($ERRORS) and !empty($ERRORS)}
<div class="alert alert-danger" role="alert">{$ERRORS|join:"<br />"}</div>
{/if}

<div class="card">
    <div class="card-header text-bg-primary rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium"><i class="fa-solid fa-comments"></i> Quản lý bình luận & đánh giá</div>
    </div>
    <div class="card-body">
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" id="form-search-reviews">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="reviews">

            <div class="row g-3 flex-xl-nowrap">
                <div class="col-md-6 flex-lg-fill">
                    <label for="element_source_id" class="form-label">Mã nguồn</label>
                    <select class="form-select select2" name="source_id" id="element_source_id">
                        {foreach from=$SOURCE_OPTIONS item=source}
                        <option value="{$source.value}" {if isset($SEARCH.source_id) and $source.value eq
                            $SEARCH.source_id} selected{/if}>{$source.title}</option>
                        {/foreach}
                    </select>
                </div>
                <div class="col-md-4 flex-lg-fill">
                    <label for="element_search" class="form-label">Tìm kiếm</label>
                    <input type="text" class="form-control" name="search" id="element_search"
                        value="{if isset($SEARCH.search)}{$SEARCH.search}{/if}"
                        placeholder="Tìm theo nội dung hoặc tên người dùng">
                </div>
                <div class="flex-grow-0 flex-shrink-1 w-auto">
                    <label for="submit_search" class="form-label d-none d-sm-block">&nbsp;</label>
                    <button id="submit_search" type="submit" class="btn btn-primary text-nowrap"><i
                            class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                </div>
                <div class="col-auto">
                    <label class="form-label d-none d-sm-block">&nbsp;</label>
                    <div class="text-muted">
                        Tổng số bình luận: <strong class="text-primary">{$TOTAL}</strong>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="card-body">

        <div class="table-responsive-lg table-card pb-1" id="list-reviews-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted tableFloatingHeaderOriginal">
                    <tr>
                        <th class="text-nowrap" style="width: 1%;">
                            <input type="checkbox" data-toggle="checkAll" name="checkAll[]"
                                class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                        </th>
                        <th class="text-nowrap" style="width: 5%;">ID</th>
                        <th class="text-nowrap" style="width: 25%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'source_title' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'asc'}&amp;of=source_title{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'source_title' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}"
                                class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Mã nguồn</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'source_title' or
                                empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq
                                'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i
                                    class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Mã nguồn</span>
                            {/if}
                        </th>
                        <th class="text-nowrap" style="width: 12%;">Người đánh giá</th>
                        <th class="text-nowrap text-center" style="width: 8%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'rating' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'desc'}&amp;of=rating{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'rating' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}"
                                class="d-flex align-items-center justify-content-center">
                                <span class="me-1">Điểm</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'rating' or
                                empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq
                                'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i
                                    class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Điểm</span>
                            {/if}
                        </th>
                        <th class="text-nowrap" style="width: 30%;">Nhận xét</th>
                        <th class="text-nowrap" style="width: 20%;">Admin Reply</th>
                        <th class="text-nowrap" style="width: 12%;">Ngày tạo</th>
                        <th class="text-nowrap text-center" style="width: 1%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {if isset($REVIEWS) and !empty($REVIEWS)}
                    {foreach from=$REVIEWS item=review}
                    <tr class="indicator-{$review.status_class}">
                        <td>
                            <input type="checkbox" data-toggle="checkSingle" name="checkSingle[]" value="{$review.id}"
                                class="form-check-input m-0 align-middle" aria-label="Chọn mục này">
                        </td>
                        <td class="text-center fw-medium">#{$review.id}</td>
                        <td>
                            <div class="text-truncate-2">
                                <strong><a href="{$review.source_link}" target="_blank"
                                        title="Xem mã nguồn">{$review.source_title}</a></strong>
                                {if $review.source_alias}<br><small
                                    class="text-muted">{$review.source_alias}</small>{/if}
                            </div>
                        </td>
                        <td>
                            <div class="fw-medium">{$review.username}</div>
                            {if $review.user_email}<small class="text-muted">{$review.user_email}</small>{/if}
                        </td>
                        <td class="text-center">
                            <div class="text-warning fw-medium">{$review.rating_stars}</div>
                            <small class="text-muted">({$review.rating}/5)</small>
                        </td>
                        <td>
                            <div class="text-truncate-3" style="max-width: 350px;">
                                {$review.content}
                            </div>
                        </td>
                        <td>
                            {if $review.has_admin_reply}
                            <div class="admin-reply-display">
                                <div class="alert alert-info mb-2" style="padding: 8px; font-size: 12px;">
                                    <small><strong>{$review.admin_reply_username}</strong> -
                                        {$review.admin_reply_time_format}</small>
                                    <div class="mt-1">{$review.admin_reply}</div>
                                </div>
                                <button type="button" class="btn btn-sm btn-warning edit-reply-btn"
                                    data-id="{$review.id}" title="Sửa phản hồi">
                                    <i class="fa-solid fa-edit"></i> Sửa
                                </button>
                            </div>
                            {else}
                            <button type="button" class="btn btn-sm btn-success add-reply-btn" data-id="{$review.id}"
                                title="Trả lời đánh giá">
                                <i class="fa-solid fa-reply"></i> Trả lời
                            </button>
                            {/if}

                            <!-- Form reply ẩn -->
                            <div class="reply-form mt-2" id="reply-form-{$review.id}" style="display: none;">
                                <textarea class="form-control mb-2" rows="3"
                                    placeholder="Nhập phản hồi của bạn...">{$review.admin_reply}</textarea>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-sm btn-primary save-reply-btn"
                                        data-id="{$review.id}">
                                        <i class="fa-solid fa-save"></i> Lưu
                                    </button>
                                    <button type="button" class="btn btn-sm btn-secondary cancel-reply-btn"
                                        data-id="{$review.id}">
                                        <i class="fa-solid fa-times"></i> Hủy
                                    </button>
                                </div>
                            </div>
                        </td>
                        <td class="text-nowrap">{$review.created_time_format}</td>
                        <td>
                            <button type="button" class="btn btn-sm btn-danger" data-toggle="deleteReview"
                                data-id="{$review.id}" data-checksess="{$review.checksess}" title="Xóa bình luận">
                                <i class="fa-solid fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                    {/foreach}
                    {else}
                    <tr>
                        <td colspan="8" class="text-center py-4">
                            <div class="alert alert-info mb-0">
                                <i class="fa-solid fa-info-circle"></i> Chưa có bình luận nào.
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
                    <input type="checkbox" data-toggle="checkAll" name="checkAll[]"
                        class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                </div>
                <div class="input-group me-1 my-1">
                    <select id="element_action" class="form-select fw-150" aria-label="Chọn thao tác"
                        aria-describedby="element_action_btn">
                        <option value="delete">Xóa đã chọn</option>
                    </select>
                    <button class="btn btn-danger" type="button" id="element_action_btn" data-toggle="actionReview"
                        data-ctn="#list-reviews-items">Thực hiện</button>
                </div>
            </div>
            <div class="pagination-wrap">
                {if isset($GENERATE_PAGE)}{$GENERATE_PAGE}{/if}
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Xử lý xóa review
        $('body').on('click', '[data-toggle="deleteReview"]', function (e) {
            e.preventDefault();
            var reviewId = $(this).data("id");
            var checksess = $(this).data("checksess");

            nukeviet.confirm("Bạn có chắc chắn muốn xóa bình luận này?", function () {
                $.ajax({
                    url: script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=reviews',
                    type: "POST",
                    data: {
                        action: "delete",
                        delete: 1,
                        id: reviewId,
                        checksess: checksess
                    },
                    dataType: "json",
                    success: function (response) {
                        if (response.status === "success") {
                            nvToast(response.mess, 'success');
                            setTimeout(function () {
                                location.reload();
                            }, 1000);
                        } else {
                            nvToast(response.mess, 'error');
                        }
                    },
                    error: function () {
                        nvToast("Có lỗi xảy ra khi xóa bình luận!", 'error');
                    }
                });
            });
        });

        // Xử lý xóa nhiều review
        $('body').on('click', '[data-toggle="actionReview"]', function (e) {
            e.preventDefault();
            var action = $('#element_action').val();
            var ctn = $($(this).data('ctn'));
            var listid = [];

            ctn.find('[data-toggle="checkSingle"]:checked').each(function () {
                listid.push($(this).val());
            });

            if (listid.length < 1) {
                nvToast("Vui lòng chọn ít nhất một bình luận để thực hiện thao tác!", 'warning');
                return;
            }

            if (action === 'delete') {
                nukeviet.confirm("Bạn có chắc chắn muốn xóa " + listid.length + " bình luận đã chọn?", function () {
                    $.ajax({
                        url: "",
                        type: "POST",
                        data: {
                            action: "delete_multiple",
                            ids: listid.join(','),
                            checksess: "{$CHECKSESS}"
                        },
                        dataType: "json",
                        success: function (response) {
                            if (response.status === "success") {
                                nvToast(response.mess, 'success');
                                setTimeout(function () {
                                    location.reload();
                                }, 1000);
                            } else {
                                nvToast(response.mess, 'error');
                            }
                        },
                        error: function () {
                            nvToast("Có lỗi xảy ra khi xóa bình luận!", 'error');
                        }
                    });
                });
            }
        });

        // Xử lý admin reply
        $('body').on('click', '.add-reply-btn, .edit-reply-btn', function (e) {
            e.preventDefault();
            var reviewId = $(this).data("id");
            $("#reply-form-" + reviewId).show();
            $(this).hide();
        });

        $('body').on('click', '.cancel-reply-btn', function (e) {
            e.preventDefault();
            var reviewId = $(this).data("id");
            $("#reply-form-" + reviewId).hide();
            $(".add-reply-btn[data-id='" + reviewId + "'], .edit-reply-btn[data-id='" + reviewId + "']").show();
        });

        $('body').on('click', '.save-reply-btn', function (e) {
            e.preventDefault();
            var reviewId = $(this).data("id");
            var replyContent = $("#reply-form-" + reviewId + " textarea").val().trim();

            if (!replyContent) {
                nvToast("Vui lòng nhập nội dung phản hồi!", 'warning');
                return;
            }

            var btn = $(this);
            var originalText = btn.html();
            btn.prop('disabled', true).html('<i class="fa-solid fa-spinner fa-spin"></i> Đang lưu...');

            $.ajax({
                url: script_name + '?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=reviews',
                type: "POST",
                data: {
                    action: "admin_reply",
                    review_id: reviewId,
                    admin_reply: replyContent,
                    checksess: "{$CHECKSESS}"
                },
                dataType: "json",
                success: function (response) {
                    if (response.status === "success") {
                        nvToast(response.mess, 'success');
                        setTimeout(function () {
                            location.reload();
                        }, 1000);
                    } else {
                        nvToast(response.mess, 'error');
                        btn.prop('disabled', false).html(originalText);
                    }
                },
                error: function () {
                    nvToast("Có lỗi xảy ra khi lưu phản hồi!", 'error');
                    btn.prop('disabled', false).html(originalText);
                }
            });
        });
    });
</script>