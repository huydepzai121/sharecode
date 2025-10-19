<div class="card">
    <div class="card-header text-bg-primary rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium">
            <i class="fa-solid fa-chart-line"></i> Quản lý tài chính
        </div>
        <div class="d-flex gap-2">
            <button type="button" class="btn btn-sm btn-light" onclick="exportFinanceReport()">
                <i class="fa-solid fa-download"></i> Xuất báo cáo
            </button>
        </div>
    </div>
    
    <div class="card-body">
        <!-- Bộ lọc thời gian -->
        <form method="get" action="{$FORM_ACTION}" class="row g-3 mb-4">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="finance">
            
            <div class="col-md-3">
                <label class="form-label">Thời gian</label>
                <select name="time" class="form-select" onchange="toggleCustomTime(this.value)">
                    {foreach from=$TIME_FILTERS key=key item=label}
                    <option value="{$key}" {if $TIME_FILTER == $key}selected{/if}>{$label}</option>
                    {/foreach}
                </select>
            </div>
            
            <div class="col-md-2" id="year-select" style="display: {if $TIME_FILTER == 'custom'}block{else}none{/if};">
                <label class="form-label">Năm</label>
                <select name="year" class="form-select">
                    {for $y=2020 to 2030}
                    <option value="{$y}" {if $YEAR == $y}selected{/if}>{$y}</option>
                    {/for}
                </select>
            </div>
            
            <div class="col-md-2" id="month-select" style="display: {if $TIME_FILTER == 'custom'}block{else}none{/if};">
                <label class="form-label">Tháng</label>
                <select name="month" class="form-select">
                    {for $m=1 to 12}
                    <option value="{$m}" {if $MONTH == $m}selected{/if}>Tháng {$m}</option>
                    {/for}
                </select>
            </div>
            
            <div class="col-md-2" id="date-from" style="display: {if $TIME_FILTER == 'custom'}block{else}none{/if};">
                <label class="form-label">Từ ngày</label>
                <input type="date" name="date_from" class="form-control" value="{$DATE_FROM}">
            </div>
            
            <div class="col-md-2" id="date-to" style="display: {if $TIME_FILTER == 'custom'}block{else}none{/if};">
                <label class="form-label">Đến ngày</label>
                <input type="date" name="date_to" class="form-control" value="{$DATE_TO}">
            </div>
            
            <div class="col-md-1 d-flex align-items-end">
                <button type="submit" class="btn btn-primary">
                    <i class="fa-solid fa-filter"></i> Lọc
                </button>
            </div>
        </form>

        <!-- Thống kê tổng quan -->
        <div class="row g-3 mb-4">
            <div class="col-lg-3 col-md-6">
                <div class="card border-0 bg-primary text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title mb-1">Tổng đơn hàng</h6>
                                <h3 class="mb-0">{$REVENUE_STATS.total_orders|default:0}</h3>
                            </div>
                            <div class="fs-1 opacity-50">
                                <i class="fa-solid fa-shopping-cart"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6">
                <div class="card border-0 bg-success text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title mb-1">Tổng doanh thu</h6>
                                <h3 class="mb-0">{$REVENUE_STATS.total_revenue_format|default:"0 VNĐ"}</h3>
                            </div>
                            <div class="fs-1 opacity-50">
                                <i class="fa-solid fa-money-bill-wave"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6">
                <div class="card border-0 bg-info text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title mb-1">Tác giả nhận ({$AUTHOR_RATE}%)</h6>
                                <h3 class="mb-0">{$REVENUE_STATS.author_commission_format|default:"0 VNĐ"}</h3>
                            </div>
                            <div class="fs-1 opacity-50">
                                <i class="fa-solid fa-user-tie"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-3 col-md-6">
                <div class="card border-0 bg-warning text-white">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="card-title mb-1">Website giữ ({$COMMISSION_RATE}%)</h6>
                                <h3 class="mb-0">{$REVENUE_STATS.website_commission_format|default:"0 VNĐ"}</h3>
                            </div>
                            <div class="fs-1 opacity-50">
                                <i class="fa-solid fa-building"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Biểu đồ doanh thu -->
        <div class="row g-3 mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fa-solid fa-chart-area"></i> Biểu đồ doanh thu 30 ngày gần nhất
                        </h5>
                    </div>
                    <div class="card-body">
                        <canvas id="revenueChart" height="100"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Top tác giả và sản phẩm -->
        <div class="row g-3">
            <!-- Top tác giả -->
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fa-solid fa-crown"></i> Top tác giả theo doanh thu
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        {if isset($TOP_AUTHORS) and !empty($TOP_AUTHORS)}
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Tác giả</th>
                                        <th class="text-end">Đơn hàng</th>
                                        <th class="text-end">Doanh thu</th>
                                        <th class="text-end">Hoa hồng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$TOP_AUTHORS item=author key=index}
                                    <tr>
                                        <td>
                                            {if $index == 0}
                                                <i class="fa-solid fa-trophy text-warning"></i>
                                            {elseif $index == 1}
                                                <i class="fa-solid fa-medal text-secondary"></i>
                                            {elseif $index == 2}
                                                <i class="fa-solid fa-award text-warning"></i>
                                            {else}
                                                {$index + 1}
                                            {/if}
                                        </td>
                                        <td>
                                            <div class="fw-medium">{$author.full_name|default:$author.username}</div>
                                            <small class="text-muted">@{$author.username}</small>
                                        </td>
                                        <td class="text-end">{$author.total_orders}</td>
                                        <td class="text-end fw-medium">{$author.total_revenue_format}</td>
                                        <td class="text-end text-success fw-medium">{$author.author_earnings_format}</td>
                                    </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                        {else}
                        <div class="text-center py-4">
                            <i class="fa-solid fa-inbox fa-2x text-muted mb-2"></i>
                            <div class="text-muted">Chưa có dữ liệu tác giả</div>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>

            <!-- Top sản phẩm -->
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fa-solid fa-fire"></i> Top sản phẩm bán chạy
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        {if isset($TOP_PRODUCTS) and !empty($TOP_PRODUCTS)}
                        <div class="table-responsive">
                            <table class="table table-hover mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th>#</th>
                                        <th>Sản phẩm</th>
                                        <th class="text-end">Bán</th>
                                        <th class="text-end">Doanh thu</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$TOP_PRODUCTS item=product key=index}
                                    <tr>
                                        <td>{$index + 1}</td>
                                        <td>
                                            <div class="fw-medium">
                                                <a href="{$product.product_url}" target="_blank" class="text-decoration-none">
                                                    {$product.title}
                                                </a>
                                            </div>
                                            <small class="text-muted">Giá: {$product.fee_amount_format}</small>
                                        </td>
                                        <td class="text-end">{$product.total_sales}</td>
                                        <td class="text-end fw-medium">{$product.total_revenue_format}</td>
                                    </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                        {else}
                        <div class="text-center py-4">
                            <i class="fa-solid fa-inbox fa-2x text-muted mb-2"></i>
                            <div class="text-muted">Chưa có dữ liệu sản phẩm</div>
                        </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="{$smarty.const.ASSETS_STATIC_URL}/js/chart/chart.js"></script>
<script>
// Toggle custom time inputs
function toggleCustomTime(value) {
    const customInputs = ['year-select', 'month-select', 'date-from', 'date-to'];
    customInputs.forEach(id => {
        document.getElementById(id).style.display = value === 'custom' ? 'block' : 'none';
    });
}

// Chart data
const chartData = {$CHART_DATA};

// Revenue Chart
const ctx = document.getElementById('revenueChart').getContext('2d');
new Chart(ctx, {
    type: 'line',
    data: {
        labels: chartData.map(item => item.date_format),
        datasets: [{
            label: 'Tổng doanh thu',
            data: chartData.map(item => item.revenue),
            borderColor: 'rgb(75, 192, 192)',
            backgroundColor: 'rgba(75, 192, 192, 0.1)',
            tension: 0.1,
            fill: true
        }, {
            label: 'Tác giả nhận',
            data: chartData.map(item => item.author_commission),
            borderColor: 'rgb(54, 162, 235)',
            backgroundColor: 'rgba(54, 162, 235, 0.1)',
            tension: 0.1,
            fill: true
        }, {
            label: 'Website giữ',
            data: chartData.map(item => item.website_commission),
            borderColor: 'rgb(255, 99, 132)',
            backgroundColor: 'rgba(255, 99, 132, 0.1)',
            tension: 0.1,
            fill: true
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            title: {
                display: false
            },
            legend: {
                position: 'top'
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
        },
        interaction: {
            intersect: false,
            mode: 'index'
        }
    }
});

// Export finance report
function exportFinanceReport() {
    const params = new URLSearchParams(window.location.search);
    params.set('export', 'excel');
    window.location.href = '{$FORM_ACTION}&' + params.toString();
}
</script>
