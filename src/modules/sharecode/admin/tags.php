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

$page_title = 'Quản lý Tags';

$checkss = $nv_Request->get_string('checkss', 'post', '');

// Cập nhật count cho tất cả tags
if ($nv_Request->get_string('action', 'get', '') == 'update_count') {
    nv_admin_sharecode_update_all_tags_count();
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&updated=1');
}

// Xóa các liên kết
if ($nv_Request->isset_request('tagsIdDel', 'post')) {
    $tid = $nv_Request->get_int('id', 'post', 0);
    $ids = $nv_Request->get_title('ids', 'post', '');

    $respon = [
        'success' => 0,
        'text' => 'Error session!!!'
    ];

    if (!empty($ids) and !empty($tid) and $checkss === NV_CHECK_SESSION) {
        nv_insert_logs(NV_LANG_DATA, $module_name, 'DEL_TAG_IDS', $tid . ': ' . $ids, $admin_info['userid']);

        $ids = preg_replace('/[^0-9\\,]+/', '', $ids);
        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_source_tags WHERE tag_id = ' . $tid . ' AND source_id IN (' . $ids . ')');

        $num = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_source_tags where tag_id=' . $tid)->fetchColumn();
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_tags SET total_sources=' . $num . ' WHERE id=' . $tid);

        $respon['success'] = 1;
    }

    nv_jsonOutput($respon);
}

// Xóa nhiều tags
if ($nv_Request->isset_request('del_listid', 'post')) {
    $del_listid = $nv_Request->get_string('del_listid', 'post', '');
    $del_listid = array_map('intval', explode(',', $del_listid));
    $del_listid = array_filter($del_listid);
    if (!empty($del_listid) and NV_CHECK_SESSION == $checkss) {
        $del_listid = implode(',', $del_listid);
        nv_insert_logs(NV_LANG_DATA, $module_name, 'DEL_TAGS', $del_listid, $admin_info['userid']);

        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_tags WHERE id IN (' . $del_listid . ')');
        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_source_tags WHERE tag_id IN (' . $del_listid . ')');

        nv_jsonOutput([
            'success' => 1,
            'text' => ''
        ]);
    }

    nv_jsonOutput([
        'success' => 0,
        'text' => 'Wrong session or no tag IDs!'
    ]);
}

// Xóa tag
if ($nv_Request->isset_request('del_tid', 'post')) {
    $tid = $nv_Request->get_int('del_tid', 'post', 0);

    if (!empty($tid) and NV_CHECK_SESSION == $checkss) {
        nv_insert_logs(NV_LANG_DATA, $module_name, 'DEL_TAG', $tid, $admin_info['userid']);

        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_tags WHERE id=' . $tid);
        $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_source_tags WHERE tag_id=' . $tid);

        nv_jsonOutput([
            'success' => 1,
            'text' => ''
        ]);
    }

    nv_jsonOutput([
        'success' => 0,
        'text' => 'Wrong session or no tag ID!'
    ]);
}

// Thêm nhiều tags
if ($nv_Request->isset_request('savetag', 'post')) {
    $respon = [
        'status' => 'error',
        'mess' => 'Error!!!',
    ];
    
    if (NV_CHECK_SESSION !== $checkss) {
        $respon['mess'] = 'Wrong session!!!';
        nv_jsonOutput($respon);
    }

    $title = $nv_Request->get_textarea('mtitle', '', NV_ALLOWED_HTML_TAGS, true);
    $list_tag = explode('<br />', strip_tags($title, '<br>'));
    $added = [];
    $aliases = [];
    foreach ($list_tag as $tag_i) {
        $name = trim(strip_tags($tag_i));
        if (nv_strlen($name) >= 2) {
            $alias = change_alias($name);
            
            // Kiểm tra alias đã tồn tại chưa
            $check_exists = $db->query('SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_tags WHERE alias=' . $db->quote($alias))->fetchColumn();
            
            if (!$check_exists) {
                $add_time = NV_CURRENTTIME;
                $sth = $db->prepare('INSERT IGNORE INTO ' . NV_PREFIXLANG . '_' . $module_data . "_tags (name, alias, description, weight, status, add_time) VALUES (:name, :alias, '', 0, 1, :add_time)");
                $sth->bindParam(':name', $name, PDO::PARAM_STR);
                $sth->bindParam(':alias', $alias, PDO::PARAM_STR);
                $sth->bindParam(':add_time', $add_time, PDO::PARAM_INT);
                $sth->execute();
                $added[] = $name;
                $aliases[] = $alias;
            }
        }
    }

    if (empty($added)) {
        $respon['mess'] = 'Không có từ khóa nào được thêm';
        nv_jsonOutput($respon);
    }
    $added = implode('; ', $added);
    $aliases = implode('; ', $aliases);
    nv_insert_logs(NV_LANG_DATA, $module_name, 'add_multi_tags', $aliases, $admin_info['userid']);

    $respon['status'] = 'success';
    $respon['mess'] = 'Đã thêm từ khóa: ' . $added;
    $respon['refresh'] = 1;
    nv_jsonOutput($respon);
}

// Thêm tag hoặc sửa tag
if ($nv_Request->isset_request('savecat', 'post')) {
    if (NV_CHECK_SESSION !== $checkss) {
        nv_jsonOutput([
            'status' => 'error',
            'mess' => 'Wrong session!!!'
        ]);
    }
    
    $id = $nv_Request->get_int('id', 'post', 0);
    if (!empty($id)) {
        $num = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_tags where id=' . $id)->fetchColumn();
        if (!$num) {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Từ khóa không tồn tại'
            ]);
        }
    }

    $name = $nv_Request->get_title('name', 'post', '');
    if (nv_strlen($name) < 2) {
        nv_jsonOutput([
            'status' => 'error',
            'input' => 'name',
            'mess' => 'Tên tag phải có ít nhất 2 ký tự'
        ]);
    }

    $alias = $nv_Request->get_title('alias', 'post', '');
    if (empty($alias)) {
        $alias = change_alias($name);
    }
    
    // Kiểm tra alias đã tồn tại chưa
    $check_sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags WHERE alias=" . $db->quote($alias);
    if ($id > 0) {
        $check_sql .= " AND id!=" . $id;
    }
    $check_exists = $db->query($check_sql)->fetchColumn();
    
    if ($check_exists) {
        nv_jsonOutput([
            'status' => 'error',
            'input' => 'alias',
            'mess' => 'Alias đã tồn tại'
        ]);
    }

    $description = $nv_Request->get_string('description', 'post', '');
    $description = nv_nl2br(nv_htmlspecialchars(strip_tags($description)), '<br />');
    $weight = $nv_Request->get_int('weight', 'post', 0);

    if (empty($id)) {
        $add_time = NV_CURRENTTIME;
        $sth = $db->prepare('INSERT INTO ' . NV_PREFIXLANG . '_' . $module_data . '_tags (name, alias, description, weight, status, add_time) VALUES (:name, :alias, :description, :weight, 1, :add_time)');
        $sth->bindParam(':add_time', $add_time, PDO::PARAM_INT);
        $msg_lg = 'add_tags';
    } else {
        $sth = $db->prepare('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_tags SET name = :name, alias = :alias, description = :description, weight = :weight, edit_time=' . NV_CURRENTTIME . ' WHERE id =' . $id);
        $msg_lg = 'edit_tags';
    }

    try {
        $sth->bindParam(':name', $name, PDO::PARAM_STR);
        $sth->bindParam(':alias', $alias, PDO::PARAM_STR);
        $sth->bindParam(':description', $description, PDO::PARAM_STR);
        $sth->bindParam(':weight', $weight, PDO::PARAM_INT);
        $sth->execute();

        nv_insert_logs(NV_LANG_DATA, $module_name, $msg_lg, $alias, $admin_info['userid']);
        nv_jsonOutput([
            'status' => 'ok',
            'mess' => 'Lưu thành công',
            'refresh' => 1
        ]);
    } catch (Throwable $e) {
        trigger_error(print_r($e, true));
        nv_jsonOutput([
            'status' => 'error',
            'mess' => 'Lỗi khi lưu dữ liệu'
        ]);
    }
}

// Danh sách liên kết
if ($nv_Request->isset_request('tagLinks', 'post')) {
    $respon = [
        'success' => 0,
        'text' => 'Error!!!',
        'html' => ''
    ];
    if (NV_CHECK_SESSION !== $checkss) {
        $respon['text'] = 'Wrong session!!!';
        nv_jsonOutput($respon);
    }

    $tid = $nv_Request->get_int('id', 'post', 0);
    $tag_data = $db_slave->query('SELECT id, name FROM ' . NV_PREFIXLANG . '_' . $module_data . '_tags where id=' . $tid)->fetch();
    if (empty($tag_data)) {
        $respon['text'] = 'Tag not exists!!!';
        nv_jsonOutput($respon);
    }

    $sql = 'SELECT st.source_id, s.catid, s.title, s.alias FROM ' . NV_PREFIXLANG . '_' . $module_data . '_source_tags st,
    ' . NV_PREFIXLANG . '_' . $module_data . '_sources s WHERE st.tag_id=' . $tid . ' AND st.source_id=s.id';
    $result = $db_slave->query($sql);

    $array = [];
    while ($row = $result->fetch()) {
        $row['url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&id=' . $row['source_id'];
        $array[] = $row;
    }

    if (empty($array)) {
        $html = '<div class="alert alert-info text-center">';
        $html .= '<i class="fa fa-info-circle fa-2x mb-3"></i><br>';
        $html .= '<strong>Chưa có mã nguồn nào sử dụng tag này</strong><br>';
        $html .= '<small class="text-muted">Tag này chưa được liên kết với bất kỳ mã nguồn nào.</small>';
        $html .= '</div>';
    } else {
        $html = '<div class="alert alert-success mb-3">';
        $html .= '<i class="fa fa-check-circle"></i> ';
        $html .= '<strong>Tìm thấy ' . count($array) . ' mã nguồn</strong> đang sử dụng tag này';
        $html .= '</div>';

        $html .= '<div class="table-responsive">';
        $html .= '<table class="table table-striped table-hover">';
        $html .= '<thead class="thead-light">';
        $html .= '<tr>';
        $html .= '<th width="60" class="text-center"><i class="fa fa-hashtag"></i> ID</th>';
        $html .= '<th><i class="fa fa-file-code-o"></i> Tên mã nguồn</th>';
        $html .= '<th width="120" class="text-center"><i class="fa fa-cogs"></i> Thao tác</th>';
        $html .= '</tr>';
        $html .= '</thead>';
        $html .= '<tbody>';

        foreach ($array as $row) {
            $html .= '<tr>';
            $html .= '<td class="text-center"><span class="badge text-primary">' . $row['source_id'] . '</span></td>';
            $html .= '<td>';
            $html .= '<a href="' . $row['url'] . '" target="_blank" class="text-primary" title="Xem chi tiết mã nguồn">';
            $html .= '<i class="fa fa-external-link"></i> ' . nv_clean60($row['title'], 60);
            $html .= '</a>';
            $html .= '</td>';
            $html .= '<td class="text-center">';
            $html .= '<button class="btn btn-danger btn-sm" onclick="removeTagLink(' . $tid . ', ' . $row['source_id'] . ')" title="Xóa liên kết">';
            $html .= '<i class="fa fa-unlink"></i> Xóa';
            $html .= '</button>';
            $html .= '</td>';
            $html .= '</tr>';
        }
        $html .= '</tbody></table></div>';

        $html .= '<div class="alert alert-warning mt-3">';
        $html .= '<i class="fa fa-warning"></i> ';
        $html .= '<strong>Lưu ý:</strong> Việc xóa liên kết sẽ loại bỏ tag khỏi mã nguồn tương ứng.';
        $html .= '</div>';
    }

    $respon['success'] = 1;
    $respon['html'] = $html;
    nv_jsonOutput($respon);
}

// Lấy thông tin tag để sửa
if ($nv_Request->isset_request('loadEditTag', 'post')) {
    $respon = [
        'success' => 0,
        'text' => 'Error!!!'
    ];
    if (NV_CHECK_SESSION !== $checkss) {
        $respon['text'] = 'Wrong session!!!';
        nv_jsonOutput($respon);
    }

    $tid = $nv_Request->get_int('id', 'post', 0);
    $tag_data = $db_slave->query('SELECT id, name, alias, description, weight FROM ' . NV_PREFIXLANG . '_' . $module_data . '_tags where id=' . $tid)->fetch();
    if (empty($tag_data)) {
        $respon['text'] = 'Tag not exists!!!';
        nv_jsonOutput($respon);
    }

    $respon['success'] = 1;
    $respon['data'] = [
        'name' => nv_unhtmlspecialchars($tag_data['name']),
        'alias' => nv_unhtmlspecialchars($tag_data['alias']),
        'description' => nv_unhtmlspecialchars(nv_br2nl($tag_data['description'])),
        'weight' => $tag_data['weight']
    ];
    nv_jsonOutput($respon);
}

// Mặc định hiển thị danh sách tags
$complete = $nv_Request->get_bool('complete', 'get,post', false);
$incomplete = $nv_Request->get_bool('incomplete', 'get,post', false);
$page = $nv_Request->get_absint('page', 'get', 1);
$per_page = 20;
$where = [];
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;

if ($incomplete === true) {
    $where[] = "(description = '' OR description IS NULL)";
    $base_url .= '&incomplete=1';
} elseif ($complete === true) {
    $where[] = "description != '' AND description IS NOT NULL";
    $base_url .= '&complete=1';
}

$q = $nv_Request->get_title('q', 'get', '');
if (nv_strlen($q) >= 2) {
    $where[] = "name LIKE '%" . $db_slave->dblikeescape($q) . "%'";
    $base_url .= '&q=' . urlencode($q);
}

$where = !empty($where) ? implode(' AND ', $where) : '';

$db_slave->sqlreset()
    ->select('COUNT(id)')
    ->from(NV_PREFIXLANG . '_' . $module_data . '_tags')
    ->where($where);

$sth = $db_slave->prepare($db_slave->sql());
$sth->execute();
$num_items = $sth->fetchColumn();

$db_slave->sqlreset()
->select('*')
->from(NV_PREFIXLANG . '_' . $module_data . '_tags')
->where($where)
->order('weight ASC, name ASC')
->limit($per_page)
->offset(($page - 1) * $per_page);

$sth = $db_slave->prepare($db_slave->sql());
$sth->execute();

$array = [];
while ($row = $sth->fetch()) {
    // Cập nhật số lượng sources cho tag nếu chưa có
    if (!isset($row['total_sources']) || $row['total_sources'] == 0) {
        $num_sources = $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_source_tags WHERE tag_id=' . $row['id'])->fetchColumn();
        $db->query('UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_tags SET total_sources=' . $num_sources . ' WHERE id=' . $row['id']);
        $row['total_sources'] = $num_sources;
    }
    
    $row['num_sources'] = $row['total_sources'];
    $row['has_sources'] = $row['total_sources'] > 0;
    $row['no_sources'] = $row['total_sources'] == 0;
    $array[] = $row;
}
$sth->closeCursor();

$generate_page = nv_generate_page($base_url, $num_items, $per_page, $page);

// Use modern Smarty templating
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('tags.tpl'));
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('OP', $op);

$tpl->assign('INCOMPLETE', $incomplete);
$tpl->assign('COMPLETE', $complete);
$tpl->assign('Q', $q);
$tpl->assign('NUM_ITEMS', $num_items);
$tpl->assign('DATA', $array);
$tpl->assign('PAGINATION', $generate_page);

$contents = $tpl->fetch('tags.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';