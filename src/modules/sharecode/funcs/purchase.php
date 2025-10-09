<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

use NukeViet\Api\DoApi;

if (!$nv_Request->isset_request('ajax', 'post') || !defined('NV_IS_USER')) {
    nv_jsonOutput([
        'status' => 'error',
        'message' => 'Truy cập không hợp lệ'
    ]);
}

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=purchase';
$array_mod_title[] = [
    'title' => 'Thanh toán',
    'link' => nv_url_rewrite($base_url, true)
];

$source_id = $nv_Request->get_int('source_id', 'post', 0);
$amount = $nv_Request->get_float('amount', 'post', 0);
$purchase_type = $nv_Request->get_title('type', 'post', '');

if ($source_id <= 0 || $amount < 0) {
    nv_jsonOutput([
        'status' => 'error',
        'message' => 'Thông tin sản phẩm không hợp lệ'
    ]);
}

$sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id . " AND status=1";
$source = $db->query($sql)->fetch();

if (empty($source)) {
    nv_jsonOutput([
        'status' => 'error',
        'message' => 'Sản phẩm không tồn tại'
    ]);
}

if ($source['fee_type'] == 'free') {
    nv_jsonOutput([
        'status' => 'error',
        'message' => 'Sản phẩm này miễn phí, không cần thanh toán'
    ]);
}

if ($source['fee_amount'] != $amount) {
    nv_jsonOutput([
        'status' => 'error',
        'message' => 'Giá sản phẩm không đúng'
    ]);
}

$sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
        WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id . " AND status='completed'";
$purchased = $db->query($sql)->fetchColumn();

if ($purchased) {
    nv_jsonOutput([
        'status' => 'error',
        'message' => 'Bạn đã mua sản phẩm này rồi'
    ]);
}

$api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
$api->setModule('wallet')
    ->setLang(NV_LANG_DATA)
    ->setAction('GetUserBalance')
    ->setData([
        'userid' => $user_info['userid'],
        'currency' => 'VND'
    ]);
$balance_result = $api->execute();

if ($balance_result['status'] != 'success' || $balance_result['data']['balance'] < $amount) {
    nv_jsonOutput([
        'status' => 'error',
        'code' => 'insufficient_funds',
        'message' => 'Số dư không đủ để mua sản phẩm này',
        'data' => [
            'current_balance' => $balance_result['status'] == 'success' ? number_format($balance_result['data']['balance']) . ' VNĐ' : '0 VNĐ',
            'needed_amount' => number_format($amount) . ' VNĐ'
        ]
    ]);
}

try {
    $db->query('BEGIN');

    $api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
    $api->setModule('wallet')
        ->setLang(NV_LANG_DATA)
        ->setAction('DeductBalance')
        ->setData([
            'userid' => $user_info['userid'],
            'amount' => $amount,
            'currency' => 'VND',
            'description' => 'Mua mã nguồn: ' . $source['title'],
            'reference_type' => 'sharecode_purchase',
            'reference_id' => $source_id
        ]);
    $wallet_result = $api->execute();

    if ($wallet_result['status'] != 'success') {
        throw new Exception('Lỗi trừ tiền từ ví: ' . $wallet_result['message']);
    }

    $purchase_id = md5($user_info['userid'] . $source_id . NV_CURRENTTIME);

    $author_commission = nv_sharecode_calculate_commission($amount);

    $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_purchases (
        id, userid, source_id, amount, author_commission, currency, payment_method,
        transaction_id, status, purchase_time, payment_time, notes
    ) VALUES (
        " . $db->quote($purchase_id) . ",
        " . $user_info['userid'] . ",
        " . $source_id . ",
        " . $amount . ",
        " . $author_commission . ",
        'VND',
        'wallet',
        " . $db->quote($wallet_result['transaction']['transaction_id']) . ",
        'completed',
        " . NV_CURRENTTIME . ",
        " . NV_CURRENTTIME . ",
        " . $db->quote('Thanh toán qua ví điện tử') . "
    )";

    if (!$db->query($sql)) {
        throw new Exception('Lỗi lưu thông tin đơn hàng');
    }

    $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources
            SET num_download = num_download + 1, last_download = " . NV_CURRENTTIME . "
            WHERE id = " . $source_id;
    $db->query($sql);
    $log_data = [
        'userid' => $user_info['userid'],
        'source_id' => $source_id,
        'action' => 'purchase',
        'ip' => NV_CLIENT_IP,
        'user_agent' => $global_config['user_agent'],
        'log_time' => NV_CURRENTTIME,
        'details' => json_encode([
            'amount' => $amount,
            'transaction_id' => $wallet_result['transaction']['transaction_id'],
            'purchase_id' => $purchase_id,
            'new_balance' => $wallet_result['transaction']['new_balance']
        ])
    ];

    $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_logs (
        userid, source_id, action, ip, user_agent, log_time, details
    ) VALUES (
        " . $log_data['userid'] . ",
        " . $log_data['source_id'] . ",
        " . $db->quote($log_data['action']) . ",
        " . $db->quote($log_data['ip']) . ",
        " . $db->quote($log_data['user_agent']) . ",
        " . $log_data['log_time'] . ",
        " . $db->quote($log_data['details']) . "
    )";
    $db->query($sql);
    nv_sharecode_send_purchase_success_email($user_info, $source, $purchase_id, $amount, $wallet_result['transaction']['transaction_id']);

    nv_jsonOutput([
        'status' => 'success',
        'message' => 'Thanh toán thành công',
        'data' => [
            'purchase_id' => $purchase_id,
            'download_url' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=download&id=' . $source_id,
            'source_title' => $source['title'],
            'amount_paid' => number_format($amount) . ' VNĐ'
        ]
    ]);
} catch (Exception $e) {
    $db->query('ROLLBACK');

    nv_jsonOutput([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
