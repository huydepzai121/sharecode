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

// Lấy alias từ URL path theo cấu trúc NukeViet 
$alias = '';
$id = 0;

// Lấy alias từ array_op NukeViet URL rewriting
if (isset($array_op[1])) {
    $alias = $array_op[1];
} else {
    // Fallback: lấy từ GET parameter (backward compatibility)
    $alias = $nv_Request->get_title('alias', 'get', '');
    $id = $nv_Request->get_int('id', 'get', 0);
}

if (empty($alias) && $id == 0) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Lấy thông tin source với thông tin author
$source = [];
if (!empty($alias)) {
    $sql = "SELECT s.*, u.username as user_username, u.email, u.first_name, u.last_name, u.photo
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
            LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON s.userid = u.userid
            WHERE s.alias=" . $db->quote($alias) . " AND s.status=1";
    $source = $db->query($sql)->fetch();
} elseif ($id > 0) {
    // Tìm theo ID
    $sql = "SELECT s.*, u.username as user_username, u.email, u.first_name, u.last_name, u.photo
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
            LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON s.userid = u.userid
            WHERE s.id=" . $id . " AND s.status=1";
    $source = $db->query($sql)->fetch();
}

// Nếu không tìm thấy source thì redirect về trang chủ
if (empty($source)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Cập nhật lượt xem
$sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources SET num_view = num_view + 1 WHERE id=" . $source['id'];
$db->query($sql_update);

// Breadcrumb với cấu trúc URL chuẩn NukeViet
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $source['alias'];
$array_mod_title[] = [
    'title' => $source['title'],
    'link' => nv_url_rewrite($base_url, true)
];

// SEO
$page_title = $source['title'];
$key_words = $source['title'] . ', ' . $source['keywords'];
$description = !empty($source['description']) ? nv_clean60($source['description'], 160) : $source['title'];

// Lấy thông tin category
$category = [];
$sql_cat = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $source['catid'];
$category = $db->query($sql_cat)->fetch();
if (empty($category)) {
    $category = ['title' => 'Chưa phân loại', 'alias' => ''];
}

// Lấy tags
$tags = [];
$sql_tags = "SELECT t.* FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags t
             INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st ON t.id = st.tag_id
             WHERE st.source_id = " . $source['id'];
$result_tags = $db->query($sql_tags);
while ($row = $result_tags->fetch()) {
    $tag_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=tag/' . $row['alias'];
    $row['link'] = nv_url_rewrite($tag_url, true);
    $tags[] = $row;
}

// Xử lý hình ảnh
if (!empty($source['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $source['image'])) {
    $source['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $source['image'];
} elseif (!empty($source['avatar']) && file_exists(NV_ROOTDIR . $source['avatar'])) {
    $source['image_url'] = NV_BASE_SITEURL . ltrim($source['avatar'], '/');
} else {
    $source['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
}

// Format dữ liệu
$source['add_time_format'] = date('d/m/Y H:i', $source['add_time']);

// Enhanced price formatting with support for contact type
switch ($source['fee_type']) {
    case 'free':
        $source['price_text'] = 'Miễn phí';
        $source['price_class'] = 'free';
        $source['price_icon'] = 'fa fa-gift';
        break;
    case 'contact':
        $source['price_text'] = 'Có phí, liên hệ để biết giá';
        $source['price_class'] = 'contact';
        $source['price_icon'] = 'fa fa-phone';
        break;
    default:
        $source['price_text'] = number_format($source['fee_amount']) . ' VNĐ';
        $source['price_class'] = 'paid';
        $source['price_icon'] = 'fa fa-money';
}

// Tạo links với nv_url_rewrite - sử dụng cấu trúc URL chuẩn NukeViet
$category_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=category/' . $category['alias'];
$source['category_link'] = nv_url_rewrite($category_url, true);

// Link download
if (function_exists('nv_sharecode_download_url')) {
    $source['download_url'] = nv_sharecode_download_url($source['id']);
} else {
    $download_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=download&id=' . $source['id'];
    $source['download_url'] = nv_url_rewrite($download_url, true);
}

// Kiểm tra quyền download và chuẩn bị data cho modal
$can_download = false;
$already_purchased = false;
$need_login = false;
$need_contact = false;
$user_balance_data = null;
$balance_after = 0;
$balance_after_class = 'text-success';
$can_pay = false;
$need_topup = false;

if (!defined('NV_IS_USER')) {
    $need_login = true;
} else {
    // Kiểm tra đã mua chưa
    $sql_purchase = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases 
                    WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source['id'] . " AND status='completed'";
    $purchased = $db->query($sql_purchase)->fetchColumn();
    
    if ($purchased) {
        // Đã mua rồi - cho phép download trực tiếp
        $already_purchased = true;
    } else {
        // Kiểm tra loại phí để xử lý phù hợp
        if ($source['fee_type'] == 'contact') {
            // Loại "liên hệ để biết giá" - không cho phép mua trực tiếp
            $need_contact = true;
        } else {
            // Chưa mua - hiển thị modal cho cả miễn phí và có phí
            $can_download = true;
            
            // Lấy thông tin số dư wallet qua nv_local_api
            // $balance_result = nv_local_api('WalletGetBalance', [
            //     'userid' => $user_info['userid'],
            //     'currency' => 'VND'
            // ], '', 'wallet');
            $api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
            $api->setModule('wallet')
                ->setLang(NV_LANG_DATA)
                ->setAction('GetUserBalance')
                ->setData([
                    'userid' => $user_info['userid'],
                    'currency' => 'VND'
                ]);
            $balance_result = $api->execute();

            if (!is_array($balance_result)) {
                if (is_string($balance_result)) {
                    $balance_result = json_decode($balance_result, true);
                }
                if (!is_array($balance_result)) {
                    $balance_result = ['status' => 'error', 'message' => 'Invalid API response'];
                }
            }

            if (isset($balance_result['status']) && $balance_result['status'] == 'success' && isset($balance_result['data']) && is_array($balance_result['data'])) {
                $user_balance_data = $balance_result['data'];
                $current_balance = isset($user_balance_data['balance']) ? floatval($user_balance_data['balance']) : 0;
                $required_amount = ($source['fee_type'] == 'free') ? 0 : floatval($source['fee_amount']);
                
                $balance_after = $current_balance - $required_amount;
                $balance_after_class = ($balance_after >= 0) ? 'text-success' : 'text-danger';
                
                if ($balance_after >= 0) {
                    $can_pay = true;
                } else {
                    $need_topup = true;
                }
            } else {
                // Không thể lấy thông tin wallet - vẫn cho phép thử
                $can_pay = true;
            }
        }
    }
}

if ($nv_Request->isset_request('get_download_token', 'post')) {
    // Xử lý tạo download token cho file đã mua
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập']);
    }

    $source_id = $nv_Request->get_int('source_id', 'post', 0);

    if ($source_id <= 0) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Source ID không hợp lệ']);
    }

    // Lấy thông tin source từ database
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id;
    $source_info = $db->query($sql)->fetch();

    if (!$source_info) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Mã nguồn không tồn tại']);
    }
    
    // Kiểm tra đã mua chưa
    $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
            WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id . " AND status='completed'";
    $purchased = $db->query($sql_check)->fetchColumn();
    
    if (!$purchased) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Bạn chưa mua mã nguồn này']);
    }
    
    // Kiểm tra link tải xuống
    if (empty($source_info['download_link'])) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Link tải xuống không hợp lệ hoặc chưa được cấu hình']);
    }

    $download_url = $source_info['download_link'];
    
    // Cập nhật thống kê download
    $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources
            SET num_download = num_download + 1
            WHERE id = " . $source_id;
    $db->query($sql_update);
    
    // Ghi log download
    $log_data = json_encode([
        'download_type' => 'external_link',
        'download_url' => $source_info['download_link'],
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

// Xử lý submit review
if ($nv_Request->isset_request('submit_review', 'post')) {
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập để đánh giá']);
    }
    
    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    $rating = $nv_Request->get_int('rating', 'post', 0);
    $comment = $nv_Request->get_textarea('comment', 'post', '');
    
    if ($source_id <= 0 || $source_id != $source['id']) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Source ID không hợp lệ']);
    }
    
    if ($rating < 1 || $rating > 5) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Đánh giá phải từ 1 đến 5 sao']);
    }
    
    if (empty($comment)) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng nhập nhận xét']);
    }
    
    // Kiểm tra đã đánh giá chưa
    $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews 
                  WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id;
    $existing_review = $db->query($sql_check)->fetchColumn();
    
    if ($existing_review) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Bạn đã đánh giá sản phẩm này rồi']);
    }
    
    // Lấy cấu hình module để check auto-approval và email notification
    $sql_config = "SELECT config_name, config_value FROM " . NV_CONFIG_GLOBALTABLE . " WHERE lang='" . NV_LANG_DATA . "' AND module='" . $module_name . "'";
    $result_config = $db->query($sql_config);
    $module_config = [];
    while ($row_config = $result_config->fetch()) {
        $module_config[$row_config['config_name']] = $row_config['config_value'];
    }
    
    // Xác định trạng thái review dựa trên cấu hình auto-approval
    $review_status = !empty($module_config['auto_approve_reviews']) ? 1 : 0;
    
    try {
        $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_reviews (
            source_id, userid, username, rating, content, add_time, status
        ) VALUES (
            " . $source_id . ",
            " . $user_info['userid'] . ",
            " . $db->quote($user_info['username']) . ",
            " . $rating . ",
            " . $db->quote($comment) . ",
            " . NV_CURRENTTIME . ",
            " . $review_status . "
        )";
        
        if ($db->exec($sql_insert)) {
            // Gửi email thông báo nếu được cấu hình
            if (!empty($module_config['email_notify_new_review'])) {
                // Lấy email admin
                $sql_admin = "SELECT u.email, u.first_name, u.last_name
                              FROM " . NV_AUTHORS_GLOBALTABLE . " a
                              JOIN " . NV_USERS_GLOBALTABLE . " u ON a.admin_id = u.userid
                              WHERE a.lev = 1 AND a.is_suspend = 0 AND u.active = 1
                              LIMIT 1";
                $admin_info = $db->query($sql_admin)->fetch();
                
                if ($admin_info) {
                    $admin_name = trim($admin_info['first_name'] . ' ' . $admin_info['last_name']);
                    if (empty($admin_name)) {
                        $admin_name = 'Admin';
                    }
                    
                    $subject = '[' . $global_config['site_name'] . '] Đánh giá mới cho mã nguồn';
                    $message = "Xin chào {$admin_name},\n\n";
                    $message .= "Có đánh giá mới cho mã nguồn '{$source['title']}'\n\n";
                    $message .= "Người đánh giá: {$user_info['username']}\n";
                    $message .= "Điểm số: {$rating}/5 sao\n";
                    $message .= "Nội dung: {$comment}\n";
                    $message .= "Trạng thái: " . ($review_status ? 'Đã duyệt tự động' : 'Chờ duyệt') . "\n\n";
                    $message .= "Xem chi tiết: " . NV_MY_DOMAIN . NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=reviews\n\n";
                    $message .= "Trân trọng,\n";
                    $message .= $global_config['site_name'];
                    
                    nv_sharecode_send_email_notification($admin_info['email'], $admin_name, $subject, $message);
                }
            }
            
            $response_message = $review_status ? 'Cảm ơn bạn đã đánh giá!' : 'Cảm ơn bạn đã đánh giá! Đánh giá sẽ được hiển thị sau khi admin duyệt.';
            nv_jsonOutput(['status' => 'success', 'message' => $response_message]);
        } else {
            nv_jsonOutput(['status' => 'error', 'message' => 'Có lỗi xảy ra khi lưu đánh giá']);
        }
    } catch (Exception $e) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Có lỗi xảy ra: ' . $e->getMessage()]);
    }
}

if ($nv_Request->isset_request('process_payment', 'post')) {
    // Xử lý thanh toán AJAX
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập']);
    }
    
    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    
    if ($source_id <= 0 || $source_id != $source['id']) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Source ID không hợp lệ']);
    }
    
    // Kiểm tra đã mua chưa
    $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
            WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id . " AND status='completed'";
    $purchased = $db->query($sql_check)->fetchColumn();
    
    if ($purchased) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Bạn đã mua mã nguồn này rồi']);
    }
    
    // Kiểm tra loại phí - không cho phép mua loại "contact"
    if ($source['fee_type'] == 'contact') {
        nv_jsonOutput(['status' => 'error', 'message' => 'Sản phẩm này yêu cầu liên hệ trực tiếp để mua']);
    }
    
    // Tính toán số tiền (miễn phí = 0đ)
    $amount = ($source['fee_type'] == 'free') ? 0 : floatval($source['fee_amount']);
    
    try {
        $db->beginTransaction();
        
        // Tạo purchase record
        $purchase_id = md5($user_info['userid'] . '_' . $source['id'] . '_' . time() . '_' . mt_rand());
        $transaction_id = 'SHARECODE_' . time() . '_' . $user_info['userid'] . '_' . $source['id'];
        
        $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_purchases (
            id, userid, source_id, amount, currency, purchase_time, payment_time, status, payment_method, transaction_id
        ) VALUES (
            " . $db->quote($purchase_id) . ",
            " . $user_info['userid'] . ",
            " . $source['id'] . ",
            " . $amount . ",
            'VND',
            " . NV_CURRENTTIME . ",
            " . NV_CURRENTTIME . ",
            'completed',
            " . $db->quote($amount > 0 ? 'wallet_auto' : 'free') . ",
            " . $db->quote($transaction_id) . "
        )";
        
        if (!$db->query($sql_insert)) {
            throw new Exception('Không thể tạo purchase record');
        }
        
        // Nếu có phí thì trừ tiền từ wallet
        if ($amount > 0) {
            // $deduct_result = nv_local_api('WalletDeductBalance', [
            //     'userid' => $user_info['userid'],
            //     'amount' => $amount,
            //     'currency' => 'VND',
            //     'description' => 'Mua mã nguồn: ' . $source['title'],
            //     'module_ref' => 'sharecode',
            //     'ref_id' => $source['id']
            // ], '', 'wallet');
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
                    'reference_id' => $source['id']
                ]);
            $deduct_result = $api->execute();

            // Xử lý kết quả API
            if (!is_array($deduct_result)) {
                if (is_string($deduct_result)) {
                    $deduct_result = json_decode($deduct_result, true);
                }
                if (!is_array($deduct_result)) {
                    $deduct_result = ['status' => 'error', 'message' => 'Invalid API response'];
                }
            }

            if (!isset($deduct_result['status']) || $deduct_result['status'] !== 'success') {
                pr($deduct_result);
                nv_jsonOutput([
                    'status' => 'error',
                    'message' => 'Không thể trừ tiền từ wallet: ' . ($deduct_result['message'] ?? 'Unknown error')
                ]);
            }
        }
        
        // Cập nhật thống kê source
        $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources
                SET num_download = num_download + 1
                WHERE id = " . $source['id'];
        $db->query($sql_update);
        
        // Ghi log
        $log_data = json_encode([
            'purchase_type' => $amount > 0 ? 'paid' : 'free',
            'amount' => $amount,
            'transaction_id' => $transaction_id,
            'payment_method' => $amount > 0 ? 'wallet_auto' : 'free'
        ]);
        
        $sql_log = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_logs (
            userid, source_id, action, ip, user_agent, log_time, details
        ) VALUES (
            " . $user_info['userid'] . ",
            " . $source['id'] . ",
            'purchase',
            " . $db->quote(NV_CLIENT_IP) . ",
            " . $db->quote($_SERVER['HTTP_USER_AGENT'] ?? '') . ",
            " . NV_CURRENTTIME . ",
            " . $db->quote($log_data) . "
        )";
        $db->query($sql_log);

        nv_sharecode_send_purchase_success_email($user_info, $source, $purchase_id, $amount, $transaction_id);

        $db->commit();

        nv_jsonOutput([
            'status' => 'success',
            'message' => 'Thanh toán thành công!',
            'data' => [
                'transaction_id' => $transaction_id,
                'amount' => $amount,
                'purchase_id' => $purchase_id
            ]
        ]);
        
    } catch (Exception $e) {
        $db->rollback();
        nv_jsonOutput(['status' => 'error', 'message' => $e->getMessage()]);
    }
}

// Lấy reviews
$sql = "SELECT r.*, u.username as user_fullname
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON r.userid = u.userid
        WHERE r.source_id=" . $source['id'] . " AND r.status=1
        ORDER BY r.add_time DESC
        LIMIT 10";
$result = $db->query($sql);

$reviews = [];
while ($row = $result->fetch()) {
    $row['created_time_format'] = date('d/m/Y H:i', $row['add_time']);
    $row['rating_stars'] = str_repeat('★', $row['rating']) . str_repeat('☆', 5 - $row['rating']);
    $row['comment'] = $row['content']; // Đặt alias để template dùng
    $row['username'] = $row['username'] ?: $row['user_fullname']; // Ưu tiên username từ reviews table
    $reviews[] = $row;
}

// Tính rating trung bình và breakdown
$sql = "SELECT AVG(rating) as avg_rating, COUNT(*) as total_reviews 
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews 
        WHERE source_id=" . $source['id'] . " AND status=1";
$rating_data = $db->query($sql)->fetch();
$avg_rating = !empty($rating_data['avg_rating']) ? round(floatval($rating_data['avg_rating']), 1) : 0;
$total_reviews = !empty($rating_data['total_reviews']) ? intval($rating_data['total_reviews']) : 0;

// Lấy breakdown rating
$rating_breakdown = [];
for ($i = 5; $i >= 1; $i--) {
    $sql_rating = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews 
                   WHERE source_id=" . $source['id'] . " AND status=1 AND rating=" . $i;
    $count = $db->query($sql_rating)->fetchColumn();
    $percent = $total_reviews > 0 ? round(($count / $total_reviews) * 100) : 0;
    $rating_breakdown[$i] = [
        'count' => $count,
        'percent' => $percent
    ];
}

// Kiểm tra user có thể đánh giá không
$can_review = false;
$need_login_review = false;
$user_has_reviewed = false;

if (!defined('NV_IS_USER')) {
    $need_login_review = true;
} else {
    // Kiểm tra đã đánh giá chưa
    $sql_user_review = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews 
                        WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source['id'];
    $user_has_reviewed = $db->query($sql_user_review)->fetchColumn();
    
    if (!$user_has_reviewed) {
        // Kiểm tra đã mua sản phẩm chưa
        $sql_purchase_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases 
                              WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source['id'] . " AND status='completed'";
        $has_purchased = $db->query($sql_purchase_check)->fetchColumn();
        
        if ($has_purchased) {
            $can_review = true;
        }
    }
}

// Chuẩn bị thông tin author
$author_info = [
    'id' => $source['userid'],
    'username' => !empty($source['user_username']) ? $source['user_username'] : $source['username'],
    'display_name' => '',
    'email' => $source['email'] ?? '',
    'avatar_url' => '',
    'total_codes' => 0,
    'total_downloads' => 0,
    'avg_rating' => 0,
    'join_date' => '',
    'profile_url' => ''
];

// Tên hiển thị ưu tiên
if (!empty($source['first_name']) || !empty($source['last_name'])) {
    $author_info['display_name'] = trim($source['first_name'] . ' ' . $source['last_name']);
} else {
    $author_info['display_name'] = $author_info['username'];
}

// Avatar
if (!empty($source['photo']) && file_exists(NV_ROOTDIR . '/' . $source['photo'])) {
    $author_info['avatar_url'] = NV_BASE_SITEURL . $source['photo'];
} else {
    $author_info['avatar_url'] = NV_BASE_SITEURL . 'themes/default/images/avatar-default.png';
}

// Thống kê của author
if ($source['userid'] > 0) {
    // Tổng số code đã đăng
    $sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $source['userid'] . " AND status=1";
    $author_info['total_codes'] = $db->query($sql_count)->fetchColumn();
    
    // Tổng lượt download
    $sql_downloads = "SELECT SUM(num_download) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $source['userid'] . " AND status=1";
    $author_info['total_downloads'] = $db->query($sql_downloads)->fetchColumn() ?: 0;
    
    // Đánh giá trung bình
    $sql_rating = "SELECT AVG(r.rating) 
                   FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
                   INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON r.source_id = s.id
                   WHERE s.userid=" . $source['userid'] . " AND r.status=1 AND s.status=1";
    $avg_rating = $db->query($sql_rating)->fetchColumn();
    $author_info['avg_rating'] = !empty($avg_rating) ? round(floatval($avg_rating), 1) : 0;
    
    // Ngày tham gia (lấy từ user table hoặc source đầu tiên)
    if (!empty($source['user_username'])) {
        $sql_join = "SELECT regdate FROM " . NV_USERS_GLOBALTABLE . " WHERE userid=" . $source['userid'];
        $regdate = $db->query($sql_join)->fetchColumn();
        $author_info['join_date'] = $regdate ? date('d/m/Y', $regdate) : '';
    }
    
    // URL profile author
    $author_info['profile_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=author&id=' . $source['userid'];
}

// Lấy sources liên quan
$sql = "SELECT s.*, c.title as category_title 
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
        WHERE s.status=1 AND s.catid=" . $source['catid'] . " AND s.id!=" . $source['id'] . "
        ORDER BY s.add_time DESC
        LIMIT 6";
$result = $db->query($sql);

$related_sources = [];
while ($row = $result->fetch()) {
    $detail_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $row['alias'];
    $row['link'] = nv_url_rewrite($detail_url, true);
    
    // Enhanced price formatting for related sources
    switch ($row['fee_type']) {
        case 'free':
            $row['price_text'] = 'Miễn phí';
            break;
        case 'contact':
            $row['price_text'] = 'Liên hệ';
            break;
        default:
            $row['price_text'] = number_format($row['fee_amount']) . ' VNĐ';
    }
    
    // Xử lý hình ảnh
    if (!empty($row['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $row['image'])) {
        $row['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $row['image'];
    } elseif (!empty($row['avatar']) && file_exists(NV_ROOTDIR . $row['avatar'])) {
        $row['image_url'] = NV_BASE_SITEURL . ltrim($row['avatar'], '/');
    } else {
        $row['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
    }
    
    $related_sources[] = $row;
}

// Chuẩn bị dữ liệu cho template
$xtpl = new XTemplate('detail.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

$xtpl->assign('SOURCE', $source);
$xtpl->assign('CATEGORY', $category);
$xtpl->assign('AUTHOR', $author_info);

// History URL để redirect sau khi thanh toán
if (defined('NV_IS_USER')) {
    $history_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history&userid=' . $user_info['userid'];
} else {
    $history_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name;
}
$xtpl->assign('HISTORY_URL', $history_url);

// Xử lý giá
if ($source['fee_type'] == 'free') {
    $xtpl->parse('main.free_price');
} elseif ($source['fee_type'] == 'contact') {
    $xtpl->parse('main.contact_price');
} else {
    $xtpl->parse('main.paid_price');
}

// Xử lý quyền download
if ($already_purchased) {
    $xtpl->parse('main.already_purchased');
} elseif ($need_login) {
    $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login';
    $xtpl->assign('LOGIN_URL', $login_url);
    $xtpl->parse('main.need_login');
} elseif ($need_contact) {
    // Contact information will be handled by JavaScript modalShow
    $xtpl->parse('main.need_contact');
} else {
    $xtpl->parse('main.can_download');
}

// Chuẩn bị data cho modal
if ($source['fee_type'] == 'free') {
    $xtpl->parse('main.free_modal');
} elseif ($source['fee_type'] == 'contact') {
    $xtpl->parse('main.contact_modal');
} else {
    $xtpl->parse('main.paid_modal');
}

if ($user_balance_data !== null && is_array($user_balance_data)) {
    $current_balance = isset($user_balance_data['balance']) ? floatval($user_balance_data['balance']) : 0;
    $xtpl->assign('USER_BALANCE', number_format($current_balance, 0, '.', ','));
    $xtpl->assign('BALANCE_AFTER', number_format($balance_after, 0, '.', ','));
    $xtpl->assign('BALANCE_AFTER_CLASS', $balance_after_class);
    $xtpl->parse('main.user_balance');
}

if ($need_topup) {
    $topup_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=wallet&' . NV_OP_VARIABLE . '=recharge';
    $xtpl->assign('TOPUP_URL', $topup_url);
    $xtpl->parse('main.need_topup');
    $xtpl->parse('main.insufficient_balance');
} elseif ($can_pay) {
    $xtpl->parse('main.can_pay');
}

// Xử lý tags
if (!empty($tags)) {
    foreach ($tags as $tag) {
        $xtpl->assign('TAG', $tag);
        $xtpl->parse('main.tags.tag');
    }
    $xtpl->parse('main.tags');
}

// Xử lý reviews section
if ($total_reviews > 0) {
    $xtpl->assign('TOTAL_REVIEWS', $total_reviews);
    $xtpl->assign('AVG_RATING', $avg_rating);
    $rating_stars = max(0, min(5, round(floatval($avg_rating))));
    $xtpl->assign('AVG_RATING_STARS', str_repeat('★', $rating_stars) . str_repeat('☆', 5 - $rating_stars));
    
    // Rating breakdown
    for ($i = 5; $i >= 1; $i--) {
        $xtpl->assign('RATING_' . $i . '_COUNT', $rating_breakdown[$i]['count']);
        $xtpl->assign('RATING_' . $i . '_PERCENT', $rating_breakdown[$i]['percent']);
    }
    
    // Hiển thị rating trong hero
    $xtpl->parse('main.has_reviews');
    $xtpl->parse('main.reviews_summary');
} else {
    // Hiển thị "chưa có đánh giá" trong hero
    $xtpl->parse('main.no_reviews_hero');
}

// Form đánh giá
if ($can_review) {
    $xtpl->parse('main.can_review');
} elseif ($need_login_review) {
    $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login';
    $xtpl->assign('LOGIN_URL', $login_url);
    $xtpl->parse('main.need_login_review');
}

// Danh sách reviews
if (!empty($reviews)) {
    foreach ($reviews as $review) {
        $xtpl->assign('REVIEW', $review);
        $xtpl->parse('main.reviews_list.review');
    }
    $xtpl->parse('main.reviews_list');
} else {
    $xtpl->parse('main.no_reviews');
}

// Xử lý related sources
if (!empty($related_sources)) {
    foreach ($related_sources as $related) {
        $xtpl->assign('RELATED', $related);
        $xtpl->parse('main.related_sources.related');
    }
    $xtpl->parse('main.related_sources');
}

// Demo link
if (!empty($source['demo_link'])) {
    $xtpl->assign('DEMO_LINK', $source['demo_link']);
    $xtpl->parse('main.demo_link');
}

$xtpl->parse('main');
$contents = $xtpl->text('main');

// Include theme functions
if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/sharecode/theme.php')) {
    include_once NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/sharecode/theme.php';
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
