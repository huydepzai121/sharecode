<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}
$author_id = $nv_Request->get_int('id', 'get', 0);
// Lấy thông tin author từ bảng users
$sql = "SELECT * FROM " . NV_USERS_GLOBALTABLE . " WHERE userid = " . $author_id;
$author = $db->query($sql)->fetch();
$array_mod_title[] = [
    'catid' => 0,
    'title' => 'Tác giả: ' . nv_show_name_user($author['first_name'], $author['last_name'], $author['username']),
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=author&id=' . $author_id
];

if ($author_id <= 0) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

// Lấy thông tin author từ bảng users
$sql = "SELECT u.userid, u.username, u.first_name, u.last_name, u.photo, u.regdate, u.last_login, u.last_ip, u.email, u.active
        FROM " . NV_USERS_GLOBALTABLE . " u
        WHERE u.userid = " . $author_id . " AND u.active = 1";
$author = $db->query($sql)->fetch();

if (empty($author)) {
    $sql = "SELECT DISTINCT userid, username
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources
            WHERE userid = " . $author_id . " AND status = 1
            LIMIT 1";
    $author_source = $db->query($sql)->fetch();

    if (empty($author_source)) {
        nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
    }

    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 20;

$category_filter = $nv_Request->get_int('category', 'get', 0);
$sort = $nv_Request->get_title('sort', 'get', 'newest');

$sort_options = [
    'newest' => 'Mới nhất',
    'oldest' => 'Cũ nhất',
    'popular' => 'Phổ biến',
    'downloads' => 'Nhiều lượt tải',
    'rating' => 'Đánh giá cao'
];

$where = "s.userid = " . $author_id . " AND s.status = 1";

if ($category_filter > 0) {
    $where .= " AND s.catid = " . $category_filter;
}

$order_by = "s.add_time DESC";
switch ($sort) {
    case 'oldest':
        $order_by = "s.add_time ASC";
        break;
    case 'popular':
        $order_by = "s.num_view DESC";
        break;
    case 'downloads':
        $order_by = "s.num_download DESC";
        break;
    case 'rating':
        $order_by = "s.avg_rating DESC";
        break;
    default:
        $order_by = "s.add_time DESC";
}

$sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
              LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
              WHERE " . $where;
$total_sources = $db->query($sql_count)->fetchColumn();

$sql_stats = "SELECT
                COUNT(*) as total_codes,
                SUM(num_download) as total_downloads,
                SUM(num_view) as total_views
              FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources
              WHERE userid = " . $author_id . " AND status = 1";
$stats = $db->query($sql_stats)->fetch();

$sources = [];
if ($total_sources > 0) {
    $offset = ($page - 1) * $per_page;

    $sql = "SELECT s.*, c.title as category_title, c.alias as category_alias
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
            LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
            WHERE " . $where . "
            ORDER BY " . $order_by . "
            LIMIT " . $offset . ", " . $per_page;

    $result = $db->query($sql);
    while ($row = $result->fetch()) {
        $row['add_time_format'] = nv_date('d/m/Y H:i', $row['add_time']);
        $row['filesize_format'] = !empty($row['file_size']) ? nv_convertfromBytes($row['file_size']) : 'Chưa xác định';
        $row['price_format'] = $row['fee_type'] == 'free' ? 'Miễn phí' : ($row['fee_type'] == 'contact' ? 'Liên hệ' : number_format($row['fee_amount']) . ' VNĐ');
        $row['price_text'] = $row['price_format'];
        $row['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&id=' . $row['id'];
        $row['category_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=category&alias=' . $row['category_alias'];

        if (!empty($row['avatar'])) {
            $row['image_url'] = $row['avatar'];
        } else {
            $row['image_url'] = NV_BASE_SITEURL . 'themes/' . $global_config['site_theme'] . '/images/no-image.png';
        }

        if (isset($row['avg_rating']) && $row['avg_rating'] > 0) {
            $row['rating_stars'] = str_repeat('★', round($row['avg_rating'])) . str_repeat('☆', 5 - round($row['avg_rating']));
            $row['total_reviews'] = $row['total_reviews'] ?? 0;
        }

        $sources[] = $row;
    }
}

$categories = [];
$sql = "SELECT id, title FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE status = 1 ORDER BY weight ASC";
$result = $db->query($sql);
while ($row = $result->fetch()) {
    $categories[] = $row;
}

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=author&id=' . $author_id;
if ($category_filter > 0) {
    $base_url .= '&category=' . $category_filter;
}
if ($sort != 'newest') {
    $base_url .= '&sort=' . $sort;
}

$generate_page = nv_alias_page('', $base_url, $total_sources, $per_page, $page);

$author_info = [
    'id' => $author_id,
    'userid' => $author_id,
    'username' => $author['username'],
    'display_name' => !empty($author['display_name']) ? $author['display_name'] : trim($author['first_name'] . ' ' . $author['last_name']),
    'email' => $author['email'] ?? '',
    'avatar_url' => !empty($author['photo']) ? NV_BASE_SITEURL . NV_UPLOADS_DIR . '/users/' . $author['photo'] : NV_BASE_SITEURL . 'themes/' . $global_config['site_theme'] . '/images/users/no_avatar.png',
    'join_time' => $author['regdate'] ?? 0,
    'join_time_format' => !empty($author['regdate']) ? nv_date('d/m/Y', $author['regdate']) : '',
    'join_date' => !empty($author['regdate']) ? nv_date('d/m/Y', $author['regdate']) : '',
    'total_codes' => $stats['total_codes'] ?? 0,
    'total_downloads' => $stats['total_downloads'] ?? 0,
    'total_views' => $stats['total_views'] ?? 0,
    'bio' => $author['bio'] ?? '',
    'website' => $author['website'] ?? '',
    'facebook' => $author['facebook'] ?? '',
    'twitter' => $author['twitter'] ?? '',
    'github' => $author['github'] ?? '',
    'avg_rating' => 0,
    'total_reviews' => 0
];

$page_title = 'Tác giả: ' . $author_info['display_name'];
$key_words = $author_info['display_name'] . ', mã nguồn, code, sharecode';
$description = 'Xem tất cả mã nguồn của tác giả ' . $author_info['display_name'] . ' - ' . $author_info['total_codes'] . ' mã nguồn, ' . number_format($author_info['total_downloads']) . ' lượt tải.';

$contents = nv_theme_sharecode_author($author_info, $sources, $categories, $sort_options, $sort, $category_filter, $generate_page, $total_sources);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
