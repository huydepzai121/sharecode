<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

$module_version = [
    'name' => 'ShareCode', // Tieu de module
    'modfuncs' => 'main,category,detail,download,tag,purchase,history,submit,author,revenue,favorites', // Cac function co block
    'change_alias' => 'category,detail,tag,history,submit,author,revenue',
    'submenu' => 'detail,purchase,history,submit,author,revenue,favorites',
    'is_sysmod' => 0, // 1:0 => Co phai la module he thong hay khong
    'virtual' => 1, // 1:0 => Co cho phep ao hao module hay khong
    'version' => '2.0.00', // Phien ban cua modle
    'date' => 'Saturday, January 18, 2025 12:00:00 PM GMT+07:00', // Ngay phat hanh phien ban
    'author' => 'Nguyễn Lâm <lamnv@vinades.vn>', // Tac gia
    'note' => 'Module marketplace chia sẻ mã nguồn với hệ thống thanh toán và giỏ hàng', // Ghi chu
    'uploads_dir' => [
        $module_upload,
        $module_upload . '/images',
        $module_upload . '/files',
        $module_upload . '/sources',
        $module_upload . '/thumbnails'
    ],
    'files_dir' => [
        $module_upload . '/files',
        $module_upload . '/sources'
    ],
    'icon' => 'fa-solid fa-shopping-cart',
];
