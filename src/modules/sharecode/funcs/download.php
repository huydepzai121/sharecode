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

$source_id = $nv_Request->get_int('id', 'get', 0);
$token = $nv_Request->get_title('token', 'get', '');

if ($source_id <= 0) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Lấy thông tin source
$sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id . " AND status=1";
$source = $db->query($sql)->fetch();

if (empty($source)) {
    nv_info_die($lang_global['error_404_title'], $lang_global['error_404_title'], 'Mã nguồn không tồn tại hoặc đã bị xóa', 404);
}

// Breadcrumb
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=download&id=' . $source_id;
$array_mod_title[] = [
    'title' => 'Tải xuống',
    'link' => nv_url_rewrite($base_url, true)
];

// Kiểm tra quyền download - CHỈ cho phép download nếu đã mua
if (!defined('NV_IS_USER')) {
    nv_info_die('Lỗi', 'Lỗi', 'Vui lòng đăng nhập để tải mã nguồn', 403);
}

// Kiểm tra đã mua chưa (cho cả miễn phí và có phí)
$sql = "SELECT id, purchase_time FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
        WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id . " AND status='completed'";
$purchase = $db->query($sql)->fetch();

if (!$purchase) {
    nv_info_die('Lỗi', 'Lỗi', 'Vui lòng thực hiện thanh toán trước khi tải xuống', 403);
}

// Token verification for direct downloads
$expected_token = md5($source_id . $user_info['userid'] . $global_config['sitekey'] . date('Ymd'));
if (empty($token) || $token !== $expected_token) {
    nv_info_die('Lỗi', 'Lỗi', 'Token không hợp lệ', 403);
}

// Xử lý download theo loại
if ($source['download_link_type'] == 'external') {
    // External link - redirect đến URL
    if (empty($source['download_link'])) {
        nv_info_die('Lỗi', 'Lỗi', 'Link tải xuống không hợp lệ', 404);
    }
    
    $download_url = $source['download_link'];
    // Kiểm tra và chuẩn hóa URL
    if (!preg_match('/^https?:\/\//', $download_url)) {
        $download_url = 'http://' . $download_url;
    }
    
    // Redirect đến external link
    header('Location: ' . $download_url);
    exit;
} else {
    // Internal file - force download
    $file_path = NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $source['file_path'];
    
    if (!file_exists($file_path)) {
        nv_info_die('Lỗi 404', 'File không tồn tại', 'File không tồn tại hoặc đã bị xóa', 404);
    }
    
    $file_name = !empty($source['file_name']) ? $source['file_name'] : basename($source['file_path']);
    
    // Security headers
    header('Content-Description: File Transfer');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename="' . $file_name . '"');
    header('Content-Transfer-Encoding: binary');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($file_path));
    
    // Clear output buffer
    if (ob_get_level()) {
        ob_end_clean();
    }
    
    // Read file và output
    readfile($file_path);
    exit;
}