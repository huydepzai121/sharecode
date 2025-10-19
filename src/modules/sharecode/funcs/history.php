<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

if ($nv_Request->isset_request('get_download_token', 'post')) {
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập']);
    }

    $source_id = $nv_Request->get_int('source_id', 'post', 0);

    if ($source_id <= 0) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Source ID không hợp lệ']);
    }

    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id . " AND status=1";
    $source = $db->query($sql)->fetch();

    if (empty($source)) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Mã nguồn không tồn tại']);
    }

    $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
            WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id . " AND status='completed'";
    $purchased = $db->query($sql_check)->fetchColumn();

    if (!$purchased) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Bạn chưa mua mã nguồn này']);
    }

    if (empty($source['download_link'])) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Link tải xuống không hợp lệ hoặc chưa được cấu hình']);
    }

    $download_url = $source['download_link'];

    $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources
            SET num_download = num_download + 1
            WHERE id = " . $source_id;
    $db->query($sql_update);

    $log_data = json_encode([
        'download_type' => 'history',
        'download_url' => $source['download_link'],
        'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? ''
    ]);

    $sql_log = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_logs (
        userid, source_id, action, ip, user_agent, log_time, details
    ) VALUES (
        " . $user_info['userid'] . ",
        " . $source_id . ",
        'download',
        " . $db->quote(NV_CLIENT_IP) . ",
        " . $db->quote($_SERVER['HTTP_USER_AGENT'] ?? '') . ",
        " . NV_CURRENTTIME . ",
        " . $db->quote($log_data) . "
    )";
    $db->query($sql_log);

    nv_jsonOutput([
        'status' => 'success',
        'download_url' => $download_url
    ]);
}

$view_userid = $nv_Request->get_int('userid', 'get', 0);

if (!defined('NV_IS_USER')) {
    $redirect_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history' . ($view_userid > 0 ? '&userid=' . $view_userid : '');
    $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login&nv_redirect=' . nv_base64_encode($redirect_url);
    nv_redirect_location($login_url);
}

$target_userid = $user_info['userid'];

if ($view_userid > 0) {
    if ($view_userid == $user_info['userid']) {
        $target_userid = $user_info['userid'];
    } else {
        if (defined('NV_IS_ADMIN')) {
            $target_userid = $view_userid;

            $sql_user = "SELECT userid, username, first_name, last_name FROM " . NV_USERS_GLOBALTABLE . " WHERE userid = " . $view_userid;
            $target_user = $db->query($sql_user)->fetch();

            if (empty($target_user)) {
                nv_info_die('Lỗi', 'Lỗi', 'User không tồn tại', 404);
            }

            $page_title = 'Lịch sử mua code của ' . ($target_user['first_name'] . ' ' . $target_user['last_name']);
        } else {
            nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history&userid=' . $user_info['userid']);
        }
    }
} else {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history&userid=' . $user_info['userid']);
}

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history&userid=' . $target_userid;
$array_mod_title[] = [
    'title' => 'Lịch sử mua hàng',
    'link' => nv_url_rewrite($base_url, true)
];

$page_title = 'Lịch sử mua code';
$key_words = 'lịch sử, mua code, sharecode';
$description = 'Xem lịch sử các mã nguồn đã mua';

$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 20;
$offset = ($page - 1) * $per_page;

$sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
              WHERE userid=" . $target_userid . " AND status='completed'";
$total_purchases = $db->query($sql_count)->fetchColumn();

$sql = "SELECT p.*, s.title, s.alias, s.avatar, s.description, s.fee_type, s.fee_amount,
               s.download_link_type, s.download_link, s.file_path, s.file_name,
               c.title as category_title
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
        WHERE p.userid=" . $target_userid . " AND p.status='completed'
        ORDER BY p.purchase_time DESC
        LIMIT " . $per_page . " OFFSET " . $offset;

$result = $db->query($sql);
$purchases = [];

while ($row = $result->fetch()) {
    $row['purchase_time_format'] = date('d/m/Y H:i', $row['purchase_time']);
    $row['payment_time_format'] = date('d/m/Y H:i', $row['payment_time']);
    $row['amount_format'] = ($row['amount'] > 0) ? number_format($row['amount'], 0, '.', ',') . ' VNĐ' : 'Miễn phí';

    // Xử lý hình ảnh sản phẩm
    if (!empty($row['avatar']) && file_exists(NV_ROOTDIR . '/' . $row['avatar'])) {
        $row['image_url'] =  $row['avatar'];
    } else {
        $row['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
    }

    $detail_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $row['alias'];
    $row['detail_url'] = nv_url_rewrite($detail_url, true);

    $token = md5($row['source_id'] . $user_info['userid'] . $global_config['sitekey'] . date('Ymd'));
    if ($row['download_link_type'] == 'external') {
        $row['download_url'] = $row['detail_url'];
    } else {
        $download_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=download&id=' . $row['source_id'] . '&token=' . $token;
        $row['download_url'] = $download_url;
    }

    $payment_methods = [
        'wallet_auto' => 'Ví điện tử',
        'free' => 'Miễn phí',
        'manual' => 'Chuyển khoản',
        'vnpay' => 'VNPay',
        'paypal' => 'PayPal'
    ];
    $row['payment_method_text'] = isset($payment_methods[$row['payment_method']]) ? $payment_methods[$row['payment_method']] : $row['payment_method'];

    $purchases[] = $row;
}

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history&userid=' . $target_userid;
$generate_page = nv_generate_page($base_url, $total_purchases, $per_page, $page);

$sql_stats = "SELECT
                COUNT(*) as total_items,
                SUM(amount) as total_spent,
                COUNT(CASE WHEN amount = 0 THEN 1 END) as free_items,
                COUNT(CASE WHEN amount > 0 THEN 1 END) as paid_items
              FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
              WHERE userid=" . $target_userid . " AND status='completed'";
$stats = $db->query($sql_stats)->fetch();

$stats['total_spent_format'] = number_format((float)$stats['total_spent'], 0, '.', ',') . ' VNĐ';

$contents = nv_theme_sharecode_history($purchases, $generate_page, $stats, $total_purchases);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
