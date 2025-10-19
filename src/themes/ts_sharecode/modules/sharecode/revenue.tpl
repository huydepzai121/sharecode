<!-- BEGIN: main -->
<div class="search-results-section">
    <div class="container">
        <div class="revenue-page">
        <div class="page-header">
            <h1><i class="fa fa-line-chart"></i> Doanh thu bán code</h1>
            <p class="text-muted">Thống kê doanh thu và hiệu quả bán hàng của bạn</p>
        </div>

        <div class="panel panel-default">
            <div class="panel-body">
                <form method="get" class="form-inline">
                    <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}">
                    <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}">
                    <input type="hidden" name="{NV_OP_VARIABLE}" value="revenue">

                    <div class="form-group">
                        <label for="time">Thời gian:</label>
                        <select name="time" class="form-control" onchange="toggleCustomTime(this.value)">
                            <option value="{TIME_OPTION.value}" {TIME_OPTION.selected}>{TIME_OPTION.text}</option>
                        </select>
                    </div>

                    <div class="form-group" id="year-select" style="display: {TIME_FILTER == 'custom' ? 'inline-block' : 'none'}; margin-left: 10px;">
                        <label for="year">Năm:</label>
                        <select name="year" class="form-control">
                            <option value="2024" {YEAR == 2024 ? 'selected' : ''}>2024</option>
                            <option value="2025" {YEAR == 2025 ? 'selected' : ''}>2025</option>
                        </select>
                    </div>

                    <div class="form-group" id="month-select" style="display: {TIME_FILTER == 'custom' ? 'inline-block' : 'none'}; margin-left: 10px;">
                        <label for="month">Tháng:</label>
                        <select name="month" class="form-control">
                            <option value="1" {MONTH == 1 ? 'selected' : ''}>Tháng 1</option>
                            <option value="2" {MONTH == 2 ? 'selected' : ''}>Tháng 2</option>
                            <option value="3" {MONTH == 3 ? 'selected' : ''}>Tháng 3</option>
                            <option value="4" {MONTH == 4 ? 'selected' : ''}>Tháng 4</option>
                            <option value="5" {MONTH == 5 ? 'selected' : ''}>Tháng 5</option>
                            <option value="6" {MONTH == 6 ? 'selected' : ''}>Tháng 6</option>
                            <option value="7" {MONTH == 7 ? 'selected' : ''}>Tháng 7</option>
                            <option value="8" {MONTH == 8 ? 'selected' : ''}>Tháng 8</option>
                            <option value="9" {MONTH == 9 ? 'selected' : ''}>Tháng 9</option>
                            <option value="10" {MONTH == 10 ? 'selected' : ''}>Tháng 10</option>
                            <option value="11" {MONTH == 11 ? 'selected' : ''}>Tháng 11</option>
                            <option value="12" {MONTH == 12 ? 'selected' : ''}>Tháng 12</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary" name="filter" style="margin-left: 10px;">
                        <i class="fa fa-filter"></i> Lọc
                    </button>
                </form>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-6 col-md-6">
                <div class="stats-box bg-primary">
                    <div class="stats-content">
                        <div class="stats-number">{STATS.total_sales}</div>
                        <div class="stats-label">Tổng đơn hàng</div>
                    </div>
                    <div class="stats-icon">
                        <i class="fa fa-shopping-cart"></i>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-6">
                <div class="stats-box bg-success">
                    <div class="stats-content">
                        <div class="stats-number">{STATS.total_revenue_format}</div>
                        <div class="stats-label">Tác giả nhận ({AUTHOR_RATE}%)</div>
                    </div>
                    <div class="stats-icon">
                        <i class="fa fa-money"></i>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-6">
                <div class="stats-box bg-info">
                    <div class="stats-content">
                        <div class="stats-number">{STATS.total_commission_format}</div>
                        <div class="stats-label">Website giữ ({COMMISSION_RATE}%)</div>
                    </div>
                    <div class="stats-icon">
                        <i class="fa fa-percent"></i>
                    </div>
                </div>
            </div>

            <div class="col-sm-6 col-md-6">
                <div class="stats-box bg-warning">
                    <div class="stats-content">
                        <div class="stats-number">{STATS.avg_order_value_format}</div>
                        <div class="stats-label">TB tác giả nhận/đơn</div>
                    </div>
                    <div class="stats-icon">
                        <i class="fa fa-calculator"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-area-chart"></i> Biểu đồ doanh thu 30 ngày gần nhất</h3>
            </div>
            <div class="panel-body">
                <canvas id="revenueChart" height="100"></canvas>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-trophy"></i> Sản phẩm bán chạy</h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Giá</th>
                            <th>Đã bán</th>
                            <th>Tác giả nhận</th>
                            <th>Website giữ</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <div class="media">
                                    <div class="media-left">
                                        <img src="{PRODUCT.image_url}" alt="{PRODUCT.title}" class="media-object" style="width: 50px; height: 50px; object-fit: cover;">
                                    </div>
                                    <div class="media-body">
                                        <a href="{PRODUCT.link}" class="media-heading">
                                            <strong>{PRODUCT.title}</strong>
                                        </a>
                                    </div>
                                </div>
                            </td>
                            <td>{PRODUCT.price_format}</td>
                            <td><span class="label label-primary">{PRODUCT.sales_count}</span></td>
                            <td><strong class="text-success">{PRODUCT.revenue_format}</strong></td>
                            <td><strong class="text-info">{PRODUCT.commission_format}</strong></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="empty-state">
                    <i class="fa fa-inbox fa-4x"></i>
                    <p>Chưa có sản phẩm nào được bán trong khoảng thời gian này</p>
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-history"></i> Lịch sử giao dịch</h3>
            </div>
            <div class="panel-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>Mã GD</th>
                            <th>Sản phẩm</th>
                            <th>Người mua</th>
                            <th>Thời gian</th>
                            <th>Số tiền</th>
                            <th>Tác giả nhận</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><code>#{TRANSACTION.id}</code></td>
                            <td>
                                <a href="{TRANSACTION.source_link}">
                                    {TRANSACTION.source_title}
                                </a>
                            </td>
                            <td>{TRANSACTION.buyer_username}</td>
                            <td>{TRANSACTION.payment_time_format}</td>
                            <td><strong class="text-success">{TRANSACTION.amount_format}</strong></td>
                            <td><strong class="text-info">{TRANSACTION.author_commission_format}</strong></td>
                        </tr>
                        </tbody>
                    </table>
                </div>

                <div class="text-center" style="margin-top: 20px;">
                    {PAGINATION}
                </div>
                <div class="empty-state">
                    <i class="fa fa-file-text-o fa-4x"></i>
                    <p>Chưa có giao dịch nào trong khoảng thời gian này</p>
                </div>
            </div>
        </div>
        </div>
    </div>
</div>

<script src="{ASSETS_STATIC_URL}/js/chart/chart.js"></script>
<script>
function toggleCustomTime(value) {
    var yearSelect = document.getElementById('year-select');
    var monthSelect = document.getElementById('month-select');

    if (value === 'custom') {
        yearSelect.style.display = 'inline-block';
        monthSelect.style.display = 'inline-block';
    } else {
        yearSelect.style.display = 'none';
        monthSelect.style.display = 'none';
    }
}

// Revenue Chart
var chartData = {CHART_DATA};
var ctx = document.getElementById('revenueChart').getContext('2d');

new Chart(ctx, {
    type: 'line',
    data: {
        labels: chartData.map(function(item) { return item.date_format; }),
        datasets: [{
            label: 'Tác giả nhận',
            data: chartData.map(function(item) { return item.revenue; }),
            borderColor: 'rgb(75, 192, 192)',
            backgroundColor: 'rgba(75, 192, 192, 0.1)',
            tension: 0.1,
            fill: true
        }, {
            label: 'Website giữ',
            data: chartData.map(function(item) { return item.commission; }),
            borderColor: 'rgb(255, 99, 132)',
            backgroundColor: 'rgba(255, 99, 132, 0.1)',
            tension: 0.1,
            fill: true
        }]
    },
    options: {
        responsive: true,
        plugins: {
            title: {
                display: true,
                text: 'Tác giả nhận và Website giữ theo ngày'
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    callback: function(value) {
                        return new Intl.NumberFormat('vi-VN').format(value) + ' VNĐ';
                    }
                }
            }
        }
    }
});
</script>

<style>
/* CSS Variables for consistency */
:root {
    --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --success-gradient: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    --info-gradient: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
    --warning-gradient: linear-gradient(135deg, #ffc107 0%, #ff9800 100%);
    --card-shadow: 0 4px 20px rgba(0,0,0,0.08);
    --hover-shadow: 0 8px 30px rgba(0,0,0,0.15);
    --border-radius-small: 6px;
    --border-radius-medium: 8px;
    --border-radius-large: 12px;
    --transition-smooth: cubic-bezier(0.4, 0, 0.2, 1);
}

/* Page Header */
.revenue-page .page-header {
    margin-bottom: 30px;
    padding: 40px 30px;
    background: #ffffff;
    border: 1px solid #e9ecef;
    border-radius: var(--border-radius-large);
    box-shadow: var(--card-shadow);
    margin-top: 0;
}

.revenue-page .page-header h1 {
    color: #2c3e50;
    font-weight: 700;
    margin: 0;
    font-size: 32px;
}

.revenue-page .page-header p {
    color: #6c757d;
    margin: 8px 0 0 0;
    font-size: 16px;
}

/* Stats Boxes */
.stats-box {
    background: white;
    border-radius: var(--border-radius-large);
    padding: 25px 20px;
    margin-bottom: 20px;
    box-shadow: var(--card-shadow);
    position: relative;
    overflow: hidden;
    transition: transform 0.3s var(--transition-smooth), box-shadow 0.3s var(--transition-smooth);
    border: none;
}

.stats-box:hover {
    transform: translateY(-5px);
    box-shadow: var(--hover-shadow);
}

.stats-box::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
}

.stats-box.bg-primary::before {
    background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
}
.stats-box.bg-success::before {
    background: linear-gradient(90deg, #28a745 0%, #20c997 100%);
}
.stats-box.bg-info::before {
    background: linear-gradient(90deg, #17a2b8 0%, #138496 100%);
}
.stats-box.bg-warning::before {
    background: linear-gradient(90deg, #ffc107 0%, #ff9800 100%);
}

.stats-content {
    position: relative;
    z-index: 2;
}

.stats-number {
    font-size: 28px;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 8px;
}

.stats-label {
    font-size: 13px;
    color: #6c757d;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-weight: 600;
}

.stats-icon {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
    opacity: 0.15;
    z-index: 1;
}

.stats-icon i {
    font-size: 56px;
}

.stats-box.bg-primary .stats-icon i { color: #667eea; }
.stats-box.bg-success .stats-icon i { color: #28a745; }
.stats-box.bg-info .stats-icon i { color: #17a2b8; }
.stats-box.bg-warning .stats-icon i { color: #ffc107; }

/* Panel Improvements */
.revenue-page .panel {
    background: white;
    border: none;
    border-radius: var(--border-radius-large);
    box-shadow: var(--card-shadow);
    margin-bottom: 30px;
    overflow: hidden;
}

.revenue-page .panel-heading {
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
    color: #2c3e50;
    border: none;
    padding: 18px 25px;
}

.revenue-page .panel-title {
    font-weight: 700;
    color: #2c3e50;
    font-size: 18px;
    margin: 0;
}

.revenue-page .panel-title i {
    margin-right: 8px;
}

.revenue-page .panel-body {
    padding: 25px;
}

/* Chart Container */
.revenue-page .panel-body canvas {
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
    border-radius: var(--border-radius-medium);
    padding: 15px;
}

/* Table Improvements */
.revenue-page .table {
    margin-bottom: 0;
    border-collapse: separate;
    border-spacing: 0;
}

.revenue-page .table th {
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
    color: #2c3e50;
    border: none;
    border-bottom: 2px solid #e9ecef;
    font-weight: 700;
    text-transform: uppercase;
    font-size: 11px;
    letter-spacing: 1px;
    padding: 16px 14px;
    white-space: nowrap;
}

.revenue-page .table td {
    vertical-align: middle;
    border-top: 1px solid #f1f3f4;
    padding: 16px 14px;
    font-size: 14px;
    color: #495057;
}

.revenue-page .table-hover tbody tr {
    transition: all 0.3s var(--transition-smooth);
    cursor: pointer;
}

.revenue-page .table-hover tbody tr:hover {
    background: #f8f9fa;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

/* Table specific styles */
.revenue-page .table .media {
    display: flex;
    align-items: center;
    gap: 12px;
}

.revenue-page .table .media-left {
    flex-shrink: 0;
}

.revenue-page .table .media-object {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 8px;
    border: 2px solid #e9ecef;
    transition: all 0.3s ease;
}

.revenue-page .table .media-object:hover {
    transform: scale(1.1);
    border-color: #007bff;
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.2);
}

.revenue-page .table .media-body {
    flex: 1;
    min-width: 0;
}

.revenue-page .table .media-heading {
    color: #2c3e50;
    font-size: 14px;
    font-weight: 600;
    line-height: 1.4;
    transition: color 0.3s ease;
}

.revenue-page .table .media-heading:hover {
    color: #007bff;
}

.revenue-page .table code {
    background: #f8f9fa;
    color: #007bff;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 12px;
    font-weight: 600;
    border: 1px solid #e9ecef;
}

.revenue-page .table .label {
    padding: 6px 12px;
    border-radius: 12px;
    font-size: 12px;
    font-weight: 600;
}

.revenue-page .table .label-primary {
    background: #007bff;
    color: white;
}

.revenue-page .table .text-success {
    color: #28a745;
    font-weight: 700;
    font-size: 14px;
}

.revenue-page .table .text-info {
    color: #17a2b8;
    font-weight: 700;
    font-size: 14px;
}

/* Table Responsive Wrapper */
.revenue-page .table-responsive {
    border-radius: var(--border-radius-medium);
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.revenue-page .table-responsive::-webkit-scrollbar {
    height: 8px;
}

.revenue-page .table-responsive::-webkit-scrollbar-track {
    background: #f1f3f4;
    border-radius: 4px;
}

.revenue-page .table-responsive::-webkit-scrollbar-thumb {
    background: #cbd5e0;
    border-radius: 4px;
}

.revenue-page .table-responsive::-webkit-scrollbar-thumb:hover {
    background: #a0aec0;
}

/* Form Improvements */
.revenue-page .form-inline .form-group {
    margin-right: 15px;
}

.revenue-page .form-control {
    border-radius: var(--border-radius-small);
    border: 2px solid #e9ecef;
    padding: 10px 15px;
    transition: all 0.3s var(--transition-smooth);
    background: #f8f9fa;
}

.revenue-page .form-control:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
    outline: none;
    background: white;
}

.revenue-page .btn {
    border-radius: var(--border-radius-small);
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-size: 13px;
    padding: 10px 20px;
    transition: all 0.3s var(--transition-smooth);
}

.revenue-page .btn-primary {
    background: #007bff;
    border: 1px solid #007bff;
    color: white;
}

.revenue-page .btn-primary:hover {
    background: #0056b3;
    border-color: #0056b3;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
}

/* Empty States */
.revenue-page .empty-state {
    text-align: center;
    padding: 80px 20px;
    color: #6c757d;
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
    border-radius: var(--border-radius-large);
}

.revenue-page .empty-state i {
    margin-bottom: 25px;
    opacity: 0.3;
    color: #667eea;
}

.revenue-page .empty-state p {
    font-size: 16px;
    margin: 0;
    color: #6c757d;
}

/* Responsive */
@media (max-width: 768px) {
    .revenue-page .page-header {
        padding: 30px 20px;
    }

    .revenue-page .page-header h1 {
        font-size: 24px;
    }

    .revenue-page .stats-box {
        margin-bottom: 20px;
    }

    .revenue-page .stats-number {
        font-size: 22px;
    }

    .revenue-page .stats-icon {
        display: none;
    }

    .revenue-page .form-inline .form-group {
        display: block;
        margin-bottom: 10px;
        margin-right: 0;
    }

    .revenue-page .panel-title {
        font-size: 16px;
    }

    .revenue-page .panel-body {
        padding: 20px 15px;
    }

    .revenue-page .table th,
    .revenue-page .table td {
        padding: 12px 8px;
        font-size: 13px;
    }

    .revenue-page .table th {
        font-size: 10px;
    }

    .revenue-page .table .media-object {
        width: 50px;
        height: 50px;
    }

    .revenue-page .table .media-heading {
        font-size: 13px;
    }
}

@media (max-width: 480px) {
    .revenue-page .page-header {
        padding: 25px 15px;
    }

    .revenue-page .page-header h1 {
        font-size: 20px;
    }

    .revenue-page .stats-number {
        font-size: 20px;
    }

    .revenue-page .panel-title {
        font-size: 15px;
    }

    .revenue-page .table th,
    .revenue-page .table td {
        padding: 10px 6px;
        font-size: 12px;
    }

    .revenue-page .table .media {
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
    }

    .revenue-page .table .media-object {
        width: 100%;
        height: auto;
        max-width: 200px;
    }
}
</style>
<!-- END: main -->
