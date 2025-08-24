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

$page_title = 'Nhật ký hoạt động';

$action = $nv_Request->get_title('action', 'get', '');
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 50;

// Xử lý AJAX requests
if ($nv_Request->isset_request('action', 'post')) {
    $ajax_action = $nv_Request->get_title('action', 'post', '');

    // Xử lý xóa log cũ
    if ($ajax_action == 'clear_logs') {
        $confirm_token = $nv_Request->get_title('confirm', 'post', '');
        $expected_token = substr(str_replace(['/', '+', '='], '', base64_encode('clear_logs' . NV_CHECK_SESSION)), 0, 32);

        if ($confirm_token == $expected_token || $confirm_token == md5('clear_logs' . NV_CHECK_SESSION)) {
            $days = $nv_Request->get_int('days', 'post', 30);
            $time_limit = NV_CURRENTTIME - ($days * 24 * 3600);

            $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_logs WHERE log_time < " . $time_limit;
            $deleted = $db->exec($sql);

            nv_jsonOutput([
                'status' => 'success',
                'mess' => 'Đã xóa ' . $deleted . ' bản ghi log cũ'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Token xác thực không hợp lệ'
            ]);
        }
    }

    // Xử lý xóa log riêng lẻ
    if ($ajax_action == 'delete') {
        $log_id = $nv_Request->get_int('id', 'post', 0);
        if ($log_id > 0) {
            $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_logs WHERE id = " . $log_id;
            if ($db->exec($sql)) {
                nv_jsonOutput([
                    'status' => 'success',
                    'mess' => 'Đã xóa log thành công'
                ]);
            } else {
                nv_jsonOutput([
                    'status' => 'error',
                    'mess' => 'Có lỗi xảy ra khi xóa log'
                ]);
            }
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'ID log không hợp lệ'
            ]);
        }
    }
}

// Lọc dữ liệu
$where_conditions = [];
$action_filter = $nv_Request->get_title('action_filter', 'get', '');
$user_filter = $nv_Request->get_title('user_filter', 'get', '');
$from_date = $nv_Request->get_title('from_date', 'get', '');
$to_date = $nv_Request->get_title('to_date', 'get', '');

if (!empty($action_filter)) {
    $where_conditions[] = "l.action=" . $db->quote($action_filter);
}

if (!empty($user_filter)) {
    $where_conditions[] = "u.username LIKE " . $db->quote('%' . $user_filter . '%');
}

if (!empty($from_date)) {
    $from_timestamp = strtotime($from_date . ' 00:00:00');
    if ($from_timestamp) {
        $where_conditions[] = "l.log_time >= " . $from_timestamp;
    }
}

if (!empty($to_date)) {
    $to_timestamp = strtotime($to_date . ' 23:59:59');
    if ($to_timestamp) {
        $where_conditions[] = "l.log_time <= " . $to_timestamp;
    }
}

$where = "1=1";
if (!empty($where_conditions)) {
    $where .= " AND " . implode(" AND ", $where_conditions);
}

// Lấy danh sách logs
$offset = ($page - 1) * $per_page;

$sql = "SELECT l.*, u.username, s.title as source_title, s.alias as source_alias
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_logs l
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON l.userid = u.userid
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON l.source_id = s.id
        WHERE " . $where . "
        ORDER BY l.log_time DESC
        LIMIT " . $offset . ", " . $per_page;
$result = $db->query($sql);

$logs = [];
while ($row = $result->fetch()) {
    $row['created_time_format'] = date('d/m/Y H:i:s', $row['log_time']);
    $row['username'] = $row['username'] ?: 'Khách';
    
    // Xử lý action type
    $action_types = [
        'download' => 'Tải xuống',
        'view' => 'Xem chi tiết',
        'add_source' => 'Thêm mã nguồn',
        'edit_source' => 'Sửa mã nguồn',
        'delete_source' => 'Xóa mã nguồn',
        'add_category' => 'Thêm danh mục',
        'edit_category' => 'Sửa danh mục',
        'delete_category' => 'Xóa danh mục'
    ];
    $row['action_text'] = $action_types[$row['action']] ?? $row['action'];
    
    // Tạo link tham chiếu nếu có source
    if (!empty($row['source_alias'])) {
        $row['reference_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['source_alias'];
        $row['reference_title'] = $row['source_title'];
    } else {
        $row['reference_link'] = '';
        $row['reference_title'] = '';
    }
    
    $logs[] = $row;
}

// Đếm tổng số
$sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_logs l
              LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON l.userid = u.userid
              WHERE " . $where;
$total = $db->query($sql_count)->fetchColumn();

// Tạo phân trang
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;
$url_params = [];
if (!empty($action_filter)) $url_params[] = 'action_filter=' . urlencode($action_filter);
if (!empty($user_filter)) $url_params[] = 'user_filter=' . urlencode($user_filter);
if (!empty($from_date)) $url_params[] = 'from_date=' . urlencode($from_date);
if (!empty($to_date)) $url_params[] = 'to_date=' . urlencode($to_date);

if (!empty($url_params)) {
    $base_url .= '&' . implode('&', $url_params);
}

$generate_page = nv_generate_page($base_url, $total, $per_page, $page);

// Lấy danh sách action types
$sql = "SELECT DISTINCT action FROM " . NV_PREFIXLANG . "_" . $module_data . "_logs ORDER BY action ASC";
$result = $db->query($sql);
$action_types_list = [];
while ($row = $result->fetch()) {
    $action_types_list[] = $row['action'];
}

$xtpl = new XTemplate('logs.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);

$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);
$xtpl->assign('TOTAL', $total);
$xtpl->assign('GENERATE_PAGE', $generate_page);

// Filter form
$xtpl->assign('ACTION_FILTER', $action_filter);
$xtpl->assign('USER_FILTER', $user_filter);
$xtpl->assign('FROM_DATE', $from_date);
$xtpl->assign('TO_DATE', $to_date);

// Action types options
foreach ($action_types_list as $action_type) {
    $selected = ($action_type == $action_filter) ? 'selected="selected"' : '';
    $action_types = [
        'download' => 'Tải xuống',
        'view' => 'Xem chi tiết',
        'add_source' => 'Thêm mã nguồn',
        'edit_source' => 'Sửa mã nguồn',
        'delete_source' => 'Xóa mã nguồn',
        'add_category' => 'Thêm danh mục',
        'edit_category' => 'Sửa danh mục',
        'delete_category' => 'Xóa danh mục'
    ];
    $action_text = $action_types[$action_type] ?? $action_type;
    
    $xtpl->assign('ACTION_OPTION', [
        'value' => $action_type,
        'text' => $action_text,
        'selected' => $selected
    ]);
    $xtpl->parse('main.action_option');
}

// Logs list
if (!empty($logs)) {
    foreach ($logs as $log) {
        if (!empty($log['reference_link'])) {
            $xtpl->assign('LOG', $log);
            $xtpl->parse('main.logs.log.reference_link');
        }
        
        $xtpl->assign('LOG', $log);
        $xtpl->parse('main.logs.log');
    }
    $xtpl->parse('main.logs');
} else {
    $xtpl->parse('main.no_logs');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
