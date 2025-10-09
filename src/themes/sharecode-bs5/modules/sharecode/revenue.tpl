<!-- BEGIN: main -->
<div class="revenue-page py-4">
    <div class="container">
        <!-- Page Header -->
        <div class="page-header mb-5" data-aos="fade-down" data-aos-duration="800">
            <div class="row align-items-center">
                <div class="col-12">
                    <div class="d-flex align-items-center">
                        <div class="header-icon me-3">
                            <i class="fa fa-line-chart fa-2x text-primary"></i>
                        </div>
                        <div>
                            <h1 class="h2 fw-bold text-dark mb-1">Doanh thu bán code</h1>
                            <p class="text-muted mb-0">Thống kê doanh thu và hiệu quả bán hàng của bạn</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Filter Form -->
        <div class="filter-section mb-5" data-aos="fade-up" data-aos-duration="600">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-4">
                    <form method="get" class="row g-3 align-items-end">
                        <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}">
                        <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}">
                        <input type="hidden" name="{NV_OP_VARIABLE}" value="revenue">

                        <div class="col-12 col-md-3">
                            <label for="time" class="form-label fw-semibold">Thời gian:</label>
                            <select name="time" class="form-select" onchange="toggleCustomTime(this.value)">
                                <option value="{TIME_OPTION.value}" {TIME_OPTION.selected}>{TIME_OPTION.text}</option>
                            </select>
                        </div>

                        <div class="col-12 col-md-2" id="year-select" style="display: {TIME_FILTER == 'custom' ? 'block' : 'none'};">
                            <label for="year" class="form-label fw-semibold">Năm:</label>
                            <select name="year" class="form-select">
                                <option value="2024" {YEAR == 2024 ? 'selected' : ''}>2024</option>
                                <option value="2025" {YEAR == 2025 ? 'selected' : ''}>2025</option>
                            </select>
                        </div>

                        <div class="col-12 col-md-3" id="month-select" style="display: {TIME_FILTER == 'custom' ? 'block' : 'none'};">
                            <label for="month" class="form-label fw-semibold">Tháng:</label>
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

                        <div class="col-12 col-md-2">
                            <button type="submit" class="btn btn-primary w-100" name="filter">
                                <i class="fa fa-filter me-2"></i> Lọc
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="stats-section mb-5">
            <div class="row g-4">
                <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-duration="600" data-aos-delay="100">
                    <div class="stats-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="stats-icon mb-3">
                                <i class="fa fa-shopping-cart fa-2x text-primary"></i>
                            </div>
                            <div class="stats-content">
                                <div class="stats-number h3 fw-bold text-dark mb-1">{STATS.total_sales}</div>
                                <div class="stats-label text-muted small">Tổng đơn hàng</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-duration="600" data-aos-delay="200">
                    <div class="stats-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="stats-icon mb-3">
                                <i class="fa fa-money fa-2x text-success"></i>
                            </div>
                            <div class="stats-content">
                                <div class="stats-number h3 fw-bold text-dark mb-1">{STATS.total_revenue_format}</div>
                                <div class="stats-label text-muted small">Tác giả nhận ({AUTHOR_RATE}%)</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-duration="600" data-aos-delay="300">
                    <div class="stats-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="stats-icon mb-3">
                                <i class="fa fa-percent fa-2x text-info"></i>
                            </div>
                            <div class="stats-content">
                                <div class="stats-number h3 fw-bold text-dark mb-1">{STATS.total_commission_format}</div>
                                <div class="stats-label text-muted small">Website giữ ({COMMISSION_RATE}%)</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-duration="600" data-aos-delay="400">
                    <div class="stats-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="stats-icon mb-3">
                                <i class="fa fa-calculator fa-2x text-warning"></i>
                            </div>
                            <div class="stats-content">
                                <div class="stats-number h3 fw-bold text-dark mb-1">{STATS.avg_order_value_format}</div>
                                <div class="stats-label text-muted small">TB tác giả nhận/đơn</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Revenue Chart -->
        <div class="chart-section mb-5" data-aos="fade-up" data-aos-duration="600">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="fa fa-area-chart text-primary me-2"></i>
                        Biểu đồ doanh thu 30 ngày gần nhất
                    </h5>
                </div>
                <div class="card-body p-4">
                    <canvas id="revenueChart" height="100"></canvas>
                </div>
            </div>
        </div>

        <!-- Best Selling Products -->
        <!-- BEGIN: products -->
        <div class="products-section mb-5" data-aos="fade-up" data-aos-duration="600">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="fa fa-trophy text-warning me-2"></i>
                        Sản phẩm bán chạy
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="border-0 fw-semibold">Sản phẩm</th>
                                    <th class="border-0 fw-semibold">Giá</th>
                                    <th class="border-0 fw-semibold">Đã bán</th>
                                    <th class="border-0 fw-semibold">Tác giả nhận</th>
                                    <th class="border-0 fw-semibold">Website giữ</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- BEGIN: product -->
                                <tr>
                                    <td class="py-3">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0 me-3">
                                                <img src="{PRODUCT.image_url}" alt="{PRODUCT.title}"
                                                     class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
                                            </div>
                                            <div class="flex-grow-1">
                                                <a href="{PRODUCT.link}" class="text-decoration-none fw-semibold text-dark">
                                                    {PRODUCT.title}
                                                </a>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-3 fw-semibold">{PRODUCT.price_format}</td>
                                    <td class="py-3">
                                        <span class="badge bg-primary rounded-pill">{PRODUCT.sales_count}</span>
                                    </td>
                                    <td class="py-3">
                                        <strong class="text-success">{PRODUCT.revenue_format}</strong>
                                    </td>
                                    <td class="py-3">
                                        <strong class="text-info">{PRODUCT.commission_format}</strong>
                                    </td>
                                </tr>
                                <!-- END: product -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- END: products -->

        <!-- No Products Empty State -->
        <!-- BEGIN: no_products -->
        <div class="products-section mb-5" data-aos="fade-up" data-aos-duration="600">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="fa fa-trophy text-warning me-2"></i>
                        Sản phẩm bán chạy
                    </h5>
                </div>
                <div class="card-body text-center py-5">
                    <div class="empty-state">
                        <i class="fa fa-inbox display-1 text-muted opacity-50 mb-3"></i>
                        <p class="text-muted mb-0">Chưa có sản phẩm nào được bán trong khoảng thời gian này</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- END: no_products -->

        <!-- Transaction History -->
        <!-- BEGIN: transactions -->
        <div class="transactions-section mb-5" data-aos="fade-up" data-aos-duration="600">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="fa fa-history text-secondary me-2"></i>
                        Lịch sử giao dịch
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="border-0 fw-semibold">Mã GD</th>
                                    <th class="border-0 fw-semibold">Sản phẩm</th>
                                    <th class="border-0 fw-semibold">Người mua</th>
                                    <th class="border-0 fw-semibold">Thời gian</th>
                                    <th class="border-0 fw-semibold">Số tiền</th>
                                    <th class="border-0 fw-semibold">Tác giả nhận</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- BEGIN: transaction -->
                                <tr>
                                    <td class="py-3">
                                        <code class="bg-light px-2 py-1 rounded">#{TRANSACTION.id}</code>
                                    </td>
                                    <td class="py-3">
                                        <a href="{TRANSACTION.source_link}" class="text-decoration-none fw-semibold">
                                            {TRANSACTION.source_title}
                                        </a>
                                    </td>
                                    <td class="py-3">{TRANSACTION.buyer_username}</td>
                                    <td class="py-3 text-muted small">{TRANSACTION.payment_time_format}</td>
                                    <td class="py-3">
                                        <strong class="text-success">{TRANSACTION.amount_format}</strong>
                                    </td>
                                    <td class="py-3">
                                        <strong class="text-info">{TRANSACTION.author_commission_format}</strong>
                                    </td>
                                </tr>
                                <!-- END: transaction -->
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <!-- BEGIN: pagination -->
                <div class="card-footer bg-white border-0 text-center py-3">
                    {PAGINATION}
                </div>
                <!-- END: pagination -->
            </div>
        </div>
        <!-- END: transactions -->

        <!-- No Transactions Empty State -->
        <!-- BEGIN: no_transactions -->
        <div class="transactions-section mb-5" data-aos="fade-up" data-aos-duration="600">
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0 py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="fa fa-history text-secondary me-2"></i>
                        Lịch sử giao dịch
                    </h5>
                </div>
                <div class="card-body text-center py-5">
                    <div class="empty-state">
                        <i class="fa fa-file-text-o display-1 text-muted opacity-50 mb-3"></i>
                        <p class="text-muted mb-0">Chưa có giao dịch nào trong khoảng thời gian này</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- END: no_transactions -->
    </div>
</div>

<script src="{ASSETS_STATIC_URL}/js/chart/chart.js"></script>
<script>
// Revenue page functionality - AOS removed for better performance
document.addEventListener('DOMContentLoaded', function() {
    // AOS animations removed for better performance
});

function toggleCustomTime(value) {
    var yearSelect = document.getElementById('year-select');
    var monthSelect = document.getElementById('month-select');

    if (value === 'custom') {
        yearSelect.style.display = 'block';
        monthSelect.style.display = 'block';
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
/* ===== REVENUE PAGE STYLES - BOOTSTRAP 5 ===== */

/* Page Header */
.page-header {
    border-bottom: 1px solid rgba(0,0,0,0.08);
    padding-bottom: 2rem;
}

.header-icon {
    transition: all 0.3s ease;
}

.header-icon:hover {
    transform: scale(1.1);
}

/* Filter Section */
.filter-section .card {
    border-radius: 16px !important;
}

.filter-section .form-label {
    color: #495057;
    font-size: 0.875rem;
}

.filter-section .form-select {
    border-radius: 8px;
    border: 1px solid #ced4da;
    transition: all 0.3s ease;
}

.filter-section .form-select:focus {
    border-color: var(--bs-primary);
    box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
}

/* Stats Cards */
.stats-card {
    transition: all 0.3s ease;
    border-radius: 16px !important;
}

.stats-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
}

.stats-icon {
    transition: all 0.3s ease;
}

.stats-card:hover .stats-icon {
    transform: scale(1.1);
}

.stats-number {
    font-size: 1.5rem;
}

.stats-label {
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    font-weight: 600;
}

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

/* Responsive Design */
@media (max-width: 767.98px) {
    .page-header {
        text-align: center;
        padding-bottom: 1.5rem;
    }

    .header-icon {
        margin-bottom: 1rem;
    }

    .stats-number {
        font-size: 1.25rem;
    }

    .filter-section .row > div {
        margin-bottom: 1rem;
    }

    .table-responsive {
        font-size: 0.8rem;
    }

    .table th,
    .table td {
        padding: 0.5rem;
    }
}
</style>
<!-- END: main -->
