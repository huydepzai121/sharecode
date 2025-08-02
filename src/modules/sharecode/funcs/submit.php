<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

// Kiểm tra quyền submit
if (!defined('NV_IS_USER') && empty($module_config['allow_guest_submit'])) {
    $redirect_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=submit';
    $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login&nv_redirect=' . nv_base64_encode($redirect_url);
    nv_redirect_location($login_url);
}

// Xử lý submit form
if ($nv_Request->isset_request('submit_product', 'post')) {
    $title = $nv_Request->get_textarea('title', 'post', '');
    $catid = $nv_Request->get_int('catid', 'post', 0);
    $description = $nv_Request->get_textarea('description', 'post', '');
    $demo_link = $nv_Request->get_textarea('demo_link', 'post', '');
    $fee_type = $nv_Request->get_string('fee_type', 'post', 'free');
    $fee_amount = $nv_Request->get_float('fee_amount', 'post', 0);
    $keywords = $nv_Request->get_textarea('keywords', 'post', '');
    $tags = $nv_Request->get_textarea('tags', 'post', '');
    $download_link_type = $nv_Request->get_string('download_link_type', 'post', 'file');
    $download_link = $nv_Request->get_textarea('download_link', 'post', '');
    
    $errors = [];
    
    // Validation
    if (empty($title)) {
        $errors[] = 'Vui lòng nhập tiêu đề sản phẩm';
    }
    if ($catid <= 0) {
        $errors[] = 'Vui lòng chọn danh mục';
    }
    if (empty($description)) {
        $errors[] = 'Vui lòng nhập mô tả sản phẩm';
    }
    if ($fee_type == 'paid' && $fee_amount <= 0) {
        $errors[] = 'Vui lòng nhập giá bán hợp lệ';
    }
    if ($download_link_type == 'external' && empty($download_link)) {
        $errors[] = 'Vui lòng nhập link tải xuống';
    }
    
    // Kiểm tra category tồn tại
    if ($catid > 0) {
        $sql_cat = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $catid . " AND status=1";
        $cat_exists = $db->query($sql_cat)->fetchColumn();
        if (!$cat_exists) {
            $errors[] = 'Danh mục không hợp lệ';
        }
    }
    
    if (empty($errors)) {
        try {
            $db->beginTransaction();
            
            // Tạo alias
            $alias = change_alias($title);
            $check_alias = 0;
            $base_alias = $alias;
            while (true) {
                $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE alias=" . $db->quote($alias);
                if (!$db->query($sql_check)->fetchColumn()) {
                    break;
                }
                $check_alias++;
                $alias = $base_alias . '-' . $check_alias;
            }
            
            // Xác định thông tin user
            $submit_userid = defined('NV_IS_USER') ? $user_info['userid'] : 0;
            $submit_username = defined('NV_IS_USER') ? $user_info['username'] : 'Guest';
            
            // Insert sản phẩm với trạng thái chờ duyệt
            $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (
                title, alias, catid, description, demo_link, keywords, 
                fee_type, fee_amount, download_link_type, download_link,
                userid, username, add_time, status
            ) VALUES (
                " . $db->quote($title) . ",
                " . $db->quote($alias) . ",
                " . $catid . ",
                " . $db->quote($description) . ",
                " . $db->quote($demo_link) . ",
                " . $db->quote($keywords) . ",
                " . $db->quote($fee_type) . ",
                " . $fee_amount . ",
                " . $db->quote($download_link_type) . ",
                " . $db->quote($download_link) . ",
                " . $submit_userid . ",
                " . $db->quote($submit_username) . ",
                " . NV_CURRENTTIME . ",
                0
            )";
            
            if ($db->exec($sql_insert)) {
                $source_id = $db->lastInsertId();
                // Xử lý tags
                if (!empty($tags)) {
                    $tag_array = array_map('trim', explode(',', $tags));
                    foreach ($tag_array as $tag_name) {
                        if (!empty($tag_name)) {
                            $tag_alias = change_alias($tag_name);
                            
                            // Kiểm tra tag đã tồn tại chưa
                            $sql_tag = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags WHERE alias=" . $db->quote($tag_alias);
                            $tag_id = $db->query($sql_tag)->fetchColumn();
                            
                            if (!$tag_id) {
                                // Tạo tag mới
                                $sql_new_tag = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, add_time) VALUES (" . $db->quote($tag_name) . ", " . $db->quote($tag_alias) . ", " . NV_CURRENTTIME . ")";
                                $db->exec($sql_new_tag);
                                $tag_id = $db->lastInsertId();
                            }
                            
                            // Liên kết tag với source
                            $sql_source_tag = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES (" . $source_id . ", " . $tag_id . ")";
                            $db->exec($sql_source_tag);
                        }
                    }
                }
                
                // Gửi email thông báo nếu được cấu hình
                $sql_config = "SELECT config_name, config_value FROM " . NV_CONFIG_GLOBALTABLE . " WHERE lang='" . NV_LANG_DATA . "' AND module='" . $module_name . "'";
                $result_config = $db->query($sql_config);
                $module_config = [];
                while ($row_config = $result_config->fetch()) {
                    $module_config[$row_config['config_name']] = $row_config['config_value'];
                }
                
                if (!empty($module_config['email_notify_new_source'])) {
                    // Lấy email admin
                    $sql_admin = "SELECT email, first_name, last_name FROM " . NV_USERS_GLOBALTABLE . " WHERE level=1 AND active=1 LIMIT 1";
                    $admin_info_notify = $db->query($sql_admin)->fetch();
                    
                    if ($admin_info_notify) {
                        $admin_name = trim($admin_info_notify['first_name'] . ' ' . $admin_info_notify['last_name']);
                        if (empty($admin_name)) {
                            $admin_name = 'Admin';
                        }
                        
                        $subject = '[' . $global_config['site_name'] . '] Sản phẩm mới chờ duyệt';
                        $message = "Xin chào {$admin_name},\n\n";
                        $message .= "Có sản phẩm mới được đăng và đang chờ duyệt:\n\n";
                        $message .= "Tiêu đề: {$title}\n";
                        $message .= "Mô tả: {$description}\n";
                        $message .= "Loại phí: " . ($fee_type == 'free' ? 'Miễn phí' : ($fee_type == 'paid' ? 'Trả phí: ' . number_format($fee_amount, 0, ',', '.') . ' VND' : 'Liên hệ')) . "\n";
                        $message .= "Người đăng: {$submit_username}\n";
                        $message .= "Thời gian: " . date('d/m/Y H:i', NV_CURRENTTIME) . "\n\n";
                        $message .= "Duyệt sản phẩm: " . NV_MY_DOMAIN . NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=pending\n\n";
                        $message .= "Trân trọng,\n";
                        $message .= $global_config['site_name'];
                        
                        nv_sharecode_send_email_notification($admin_info_notify['email'], $admin_name, $subject, $message);
                    }
                }
                
                $db->commit();
                
                nv_info_die('Thành công', 'Đăng sản phẩm thành công!', 'Sản phẩm của bạn đã được gửi và đang chờ admin duyệt. Bạn sẽ nhận được thông báo khi sản phẩm được phê duyệt.', 200);
            } else {
                throw new Exception('Không thể lưu sản phẩm');
            }
        } catch (Exception $e) {
            $db->rollback();
            $errors[] = 'Có lỗi xảy ra: ' . $e->getMessage();
        }
    }
}

// Breadcrumb
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=submit';
$array_mod_title[] = [
    'title' => 'Đăng mã nguồn',
    'link' => nv_url_rewrite($base_url, true)
];

// SEO
$page_title = 'Đăng bán sản phẩm';
$key_words = 'đăng bán, sản phẩm, sharecode';
$description = 'Đăng bán sản phẩm lên website';

// Lấy danh sách categories
$categories = [];
$sql_cats = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE status=1 ORDER BY weight ASC";
$result_cats = $db->query($sql_cats);
while ($row = $result_cats->fetch()) {
    $categories[] = $row;
}

// Initialize errors array
$errors = [];

$contents = nv_theme_sharecode_submit($categories, $errors);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';