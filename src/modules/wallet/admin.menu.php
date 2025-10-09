<?php

/**
 * @Project WALLET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2018 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Friday, March 9, 2018 6:24:54 AM
 */

if (!defined('NV_ADMIN')) {
    die('Stop!!!');
}

global $nv_Cache, $global_array_admins, $global_array_admin_groups, $db_config;

$sql = "SELECT * FROM " . $db_config['prefix'] . "_" . $module_data . "_admin_groups ORDER BY group_title ASC";
$global_array_admin_groups = $nv_Cache->db($sql, 'gid', $module_name);

if (!function_exists('nv_wallet_array_admins')) {
    /**
     * nv_wallet_array_admins()
     *
     * @param mixed $module_data
     * @return
     */
    function nv_wallet_array_admins($module_data)
    {
        global $db_slave, $db_config;

        $array = array();
        $sql = 'SELECT * FROM ' . $db_config['prefix'] . '_' . $module_data . '_admins ORDER BY admin_id ASC';
        $result = $db_slave->query($sql);

        while ($row = $result->fetch()) {
            $array[$row['admin_id']] = $row;
        }

        return $array;
    }
}

$is_refresh = false;
$global_array_admins = nv_wallet_array_admins($module_data);

if (!empty($module_info['admins'])) {
    $module_admin = explode(',', $module_info['admins']);
    foreach ($module_admin as $userid_i) {
        if (!isset($global_array_admins[$userid_i])) {
            $db->query('INSERT INTO ' . $db_config['prefix'] . '_' . $module_data . '_admins (
                admin_id, gid, add_time, update_time
            ) VALUES (
                ' . $userid_i . ', 0, ' . NV_CURRENTTIME . ', 0
            )');
            $is_refresh = true;
        }
    }
}
if ($is_refresh) {
    $global_array_admins = nv_wallet_array_admins($module_data);
}

$IS_FULL_ADMIN = (defined('NV_IS_SPADMIN') or defined('NV_IS_GODADMIN')) ? true : false;
$PERMISSION_ADMIN = [];
if (isset($global_array_admins[$admin_info['admin_id']]) and isset($global_array_admin_groups[$global_array_admins[$admin_info['admin_id']]['gid']])) {
    $PERMISSION_ADMIN = $global_array_admin_groups[$global_array_admins[$admin_info['admin_id']]['gid']];
}

$allow_func = ['main'];
$allow_func = ['add_bank_info'];
$submenu['add_bank_info'] = "Quản lý tài khoản";

// Quyền xem và cập nhật ví tiền
if ($IS_FULL_ADMIN or !empty($PERMISSION_ADMIN['is_wallet'])) {
    $allow_func[] = 'addacount';
    $allow_func[] = 'config_bank_info';
}

// Quyền xem giao dịch. Quản lý giao dịch check riêng trong function
if ($IS_FULL_ADMIN or !empty($PERMISSION_ADMIN['is_vtransaction']) or !empty($PERMISSION_ADMIN['is_mtransaction'])) {

}

$allow_func[] = 'transaction';
$allow_func[] = 'viewtransaction';
$submenu['transaction'] = $nv_Lang->getModule('transaction');

// Quyền tạo giao dịch
if ($IS_FULL_ADMIN or !empty($PERMISSION_ADMIN['is_mtransaction'])) {
}
$allow_func[] = 'add_transaction';
$submenu['add_transaction'] = $nv_Lang->getModule('add_transaction');
