/**
 * JavaScript xử lý reply comment cho ShareCode (Admin & User)
 */

$(document).ready(function () {
    // Xử lý click nút reply comment
    $(document).on('click', '.reply-btn', function () {
        var commentId = $(this).data('comment-id');
        var username = $(this).data('username');

        // Kiểm tra xem đã có form reply chưa
        var existingForm = $('#reply-form-' + commentId);
        if (existingForm.length > 0) {
            existingForm.toggle();
            return;
        }

        // Đóng tất cả form reply khác
        $('.reply-form').hide();

        // Xác định loại reply (admin hay user)
        var isAdmin = $('body').hasClass('admin-logged-in') || typeof admin_info !== 'undefined';
        var replyType = isAdmin ? 'admin' : 'user';
        var buttonText = isAdmin ? 'Gửi phản hồi admin' : 'Gửi trả lời';
        var headerText = isAdmin ? 'Trả lời bình luận của' : 'Trả lời bình luận của';

        // Tạo form reply mới
        var replyForm = `
            <div id="reply-form-${commentId}" class="reply-form mt-3" data-type="${replyType}">
                <div class="card">
                    <div class="card-header">
                        <h6 class="mb-0">
                            <i class="fa fa-reply"></i> ${headerText} ${username}
                        </h6>
                    </div>
                    <div class="card-body">
                        <textarea class="form-control" rows="4" placeholder="Nhập ${replyType === 'admin' ? 'phản hồi' : 'trả lời'} của bạn..." id="reply-content-${commentId}"></textarea>
                        <div class="mt-3">
                            <button type="button" class="btn btn-primary btn-sm" onclick="submitReply(${commentId}, '${replyType}')">
                                <i class="fa fa-paper-plane"></i> ${buttonText}
                            </button>
                            <button type="button" class="btn btn-secondary btn-sm" onclick="cancelReply(${commentId})">
                                <i class="fa fa-times"></i> Hủy
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;

        // Thêm form vào sau comment
        $(this).closest('.comment-item, .comment-content').after(replyForm);
    });
});

/**
 * Gửi reply (admin hoặc user)
 */
function submitReply(commentId, replyType) {
    var content = $('#reply-content-' + commentId).val().trim();

    if (!content) {
        if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
            nukeviet.toast('error', 'Vui lòng nhập nội dung!');
        } else {
            alert('Vui lòng nhập nội dung!');
        }
        return;
    }

    // Disable button để tránh spam
    var submitBtn = $('#reply-form-' + commentId + ' .btn-primary');
    var originalText = submitBtn.html();
    submitBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang gửi...');

    var postData = {
        submit_comment: 1,
        source_id: $('input[name="source_id"]').val() || getSourceIdFromUrl(),
        comment: content,
        parent_id: commentId // User reply sẽ dùng parent_id
    };

    // Nếu là admin reply, thêm reply_to_comment_id
    if (replyType === 'admin') {
        postData.reply_to_comment_id = commentId;
        postData.parent_id = 0; // Admin reply không dùng parent_id
    }

    $.ajax({
        url: window.location.href,
        type: 'POST',
        data: postData,
        dataType: 'json',
        success: function (response) {
            if (response.status === 'success') {
                if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                    nukeviet.toast('success', response.message);
                } else {
                    alert(response.message);
                }

                // Reload trang để hiển thị reply mới
                setTimeout(function () {
                    window.location.reload();
                }, 1000);
            } else {
                if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                    nukeviet.toast('error', response.message);
                } else {
                    alert(response.message);
                }

                // Re-enable button
                submitBtn.prop('disabled', false).html(originalText);
            }
        },
        error: function () {
            if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                nukeviet.toast('error', 'Có lỗi xảy ra khi gửi!');
            } else {
                alert('Có lỗi xảy ra khi gửi!');
            }

            // Re-enable button
            submitBtn.prop('disabled', false).html(originalText);
        }
    });
}

/**
 * Hủy reply
 */
function cancelReply(commentId) {
    $('#reply-form-' + commentId).remove();
}

/**
 * Lấy source ID từ URL (fallback)
 */
function getSourceIdFromUrl() {
    var urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('id') || 0;
}

/**
 * ===== ADMIN REPLY FOR REVIEWS =====
 */

$(document).ready(function () {
    // Admin reply cho reviews - Hiển thị form reply
    $(document).on('click', '.admin-reply-btn, .edit-admin-reply-btn', function (e) {
        e.preventDefault();
        var reviewId = $(this).data('review-id');
        var form = $('#admin-reply-form-' + reviewId);

        // Đóng tất cả form khác
        $('.admin-reply-form').hide();

        // Toggle form hiển thị
        form.toggle();

        // Focus vào textarea nếu form hiển thị
        if (form.is(':visible')) {
            form.find('textarea[name="admin_reply_content"]').focus();
        }
    });

    // Xử lý submit admin reply cho reviews
    $(document).on('submit', '.admin-review-reply-form', function (e) {
        e.preventDefault();
        var form = $(this);
        var reviewId = form.data('review-id');
        var content = form.find('textarea[name="admin_reply_content"]').val().trim();

        if (!content) {
            if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                nukeviet.toast('error', 'Vui lòng nhập nội dung phản hồi');
            } else {
                alert('Vui lòng nhập nội dung phản hồi');
            }
            return;
        }

        // Disable form để tránh spam
        var submitBtn = form.find('button[type="submit"]');
        var originalText = submitBtn.html();
        submitBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang gửi...');
        form.find('button').prop('disabled', true);

        $.ajax({
            url: window.location.href,
            type: 'POST',
            data: {
                admin_reply_review: 1,
                review_id: reviewId,
                admin_reply_content: content,
                checksess: form.find('input[name="checksess"]').val()
            },
            dataType: 'json',
            success: function (response) {
                if (response.status === 'success') {
                    if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                        nukeviet.toast('success', response.message);
                    } else {
                        alert(response.message);
                    }

                    // Reload trang để hiển thị reply mới
                    setTimeout(function () {
                        window.location.reload();
                    }, 1000);
                } else {
                    if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                        nukeviet.toast('error', response.message);
                    } else {
                        alert(response.message);
                    }

                    // Re-enable form
                    submitBtn.prop('disabled', false).html(originalText);
                    form.find('button').prop('disabled', false);
                }
            },
            error: function () {
                if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                    nukeviet.toast('error', 'Có lỗi xảy ra khi gửi phản hồi');
                } else {
                    alert('Có lỗi xảy ra khi gửi phản hồi');
                }

                // Re-enable form
                submitBtn.prop('disabled', false).html(originalText);
                form.find('button').prop('disabled', false);
            }
        });
    });

    // Hủy admin reply cho reviews
    $(document).on('click', '.cancel-admin-reply', function () {
        var reviewId = $(this).closest('.admin-review-reply-form').data('review-id');
        $('#admin-reply-form-' + reviewId).hide();
    });
});
