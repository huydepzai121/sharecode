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

$page_title = 'Quản lý danh mục';

$action = $nv_Request->get_title('action', 'get', '');
$id = $nv_Request->get_int('id', 'get', 0);

// Xử lý xóa danh mục
if ($action == 'delete' && $id > 0) {
    if ($nv_Request->get_title('confirm', 'get', '') == md5($id . NV_CHECK_SESSION)) {
        // Kiểm tra có sources trong danh mục không
        $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE catid=" . $id;
        $count = $db->query($sql)->fetchColumn();
        
        if ($count > 0) {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Không thể xóa danh mục có chứa mã nguồn'
            ]);
        }
        
        // Kiểm tra có danh mục con không
        $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE parentid=" . $id;
        $count = $db->query($sql)->fetchColumn();
        
        if ($count > 0) {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Không thể xóa danh mục có chứa danh mục con'
            ]);
        }
        
        $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $id;
        if ($db->exec($sql)) {
            nv_jsonOutput([
                'status' => 'success',
                'mess' => 'Xóa danh mục thành công'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Lỗi khi xóa danh mục'
            ]);
        }
    }
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
}

// Khởi tạo biến error
$error = [];

// Xử lý thêm/sửa danh mục
if ($nv_Request->get_title('save', 'post', '') != '') {
    $post = [];
    
    $post['title'] = $nv_Request->get_title('title', 'post', '');
    $post['alias'] = $nv_Request->get_title('alias', 'post', '');
    $post['description'] = $nv_Request->get_textarea('description', 'post', '');
    // Removed parent category functionality as per issue #1
    // $post['parentid'] = $nv_Request->get_int('parentid', 'post', 0);
    // Removed weight/order display as per issue #1  
    // $post['weight'] = $nv_Request->get_int('weight', 'post', 0);
    $post['status'] = $nv_Request->get_int('status', 'post', 1);
    
    if (empty($post['title'])) {
        $error[] = 'Tên danh mục không được để trống';
    }
    
    // Auto-generate alias from title if empty (issue #1 fix)
    if (empty($post['alias'])) {
        $post['alias'] = nv_admin_sharecode_create_alias($post['title'], 'categories', $id);
    } else {
        // Clean up manually entered alias
        $post['alias'] = nv_admin_sharecode_create_alias($post['alias'], 'categories', $id);
    }
    
    if (!nv_admin_sharecode_check_alias($post['alias'], 'categories', $id)) {
        $error[] = 'Liên kết tĩnh đã tồn tại';
    }
    
    if (empty($error)) {
        if ($id > 0) {
            // Cập nhật
            $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_categories SET
                    title=" . $db->quote($post['title']) . ",
                    alias=" . $db->quote($post['alias']) . ",
                    description=" . $db->quote($post['description']) . ",
                    status=" . $post['status'] . ",
                    edit_time=" . NV_CURRENTTIME . "
                    WHERE id=" . $id;
        } else {
            // Thêm mới
            $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_categories
                    (title, alias, description, status, add_time) VALUES (
                    " . $db->quote($post['title']) . ",
                    " . $db->quote($post['alias']) . ",
                    " . $db->quote($post['description']) . ",
                    " . $post['status'] . ",
                    " . NV_CURRENTTIME . "
                    )";
        }
        
        if ($db->exec($sql)) {
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
        } else {
            $error[] = 'Lỗi khi lưu dữ liệu';
        }
    }
}

// Lấy dữ liệu để sửa
$row = [];
if ($id > 0) {
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $id;
    $row = $db->query($sql)->fetch();
    if (empty($row)) {
        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
    }
}

// Lấy danh sách categories
$categories = nv_admin_sharecode_get_all_categories();
$tree = nv_admin_sharecode_build_category_tree($categories);

// Use modern Smarty templating
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('categories.tpl'));
$tpl->assign('LANG', $nv_Lang);
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('OP', $op);
$tpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . ($id > 0 ? '&id=' . $id : ''));

// Form data
$data = [];
if (!empty($post)) {
    $data = $post;
} elseif (!empty($row)) {
    $data = $row;
} else {
    $data = [
        'title' => '',
        'alias' => '',
        'description' => '',
        'status' => 1
    ];
}

// Xử lý trạng thái checkbox
$data['status_checked'] = $data['status'] ? 'checked="checked"' : '';

// Determine if we're adding or editing
$is_edit = ($id > 0);
$tpl->assign('IS_EDIT', $is_edit);
$tpl->assign('DATA', $data);

// Parent category functionality removed as per issue #1
// $parent_options = nv_admin_sharecode_get_category_options($data['parentid'] ?? 0, $id);
// $tpl->assign('PARENT_OPTIONS', $parent_options);

// Assign errors if any
$tpl->assign('ERRORS', $error);

// Process categories for template
$categories_data = [];
if (!empty($tree)) {
    foreach ($tree as $category) {
        $category['level_prefix'] = str_repeat('&nbsp;&nbsp;&nbsp;', $category['level']);
        $category['status_text'] = $category['status'] ? 'Hoạt động' : 'Không hoạt động';
        $category['status_class'] = $category['status'] ? 'success' : 'secondary';
        $category['edit_url'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&id=' . $category['id'];
        $category['delete_url'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&action=delete&id=' . $category['id'] . '&confirm=' . md5($category['id'] . NV_CHECK_SESSION);
        $category['add_time_format'] = nv_date('d/m/Y H:i', $category['add_time']);
        $category['edit_time_format'] = !empty($category['edit_time']) ? nv_date('d/m/Y H:i', $category['edit_time']) : '';
        
        $categories_data[] = $category;
    }
}

$tpl->assign('CATEGORIES', $categories_data);

// Base URL for JavaScript actions
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;
$tpl->assign('BASE_URL', $base_url);

// Hiển thị template
$contents = $tpl->fetch('categories.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
