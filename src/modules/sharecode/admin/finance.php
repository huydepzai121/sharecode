<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

$page_title = 'Quản lý tài chính';


if ($nv_Request->isset_request('export', 'get') && $nv_Request->get_title('export', 'get') === 'excel') {
    exportFinanceToExcel($db, $module_data, $where_time, $commission_rate, $author_rate);
    exit();
}


$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('finance.tpl'));


$commission_rate = $module_config[$module_name]['author_commission_rate'] ?? 20;
$author_rate = 100 - $commission_rate;


$time_filter = $nv_Request->get_title('time', 'get', 'this_month');
$year = $nv_Request->get_int('year', 'get', date('Y'));
$month = $nv_Request->get_int('month', 'get', date('n'));
$date_from = $nv_Request->get_title('date_from', 'get', '');
$date_to = $nv_Request->get_title('date_to', 'get', '');


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
    case 'this_year':
        $start_time = mktime(0, 0, 0, 1, 1, date('Y'));
        $end_time = mktime(23, 59, 59, 12, 31, date('Y'));
        $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
        break;
    case 'custom':
        if (!empty($date_from) && !empty($date_to)) {
            $start_time = strtotime($date_from . ' 00:00:00');
            $end_time = strtotime($date_to . ' 23:59:59');
            if ($start_time && $end_time) {
                $where_time = " AND payment_time BETWEEN " . $start_time . " AND " . $end_time;
            }
        }
        break;
}


$revenue_stats = [];


$sql = "SELECT 
            COUNT(*) as total_orders,
            SUM(amount) as total_revenue,
            SUM(ROUND(amount * " . ($author_rate / 100) . ", 2)) as author_commission,
            SUM(ROUND(amount * " . ($commission_rate / 100) . ", 2)) as website_commission,
            AVG(amount) as avg_order_value
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases 
        WHERE status = 'completed'" . $where_time;

$result = $db->query($sql);
$revenue_stats = $result->fetch();


$revenue_stats['total_revenue_format'] = number_format($revenue_stats['total_revenue'] ?: 0) . ' VNĐ';
$revenue_stats['author_commission_format'] = number_format($revenue_stats['author_commission'] ?: 0) . ' VNĐ';
$revenue_stats['website_commission_format'] = number_format($revenue_stats['website_commission'] ?: 0) . ' VNĐ';
$revenue_stats['avg_order_value_format'] = number_format($revenue_stats['avg_order_value'] ?: 0) . ' VNĐ';


$sql = "SELECT 
            u.userid, u.username, u.first_name, u.last_name, u.email,
            COUNT(p.id) as total_orders,
            SUM(p.amount) as total_revenue,
            SUM(ROUND(p.amount * " . ($author_rate / 100) . ", 2)) as author_earnings,
            AVG(p.amount) as avg_order_value
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
        INNER JOIN " . NV_USERS_GLOBALTABLE . " u ON s.userid = u.userid
        WHERE p.status = 'completed'" . $where_time . "
        GROUP BY u.userid
        ORDER BY author_earnings DESC
        LIMIT 20";

$result = $db->query($sql);
$top_authors = [];
while ($row = $result->fetch()) {
    $row['full_name'] = trim($row['first_name'] . ' ' . $row['last_name']);
    $row['total_revenue_format'] = number_format($row['total_revenue']) . ' VNĐ';
    $row['author_earnings_format'] = number_format($row['author_earnings']) . ' VNĐ';
    $row['avg_order_value_format'] = number_format($row['avg_order_value']) . ' VNĐ';
    $top_authors[] = $row;
}


$chart_data = [];
for ($i = 29; $i >= 0; $i--) {
    $date = date('Y-m-d', strtotime('-' . $i . ' days'));
    $start = strtotime($date . ' 00:00:00');
    $end = strtotime($date . ' 23:59:59');

    $sql = "SELECT 
                COUNT(*) as orders,
                COALESCE(SUM(amount), 0) as revenue,
                COALESCE(SUM(ROUND(amount * " . ($author_rate / 100) . ", 2)), 0) as author_commission,
                COALESCE(SUM(ROUND(amount * " . ($commission_rate / 100) . ", 2)), 0) as website_commission
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases 
            WHERE status = 'completed'
            AND payment_time BETWEEN " . $start . " AND " . $end;

    $result = $db->query($sql);
    $day_data = $result->fetch();

    $chart_data[] = [
        'date' => $date,
        'date_format' => date('d/m', strtotime($date)),
        'orders' => intval($day_data['orders']),
        'revenue' => floatval($day_data['revenue']),
        'author_commission' => floatval($day_data['author_commission']),
        'website_commission' => floatval($day_data['website_commission'])
    ];
}

$sql = "SELECT 
            s.id, s.title, s.alias, s.fee_amount,
            COUNT(p.id) as total_sales,
            SUM(p.amount) as total_revenue,
            SUM(ROUND(p.amount * " . ($author_rate / 100) . ", 2)) as author_earnings
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
        INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
        WHERE p.status = 'completed'" . $where_time . "
        GROUP BY s.id
        ORDER BY total_revenue DESC
        LIMIT 10";

$result = $db->query($sql);
$top_products = [];
while ($row = $result->fetch()) {
    $row['total_revenue_format'] = number_format($row['total_revenue']) . ' VNĐ';
    $row['author_earnings_format'] = number_format($row['author_earnings']) . ' VNĐ';
    $row['fee_amount_format'] = number_format($row['fee_amount']) . ' VNĐ';
    $row['product_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $row['alias'];
    $top_products[] = $row;
}


$time_filters = [
    'today' => 'Hôm nay',
    'yesterday' => 'Hôm qua',
    'this_week' => 'Tuần này',
    'this_month' => 'Tháng này',
    'last_month' => 'Tháng trước',
    'this_year' => 'Năm này',
    'custom' => 'Tùy chọn'
];


$tpl->assign('REVENUE_STATS', $revenue_stats);
$tpl->assign('TOP_AUTHORS', $top_authors);
$tpl->assign('TOP_PRODUCTS', $top_products);
$tpl->assign('CHART_DATA', json_encode($chart_data));
$tpl->assign('TIME_FILTERS', $time_filters);
$tpl->assign('TIME_FILTER', $time_filter);
$tpl->assign('YEAR', $year);
$tpl->assign('MONTH', $month);
$tpl->assign('DATE_FROM', $date_from);
$tpl->assign('DATE_TO', $date_to);
$tpl->assign('COMMISSION_RATE', $commission_rate);
$tpl->assign('AUTHOR_RATE', $author_rate);
$tpl->assign('MODULE_NAME', $module_name);
$tpl->assign('FORM_ACTION', NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=finance');

$contents = $tpl->fetch('finance.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';

/**
 * Xuất báo cáo tài chính ra Excel
 */
function exportFinanceToExcel($db, $module_data, $where_time, $commission_rate, $author_rate)
{
    global $db_config;


    $sql = "SELECT
                COUNT(*) as total_orders,
                SUM(amount) as total_revenue,
                SUM(ROUND(amount * " . ($author_rate / 100) . ", 2)) as author_commission,
                SUM(ROUND(amount * " . ($commission_rate / 100) . ", 2)) as website_commission
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases
            WHERE status = 'completed'" . $where_time;
    $overview = $db->query($sql)->fetch();


    $sql = "SELECT
                p.id, p.transaction_id, p.amount, p.payment_time,
                s.title as source_title,
                u.username, u.first_name, u.last_name,
                ROUND(p.amount * " . ($author_rate / 100) . ", 2) as author_earnings,
                ROUND(p.amount * " . ($commission_rate / 100) . ", 2) as website_earnings
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_purchases p
            INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON p.source_id = s.id
            INNER JOIN " . NV_USERS_GLOBALTABLE . " u ON s.userid = u.userid
            WHERE p.status = 'completed'" . $where_time . "
            ORDER BY p.payment_time DESC";

    $result = $db->query($sql);
    $transactions = [];
    while ($row = $result->fetch()) {
        $transactions[] = $row;
    }

    $csv_content = "\xEF\xBB\xBF";


    $csv_content .= "BÁO CÁO TÀI CHÍNH SHARECODE\n";
    $csv_content .= "Thời gian xuất: " . date('d/m/Y H:i:s') . "\n";
    $csv_content .= "Khoảng thời gian: " . ($where_time ? "Có lọc" : "Tất cả") . "\n\n";

    $csv_content .= "TỔNG QUAN:\n";
    $csv_content .= "Tổng đơn hàng," . ($overview['total_orders'] ?: 0) . "\n";
    $csv_content .= "Tổng doanh thu," . number_format($overview['total_revenue'] ?: 0) . " VNĐ\n";
    $csv_content .= "Tác giả nhận (" . $author_rate . "%)," . number_format($overview['author_commission'] ?: 0) . " VNĐ\n";
    $csv_content .= "Website giữ (" . $commission_rate . "%)," . number_format($overview['website_commission'] ?: 0) . " VNĐ\n\n";


    $csv_content .= "CHI TIẾT GIAO DỊCH:\n";
    $headers = [
        'Mã đơn hàng',
        'Mã giao dịch',
        'Tác giả',
        'Sản phẩm',
        'Số tiền',
        'Tác giả nhận',
        'Website giữ',
        'Thời gian thanh toán'
    ];

    $csv_content .= implode(',', array_map(function ($header) {
        return '"' . str_replace('"', '""', $header) . '"';
    }, $headers)) . "\n";

    foreach ($transactions as $transaction) {
        $row = [
            $transaction['id'],
            $transaction['transaction_id'] ?: '',
            trim($transaction['first_name'] . ' ' . $transaction['last_name']) ?: $transaction['username'],
            $transaction['source_title'],
            number_format($transaction['amount']) . ' VNĐ',
            number_format($transaction['author_earnings']) . ' VNĐ',
            number_format($transaction['website_earnings']) . ' VNĐ',
            date('d/m/Y H:i:s', $transaction['payment_time'])
        ];

        $csv_content .= implode(',', array_map(function ($field) {
            return '"' . str_replace('"', '""', $field) . '"';
        }, $row)) . "\n";
    }


    $filename = 'bao_cao_tai_chinh_' . date('Y-m-d_H-i-s') . '.csv';


    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . $filename . '"');
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
    header('Pragma: public');
    header('Content-Length: ' . strlen($csv_content));


    echo $csv_content;
}
