<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

$alias = $nv_Request->get_title('t', 'get', '');
$page = $nv_Request->get_int('page', 'get', 1);
if (empty($array_op)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags WHERE alias=" . $db->quote($array_op[1]);
$tag = $db->query($sql)->fetch();

if (empty($tag)) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
}

$per_page = 12;
$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $array_op[0] . '/' . $array_op[1] . '/';

$sql = "SELECT COUNT(DISTINCT s.id) 
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st ON s.id = st.source_id
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_tags t ON st.tag_id = t.id
        WHERE s.status=1 AND t.id=" . $tag['id'];
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
$sql = "SELECT DISTINCT s.*, c.title as category_title,
        (SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews r WHERE r.source_id = s.id AND r.status = 1) as total_reviews
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st ON s.id = st.source_id
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_tags t ON st.tag_id = t.id
        WHERE s.status=1 AND t.id=" . $tag['id'] . "
        ORDER BY " . $order_by . "
        LIMIT " . $limit . ", " . $per_page;

$result = $db->query($sql);
$sources = [];

while ($row = $result->fetch()) {
    $row['add_time_format'] = date('d/m/Y', $row['add_time']);

    switch ($row['fee_type']) {
        case 'free':
            $row['price_text'] = 'Miễn phí';
            $row['price_class'] = 'text-success';
            $row['price_badge'] = 'success';
            break;
        case 'contact':
            $row['price_text'] = 'Liên hệ để biết giá';
            $row['price_class'] = 'text-info';
            $row['price_badge'] = 'info';
            break;
        default:
            $row['price_text'] = number_format($row['fee_amount']) . ' VNĐ';
            $row['price_class'] = 'text-warning';
            $row['price_badge'] = 'warning';
    }

    if (!empty($row['avatar']) && file_exists(NV_ROOTDIR . '/' . $row['avatar'])) {
        $row['image_url'] =  $row['avatar'];
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

$page_title = 'Tag: ' . $tag['name'] . ' - ' . $module_info['custom_title'];
$key_words = $tag['name'] . ', ' . $module_info['keywords'];
if (!empty($tag['keywords'])) {
    $key_words = $tag['name'] . ', ' . $tag['keywords'] . ', ' . $module_info['keywords'];
}
$description = 'Danh sách mã nguồn có tag: ' . $tag['name'];

$array_mod_title[] = [
    'catid' => 0,
    'title' => 'Tag: ' . $tag['name'],
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $array_op[0] . '/' . $array_op[1]
];

$sql = "SELECT t.*, COUNT(st.source_id) as total_sources
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags t
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st ON t.id = st.tag_id
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON st.source_id = s.id
        WHERE t.id != " . $tag['id'] . " AND s.status = 1
        GROUP BY t.id
        ORDER BY total_sources DESC, t.name ASC
        LIMIT 10";
$result = $db->query($sql);
$related_tags = [];

while ($row = $result->fetch()) {
    $tag_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $array_op[0] . '/' . $array_op[1];
    $row['link'] = nv_url_rewrite($tag_url, true);
    $related_tags[] = $row;
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

$contents = nv_theme_sharecode_tag($tag, $sources, $related_tags, $sort_links, $sort, $generate_page, $total_sources);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
