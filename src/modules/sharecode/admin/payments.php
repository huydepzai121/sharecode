<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

$page_title = 'Quản lý đơn hàng';


if ($nv_Request->isset_request('action', 'post') && $nv_Request->get_title('action', 'post') === 'admin_payment') {
    $userid = $nv_Request->get_title('userid', 'post', '');
    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    $amount = $nv_Request->get_float('amount', 'post', 0);
    $notes = $nv_Request->get_title('notes', 'post', '');

    $error = [];


    if (empty($userid)) {
        $error[] = 'Vui lòng chọn user';
    }
    if ($source_id <= 0) {
        $error[] = 'Vui lòng chọn mã nguồn';
    }
    if ($amount < 0) {
        $error[] = 'Số tiền phải lớn hơn 0';
    }


    $real_userid = 0;
    if (!empty($userid)) {
        if (is_numeric($userid)) {

            $sql = "SELECT userid FROM " . NV_USERS_GLOBALTABLE . " WHERE userid = " . intval($userid);
            $real_userid = $db->query($sql)->fetchColumn();
        } else {

            $sql = "SELECT userid FROM " . NV_USERS_GLOBALTABLE . " WHERE username = " . $db->quote($userid);
            $real_userid = $db->query($sql)->fetchColumn();
        }

        if (!$real_userid) {
            $error[] = 'User không tồn tại';
        }
    }


    if ($source_id > 0) {
        $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id = " . $source_id;
        if (!$db->query($sql)->fetchColumn()) {
            $error[] = 'Mã nguồn không tồn tại';
        }
    }


    if ($real_userid > 0 && $source_id > 0) {
        $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases WHERE userid = " . $real_userid . " AND source_id = " . $source_id . " AND status = 'completed'";
        if ($db->query($sql)->fetchColumn()) {
            $error[] = 'User đã mua mã nguồn này rồi';
        }
    }

    if (empty($error)) {
        try {
            $db->beginTransaction();


            $purchase_id = md5($real_userid . '_' . $source_id . '_' . time() . rand(1000, 9999));


            $transaction_id = 'ADMIN_PAY_' . time() . '_' . $real_userid . '_' . $source_id;


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
                ':userid' => $real_userid,
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

            nv_jsonOutput([
                'status' => 'success',
                'message' => 'Đã tạo thành công đơn hàng thanh toán hộ user!'
            ]);
        } catch (Exception $e) {
            $db->rollback();
            nv_jsonOutput([
                'status' => 'error',
                'message' => 'Có lỗi xảy ra: ' . $e->getMessage()
            ]);
        }
    } else {
        nv_jsonOutput([
            'status' => 'error',
            'message' => implode('<br>', $error)
        ]);
    }
}


if ($nv_Request->isset_request('bulk_action', 'post')) {
    $action = $nv_Request->get_title('action', 'post', '');
    $selected_ids = $nv_Request->get_array('selected_ids', 'post', []);

    if (!empty($action) && !empty($selected_ids)) {
        $success_count = 0;
        $error_count = 0;

        foreach ($selected_ids as $id) {
            $id = trim($id);
            if (empty($id)) continue;

            try {
                switch ($action) {
                    case 'delete_selected':
                        $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases WHERE id = " . $db->quote($id);
                        if ($db->exec($sql)) {
                            $success_count++;
                        } else {
                            $error_count++;
                        }
                        break;

                    case 'mark_completed':
                    case 'mark_pending':
                    case 'mark_failed':
                    case 'mark_cancelled':
                        $new_status = str_replace('mark_', '', $action);
                        $update_data = ['status' => $new_status];

                        if ($new_status == 'completed') {
                            $update_data['payment_time'] = NV_CURRENTTIME;
                        }

                        $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_purchases SET ";
                        $sql_parts = [];
                        foreach ($update_data as $field => $value) {
                            if ($field == 'payment_time') {
                                $sql_parts[] = $field . " = " . $value;
                            } else {
                                $sql_parts[] = $field . " = " . $db->quote($value);
                            }
                        }
                        $sql .= implode(', ', $sql_parts);
                        $sql .= " WHERE id = " . $db->quote($id);

                        if ($db->exec($sql)) {
                            $success_count++;
                        } else {
                            $error_count++;
                        }
                        break;

                    case 'export_selected':
                        exportPaymentsToExcel($selected_ids, $db, $module_data);
                        exit();
                }
            } catch (Exception $e) {
                $error_count++;
            }
        }

        $message = "Đã xử lý thành công {$success_count} mục";
        if ($error_count > 0) {
            $message .= ", {$error_count} mục lỗi";
        }

        nv_jsonOutput([
            'status' => 'success',
            'message' => $message
        ]);
    } else {
        nv_jsonOutput([
            'status' => 'error',
            'message' => 'Vui lòng chọn thao tác và ít nhất 1 mục'
        ]);
    }
}


$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('payments.tpl'));


$action = $nv_Request->get_title('action', 'get', '');
$id = $nv_Request->get_title('id', 'get', '');
$checkss = $nv_Request->get_title('checkss', 'get', '');


if ($action == 'delete' && !empty($id) && $checkss == md5($id . NV_CHECK_SESSION . $global_config['sitekey'])) {
    $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases WHERE id = " . $db->quote($id);
    if ($db->exec($sql)) {
        nv_jsonOutput([
            'status' => 'success',
            'mess' => 'Xóa đơn hàng thành công'
        ]);
    } else {
        nv_jsonOutput([
            'status' => 'error',
            'mess' => 'Có lỗi xảy ra khi xóa đơn hàng'
        ]);
    }
}


if ($nv_Request->isset_request('update_status', 'post')) {
    $id = $nv_Request->get_title('id', 'post', '');
    $new_status = $nv_Request->get_title('status', 'post', '');
    $checkss = $nv_Request->get_title('checkss', 'post', '');
    $allowed_status = ['pending', 'completed', 'failed', 'cancelled', 'refunded'];

    if (md5($id . NV_CHECK_SESSION . $global_config['sitekey']) == $checkss) {
        if (in_array($new_status, $allowed_status)) {
            $update_data = ['status' => $new_status];


            if ($new_status == 'completed') {
                $update_data['payment_time'] = NV_CURRENTTIME;
            }

            $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_purchases SET ";
            $sql_parts = [];
            foreach ($update_data as $field => $value) {
                if ($field == 'payment_time') {
                    $sql_parts[] = $field . " = " . $value;
                } else {
                    $sql_parts[] = $field . " = " . $db->quote($value);
                }
            }
            $sql .= implode(', ', $sql_parts);
            $sql .= " WHERE id = " . $db->quote($id);

            if ($db->exec($sql)) {
                nv_jsonOutput([
                    'status' => 'success',
                    'mess' => 'Cập nhật trạng thái thành công'
                ]);
            } else {
                nv_jsonOutput([
                    'status' => 'error',
                    'mess' => 'Có lỗi xảy ra khi cập nhật trạng thái'
                ]);
            }
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'mess' => 'Trạng thái không hợp lệ'
            ]);
        }
    } else {
        nv_jsonOutput([
            'status' => 'error',
            'mess' => 'Không đúng checksum'
        ]);
    }
}

// Xử lý xem chi tiết đơn hàng
if ($action == 'view' && !empty($id)) {
    $sql = "SELECT p.*, s.title as source_title, s.alias as source_alias, s.fee_amount as source_price,
                   u.username, u.first_name, u.last_name, u.email
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
            LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
            LEFT JOIN " . $db_config['prefix'] . "_users u ON p.userid = u.userid
            WHERE p.id = " . $db->quote($id);

    $payment = $db->query($sql)->fetch();

    if (empty($payment)) {
        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=payments');
    }

    // Định dạng dữ liệu
    $payment['amount_formatted'] = number_format($payment['amount'], 0, ',', '.') . ' ' . $payment['currency'];
    $payment['purchase_time_formatted'] = date('H:i:s d/m/Y', $payment['purchase_time']);
    $payment['payment_time_formatted'] = $payment['payment_time'] ? date('H:i:s d/m/Y', $payment['payment_time']) : '';
    $payment['full_name'] = trim($payment['first_name'] . ' ' . $payment['last_name']);

    // Tạo URL cho source nếu có
    if (!empty($payment['source_alias'])) {
        $payment['source_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $payment['source_alias'];
    } else {
        $payment['source_url'] = '';
    }

    // Format source price
    if (!empty($payment['source_price'])) {
        $payment['source_price_formatted'] = number_format($payment['source_price'], 0, ',', '.') . ' VND';
    } else {
        $payment['source_price_formatted'] = '0 VND';
    }

    // Tạo delete URL
    $payment['delete_url'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=payments&action=delete&id=' . $payment['id'] . '&checkss=' . md5($payment['id'] . NV_CHECK_SESSION . $global_config['sitekey']);

    // Trạng thái
    $status_list = [
        'pending' => ['title' => 'Chờ thanh toán', 'class' => 'warning'],
        'completed' => ['title' => 'Đã thanh toán', 'class' => 'success'],
        'failed' => ['title' => 'Thanh toán thất bại', 'class' => 'danger'],
        'cancelled' => ['title' => 'Đã hủy', 'class' => 'secondary'],
        'refunded' => ['title' => 'Đã hoàn tiền', 'class' => 'info']
    ];

    $status_info = $status_list[$payment['status']] ?? $status_list['pending'];
    $payment['status_info'] = $status_info;
    $payment['status_class'] = $status_info['class'];
    $payment['status_text'] = $status_info['title'];
    $payment['checksess'] = md5($payment['id'] . NV_CHECK_SESSION . $global_config['sitekey']);

    // Sử dụng template riêng cho detail
    $detail_tpl = new \NukeViet\Template\NVSmarty();
    $detail_tpl->setTemplateDir(get_module_tpl_dir('payments_detail.tpl'));
    $detail_tpl->assign('PAYMENT', $payment);
    $detail_tpl->assign('STATUS_LIST', $status_list);
    $detail_tpl->assign('CHECKSS', md5($payment['id'] . NV_CHECK_SESSION . $global_config['sitekey']));
    $detail_tpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=payments');

    $contents = $detail_tpl->fetch('payments_detail.tpl');

    include NV_ROOTDIR . '/includes/header.php';
    echo nv_admin_theme($contents);
    include NV_ROOTDIR . '/includes/footer.php';
    exit();
}

// Lấy danh sách đơn hàng
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 20;

// Bộ lọc
$search = $nv_Request->get_title('search', 'get', '');
$status_filter = $nv_Request->get_title('status', 'get', '');
$date_from = $nv_Request->get_title('date_from', 'get', '');
$date_to = $nv_Request->get_title('date_to', 'get', '');

$where_conditions = [];
$where_params = [];

if (!empty($search)) {
    $where_conditions[] = "(p.id LIKE :search OR s.title LIKE :search2 OR u.username LIKE :search3 OR u.email LIKE :search4)";
    $where_params[':search'] = '%' . $search . '%';
    $where_params[':search2'] = '%' . $search . '%';
    $where_params[':search3'] = '%' . $search . '%';
    $where_params[':search4'] = '%' . $search . '%';
}

if (!empty($status_filter)) {
    $where_conditions[] = "p.status = :status";
    $where_params[':status'] = $status_filter;
}

if (!empty($date_from)) {
    $timestamp_from = strtotime($date_from . ' 00:00:00');
    if ($timestamp_from) {
        $where_conditions[] = "p.purchase_time >= :date_from";
        $where_params[':date_from'] = $timestamp_from;
    }
}

if (!empty($date_to)) {
    $timestamp_to = strtotime($date_to . ' 23:59:59');
    if ($timestamp_to) {
        $where_conditions[] = "p.purchase_time <= :date_to";
        $where_params[':date_to'] = $timestamp_to;
    }
}

$where_clause = !empty($where_conditions) ? 'WHERE ' . implode(' AND ', $where_conditions) : '';

// Đếm tổng số bản ghi
$sql_count = "SELECT COUNT(*) 
              FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
              LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
              LEFT JOIN " . $db_config['prefix'] . "_users u ON p.userid = u.userid
              " . $where_clause;

$stmt_count = $db->prepare($sql_count);

foreach ($where_params as $key => $value) {
    $stmt_count->bindValue($key, $value);
}
$stmt_count->execute();
$total_records = $stmt_count->fetchColumn();

// Tính toán phân trang
$total_pages = ceil($total_records / $per_page);
$offset = ($page - 1) * $per_page;

// Lấy dữ liệu
$sql = "SELECT p.*, s.title as source_title, s.alias as source_alias, s.fee_amount as source_price,
               u.username, u.first_name, u.last_name, u.email
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
        LEFT JOIN " . $db_config['prefix'] . "_users u ON p.userid = u.userid
        " . $where_clause . "
        ORDER BY p.purchase_time DESC
        LIMIT " . $per_page . " OFFSET " . $offset;


$stmt = $db->prepare($sql);
foreach ($where_params as $key => $value) {
    $stmt->bindValue($key, $value);
}
$stmt->execute();
$payments = $stmt->fetchAll();

// Định dạng dữ liệu
$status_list = [
    'pending' => ['title' => 'Chờ thanh toán', 'class' => 'warning'],
    'completed' => ['title' => 'Đã thanh toán', 'class' => 'success'],
    'failed' => ['title' => 'Thanh toán thất bại', 'class' => 'danger'],
    'cancelled' => ['title' => 'Đã hủy', 'class' => 'secondary'],
    'refunded' => ['title' => 'Đã hoàn tiền', 'class' => 'info']
];

// Status options for search filter
$status_search = [
    '' => 'Tất cả trạng thái',
    'pending' => 'Chờ thanh toán',
    'completed' => 'Đã thanh toán',
    'failed' => 'Thanh toán thất bại',
    'cancelled' => 'Đã hủy',
    'refunded' => 'Đã hoàn tiền'
];

foreach ($payments as &$payment) {
    $payment['amount_formatted'] = number_format($payment['amount'], 0, ',', '.') . ' ' . $payment['currency'];
    $payment['purchase_time_formatted'] = date('H:i:s d/m/Y', $payment['purchase_time']);
    $payment['payment_time_formatted'] = $payment['payment_time'] ? date('H:i:s d/m/Y', $payment['payment_time']) : '';
    $payment['full_name'] = trim($payment['first_name'] . ' ' . $payment['last_name']);

    // Thêm status_class và status_text riêng biệt
    $status_info = $status_list[$payment['status']] ?? $status_list['pending'];
    $payment['status_info'] = $status_info;
    $payment['status_class'] = $status_info['class'];
    $payment['status_text'] = $status_info['title'];

    $payment['delete_url'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=payments&action=delete&id=' . $payment['id'] . '&checkss=' . md5($payment['id'] . NV_CHECK_SESSION . $global_config['sitekey']);
    $payment['view_url'] = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=payments&action=view&id=' . $payment['id'];

    // Tạo checksum cho update status
    $payment['checksess'] = md5($payment['id'] . NV_CHECK_SESSION . $global_config['sitekey']);
    $payment['update_checkss'] = md5($payment['id'] . NV_CHECK_SESSION . $global_config['sitekey']);

    // Tạo URL cho source nếu có
    if (!empty($payment['source_alias'])) {
        $payment['source_url'] = NV_BASE_SITEURL . $module_name . '/' . $payment['source_alias'] . '/';
    } else {
        $payment['source_url'] = '';
    }

    // Format source price
    if (!empty($payment['source_price'])) {
        $payment['source_price_formatted'] = number_format($payment['source_price'], 0, ',', '.') . ' VND';
    } else {
        $payment['source_price_formatted'] = '0 VND';
    }
}

// Tạo phân trang
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=payments';
$generate_page = nv_generate_page($base_url, $total_records, $per_page, $page);

// Thêm số thứ tự cho payments
foreach ($payments as $index => &$payment) {
    $payment['stt'] = ($page - 1) * $per_page + $index + 1;
}

// Lấy danh sách mã nguồn cho modal
$sources = [];
$sql = "SELECT id, title, fee_amount, fee_type  FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE status = 1 AND id =5 ORDER BY title";
$result = $db->query($sql);
while ($row = $result->fetch()) {
    $sources[] = [
        'id' => $row['id'],
        'title' => $row['title'],
        'fee_amount' => $row['fee_amount'],
        'fee_type' => $row['fee_type']
    ];
}

// Tạo filtersql cho popup chọn user
$filtersql = ' active = 1';

// Tạo danh sách actions cho bulk operations
$actions = [
    ['value' => '', 'title' => 'Chọn thao tác'],
    ['value' => 'delete_selected', 'title' => 'Xóa các mục đã chọn'],
    ['value' => 'mark_completed', 'title' => 'Đánh dấu đã thanh toán'],
    ['value' => 'mark_pending', 'title' => 'Đánh dấu chờ thanh toán'],
    ['value' => 'mark_failed', 'title' => 'Đánh dấu thanh toán thất bại'],
    ['value' => 'mark_cancelled', 'title' => 'Đánh dấu đã hủy'],
    ['value' => 'export_selected', 'title' => 'Xuất Excel các mục đã chọn']
];

// Create search array for template
$search_array = [
    'search' => $search,
    'status' => $status_filter,
    'date_from' => $date_from,
    'date_to' => $date_to
];

$tpl->assign('PAYMENTS', $payments);
$tpl->assign('STATUS_LIST', $status_list);
$tpl->assign('STATUS_SEARCH', $status_search);
$tpl->assign('ACTIONS', $actions);
$tpl->assign('SEARCH', $search_array);
$tpl->assign('STATUS_FILTER', $status_filter);
$tpl->assign('DATE_FROM', $date_from);
$tpl->assign('DATE_TO', $date_to);
$tpl->assign('TOTAL_RECORDS', $total_records);
$tpl->assign('GENERATE_PAGE', $generate_page);
$tpl->assign('PAGINATION', $generate_page);
$tpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=payments');
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('sources', $sources);
$tpl->assign('FILTERSQL', $crypt->encrypt($filtersql, NV_CHECK_SESSION));

$contents = $tpl->fetch('payments.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

/**
 * Xuất danh sách đơn hàng ra Excel
 */
function exportPaymentsToExcel($payment_ids, $db, $module_data)
{
    global $db_config;

    if (empty($payment_ids)) {
        nv_jsonOutput([
            'status' => 'error',
            'message' => 'Không có dữ liệu để xuất'
        ]);
        return;
    }

    // Tạo placeholders cho IN clause
    $placeholders = str_repeat('?,', count($payment_ids) - 1) . '?';

    // Query lấy dữ liệu
    $sql = "SELECT p.*, s.title as source_title, s.alias as source_alias, s.fee_amount as source_price,
                   u.username, u.first_name, u.last_name, u.email
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
            LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
            LEFT JOIN " . $db_config['prefix'] . "_users u ON p.userid = u.userid
            WHERE p.id IN ($placeholders)
            ORDER BY p.purchase_time DESC";

    $stmt = $db->prepare($sql);
    $stmt->execute($payment_ids);
    $payments = $stmt->fetchAll();

    if (empty($payments)) {
        nv_jsonOutput([
            'status' => 'error',
            'message' => 'Không tìm thấy dữ liệu'
        ]);
        return;
    }

    // Tạo nội dung CSV
    $csv_content = "\xEF\xBB\xBF"; // UTF-8 BOM

    // Header
    $headers = [
        'Mã đơn hàng',
        'Mã giao dịch',
        'Tên khách hàng',
        'Username',
        'Email',
        'Sản phẩm',
        'Số tiền',
        'Tiền tệ',
        'Phương thức TT',
        'Trạng thái',
        'Thời gian đặt hàng',
        'Thời gian thanh toán',
        'Ghi chú'
    ];

    $csv_content .= implode(',', array_map(function ($header) {
        return '"' . str_replace('"', '""', $header) . '"';
    }, $headers)) . "\n";

    // Dữ liệu
    $status_map = [
        'pending' => 'Chờ thanh toán',
        'completed' => 'Đã thanh toán',
        'failed' => 'Thanh toán thất bại',
        'cancelled' => 'Đã hủy',
        'refunded' => 'Đã hoàn tiền'
    ];

    foreach ($payments as $payment) {
        $row = [
            $payment['id'],
            $payment['transaction_id'] ?: '',
            trim($payment['first_name'] . ' ' . $payment['last_name']),
            $payment['username'] ?: '',
            $payment['email'] ?: '',
            $payment['source_title'] ?: '',
            number_format($payment['amount'], 0, ',', '.'),
            $payment['currency'] ?: 'VND',
            $payment['payment_method'] ?: '',
            $status_map[$payment['status']] ?? $payment['status'],
            date('d/m/Y H:i:s', $payment['purchase_time']),
            $payment['payment_time'] ? date('d/m/Y H:i:s', $payment['payment_time']) : '',
            $payment['notes'] ?: ''
        ];

        $csv_content .= implode(',', array_map(function ($field) {
            return '"' . str_replace('"', '""', $field) . '"';
        }, $row)) . "\n";
    }

    // Tạo tên file
    $filename = 'don_hang_' . date('Y-m-d_H-i-s') . '.csv';

    // Headers để download
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filename . '"');
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
    header('Pragma: public');
    header('Content-Length: ' . strlen($csv_content));

    // Xuất nội dung
    echo $csv_content;
    exit();
}
