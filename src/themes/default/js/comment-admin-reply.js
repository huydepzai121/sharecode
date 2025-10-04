/**
 * JavaScript xử lý Admin Reply Comment cho NukeViet
 * Tương thích với quyền NV_IS_ADMIN
 */

$(document).ready(function() {
    // Kiểm tra quyền admin
    var isAdmin = $('body').hasClass('admin-logged-in') || 
                  typeof admin_info !== 'undefined' || 
                  $('.admin-reply-btn').length > 0;
    
    if (!isAdmin) {
        return; // Không phải admin thì không load script
    }
    
    // Xử lý click nút admin reply
    $(document).on('click', '.admin-reply-btn', function(e) {
        e.preventDefault();
        
        var commentId = $(this).data('comment-id');
        var commentContainer = $(this).closest('.comment-item');
        
        // Kiểm tra xem đã có form reply chưa
        var existingForm = commentContainer.find('.admin-reply-form');
        if (existingForm.length > 0) {
            existingForm.toggle();
            return;
        }
        
        // Đóng tất cả form reply khác
        $('.admin-reply-form').hide();
        
        // Tạo form reply mới
        var replyForm = createAdminReplyForm(commentId);
        commentContainer.append(replyForm);
        
        // Focus vào textarea
        $('#admin-reply-content-' + commentId).focus();
    });
    
    // Xử lý hủy reply
    $(document).on('click', '.cancel-admin-reply', function(e) {
        e.preventDefault();
        $(this).closest('.admin-reply-form').hide();
    });
    
    // Xử lý submit reply
    $(document).on('click', '.submit-admin-reply', function(e) {
        e.preventDefault();
        
        var commentId = $(this).data('comment-id');
        var content = $('#admin-reply-content-' + commentId).val().trim();
        
        if (!content) {
            showMessage('error', 'Vui lòng nhập nội dung phản hồi!');
            return;
        }
        
        submitAdminReply(commentId, content);
    });
    
    // Xử lý Enter + Ctrl để submit
    $(document).on('keydown', '.admin-reply-textarea', function(e) {
        if (e.ctrlKey && e.keyCode === 13) {
            var commentId = $(this).data('comment-id');
            var submitBtn = $('.submit-admin-reply[data-comment-id="' + commentId + '"]');
            submitBtn.click();
        }
    });
});

/**
 * Tạo form admin reply
 */
function createAdminReplyForm(commentId) {
    return `
        <div class="admin-reply-form mt-3" style="display: block;">
            <div class="card border-primary">
                <div class="card-header bg-primary text-white py-2">
                    <h6 class="mb-0">
                        <i class="fa fa-shield"></i> Phản hồi Admin
                    </h6>
                </div>
                <div class="card-body">
                    <textarea 
                        class="form-control admin-reply-textarea" 
                        id="admin-reply-content-${commentId}"
                        data-comment-id="${commentId}"
                        rows="4" 
                        placeholder="Nhập phản hồi của bạn với tư cách Admin...">
                    </textarea>
                    <div class="mt-3">
                        <button type="button" 
                                class="btn btn-primary btn-sm submit-admin-reply" 
                                data-comment-id="${commentId}">
                            <i class="fa fa-paper-plane"></i> Gửi phản hồi
                        </button>
                        <button type="button" class="btn btn-secondary btn-sm cancel-admin-reply">
                            <i class="fa fa-times"></i> Hủy
                        </button>
                        <small class="text-muted ml-3">
                            <i class="fa fa-info-circle"></i> Nhấn Ctrl + Enter để gửi nhanh
                        </small>
                    </div>
                </div>
            </div>
        </div>
    `;
}

/**
 * Gửi admin reply
 */
function submitAdminReply(commentId, content) {
    var submitBtn = $('.submit-admin-reply[data-comment-id="' + commentId + '"]');
    var originalText = submitBtn.html();
    
    // Disable button và hiển thị loading
    submitBtn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang gửi...');
    
    $.ajax({
        url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=comment&' + nv_fc_variable + '=reply',
        type: 'POST',
        dataType: 'json',
        data: {
            action: 'admin_reply',
            cid: commentId,
            reply_content: content,
            checksess: nv_check_session
        },
        success: function(response) {
            if (response.status === 'success') {
                showMessage('success', response.message);
                
                // Cập nhật hiển thị reply
                var commentContainer = $('.admin-reply-form').closest('.comment-item');
                var existingReplies = commentContainer.find('.admin-replies');
                
                if (existingReplies.length > 0) {
                    existingReplies.replaceWith(response.reply_html);
                } else {
                    commentContainer.find('.comment-content').after(response.reply_html);
                }
                
                // Ẩn form reply
                $('.admin-reply-form').hide();
                
                // Reset form
                $('#admin-reply-content-' + commentId).val('');
                
            } else {
                showMessage('error', response.message || 'Có lỗi xảy ra khi gửi phản hồi');
            }
        },
        error: function() {
            showMessage('error', 'Có lỗi xảy ra khi kết nối server');
        },
        complete: function() {
            // Restore button
            submitBtn.prop('disabled', false).html(originalText);
        }
    });
}

/**
 * Hiển thị thông báo
 */
function showMessage(type, message) {
    if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
        nukeviet.toast(type, message);
    } else if (typeof toastr !== 'undefined') {
        toastr[type](message);
    } else {
        alert(message);
    }
}
