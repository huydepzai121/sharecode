<!-- BEGIN: main -->
<div class="revenue-page">
    <div class="page-header">
        <h1><i class="fa fa-chart-line"></i> Doanh thu bán code</h1>
        <p class="text-muted">Thống kê doanh thu và hiệu quả bán hàng của bạn</p>
    </div>

    <!-- Time Filter -->
    <div class="card mb-4">
        <div class="card-body">
            <form method="get" class="row align-items-end">
                <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}">
                <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}">
                <input type="hidden" name="{NV_OP_VARIABLE}" value="revenue">
                
                <div class="col-md-4">
                    <label class="form-label">Thời gian:</label>
                    <select name="time" class="form-select" onchange="toggleCustomTime(this.value)">
                        <!-- BEGIN: time_option -->
                        <option value="{TIME_OPTION.value}" {TIME_OPTION.selected}>{TIME_OPTION.text}</option>
                        <!-- END: time_option -->
                    </select>
                </div>
                
                <div class="col-md-2" id="year-select" style="display: {TIME_FILTER == 'custom' ? 'block' : 'none'}">
                    <label class="form-label">Năm:</label>
                    <select name="year" class="form-select">
                        <option value="2024" {YEAR == 2024 ? 'selected' : ''}>2024</option>
                        <option value="2025" {YEAR == 2025 ? 'selected' : ''}>2025</option>
                    </select>
                </div>
                
                <div class="col-md-2" id="month-select" style="display: {TIME_FILTER == 'custom' ? 'block' : 'none'}">
                    <label class="form-label">Tháng:</label>
                    <select name="month" class="form-select">
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
                
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-filter"></i> Lọc
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">{STATS.total_sales}</h4>
                            <p class="mb-0">Tổng đơn hàng</p>
                        </div>
                        <div class="align-self-center">
                            <i class="fa fa-shopping-cart fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-success text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">{STATS.total_revenue_format}</h4>
                            <p class="mb-0">Tổng doanh thu</p>
                        </div>
                        <div class="align-self-center">
                            <i class="fa fa-money-bill fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-info text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">{STATS.total_commission_format}</h4>
                            <p class="mb-0">Hoa hồng ({COMMISSION_RATE}%)</p>
                        </div>
                        <div class="align-self-center">
                            <i class="fa fa-percentage fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-3">
            <div class="card bg-warning text-white">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="mb-0">{STATS.avg_order_value_format}</h4>
                            <p class="mb-0">Giá trị TB/đơn</p>
                        </div>
                        <div class="align-self-center">
                            <i class="fa fa-calculator fa-2x"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Revenue Chart -->
    <div class="card mb-4">
        <div class="card-header">
            <h5><i class="fa fa-chart-area"></i> Biểu đồ doanh thu 30 ngày gần nhất</h5>
        </div>
        <div class="card-body">
            <canvas id="revenueChart" height="100"></canvas>
        </div>
    </div>

    <!-- Top Products -->
    <div class="card mb-4">
        <div class="card-header">
            <h5><i class="fa fa-trophy"></i> Sản phẩm bán chạy</h5>
        </div>
        <div class="card-body">
            <!-- BEGIN: products -->
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Giá</th>
                            <th>Đã bán</th>
                            <th>Doanh thu</th>
                            <th>Hoa hồng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: product -->
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="{PRODUCT.image_url}" alt="{PRODUCT.title}" class="me-3" style="width: 50px; height: 50px; object-fit: cover;">
                                    <div>
                                        <a href="{PRODUCT.link}" class="text-decoration-none">
                                            <strong>{PRODUCT.title}</strong>
                                        </a>
                                    </div>
                                </div>
                            </td>
                            <td>{PRODUCT.price_format}</td>
                            <td><span class="badge bg-primary">{PRODUCT.sales_count}</span></td>
                            <td><strong class="text-success">{PRODUCT.revenue_format}</strong></td>
                            <td><strong class="text-info">{PRODUCT.commission_format}</strong></td>
                        </tr>
                        <!-- END: product -->
                    </tbody>
                </table>
            </div>
            <!-- END: products -->
            
            <!-- BEGIN: no_products -->
            <div class="text-center py-4">
                <i class="fa fa-box-open fa-3x text-muted mb-3"></i>
                <p class="text-muted">Chưa có sản phẩm nào được bán trong khoảng thời gian này</p>
            </div>
            <!-- END: no_products -->
        </div>
    </div>

    <!-- Recent Transactions -->
    <div class="card">
        <div class="card-header">
            <h5><i class="fa fa-history"></i> Lịch sử giao dịch</h5>
        </div>
        <div class="card-body">
            <!-- BEGIN: transactions -->
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Mã GD</th>
                            <th>Sản phẩm</th>
                            <th>Người mua</th>
                            <th>Thời gian</th>
                            <th>Số tiền</th>
                            <th>Hoa hồng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: transaction -->
                        <tr>
                            <td><code>#{TRANSACTION.id}</code></td>
                            <td>
                                <a href="{TRANSACTION.source_link}" class="text-decoration-none">
                                    {TRANSACTION.source_title}
                                </a>
                            </td>
                            <td>{TRANSACTION.buyer_username}</td>
                            <td>{TRANSACTION.payment_time_format}</td>
                            <td><strong class="text-success">{TRANSACTION.amount_format}</strong></td>
                            <td><strong class="text-info">{TRANSACTION.author_commission_format}</strong></td>
                        </tr>
                        <!-- END: transaction -->
                    </tbody>
                </table>
            </div>
            
            <!-- BEGIN: pagination -->
            <div class="text-center mt-3">
                {PAGINATION}
            </div>
            <!-- END: pagination -->
            <!-- END: transactions -->
            
            <!-- BEGIN: no_transactions -->
            <div class="text-center py-4">
                <i class="fa fa-receipt fa-3x text-muted mb-3"></i>
                <p class="text-muted">Chưa có giao dịch nào trong khoảng thời gian này</p>
            </div>
            <!-- END: no_transactions -->
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
function toggleCustomTime(value) {
    const yearSelect = document.getElementById('year-select');
    const monthSelect = document.getElementById('month-select');
    
    if (value === 'custom') {
        yearSelect.style.display = 'block';
        monthSelect.style.display = 'block';
    } else {
        yearSelect.style.display = 'none';
        monthSelect.style.display = 'none';
    }
}

// Revenue Chart
const chartData = {CHART_DATA};
const ctx = document.getElementById('revenueChart').getContext('2d');

new Chart(ctx, {
    type: 'line',
    data: {
        labels: chartData.map(item => item.date_format),
        datasets: [{
            label: 'Doanh thu',
            data: chartData.map(item => item.revenue),
            borderColor: 'rgb(75, 192, 192)',
            backgroundColor: 'rgba(75, 192, 192, 0.1)',
            tension: 0.1,
            fill: true
        }, {
            label: 'Hoa hồng',
            data: chartData.map(item => item.commission),
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
                text: 'Doanh thu và hoa hồng theo ngày'
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
.revenue-page .card {
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    border: 1px solid rgba(0, 0, 0, 0.125);
}

.revenue-page .page-header {
    margin-bottom: 2rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #dee2e6;
}

.revenue-page .page-header h1 {
    color: #495057;
    font-weight: 600;
}
</style>
<!-- END: main -->
