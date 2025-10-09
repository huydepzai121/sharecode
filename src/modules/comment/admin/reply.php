<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    exit('Stop!!!');
}

$page_title = 'Trả lời bình luận';

// Xử lý AJAX reply comment
if ($nv_Request->isset_request('action', 'post')) {
    $action = $nv_Request->get_title('action', 'post', '');
    $cid = $nv_Request->get_int('cid', 'post', 0);
    
    if ($action == 'admin_reply' && $cid > 0) {
        $checksess = $nv_Request->get_title('checksess', 'post', '');
        $reply_content = $nv_Request->get_textarea('reply_content', '', 'post');
        
        if ($checksess == NV_CHECK_SESSION && !empty($reply_content)) {
            // Lấy thông tin comment hiện tại
            $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . " WHERE cid = " . $cid;
            $comment = $db->query($sql)->fetch();
            
            if ($comment) {
                // Xử lý admin reply (JSON conversation format)
                $current_replies = [];
                if (!empty($comment['admin_reply'])) {
                    $current_replies = json_decode($comment['admin_reply'], true);
                    if (!is_array($current_replies)) {
                        $current_replies = [];
                    }
                }
                
                // Thêm reply mới
                $new_reply = [
                    'content' => $reply_content,
                    'admin_username' => $admin_info['username'],
                    'admin_name' => nv_show_name_user($admin_info['first_name'], $admin_info['last_name']),
                    'time' => NV_CURRENTTIME,
                    'admin_id' => $admin_info['admin_id']
                ];
                
                $current_replies[] = $new_reply;
                
                // Cập nhật database
                $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . " 
                        SET admin_reply = " . $db->quote(json_encode($current_replies, JSON_UNESCAPED_UNICODE)) . ",
                            admin_reply_time = " . NV_CURRENTTIME . ",
                            admin_reply_userid = " . $admin_info['admin_id'] . "
                        WHERE cid = " . $cid;
                
                if ($db->exec($sql)) {
                    nv_jsonOutput([
                        'status' => 'success',
                        'message' => 'Trả lời bình luận thành công!',
                        'reply_html' => nv_format_admin_reply($current_replies)
                    ]);
                } else {
                    nv_jsonOutput([
                        'status' => 'error',
                        'message' => 'Có lỗi xảy ra khi lưu phản hồi'
                    ]);
                }
            } else {
                nv_jsonOutput([
                    'status' => 'error',
                    'message' => 'Không tìm thấy bình luận'
                ]);
            }
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'message' => 'Dữ liệu không hợp lệ'
            ]);
        }
    }
}

/**
 * Format admin reply để hiển thị
 */
function nv_format_admin_reply($replies) {
    if (empty($replies) || !is_array($replies)) {
        return '';
    }
    
    $html = '<div class="admin-replies mt-3">';
    foreach ($replies as $reply) {
        $time = !empty($reply['time']) ? nv_date('H:i d/m/Y', $reply['time']) : '';
        $admin_name = !empty($reply['admin_name']) ? $reply['admin_name'] : $reply['admin_username'];
        
        $html .= '<div class="admin-reply-item border-left border-primary pl-3 mb-2">';
        $html .= '<div class="admin-reply-header">';
        $html .= '<strong class="text-primary"><i class="fa fa-shield"></i> ' . $admin_name . '</strong>';
        $html .= '<small class="text-muted ml-2">' . $time . '</small>';
        $html .= '</div>';
        $html .= '<div class="admin-reply-content mt-1">' . nl2br(nv_htmlspecialchars($reply['content'])) . '</div>';
        $html .= '</div>';
    }
    $html .= '</div>';
    
    return $html;
}

// Redirect về trang chính nếu không phải AJAX
nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
