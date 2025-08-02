<?php

/**
 * @Project WALLET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2018 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Friday, March 9, 2018 6:24:54 AM
 */

if (!defined('NV_IS_FILE_ADMIN'))
    die('Stop!!!');

$page_title = $table_caption = $nv_Lang->getModule('acountuser');

// Kiểm tra quyền quản lý ví tiền, nếu không có quyền chuyển đến quyền gần nhất có thể
// if (!$IS_FULL_ADMIN and empty($PERMISSION_ADMIN['is_wallet'])) {
//     $show_funcs = [
//         'transaction',
//         'order-list',
//         'exchange',
//         'historyexchange',
//         'money',
//         'payport',
//         'config',
//         'statistics'
//     ];
//     foreach ($allow_func as $op) {
//         if (in_array($op, $show_funcs)) {
//             nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
//         }
//     }

//     $contents = nv_theme_alert($nv_Lang->getModule('permission_none'), $nv_Lang->getModule('permission_none_explain'), 'danger');

//     include NV_ROOTDIR . '/includes/header.php';
//     echo nv_admin_theme($contents);
//     include NV_ROOTDIR . '/includes/footer.php';
// }

$page = $nv_Request->get_int('page', 'get', 1);
if ($page < 1 or $page > 9999999999) {
    $page = 1;
}
$per_page = 5000;
$base_url = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name;

$methods = array(
    'userid' => array(
        'key' => 'userid',
        'value' => $nv_Lang->getModule('search_id'),
        'selected' => ''
    ),
    'username' => array(
        'key' => 'username',
        'value' => $nv_Lang->getModule('search_account'),
        'selected' => ''
    ),
    'first_name' => array(
        'key' => 'first_name',
        'value' => $nv_Lang->getModule('search_name'),
        'selected' => ''
    ),
    'email' => array(
        'key' => 'email',
        'value' => $nv_Lang->getModule('search_mail'),
        'selected' => ''
    )
);

$array_search = array();
$array_search['q'] = $nv_Request->get_title('q', 'get', '');
$array_search['f'] = $nv_Request->get_title('f', 'get', '');
$isSearch = false;

$db->sqlreset();
$db->select('COUNT(*)');
$db->from($db_config['prefix'] . "_" . $module_data . "_money tb1, " . NV_USERS_GLOBALTABLE . " tb2");

$where = array('tb1.userid=tb2.userid');

if (!empty($array_search['q'])) {
    $base_url .= '&amp;q=' . urlencode($array_search['q']);
    $dbkey = $db->dblikeescape($array_search['q']);
    $array_likes = array(
        'userid' => "tb2.userid LIKE '" . $dbkey . "'",
        'username' => "tb2.username LIKE '%" . $dbkey . "%'",
        'first_name' => ($global_config['name_show'] == 0 ? "concat(last_name,' ',first_name)" : "concat(first_name,' ',last_name)") . " LIKE '%" . $dbkey . "%'",
        'email' => "tb2.email LIKE '%" . $dbkey . "%'"
    );
    if (isset($methods[$array_search['f']])) {
        $query_q = $array_likes[$array_search['f']];
    } else {
        $query_q = '(' . implode(' OR ', $array_likes) . ')';
    }
    $where[] = $query_q;
    $isSearch = true;
}
if (isset($methods[$array_search['f']])) {
    $base_url .= '&amp;f=' . $array_search['f'];
}

$db->where(implode(' AND ', $where));

$result = $db->query($db->sql());
$all_page = $result->fetchColumn();

$db->select('tb1.*, tb2.username, tb2.email, tb2.first_name, tb2.last_name');
$db->order('tb1.created_time DESC');
$db->limit($per_page);
$db->offset(($page - 1) * $per_page);

$result = $db->query($db->sql());
$array = $array_users = $array_userids = array();
while ($row = $result->fetch()) {
    $array[$row['userid'] . $row['money_unit']] = $row;
    if (!empty($row['created_userid'])) {
        $array_userids[$row['created_userid']] = $row['created_userid'];
    }
}

if (!empty($array_userids)) {
    $sql = "SELECT userid, username, first_name, last_name FROM " . NV_USERS_GLOBALTABLE . " WHERE userid IN(" . implode(',', $array_userids) . ")";
    $result = $db->query($sql);
    while ($row = $result->fetch()) {
        $array_users[$row['userid']] = $row;
    }
}

$generate_page = nv_generate_page($base_url, $all_page, $per_page, $page);

// Xác định cập nhật hay tạo mới tài khoản
$info_userdata = array();
$username = $nv_Request->get_title('u', 'get', '');
if (!empty($username)) {
    $sql = "SELECT * FROM " . NV_USERS_GLOBALTABLE . " WHERE username=:username";
    $sth = $db->prepare($sql);
    $sth->bindParam(':username', $username, PDO::PARAM_STR);
    $sth->execute();
    $info_userdata = $sth->fetch();
    if (empty($info_userdata)) {
        nv_redirect_location(NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name);
    }
}
$update = $nv_Request->get_int('update', 'get', 0);

$isShowAccountArea = false;

// Add new acount
if (!empty($info_userdata)) {
    $money_unit = $nv_Request->get_title('money_unit', 'get', '');
    if (!empty($money_unit)) {
        $sql = "SELECT COUNT(*) FROM " . $db_config['prefix'] . "_" . $module_data . "_money WHERE userid ='" . $info_userdata['userid'] . "' AND money_unit=" . $db->quote($money_unit);
        if ($db->query($sql)->fetchColumn() != 1) {
            nv_redirect_location(NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name);
        }
    }
}

// Chuẩn bị dữ liệu cho template
$template = get_tpl_dir([$global_config['module_theme'], $global_config['admin_theme']], 'admin_future', '/modules/' . $module_file . '/main.tpl');
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(NV_ROOTDIR . '/themes/' . $template . '/modules/' . $module_file);

// Gán các biến cho template
$tpl->assign('LANG', $nv_Lang);
$tpl->assign('OP', $op);
$tpl->assign('BASE_URL', $base_url);
$tpl->assign('TABLE_CAPTION', $table_caption);
$tpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$tpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$tpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$tpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('SEARCH', $array_search);
$tpl->assign('METHODS', $methods);
$tpl->assign('GENERATE_PAGE', $generate_page);
$tpl->assign('INFO_USERDATA', $info_userdata);
$tpl->assign('UPDATE', $update);
$tpl->assign('IS_SHOW_ACCOUNT_AREA', $isShowAccountArea);
$tpl->assign('GLOBAL_ARRAY_MONEY_SYS', $global_array_money_sys);
$tpl->assign('GLOBAL_ARRAY_TRANSACTION_TYPE', $global_array_transaction_type);
$tpl->assign('URL_THEMES', NV_STATIC_URL . 'themes/' . $global_config['site_theme'] . '/');

// Xử lý form tạo tài khoản
if (!empty($info_userdata)) {
    $money_unit = $nv_Request->get_title('money_unit', 'get', '');
    if (!empty($money_unit)) {
        $sql = "SELECT COUNT(*) FROM " . $db_config['prefix'] . "_" . $module_data . "_money WHERE userid ='" . $info_userdata['userid'] . "' AND money_unit=" . $db->quote($money_unit);
        if ($db->query($sql)->fetchColumn() != 1) {
            nv_redirect_location(NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name);
        }
    }

    // Xử lý loại giao dịch
    unset($global_array_transaction_type['4']);
    if (!$update) {
        unset($global_array_transaction_type['1'], $global_array_transaction_type['2']);
        $transaction_type = 0;
    } else {
        $transaction_type = 1;
    }

    $tpl->assign('USERNAME', $info_userdata['username']);
    $tpl->assign('USERID', $info_userdata['userid']);
    $tpl->assign('CAPTION', $update ? $nv_Lang->getModule('editacount') : $nv_Lang->getModule('creataccount'));
    $tpl->assign('ALLOW_SUB', $update);
}
// Xử lý dữ liệu tài khoản
$accounts = array();
foreach ($array as $row) {
    $row['edit_url'] = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module_name . "&amp;u=" . urlencode($row['username']) . "&amp;money_unit=" . $row['money_unit'] . "&update=1";
    $row['view_url'] = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module_name . "&amp;" . NV_OP_VARIABLE . "=transaction&amp;userid=" . $row['userid'];
    $row['full_name'] = nv_show_name_user($row['first_name'], $row['last_name']);
    $row['created_time'] = nv_date('d/m/Y, H:i', $row['created_time']);
    if (isset($array_users[$row['created_userid']])) {
        $row['created_userid'] = $array_users[$row['created_userid']]['username'];
    } else {
        $row['created_userid'] = $nv_Lang->getModule('addacountsys');
    }
    $row['money_total'] = get_display_money($row['money_total']);
    $accounts[] = $row;
}

$tpl->assign('ACCOUNTS', $accounts);
$tpl->assign('IS_SEARCH', $isSearch);

$contents = $tpl->fetch('main.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
