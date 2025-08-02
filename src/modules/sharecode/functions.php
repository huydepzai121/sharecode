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
            'title' => 'Sản phẩm yêu thích',
            'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=favorites',
            'icon' => 'fa fa-heart'
        ];
        
        $unread_count = nv_sharecode_get_unread_notifications_count($user_info['userid']);
        $notification_badge = $unread_count > 0 ? ' <span class="badge badge-danger">' . $unread_count . '</span>' : '';
        
        $menu[] = [
            'title' => 'Thông báo' . $notification_badge,
            'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=notifications',
            'icon' => 'fa fa-bell'
        ];
    }
    
    return $menu;
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

        $response = nv_local_api('WalletCheckBalance', $params, '', 'wallet');

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

        $response = nv_local_api('WalletDeductBalance', $params, '', 'wallet');

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

        $response = nv_local_api('WalletGetBalance', $params, '', 'wallet');

        if ($response && isset($response['status']) && $response['status'] == 'success') {
            return floatval($response['data']['balance']);
        }

        return 0;
    } catch (Exception $e) {
        return 0;
    }
}

/**
 * nv_sharecode_is_favorite()
 * Kiểm tra xem sản phẩm có trong danh sách yêu thích không
 *
 * @param int $source_id
 * @param int $user_id
 * @return bool
 */
function nv_sharecode_is_favorite($source_id, $user_id = 0)
{
    global $db, $module_data;
    
    if ($user_id <= 0 || $source_id <= 0) {
        return false;
    }
    
    $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites WHERE userid=" . $user_id . " AND source_id=" . $source_id;
    return $db->query($sql)->fetchColumn() ? true : false;
}

/**
 * nv_sharecode_get_user_favorites_count()
 * Lấy số lượng sản phẩm yêu thích của user
 *
 * @param int $user_id
 * @return int
 */
function nv_sharecode_get_user_favorites_count($user_id)
{
    global $db, $module_data;
    
    if ($user_id <= 0) {
        return 0;
    }
    
    $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_favorites f 
            INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON f.source_id = s.id 
            WHERE f.userid=" . $user_id . " AND s.status=1";
    return $db->query($sql)->fetchColumn();
}

/**
 * nv_sharecode_add_notification()
 * Thêm thông báo mới
 *
 * @param int $userid
 * @param string $type
 * @param string $title  
 * @param string $content
 * @param int $source_id
 * @param string $url
 * @return bool
 */
function nv_sharecode_add_notification($userid, $type, $title, $content = '', $source_id = 0, $url = '')
{
    global $db, $module_data;
    
    if ($userid <= 0 || empty($type) || empty($title)) {
        return false;
    }
    
    try {
        $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_notifications 
                      (userid, type, title, content, source_id, url, add_time) VALUES (
                      " . $userid . ",
                      " . $db->quote($type) . ",
                      " . $db->quote($title) . ",
                      " . $db->quote($content) . ",
                      " . $source_id . ",
                      " . $db->quote($url) . ",
                      " . NV_CURRENTTIME . "
                      )";
        return $db->exec($sql_insert) ? true : false;
    } catch (Exception $e) {
        return false;
    }
}

/**
 * nv_sharecode_get_unread_notifications_count()
 * Lấy số lượng thông báo chưa đọc
 *
 * @param int $user_id
 * @return int
 */
function nv_sharecode_get_unread_notifications_count($user_id)
{
    global $db, $module_data;
    
    if ($user_id <= 0) {
        return 0;
    }
    
    $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_notifications 
            WHERE userid=" . $user_id . " AND is_read=0";
    return $db->query($sql)->fetchColumn();
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


