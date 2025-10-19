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

$page_title = 'Quản lý bình luận & đánh giá';

$action = $nv_Request->get_title('action', 'get', '');
$id = $nv_Request->get_int('id', 'get,post', 0);
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 20;

// Xử lý xóa review
if ($nv_Request->get_title('action', 'get', '') == 'delete') {
    if ($nv_Request->get_title('confirm', 'get', '') == NV_CHECK_SESSION) {
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

// Xử lý AJAX requests
if ($nv_Request->isset_request('action', 'post')) {
    $ajax_action = $nv_Request->get_title('action', 'post', '');

    // Xử lý admin reply
    if ($ajax_action == 'admin_reply') {
        $review_id = $nv_Request->get_int('review_id', 'post', 0);
        $admin_reply = $nv_Request->get_textarea('admin_reply', '', 'post');
        $checksess = $nv_Request->get_title('checksess', 'post', '');

        if ($checksess == NV_CHECK_SESSION && $review_id > 0 && !empty($admin_reply)) {
            $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_reviews SET
                    admin_reply = :admin_reply,
                    admin_reply_time = " . NV_CURRENTTIME . ",
                    admin_reply_userid = " . $admin_info['userid'] . "
                    WHERE id = " . $review_id;

            $sth = $db->prepare($sql);
            $sth->bindParam(':admin_reply', $admin_reply, PDO::PARAM_STR);

            if ($sth->execute()) {
                nv_jsonOutput([
                    'status' => 'success',
                    'mess' => 'Đã trả lời review thành công!'
                ]);
            }
        }

        nv_jsonOutput([
            'status' => 'error',
            'mess' => 'Có lỗi xảy ra khi trả lời review!'
        ]);
    }

    // Bỏ chức năng thay đổi trạng thái vì giờ tự động approve

    // Chỉ giữ chức năng xóa review qua AJAX
    if ($ajax_action == 'delete' && $id > 0) {
        $checksess = $nv_Request->get_title('checksess', 'post', '');
        if ($checksess == NV_CHECK_SESSION) {
            $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews WHERE id=" . $id;
            if ($db->exec($sql)) {
                nv_jsonOutput([
                    'status' => 'success',
                    'mess' => 'Xóa bình luận thành công'
                ]);
            } else {
                nv_jsonOutput([
                    'status' => 'error',
                    'mess' => 'Lỗi khi xóa bình luận'
                ]);
            }
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Token xác thực không hợp lệ'
            ]);
        }
    }

    // Xóa nhiều review cùng lúc
    if ($ajax_action == 'delete_multiple') {
        $checksess = $nv_Request->get_title('checksess', 'post', '');
        $ids = $nv_Request->get_title('ids', 'post', '');

        if ($checksess == NV_CHECK_SESSION && !empty($ids)) {
            $ids_array = explode(',', $ids);
            $ids_array = array_map('intval', $ids_array);
            $ids_array = array_filter($ids_array, function($id) { return $id > 0; });

            if (!empty($ids_array)) {
                $ids_string = implode(',', $ids_array);
                $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews WHERE id IN (" . $ids_string . ")";
                $deleted_count = $db->exec($sql);

                if ($deleted_count > 0) {
                    nv_jsonOutput([
                        'status' => 'success',
                        'mess' => 'Đã xóa ' . $deleted_count . ' bình luận thành công'
                    ]);
                } else {
                    nv_jsonOutput([
                        'status' => 'error',
                        'mess' => 'Không có bình luận nào được xóa'
                    ]);
                }
            } else {
                nv_jsonOutput([
                    'status' => 'error',
                    'mess' => 'Danh sách ID không hợp lệ'
                ]);
            }
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Token xác thực không hợp lệ hoặc thiếu dữ liệu'
            ]);
        }
    }
}

// Lọc dữ liệu
$where_conditions = [];
$source_id_filter = $nv_Request->get_int('source_id', 'get', 0);
$search = $nv_Request->get_title('search', 'get', '');

// Chỉ hiển thị reviews đã được duyệt (status=1) vì giờ tự động approve
$where_conditions[] = "r.status=1";

if ($source_id_filter > 0) {
    $where_conditions[] = "r.source_id=" . $source_id_filter;
}

if (!empty($search)) {
    $where_conditions[] = "(r.content LIKE " . $db->quote('%' . $search . '%') . " OR u.username LIKE " . $db->quote('%' . $search . '%') . ")";
}

$where = !empty($where_conditions) ? implode(" AND ", $where_conditions) : "1=1";

// Lấy danh sách reviews
$offset = ($page - 1) * $per_page;

$sql = "SELECT r.*, s.title as source_title, s.alias as source_alias, u.username, ar.username as admin_reply_username
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON r.source_id = s.id
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON r.userid = u.userid
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " ar ON r.admin_reply_userid = ar.userid
        WHERE " . $where . "
        ORDER BY r.add_time DESC
        LIMIT " . $offset . ", " . $per_page;
$result = $db->query($sql);

$reviews = [];
while ($row = $result->fetch()) {
    $row['created_time_format'] = date('d/m/Y H:i', $row['add_time']);
    $row['rating_stars'] = str_repeat('★', $row['rating']) . str_repeat('☆', 5 - $row['rating']);
    $row['source_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['source_alias'];
    $row['username'] = $row['username'] ?: 'Khách';
    $row['user_email'] = $row['email'] ?? '';
    $row['checksess'] = NV_CHECK_SESSION;

    // Thêm status_class để tránh lỗi undefined
    $row['status_class'] = ($row['status'] == 1) ? 'success' : 'warning';
    $row['status_text'] = ($row['status'] == 1) ? 'Đã duyệt' : 'Chờ duyệt';

    // Xử lý admin reply
    $row['has_admin_reply'] = !empty($row['admin_reply']);
    $row['admin_reply_time_format'] = $row['admin_reply_time'] ? date('d/m/Y H:i', $row['admin_reply_time']) : '';
    $row['admin_reply_username'] = $row['admin_reply_username'] ?: 'Admin';

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
if (!empty($search)) {
    $base_url .= '&search=' . urlencode($search);
}
$generate_page = nv_generate_page($base_url, $total, $per_page, $page);

// Lấy danh sách sources cho filter
$sql = "SELECT id, title FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources ORDER BY title ASC";
$result = $db->query($sql);
$sources_list = [];
while ($row = $result->fetch()) {
    $sources_list[] = $row;
}

// Khởi tạo Smarty
$smarty = new \NukeViet\Template\NVSmarty();
$smarty->setTemplateDir(get_module_tpl_dir('reviews.tpl'));
$smarty->assign('LANG', $lang_module);
$smarty->assign('GLANG', $lang_global);

// Chuẩn bị dữ liệu cho Smarty
// Tạo source options cho dropdown
$source_options = [
    ['value' => 0, 'title' => 'Tất cả mã nguồn']
];
foreach ($sources_list as $source) {
    $source_options[] = [
        'value' => $source['id'],
        'title' => $source['title']
    ];
}

// Chuẩn bị dữ liệu search
$search_data = [
    'source_id' => $source_id_filter,
    'search' => $search
];

// Sử dụng Smarty template
$smarty->assign('TOTAL', $total);
$smarty->assign('SEARCH', $search);
$smarty->assign('REVIEWS', $reviews);
$smarty->assign('GENERATE_PAGE', $generate_page);
$smarty->assign('CHECKSESS', NV_CHECK_SESSION);
$smarty->assign('MODULE_NAME', $module_name);
$smarty->assign('OP', $op);
$smarty->assign('SOURCE_OPTIONS', $source_options);
$smarty->assign('SEARCH_DATA', $search_data);

$contents = $smarty->fetch('reviews.tpl');




include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
