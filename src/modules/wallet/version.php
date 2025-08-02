<?php

/**
 * @Project WALLET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2018 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Friday, March 9, 2018 6:24:54 AM
 */

if (!defined('NV_MAINFILE'))
    die('Stop!!!');

$module_version = array(
    "name" => "Wallet",
    "modfuncs" => "main,pay,complete,money,exchange,historyexchange,recharge, manager_info, manager_money",
    "submenu" => "main,money,exchange,historyexchange, manager_info, manager_money",
    "is_sysmod" => 1,
    "virtual" => 1,
    'version' => '4.5.02',
    'date' => 'Saturday, September 24, 2022 15:00:00 GMT+07:00',
    "author" => "VINADES (contact@vinades.vn)",
    "uploads_dir" => array($module_name),
    "note" => "Quản lý tiền thành viên",
    'uploads_dir' => [
        $module_upload,
        $module_upload . '/wellet',
    ],
    'files_dir' => [
        $module_upload . '/wellet'
    ],
);
