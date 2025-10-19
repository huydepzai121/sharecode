<?php

/**
 * @Project WALLET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2018 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Friday, March 9, 2018 6:24:54 AM
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

nvUpdateTransactionExpired();

// Thay đổi trạng thái giao dịch
if ($nv_Request->isset_request('ajax_action', 'post')) {
    $transactionid = $nv_Request->get_int('transactionid', 'post', 0);
    $new_vid = $nv_Request->get_int('new_vid', 'post', 0);
    $content = 'NO_' . $transactionid;

    // Kiểm tra quyền
    if ($IS_FULL_ADMIN or !empty($PERMISSION_ADMIN['is_mtransaction'])) {
        $sql = 'SELECT * FROM ' . $db_config['prefix'] . '_' . $module_data . '_transaction WHERE id=' . $transactionid;
        $row = $db->query($sql)->fetch();
        if (isset($row['transaction_status']) and $row['transaction_status'] != $new_vid and $row['transaction_status'] != 4 and $new_vid != 0 and empty($row['is_expired'])) {
            $sql = 'UPDATE ' . $db_config['prefix'] . '_' . $module_data . '_transaction SET
                transaction_status=' . $new_vid . ',
                transaction_time=' . NV_CURRENTTIME . '
            WHERE id=' . $transactionid;
            $db->query($sql);

            if (!empty($row['order_id'])) {
                // Xác định thông tin đơn hàng
                $order_info = $db->query("SELECT * FROM " . $db_config['prefix'] . "_" . $module_data . "_orders WHERE id=" . $row['order_id'])->fetch();

                // Cập nhật trạng thái giao dịch nếu thanh toán hóa đơn của các module khác
                try {
                    $db->query('UPDATE ' . $db_config['prefix'] . '_' . $module_data . '_orders SET
                        paid_status=' . $new_vid . ',
                        paid_time=' . NV_CURRENTTIME . '
                    WHERE id=' . $row['order_id']);
                } catch (Exception $ex) {
                    trigger_error($ex->getMessage());
                }

                // Gọi về module để cập nhật đơn hàng của module
                if (!empty($order_info) and isset($sys_mods[$order_info['order_mod']])) {
                    $order_info['paid_status'] = $new_vid;
                    $order_info['paid_time'] = NV_CURRENTTIME;

                    // Backup lại các biến của module wallet
                    $_module_name = $module_name;
                    $_module_info = $module_info;
                    $_module_file = $module_file;
                    $_module_data = $module_data;
                    $_module_upload = $module_upload;

                    $module_name = $order_info['order_mod'];
                    $module_info = $sys_mods[$order_info['order_mod']];
                    $module_file = $module_info['module_file'];
                    $module_data = $module_info['module_data'];
                    $module_upload = $module_info['module_upload'];

                    // Gọi ra file cập nhật giao dịch
                    try {
                        if (file_exists(NV_ROOTDIR . '/modules/' . $module_file . '/wallet.admin.php')) {
                            define('NV_IS_WALLET_ADMIN', true);
                            require NV_ROOTDIR . '/modules/' . $module_file . '/wallet.admin.php';
                        }
                    } catch (Exception $ex) {
                        trigger_error($ex->getMessage());
                    }

                    // Trả lại các biến backup
                    $module_name = $_module_name;
                    $module_info = $_module_info;
                    $module_file = $_module_file;
                    $module_data = $_module_data;
                    $module_upload = $_module_upload;
                }
            } else {
                // Cập nhật số tiền nếu giao dịch nạp tiền
                update_money($row['userid'], $row['money_total'], $row['money_unit'], $new_vid, $row['transaction_status'], $row['status']);
            }

            $content = 'OK_' . $transactionid;
        }
        $nv_Cache->delMod($module_name);
    }

    include NV_ROOTDIR . '/includes/header.php';
    echo $content;
    include NV_ROOTDIR . '/includes/footer.php';
}

// Chuẩn bị dữ liệu cho template
$template = get_tpl_dir([$global_config['module_theme'], $global_config['admin_theme']], 'admin_future', '/modules/' . $module_file . '/transaction.tpl');
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(NV_ROOTDIR . '/themes/' . $template . '/modules/' . $module_file);

// Gán các biến cơ bản cho template
$tpl->assign('LANG', $nv_Lang);
$tpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$tpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$tpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$tpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$tpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('OP', $op);
$tpl->assign('ASSETS_STATIC_URL', NV_BASE_SITEURL . 'assets/');

// Khởi tạo các biến tìm kiếm
$array_fields_search = [
    'customer_name' => $nv_Lang->getModule('customer_name'),
    'customer_email' => $nv_Lang->getModule('customer_email'),
    'customer_phone' => $nv_Lang->getModule('customer_phone'),
    'customer_address' => $nv_Lang->getModule('customer_address'),
    'customer_info' => $nv_Lang->getModule('customer_info'),
];

$isSearchSubmit = false;
$array_search = [];
$array_search['q'] = $nv_Request->get_title('q', 'get', '');
$array_search['are'] = $nv_Request->get_title('are', 'get', ''); // Các field tìm theo khóa
$array_search['crf'] = $nv_Request->get_title('crf', 'get', ''); // Tạo từ
$array_search['crt'] = $nv_Request->get_title('crt', 'get', ''); // Tạo đến
$array_search['st'] = $nv_Request->get_int('st', 'get', 0); // Cộng tiền hay trừ tiền
$array_search['mo'] = $nv_Request->get_title('mo', 'get', ''); // Loại tiền tệ
$array_search['aou'] = $nv_Request->get_int('aou', 'get', 0); // Admin giao dịch hay thành viên giao dịch
$array_search['tty'] = $nv_Request->get_int('tty', 'get', -1); // Kiểu giao dịch
$array_search['trf'] = $nv_Request->get_title('trf', 'get', ''); // Giao dịch từ ngày
$array_search['trt'] = $nv_Request->get_title('trt', 'get', ''); // Giao dịch đến ngày
$array_search['tst'] = $nv_Request->get_int('tst', 'get', -1); // Trạng thái giao dịch
$array_search['tpa'] = $nv_Request->get_title('tpa', 'get', ''); // Cổng thanh toán
$array_search['per_page'] = $nv_Request->get_int('per_page', 'get', 0); // Số bản ghi

// Xem theo thành viên
$view_userid = $nv_Request->get_int('userid', 'get', 0);
$view_user_info = [];
if ($view_userid) {
    $sql = "SELECT userid, username FROM " . NV_USERS_GLOBALTABLE . " WHERE userid=" . $view_userid;
    $view_user_info = $db->query($sql)->fetch();
    if (empty($view_user_info)) {
        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
    }
}

// Xem theo đơn hàng
$view_orderid = $nv_Request->get_int('orderid', 'get', 0);
$view_order_info = [];
if ($view_orderid) {
    $sql = "SELECT * FROM " . $db_config['prefix'] . '_' . $module_data . "_orders WHERE id=" . $view_orderid;
    $view_order_info = $db->query($sql)->fetch();
    if (empty($view_order_info)) {
        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
    }
}

// Xử lý dữ liệu vào
if (!empty($array_search['are']) and !isset($array_fields_search[$array_search['are']])) {
    $array_search['are'] = '';
}
$array_ele_date = ['crf', 'crt', 'trf', 'trt'];
foreach ($array_ele_date as $f) {
    $fval = $array_search[$f];
    $array_search[$f] = 0;
    if (preg_match('/^([0-9]{2})\.([0-9]{2})\.([0-9]{4})$/', $fval, $m)) {
        $array_search[$f] = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    }
}
if ($array_search['st'] != 1 and $array_search['st'] != -1) {
    $array_search['st'] = 0;
}
if (!empty($array_search['mo']) and !isset($global_array_money_sys[$array_search['mo']])) {
    $array_search['mo'] = '';
}
if ($array_search['aou'] > 2 and $array_search['aou'] < 0) {
    $array_search['aou'] = 0;
}
if ($array_search['tty'] != -1 and !isset($global_array_transaction_type[$array_search['tty']])) {
    $array_search['tty'] = -1;
}
if ($array_search['tst'] != -1 and !isset($global_array_transaction_status[$array_search['tst']])) {
    $array_search['tst'] = -1;
}
if (!empty($array_search['tpa']) and !isset($global_array_payments[$array_search['tpa']])) {
    $array_search['tpa'] = '';
}
if ($array_search['per_page'] > 1000 or $array_search['per_page'] < 1) {
    $array_search['per_page'] = 30;
}

$page = $nv_Request->get_int('page', 'get', 1);
$per_page_old = $nv_Request->get_int('per_page', 'cookie', 50);
$per_page = !empty($array_search['per_page']) ? $array_search['per_page'] : $per_page_old;
if ($per_page_old != $per_page) {
    $nv_Request->set_Cookie('per_page', $per_page, NV_LIVE_COOKIE_TIME);
}

$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op;

// Removed all WHERE conditions as requested

$db->sqlreset();
$db->select('COUNT(*)');
$db->from($db_config['prefix'] . '_' . $module_data . '_transaction tb1');
$db->join('LEFT JOIN ' . NV_USERS_GLOBALTABLE . ' tb2 ON tb1.adminid=tb2.userid LEFT JOIN ' . NV_USERS_GLOBALTABLE . ' tb3 ON tb1.userid=tb3.userid LEFT JOIN ' . NV_USERS_GLOBALTABLE . ' tb4 ON tb1.customer_id=tb4.userid');

// No WHERE conditions applied

$all_page = $db->query($db->sql())->fetchColumn();

$db->order('is_expired ASC, IF(transaction_time=0,created_time,transaction_time) DESC');
$db->limit($per_page);
$db->offset(($page - 1) * $per_page);
$db->select('tb1.*, tb2.username admin_transaction, tb3.username accounttran, tb4.username customer_transaction');
$result = $db->query($db->sql());

$xuatra = $congvao = 0;
$arr_list_transaction = [];
$arrUserId = [];
while ($row = $result->fetch()) {
    if ($row['status'] == -1) {
        $xuatra = $row['money_total'] + $xuatra;
    } else {
        $congvao = $row['money_total'] + $congvao;
    }

    $arr_list_transaction[$row['id']] = [
        'id' => $row['id'], //
        'code' => empty($row['order_id']) ? sprintf('GD%010s', $row['id']) : sprintf('WP%010s', $row['id']),
        'created_time' => date('d/m/Y H:i', $row['created_time']), //
        'status' => ($row['status'] == 1) ? '+' : '-', //
        'money_unit' => $row['money_unit'], //
        'money_total' => get_display_money($row['money_total']), //
        'money_net' => get_display_money($row['money_net']), //
        'accounttran' => empty($row['accounttran']) ? 'N/A' : $row['accounttran'], //
        'userid' => $row['userid'], // Tài khoản được tác động
        'tran_uid' => $row['adminid'] ? $row['adminid'] : $row['customer_id'], // Tài khoản thực hiện giao dịch
        'tran_uname' => ($row['admin_transaction'] ? '<strong>' . $row['admin_transaction'] . '</strong>' : ($row['customer_transaction'] ? $row['customer_transaction'] : 'N/A')), // Tên người thực hiện giao dịch
        'customer_name' => $row['customer_name'], //
        'customer_email' => $row['customer_email'], //
        'customer_phone' => $row['customer_phone'], //
        'customer_address' => $row['customer_address'], //
        'customer_info' => $row['customer_info'], //
        'transaction_id' => $row['transaction_id'], //
        'transaction_status' => $row['transaction_status'], //
        'transaction_time' => $row['transaction_time'], //
        'transaction_data' => $row['transaction_data'], //
        'payment' => $row['payment'], //
        'is_expired' => $row['is_expired'], //
        'view_user' => NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module_name . "&amp;" . NV_OP_VARIABLE . "=" . $op . "&amp;userid=" . $row['userid'], //
        'view_transaction' => NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module_name . "&amp;" . NV_OP_VARIABLE . "=viewtransaction&amp;id=" . $row['id'], //
    ];

    $arrUserId[] = $row['userid'];
}

if (!empty($arrUserId)) {
    $sql = "SELECT userid, username,first_name, last_name FROM " . NV_USERS_GLOBALTABLE . " WHERE userid in (" . implode(',', $arrUserId) . ")";
    $infoUs = $db->query($sql)->fetch();
    $infoUs['fullname'] = nv_show_name_user($infoUs['first_name'], $infoUs['last_name']);
}

foreach ($arr_list_transaction as $k => $v) {
    if ($v['userid'] == $infoUs['userid']) {
        $arr_list_transaction[$k]['customer_name'] = $infoUs['fullname'];
    }
}

$sum = -$xuatra + $congvao;
$sum = get_display_money($sum);

// Gán dữ liệu tìm kiếm
$tpl->assign('DATA_SEARCH', $array_search);

// Gán thông tin xem theo user nếu có
if (!empty($view_user_info)) {
    $tpl->assign('VIEW_USER_INFO', true);
    $tpl->assign('VIEW_USER_NAME', $view_user_info['username']);
    $tpl->assign('VIEW_USER_CANCEL', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Gán thông tin xem theo đơn hàng nếu có
if (!empty($view_order_info)) {
    $tpl->assign('VIEW_ORDER_INFO', true);
    $tpl->assign('VIEW_ORDER_NAME', sprintf('DH%010s', $view_order_info['id']));
    $tpl->assign('VIEW_ORDER_CANCEL', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Gán trạng thái collapse form tìm kiếm
$tpl->assign('COLLAPSE1', $isSearchSubmit ? 'true' : 'false');
$tpl->assign('COLLAPSE2', $isSearchSubmit ? ' in' : '');

// Gán các select box tìm kiếm
$fields_search = [];
foreach ($array_fields_search as $key => $value) {
    $fields_search[] = [
        'key' => $key,
        'title' => $value,
        'selected' => ($key == $array_search['are']) ? ' selected="selected"' : ''
    ];
}
$tpl->assign('FIELDS_SEARCH', $fields_search);

// Gán loại giao dịch
$transaction_types = [];
foreach ([1, -1] as $val) {
    $transaction_types[] = [
        'key' => $val,
        'title' => $val == 1 ? $nv_Lang->getModule('transaction1') : $nv_Lang->getModule('transaction2'),
        'selected' => $val == $array_search['st'] ? ' selected="selected"' : ''
    ];
}
$tpl->assign('ST', $transaction_types);

// Gán đơn vị tiền tệ
$money_sys = [];
foreach ($global_array_money_sys as $row) {
    $money_sys[] = [
        'key' => $row['code'],
        'title' => $row['code'],
        'selected' => $row['code'] == $array_search['mo'] ? ' selected="selected"' : ''
    ];
}
$tpl->assign('MONEY_SYS', $money_sys);

// Gán loại giao dịch
$transaction_type = [];
foreach ($global_array_transaction_type as $key => $value) {
    $transaction_type[] = [
        'key' => $key,
        'title' => $value,
        'selected' => $key == $array_search['tty'] ? ' selected="selected"' : ''
    ];
}
$tpl->assign('TTY', $transaction_type);

// Gán trạng thái giao dịch
$transaction_status = [];
foreach ($global_array_transaction_status as $key => $value) {
    $transaction_status[] = [
        'key' => $key,
        'title' => $value,
        'selected' => $key == $array_search['tst'] ? ' selected="selected"' : ''
    ];
}
$tpl->assign('TST', $transaction_status);

// Gán phương thức thanh toán
$payment_methods = [];
foreach ($global_array_payments as $row) {
    $payment_methods[] = [
        'key' => $row['payment'],
        'title' => $row['paymentname'],
        'selected' => $row['payment'] == $array_search['tpa'] ? ' selected="selected"' : ''
    ];
}
$tpl->assign('TPA', $payment_methods);

// Gán danh sách giao dịch
$tpl->assign('TRANSACTIONS', $arr_list_transaction);

// Gán phân trang
if (!empty($generate_page)) {
    $tpl->assign('GENERATE_PAGE', $generate_page);
}

$contents = $tpl->fetch('transaction.tpl');

$page_title = $nv_Lang->getModule('transaction');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
