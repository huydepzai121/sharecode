<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}
if (!defined('NV_IS_USER')) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login&nv_redirect=' . nv_base64_encode($client_info['selfurl']));
}
$page_title = 'Doanh thu bán code';
$key_words = 'doanh thu, bán code, thống kê, sharecode';
$description = 'Thống kê doanh thu từ việc bán source code trên ' . $global_config['site_name'];

$array_mod_title[] = [
    'catid' => 0,
    'title' => 'Doanh thu bán code',
    'link' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=revenue'
];
$userid = $user_info['userid'];

$time_filter = $nv_Request->get_title('time', 'get', 'all');
$year = $nv_Request->get_int('year', 'get', date('Y'));
$month = $nv_Request->get_int('month', 'get', date('n'));

$where_time = '';
switch ($time_filter) {
    case 'today':
        $start_time = mktime(0, 0, 0, date('n'), date('j'), date('Y'));
        $end_time = mktime(23, 59, 59, date('n'), date('j'), date('Y'));
        $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        break;
    case 'yesterday':
        $start_time = mktime(0, 0, 0, date('n'), date('j') - 1, date('Y'));
        $end_time = mktime(23, 59, 59, date('n'), date('j') - 1, date('Y'));
        $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        break;
    case 'this_week':
        $start_time = mktime(0, 0, 0, date('n'), date('j') - date('w'), date('Y'));
        $end_time = mktime(23, 59, 59, date('n'), date('j') - date('w') + 6, date('Y'));
        $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        break;
    case 'this_month':
        $start_time = mktime(0, 0, 0, date('n'), 1, date('Y'));
        $end_time = mktime(23, 59, 59, date('n'), date('t'), date('Y'));
        $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        break;
    case 'last_month':
        $last_month = date('n') - 1;
        $year_last = date('Y');
        if ($last_month <= 0) {
            $last_month = 12;
            $year_last--;
        }
        $start_time = mktime(0, 0, 0, $last_month, 1, $year_last);
        $end_time = mktime(23, 59, 59, $last_month, date('t', $start_time), $year_last);
        $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        break;
    case 'last_week':
        $start_time = mktime(0, 0, 0, date('n'), date('j') - date('w') - 7, date('Y'));
        $end_time = mktime(23, 59, 59, date('n'), date('j') - date('w') - 1, date('Y'));
        $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        break;
    case 'this_year':
        $start_time = mktime(0, 0, 0, 1, 1, date('Y'));
        $end_time = mktime(23, 59, 59, 12, 31, date('Y'));
        $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        break;
    case 'custom':
        if ($year > 0 && $month > 0) {
            $start_time = mktime(0, 0, 0, $month, 1, $year);
            $end_time = mktime(23, 59, 59, $month, date('t', $start_time), $year);
            $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        }
        break;
}

$commission_rate = isset($module_config[$module_name]['author_commission_rate']) ? $module_config[$module_name]['author_commission_rate'] : 70;
$commission_decimal = $commission_rate / 100;
$author_rate = 100 - $commission_rate;
$author_decimal = $author_rate / 100;

$sql = "SELECT
            COUNT(*) as total_sales,
            SUM(ROUND(amount * " . $author_decimal . ", 2)) as total_revenue,
            SUM(ROUND(amount * " . $commission_decimal . ", 2)) as total_commission,
            AVG(ROUND(amount * " . $author_decimal . ", 2)) as avg_order_value
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
        WHERE s.userid = " . $userid . " AND p.status = 'completed'" . $where_time;

$stats = $db->query($sql)->fetch();
if (!$stats['total_sales']) {
    $stats = [
        'total_sales' => 0,
        'total_revenue' => 0,
        'total_commission' => 0,
        'avg_order_value' => 0
    ];
}

$sql = "SELECT
            s.id,
            s.title,
            s.fee_amount as price,
            s.avatar,
            s.alias,
            COUNT(p.id) as sales_count,
            SUM(ROUND(p.amount * " . $author_decimal . ", 2)) as revenue,
            SUM(ROUND(p.amount * " . $commission_decimal . ", 2)) as commission
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_purchases p ON s.id = p.source_id AND p.status = 'completed'" . $where_time . "
        WHERE s.userid = " . $userid . " AND s.status = 1
        GROUP BY s.id
        ORDER BY sales_count DESC, revenue DESC
        LIMIT 20";

$products = [];
$result = $db->query($sql);
while ($row = $result->fetch()) {
    $row['revenue'] = floatval($row['revenue']);
    $row['commission'] = floatval($row['commission']);
    $row['price_format'] = number_format($row['price']) . ' VNĐ';
    $row['revenue_format'] = number_format($row['revenue']) . ' VNĐ';
    $row['commission_format'] = number_format($row['commission']) . ' VNĐ';
    $row['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['alias'];

    if (!empty($row['avatar'])) {
        $row['image_url'] = NV_BASE_SITEURL . ltrim($row['avatar'], '/');
    } else {
        $row['image_url'] = NV_BASE_SITEURL . 'themes/' . $global_config['site_theme'] . '/images/no-image.png';
    }
    $products[] = $row;
}
$chart_data = [];
for ($i = 29; $i >= 0; $i--) {
    $date = date('Y-m-d', strtotime('-' . $i . ' days'));
    $start = strtotime($date . ' 00:00:00');
    $end = strtotime($date . ' 23:59:59');

    $sql = "SELECT
                COUNT(*) as sales,
                COALESCE(SUM(ROUND(amount * " . $author_decimal . ", 2)), 0) as revenue,
                COALESCE(SUM(ROUND(amount * " . $commission_decimal . ", 2)), 0) as commission
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
            INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
            WHERE s.userid = " . $userid . " AND p.status = 'completed'
            AND p.payment_time BETWEEN " . $start . " AND " . $end;

    $day_stats = $db->query($sql)->fetch();

    $chart_data[] = [
        'date' => $date,
        'date_format' => date('d/m', $start),
        'sales' => intval($day_stats['sales']),
        'revenue' => floatval($day_stats['revenue']),
        'commission' => floatval($day_stats['commission'])
    ];
}

$page = $nv_Request->get_int('page', 'get', 1);
$per_page = 20;
$offset = ($page - 1) * $per_page;

$sql = "SELECT COUNT(*)
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
        WHERE s.userid = " . $userid . " AND p.status = 'completed'" . $where_time;
$total_transactions = $db->query($sql)->fetchColumn();

$sql = "SELECT
            p.*,
            s.title as source_title,
            s.alias as source_alias,
            u.username as buyer_username
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON p.userid = u.userid
        WHERE s.userid = " . $userid . " AND p.status = 'completed'" . $where_time . "
        ORDER BY p.payment_time DESC
        LIMIT " . $offset . ", " . $per_page;

$transactions = [];
$result = $db->query($sql);
while ($row = $result->fetch()) {
    $row['payment_time_format'] = nv_date('d/m/Y H:i', $row['payment_time']);
    $row['amount_format'] = number_format($row['amount']) . ' VNĐ';
    $row['author_commission'] = round($row['amount'] * $author_decimal, 2);
    $row['author_commission_format'] = number_format($row['author_commission']) . ' VNĐ';
    $row['source_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail&alias=' . $row['source_alias'];
    $transactions[] = $row;
}

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=revenue';
if ($time_filter != 'all') {
    $base_url .= '&time=' . $time_filter;
    if ($time_filter == 'custom' && $year > 0 && $month > 0) {
        $base_url .= '&year=' . $year . '&month=' . $month;
    }
}

$generate_page = nv_alias_page('', $base_url, $total_transactions, $per_page, $page);

$stats['total_revenue_format'] = number_format($stats['total_revenue']) . ' VNĐ';
$stats['total_commission_format'] = number_format($stats['total_commission']) . ' VNĐ';
$stats['avg_order_value_format'] = number_format($stats['avg_order_value']) . ' VNĐ';

$contents = nv_theme_sharecode_revenue($stats, $products, $chart_data, $transactions, $generate_page, $time_filter, $year, $month, $commission_rate);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
