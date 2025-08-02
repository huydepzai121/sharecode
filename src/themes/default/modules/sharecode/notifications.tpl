<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="page-header d-flex justify-content-between align-items-center">
                <div>
                    <h2><i class="fa fa-bell text-info"></i> {LANG.my_notifications}</h2>
                    <p class="text-muted">
                        Tổng số: <strong>{TOTAL_NOTIFICATIONS}</strong> thông báo
                        <!-- BEGIN: unread_badge -->
                        | <span class="text-danger"><strong>{UNREAD_COUNT}</strong> chưa đọc</span>
                        <!-- END: unread_badge -->
                    </p>
                </div>
                
                <!-- BEGIN: mark_all_read -->
                <div>
                    <button type="button" class="btn btn-outline-primary btn-sm" id="mark-all-read">
                        <i class="fa fa-check-double"></i> {LANG.mark_all_read}
                    </button>
                </div>
                <!-- END: mark_all_read -->
            </div>

            <!-- BEGIN: notifications -->
            <div class="notification-list">
                <!-- BEGIN: item -->
                <div class="notification-item {ITEM.css_class}" data-id="{ITEM.id}">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="d-flex align-items-start">
                                <div class="notification-icon me-3">
                                    <i class="fa {ITEM.icon} fa-2x"></i>
                                </div>
                                
                                <div class="notification-content flex-grow-1">
                                    <h5 class="card-title mb-1">
                                        {ITEM.title}
                                        <!-- BEGIN: unread_dot -->
                                        <span class="badge bg-danger ms-2">Mới</span>
                                        <!-- END: unread_dot -->
                                    </h5>
                                    
                                    <!-- BEGIN: content -->
                                    <p class="card-text text-muted mb-2">{ITEM.content}</p>
                                    <!-- END: content -->
                                    
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="fa fa-clock-o"></i> {ITEM.add_time_format}
                                        </small>
                                        
                                        <div class="notification-actions">
                                            <!-- BEGIN: url -->
                                            <a href="{ITEM.url}" class="btn btn-sm btn-outline-primary me-2">
                                                <i class="fa fa-external-link"></i> Xem chi tiết
                                            </a>
                                            <!-- END: url -->
                                            
                                            <!-- BEGIN: mark_read_btn -->
                                            <button type="button" class="btn btn-sm btn-outline-success mark-read" 
                                                    data-id="{ITEM.id}" title="{LANG.mark_as_read}">
                                                <i class="fa fa-check"></i>
                                            </button>
                                            <!-- END: mark_read_btn -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: item -->
            </div>
            <!-- END: notifications -->

            <!-- BEGIN: no_notifications -->
            <div class="text-center py-5">
                <i class="fa fa-bell-slash-o fa-5x text-muted mb-3"></i>
                <h4 class="text-muted">{LANG.no_notifications}</h4>
                <p class="text-muted">Bạn sẽ nhận được thông báo khi có hoạt động mới!</p>
            </div>
            <!-- END: no_notifications -->

            <!-- BEGIN: pagination -->
            <div class="text-center mt-4">
                {PAGINATION}
            </div>
            <!-- END: pagination -->
        </div>
    </div>
</div>

<style>
.notification-item.unread {
    background: rgba(0, 123, 255, 0.1);
    border-left: 4px solid #007bff;
}

.notification-item.read {
    opacity: 0.7;
}

.notification-icon {
    width: 50px;
    text-align: center;
}

.notification-content {
    min-height: 50px;
}

@media (max-width: 768px) {
    .page-header {
        flex-direction: column;
        align-items: flex-start !important;
    }
    
    .page-header .btn {
        margin-top: 10px;
    }
    
    .notification-actions {
        flex-direction: column;
    }
    
    .notification-actions .btn {
        margin-bottom: 5px;
    }
}
</style>

<script>
$(document).ready(function() {
    // Xử lý đánh dấu đã đọc một thông báo
    $('.mark-read').click(function(e) {
        e.preventDefault();
        
        var notificationId = $(this).data('id');
        var button = $(this);
        var notificationItem = button.closest('.notification-item');
        
        $.post('{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=notifications', {
            ajax_mark_read: 1,
            notification_id: notificationId
        }, function(response) {
            if (response.status === 'success') {
                notificationItem.removeClass('unread').addClass('read');
                button.fadeOut();
                
                // Cập nhật số lượng unread
                var unreadCount = parseInt($('.text-danger strong').text()) || 0;
                if (unreadCount > 1) {
                    $('.text-danger strong').text(unreadCount - 1);
                } else {
                    $('.text-danger').parent().remove();
                    $('#mark-all-read').fadeOut();
                }
            } else {
                alert(response.message || 'Có lỗi xảy ra');
            }
        }, 'json').fail(function() {
            alert('Có lỗi xảy ra khi kết nối với máy chủ');
        });
    });
    
    // Xử lý đánh dấu tất cả đã đọc
    $('#mark-all-read').click(function(e) {
        e.preventDefault();
        
        if (confirm('Bạn có chắc muốn đánh dấu tất cả thông báo là đã đọc?')) {
            $.post('{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=notifications', {
                ajax_mark_all_read: 1
            }, function(response) {
                if (response.status === 'success') {
                    $('.notification-item.unread').removeClass('unread').addClass('read');
                    $('.mark-read').fadeOut();
                    $('.text-danger').parent().remove();
                    $('#mark-all-read').fadeOut();
                } else {
                    alert(response.message || 'Có lỗi xảy ra');
                }
            }, 'json').fail(function() {
                alert('Có lỗi xảy ra khi kết nối với máy chủ');
            });
        }
    });
    
    // Auto click vào link nếu có khi click vào notification item
    $('.notification-item').click(function(e) {
        if (!$(e.target).closest('.notification-actions').length) {
            var link = $(this).find('a[href]').first();
            if (link.length) {
                window.location.href = link.attr('href');
            }
        }
    });
});
</script>
<!-- END: main -->