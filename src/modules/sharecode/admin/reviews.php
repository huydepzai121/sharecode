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

$page_title = 'Quản lý đánh giá';

$action = $nv_Request->get_title('action', 'get', '');
$id = $nv_Request->get_int('id', 'get', 0);
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 20;

// Xử lý xóa review
if ($action == 'delete' && $id > 0) {
    if ($nv_Request->get_title('confirm', 'get', '') == md5($id . NV_CHECK_SESSION)) {
        $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews WHERE id=" . $id;
        if ($db->exec($sql)) {
            nv_jsonOutput([
                'status' => 'success',
                'mess' => 'Xóa đánh giá thành công'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Lỗi khi xóa đánh giá'
            ]);
        }
    }
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
}

// Xử lý thay đổi trạng thái
if ($action == 'change_status' && $id > 0) {
    $new_status = $nv_Request->get_int('status', 'get', 0);
    $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_reviews SET status=" . $new_status . " WHERE id=" . $id;
    if ($db->exec($sql)) {
        nv_jsonOutput([
            'status' => 'success',
            'mess' => 'Cập nhật trạng thái thành công'
        ]);
    } else {
        nv_jsonOutput([
            'status' => 'error',
            'mess' => 'Lỗi khi cập nhật trạng thái'
        ]);
    }
}

// Lọc dữ liệu
$where_conditions = [];
$source_id_filter = $nv_Request->get_int('source_id', 'get', 0);
$status_filter = $nv_Request->get_int('status_filter', 'get', -1);

if ($source_id_filter > 0) {
    $where_conditions[] = "r.source_id=" . $source_id_filter;
}

if ($status_filter >= 0) {
    $where_conditions[] = "r.status=" . $status_filter;
}

$where = "1=1";
if (!empty($where_conditions)) {
    $where .= " AND " . implode(" AND ", $where_conditions);
}

// Lấy danh sách reviews
$offset = ($page - 1) * $per_page;

$sql = "SELECT r.*, s.title as source_title, s.alias as source_alias, u.username
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON r.source_id = s.id
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON r.userid = u.userid
        WHERE " . $where . "
        ORDER BY r.add_time DESC
        LIMIT " . $offset . ", " . $per_page;
$result = $db->query($sql);

$reviews = [];
while ($row = $result->fetch()) {
    $row['created_time_format'] = date('d/m/Y H:i', $row['add_time']);
    $row['rating_stars'] = str_repeat('★', $row['rating']) . str_repeat('☆', 5 - $row['rating']);
    $row['status_text'] = $row['status'] ? 'Đã duyệt' : 'Chờ duyệt';
    $row['source_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['source_alias'];
    $reviews[] = $row;
}

// Đếm tổng số
$sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r WHERE " . $where;
$total = $db->query($sql_count)->fetchColumn();

// Tạo phân trang
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;
if ($source_id_filter > 0) {
    $base_url .= '&source_id=' . $source_id_filter;
}
if ($status_filter >= 0) {
    $base_url .= '&status_filter=' . $status_filter;
}
$generate_page = nv_generate_page($base_url, $total, $per_page, $page);

// Lấy danh sách sources cho filter
$sql = "SELECT id, title FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources ORDER BY title ASC";
$result = $db->query($sql);
$sources_list = [];
while ($row = $result->fetch()) {
    $sources_list[] = $row;
}

$xtpl = new XTemplate('reviews.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);

$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);
$xtpl->assign('TOTAL', $total);
$xtpl->assign('GENERATE_PAGE', $generate_page);

// Filter form
$xtpl->assign('SOURCE_ID_FILTER', $source_id_filter);
$xtpl->assign('STATUS_FILTER', $status_filter);

// Sources options
foreach ($sources_list as $source) {
    $source['selected'] = ($source['id'] == $source_id_filter) ? 'selected="selected"' : '';
    $xtpl->assign('SOURCE_OPTION', $source);
    $xtpl->parse('main.source_option');
}

// Status options
$status_options = [
    -1 => 'Tất cả',
    0 => 'Chờ duyệt',
    1 => 'Đã duyệt'
];
foreach ($status_options as $value => $text) {
    $selected = ($value == $status_filter) ? 'selected="selected"' : '';
    $xtpl->assign('STATUS_OPTION', [
        'value' => $value,
        'text' => $text,
        'selected' => $selected
    ]);
    $xtpl->parse('main.status_option');
}

// Reviews list
if (!empty($reviews)) {
    foreach ($reviews as $review) {
        // Xử lý template cho status
        if ($review['status']) {
            $xtpl->parse('main.reviews.review.approved');
            $xtpl->parse('main.reviews.review.reject_btn');
        } else {
            $xtpl->parse('main.reviews.review.pending');
            $xtpl->parse('main.reviews.review.approve_btn');
        }

        $xtpl->assign('REVIEW', $review);
        $xtpl->parse('main.reviews.review');
    }
    $xtpl->parse('main.reviews');
} else {
    $xtpl->parse('main.no_reviews');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
