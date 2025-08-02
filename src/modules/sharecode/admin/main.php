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

$page_title = 'Trang chủ ShareCode';

// Use modern Smarty templating
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('main.tpl'));
$tpl->assign('LANG', $nv_Lang);
$tpl->assign('MODULE_NAME', $module_name);

// Thêm các biến cần thiết cho template
$lang_module['admin_main'] = 'Quản lý ShareCode';

// Lấy thống kê
$stats = nv_admin_sharecode_get_statistics();
$tpl->assign('STATS', $stats);

// Danh sách sources mới nhất
$sources_data = nv_admin_sharecode_get_sources([], 1, 10);
$sources = [];

if (!empty($sources_data['data'])) {
    foreach ($sources_data['data'] as $source) {
        $source['add_time_format'] = nv_date('d/m/Y H:i', $source['add_time']);
        $source['status_text'] = $source['status'] == 1 ? 'Hoạt động' : ($source['status'] == 0 ? 'Chờ duyệt' : 'Từ chối');
        $source['status_class'] = $source['status'] == 1 ? 'success' : ($source['status'] == 0 ? 'warning' : 'danger');
        $source['fee_text'] = $source['fee_type'] == 'free' ? 'Miễn phí' : number_format($source['fee_amount']) . ' VNĐ';
        $source['fee_class'] = $source['fee_type'] == 'free' ? 'success' : 'warning';
        
        $sources[] = $source;
    }
}

$tpl->assign('SOURCES', $sources);

// Base URL for actions
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;
$tpl->assign('BASE_URL', $base_url);

// Hiển thị template
$contents = $tpl->fetch('main.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
