<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 3-6-2010 0:14
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    exit('Stop!!!');
}

require_once NV_ROOTDIR . '/modules/' . $module_file . '/admin.functions.php';

$page_title = 'Quản lý từ khóa';

// Xử lý các action
$action = $nv_Request->get_title('action', 'get,post', '');
$id = $nv_Request->get_int('id', 'get,post', 0);

$checkss = $nv_Request->get_string('checkss', 'post', '');

// Lấy thông tin keyword để sửa (AJAX)
if ($nv_Request->isset_request('getkeyword', 'post')) {
    $kid = $nv_Request->get_int('id', 'post', 0);

    $respon = [
        'success' => 0,
        'text' => 'Error session!!!'
    ];

    if ($kid > 0 && $checkss === NV_CHECK_SESSION) {
        $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE id=" . $kid;
        $keyword = $db->query($sql)->fetch();

        if ($keyword) {
            $respon['success'] = 1;
            $respon['data'] = $keyword;
        } else {
            $respon['text'] = 'Không tìm thấy từ khóa';
        }
    }

    nv_jsonOutput($respon);
}

if ($nv_Request->isset_request('savekeyword', 'post')) {
    $respon = [
        'status' => 'error',
        'mess' => 'Error session!!!'
    ];

    if ($checkss === NV_CHECK_SESSION) {
        $post = [];
        $post['id'] = $nv_Request->get_int('id', 'post', 0);
        $post['name'] = $nv_Request->get_title('name', 'post', '');
        $post['alias'] = $nv_Request->get_title('alias', 'post', '');
        $post['description'] = $nv_Request->get_textarea('description', 'post', '');
        // Weight sẽ được tự động tính toán
        $post['status'] = $nv_Request->get_int('status', 'post', 0);

        $error = [];

        // Validation
        if (empty($post['name'])) {
            $error[] = 'Tên từ khóa không được để trống';
        }

        // Tạo alias tự động nếu không có
        if (empty($post['alias'])) {
            $post['alias'] = change_alias($post['name']);
        } else {
            $post['alias'] = change_alias($post['alias']);
        }

        // Kiểm tra trùng lặp
        $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE name=" . $db->quote($post['name']);
        if ($post['id'] > 0) {
            $sql .= " AND id!=" . $post['id'];
        }
        $existing_id = $db->query($sql)->fetchColumn();
        if ($existing_id) {
            $error[] = 'Tên từ khóa đã tồn tại';
        }

        if (empty($error)) {
            if ($post['id'] > 0) {
                // Update - không thay đổi weight
                $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_keywords SET
                        name=" . $db->quote($post['name']) . ",
                        alias=" . $db->quote($post['alias']) . ",
                        description=" . $db->quote($post['description']) . ",
                        status=" . $post['status'] . "
                        WHERE id=" . $post['id'];
                $action_text = 'cập nhật';
            } else {
                // Insert - weight = max + 1 để xếp cuối
                $sql = "SELECT MAX(weight) FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords";
                $max_weight = (int)$db->query($sql)->fetchColumn();
                $new_weight = $max_weight + 1;

                $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_keywords
                        (name, alias, description, weight, status, add_time) VALUES
                        (" . $db->quote($post['name']) . ", " . $db->quote($post['alias']) . ", " . $db->quote($post['description']) . ", " . $new_weight . ", " . $post['status'] . ", " . NV_CURRENTTIME . ")";
                $action_text = 'thêm';
            }

            if ($db->exec($sql)) {
                $respon['status'] = 'success';
                $respon['mess'] = 'Đã ' . $action_text . ' từ khóa thành công';
                $respon['refresh'] = true;
            } else {
                $respon['mess'] = 'Có lỗi xảy ra khi ' . $action_text . ' từ khóa';
            }
        } else {
            $respon['mess'] = implode('<br>', $error);
        }
    }

    nv_jsonOutput($respon);
}

// Lưu nhiều keywords (AJAX)
if ($nv_Request->isset_request('savemultikeywords', 'post')) {
    $respon = [
        'status' => 'error',
        'mess' => 'Error session!!!'
    ];

    if ($checkss === NV_CHECK_SESSION) {
        $keywords_multi = $nv_Request->get_textarea('keywords_multi', 'post', '');
        $keywords_array = array_filter(array_map('trim', explode("\n", $keywords_multi)));

        if (empty($keywords_array)) {
            $respon['mess'] = 'Vui lòng nhập ít nhất một từ khóa';
        } else {
            $added = 0;
            $skipped = 0;

            // Lấy max weight hiện tại
            $sql = "SELECT MAX(weight) FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords";
            $max_weight = (int)$db->query($sql)->fetchColumn();

            foreach ($keywords_array as $keyword_name) {
                if (empty($keyword_name)) continue;

                // Kiểm tra trùng lặp
                $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE name=" . $db->quote($keyword_name);
                $existing_id = $db->query($sql)->fetchColumn();

                if (!$existing_id) {
                    $max_weight++; // Tăng weight cho từ khóa tiếp theo
                    $alias = change_alias($keyword_name);
                    $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_keywords
                            (name, alias, description, weight, status, add_time) VALUES
                            (" . $db->quote($keyword_name) . ", " . $db->quote($alias) . ", '', " . $max_weight . ", 1, " . NV_CURRENTTIME . ")";

                    if ($db->exec($sql)) {
                        $added++;
                    }
                } else {
                    $skipped++;
                }
            }

            $respon['status'] = 'success';
            $respon['mess'] = "Đã thêm {$added} từ khóa mới" . ($skipped > 0 ? ", bỏ qua {$skipped} từ khóa đã tồn tại" : "");
            $respon['refresh'] = true;
        }
    }

    nv_jsonOutput($respon);
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
        // Kiểm tra keyword tồn tại
        $sql = 'SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_keywords WHERE id=' . $id;
        $numrows = $db->query($sql)->fetchColumn();

        if ($numrows != 1) {
            exit('NO_' . $id);
        }

        // Lấy tất cả keywords khác để sắp xếp lại weight
        $sql = 'SELECT id FROM ' . NV_PREFIXLANG . '_' . $module_data . '_keywords WHERE id!=' . $id . ' ORDER BY weight ASC';
        $result = $db->query($sql);

        $weight = 0;
        while ($row = $result->fetch()) {
            ++$weight;
            if ($weight == $new_weight) {
                ++$weight;
            }
            $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_keywords SET weight=' . $weight . ' WHERE id=' . $row['id'];
            $db->query($sql);
        }

        // Cập nhật weight cho keyword hiện tại
        $sql = 'UPDATE ' . NV_PREFIXLANG . '_' . $module_data . '_keywords SET weight=' . $new_weight . ' WHERE id=' . $id;
        $db->query($sql);

        echo 'OK_' . $id;
    }
    exit();
}

// Xử lý AJAX requests
if ($nv_Request->isset_request('ajax', 'post')) {
    $ajax_action = $nv_Request->get_title('ajax_action', 'post', '');

    // Xóa keyword
    if ($ajax_action == 'delete' && $id > 0) {
        // Kiểm tra keyword có đang được sử dụng không
        $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE keywords LIKE " . $db->quote('%' . $id . '%');
        $count = $db->query($sql)->fetchColumn();

        if ($count > 0) {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Không thể xóa từ khóa này vì đang được sử dụng bởi ' . $count . ' sản phẩm'
            ]);
        }

        $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE id=" . $id;
        if ($db->exec($sql)) {
            nv_jsonOutput([
                'status' => 'success',
                'mess' => 'Đã xóa từ khóa thành công'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Có lỗi xảy ra khi xóa từ khóa'
            ]);
        }
    }

    // Cập nhật trạng thái
    if ($ajax_action == 'change_status' && $id > 0) {
        $new_status = $nv_Request->get_int('status', 'post', 0);
        $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_keywords SET status=" . $new_status . " WHERE id=" . $id;
        if ($db->exec($sql)) {
            nv_jsonOutput([
                'status' => 'success',
                'mess' => 'Đã cập nhật trạng thái thành công'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Có lỗi xảy ra khi cập nhật trạng thái'
            ]);
        }
    }

    // Cập nhật weight
    if ($ajax_action == 'change_weight' && $id > 0) {
        $new_weight = $nv_Request->get_int('weight', 'post', 0);
        $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_keywords SET weight=" . $new_weight . " WHERE id=" . $id;
        if ($db->exec($sql)) {
            nv_jsonOutput([
                'status' => 'success',
                'mess' => 'Đã cập nhật thứ tự thành công'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Có lỗi xảy ra khi cập nhật thứ tự'
            ]);
        }
    }
}

// Xử lý thêm/sửa keyword
$error = [];
if ($action == 'add' || $action == 'edit') {
    if ($nv_Request->isset_request('submit', 'post')) {
        $post = [];
        $post['name'] = $nv_Request->get_title('name', 'post', '');
        $post['alias'] = $nv_Request->get_title('alias', 'post', '');
        $post['description'] = $nv_Request->get_textarea('description', 'post', '');
        $post['weight'] = $nv_Request->get_int('weight', 'post', 0);
        $post['status'] = $nv_Request->get_int('status', 'post', 1);

        // Validation
        if (empty($post['name'])) {
            $error[] = 'Tên từ khóa không được để trống';
        }

        // Tạo alias tự động nếu không có
        if (empty($post['alias'])) {
            $post['alias'] = change_alias($post['name']);
        } else {
            $post['alias'] = change_alias($post['alias']);
        }

        // Kiểm tra trùng lặp
        $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE name=" . $db->quote($post['name']);
        if ($action == 'edit') {
            $sql .= " AND id!=" . $id;
        }
        $existing_id = $db->query($sql)->fetchColumn();
        if ($existing_id) {
            $error[] = 'Tên từ khóa đã tồn tại';
        }

        if (empty($error)) {
            if ($action == 'add') {
                $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_keywords (name, alias, description, weight, status, add_time) VALUES (" . $db->quote($post['name']) . ", " . $db->quote($post['alias']) . ", " . $db->quote($post['description']) . ", " . $post['weight'] . ", " . $post['status'] . ", " . NV_CURRENTTIME . ")";
            } else {
                $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_keywords SET name=" . $db->quote($post['name']) . ", alias=" . $db->quote($post['alias']) . ", description=" . $db->quote($post['description']) . ", weight=" . $post['weight'] . ", status=" . $post['status'] . " WHERE id=" . $id;
            }

            if ($db->exec($sql)) {
                nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&success=1');
            } else {
                $error[] = 'Có lỗi xảy ra khi lưu dữ liệu';
            }
        }
    }
}

// Lấy dữ liệu để sửa
$row = [];
if ($id > 0 && ($action == 'edit' || $action == '')) {
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE id=" . $id;
    $row = $db->query($sql)->fetch();
    if (empty($row)) {
        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
    }
}

// Phân trang và tìm kiếm
$per_page = 20;
$page = $nv_Request->get_int('page', 'get', 1);
$search = $nv_Request->get_title('search', 'get', '');

$where = [];
if (!empty($search)) {
    $where[] = "(name LIKE " . $db->quote('%' . $search . '%') . " OR description LIKE " . $db->quote('%' . $search . '%') . ")";
}

$where_sql = !empty($where) ? ' WHERE ' . implode(' AND ', $where) : '';

// Đếm tổng số bản ghi
$sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords" . $where_sql;
$total = $db->query($sql)->fetchColumn();

// Lấy dữ liệu
$keywords = [];
if ($total > 0) {
    $offset = ($page - 1) * $per_page;
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords" . $where_sql . " ORDER BY weight ASC, name ASC LIMIT " . $offset . ", " . $per_page;
    $result = $db->query($sql);
    while ($keyword = $result->fetch()) {
        $keyword['add_time_format'] = date('d/m/Y H:i', $keyword['add_time']);
        $keywords[] = $keyword;
    }
}

// Tạo phân trang
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;
if (!empty($search)) {
    $base_url .= '&search=' . urlencode($search);
}

$generate_page = nv_generate_page($base_url, $total, $per_page, $page);

// Use modern Smarty templating
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('keywords.tpl'));
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('OP', $op);
$tpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);

// Danh sách keywords
$tpl->assign('SEARCH', $search);
$tpl->assign('TOTAL', $total);
$tpl->assign('DATA', $keywords);
$tpl->assign('PAGINATION', $generate_page);

$contents = $tpl->fetch('keywords.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';