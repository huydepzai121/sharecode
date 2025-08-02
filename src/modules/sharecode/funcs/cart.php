<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

use NukeViet\Api\DoApi;

// Breadcrumb
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=cart';
$array_mod_title[] = [
    'title' => 'Giỏ hàng',
    'link' => nv_url_rewrite($base_url, true)
];

// SEO
$page_title = 'Giỏ hàng của bạn';
$key_words = 'giỏ hàng, mua sắm, thanh toán';
$description = 'Giỏ hàng mã nguồn - Thanh toán và tải về';

// Get cart items from localStorage via AJAX or session
$action = $nv_Request->get_title('action', 'post', '');
$cart_items = [];
$total_amount = 0;

if ($action == 'get_cart') {
    // AJAX request to get cart data
    $item_ids = $nv_Request->get_array_int('items', 'post', []);
    
    if (!empty($item_ids)) {
        $ids_str = implode(',', $item_ids);
        $sql = "SELECT s.*, c.title as category_title 
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
                LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
                WHERE s.id IN ($ids_str) AND s.status = 1 AND s.fee_type = 'paid'";
        
        $result = $db->query($sql);
        while ($row = $result->fetch()) {
            // Format data
            $row['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['alias'];
            $row['price_text'] = number_format($row['fee_amount']) . ' VNĐ';
            
            // Image
            if (!empty($row['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $row['image'])) {
                $row['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $row['image'];
            } else {
                $row['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no-image.png';
            }
            
            $cart_items[] = $row;
            $total_amount += $row['fee_amount'];
        }
    }
    
    // Return JSON for AJAX
    if ($nv_Request->isset_request('ajax', 'post')) {
        nv_jsonOutput([
            'status' => 'success',
            'items' => $cart_items,
            'total' => $total_amount,
            'total_text' => number_format($total_amount) . ' VNĐ',
            'count' => count($cart_items)
        ]);
    }
}

// Handle bulk purchase
if ($action == 'purchase_all' && defined('NV_IS_USER')) {
    if (!$nv_Request->isset_request('ajax', 'post')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Truy cập không hợp lệ']);
    }
    
    $item_ids = $nv_Request->get_array_int('items', 'post', []);
    
    if (empty($item_ids)) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Giỏ hàng trống']);
    }
    
    try {
        $db->query('BEGIN');
        
        // Get cart items and calculate total
        $ids_str = implode(',', $item_ids);
        $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources 
                WHERE id IN ($ids_str) AND status = 1 AND fee_type = 'paid'";
        $result = $db->query($sql);
        
        $sources = [];
        $total_amount = 0;
        
        while ($row = $result->fetch()) {
            // Check if already purchased
            $check_sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
                         WHERE userid = " . $user_info['userid'] . " AND source_id = " . $row['id'] . " AND status = 'completed'";
            if ($db->query($check_sql)->fetchColumn()) {
                throw new Exception('Bạn đã mua sản phẩm "' . $row['title'] . '" rồi');
            }
            
            $sources[] = $row;
            $total_amount += $row['fee_amount'];
        }
        
        if (empty($sources)) {
            throw new Exception('Không có sản phẩm hợp lệ trong giỏ hàng');
        }
        
        // Kiểm tra số dư trước khi thanh toán
        $api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
        $api->setModule('wallet')
            ->setLang(NV_LANG_DATA)
            ->setAction('GetUserBalance')
            ->setData([
                'userid' => $user_info['userid'],
                'currency' => 'VND'
            ]);
        $balance_result = $api->execute();
        
        if ($balance_result['status'] != 'success' || $balance_result['data']['balance'] < $total_amount) {
            throw new Exception('Số dư không đủ để thanh toán giỏ hàng này. Cần: ' . number_format($total_amount, 0, '.', ',') . ' VNĐ');
        }
        
        // Sử dụng DoApi để trừ tiền từ ví
        $api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
        $api->setModule('wallet')
            ->setLang(NV_LANG_DATA)
            ->setAction('DeductBalance')
            ->setData([
                'userid' => $user_info['userid'],
                'amount' => $total_amount,
                'currency' => 'VND',
                'description' => 'Mua ' . count($sources) . ' mã nguồn từ giỏ hàng',
                'reference_type' => 'sharecode_bulk_purchase',
                'reference_id' => implode(',', $item_ids)
            ]);
        $wallet_result = $api->execute();
        
        if ($wallet_result['status'] != 'success') {
            throw new Exception('Lỗi trừ tiền từ ví: ' . $wallet_result['message']);
        }
        
        // Create purchase records for each item
        $purchase_ids = [];
        foreach ($sources as $source) {
            $purchase_id = md5($user_info['userid'] . $source['id'] . NV_CURRENTTIME . rand());
            
            $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_purchases (
                id, userid, source_id, amount, currency, payment_method,
                transaction_id, status, purchase_time, payment_time, notes
            ) VALUES (
                " . $db->quote($purchase_id) . ",
                " . $user_info['userid'] . ",
                " . $source['id'] . ",
                " . $source['fee_amount'] . ",
                'VND',
                'wallet',
                " . $db->quote($wallet_result['transaction']['transaction_id']) . ",
                'completed',
                " . NV_CURRENTTIME . ",
                " . NV_CURRENTTIME . ",
                " . $db->quote('Thanh toán qua ví điện tử - Mua từ giỏ hàng') . "
            )";
            
            if (!$db->query($sql)) {
                throw new Exception('Lỗi lưu thông tin đơn hàng');
            }
            
            $purchase_ids[] = $purchase_id;
            
            // Update download count
            $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources 
                    SET num_download = num_download + 1, last_download = " . NV_CURRENTTIME . "
                    WHERE id = " . $source['id'];
            $db->query($sql);
        }
        
        // Log bulk purchase
        $log_data = [
            'userid' => $user_info['userid'],
            'source_id' => 0, // Bulk purchase
            'action' => 'bulk_purchase',
            'ip' => NV_CLIENT_IP,
            'user_agent' => $global_config['user_agent'],
            'log_time' => NV_CURRENTTIME,
            'details' => json_encode([
                'total_amount' => $total_amount,
                'item_count' => count($sources),
                'item_ids' => $item_ids,
                'purchase_ids' => $purchase_ids,
                'transaction_id' => $wallet_result['transaction']['transaction_id'],
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
        
        $db->query('COMMIT');
        
        nv_jsonOutput([
            'status' => 'success',
            'message' => 'Thanh toán thành công ' . count($sources) . ' sản phẩm',
            'data' => [
                'purchase_count' => count($sources),
                'total_amount' => number_format($total_amount) . ' VNĐ',
                'dashboard_url' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=dashboard'
            ]
        ]);
        
    } catch (Exception $e) {
        $db->query('ROLLBACK');
        nv_jsonOutput([
            'status' => 'error',
            'message' => $e->getMessage()
        ]);
    }
}

// Render cart page
$contents = nv_theme_sharecode_cart($cart_items, $total_amount);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';