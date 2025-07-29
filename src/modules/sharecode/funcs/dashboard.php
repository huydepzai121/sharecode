<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

// Yêu cầu đăng nhập
if (!defined('NV_IS_USER')) {
    $redirect_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=dashboard';
    $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login&nv_redirect=' . nv_base64_encode($redirect_url);
    nv_redirect_location($login_url);
}

// AJAX: Xóa sản phẩm
if ($nv_Request->isset_request('ajax_delete_source', 'post')) {
    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    
    $response = ['status' => 'error', 'message' => 'Có lỗi xảy ra'];
    
    if ($source_id > 0) {
        // Kiểm tra quyền sở hữu
        $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id . " AND userid=" . $user_info['userid'];
        if ($db->query($sql_check)->fetchColumn()) {
            try {
                $db->beginTransaction();
                
                // Xóa các liên kết tags
                $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_source_tags WHERE source_id=" . $source_id);
                
                // Xóa reviews
                $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews WHERE source_id=" . $source_id);
                
                // Xóa favorites
                $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites WHERE source_id=" . $source_id);
                
                // Xóa notifications
                $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_notifications WHERE source_id=" . $source_id);
                
                // Xóa logs
                $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_logs WHERE source_id=" . $source_id);
                
                // Xóa sản phẩm
                $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id);
                
                $db->commit();
                $response = ['status' => 'success', 'message' => 'Đã xóa sản phẩm thành công'];
            } catch (Exception $e) {
                $db->rollback();
                $response['message'] = 'Lỗi: ' . $e->getMessage();
            }
        } else {
            $response['message'] = 'Bạn không có quyền xóa sản phẩm này';
        }
    }
    
    nv_jsonOutput($response);
}

// Lấy thống kê user
$stats = [];

// Tổng số sản phẩm
$sql_total = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $user_info['userid'];
$stats['total_sources'] = $db->query($sql_total)->fetchColumn();

// Sản phẩm đã duyệt
$sql_approved = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $user_info['userid'] . " AND status=1";
$stats['approved_sources'] = $db->query($sql_approved)->fetchColumn();

// Sản phẩm chờ duyệt
$sql_pending = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $user_info['userid'] . " AND status=0";
$stats['pending_sources'] = $db->query($sql_pending)->fetchColumn();

// Tổng lượt xem
$sql_views = "SELECT SUM(num_view) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $user_info['userid'] . " AND status=1";
$stats['total_views'] = $db->query($sql_views)->fetchColumn() ?: 0;

// Tổng lượt tải
$sql_downloads = "SELECT SUM(num_download) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $user_info['userid'] . " AND status=1";
$stats['total_downloads'] = $db->query($sql_downloads)->fetchColumn() ?: 0;

// Số yêu thích
$stats['favorites_count'] = nv_sharecode_get_user_favorites_count($user_info['userid']);

// Số thông báo chưa đọc
$stats['unread_notifications'] = nv_sharecode_get_unread_notifications_count($user_info['userid']);

// Tổng doanh thu (nếu có)
$sql_revenue = "SELECT SUM(amount) FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p 
                INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id 
                WHERE s.userid=" . $user_info['userid'] . " AND p.status='completed'";
$stats['total_revenue'] = $db->query($sql_revenue)->fetchColumn() ?: 0;

// Lấy sản phẩm gần đây
$recent_sources = [];
$sql_recent = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources 
               WHERE userid=" . $user_info['userid'] . " 
               ORDER BY add_time DESC 
               LIMIT 5";
$result_recent = $db->query($sql_recent);
while ($row = $result_recent->fetch()) {
    $row['add_time_format'] = nv_date('d/m/Y H:i', $row['add_time']);
    $row['status_text'] = $row['status'] == 1 ? 'Đã duyệt' : 'Chờ duyệt';
    $row['status_class'] = $row['status'] == 1 ? 'success' : 'warning';
    $row['edit_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=submit&edit=' . $row['id'];
    $row['detail_url'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['alias'], true);
    
    $recent_sources[] = $row;
}

// Lấy đánh giá gần đây
$recent_reviews = [];
$sql_reviews = "SELECT r.*, s.title as source_title, s.alias as source_alias 
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
                INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON r.source_id = s.id
                WHERE s.userid=" . $user_info['userid'] . " 
                ORDER BY r.add_time DESC 
                LIMIT 5";
$result_reviews = $db->query($sql_reviews);
while ($row = $result_reviews->fetch()) {
    $row['add_time_format'] = nv_date('d/m/Y H:i', $row['add_time']);
    $row['source_url'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['source_alias'], true);
    
    $recent_reviews[] = $row;
}

// Breadcrumb
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=dashboard';
$array_mod_title[] = [
    'title' => 'Bảng điều khiển',
    'link' => $base_url
];

// SEO
$page_title = 'Bảng điều khiển - ' . $user_info['username'];
$key_words = 'dashboard, quản lý, ' . $module_info['custom_title'];
$description = 'Bảng điều khiển cá nhân để quản lý sản phẩm và hoạt động';

$contents = nv_theme_sharecode_dashboard($stats, $recent_sources, $recent_reviews, $user_info);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';