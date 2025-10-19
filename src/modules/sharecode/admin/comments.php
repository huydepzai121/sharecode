<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

$page_title = 'Quản lý bình luận';


$id = $nv_Request->get_int('id', 'get,post', 0);

if ($nv_Request->isset_request('action', 'post')) {
    $ajax_action = $nv_Request->get_title('action', 'post', '');


    if ($ajax_action == 'delete' && $id > 0) {
        $checksess = $nv_Request->get_title('checksess', 'post', '');
        if ($checksess == NV_CHECK_SESSION) {
            $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments WHERE id=" . $id;
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


    if ($ajax_action == 'reply' && $id > 0) {
        $checksess = $nv_Request->get_title('checksess', 'post', '');
        $reply_content = $nv_Request->get_textarea('reply_content', 'post', '');

        if ($checksess == NV_CHECK_SESSION && !empty($reply_content)) {
            $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_comments 
                    SET admin_reply = " . $db->quote($reply_content) . ",
                        admin_reply_time = " . NV_CURRENTTIME . ",
                        admin_reply_userid = " . $admin_info['userid'] . "
                    WHERE id = " . $id;

            if ($db->exec($sql)) {
                nv_jsonOutput([
                    'status' => 'success',
                    'mess' => 'Trả lời bình luận thành công'
                ]);
            } else {
                nv_jsonOutput([
                    'status' => 'error',
                    'mess' => 'Lỗi khi trả lời bình luận'
                ]);
            }
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Dữ liệu không hợp lệ'
            ]);
        }
    }
}


$where_conditions = [];
$source_id_filter = $nv_Request->get_int('source_id', 'get', 0);
$search = $nv_Request->get_title('search', 'get', '');


$where_conditions[] = "c.status=1";

if ($source_id_filter > 0) {
    $where_conditions[] = "c.source_id=" . $source_id_filter;
}

if (!empty($search)) {
    $where_conditions[] = "(c.content LIKE " . $db->quote('%' . $search . '%') . " OR u.username LIKE " . $db->quote('%' . $search . '%') . ")";
}

$where = implode(" AND ", $where_conditions);


$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 20;
$offset = ($page - 1) * $per_page;


$sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments c
              LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON c.userid = u.userid
              WHERE " . $where;
$total = $db->query($sql_count)->fetchColumn();


$sql = "SELECT c.*, u.username, u.email, s.title as source_title, s.alias as source_alias,
               ar.username as admin_reply_username
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments c
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON c.userid = u.userid
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON c.source_id = s.id
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " ar ON c.admin_reply_userid = ar.userid
        WHERE " . $where . "
        ORDER BY c.add_time DESC
        LIMIT " . $offset . ", " . $per_page;

$result = $db->query($sql);

$comments = [];
while ($row = $result->fetch()) {
    $row['created_time_format'] = date('d/m/Y H:i', $row['add_time']);
    $row['source_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['source_alias'];
    $row['username'] = $row['username'] ?: 'Khách';
    $row['user_email'] = $row['email'] ?? '';
    $row['checksess'] = NV_CHECK_SESSION;
    $row['has_admin_reply'] = !empty($row['admin_reply']);
    if ($row['has_admin_reply']) {
        $row['admin_reply_time_format'] = date('d/m/Y H:i', $row['admin_reply_time']);
    }
    $comments[] = $row;
}


$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;
if ($source_id_filter > 0) {
    $base_url .= '&source_id=' . $source_id_filter;
}
if (!empty($search)) {
    $base_url .= '&search=' . urlencode($search);
}
$generate_page = nv_generate_page($base_url, $total, $per_page, $page);


$sql_sources = "SELECT id, title FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE status=1 ORDER BY title ASC";
$result_sources = $db->query($sql_sources);
$source_options = [['value' => 0, 'title' => 'Tất cả sản phẩm']];
while ($row_source = $result_sources->fetch()) {
    $source_options[] = [
        'value' => $row_source['id'],
        'title' => $row_source['title']
    ];
}

$search_data = [
    'source_id' => $source_id_filter,
    'search' => $search
];

$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('comments.tpl'));
$tpl->assign('LANG', $nv_Lang);
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('OP', $op);
$tpl->assign('TOTAL', $total);
$tpl->assign('GENERATE_PAGE', $generate_page);
$tpl->assign('SOURCE_OPTIONS', $source_options);
$tpl->assign('SEARCH', $search_data);
$tpl->assign('COMMENTS', $comments);

$contents = $tpl->fetch('comments.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
