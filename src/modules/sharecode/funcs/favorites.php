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

// Yêu cầu đăng nhập để xem favorites
if (!defined('NV_IS_USER')) {
    $redirect_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=favorites';
    $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login&nv_redirect=' . nv_base64_encode($redirect_url);
    nv_redirect_location($login_url);
}

// AJAX: Thêm/xóa favorite
if ($nv_Request->isset_request('ajax_favorite', 'post')) {
    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    $action = $nv_Request->get_string('action', 'post', ''); // add hoặc remove
    
    $response = ['status' => 'error', 'message' => 'Có lỗi xảy ra'];
    
    if ($source_id > 0 && in_array($action, ['add', 'remove'])) {
        // Kiểm tra source tồn tại
        $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id . " AND status=1";
        if ($db->query($sql_check)->fetchColumn()) {
            try {
                if ($action == 'add') {
                    // Thêm vào favorites
                    $sql_insert = "INSERT IGNORE INTO " . NV_PREFIXLANG . "_" . $module_data . "_favorites (userid, source_id, add_time) VALUES (" . $user_info['userid'] . ", " . $source_id . ", " . NV_CURRENTTIME . ")";
                    if ($db->exec($sql_insert)) {
                        $response = ['status' => 'success', 'message' => 'Đã thêm vào yêu thích', 'action' => 'added'];
                    }
                } else {
                    // Xóa khỏi favorites
                    $sql_delete = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id;
                    if ($db->exec($sql_delete)) {
                        $response = ['status' => 'success', 'message' => 'Đã xóa khỏi yêu thích', 'action' => 'removed'];
                    }
                }
            } catch (Exception $e) {
                $response['message'] = 'Lỗi database: ' . $e->getMessage();
            }
        } else {
            $response['message'] = 'Sản phẩm không tồn tại';
        }
    } else {
        $response['message'] = 'Dữ liệu không hợp lệ';
    }
    
    nv_jsonOutput($response);
}

// Phân trang
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = $module_config['items_per_page'];
$offset = ($page - 1) * $per_page;

// Lấy tổng số favorites
$sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites WHERE userid=" . $user_info['userid'];
$total_favorites = $db->query($sql_count)->fetchColumn();

// Lấy danh sách favorites
$favorites = [];
if ($total_favorites > 0) {
    $sql = "SELECT f.*, s.* FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites f
            INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON f.source_id = s.id
            WHERE f.userid = " . $user_info['userid'] . " AND s.status = 1
            ORDER BY f.add_time DESC
            LIMIT " . $offset . ", " . $per_page;
    
    $result = $db->query($sql);
    while ($row = $result->fetch()) {
        // Format dữ liệu
        $row['add_time_format'] = nv_date('d/m/Y H:i', $row['add_time']);
        $row['detail_url'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['alias'], true);
        $row['price_text'] = ($row['fee_type'] == 'free') ? $lang_module['free'] : number_format($row['fee_amount']) . ' VND';
        
        $favorites[] = $row;
    }
}

// Tạo phân trang
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=favorites';
$generate_page = nv_generate_page($base_url, $total_favorites, $per_page, $page);

// Breadcrumb
$array_mod_title[] = [
    'title' => 'Sản phẩm yêu thích',
    'link' => $base_url
];

// SEO
$page_title = 'Sản phẩm yêu thích của tôi';
$key_words = 'yêu thích, bookmark, ' . $module_info['custom_title'];
$description = 'Danh sách các sản phẩm mã nguồn đã lưu vào yêu thích';

$contents = nv_theme_sharecode_favorites($favorites, $generate_page, $total_favorites);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';