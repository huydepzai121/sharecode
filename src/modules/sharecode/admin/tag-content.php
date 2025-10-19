<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    exit('Stop!!!');
}

$id = $nv_Request->get_int('id', 'get', 0);
$page_title = $id ? 'Sửa tag' : 'Thêm tag';


$tag = [
    'id' => 0,
    'name' => '',
    'alias' => '',
    'description' => '',
    'weight' => 0,
    'status' => 1
];

$error = [];

if ($id > 0) {
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags WHERE id=" . $id;
    $tag = $db->query($sql)->fetch();

    if (empty($tag)) {
        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=tags');
    }
}

if ($nv_Request->get_int('save', 'post', 0)) {
    $tag['name'] = $nv_Request->get_title('name', 'post', '');
    $tag['alias'] = $nv_Request->get_title('alias', 'post', '');
    $tag['description'] = $nv_Request->get_textarea('description', '', NV_ALLOWED_HTML_TAGS);
    $tag['weight'] = $nv_Request->get_int('weight', 'post', 0);
    $tag['status'] = $nv_Request->get_int('status', 'post', 0);


    if (empty($tag['name'])) {
        $error[] = 'Tên tag không được để trống';
    }

    if (empty($tag['alias'])) {
        $tag['alias'] = change_alias($tag['name']);
    } else {
        $tag['alias'] = change_alias($tag['alias']);
    }


    $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags WHERE alias=" . $db->quote($tag['alias']);
    if ($id > 0) {
        $sql .= " AND id!=" . $id;
    }
    $exists = $db->query($sql)->fetchColumn();
    if ($exists) {
        $error[] = 'Alias đã tồn tại';
    }

    if (empty($error)) {
        if ($id > 0) {

            $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_tags SET 
                    name=" . $db->quote($tag['name']) . ",
                    alias=" . $db->quote($tag['alias']) . ",
                    description=" . $db->quote($tag['description']) . ",
                    weight=" . $tag['weight'] . ",
                    status=" . $tag['status'] . "
                    WHERE id=" . $id;
            $db->query($sql);

            nv_insert_logs(NV_LANG_DATA, $module_name, 'Edit tag', $tag['name'], $admin_info['userid']);
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=tags');
        } else {

            $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags 
                    (name, alias, description, weight, status, add_time) 
                    VALUES (" . $db->quote($tag['name']) . ", " . $db->quote($tag['alias']) . ", " . $db->quote($tag['description']) . ", " . $tag['weight'] . ", " . $tag['status'] . ", " . NV_CURRENTTIME . ")";
            $db->query($sql);

            nv_insert_logs(NV_LANG_DATA, $module_name, 'Add tag', $tag['name'], $admin_info['userid']);
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=tags');
        }
    }
}

$xtpl = new XTemplate('tag-content.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);
$xtpl->assign('TAG', $tag);


if (!empty($error)) {
    $xtpl->assign('ERROR', implode('<br>', $error));
    $xtpl->parse('main.error');
}


$status_options = [
    1 => 'Hoạt động',
    0 => 'Ngưng hoạt động'
];

foreach ($status_options as $value => $text) {
    $selected = ($tag['status'] == $value) ? 'selected="selected"' : '';
    $xtpl->assign('STATUS_OPTION', [
        'value' => $value,
        'text' => $text,
        'selected' => $selected
    ]);
    $xtpl->parse('main.status_option');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
