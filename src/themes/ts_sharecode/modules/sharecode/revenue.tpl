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
.revenue-page .panel {
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    border: 1px solid #e3e3e3;
    border-radius: 6px;
    margin-bottom: 20px;
}

.revenue-page .page-header {
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 2px solid #f0f0f0;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 30px 20px;
    border-radius: 8px;
    margin-top: -15px;
}

.revenue-page .page-header h1 {
    color: white;
    font-weight: 300;
    margin: 0;
    font-size: 28px;
}

.revenue-page .page-header p {
    color: rgba(255,255,255,0.9);
    margin: 5px 0 0 0;
}

/* Stats Boxes */
.stats-box {
    background: white;
    border-radius: 8px;
    padding: 25px 20px;
    margin-bottom: 20px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    position: relative;
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.stats-box:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.stats-box::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 4px;
}

.stats-box.bg-primary::before { background: #3498db; }
.stats-box.bg-success::before { background: #2ecc71; }
.stats-box.bg-info::before { background: #1abc9c; }
.stats-box.bg-warning::before { background: #f39c12; }

.stats-content {
    position: relative;
    z-index: 2;
}

.stats-number {
    font-size: 24px;
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 5px;
}

.stats-label {
    font-size: 14px;
    color: #7f8c8d;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.stats-icon {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
    opacity: 0.1;
    z-index: 1;
}

.stats-icon i {
    font-size: 48px;
}

.stats-box.bg-primary .stats-icon i { color: #3498db; }
.stats-box.bg-success .stats-icon i { color: #2ecc71; }
.stats-box.bg-info .stats-icon i { color: #1abc9c; }
.stats-box.bg-warning .stats-icon i { color: #f39c12; }

/* Panel Improvements */
.revenue-page .panel-heading {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    border-bottom: 1px solid #dee2e6;
    padding: 15px 20px;
}

.revenue-page .panel-title {
    font-weight: 600;
    color: #495057;
    font-size: 16px;
}

.revenue-page .panel-body {
    padding: 20px;
}

/* Table Improvements */
.revenue-page .table {
    margin-bottom: 0;
}

.revenue-page .table th {
    background-color: #f8f9fa;
    border-bottom: 2px solid #dee2e6;
    font-weight: 600;
    color: #495057;
    text-transform: uppercase;
    font-size: 12px;
    letter-spacing: 0.5px;
}

.revenue-page .table td {
    vertical-align: middle;
    border-top: 1px solid #f1f3f4;
}

.revenue-page .table-hover tbody tr:hover {
    background-color: #f8f9fa;
}

/* Media Object */
.revenue-page .media-object {
    border-radius: 6px;
    border: 2px solid #f1f3f4;
}

/* Form Improvements */
.revenue-page .form-inline .form-group {
    margin-right: 15px;
}

.revenue-page .form-control {
    border-radius: 4px;
    border: 1px solid #ced4da;
}

.revenue-page .btn {
    border-radius: 4px;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-size: 12px;
}

/* Empty States */
.revenue-page .empty-state {
    text-align: center;
    padding: 60px 20px;
    color: #6c757d;
}

.revenue-page .empty-state i {
    margin-bottom: 20px;
    opacity: 0.5;
}

.revenue-page .empty-state p {
    font-size: 16px;
    margin: 0;
}

/* Responsive */
@media (max-width: 768px) {
    .revenue-page .stats-box {
        margin-bottom: 15px;
    }

    .revenue-page .stats-number {
        font-size: 20px;
    }

    .revenue-page .stats-icon {
        display: none;
    }

    .revenue-page .form-inline .form-group {
        display: block;
        margin-bottom: 10px;
        margin-right: 0;
    }
}
</style>
