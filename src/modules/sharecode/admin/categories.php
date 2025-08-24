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

$action = $nv_Request->get_title('action', 'get,post', '');
$id = $nv_Request->get_int('id', 'get,post', 0);
$ajax = $nv_Request->get_int('ajax', 'get,post', 0);

// Xử lý xóa danh mục
if ($action == 'delete' && $id > 0) {
    if ($nv_Request->get_title('confirm', 'get', '') == md5($id . NV_CHECK_SESSION)) {
        // Kiểm tra có sources trong danh mục không
        $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE catid=" . $id;
        $count = $db->query($sql)->fetchColumn();
        
        if ($count > 0) {
            nv_info_die('Thông báo', 'Không thể xóa danh mục có chứa ' . $count . ' mã nguồn. Vui lòng di chuyển hoặc xóa các mã nguồn trước.', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
        }
        
        // Kiểm tra có danh mục con không (if hierarchical categories are re-enabled)
        $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE parentid=" . $id;
        $count = $db->query($sql)->fetchColumn();
        
        if ($count > 0) {
            nv_info_die('Thông báo', 'Không thể xóa danh mục có chứa ' . $count . ' danh mục con. Vui lòng xóa các danh mục con trước.', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
        }
        
        // Lấy weight của category sẽ xóa
        $sql = "SELECT weight FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $id;
        $deleted_weight = $db->query($sql)->fetchColumn();

        $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $id;
        if ($db->exec($sql)) {
            // Cập nhật weight cho các category có weight > deleted_weight
            if ($deleted_weight > 0) {
                $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_categories
                        SET weight = weight - 1
                        WHERE weight > " . $deleted_weight;
                $db->exec($sql);
            }

            $nv_Cache->delMod($module_name);
            nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&del_success=1');
        } else {
            nv_info_die('Lỗi', 'Lỗi khi xóa danh mục khỏi cơ sở dữ liệu', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
        }
    }
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
}

// Xử lý bulk actions
if ($nv_Request->isset_request('bulk_action', 'post')) {
    $action_type = $nv_Request->get_title('action_type', 'post', '');
    $ids = $nv_Request->get_array('ids', 'post', []);
    
    if (!empty($ids) && in_array($action_type, ['delete', 'activate', 'deactivate'])) {
        $success_count = 0;
        $error_messages = [];
        
        foreach ($ids as $cat_id) {
            $cat_id = intval($cat_id);
            if ($cat_id <= 0) continue;
            
            if ($action_type == 'delete') {
                // Kiểm tra có sources trong danh mục không
                $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE catid=" . $cat_id;
                $count = $db->query($sql)->fetchColumn();
                
                if ($count > 0) {
                    $sql_name = "SELECT title FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $cat_id;
                    $cat_name = $db->query($sql_name)->fetchColumn();
                    $error_messages[] = '"' . $cat_name . '" có ' . $count . ' mã nguồn';
                    continue;
                }
                
                $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $cat_id;
                if ($db->exec($sql)) {
                    $success_count++;
                }
            } elseif ($action_type == 'activate') {
                $db->query("UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_categories SET status=1 WHERE id=" . $cat_id);
                $success_count++;
            } elseif ($action_type == 'deactivate') {
                $db->query("UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_categories SET status=0 WHERE id=" . $cat_id);
                $success_count++;
            }
        }

        // Reorder weights after bulk delete
        if ($success_count > 0 && $action_type == 'delete') {
            $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories ORDER BY weight ASC";
            $result = $db->query($sql);
            $weight = 1;
            while ($row = $result->fetch()) {
                $db->exec("UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_categories SET weight=" . $weight . " WHERE id=" . $row['id']);
                $weight++;
            }
            $nv_Cache->delMod($module_name);
        }

        $message = 'Đã xử lý ' . $success_count . ' danh mục';
        if (!empty($error_messages)) {
            $message .= '. Không thể xóa: ' . implode(', ', $error_messages);
        }

        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&bulk_success=' . urlencode($message));
    }
    
    nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
}

// AJAX: Get category data for editing
if ($action == 'get_category' && $ajax == 1 && $id > 0) {
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $id;
    $row = $db->query($sql)->fetch();
    
    if (empty($row)) {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Danh mục không tồn tại'
        ]);
    }
    
    nv_jsonOutput([
        'status' => 'OK',
        'data' => $row
    ]);
}

// AJAX: Save category (add/edit)
if ($action == 'save_category' && $ajax == 1) {
    $checkss = $nv_Request->get_title('checkss', 'post', '');
    if ($checkss != NV_CHECK_SESSION) {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Lỗi xác thực phiên làm việc'
        ]);
    }

    $post = [];
    $error = [];

    $post['title'] = $nv_Request->get_title('title', 'post', '');
    $post['alias'] = $nv_Request->get_title('alias', 'post', '');
    $post['description'] = $nv_Request->get_textarea('description', 'post', '');
    $post['parentid'] = $nv_Request->get_int('parent_id', 'post', 0);
    $post['image'] = $nv_Request->get_title('image', 'post', '');
    $post['status'] = $nv_Request->get_int('status', 'post', 0);
    
    if (empty($post['title'])) {
        $error[] = 'Tên danh mục không được để trống';
    }
    
    // Auto-generate alias from title if empty
    if (empty($post['alias'])) {
        $post['alias'] = nv_admin_sharecode_create_alias($post['title'], 'categories', $id);
    } else {
        // Clean up manually entered alias
        $post['alias'] = nv_admin_sharecode_create_alias($post['alias'], 'categories', $id);
    }
    
    if (!nv_admin_sharecode_check_alias($post['alias'], 'categories', $id)) {
        $error[] = 'Liên kết tĩnh đã tồn tại';
    }
    
    if (!empty($error)) {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => implode('<br>', $error)
        ]);
    }
    
    if ($id > 0) {
        // Cập nhật
        $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_categories SET
                title=" . $db->quote($post['title']) . ",
                alias=" . $db->quote($post['alias']) . ",
                description=" . $db->quote($post['description']) . ",
                parentid=" . $post['parentid'] . ",
                image=" . $db->quote($post['image']) . ",
                status=" . $post['status'] . ",
                edit_time=" . NV_CURRENTTIME . "
                WHERE id=" . $id;
    } else {
        // Thêm mới - weight = max + 1 để xếp cuối
        $sql = "SELECT MAX(weight) FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories";
        $max_weight = (int)$db->query($sql)->fetchColumn();
        $new_weight = $max_weight + 1;

        $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_categories
                (title, alias, description, parentid, image, weight, status, add_time) VALUES (
                " . $db->quote($post['title']) . ",
                " . $db->quote($post['alias']) . ",
                " . $db->quote($post['description']) . ",
                " . $post['parentid'] . ",
                " . $db->quote($post['image']) . ",
                " . $new_weight . ",
                " . $post['status'] . ",
                " . NV_CURRENTTIME . "
                )";
    }
    
    try {
        if ($db->exec($sql)) {
            nv_jsonOutput([
                'status' => 'OK',
                'mess' => ($id > 0) ? 'Cập nhật danh mục thành công' : 'Thêm danh mục mới thành công'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'ERROR',
                'mess' => 'Lỗi khi lưu dữ liệu vào cơ sở dữ liệu'
            ]);
        }
    } catch (Exception $e) {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Lỗi cơ sở dữ liệu: ' . $e->getMessage()
        ]);
    }
}

// AJAX: Change weight
if ($nv_Request->get_title('action', 'post', '') == 'change_weight') {
    $id = $nv_Request->get_int('id', 'post', 0);
    $new_weight = $nv_Request->get_int('new_weight', 'post', 0);
    $checkss = $nv_Request->get_title('checkss', 'post', '');

    if ($checkss != NV_CHECK_SESSION) {
        exit('Wrong session');
    }

    if ($id > 0 && $new_weight > 0) {
        // Kiểm tra category tồn tại
        $sql = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories WHERE id=' . $id;
        $numrows = $db->query($sql)->fetchColumn();

        if ($numrows != 1) {
            exit('NO_' . $id);
        }

        // Lấy tất cả categories khác để sắp xếp lại weight
        $sql = 'SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_categories WHERE id!=' . $id . ' ORDER BY weight ASC';
        $result = $db->query($sql);

        $weight = 0;
        while ($row = $result->fetch()) {
            ++$weight;
            if ($weight == $new_weight) {
                ++$weight;
            }
            $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_categories SET weight=' . $weight . ' WHERE id=' . $row['id'];
            $db->query($sql);
        }

        // Cập nhật weight cho category hiện tại
        $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_categories SET weight=' . $new_weight . ', edit_time=' . NV_CURRENTTIME . ' WHERE id=' . $id;
        $db->query($sql);

        // Clear cache
        $nv_Cache->delMod($module_name);

        include NV_ROOTDIR . '/includes/header.php';
        echo 'OK_' . $id;
        include NV_ROOTDIR . '/includes/footer.php';
    }

    exit('ERROR');
}

// AJAX: Get parent options (exclude current category and its children)
if ($nv_Request->get_title('action', 'post', '') == 'get_parent_options') {
    $exclude_id = $nv_Request->get_int('exclude_id', 'post', 0);
    $selected_id = $nv_Request->get_int('selected_id', 'post', 0);

    try {
        $parent_options = nv_admin_sharecode_get_category_options($selected_id, $exclude_id);

        include NV_ROOTDIR . '/includes/header.php';
        echo $parent_options;
        include NV_ROOTDIR . '/includes/footer.php';
    } catch (Exception $e) {
        include NV_ROOTDIR . '/includes/header.php';
        echo '<option value="0">-- Lỗi: ' . $e->getMessage() . ' --</option>';
        include NV_ROOTDIR . '/includes/footer.php';
    }
}

// Khởi tạo biến error
$error = [];

// No longer needed - moved to AJAX handlers above

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

// No form data needed - using modal AJAX interface

// Success/Error messages
$success_message = '';
if ($nv_Request->get_int('del_success', 'get', 0) == 1) {
    $success_message = 'Xóa danh mục thành công';
} elseif ($nv_Request->isset_request('bulk_success', 'get')) {
    $success_message = $nv_Request->get_title('bulk_success', 'get', '');
}

if ($success_message) {
    $tpl->assign('SUCCESS_MESSAGE', $success_message);
}

// Assign errors if any
$tpl->assign('ERRORS', $error);

// Process categories for template
$categories_data = [];
if (!empty($tree)) {
    // Tạo map để kiểm tra category nào có con
    $children_map = [];
    foreach ($tree as $cat) {
        if ($cat['parentid'] > 0) {
            $children_map[$cat['parentid']] = true;
        }
    }

    foreach ($tree as $category) {
        $level = isset($category['level']) ? $category['level'] : 0;
        $category['level'] = $level; // Đảm bảo level được truyền cho template
        $category['level_prefix'] = str_repeat('&nbsp;&nbsp;&nbsp;', $level);
        $category['has_children'] = isset($children_map[$category['id']]);
        $category['status_text'] = $category['status'] ? 'Hoạt động' : 'Không hoạt động';
        $category['status_class'] = $category['status'] ? 'success' : 'secondary';
        $category['edit_url'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&id=' . $category['id'];
        $category['delete_url'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&action=delete&id=' . $category['id'] . '&confirm=' . md5($category['id'] . NV_CHECK_SESSION);
        $category['checksess'] = md5($category['id'] . NV_CHECK_SESSION);
        $category['add_time_format'] = nv_date('d/m/Y H:i', $category['add_time']);
        $category['edit_time_format'] = !empty($category['edit_time']) ? nv_date('d/m/Y H:i', $category['edit_time']) : '';

        $categories_data[] = $category;
    }
}

$tpl->assign('CATEGORIES', $categories_data);
$tpl->assign('TOTAL_CATEGORIES', count($categories_data));

// Tạo dropdown parent categories (sẽ được cập nhật qua AJAX khi edit)
$parent_options = nv_admin_sharecode_get_category_options(0, 0);
$tpl->assign('PARENT_OPTIONS', $parent_options);

// Khởi tạo dữ liệu form mặc định
$default_data = [
    'title' => '',
    'alias' => '',
    'description' => '',
    'parentid' => 0,
    'image' => '',
    'weight' => 0,
    'status' => 1,
    'status_checked' => 'checked'
];
$tpl->assign('DATA', $default_data);

// Base URL for JavaScript actions
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;
$tpl->assign('BASE_URL', $base_url);

$tpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$tpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$tpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$tpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$tpl->assign('NV_CHECK_SESSION', NV_CHECK_SESSION);
$tpl->assign('NV_UPLOADS_DIR', NV_UPLOADS_DIR);

// Hiển thị template
$contents = $tpl->fetch('categories.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
