<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    exit('Stop!!!');
}

$page_title = 'Cấu hình module';


$sql = "SELECT config_name, config_value FROM " . NV_CONFIG_GLOBALTABLE . " WHERE lang='" . NV_LANG_DATA . "' AND module='" . $module_name . "'";
$result = $db->query($sql);
$module_config = [];
while ($row = $result->fetch()) {
    $module_config[$row['config_name']] = $row['config_value'];
}


$default_config = [
    'items_per_page' => 12,
    'allow_guest_download' => 1,
    'allow_guest_submit' => 1,
    'require_login_paid' => 1,
    'auto_approve_reviews' => 0,
    'max_file_size' => 50,
    'allowed_extensions' => 'zip,rar,7z,tar,gz,doc,docx,pdf,txt',
    'watermark_enable' => 0,
    'watermark_text' => $global_config['site_name'],
    'email_notify_new_source' => 1,
    'email_notify_new_review' => 1,
    'author_commission_rate' => 70
];


foreach ($default_config as $key => $value) {
    if (!isset($module_config[$key])) {
        $module_config[$key] = $value;
    }
}


if ($nv_Request->isset_request('save_config', 'post')) {
    try {
        $error = [];
        $new_config = [];

        $new_config['items_per_page'] = $nv_Request->get_int('items_per_page', 'post', 12);
        $new_config['allow_guest_download'] = $nv_Request->get_int('allow_guest_download', 'post', 0);
        $new_config['allow_guest_submit'] = $nv_Request->get_int('allow_guest_submit', 'post', 0);
        $new_config['require_login_paid'] = $nv_Request->get_int('require_login_paid', 'post', 0);
        $new_config['auto_approve_reviews'] = $nv_Request->get_int('auto_approve_reviews', 'post', 0);
        $new_config['max_file_size'] = $nv_Request->get_int('max_file_size', 'post', 50);
        $new_config['allowed_extensions'] = $nv_Request->get_title('allowed_extensions', 'post', '');
        $new_config['watermark_enable'] = $nv_Request->get_int('watermark_enable', 'post', 0);
        $new_config['watermark_text'] = $nv_Request->get_title('watermark_text', 'post', '');
        $new_config['email_notify_new_source'] = $nv_Request->get_int('email_notify_new_source', 'post', 0);
        $new_config['email_notify_new_review'] = $nv_Request->get_int('email_notify_new_review', 'post', 0);
        $new_config['author_commission_rate'] = $nv_Request->get_int('author_commission_rate', 'post', 70);


        if ($new_config['items_per_page'] < 1 || $new_config['items_per_page'] > 100) {
            $error[] = 'Số item trên trang phải từ 1 đến 100';
        }

        if ($new_config['max_file_size'] < 1 || $new_config['max_file_size'] > 1000) {
            $error[] = 'Kích thước file tối đa phải từ 1MB đến 1000MB';
        }

        if (empty($new_config['allowed_extensions'])) {
            $error[] = 'Phần mở rộng file không được để trống';
        }

        if ($new_config['author_commission_rate'] < 0 || $new_config['author_commission_rate'] > 100) {
            $error[] = 'Tỷ lệ hoa hồng phải từ 0% đến 100%';
        }

        if (empty($error)) {

            $db->query("DELETE FROM " . NV_CONFIG_GLOBALTABLE . " WHERE lang='" . NV_LANG_DATA . "' AND module='" . $module_name . "'");


            foreach ($new_config as $config_name => $config_value) {
                $sql = "INSERT INTO " . NV_CONFIG_GLOBALTABLE . " (lang, module, config_name, config_value) VALUES (
                    '" . NV_LANG_DATA . "',
                    '" . $module_name . "',
                    " . $db->quote($config_name) . ",
                    " . $db->quote($config_value) . "
                )";
                $db->query($sql);
            }

            $module_config = $new_config;
            $success_message = 'Lưu cấu hình thành công';
        }
    } catch (Exception $e) {
        pr($e->getMessage());
    }
}

$xtpl = new XTemplate('config.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);

$xtpl->assign('LANG', $lang_module);
$xtpl->assign('GLANG', $lang_global);
$xtpl->assign('MODULE_NAME', $module_name);
$xtpl->assign('OP', $op);
$xtpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);


$xtpl->assign('CONFIG', $module_config);


$xtpl->assign('ALLOW_GUEST_DOWNLOAD_CHECKED', $module_config['allow_guest_download'] ? 'checked="checked"' : '');
$xtpl->assign('ALLOW_GUEST_SUBMIT_CHECKED', $module_config['allow_guest_submit'] ? 'checked="checked"' : '');
$xtpl->assign('REQUIRE_LOGIN_PAID_CHECKED', $module_config['require_login_paid'] ? 'checked="checked"' : '');
$xtpl->assign('AUTO_APPROVE_REVIEWS_CHECKED', $module_config['auto_approve_reviews'] ? 'checked="checked"' : '');
$xtpl->assign('WATERMARK_ENABLE_CHECKED', $module_config['watermark_enable'] ? 'checked="checked"' : '');
$xtpl->assign('EMAIL_NOTIFY_NEW_SOURCE_CHECKED', $module_config['email_notify_new_source'] ? 'checked="checked"' : '');
$xtpl->assign('EMAIL_NOTIFY_NEW_REVIEW_CHECKED', $module_config['email_notify_new_review'] ? 'checked="checked"' : '');


if (!empty($success_message)) {
    $xtpl->assign('SUCCESS_MESSAGE', $success_message);
    $xtpl->parse('main.success');
}


if (!empty($error)) {
    foreach ($error as $err) {
        $xtpl->assign('ERROR', $err);
        $xtpl->parse('main.error');
    }
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
