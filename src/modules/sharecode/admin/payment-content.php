<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 3-9-2010 0:14
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

$page_title = 'Thanh toán hộ user';

// Lấy danh sách user
$users = [];
$sql = "SELECT userid, username, first_name, last_name, email FROM " . NV_USERS_GLOBALTABLE . " WHERE active = 1 ORDER BY username";
$result = $db->query($sql);
while ($row = $result->fetch()) {
    $users[] = [
        'userid' => $row['userid'],
        'username' => $row['username'],
        'full_name' => trim($row['first_name'] . ' ' . $row['last_name']),
        'email' => $row['email']
    ];
}

// Lấy danh sách mã nguồn
$sources = [];
$sql = "SELECT id, title, fee_amount FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE status = 1 ORDER BY title";
$result = $db->query($sql);
while ($row = $result->fetch()) {
    $sources[] = [
        'id' => $row['id'],
        'title' => $row['title'],
        'fee_amount' => $row['fee_amount']
    ];
}

$error = [];
$success = '';

if ($nv_Request->isset_request('submit', 'post')) {
    $userid = $nv_Request->get_int('userid', 'post', 0);
    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    $amount = $nv_Request->get_float('amount', 'post', 0);
    $notes = $nv_Request->get_title('notes', 'post', '');

    // Validate
    if ($userid <= 0) {
        $error[] = 'Vui lòng chọn user';
    }
    if ($source_id <= 0) {
        $error[] = 'Vui lòng chọn mã nguồn';
    }
    if ($amount < 0) {
        $error[] = 'Số tiền phải lớn hơn 0';
    }

    // Kiểm tra user có tồn tại không
    if ($userid > 0) {
        $sql = "SELECT userid FROM " . NV_USERS_GLOBALTABLE . " WHERE userid = " . $userid;
        if (!$db->query($sql)->fetchColumn()) {
            $error[] = 'User không tồn tại';
        }
    }

    // Kiểm tra mã nguồn có tồn tại không
    if ($source_id > 0) {
        $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id = " . $source_id;
        if (!$db->query($sql)->fetchColumn()) {
            $error[] = 'Mã nguồn không tồn tại';
        }
    }

    // Kiểm tra user đã mua mã nguồn này chưa
    if ($userid > 0 && $source_id > 0) {
        $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases WHERE userid = " . $userid . " AND source_id = " . $source_id . " AND status = 'completed'";
        if ($db->query($sql)->fetchColumn()) {
            $error[] = 'User đã mua mã nguồn này rồi';
        }
    }

    if (empty($error)) {
        try {
            $db->beginTransaction();

            // Tạo ID đơn hàng
            $purchase_id = md5($userid . '_' . $source_id . '_' . time() . rand(1000, 9999));

            // Tạo mã giao dịch
            $transaction_id = 'ADMIN_PAY_' . time() . '_' . $userid . '_' . $source_id;

            // Thêm vào bảng purchases
            $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_purchases (
                id, userid, source_id, amount, currency, payment_method,
                transaction_id, status, purchase_time, payment_time, notes
            ) VALUES (
                :id, :userid, :source_id, :amount, :currency, :payment_method,
                :transaction_id, :status, :purchase_time, :payment_time, :notes
            )";

            $purchase_notes = "Thanh toán hộ bởi admin " . $admin_info['username'];
            if (!empty($notes)) {
                $purchase_notes .= ". Ghi chú: " . $notes;
            }

            $sth = $db->prepare($sql);
            $sth->execute([
                ':id' => $purchase_id,
                ':userid' => $userid,
                ':source_id' => $source_id,
                ':amount' => $amount,
                ':currency' => 'VND',
                ':payment_method' => 'admin_payment',
                ':transaction_id' => $transaction_id,
                ':status' => 'completed',
                ':purchase_time' => NV_CURRENTTIME,
                ':payment_time' => NV_CURRENTTIME,
                ':notes' => $purchase_notes
            ]);

            $db->commit();
            $success = 'Đã tạo thành công đơn hàng thanh toán hộ user!';

            // Reset form
            $userid = $source_id = 0;
            $amount = 0;
            $notes = '';

        } catch (Exception $e) {
            $db->rollback();
            $error[] = 'Có lỗi xảy ra: ' . $e->getMessage();
        }
    }
} else {
    $userid = $source_id = 0;
    $amount = 0;
    $notes = '';
}

// Tạo filtersql cho popup chọn user
$filtersql = ' active = 1';

// Use modern Smarty templating
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('payment-content.tpl'));
$tpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);

// Assign dữ liệu
$tpl->assign('errors', $error);
$tpl->assign('success', $success);
$tpl->assign('users', $users);
$tpl->assign('sources', $sources);
$tpl->assign('FILTERSQL', $crypt->encrypt($filtersql, NV_CHECK_SESSION));
$tpl->assign('data', [
    'userid' => $userid,
    'source_id' => $source_id,
    'amount' => $amount,
    'notes' => $notes
]);

$contents = $tpl->fetch('payment-content.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
