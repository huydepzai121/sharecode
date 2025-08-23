<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

use NukeViet\Service\Share;

$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;

// Khởi tạo các biến cần thiết
$page_title = "Quản lý tài khoản Ngân Hàng";
$listService = array();
$q = '';
$domain = NV_MY_DOMAIN;
$template = get_tpl_dir([$global_config['module_theme'], $global_config['admin_theme']], 'admin_future', '/modules/' . $module_file . '/add_bank_info.tpl');
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(NV_ROOTDIR . '/themes/' . $template . '/modules/' . $module_file);

// Xử lý các action từ ajax
if ($nv_Request->isset_request('action', 'post')) {
    $action = $nv_Request->get_string('action', 'post', '');
    $response = array();

    switch ($action) {
        case 'add_bank':
        case 'edit_bank':
            $data = array(
                'id' => $nv_Request->get_int('id', 'post', 0),
                'title' => $nv_Request->get_title('title', 'post', ''),
                'account_holder' => $nv_Request->get_title('account_holder', 'post', ''),
                'account_number' => $nv_Request->get_title('account_number', 'post', ''),
                'description_content' => $nv_Request->get_title('description_content', 'post', ''),
                'note' => $nv_Request->get_textarea('note', '', ''),
                'status' => $nv_Request->get_int('status', 'post', 1),
                'url_config' => URL_CONFIG
            );

            // Xử lý logo từ trình quản lý file
            $bank_logo = $nv_Request->get_title('bank_logo', 'post', '');
            if (!empty($bank_logo)) {
                // Lưu đường dẫn đầy đủ
                $data['bank_name'] = $bank_logo;

                // Xóa file cũ nếu là sửa và có file mới
                if ($action == 'edit_bank' && !empty($data['id'])) {
                    $old_file = $db->query('SELECT bank_name FROM ' . $db_config['prefix'] . '_' . $module_data . '_bank_info WHERE id=' . $data['id'] . ' AND url_config = "' . URL_CONFIG . '"')->fetchColumn();
                    if (!empty($old_file) && $old_file != $bank_logo) {
                        $old_file_path = NV_ROOTDIR . '/' . $old_file;
                        if (file_exists($old_file_path)) {
                            @unlink($old_file_path);
                        }
                    }
                }
            } else {
                // Nếu không có ảnh mới, giữ nguyên ảnh cũ
                if ($action == 'edit_bank' && !empty($data['id'])) {
                    $old_file = $db->query('SELECT bank_name FROM ' . $db_config['prefix'] . '_' . $module_data . '_bank_info WHERE id=' . $data['id'] . ' AND url_config = "' . URL_CONFIG . '"')->fetchColumn();
                    if (!empty($old_file)) {
                        $data['bank_name'] = $old_file;
                    }
                }
            }

            if ($action == 'add_bank') {
                $sql = "INSERT INTO " . $db_config['prefix'] . "_" . $module_data . "_bank_info
                        (title, account_holder, account_number, bank_name, description_content, note, status, url_config)
                        VALUES
                        (:title, :account_holder, :account_number, :bank_name, :description_content, :note, :status, :url_config)";
                $message = 'Thêm tài khoản thành công';
            } else {
                $sql = "UPDATE " . $db_config['prefix'] . "_" . $module_data . "_bank_info SET
                        title = :title,
                        account_holder = :account_holder,
                        account_number = :account_number,
                        bank_name = :bank_name,
                        description_content = :description_content,
                        note = :note,
                        status = :status
                        WHERE id = " . $data['id'] . " AND url_config = :url_config";
                $message = 'Cập nhật tài khoản thành công';
            }

            try {
                $sth = $db->prepare($sql);
                $sth->bindParam(':title', $data['title'], PDO::PARAM_STR);
                $sth->bindParam(':account_holder', $data['account_holder'], PDO::PARAM_STR);
                $sth->bindParam(':account_number', $data['account_number'], PDO::PARAM_STR);
                $sth->bindParam(':bank_name', $data['bank_name'], PDO::PARAM_STR);
                $sth->bindParam(':description_content', $data['description_content'], PDO::PARAM_STR);
                $sth->bindParam(':note', $data['note'], PDO::PARAM_STR);
                $sth->bindParam(':status', $data['status'], PDO::PARAM_INT);
                $sth->bindParam(':url_config', $data['url_config'], PDO::PARAM_STR);

                if ($sth->execute()) {
                    $response['status'] = 'success';
                    $response['message'] = $message;
                    nv_insert_logs(NV_LANG_DATA, $module_name, $message, 'ID: ' . $data['id'], $admin_info['userid']);
                } else {
                    $response['status'] = 'error';
                    $response['message'] = 'Lỗi: Không thể lưu dữ liệu';
                }
            } catch (PDOException $e) {
                $response['status'] = 'error';
                $response['message'] = 'Lỗi: ' . $e->getMessage();
            }
            break;

        case 'get_bank':
            $id = $nv_Request->get_int('id', 'post', 0);
            $sql = "SELECT * FROM " . $db_config['prefix'] . "_" . $module_data . "_bank_info WHERE id = " . $id . " AND url_config = '" . URL_CONFIG . "'";
            $bank = $db->query($sql)->fetch();
            if ($bank) {
                $response['status'] = 'success';
                $response['data'] = $bank;
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Không tìm thấy tài khoản';
            }
            break;

        case 'delete_bank':
            $id = $nv_Request->get_int('id', 'post', 0);

            // Xóa file logo
            $old_file = $db->query('SELECT bank_name FROM ' . $db_config['prefix'] . '_' . $module_data . '_bank_info WHERE id=' . $id . ' AND url_config = "' . URL_CONFIG . '"')->fetchColumn();
            if (!empty($old_file)) {
                $old_file_path = NV_ROOTDIR . '/' . $old_file;
                if (file_exists($old_file_path)) {
                    @unlink($old_file_path);
                }
            }

            $sql = "DELETE FROM " . $db_config['prefix'] . "_" . $module_data . "_bank_info WHERE id = " . $id . " AND url_config = '" . URL_CONFIG . "'";
            if ($db->exec($sql)) {
                $response['status'] = 'success';
                $response['message'] = 'Xóa tài khoản thành công';
                nv_insert_logs(NV_LANG_DATA, $module_name, 'Xóa tài khoản ngân hàng', 'ID: ' . $id, $admin_info['userid']);
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Lỗi: Không thể xóa tài khoản';
            }
            break;

        case 'change_status':
            $id = $nv_Request->get_int('id', 'post', 0);
            $status = $nv_Request->get_int('status', 'post', 0);

            $sql = "UPDATE " . $db_config['prefix'] . "_" . $module_data . "_bank_info SET status = " . $status . " WHERE id = " . $id . " AND url_config = '" . URL_CONFIG . "'";
            if ($db->exec($sql)) {
                $response['status'] = 'success';
                nv_insert_logs(NV_LANG_DATA, $module_name, 'Thay đổi trạng thái tài khoản ngân hàng', 'ID: ' . $id, $admin_info['userid']);
            } else {
                $response['status'] = 'error';
                $response['message'] = 'Lỗi: Không thể cập nhật trạng thái';
            }
            break;
    }

    nv_jsonOutput($response);
}

// Lấy danh sách tài khoản ngân hàng
$sql = "SELECT * FROM " . $db_config['prefix'] . "_" . $module_data . "_bank_info WHERE url_config = '" . URL_CONFIG . "' ORDER BY id DESC";
$BANK_LIST = $db->query($sql)->fetchAll();

// Gán các biến cho template
$tpl->assign('LANG', $nv_Lang);
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('LIST_SERVICE', $listService);
$tpl->assign('BASE_URL', $base_url);
$tpl->assign('Q', $q);
$tpl->assign('DOMAIN', $domain);
$tpl->assign('URL_THEMES', NV_STATIC_URL . 'themes/' . $global_config['site_theme'] . '/');
$tpl->assign('UPLOAD_URL', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=upload');
$tpl->assign('UPLOAD_CURRENT', '');
$tpl->assign('URL_THEMES', NV_STATIC_URL . 'themes/' . $global_config['site_theme'] . '/');
$tpl->assign('NV_BASE_ADMINURL', NV_BASE_ADMINURL);
$tpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
$tpl->assign('NV_LANG_DATA', NV_LANG_DATA);
$tpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
$tpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);
$tpl->assign('MODULE_UPLOAD', $module_upload);
$tpl->assign('BANK_LIST', $BANK_LIST);

$contents = $tpl->fetch('add_bank_info.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
