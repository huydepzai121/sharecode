<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

use NukeViet\Api\DoApi;

$alias = '';
$id = 0;

if (isset($array_op[1])) {
    $alias = $array_op[1];
} else {
    $alias = $nv_Request->get_title('alias', 'get', '');
    $id = $nv_Request->get_int('id', 'get', 0);
}

if (empty($alias) && $id == 0) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$source = [];
if (!empty($alias)) {
    $sql = "SELECT s.*, u.username as user_username, u.email, u.first_name, u.last_name, u.photo
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
            LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON s.userid = u.userid
            WHERE s.alias=" . $db->quote($alias) . " AND s.status=1";
    $source = $db->query($sql)->fetch();
} elseif ($id > 0) {
    $sql = "SELECT s.*, u.username as user_username, u.email, u.first_name, u.last_name, u.photo
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
            LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON s.userid = u.userid
            WHERE s.id=" . $id . " AND s.status=1";
    $source = $db->query($sql)->fetch();
}

if (empty($source)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources SET num_view = num_view + 1 WHERE id=" . $source['id'];
$db->query($sql_update);

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $source['alias'];
$array_mod_title[] = [
    'title' => $source['title'],
    'link' => nv_url_rewrite($base_url, true)
];

$page_title = $source['title'];
$key_words = $source['title'] . ', ' . $source['keywords'];
$description = !empty($source['description']) ? nv_clean60($source['description'], 160) : $source['title'];

$category = [];
$sql_cat = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $source['catid'];
$category = $db->query($sql_cat)->fetch();
if (empty($category)) {
    $category = ['title' => 'Chưa phân loại', 'alias' => ''];
}

$tags = [];
$sql_tags = "SELECT t.* FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags t
             INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st ON t.id = st.tag_id
             WHERE st.source_id = " . $source['id'];
$result_tags = $db->query($sql_tags);
while ($row = $result_tags->fetch()) {
    $tag_url = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=tag/' . $row['alias'], true);
    $row['link'] = $tag_url . '/';
    $tags[] = $row;
}

if (!empty($source['avatar']) && file_exists(NV_ROOTDIR . '/' . $source['avatar'])) {
    $source['image_url'] =  $source['avatar'];
} else {
    $source['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
}

$category_info = [];
if ($source['catid'] > 0) {
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id = " . $source['catid'];
    $result = $db->query($sql);
    if ($result->rowCount()) {
        $category_info = $result->fetch();
    }
}

$source['add_time_format'] = date('d/m/Y H:i', $source['add_time']);

if ($source['file_size'] > 0) {
    if ($source['file_size'] >= 1073741824) {
        $source['file_size_format'] = round($source['file_size'] / 1073741824, 2) . ' GB';
    } elseif ($source['file_size'] >= 1048576) {
        $source['file_size_format'] = round($source['file_size'] / 1048576, 2) . ' MB';
    } elseif ($source['file_size'] >= 1024) {
        $source['file_size_format'] = round($source['file_size'] / 1024, 2) . ' KB';
    } else {
        $source['file_size_format'] = $source['file_size'] . ' bytes';
    }
} else {
    $source['file_size_format'] = 'Chưa xác định';
}

$source['category_title'] = !empty($category_info) ? $category_info['title'] : 'Chưa phân loại';

$source['file_type_display'] = '';
switch ($source['download_link_type']) {
    case 'file':
        $source['file_type_display'] = 'File tải về';
        break;
    case 'external':
        $source['file_type_display'] = 'Link ngoài';
        break;
    default:
        $source['file_type_display'] = 'Chưa xác định';
        break;
}

$source['fee_type_display'] = '';
switch ($source['fee_type']) {
    case 'free':
        $source['fee_type_display'] = 'Miễn phí';
        break;
    case 'paid':
        $source['fee_type_display'] = 'Có phí';
        break;
    case 'contact':
        $source['fee_type_display'] = 'Liên hệ';
        break;
    default:
        $source['fee_type_display'] = 'Chưa xác định';
        break;
}

$demo_images = [];
if (!empty($source['demo_image'])) {
    $demo_image_data = json_decode($source['demo_image'], true);
    if (is_array($demo_image_data)) {
        foreach ($demo_image_data as $k => $img_path) {
            if (!empty($img_path)) {
                $clean_path = ltrim($img_path, '/');
                $full_path = NV_ROOTDIR . '/' . $clean_path;

                if (file_exists($full_path)) {
                    $demo_images[] = [
                        'url' => NV_BASE_SITEURL . $clean_path,
                        'path' => $clean_path,
                        'alt' => 'Demo ảnh - ' . $source['title'],
                        'title' => 'Xem demo ảnh của ' . $source['title'],
                        'index' => $k + 1
                    ];
                }
            }
        }
    } elseif (is_string($source['demo_image']) && !empty($source['demo_image'])) {
        $clean_path = ltrim($source['demo_image'], '/');
        $full_path = NV_ROOTDIR . '/' . $clean_path;

        if (file_exists($full_path)) {
            $demo_images[] = [
                'url' => NV_BASE_SITEURL . $clean_path,
                'path' => $clean_path,
                'alt' => 'Demo ảnh - ' . $source['title'],
                'title' => 'Xem demo ảnh của ' . $source['title'],
                'index' => 1
            ];
        }
    }
}

switch ($source['fee_type']) {
    case 'free':
        $source['price_text'] = 'Miễn phí';
        $source['price_class'] = 'free';
        $source['price_icon'] = 'fa fa-gift';
        break;
    case 'contact':
        $source['price_text'] = 'Liên hệ để biết giá';
        $source['price_class'] = 'contact';
        $source['price_icon'] = 'fa fa-phone';
        break;
    default:
        $source['price_text'] = number_format($source['fee_amount']) . ' VNĐ';
        $source['price_class'] = 'paid';
        $source['price_icon'] = 'fa fa-money';
}

$category_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=category/' . $category['alias'];
$source['category_link'] = nv_url_rewrite($category_url, true);

$download_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=download&id=' . $source['id'];
$source['download_url'] = nv_url_rewrite($download_url, true);

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
    $is_author = ($user_info['userid'] == $source['userid']);
    $is_admin = defined('NV_IS_ADMIN');

    if ($is_author || $is_admin) {
        $already_purchased = true;
    } else {
        $sql_purchase = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
                        WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source['id'] . " AND status='completed'";
        $purchased = $db->query($sql_purchase)->fetchColumn();

        if ($purchased) {
            $already_purchased = true;
        } else {
            if ($source['fee_type'] == 'contact') {
                $need_contact = true;
            } else {
                $can_download = true;

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
                    $can_pay = true;
                }
            }
        }
    }
}

if ($nv_Request->isset_request('get_download_token', 'post')) {
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập']);
    }

    $source_id = $nv_Request->get_int('source_id', 'post', 0);

    if ($source_id <= 0) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Source ID không hợp lệ']);
    }

    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id;
    $source_info = $db->query($sql)->fetch();

    if (!$source_info) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Mã nguồn không tồn tại']);
    }

    $is_author = ($user_info['userid'] == $source_info['userid']);
    $is_admin = defined('NV_IS_ADMIN');

    if (!$is_author && !$is_admin) {
        $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
                WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id . " AND status='completed'";
        $purchased = $db->query($sql_check)->fetchColumn();

        if (!$purchased) {
            nv_jsonOutput(['status' => 'error', 'message' => 'Bạn chưa mua mã nguồn này']);
        }
    }

    if (empty($source_info['download_link'])) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Link tải xuống không hợp lệ hoặc chưa được cấu hình']);
    }

    $download_url = $source_info['download_link'];
    $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources
            SET num_download = num_download + 1
            WHERE id = " . $source_id;
    $db->query($sql_update);

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

if ($nv_Request->isset_request('admin_reply_review', 'post') && defined('NV_IS_ADMIN')) {
    $review_id = $nv_Request->get_int('review_id', 'post', 0);
    $admin_reply_content = $nv_Request->get_textarea('admin_reply_content', 'post', '');
    $checksess = $nv_Request->get_title('checksess', 'post', '');

    if ($checksess != NV_CHECK_SESSION) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Token xác thực không hợp lệ']);
    }

    if ($review_id <= 0) {
        nv_jsonOutput(['status' => 'error', 'message' => 'ID đánh giá không hợp lệ']);
    }

    if (empty($admin_reply_content)) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng nhập nội dung phản hồi']);
    }

    $sql_check = "SELECT r.id, r.userid, u.email, u.username
                  FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
                  LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON r.userid = u.userid
                  WHERE r.id=" . $review_id . " AND r.source_id=" . $source['id'] . " AND r.status=1";
    $review_info = $db->query($sql_check)->fetch();

    if (!$review_info) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Đánh giá không tồn tại hoặc không thuộc về sản phẩm này']);
    }

    try {
        $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_reviews
                      SET admin_reply = " . $db->quote($admin_reply_content) . ",
                          admin_reply_time = " . NV_CURRENTTIME . ",
                          admin_reply_userid = " . $admin_info['userid'] . "
                      WHERE id = " . $review_id;

        if ($db->exec($sql_update)) {
            if (!empty($review_info['email']) && !empty($review_info['username'])) {
                $subject = "Admin đã trả lời đánh giá của bạn - " . $global_config['site_name'];
                $message = "Xin chào " . $review_info['username'] . ",\n\n";
                $message .= "Admin đã trả lời đánh giá của bạn cho sản phẩm: " . $source['title'] . "\n\n";
                $message .= "Phản hồi từ admin:\n" . $admin_reply_content . "\n\n";
                $message .= "Xem chi tiết tại: " . NV_MY_DOMAIN . NV_BASE_SITEURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=detail&alias=" . $source['alias'] . "\n\n";
                $message .= "Trân trọng,\n" . $global_config['site_name'];

                @nv_sendmail(
                    [$global_config['site_name'], $global_config['site_email']],
                    $review_info['email'],
                    $subject,
                    $message
                );
            }

            nv_jsonOutput(['status' => 'success', 'message' => 'Trả lời đánh giá thành công!']);
        } else {
            nv_jsonOutput(['status' => 'error', 'message' => 'Có lỗi xảy ra khi lưu phản hồi']);
        }
    } catch (Exception $e) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Lỗi hệ thống: ' . $e->getMessage()]);
    }
}

// Xử lý trả lời bình luận
if ($nv_Request->isset_request('submit_reply', 'post')) {
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập để trả lời']);
    }

    $comment_id = $nv_Request->get_int('comment_id', 'post', 0);
    $reply_content = $nv_Request->get_textarea('reply_content', 'post', '');
    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    $checksess = $nv_Request->get_title('checksess', 'post', '');

    if ($checksess != NV_CHECK_SESSION) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Token xác thực không hợp lệ']);
    }

    if ($source_id <= 0 || $source_id != $source['id']) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Source ID không hợp lệ']);
    }

    if ($comment_id <= 0) {
        nv_jsonOutput(['status' => 'error', 'message' => 'ID bình luận không hợp lệ']);
    }

    if (empty($reply_content)) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng nhập nội dung trả lời']);
    }

    if (strlen($reply_content) < 5) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Nội dung trả lời phải có ít nhất 5 ký tự']);
    }

    // Kiểm tra comment có tồn tại và thuộc về source này không
    $sql_check = "SELECT c.id, c.userid, c.username
                  FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments c
                  WHERE c.id=" . $comment_id . " AND c.source_id=" . $source_id . " AND c.status=1";
    $comment_info = $db->query($sql_check)->fetch();

    if (!$comment_info) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Bình luận không tồn tại hoặc không thuộc về sản phẩm này']);
    }

    try {
        // Thêm reply vào database
        $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_comments
                      (source_id, userid, username, content, time_add, status, parent_id)
                      VALUES (
                          " . $source_id . ",
                          " . $user_info['userid'] . ",
                          " . $db->quote($user_info['username']) . ",
                          " . $db->quote($reply_content) . ",
                          " . NV_CURRENTTIME . ",
                          1,
                          " . $comment_id . "
                      )";

        if ($db->exec($sql_insert)) {
            // Gửi email thông báo cho người được reply (nếu khác người reply)
            if ($comment_info['userid'] != $user_info['userid'] && !empty($comment_info['username'])) {
                // Lấy email của người được reply
                $sql_email = "SELECT email FROM " . NV_USERS_GLOBALTABLE . " WHERE userid=" . $comment_info['userid'];
                $user_email = $db->query($sql_email)->fetchColumn();

                if (!empty($user_email)) {
                    $subject = "Có người trả lời bình luận của bạn - " . $global_config['site_name'];
                    $message = "Xin chào " . $comment_info['username'] . ",\n\n";
                    $message .= $user_info['username'] . " đã trả lời bình luận của bạn cho sản phẩm: " . $source['title'] . "\n\n";
                    $message .= "Nội dung trả lời:\n" . $reply_content . "\n\n";
                    $message .= "Xem chi tiết tại: " . NV_MY_DOMAIN . NV_BASE_SITEURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=detail&alias=" . $source['alias'] . "\n\n";
                    $message .= "Trân trọng,\n" . $global_config['site_name'];

                    @nv_sendmail(
                        [$global_config['site_name'], $global_config['site_email']],
                        $user_email,
                        $subject,
                        $message
                    );
                }
            }

            nv_jsonOutput(['status' => 'success', 'message' => 'Trả lời bình luận thành công!']);
        } else {
            nv_jsonOutput(['status' => 'error', 'message' => 'Có lỗi xảy ra khi lưu trả lời']);
        }
    } catch (Exception $e) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Lỗi hệ thống: ' . $e->getMessage()]);
    }
}

if ($nv_Request->isset_request('submit_review', 'post')) {
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập để đánh giá']);
    }

    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    $rating = $nv_Request->get_int('rating', 'post', 0);
    $comment = $nv_Request->get_textarea('comment', 'post', '');
    $checksess = $nv_Request->get_title('checksess', 'post', '');

    if ($checksess != NV_CHECK_SESSION) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Token xác thực không hợp lệ']);
    }

    if ($source_id <= 0 || $source_id != $source['id']) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Source ID không hợp lệ']);
    }

    if ($rating < 1 || $rating > 5) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Đánh giá phải từ 1 đến 5 sao']);
    }

    if (empty($comment)) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng nhập nhận xét']);
    }

    $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews
                  WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id;
    $existing_review = $db->query($sql_check)->fetchColumn();

    if ($existing_review) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Bạn đã đánh giá sản phẩm này rồi']);
    }

    $sql_config = "SELECT config_name, config_value FROM " . NV_CONFIG_GLOBALTABLE . " WHERE lang='" . NV_LANG_DATA . "' AND module='" . $module_name . "'";
    $result_config = $db->query($sql_config);
    $module_config = [];
    while ($row_config = $result_config->fetch()) {
        $module_config[$row_config['config_name']] = $row_config['config_value'];
    }

    $review_status = 1;

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
            if (!empty($module_config['email_notify_new_review'])) {
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

            $response_message = 'Cảm ơn bạn đã đánh giá! Đánh giá của bạn đã được đăng.';
            nv_jsonOutput(['status' => 'success', 'message' => $response_message]);
        } else {
            nv_jsonOutput(['status' => 'error', 'message' => 'Có lỗi xảy ra khi lưu đánh giá']);
        }
    } catch (Exception $e) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Có lỗi xảy ra: ' . $e->getMessage()]);
    }
}

if ($nv_Request->isset_request('process_payment', 'post')) {
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập']);
    }

    $source_id = $nv_Request->get_int('source_id', 'post', 0);

    if ($source_id <= 0 || $source_id != $source['id']) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Source ID không hợp lệ']);
    }

    $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
            WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source_id . " AND status='completed'";
    $purchased = $db->query($sql_check)->fetchColumn();

    if ($purchased) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Bạn đã mua mã nguồn này rồi']);
    }

    if ($source['fee_type'] == 'contact') {
        nv_jsonOutput(['status' => 'error', 'message' => 'Sản phẩm này yêu cầu liên hệ trực tiếp để mua']);
    }

    $amount = ($source['fee_type'] == 'free') ? 0 : floatval($source['fee_amount']);

    try {
        $db->beginTransaction();

        $purchase_id = md5($user_info['userid'] . '_' . $source['id'] . '_' . time() . '_' . mt_rand());
        $transaction_id = 'SHARECODE_' . time() . '_' . $user_info['userid'] . '_' . $source['id'];
        if ($amount > 0) {
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

            if (!is_array($deduct_result)) {
                if (is_string($deduct_result)) {
                    $deduct_result = json_decode($deduct_result, true);
                }
                if (!is_array($deduct_result)) {
                    $deduct_result = ['status' => 'error', 'message' => 'Invalid API response'];
                }
            }

            if (!isset($deduct_result['status']) || $deduct_result['status'] !== 'success') {
                throw new Exception('Không thể trừ tiền từ wallet: ' . ($deduct_result['message'] ?? 'Unknown error'));
            }
        }
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

        $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources
                SET num_download = num_download + 1
                WHERE id = " . $source['id'];
        $db->query($sql_update);

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

if ($nv_Request->isset_request('submit_comment', 'post')) {
    if (!defined('NV_IS_USER') && !defined('NV_IS_ADMIN')) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng đăng nhập để bình luận']);
    }

    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    $comment = $nv_Request->get_textarea('comment', 'post', '');
    $parent_id = $nv_Request->get_int('parent_id', 'post', 0);
    $reply_to_comment_id = $nv_Request->get_int('reply_to_comment_id', 'post', 0);

    if ($source_id != $source['id']) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Dữ liệu không hợp lệ']);
    }

    if (empty($comment)) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Vui lòng nhập nội dung bình luận']);
    }

    $current_userid = 0;
    $current_username = '';
    $current_email = '';
    $is_admin_comment = false;

    if (defined('NV_IS_ADMIN')) {
        global $admin_info;
        $current_userid = $admin_info['userid'];
        $current_username = $admin_info['username'];
        $current_email = $admin_info['email'];
        $is_admin_comment = true;
    } elseif (defined('NV_IS_USER')) {
        $current_userid = $user_info['userid'];
        $current_username = $user_info['username'];
        $current_email = $user_info['email'];
        $is_admin_comment = false;
    }

    if ($is_admin_comment && $reply_to_comment_id > 0) {
        $sql_check = "SELECT id, admin_reply FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments
                      WHERE id=" . $reply_to_comment_id . " AND source_id=" . $source_id . " AND status=1";
        $existing_comment = $db->query($sql_check)->fetch();

        if (!$existing_comment) {
            nv_jsonOutput(['status' => 'error', 'message' => 'Comment không tồn tại']);
        }

        $conversation = [];
        if (!empty($existing_comment['admin_reply'])) {
            $decoded = json_decode($existing_comment['admin_reply'], true);
            if (json_last_error() === JSON_ERROR_NONE && is_array($decoded)) {
                $conversation = $decoded;
            } else {
                $conversation[] = [
                    'content' => $existing_comment['admin_reply'],
                    'admin_username' => 'admin',
                    'time' => time() - 3600
                ];
            }
        }

        $conversation[] = [
            'content' => $comment,
            'admin_username' => $current_username,
            'time' => NV_CURRENTTIME
        ];

        $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_comments
                       SET admin_reply = " . $db->quote(json_encode($conversation, JSON_UNESCAPED_UNICODE)) . ",
                           admin_reply_time = " . NV_CURRENTTIME . ",
                           admin_reply_userid = " . $current_userid . "
                       WHERE id = " . $reply_to_comment_id;

        if ($db->exec($sql_update)) {
            nv_jsonOutput(['status' => 'success', 'message' => 'Trả lời thành công!']);
        } else {
            nv_jsonOutput(['status' => 'error', 'message' => 'Có lỗi xảy ra khi lưu trả lời']);
        }
    }

    if ($parent_id > 0) {
        $sql_check_parent = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments
                             WHERE id=" . $parent_id . " AND source_id=" . $source_id . " AND status=1";
        $parent_exists = $db->query($sql_check_parent)->fetchColumn();
        if (!$parent_exists) {
            nv_jsonOutput(['status' => 'error', 'message' => 'Bình luận gốc không tồn tại']);
        }
    }

    try {
        $columns = "source_id, userid, username, email, content, add_time, status, parent_id, ip_address, user_agent";
        $values = $source_id . ", " . $current_userid . ", " . $db->quote($current_username) . ", " .
            $db->quote($current_email) . ", " . $db->quote($comment) . ", " . NV_CURRENTTIME . ", 1, " .
            $parent_id . ", " . $db->quote(NV_CLIENT_IP) . ", " . $db->quote($_SERVER['HTTP_USER_AGENT'] ?? '');

        try {
            $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_comments (
                " . $columns . ", is_admin
            ) VALUES (
                " . $values . ", " . ($is_admin_comment ? 1 : 0) . "
            )";
            $db->exec($sql_insert);
        } catch (Exception $e) {
            $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_comments (
                " . $columns . "
            ) VALUES (
                " . $values . "
            )";
            $db->exec($sql_insert);
        }

        $message = $parent_id > 0 ? 'Phản hồi của bạn đã được gửi thành công!' : 'Bình luận của bạn đã được gửi thành công!';
        nv_jsonOutput(['status' => 'success', 'message' => $message]);
    } catch (Exception $e) {
        nv_jsonOutput(['status' => 'error', 'message' => 'Có lỗi xảy ra: ' . $e->getMessage()]);
    }
}

$sql = "SELECT r.*, u.username as user_fullname, ar.username as admin_reply_username
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON r.userid = u.userid
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " ar ON r.admin_reply_userid = ar.userid
        WHERE r.source_id=" . $source['id'] . " AND r.status=1
        ORDER BY r.add_time DESC
        LIMIT 10";
$result = $db->query($sql);

$reviews = [];
while ($row = $result->fetch()) {
    $row['created_time_format'] = date('d/m/Y H:i', $row['add_time']);
    $row['rating_stars'] = str_repeat('★', $row['rating']) . str_repeat('☆', 5 - $row['rating']);
    $row['comment'] = $row['content'];
    $row['username'] = $row['username'] ?: $row['user_fullname'];

    $row['has_admin_reply'] = !empty($row['admin_reply']);
    $row['admin_reply_time_format'] = $row['admin_reply_time'] ? date('d/m/Y H:i', $row['admin_reply_time']) : '';
    $row['admin_reply_username'] = $row['admin_reply_username'] ?: 'Admin';
    $row['admin_reply_display'] = $row['admin_reply'] ? nl2br(htmlspecialchars($row['admin_reply'])) : '';

    $reviews[] = $row;
}

$sql = "SELECT AVG(rating) as avg_rating, COUNT(*) as total_reviews
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews
        WHERE source_id=" . $source['id'] . " AND status=1";
$rating_data = $db->query($sql)->fetch();
$avg_rating = !empty($rating_data['avg_rating']) ? round(floatval($rating_data['avg_rating']), 1) : 0;
$total_reviews = !empty($rating_data['total_reviews']) ? intval($rating_data['total_reviews']) : 0;

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

$can_review = false;
$need_login_review = false;
$need_purchase_review = false;
$user_has_reviewed = false;

if (!defined('NV_IS_USER')) {
    $need_login_review = true;
} else {
    // Kiểm tra user đã đánh giá chưa
    $sql_user_review = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews
                        WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source['id'];
    $user_has_reviewed = $db->query($sql_user_review)->fetchColumn();

    if (!$user_has_reviewed) {
        // Kiểm tra có phải tác giả không
        $is_author = ($user_info['userid'] == $source['userid']);

        if ($is_author) {
            // Tác giả không thể đánh giá sản phẩm của chính mình
            $can_review = false;
        } else {
            // Kiểm tra đã mua sản phẩm chưa
            $sql_purchase_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
                                  WHERE userid=" . $user_info['userid'] . " AND source_id=" . $source['id'] . " AND status='completed'";
            $has_purchased = $db->query($sql_purchase_check)->fetchColumn();

            if ($has_purchased) {
                $can_review = true;
            } else {
                $need_purchase_review = true;
            }
        }
    }
}

$sql_comments = "SELECT c.*, u.username as user_fullname, u.photo, ar.username as admin_reply_username
                 FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments c
                 LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON c.userid = u.userid
                 LEFT JOIN " . NV_USERS_GLOBALTABLE . " ar ON c.admin_reply_userid = ar.userid
                 WHERE c.source_id=" . $source['id'] . " AND c.status=1
                 ORDER BY c.parent_id ASC, c.add_time ASC";

$result_comments = $db->query($sql_comments);

$all_comments = [];
$comments_tree = [];

while ($row = $result_comments->fetch()) {
    $row['created_time_format'] = date('d/m/Y H:i', $row['add_time']);
    $row['username'] = $row['username'] ?: $row['user_fullname'];
    $row['has_admin_reply'] = !empty($row['admin_reply']);

    $row['is_admin_comment'] = !empty($row['is_admin']);

    if ($row['has_admin_reply']) {
        $row['admin_reply_time_format'] = date('d/m/Y H:i', $row['admin_reply_time']);

        $admin_reply_data = json_decode($row['admin_reply'], true);
        if (json_last_error() === JSON_ERROR_NONE && is_array($admin_reply_data)) {
            $row['admin_reply_conversation'] = $admin_reply_data;
            $row['admin_reply_display'] = '';
            foreach ($admin_reply_data as $reply) {
                $reply_time = date('d/m/Y H:i', $reply['time']);
                $row['admin_reply_display'] .= '<div class="admin-conversation-item">';
                $row['admin_reply_display'] .= '<div class="admin-conversation-header">';
                $row['admin_reply_display'] .= '<strong>' . htmlspecialchars($reply['admin_username']) . '</strong>';
                $row['admin_reply_display'] .= ' - <small>' . $reply_time . '</small>';
                $row['admin_reply_display'] .= '</div>';
                $row['admin_reply_display'] .= '<div class="admin-conversation-content">' . nl2br(htmlspecialchars($reply['content'])) . '</div>';
                $row['admin_reply_display'] .= '</div>';
            }
        } else {
            $row['admin_reply_display'] = nl2br(htmlspecialchars($row['admin_reply']));
            $row['admin_reply_conversation'] = null;
        }
    }
    $row['replies'] = [];
    $all_comments[$row['id']] = $row;
}

foreach ($all_comments as $comment) {
    if ($comment['parent_id'] == 0) {
        $comments_tree[] = $comment;
    } else {
        if (isset($all_comments[$comment['parent_id']])) {
            $all_comments[$comment['parent_id']]['replies'][] = $comment;
        }
    }
}

foreach ($comments_tree as $key => $comment) {
    if (isset($all_comments[$comment['id']]['replies'])) {
        $comments_tree[$key]['replies'] = $all_comments[$comment['id']]['replies'];
    }
}

$comments = $comments_tree;

$sql_count_comments = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments
                       WHERE source_id=" . $source['id'] . " AND status=1";
$total_comments = $db->query($sql_count_comments)->fetchColumn();

$can_comment = defined('NV_IS_USER') || defined('NV_IS_ADMIN');
$need_login_comment = !defined('NV_IS_USER') && !defined('NV_IS_ADMIN');

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

if (!empty($source['first_name']) || !empty($source['last_name'])) {
    $author_info['display_name'] = trim($source['first_name'] . ' ' . $source['last_name']);
} else {
    $author_info['display_name'] = $author_info['username'];
}

if (!empty($source['photo']) && file_exists(NV_ROOTDIR . '/' . $source['photo'])) {
    $author_info['avatar_url'] = NV_BASE_SITEURL . $source['photo'];
} else {
    $author_info['avatar_url'] = NV_BASE_SITEURL . 'themes/' . $global_config['site_theme'] . '/images/users/no_avatar.png';
}

if ($source['userid'] > 0) {
    $sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $source['userid'] . " AND status=1";
    $author_info['total_codes'] = $db->query($sql_count)->fetchColumn();

    $sql_downloads = "SELECT SUM(num_download) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE userid=" . $source['userid'] . " AND status=1";
    $author_info['total_downloads'] = $db->query($sql_downloads)->fetchColumn() ?: 0;

    $sql_rating = "SELECT AVG(r.rating)
                   FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
                   INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON r.source_id = s.id
                   WHERE s.userid=" . $source['userid'] . " AND r.status=1 AND s.status=1";
    $avg_rating = $db->query($sql_rating)->fetchColumn();
    $author_info['avg_rating'] = !empty($avg_rating) ? round(floatval($avg_rating), 1) : 0;

    if (!empty($source['user_username'])) {
        $sql_join = "SELECT regdate FROM " . NV_USERS_GLOBALTABLE . " WHERE userid=" . $source['userid'];
        $regdate = $db->query($sql_join)->fetchColumn();
        $author_info['join_date'] = $regdate ? date('d/m/Y', $regdate) : '';
    }

    $author_info['profile_url'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=author&id=' . $source['userid'], true);
}

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

    if (!empty($row['image']) && file_exists(NV_ROOTDIR . '/' . $row['image'])) {
        $row['image_url'] = NV_BASE_SITEURL . $row['image'];
    } elseif (!empty($row['avatar']) && file_exists(NV_ROOTDIR . '/' . $row['avatar'])) {
        $row['image_url'] = NV_BASE_SITEURL . $row['avatar'];
    } else {
        $row['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
    }

    $related_sources[] = $row;
}

$is_admin = defined('NV_IS_ADMIN');
$is_author = defined('NV_IS_USER') ? ($user_info['userid'] == $source['userid']) : false;

$contents = nv_theme_sharecode_detail($source, $category, $tags, $reviews, $avg_rating, $total_reviews, $related_sources, $can_download, $author_info, $demo_images, $already_purchased, $need_login, $need_contact, $user_balance_data, $balance_after, $balance_after_class, $can_pay, $need_topup, $rating_breakdown, $can_review, $need_login_review, $need_purchase_review, $comments, $total_comments, $can_comment, $need_login_comment, $is_admin, $is_author);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
