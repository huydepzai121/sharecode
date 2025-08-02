<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_FILE_MODULES')) {
    exit('Stop!!!');
}

$sql_drop_module = [];
$array_table = [
    'categories',
    'sources',
    'reviews',
    'tags',
    'source_tags',
    'purchases',
    'logs',
    'download_logs',
    'favorites',
    'notifications'
];

$table = $db_config['prefix'] . '_' . $lang . '_' . $module_data;
$result = $db->query('SHOW TABLE STATUS LIKE ' . $db->quote($table . '_%'));
while ($item = $result->fetch()) {
    $name = substr($item['name'], strlen($table) + 1);
    if (preg_match('/^' . $db_config['prefix'] . '\_' . $lang . '\_' . $module_data . '\_/', $item['name']) and in_array($name, $array_table, true)) {
        $sql_drop_module[] = 'DROP TABLE IF EXISTS ' . $item['name'];
    }
}

$result = $db->query("SHOW TABLE STATUS LIKE '" . $db_config['prefix'] . "\_" . $lang . "\_comment'");
$rows = $result->fetchAll();
if (count($rows)) {
    $sql_drop_module[] = 'DELETE FROM ' . $db_config['prefix'] . '_' . $lang . "_comment WHERE module='" . $module_name . "'";
}

// Xóa cấu hình module
$sql_drop_module[] = 'DELETE FROM ' . NV_CONFIG_GLOBALTABLE . " WHERE module='" . $module_name . "'";
$sql_drop_module[] = 'DELETE FROM ' . NV_CONFIG_GLOBALTABLE . " WHERE config_name='" . $module_name . "'";

$sql_create_module = $sql_drop_module;

// Tạo bảng categories
$sql_create_module[] = "CREATE TABLE " . $table . "_categories (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID danh mục',
    parentid INT NOT NULL DEFAULT 0 COMMENT 'ID danh mục cha',
    title VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Tên danh mục',
    alias VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Đường dẫn tĩnh',
    description TEXT COMMENT 'Mô tả danh mục',
    image VARCHAR(255) DEFAULT '' COMMENT 'Hình ảnh đại diện',
    weight INT DEFAULT 0 COMMENT 'Thứ tự sắp xếp',
    status TINYINT DEFAULT 1 COMMENT 'Trạng thái (0: tắt, 1: bật)',
    add_time INT(11) DEFAULT 0 COMMENT 'Thời gian tạo',
    INDEX idx_alias (alias),
    INDEX idx_parentid (parentid),
    INDEX idx_status (status),
    INDEX idx_weight (weight),
    INDEX idx_status_weight (status, weight)
) ENGINE=MyISAM COMMENT='Bảng danh mục'";

// Tạo bảng sources
$sql_create_module[] = "CREATE TABLE " . $table . "_sources (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID mã nguồn',
    catid INT NOT NULL DEFAULT 0 COMMENT 'ID danh mục',
    title VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Tiêu đề mã nguồn',
    alias VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Đường dẫn tĩnh',
    description TEXT COMMENT 'Mô tả ngắn',
    content LONGTEXT COMMENT 'Nội dung chi tiết',
    image VARCHAR(255) DEFAULT '' COMMENT 'Hình ảnh đại diện',
    file_path VARCHAR(255) DEFAULT '' COMMENT 'Đường dẫn file',
    file_name VARCHAR(255) DEFAULT '' COMMENT 'Tên file gốc',
    file_size INT DEFAULT 0 COMMENT 'Kích thước file (bytes)',
    download_link VARCHAR(255) DEFAULT '' COMMENT 'Link tải xuống',
    download_link_type ENUM('internal','external') DEFAULT 'internal' COMMENT 'Loại link (nội bộ/bên ngoài)',
    demo_link VARCHAR(255) DEFAULT '' COMMENT 'Link demo',
    keywords VARCHAR(255) DEFAULT '' COMMENT 'Từ khóa tìm kiếm',
    fee_type ENUM('free','paid','contact') DEFAULT 'free' COMMENT 'Loại phí (free/paid/contact)',
    fee_amount DECIMAL(15,2) DEFAULT 0.00 COMMENT 'Số tiền',
    contact_phone VARCHAR(20) DEFAULT '' COMMENT 'Số điện thoại liên hệ',
    contact_email VARCHAR(100) DEFAULT '' COMMENT 'Email liên hệ',
    contact_skype VARCHAR(100) DEFAULT '' COMMENT 'Skype liên hệ',
    contact_telegram VARCHAR(100) DEFAULT '' COMMENT 'Telegram liên hệ',
    contact_zalo VARCHAR(20) DEFAULT '' COMMENT 'Zalo liên hệ',
    contact_facebook VARCHAR(255) DEFAULT '' COMMENT 'Facebook liên hệ',
    contact_website VARCHAR(255) DEFAULT '' COMMENT 'Website liên hệ',
    contact_address TEXT COMMENT 'Địa chỉ liên hệ',
    num_view INT DEFAULT 0 COMMENT 'Số lượt xem',
    num_download INT DEFAULT 0 COMMENT 'Số lượt tải',
    avg_rating DECIMAL(3,2) DEFAULT 0.00 COMMENT 'Điểm đánh giá trung bình',
    status TINYINT DEFAULT 1 COMMENT 'Trạng thái (0: tắt, 1: bật, 2: chờ duyệt)',
    userid INT DEFAULT 0 COMMENT 'ID người đăng',
    username VARCHAR(100) DEFAULT '' COMMENT 'Tên người đăng',
    INDEX idx_alias (alias),
    INDEX idx_catid (catid),
    INDEX idx_status (status),
    INDEX idx_fee_type (fee_type),
    INDEX idx_userid (userid),
    INDEX idx_catid_status (catid, status),
    INDEX idx_fee_type_status (fee_type, status),
    INDEX idx_num_view (num_view),
    INDEX idx_num_download (num_download),
    INDEX idx_avg_rating (avg_rating),
    FULLTEXT idx_title_keywords (title, keywords, description)
) ENGINE=MyISAM COMMENT='Bảng mã nguồn'";

// Tạo bảng purchases
$sql_create_module[] = "CREATE TABLE " . $table . "_purchases (
    id VARCHAR(32) NOT NULL COMMENT 'ID giao dịch mua',
    userid INT NOT NULL DEFAULT 0 COMMENT 'ID người mua',
    source_id INT NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
    amount DECIMAL(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền',
    currency VARCHAR(3) DEFAULT 'VND' COMMENT 'Loại tiền tệ',
    payment_method VARCHAR(50) DEFAULT '' COMMENT 'Phương thức thanh toán',
    transaction_id VARCHAR(100) DEFAULT '' COMMENT 'Mã giao dịch từ gateway',
    status VARCHAR(20) DEFAULT 'pending' COMMENT 'Trạng thái (pending/completed/failed/cancelled)',
    purchase_time INT(11) DEFAULT 0 COMMENT 'Thời gian đặt mua',
    payment_time INT(11) DEFAULT 0 COMMENT 'Thời gian thanh toán',
    notes TEXT COMMENT 'Ghi chú',
    PRIMARY KEY (id),
    INDEX idx_userid (userid),
    INDEX idx_source_id (source_id),
    INDEX idx_status (status),
    INDEX idx_purchase_time (purchase_time),
    INDEX idx_payment_time (payment_time),
    INDEX idx_userid_status (userid, status),
    INDEX idx_source_id_status (source_id, status)
) ENGINE=MyISAM COMMENT='Bảng giao dịch mua'";

// Tạo bảng reviews
$sql_create_module[] = "CREATE TABLE " . $table . "_reviews (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID đánh giá',
    source_id INT NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
    userid INT NOT NULL DEFAULT 0 COMMENT 'ID người đánh giá',
    username VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Tên người đánh giá',
    title VARCHAR(255) DEFAULT '' COMMENT 'Tiêu đề đánh giá',
    content TEXT COMMENT 'Nội dung đánh giá',
    rating TINYINT DEFAULT 5 COMMENT 'Số sao đánh giá (1-5)',
    status TINYINT DEFAULT 0 COMMENT 'Trạng thái (0: chờ duyệt, 1: đã duyệt, 2: từ chối)',
    INDEX idx_source_id (source_id),
    INDEX idx_userid (userid),
    INDEX idx_status (status),
    INDEX idx_rating (rating),
    INDEX idx_source_id_status (source_id, status),
    INDEX idx_source_id_rating (source_id, rating)
) ENGINE=MyISAM COMMENT='Bảng đánh giá'";

// Tạo bảng tags
$sql_create_module[] = "CREATE TABLE " . $table . "_tags (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID thẻ tag',
    name VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Tên thẻ tag',
    alias VARCHAR(100) NOT NULL DEFAULT '' COMMENT 'Đường dẫn tĩnh',
    description TEXT COMMENT 'Mô tả thẻ tag',
    weight INT DEFAULT 0 COMMENT 'Thứ tự sắp xếp',
    status TINYINT DEFAULT 1 COMMENT 'Trạng thái (0: tắt, 1: bật)',
    total_sources INT DEFAULT 0 COMMENT 'Tổng số mã nguồn có tag này',
    UNIQUE KEY unique_name (name),
    INDEX idx_alias (alias),
    INDEX idx_weight (weight),
    INDEX idx_status (status),
    INDEX idx_total_sources (total_sources),
    INDEX idx_status_weight (status, weight)
) ENGINE=MyISAM COMMENT='Bảng thẻ tag'";

// Tạo bảng source_tags
$sql_create_module[] = "CREATE TABLE " . $table . "_source_tags (
    source_id INT NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
    tag_id INT NOT NULL DEFAULT 0 COMMENT 'ID thẻ tag',
    PRIMARY KEY (source_id, tag_id),
    INDEX idx_tag_id (tag_id)
) ENGINE=MyISAM COMMENT='Bảng liên kết mã nguồn và thẻ tag'";

// Tạo bảng logs
$sql_create_module[] = "CREATE TABLE " . $table . "_logs (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID log',
    userid INT DEFAULT 0 COMMENT 'ID người dùng',
    source_id INT DEFAULT 0 COMMENT 'ID mã nguồn liên quan',
    action VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'Hành động (view/download/upload/etc)',
    ip VARCHAR(45) DEFAULT '' COMMENT 'Địa chỉ IP',
    user_agent TEXT COMMENT 'User Agent của trình duyệt',
    log_time INT(11) DEFAULT 0 COMMENT 'Thời gian ghi log',
    details LONGTEXT COMMENT 'Chi tiết bổ sung',
    INDEX idx_userid (userid),
    INDEX idx_source_id (source_id),
    INDEX idx_action (action),
    INDEX idx_log_time (log_time),
    INDEX idx_action_log_time (action, log_time),
    INDEX idx_userid_action (userid, action)
) ENGINE=MyISAM COMMENT='Bảng ghi log hệ thống'";

// Tạo bảng download_logs
$sql_create_module[] = "CREATE TABLE " . $table . "_download_logs (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID log tải xuống',
    source_id INT NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
    user_id INT DEFAULT 0 COMMENT 'ID người tải (0 nếu guest)',
    ip_address VARCHAR(45) DEFAULT '' COMMENT 'Địa chỉ IP',
    download_time INT(11) DEFAULT 0 COMMENT 'Thời gian tải xuống',
    user_agent TEXT COMMENT 'User Agent của trình duyệt',
    INDEX idx_source_id (source_id),
    INDEX idx_user_id (user_id),
    INDEX idx_download_time (download_time),
    INDEX idx_source_id_download_time (source_id, download_time),
    INDEX idx_user_id_download_time (user_id, download_time)
) ENGINE=MyISAM COMMENT='Bảng log tải xuống'";

// Tạo bảng favorites
$sql_create_module[] = "CREATE TABLE " . $table . "_favorites (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID yêu thích',
    userid INT NOT NULL DEFAULT 0 COMMENT 'ID người dùng',
    source_id INT NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
    UNIQUE KEY unique_favorite (userid, source_id),
    INDEX idx_userid (userid),
    INDEX idx_source_id (source_id)
) ENGINE=MyISAM COMMENT='Bảng mã nguồn yêu thích'";

// Tạo bảng notifications
$sql_create_module[] = "CREATE TABLE " . $table . "_notifications (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT 'ID thông báo',
    userid INT NOT NULL DEFAULT 0 COMMENT 'ID người nhận',
    type VARCHAR(50) NOT NULL DEFAULT '' COMMENT 'Loại thông báo (new_source/review/etc)',
    title VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'Tiêu đề thông báo',
    content TEXT COMMENT 'Nội dung thông báo',
    source_id INT DEFAULT 0 COMMENT 'ID mã nguồn liên quan',
    url VARCHAR(255) DEFAULT '' COMMENT 'URL liên kết',
    is_read TINYINT DEFAULT 0 COMMENT 'Đã đọc (0: chưa, 1: rồi)',
    INDEX idx_userid (userid),
    INDEX idx_type (type),
    INDEX idx_is_read (is_read),
    INDEX idx_userid_is_read (userid, is_read),
    INDEX idx_userid_type (userid, type)
) ENGINE=MyISAM COMMENT='Bảng thông báo'";

// Dữ liệu mẫu đã được chuyển sang file /language/data_vi.php
