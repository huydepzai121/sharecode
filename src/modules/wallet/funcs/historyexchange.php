<?php

/**
 * @Project WALLET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2018 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Friday, March 9, 2018 6:24:54 AM
 */

if (!defined('NV_IS_MOD_WALLET'))
    die('Stop!!!');

if (!defined('NV_IS_USER')) {
    $redirect = nv_url_rewrite(NV_BASE_SITEURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=" . $op, true);
    nv_redirect_location(NV_BASE_SITEURL . "index.php?" . NV_NAME_VARIABLE . "=users&" . NV_OP_VARIABLE . "=login&nv_redirect=" . nv_redirect_encrypt($redirect));
}

$page_url = $base_url = NV_BASE_SITEURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&amp;" . NV_NAME_VARIABLE . "=" . $module_name . "&amp;" . NV_OP_VARIABLE . "=" . $op;
$page_title = $nv_Lang->getModule('historyexchange');
$page = 1;
if (isset($array_op[1]) and preg_match('/^page\-([0-9]+)$/', $array_op[1], $m)) {
    $page = intval($m[1]);
}
if ($page < 1 or $page > 9999999999) {
    $page = 1;
}

if ($page > 1) {
    $page_url .= '/page-' . $page;
}
$canonicalUrl = getCanonicalUrl($page_url);

$per_page = 30;

$db->sqlreset();
$db->from($db_config['prefix'] . "_" . $module_data . "_transaction");
$db->where("userid = " . $user_info['userid']);

$db->select('COUNT(*)');
$result = $db->query($db->sql());
$all_page = $result->fetchColumn();

betweenURLs($page, ceil($all_page/$per_page), $base_url, '/page-', $prevPage, $nextPage);

$db->select('*');
$db->order('created_time DESC');
$db->limit($per_page);
$db->offset(($page - 1) * $per_page);

$result = $db->query($db->sql());

$array = array();
while ($row = $result->fetch()) {
    if (!empty($row['order_id'])) {
        $row['transaction_code'] = sprintf('WP%010s', $row['id']);
    } else {
        $row['transaction_code'] = sprintf('GD%010s', $row['id']);
    }
    $detail = json_decode($row['detail_money'], true);
    $row['status'] = empty($row['order_id']) ? ($row['status'] == 1 ? '+' : '-') : '';
    if ($row['status'] == '+') {
        $total = floatval($detail['money_total']) + floatval($row['money_net']);
    } else {
        $total = floatval($detail['money_total']) - floatval($row['money_net']);
    }
    $money_total1 = "<span class='badge gradient-1 badge-warning'>" . number_format($detail['money_total'], 0, ',', '.') . "</span>";
    $money_total2 = "<span class='badge gradient-2 badge-danger'>" . number_format($row['money_net'], 0, ',', '.') . "</span>";
    $money_total3 = "<span class='badge gradient-3 badge-success'>" . number_format($total, 0, ',', '.') . "</span>";
    $row['detail'] = $money_total1 . ' ' . $row['status'] . ' ' . $money_total2 . ' = ' . $money_total3;
    $array[$row['id']] = $row;
}

$generate_page = nv_alias_page($page_title, $base_url, $all_page, $per_page, $page);
$contents = nv_wallet_history_exchange($array, $generate_page, $page, $per_page);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
