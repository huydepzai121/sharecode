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

$author_id = $nv_Request->get_int('id', 'get', 0);

if ($author_id <= 0) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Lấy thông tin author
$sql = "SELECT u.userid, u.username, u.email, u.first_name, u.last_name, u.photo, u.regdate, u.last_login, u.last_ip
        FROM " . NV_USERS_GLOBALTABLE . " u
        WHERE u.userid = " . $author_id . " AND u.active = 1";
$author = $db->query($sql)->fetch();

if (empty($author)) {
    // Thử tìm theo userid trong sources
    $sql = "SELECT DISTINCT userid, username
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources
            WHERE userid = " . $author_id . " AND status = 1
            LIMIT 1";
    $author_source = $db->query($sql)->fetch();

    if (empty($author_source)) {
        nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
    }

    // Tạo author info giả từ source
    $author = [
        'userid' => $author_id,
        'username' => $author_source['username'],
        'email' => '',
        'first_name' => '',
        'last_name' => '',
        'photo' => '',
        'regdate' => 0,
        'last_login' => 0,
        'last_ip' => ''
    ];
}

// Chuẩn bị thông tin author
$author_info = [
    'id' => $author['userid'],
    'username' => $author['username'],
    'display_name' => '',
    'email' => $author['email'] ?? '',
    'avatar_url' => '',
    'join_date' => '',
    'last_login' => '',
    'total_codes' => 0,
    'total_downloads' => 0,
    'total_views' => 0,
    'avg_rating' => 0,
    'total_reviews' => 0
];

// Tên hiển thị
if (!empty($author['first_name']) || !empty($author['last_name'])) {
    $author_info['display_name'] = trim($author['first_name'] . ' ' . $author['last_name']);
} else {
    $author_info['display_name'] = $author['username'];
}

// Avatar
if (!empty($author['photo']) && file_exists(NV_ROOTDIR . '/' . $author['photo'])) {
    $author_info['avatar_url'] = NV_BASE_SITEURL . $author['photo'];
} else {
    $author_info['avatar_url'] = NV_BASE_SITEURL . 'themes/default/images/avatar-default.png';
}

// Ngày tham gia và đăng nhập cuối
if ($author['regdate'] > 0) {
    $author_info['join_date'] = date('d/m/Y', $author['regdate']);
}
if ($author['last_login'] > 0) {
    $author_info['last_login'] = date('d/m/Y H:i', $author['last_login']);
}

// Thống kê chi tiết
$sql_stats = "SELECT
                COUNT(*) as total_codes,
                SUM(num_download) as total_downloads,
                SUM(num_view) as total_views
              FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources
              WHERE userid = " . $author_id . " AND status = 1";
$stats = $db->query($sql_stats)->fetch();

$author_info['total_codes'] = $stats['total_codes'] ?: 0;
$author_info['total_downloads'] = $stats['total_downloads'] ?: 0;
$author_info['total_views'] = $stats['total_views'] ?: 0;

// Đánh giá trung bình và tổng số review
$sql_rating = "SELECT AVG(r.rating) as avg_rating, COUNT(r.id) as total_reviews
               FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r
               INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON r.source_id = s.id
               WHERE s.userid = " . $author_id . " AND r.status = 1 AND s.status = 1";
$rating_data = $db->query($sql_rating)->fetch();

$author_info['avg_rating'] = $rating_data['avg_rating'] ? round($rating_data['avg_rating'], 1) : 0;
$author_info['total_reviews'] = $rating_data['total_reviews'] ?: 0;

// Lấy danh sách sources của author
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 12;
$offset = ($page - 1) * $per_page;

// Filter options
$category_filter = $nv_Request->get_int('category', 'get', 0);
$sort = $nv_Request->get_string('sort', 'get', 'latest');

$where_conditions = ['s.userid = ' . $author_id, 's.status = 1'];

if ($category_filter > 0) {
    $where_conditions[] = 's.catid = ' . $category_filter;
}

$where_clause = 'WHERE ' . implode(' AND ', $where_conditions);

// Sort options
$order_clause = '';
switch ($sort) {
    case 'popular':
        $order_clause = 'ORDER BY s.num_download DESC, s.add_time DESC';
        break;
    case 'rating':
        $order_clause = 'ORDER BY s.num_download DESC, s.add_time DESC'; // TODO: Add avg rating to sources table
        break;
    case 'oldest':
        $order_clause = 'ORDER BY s.add_time ASC';
        break;
    case 'latest':
    default:
        $order_clause = 'ORDER BY s.add_time DESC';
        break;
}

// Đếm tổng số
$sql_count = "SELECT COUNT(*) 
              FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
              " . $where_clause;
$total_sources = $db->query($sql_count)->fetchColumn();

// Lấy danh sách sources
$sql = "SELECT s.*, c.title as category_title, c.alias as category_alias
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
        " . $where_clause . "
        " . $order_clause . "
        LIMIT " . $per_page . " OFFSET " . $offset;

$result = $db->query($sql);
$sources = [];

while ($row = $result->fetch()) {
    // Format data
    $row['add_time_format'] = date('d/m/Y', $row['add_time']);
    $row['price_text'] = $row['fee_type'] == 'free' ? 'Miễn phí' : number_format($row['fee_amount']) . ' VNĐ';
    
    // Links
    $detail_url = NV_BASE_SITEURL . $module_name . '/detail/' . $row['alias'];
    $row['link'] = nv_url_rewrite($detail_url, true);
    
    if (!empty($row['category_alias'])) {
        $category_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=category&t=' . $row['category_alias'];
        $row['category_link'] = nv_url_rewrite($category_url, true);
    } else {
        $row['category_link'] = '';
    }
    
    // Image
    if (!empty($row['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $row['image'])) {
        $row['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $row['image'];
    } else {
        $row['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no-image.png';
    }
    
    // Rating
    $sql_rating = "SELECT AVG(rating) as avg_rating, COUNT(*) as total_reviews 
                   FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews 
                   WHERE source_id = " . $row['id'] . " AND status = 1";
    $rating_info = $db->query($sql_rating)->fetch();
    $row['avg_rating'] = $rating_info['avg_rating'] ? round($rating_info['avg_rating'], 1) : 0;
    $row['total_reviews'] = $rating_info['total_reviews'] ?: 0;
    $row['rating_stars'] = str_repeat('★', round($row['avg_rating'])) . str_repeat('☆', 5 - round($row['avg_rating']));
    
    $sources[] = $row;
}

// Pagination
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=author&id=' . $author_id;
if ($category_filter > 0) {
    $base_url .= '&category=' . $category_filter;
}
if ($sort != 'latest') {
    $base_url .= '&sort=' . $sort;
}

$generate_page = nv_generate_page($base_url, $total_sources, $per_page, $page);

// Lấy danh sách categories cho filter (chỉ categories có source của author này)
$sql_cats = "SELECT DISTINCT c.id, c.title, c.alias
             FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories c
             INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON c.id = s.catid
             WHERE s.userid = " . $author_id . " AND s.status = 1 AND c.status = 1
             ORDER BY c.weight ASC, c.title ASC";
$result_cats = $db->query($sql_cats);

$categories = [];
while ($row = $result_cats->fetch()) {
    $categories[] = $row;
}

// Sort options
$sort_options = [
    'latest' => 'Mới nhất',
    'popular' => 'Phổ biến nhất',
    'oldest' => 'Cũ nhất'
];

// Breadcrumb
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=author&id=' . $author_id;
$array_mod_title[] = [
    'title' => 'Tác giả: ' . $author_info['display_name'],
    'link' => nv_url_rewrite($base_url, true)
];

// SEO
$page_title = 'Tác giả: ' . $author_info['display_name'];
$key_words = $author_info['display_name'] . ', mã nguồn, code, sharecode';
$description = 'Xem tất cả mã nguồn của tác giả ' . $author_info['display_name'] . ' - ' . $author_info['total_codes'] . ' mã nguồn, ' . number_format($author_info['total_downloads']) . ' lượt tải.';

// Render template
$contents = nv_theme_sharecode_author($author_info, $sources, $categories, $sort_options, $sort, $category_filter, $generate_page, $total_sources);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';