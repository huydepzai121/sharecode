<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

$q = $nv_Request->get_title('q', 'get', '');
$category = $nv_Request->get_int('category', 'get', 0);
$price_filter = $nv_Request->get_title('price_filter', 'get', '');
$sort = $nv_Request->get_title('sort', 'get', 'latest');
$page = $nv_Request->get_int('page', 'get', 1);

$per_page = !empty($module_config[$module_name]['items_per_page']) ? intval($module_config[$module_name]['items_per_page']) : 12;
$offset = ($page - 1) * $per_page;

$where_conditions = ['s.status = 1'];

if (!empty($q)) {
    $q_escaped = $db->quote('%' . $q . '%');
    $where_conditions[] = "(s.title LIKE $q_escaped OR s.description LIKE $q_escaped OR s.keywords LIKE $q_escaped)";
}

if ($category > 0) {
    $where_conditions[] = 's.catid = ' . intval($category);
}

if ($price_filter == 'free') {
    $where_conditions[] = 's.fee_type = "free"';
} elseif ($price_filter == 'paid') {
    $where_conditions[] = 's.fee_type = "paid"';
}

$order_map = [
    'latest' => 's.add_time DESC',
    'popular' => 's.num_view DESC',
    'name' => 's.title ASC',
    'rating' => 's.avg_rating DESC'
];
$order_by = isset($order_map[$sort]) ? $order_map[$sort] : $order_map['latest'];

$count_sql = "SELECT COUNT(s.id) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s";
$count_sql .= " WHERE " . implode(' AND ', $where_conditions);
$total_sources = $db->query($count_sql)->fetchColumn();

$sources = [];
if ($total_sources > 0) {
    $sql = "SELECT s.*, c.title as category_title, c.alias as category_alias
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
            LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
            WHERE " . implode(' AND ', $where_conditions) . "
            ORDER BY " . $order_by . "
            LIMIT " . intval($offset) . ", " . intval($per_page);

    $result = $db->query($sql);

    while ($row = $result->fetch()) {
        $row['add_time_format'] = nv_date('d/m/Y', $row['add_time']);

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
        $detail_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $row['alias'];
        $row['link'] = nv_url_rewrite($detail_url, true);

        if (!empty($row['avatar']) && file_exists(NV_ROOTDIR . '/' . $row['avatar'])) {
            $row['image_url'] = $row['avatar'];
        } else {
            $row['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
        }

        $row['avg_rating'] = isset($row['avg_rating']) ? $row['avg_rating'] : 0;
        $row['total_reviews'] = isset($row['total_reviews']) ? $row['total_reviews'] : 0;

        $sources[] = $row;
    }
}

$categories = [];
$cat_sql = "SELECT id, title FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE status = 1 ORDER BY weight ASC";
$cat_result = $db->query($cat_sql);
while ($cat_row = $cat_result->fetch()) {
    $categories[] = $cat_row;
}

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name;
if (!empty($q)) $base_url .= '&q=' . urlencode($q);
if ($category > 0) $base_url .= '&category=' . $category;
if (!empty($price_filter)) $base_url .= '&price_filter=' . urlencode($price_filter);
if (!empty($sort)) $base_url .= '&sort=' . urlencode($sort);

$base_url = nv_url_rewrite($base_url, true);

$generate_page = nv_generate_page($base_url, $total_sources, $per_page, $page);

$page_title = $module_info['site_title'];
$key_words = $module_info['keywords'];
$description = $module_info['description'];

if (!empty($q)) {
    $page_title = 'Tìm kiếm: ' . $q . ' - ' . $page_title;
    $key_words = $q . ', ' . $key_words;
}

$contents = nv_theme_sharecode_list_view($sources, $categories, $q, $category, $price_filter, $sort, $total_sources, $generate_page, $base_url);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
