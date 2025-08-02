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

$page_title = 'Quản lý mã nguồn';

// Use modern Smarty templating
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('sources.tpl'));
$tpl->assign('LANG', $lang_module);
$tpl->assign('GLANG', $lang_global);
$tpl->assign('MODULE_NAME', $module_name);

$action = $nv_Request->get_title('action', 'get', '');
$id = $nv_Request->get_int('id', 'get', 0);
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = $nv_Request->get_int('per_page', 'get', 20);

// Search parameters
$array_search = [];
$array_search['q'] = $nv_Request->get_title('q', 'get', '');
$array_search['catid'] = $nv_Request->get_int('catid', 'get', 0);
$array_search['status'] = $nv_Request->get_int('status', 'get', -1);
$array_search['fee_type'] = $nv_Request->get_title('fee_type', 'get', '');

// Nếu không có action và không có id thì mặc định hiển thị danh sách
if (empty($action) && $id == 0) {
    $action = 'list';
}

// Xử lý xóa source với AJAX
if ($action == 'delete' && $id > 0) {
    $checksess = $nv_Request->get_title('checksess', 'post', '');
    if ($checksess == md5($id . NV_CHECK_SESSION)) {
        if (nv_admin_sharecode_delete_source($id)) {
            nv_jsonOutput([
                'status' => 'OK',
                'mess' => 'Xóa mã nguồn thành công'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'ERROR',
                'mess' => 'Lỗi khi xóa mã nguồn'
            ]);
        }
    }
    nv_jsonOutput([
        'status' => 'ERROR', 
        'mess' => 'Lỗi xác thực'
    ]);
}

// Xử lý bulk actions
if ($nv_Request->isset_request('bulk_action', 'post')) {
    $action_type = $nv_Request->get_title('action_type', 'post', '');
    $ids = $nv_Request->get_array('ids', 'post', []);
    
    if (!empty($ids) && in_array($action_type, ['delete', 'activate', 'deactivate'])) {
        $success_count = 0;
        foreach ($ids as $source_id) {
            if ($action_type == 'delete') {
                if (nv_admin_sharecode_delete_source($source_id)) {
                    $success_count++;
                }
            } elseif ($action_type == 'activate') {
                $db->query("UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources SET status=1 WHERE id=" . intval($source_id));
                $success_count++;
            } elseif ($action_type == 'deactivate') {
                $db->query("UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources SET status=0 WHERE id=" . intval($source_id));
                $success_count++;
            }
        }
        
        nv_jsonOutput([
            'status' => 'OK',
            'mess' => sprintf('Đã xử lý %d mã nguồn', $success_count)
        ]);
    }
    
    nv_jsonOutput([
        'status' => 'ERROR',
        'mess' => 'Thao tác không hợp lệ'
    ]);
}

// Xử lý thêm/sửa source
if ($nv_Request->isset_request('save', 'post')) {
    $error = [];
    $post = [];
    
    $post['title'] = $nv_Request->get_title('title', 'post', '');
    $post['alias'] = $nv_Request->get_title('alias', 'post', '');
    $post['short_description'] = $nv_Request->get_textarea('short_description', 'post', ''); // Renamed from description (issue #1)
    $post['detailed_description'] = $nv_Request->get_editor('detailed_description', 'post', ''); // New detailed description (issue #1)
    $post['catid'] = $nv_Request->get_int('catid', 'post', 0);
    $post['download_link_type'] = $nv_Request->get_title('download_link_type', 'post', 'internal');
    $post['download_link'] = $nv_Request->get_textarea('download_link', 'post', '');
    $post['external_source_link'] = $nv_Request->get_textarea('external_source_link', 'post', ''); // New external source field (issue #1)
    $post['demo_link'] = $nv_Request->get_textarea('demo_link', 'post', '');
    $post['fee_type'] = $nv_Request->get_title('fee_type', 'post', 'free');
    $post['fee_amount'] = $nv_Request->get_float('fee_amount', 'post', 0);
    $post['keywords'] = $nv_Request->get_title('keywords', 'post', ''); // This will be moved in template (issue #1)
    $post['tags'] = $nv_Request->get_title('tags', 'post', ''); // New select2 tags field (issue #1)
    $post['status'] = $nv_Request->get_int('status', 'post', 1);
    $post['tag_ids'] = $nv_Request->get_array('tag_ids', 'post', []);
    
    // Avatar/background image field (issue #1)
    $post['avatar'] = '';
    $post['background_image'] = '';
    
    // Contact fields
    $post['contact_phone'] = $nv_Request->get_title('contact_phone', 'post', '');
    $post['contact_email'] = $nv_Request->get_title('contact_email', 'post', '');
    $post['contact_skype'] = $nv_Request->get_title('contact_skype', 'post', '');
    $post['contact_telegram'] = $nv_Request->get_title('contact_telegram', 'post', '');
    $post['contact_zalo'] = $nv_Request->get_title('contact_zalo', 'post', '');
    $post['contact_facebook'] = $nv_Request->get_title('contact_facebook', 'post', '');
    $post['contact_website'] = $nv_Request->get_title('contact_website', 'post', '');
    $post['contact_address'] = $nv_Request->get_textarea('contact_address', 'post', '');

    // Debug: Kiểm tra tag_ids được gửi lên
    // var_dump('Tag IDs received:', $post['tag_ids']); // Uncomment để debug
    
    // Enhanced validation (issue #1)
    if (empty($post['title'])) {
        $error[] = 'Tên mã nguồn không được để trống';
    } elseif (strlen($post['title']) < 3) {
        $error[] = 'Tên mã nguồn phải có ít nhất 3 ký tự';
    } elseif (strlen($post['title']) > 255) {
        $error[] = 'Tên mã nguồn không được vượt quá 255 ký tự';
    }
    
    if ($post['catid'] <= 0) {
        $error[] = 'Vui lòng chọn danh mục phù hợp cho mã nguồn';
    }
    
    if (empty($post['short_description'])) {
        $error[] = 'Mô tả ngắn không được để trống';
    } elseif (strlen($post['short_description']) < 10) {
        $error[] = 'Mô tả ngắn phải có ít nhất 10 ký tự';
    }
    
    // Validate download links based on type
    if ($post['download_link_type'] == 'external' && empty($post['download_link'])) {
        $error[] = 'Vui lòng nhập link download bên ngoài';
    } elseif ($post['download_link_type'] == 'external' && !filter_var($post['download_link'], FILTER_VALIDATE_URL)) {
        $error[] = 'Link download không hợp lệ';
    }
    
    // Validate fee amount if paid
    if ($post['fee_type'] == 'paid' && $post['fee_amount'] <= 0) {
        $error[] = 'Vui lòng nhập số tiền hợp lệ cho mã nguồn trả phí';
    }
    
    // Validate contact info if fee type is contact
    if ($post['fee_type'] == 'contact') {
        $contact_fields = ['contact_phone', 'contact_email', 'contact_skype', 'contact_telegram', 'contact_zalo', 'contact_facebook', 'contact_website'];
        $has_contact = false;
        foreach ($contact_fields as $field) {
            if (!empty($post[$field])) {
                $has_contact = true;
                break;
            }
        }
        if (!$has_contact) {
            $error[] = 'Vui lòng nhập ít nhất một thông tin liên hệ khi chọn loại phí "Liên hệ"';
        }
    }
    
    // Xử lý upload file mã nguồn
    $file_info = [];
    if (isset($_FILES['source_file']) && $_FILES['source_file']['error'] == UPLOAD_ERR_OK) {
        $upload_info = $_FILES['source_file'];
        $file_ext = strtolower(pathinfo($upload_info['name'], PATHINFO_EXTENSION));
        $allowed_exts = ['zip', 'rar', '7z', 'tar', 'gz'];
        
        // Kiểm tra extension cho file .tar.gz
        if ($file_ext == 'gz' && substr(strtolower($upload_info['name']), -7) == '.tar.gz') {
            $file_ext = 'tar.gz';
            $allowed_exts[] = 'tar.gz';
        }
        
        if (!in_array($file_ext, $allowed_exts)) {
            $error[] = 'File không đúng định dạng. Chỉ chấp nhận: ' . implode(', ', $allowed_exts);
        } elseif ($upload_info['size'] > 100 * 1024 * 1024) { // 100MB limit
            $error[] = 'File không được vượt quá 100MB';
        } else {
            // Tạo tên file unique
            $file_name = $upload_info['name'];
            $file_path = 'files/' . date('Y/m/d') . '/';
            $full_upload_dir = NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $file_path;
            
            // Tạo thư mục nếu chưa tồn tại
            if (!is_dir($full_upload_dir)) {
                nv_mkdir(NV_UPLOADS_REAL_DIR . '/' . $module_upload, $file_path);
            }
            
            // Tạo tên file unique để tránh trùng lặp
            $unique_name = date('YmdHis') . '_' . nv_genpass(6) . '.' . $file_ext;
            $full_file_path = $full_upload_dir . $unique_name;
            
            if (move_uploaded_file($upload_info['tmp_name'], $full_file_path)) {
                $file_info = [
                    'file_path' => $file_path . $unique_name,
                    'file_name' => $file_name,
                    'file_size' => $upload_info['size']
                ];
            } else {
                $error[] = 'Lỗi khi upload file';
            }
        }
    } elseif ($id == 0) {
        // Bắt buộc phải có file khi thêm mới
        $error[] = 'Vui lòng chọn file mã nguồn để upload';
    }
    
    // Auto-fill alias from title (issue #1)
    if (empty($post['alias'])) {
        $post['alias'] = nv_admin_sharecode_create_alias($post['title'], 'sources', $id);
    } else {
        // Clean up manually entered alias
        $post['alias'] = nv_admin_sharecode_create_alias($post['alias'], 'sources', $id);
    }
    
    if (!nv_admin_sharecode_check_alias($post['alias'], 'sources', $id)) {
        $error[] = 'Liên kết tĩnh "' . $post['alias'] . '" đã tồn tại. Vui lòng sử dụng liên kết khác.';
    }
    
    if (empty($error)) {
        if ($id > 0) {
            // Cập nhật
            $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources SET 
                    title=" . $db->quote($post['title']) . ",
                    alias=" . $db->quote($post['alias']) . ",
                    short_description=" . $db->quote($post['short_description']) . ",
                    detailed_description=" . $db->quote($post['detailed_description']) . ",
                    catid=" . $post['catid'] . ",
                    download_link_type=" . $db->quote($post['download_link_type']) . ",
                    download_link=" . $db->quote($post['download_link']) . ",
                    external_source_link=" . $db->quote($post['external_source_link']) . ",
                    demo_link=" . $db->quote($post['demo_link']) . ",
                    fee_type=" . $db->quote($post['fee_type']) . ",
                    fee_amount=" . $post['fee_amount'] . ",
                    keywords=" . $db->quote($post['keywords']) . ",
                    contact_phone=" . $db->quote($post['contact_phone']) . ",
                    contact_email=" . $db->quote($post['contact_email']) . ",
                    contact_skype=" . $db->quote($post['contact_skype']) . ",
                    contact_telegram=" . $db->quote($post['contact_telegram']) . ",
                    contact_zalo=" . $db->quote($post['contact_zalo']) . ",
                    contact_facebook=" . $db->quote($post['contact_facebook']) . ",
                    contact_website=" . $db->quote($post['contact_website']) . ",
                    contact_address=" . $db->quote($post['contact_address']) . ",
                    status=" . $post['status'] . ",
                    update_time=" . NV_CURRENTTIME . "
                    WHERE id=" . $id;
        } else {
            // Thêm mới
            $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources
                    (title, alias, short_description, detailed_description, catid, download_link_type, download_link, external_source_link, demo_link, keywords, fee_type, fee_amount, 
                     contact_phone, contact_email, contact_skype, contact_telegram, contact_zalo, contact_facebook, contact_website, contact_address,
                     status, userid, add_time) VALUES (
                    " . $db->quote($post['title']) . ",
                    " . $db->quote($post['alias']) . ",
                    " . $db->quote($post['short_description']) . ",
                    " . $db->quote($post['detailed_description']) . ",
                    " . $post['catid'] . ",
                    " . $db->quote($post['download_link_type']) . ",
                    " . $db->quote($post['download_link']) . ",
                    " . $db->quote($post['external_source_link']) . ",
                    " . $db->quote($post['demo_link']) . ",
                    " . $db->quote($post['keywords']) . ",
                    " . $db->quote($post['fee_type']) . ",
                    " . $post['fee_amount'] . ",
                    " . $db->quote($post['contact_phone']) . ",
                    " . $db->quote($post['contact_email']) . ",
                    " . $db->quote($post['contact_skype']) . ",
                    " . $db->quote($post['contact_telegram']) . ",
                    " . $db->quote($post['contact_zalo']) . ",
                    " . $db->quote($post['contact_facebook']) . ",
                    " . $db->quote($post['contact_website']) . ",
                    " . $db->quote($post['contact_address']) . ",
                    " . $post['status'] . ",
                    " . $admin_info['userid'] . ",
                    " . NV_CURRENTTIME . "
                    )";
        }
        
        if ($db->exec($sql)) {
            // Lấy ID của source (cho trường hợp thêm mới hoặc cập nhật)
            if ($id > 0) {
                $source_id = $id; // Trường hợp cập nhật
            } else {
                $source_id = $db->lastInsertId(); // Trường hợp thêm mới
            }

            // Cập nhật tags cho source
            if ($source_id > 0) {
                nv_admin_sharecode_update_source_tags($source_id, $post['tag_ids']);
            }
            
            // Gửi email thông báo nếu là thêm mới và được cấu hình
            if ($id == 0) { // Chỉ thông báo khi thêm mới
                $sql_config = "SELECT config_name, config_value FROM " . NV_CONFIG_GLOBALTABLE . " WHERE lang='" . NV_LANG_DATA . "' AND module='" . $module_name . "'";
                $result_config = $db->query($sql_config);
                $module_config = [];
                while ($row_config = $result_config->fetch()) {
                    $module_config[$row_config['config_name']] = $row_config['config_value'];
                }
                
                if (!empty($module_config['email_notify_new_source'])) {
                    // Lấy email admin (có thể thông báo cho admin khác)
                    $sql_admin = "SELECT email, first_name, last_name FROM " . NV_USERS_GLOBALTABLE . " WHERE level=1 AND active=1 AND userid<>" . $admin_info['userid'] . " LIMIT 1";
                    $admin_info_notify = $db->query($sql_admin)->fetch();
                    
                    if ($admin_info_notify) {
                        $admin_name = trim($admin_info_notify['first_name'] . ' ' . $admin_info_notify['last_name']);
                        if (empty($admin_name)) {
                            $admin_name = 'Admin';
                        }
                        
                        $subject = '[' . $global_config['site_name'] . '] Sản phẩm mới được thêm';
                        $message = "Xin chào {$admin_name},\n\n";
                        $message .= "Có sản phẩm mới được thêm bởi admin:\n\n";
                        $message .= "Tiêu đề: {$post['title']}\n";
                        $message .= "Mô tả: {$post['description']}\n";
                        $message .= "Loại phí: " . ($post['fee_type'] == 'free' ? 'Miễn phí' : ($post['fee_type'] == 'paid' ? 'Trả phí: ' . number_format($post['fee_amount'], 0, ',', '.') . ' VND' : 'Liên hệ')) . "\n";
                        $message .= "Trạng thái: " . ($post['status'] ? 'Đã duyệt' : 'Chờ duyệt') . "\n";
                        $message .= "Người thêm: {$admin_info['username']}\n";
                        $message .= "Thời gian: " . date('d/m/Y H:i', NV_CURRENTTIME) . "\n\n";
                        $message .= "Xem chi tiết: " . NV_MY_DOMAIN . NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=sources&action=edit&id=" . $source_id . "\n\n";
                        $message .= "Trân trọng,\n";
                        $message .= $global_config['site_name'];
                        
                        nv_sharecode_send_email_notification($admin_info_notify['email'], $admin_name, $subject, $message);
                    }
                }
            }

            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&success=1');
        } else {
            $error[] = 'Lỗi khi lưu dữ liệu vào cơ sở dữ liệu';
        }
    }
}

// Lấy dữ liệu để sửa
$row = [];
$current_tag_ids = [];
if ($id > 0 && ($action == 'edit' || $action == '')) {
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $id;
    $row = $db->query($sql)->fetch();
    if (empty($row)) {
        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
    }

    // Lấy tags hiện tại
    $current_tags = nv_admin_sharecode_get_source_tags($id);
    foreach ($current_tags as $tag) {
        $current_tag_ids[] = $tag['id'];
    }
}

// Build search conditions
$where_conditions = [];
if (!empty($array_search['q'])) {
    $where_conditions[] = "(s.title LIKE '%" . $db->dblikeescape($array_search['q']) . "%' OR s.description LIKE '%" . $db->dblikeescape($array_search['q']) . "%')";
}
if ($array_search['catid'] > 0) {
    $where_conditions[] = "s.catid=" . $array_search['catid'];
}
if ($array_search['status'] != -1) {
    $where_conditions[] = "s.status=" . $array_search['status'];
}
if (!empty($array_search['fee_type'])) {
    $where_conditions[] = "s.fee_type='" . $db->dblikeescape($array_search['fee_type']) . "'";
}

$sources_data = nv_admin_sharecode_get_sources($where_conditions, $page, $per_page);

// Build search form data
$type_search = [
    '' => 'Tất cả',
    'title' => 'Tiêu đề',
    'description' => 'Mô tả'
];

$status_search = [
    -1 => 'Tất cả trạng thái',
    1 => 'Hoạt động', 
    0 => 'Không hoạt động'
];

$fee_type_search = [
    '' => 'Tất cả loại phí',
    'free' => 'Miễn phí',
    'paid' => 'Có phí',
    'contact' => 'Liên hệ để biết giá'
];

// Get categories for filter - use proper function to get flat list
$val_cat_content = [];
$val_cat_content[] = [
    'value' => 0,
    'title' => 'Tất cả danh mục'
];
// Get categories using a direct query to handle crashed tables
$sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories ORDER BY parentid ASC, weight ASC";
$result = $db->query($sql);
$categories_raw = [];
while ($row_cat = $result->fetch()) {
    $categories_raw[$row_cat['parentid']][] = $row_cat;
}

if (!empty($categories_raw)) {
    $categories_tree = nv_admin_sharecode_build_category_tree($categories_raw);
    
    foreach ($categories_tree as $cat) {
        $prefix = str_repeat('&nbsp;&nbsp;&nbsp;', $cat['level']);
        $val_cat_content[] = [
            'value' => $cat['id'],
            'title' => $prefix . $cat['title']
        ];
    }
} else {
    // If no categories exist, add a message
    $val_cat_content[] = [
        'value' => '',
        'title' => '-- Chưa có danh mục nào --'
    ];
}

// Assign template variables
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;

// Check for success message
$success_message = '';
if ($nv_Request->get_int('success', 'get', 0) == 1) {
    $success_message = 'Lưu mã nguồn thành công';
}

$tpl->assign('SUCCESS_MESSAGE', $success_message);
$tpl->assign('SEARCH', $array_search);
$tpl->assign('TYPE_SEARCH', $type_search);
$tpl->assign('STATUS_SEARCH', $status_search);
$tpl->assign('FEE_TYPE_SEARCH', $fee_type_search);
$tpl->assign('LIST_CAT', $val_cat_content);
$tpl->assign('PER_PAGE', $per_page);
$tpl->assign('BASE_URL', $base_url);
$tpl->assign('FORM_ACTION', $base_url . ($id > 0 ? '&id=' . $id : ''));

// Prepare form data
if ($id > 0 || $action == 'add' || $action == 'edit') {
    // Form data
    if (!empty($post)) {
        $form_data = $post;
    } elseif (!empty($row)) {
        $form_data = $row;
    } else {
        $form_data = [
            'title' => '',
            'alias' => '',
            'description' => '',
            'catid' => 0,
            'download_link_type' => 'internal',
            'download_link' => '',
            'demo_link' => '',
            'fee_type' => 'free',
            'fee_amount' => 0,
            'keywords' => '',
            'status' => 1,
            'contact_phone' => '',
            'contact_email' => '',
            'contact_skype' => '',
            'contact_telegram' => '',
            'contact_zalo' => '',
            'contact_facebook' => '',
            'contact_website' => '',
            'contact_address' => ''
        ];
    }
    $tpl->assign('DATA', $form_data);
    $tpl->assign('IS_FORM', true);
    $tpl->assign('IS_EDIT', $id > 0);
    $category_options = nv_admin_sharecode_get_category_options($form_data['catid'] ?? 0);
    $tpl->assign('CATEGORY_OPTIONS', $category_options);
    
    $all_tags = nv_admin_sharecode_get_all_tags();
            foreach ($all_tags as &$tag) {
                $tag['checked'] = in_array($tag['id'], $current_tag_ids) ? true : false;
            }
            $tpl->assign('TAGS', $all_tags);

    // Error messages
    if (!empty($error)) {
        $tpl->assign('ERRORS', $error);
    }
} else {
    $tpl->assign('IS_FORM', false);
}

// Prepare sources list data
if (!($id > 0 || $action == 'add')) {
    $sources = [];
    if (!empty($sources_data['data'])) {
        foreach ($sources_data['data'] as $source) {
            $source['add_time_format'] = date('d/m/Y H:i', $source['add_time']);
            $source['status_text'] = $source['status'] ? 'Hoạt động' : 'Không hoạt động';
            $source['status_class'] = $source['status'] ? 'success' : 'secondary';
            
            if ($source['fee_type'] == 'free') {
                $source['fee_text'] = 'Miễn phí';
                $source['fee_class'] = 'success';
            } elseif ($source['fee_type'] == 'contact') {
                $source['fee_text'] = 'Liên hệ';
                $source['fee_class'] = 'info';
            } else {
                $source['fee_text'] = number_format($source['fee_amount']) . ' VNĐ';
                $source['fee_class'] = 'warning';
            }
            
            $source['edit_url'] = $base_url . '&action=edit&id=' . $source['id'];
            $source['checksess'] = md5($source['id'] . NV_CHECK_SESSION);
            $sources[] = $source;
        }
    }
    
    $tpl->assign('SOURCES', $sources);
    $tpl->assign('PAGINATION', nv_generate_page($base_url, $sources_data['total'], $per_page, $page));
    
    // Bulk actions
    $actions = [
        ['value' => 'activate', 'title' => 'Kích hoạt'],
        ['value' => 'deactivate', 'title' => 'Ngừng kích hoạt'],
        ['value' => 'delete', 'title' => 'Xóa']
    ];
    $tpl->assign('ACTIONS', $actions);
}

$contents = $tpl->fetch('sources.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
