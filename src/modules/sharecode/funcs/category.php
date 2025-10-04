<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

$alias = $nv_Request->get_title('t', 'get', '');
$page = $nv_Request->get_int('page', 'get', 1);

if (empty($alias)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE alias=" . $db->quote($alias) . " AND status=1";
$category = $db->query($sql)->fetch();

if (empty($category)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$per_page = 20;
$base_url = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=category&t=' . $alias, true);

$sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE status=1 AND catid=" . $category['id'];
$total_sources = $db->query($sql)->fetchColumn();

$sort = $nv_Request->get_title('sort', 'get', 'latest');
$allowed_sorts = ['latest', 'popular', 'name', 'rating'];
if (!in_array($sort, $allowed_sorts)) {
    $sort = 'latest';
}

$order_by = '';
switch ($sort) {
    case 'latest':
        $order_by = 's.add_time DESC';
        break;
    case 'popular':
        $order_by = 's.num_download DESC, s.num_view DESC';
        break;
    case 'name':
        $order_by = 's.title ASC';
        break;
    case 'rating':
        $order_by = 's.avg_rating DESC, s.num_download DESC';
        break;
}

$limit = ($page - 1) * $per_page;
$sql = "SELECT s.*, c.title as category_title,
        (SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r WHERE r.source_id = s.id AND r.status = 1) as total_reviews
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
        WHERE s.status=1 AND s.catid=" . $category['id'] . "
        ORDER BY " . $order_by . "
        LIMIT " . $limit . ", " . $per_page;

$result = $db->query($sql);
$sources = [];

while ($row = $result->fetch()) {
    $row['add_time_format'] = date('d/m/Y', $row['add_time']);

    // Xử lý giá và loại giá
    $row['is_free'] = false;
    $row['is_paid'] = false;
    $row['is_contact'] = false;

    switch ($row['fee_type']) {
        case 'free':
            $row['price_text'] = 'Miễn phí';
            $row['price_class'] = 'text-success';
            $row['price_badge'] = 'success';
            $row['fee_amount_formatted'] = 'Miễn phí';
            $row['is_free'] = true;
            break;
        case 'contact':
            $row['price_text'] = 'Liên hệ để biết giá';
            $row['price_class'] = 'text-info';
            $row['price_badge'] = 'info';
            $row['fee_amount_formatted'] = 'Liên hệ';
            $row['is_contact'] = true;
            break;
        default:
            $row['price_text'] = number_format($row['fee_amount']) . ' VNĐ';
            $row['price_class'] = 'text-warning';
            $row['price_badge'] = 'warning';
            $row['fee_amount_formatted'] = number_format($row['fee_amount']) . ' VNĐ';
            $row['is_paid'] = true;
    }

    if (!empty($row['avatar']) && file_exists(NV_ROOTDIR . '/' . $row['avatar'])) {
        $row['image_url'] = $row['avatar'];
    } else {
        $row['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
    }

    $detail_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $row['alias'];
    $row['link'] = nv_url_rewrite($detail_url, true);

    $row['rating_stars'] = '';
    if ($row['avg_rating'] > 0) {
        $row['rating_stars'] = str_repeat('★', round($row['avg_rating'])) . str_repeat('☆', 5 - round($row['avg_rating']));
    }

    $sources[] = $row;
}

$generate_page = nv_alias_page($page_title, $base_url, $total_sources, $per_page, $page);

$page_title = $category['title'] . ' - ' . $module_info['custom_title'];
$key_words = $category['title'] . ', ' . $module_info['keywords'];
if (!empty($category['keywords'])) {
    $key_words = $category['title'] . ', ' . $category['keywords'] . ', ' . $module_info['keywords'];
}
$description = !empty($category['description']) ? nv_clean60($category['description'], 160) : $category['title'];

$array_mod_title[] = [
    'catid' => 0,
    'title' => $category['title'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=category&t=' . $category['alias']
];

$sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE status=1 AND parentid=" . $category['id'] . " ORDER BY weight ASC";
$result = $db->query($sql);
$subcategories = [];

while ($row = $result->fetch()) {
    $cat_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=category&t=' . $row['alias'];
    $row['link'] = nv_url_rewrite($cat_url, true);
    $sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE status=1 AND catid=" . $row['id'];
    $row['total_sources'] = $db->query($sql_count)->fetchColumn();

    $subcategories[] = $row;
}

$sort_links = [];
$sorts = [
    'latest' => 'Mới nhất',
    'popular' => 'Phổ biến',
    'name' => 'Tên A-Z',
    'rating' => 'Đánh giá cao'
];

foreach ($sorts as $sort_key => $sort_name) {
    $sort_url = $base_url . '&sort=' . $sort_key;
    if ($page > 1) {
        $sort_url .= '&page=' . $page;
    }
    $sort_links[$sort_key] = [
        'name' => $sort_name,
        'link' => nv_url_rewrite($sort_url, true),
        'active' => $sort == $sort_key
    ];
}

$contents = nv_theme_sharecode_category_view($category, $sources, $total_sources, $generate_page, $base_url, $sort_links, $subcategories);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
