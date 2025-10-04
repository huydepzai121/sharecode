<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

define('NV_IS_MOD_SHARECODE', true);
use NukeViet\Api\DoApi;

/**
 * nv_sharecode_user_menu()
 * Tạo menu user cho module sharecode
 *
 * @return array
 */
function nv_sharecode_user_menu()
{
    global $module_name, $lang_module, $user_info;
    
    $menu = [];
    
    if (defined('NV_IS_USER')) {
        $menu[] = [
            'title' => 'Bảng điều khiển',
            'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=dashboard',
            'icon' => 'fa fa-dashboard'
        ];
        
        $menu[] = [
            'title' => 'Lịch sử mua code',
            'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history&userid=' . $user_info['userid'],
            'icon' => 'fa fa-history'
        ];

        $menu[] = [
            'title' => 'Doanh thu bán code',
            'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=revenue',
            'icon' => 'fa fa-chart-line'
        ];

        $menu[] = [
            'title' => 'Sản phẩm yêu thích',
            'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=favorites',
            'icon' => 'fa fa-heart'
        ];

    }
    
    return $menu;
}

/**
 * nv_sharecode_calculate_commission()
 * Tính hoa hồng cho tác giả
 *
 * @param float $amount Số tiền giao dịch
 * @param float $rate Tỷ lệ hoa hồng (nếu null sẽ lấy từ config)
 * @return float
 */
function nv_sharecode_calculate_commission($amount, $rate = null)
{
    global $module_config;

    if ($rate === null) {
        $rate = isset($module_config['author_commission_rate']) ? $module_config['author_commission_rate'] / 100 : 0.7;
    }

    return round($amount * $rate, 2);
}

/**
 * nv_sharecode_update_purchase_commission()
 * Cập nhật hoa hồng cho giao dịch
 *
 * @param string $purchase_id ID giao dịch
 * @param float $amount Số tiền
 * @return bool
 */
function nv_sharecode_update_purchase_commission($purchase_id, $amount)
{
    global $db, $module_data;

    $commission = nv_sharecode_calculate_commission($amount);

    $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_purchases
            SET author_commission = " . $commission . "
            WHERE id = " . $db->quote($purchase_id);

    return $db->exec($sql) !== false;
}

/**
 * nv_sharecode_get_categories()
 * Lấy danh sách categories
 *
 * @param int $parent_id
 * @return array
 */
function nv_sharecode_get_categories($parent_id = 0)
{
    global $db, $module_data, $lang;
    
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories 
            WHERE status=1 AND parentid=" . intval($parent_id) . " 
            ORDER BY weight ASC";
    $result = $db->query($sql);
    
    $categories = [];
    while ($row = $result->fetch()) {
        $categories[$row['id']] = $row;
    }
    
    return $categories;
}

/**
 * nv_sharecode_get_category_info()
 * Lấy thông tin category
 *
 * @param mixed $id_or_alias
 * @return array|false
 */
function nv_sharecode_get_category_info($id_or_alias)
{
    global $db, $module_data, $lang;
    
    if (is_numeric($id_or_alias)) {
        $where = "id=" . intval($id_or_alias);
    } else {
        $where = "alias=" . $db->quote($id_or_alias);
    }
    
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories 
            WHERE " . $where . " AND status=1";
    $result = $db->query($sql);
    
    return $result->fetch();
}

/**
 * nv_sharecode_get_source_info()
 * Lấy thông tin source
 *
 * @param mixed $id_or_alias
 * @return array|false
 */
function nv_sharecode_get_source_info($id_or_alias)
{
    global $db, $module_data, $lang;
    
    if (is_numeric($id_or_alias)) {
        $where = "id=" . intval($id_or_alias);
    } else {
        $where = "alias=" . $db->quote($id_or_alias);
    }
    
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources 
            WHERE " . $where . " AND status=1";
    $result = $db->query($sql);
    
    return $result->fetch();
}

/**
 * nv_sharecode_update_view()
 * Cập nhật lượt xem
 *
 * @param int $source_id
 * @return bool
 */
function nv_sharecode_update_view($source_id)
{
    global $db, $module_data, $lang;
    
    $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources 
            SET num_view = num_view + 1 
            WHERE id=" . intval($source_id);
    
    return $db->exec($sql);
}

/**
 * nv_sharecode_update_download()
 * Cập nhật lượt download
 *
 * @param int $source_id
 * @return bool
 */
function nv_sharecode_update_download($source_id)
{
    global $db, $module_data, $lang;
    
    $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources 
            SET num_download = num_download + 1 
            WHERE id=" . intval($source_id);
    
    return $db->exec($sql);
}

/**
 * nv_sharecode_log_download()
 * Ghi log download
 *
 * @param int $source_id
 * @param int $user_id
 * @return bool
 */
function nv_sharecode_log_download($source_id, $user_id = 0)
{
    global $db, $module_data, $lang, $client_info;
    
    $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_download_logs 
            (source_id, user_id, ip_address, download_time, user_agent) VALUES (
                " . intval($source_id) . ",
                " . intval($user_id) . ",
                " . $db->quote($client_info['ip']) . ",
                " . NV_CURRENTTIME . ",
                " . $db->quote($client_info['agent']) . "
            )";
    
    return $db->exec($sql);
}

/**
 * nv_sharecode_get_tags()
 * Lấy danh sách tags của source
 *
 * @param int $source_id
 * @return array
 */
function nv_sharecode_get_tags($source_id)
{
    global $db, $module_data, $lang;
    
    $sql = "SELECT t.* FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags t
            INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st ON t.id = st.tag_id
            WHERE st.source_id=" . intval($source_id);
    $result = $db->query($sql);
    
    $tags = [];
    while ($row = $result->fetch()) {
        $tags[] = $row;
    }
    
    return $tags;
}

/**
 * nv_sharecode_check_permission()
 * Kiểm tra quyền download
 *
 * @param array $source
 * @param int $user_id
 * @return bool
 */
function nv_sharecode_check_permission($source, $user_id = 0)
{
    global $module_name;

    // Kiểm tra nếu là tác giả hoặc admin thì cho phép download miễn phí
    if ($user_id > 0) {
        $is_author = ($user_id == $source['userid']);
        $is_admin = defined('NV_IS_ADMIN');

        if ($is_author || $is_admin) {
            return true;
        }
    }

    // Nếu là free thì cho phép download
    if ($source['fee_type'] == 'free') {
        return true;
    }

    // Nếu là paid thì cần kiểm tra wallet
    if ($source['fee_type'] == 'paid' && $user_id > 0) {
        // Kiểm tra với module wallet qua API
        return nv_sharecode_wallet_check_balance($user_id, $source['fee_amount']);
    }

    return false;
}

/**
 * nv_sharecode_process_payment()
 * Xử lý thanh toán
 *
 * @param array $source
 * @param int $user_id
 * @return bool
 */
function nv_sharecode_process_payment($source, $user_id)
{
    global $module_name;

    if ($source['fee_type'] == 'paid' && $user_id > 0) {
        // Xử lý thanh toán qua module wallet API
        $description = 'Tải xuống: ' . $source['title'];
        return nv_sharecode_wallet_deduct_balance($user_id, $source['fee_amount'], $description, $module_name, $source['id']);
    }

    return true;
}

/**
 * nv_sharecode_wallet_check_balance()
 * Kiểm tra số dư wallet qua API
 *
 * @param int $user_id
 * @param float $amount
 * @param string $currency
 * @return bool
 */
function nv_sharecode_wallet_check_balance($user_id, $amount, $currency = 'VND')
{
    try {
        // Gọi API kiểm tra số dư bằng nv_local_api
        $params = [
            'userid' => $user_id,
            'amount' => $amount,
            'currency' => $currency
        ];

        // $response = nv_local_api('WalletCheckBalance', $params, '', 'wallet');
        $api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
        $api->setModule('wallet')
            ->setLang(NV_LANG_DATA)
            ->setAction('CheckBalance')
            ->setData($params);
        $response = $api->execute();

        if ($response && isset($response['status']) && $response['status'] == 'success') {
            return $response['data']['has_enough'];
        }

        return false;
    } catch (Exception $e) {
        return false;
    }
}

/**
 * nv_sharecode_wallet_deduct_balance()
 * Trừ tiền wallet qua API
 *
 * @param int $user_id
 * @param float $amount
 * @param string $description
 * @param string $module_ref
 * @param int $ref_id
 * @param string $currency
 * @return bool
 */
function nv_sharecode_wallet_deduct_balance($user_id, $amount, $description, $module_ref, $ref_id, $currency = 'VND')
{
    try {
        // Gọi API trừ tiền bằng nv_local_api
        $params = [
            'userid' => $user_id,
            'amount' => $amount,
            'currency' => $currency,
            'description' => $description,
            'module_ref' => $module_ref,
            'ref_id' => $ref_id
        ];

        // $response = nv_local_api('WalletDeductBalance', $params, '', 'wallet');
        $api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
        $api->setModule('wallet')
            ->setLang(NV_LANG_DATA)
            ->setAction('DeductBalance')
            ->setData($params);
        $response = $api->execute();
        if ($response && isset($response['status']) && $response['status'] == 'success') {
            return true;
        }

        return false;
    } catch (Exception $e) {
        pr($e->getMessage());
        return false;
    }
}

/**
 * nv_sharecode_wallet_get_balance()
 * Lấy số dư wallet qua API
 *
 * @param int $user_id
 * @param string $currency
 * @return float
 */
function nv_sharecode_wallet_get_balance($user_id, $currency = 'VND')
{
    try {
        // Gọi API lấy số dư bằng nv_local_api
        $params = [
            'userid' => $user_id,
            'currency' => $currency
        ];

        // $response = nv_local_api('WalletGetBalance', $params, '', 'wallet');
        $api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
        $api->setModule('wallet')
            ->setLang(NV_LANG_DATA)
            ->setAction('GetUserBalance')
            ->setData($params);
        $response = $api->execute();
        if ($response && isset($response['status']) && $response['status'] == 'success') {
            return floatval($response['data']['balance']);
        }

        return 0;
    } catch (Exception $e) {
        return 0;
    }
}



/**
 * nv_sharecode_send_email_notification()
 * Gửi email thông báo
 *
 * @param string $to_email
 * @param string $to_name
 * @param string $subject
 * @param string $message
 * @return bool
 */
function nv_sharecode_send_email_notification($to_email, $to_name, $subject, $message)
{
    global $global_config, $lang_global;
    
    if (empty($to_email) || empty($subject) || empty($message)) {
        return false;
    }
    
    try {
        // Chuẩn bị email
        $from = [$global_config['site_email'], $global_config['site_name']];
        $to = [$to_email, $to_name];
        
        // Template email cơ bản
        $email_template = '
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
            <div style="background: #f8f9fa; padding: 20px; text-align: center;">
                <h2 style="color: #333; margin: 0;">' . $global_config['site_name'] . '</h2>
                <p style="margin: 5px 0 0 0; color: #666;">ShareCode - Chia sẻ mã nguồn</p>
            </div>
            <div style="padding: 30px 20px;">
                <h3 style="color: #333; margin-top: 0;">' . $subject . '</h3>
                <div style="color: #555; line-height: 1.6;">
                    ' . $message . '
                </div>
            </div>
            <div style="background: #f8f9fa; padding: 15px 20px; text-align: center; font-size: 12px; color: #666;">
                <p>Đây là email tự động, vui lòng không trả lời email này.</p>
                <p>© ' . date('Y') . ' ' . $global_config['site_name'] . '. All rights reserved.</p>
            </div>
        </div>';
        
        return nv_sendmail($from, $to, $subject, $email_template);
    } catch (Exception $e) {
        return false;
    }
}

/**
 * nv_sharecode_send_purchase_success_email()
 * Gửi email thông báo thanh toán thành công
 *
 * @param array $user_info
 * @param array $source
 * @param string $purchase_id
 * @param float $amount
 * @param string $transaction_id
 * @return bool
 */
function nv_sharecode_send_purchase_success_email($user_info, $source, $purchase_id, $amount, $transaction_id)
{
    global $global_config, $module_name;

    try {
        // Tiêu đề email
        $subject = '[' . $global_config['site_name'] . '] Thanh toán thành công';

        // Nội dung email
        $message = 'Xin chào ' . $user_info['full_name'] . ',<br><br>';
        $message .= 'Cảm ơn bạn đã thanh toán thành công cho sản phẩm:<br><br>';
        $message .= '<strong>Thông tin đơn hàng:</strong><br>';
        $message .= 'Tên sản phẩm: ' . $source['title'] . '<br>';
        $message .= 'Mô tả: ' . $source['description'] . '<br>';
        $message .= 'Số tiền: ' . number_format($amount, 0, ',', '.') . ' VNĐ<br>';
        $message .= 'Mã giao dịch: ' . $transaction_id . '<br>';
        $message .= 'Mã đơn hàng: ' . $purchase_id . '<br>';
        $message .= 'Thời gian: ' . date('d/m/Y H:i', NV_CURRENTTIME) . '<br><br>';

        $message .= '<strong>Thông tin tải xuống:</strong><br>';
        $message .= 'Bạn có thể tải xuống sản phẩm tại: <a href="' . NV_MY_DOMAIN . NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=download&id=' . $source['id'] . '">Tải xuống ngay</a><br>';
        $message .= 'Hoặc xem lịch sử mua hàng tại: <a href="' . NV_MY_DOMAIN . NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history&user">Lịch sử mua hàng</a><br><br>';

        $message .= 'Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!<br><br>';
        $message .= 'Trân trọng,<br>' . $global_config['site_name'];

        // Gửi email
        $from = [$global_config['site_email'], $global_config['site_name']];
        $to = $user_info['email'];

        return nv_sendmail($from, $to, $subject, $message);

    } catch (Exception $e) {
        return false;
    }
}



/**
 * nv_sharecode_create_upload_dirs()
 * Tạo các thư mục upload cần thiết
 *
 * @param string $module_upload
 * @return bool
 */
function nv_sharecode_create_upload_dirs($module_upload)
{
    global $db;

    $upload_dirs = [
        $module_upload,
        $module_upload . '/images',
        $module_upload . '/sources',
        $module_upload . '/thumbnails'
    ];

    foreach ($upload_dirs as $dir) {
        $full_path = NV_UPLOADS_REAL_DIR . '/' . $dir;
        if (!is_dir($full_path)) {
            $parts = explode('/', $dir);
            $current_path = '';

            foreach ($parts as $part) {
                if (!empty($part)) {
                    $current_path .= $part;
                    $check_path = NV_UPLOADS_REAL_DIR . '/' . $current_path;

                    if (!is_dir($check_path)) {
                        $parent_path = dirname($check_path);
                        $dir_name = basename($check_path);

                        $mk = nv_mkdir($parent_path, $dir_name);
                        if ($mk[0] > 0) {
                            try {
                                $db->query('INSERT INTO ' . NV_UPLOAD_GLOBALTABLE . "_dir (dirname, time) VALUES ('" . NV_UPLOADS_DIR . '/' . $current_path . "', 0)");
                            } catch (PDOException $e) {
                                // Ignore duplicate entries
                            }
                        }
                    }
                    $current_path .= '/';
                }
            }
        }
    }

    return true;
}

/**
 * nv_sharecode_is_favorite()
 * Kiểm tra xem source có được yêu thích bởi user không
 *
 * @param int $source_id
 * @param int $user_id
 * @return bool
 */
function nv_sharecode_is_favorite($source_id, $user_id)
{
    global $db, $module_data;

    if ($user_id <= 0 || $source_id <= 0) {
        return false;
    }

    try {
        $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites
                WHERE userid = " . intval($user_id) . " AND source_id = " . intval($source_id);

        return $db->query($sql)->fetchColumn() > 0;
    } catch (PDOException $e) {
        // Log lỗi để debug
        error_log("nv_sharecode_is_favorite error: " . $e->getMessage());
        error_log("SQL: " . $sql);
        return false;
    }
}

/**
 * nv_sharecode_add_favorite()
 * Thêm source vào danh sách yêu thích
 *
 * @param int $source_id
 * @param int $user_id
 * @return bool
 */
function nv_sharecode_add_favorite($source_id, $user_id)
{
    global $db, $module_data;

    if ($user_id <= 0 || $source_id <= 0) {
        return false;
    }

    if (nv_sharecode_is_favorite($source_id, $user_id)) {
        return true; 
    }

    try {
        // Kiểm tra xem bảng có trường add_time không
        $has_add_time = false;
        try {
            $check_sql = "SHOW COLUMNS FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites LIKE 'add_time'";
            $result = $db->query($check_sql);
            $has_add_time = $result->rowCount() > 0;
        } catch (Exception $e) {
            $has_add_time = false;
        }

        if ($has_add_time) {
            $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_favorites (userid, source_id, add_time)
                    VALUES (" . intval($user_id) . ", " . intval($source_id) . ", " . time() . ")";
        } else {
            $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_favorites (userid, source_id)
                    VALUES (" . intval($user_id) . ", " . intval($source_id) . ")";
        }

        return $db->exec($sql) > 0;
    } catch (PDOException $e) {
        pr($e->getMessage());
        return false;
    }
}

/**
 * nv_sharecode_remove_favorite()
 * Xóa source khỏi danh sách yêu thích
 *
 * @param int $source_id
 * @param int $user_id
 * @return bool
 */
function nv_sharecode_remove_favorite($source_id, $user_id)
{
    global $db, $module_data;

    if ($user_id <= 0 || $source_id <= 0) {
        return false;
    }

    try {
        $sql = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites
                WHERE userid = " . intval($user_id) . " AND source_id = " . intval($source_id);

        return $db->exec($sql) > 0;
    } catch (PDOException $e) {
        return false;
    }
}

/**
 * nv_sharecode_get_user_favorites()
 * Lấy danh sách yêu thích của user
 *
 * @param int $user_id
 * @param int $page
 * @param int $per_page
 * @return array
 */
function nv_sharecode_get_user_favorites($user_id, $page = 1, $per_page = 20)
{
    global $db, $module_data;

    if ($user_id <= 0) {
        return ['items' => [], 'total' => 0];
    }

    // Đếm tổng số
    $sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites f
                  INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON f.source_id = s.id
                  WHERE f.userid = " . intval($user_id) . " AND s.status = 1";

    $total = $db->query($sql_count)->fetchColumn();

    if ($total == 0) {
        return ['items' => [], 'total' => 0];
    }

    // Lấy dữ liệu
    $offset = ($page - 1) * $per_page;

    // Kiểm tra xem bảng có trường add_time không
    $has_add_time = false;
    try {
        $check_sql = "SHOW COLUMNS FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites LIKE 'add_time'";
        $result = $db->query($check_sql);
        $has_add_time = $result->rowCount() > 0;
    } catch (Exception $e) {
        $has_add_time = false;
    }

    if ($has_add_time) {
        $sql = "SELECT s.*, f.id as favorite_id, f.add_time, c.title as category_title, c.alias as category_alias
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites f
                INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON f.source_id = s.id
                LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
                WHERE f.userid = " . intval($user_id) . " AND s.status = 1
                ORDER BY f.id DESC
                LIMIT " . intval($per_page) . " OFFSET " . intval($offset);
    } else {
        $sql = "SELECT s.*, f.id as favorite_id, c.title as category_title, c.alias as category_alias
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites f
                INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON f.source_id = s.id
                LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
                WHERE f.userid = " . intval($user_id) . " AND s.status = 1
                ORDER BY f.id DESC
                LIMIT " . intval($per_page) . " OFFSET " . intval($offset);
    }

    $result = $db->query($sql);
    $items = [];

    while ($row = $result->fetch()) {
        $items[] = $row;
    }

    return ['items' => $items, 'total' => $total];
}

/**
 * nv_sharecode_get_favorites_count()
 * Lấy số lượng yêu thích của user
 *
 * @param int $user_id
 * @return int
 */
function nv_sharecode_get_favorites_count($user_id)
{
    global $db, $module_data;

    if ($user_id <= 0) {
        return 0;
    }

    $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites f
            INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON f.source_id = s.id
            WHERE f.userid = " . intval($user_id) . " AND s.status = 1";

    return intval($db->query($sql)->fetchColumn());
}

/**
 * nv_sharecode_log_action()
 * Ghi log hành động của user
 *
 * @param int $user_id
 * @param int $source_id
 * @param string $action
 * @param string $details
 * @return bool
 */
function nv_sharecode_log_action($user_id, $source_id, $action, $details = '')
{
    global $db, $module_data, $client_info;

    try {
        $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_logs
                (userid, source_id, action, ip, user_agent, log_time, details)
                VALUES (
                    " . intval($user_id) . ",
                    " . intval($source_id) . ",
                    " . $db->quote($action) . ",
                    " . $db->quote($client_info['ip']) . ",
                    " . $db->quote($client_info['agent']) . ",
                    " . NV_CURRENTTIME . ",
                    " . $db->quote($details) . "
                )";

        return $db->exec($sql) > 0;
    } catch (PDOException $e) {
        return false;
    }
}
