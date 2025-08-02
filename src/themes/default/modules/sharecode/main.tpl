<!-- BEGIN: main -->
<div class="search-results-section">
    <div class="container-fluid">
        <!-- Sort Bar -->
        <div class="panel panel-default">
            <div class="panel-body" style="padding: 10px 15px;">
                <div class="row">
                    <div class="col-xs-24 col-sm-12" style="display: flex; align-items: center;">
                        <p class="results-info" style="margin: 0; line-height: 1;">
                            Hiển thị <strong>{TOTAL_SOURCES}</strong> kết quả
                        </p>
                    </div>
                    <div class="col-xs-24 col-sm-12" style="display: flex; align-items: center; justify-content: flex-end;">
                        <form action="{BASE_URL}" method="get" class="form-inline" id="sort-form" style="margin: 0;">
                            <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
                            <input type="hidden" name="q" value="{SEARCH_KEY}" />
                            <input type="hidden" name="category" value="" />
                            <input type="hidden" name="price_filter" value="" />

                            <div class="form-group" style="margin: 0; display: flex; align-items: center;">
                                <label style="margin: 0 8px 0 0;">Sắp xếp:</label>
                                <select name="sort" class="form-control" onchange="document.getElementById('sort-form').submit();" style="width: auto;">
                                    <!-- BEGIN: sort_option -->
                                    <option value="{SORT.key}" {SORT.selected}>{SORT.label}</option>
                                    <!-- END: sort_option -->
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- BEGIN: sources -->
        <!-- Sources List -->
        <div class="sources-list">
            <!-- BEGIN: source -->
            <div class="source-item">
                <div class="row">
                    <div class="col-xs-24 col-sm-8 col-md-6 col-lg-4">
                        <div class="source-image">
                            <a href="{SOURCE.link}">
                                <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-responsive">
                            </a>
                        </div>
                    </div>
                    <div class="col-xs-24 col-sm-16 col-md-18 col-lg-20">
                        <div class="source-content">
                            <div class="source-header">
                                <h3 class="source-title">
                                    <a href="{SOURCE.link}">{SOURCE.title}</a>
                                </h3>
                                <div class="source-price">
                                    <span class="price-badge badge-{SOURCE.price_badge}">
                                        <i class="fa fa-tag"></i> {SOURCE.price_text}
                                    </span>
                                </div>
                            </div>
                            
                            <div class="source-meta">
                                <span class="source-category">
                                    <i class="fa fa-folder"></i> {SOURCE.category_title}
                                </span>
                                <span class="source-date">
                                    <i class="fa fa-calendar"></i> {SOURCE.add_time_format}
                                </span>
                            </div>
                            
                            <div class="source-description">
                                {SOURCE.description}
                            </div>
                            
                            <div class="source-stats">
                                <span class="stat-item">
                                    <i class="fa fa-eye"></i> {SOURCE.num_view} lượt xem
                                </span>
                                <span class="stat-item">
                                    <i class="fa fa-download"></i> {SOURCE.num_download} lượt tải
                                </span>
                                <span class="stat-item">
                                    <i class="fa fa-star"></i> {SOURCE.avg_rating}/5 ({SOURCE.total_reviews} đánh giá)
                                </span>
                            </div>
                            
                            <div class="source-actions">
                                <a href="{SOURCE.link}" class="btn btn-primary">
                                    <i class="fa fa-eye"></i> Xem chi tiết
                                </a>
                                <!-- BEGIN: can_download -->
                                <a href="#" class="btn btn-success">
                                    <i class="fa fa-download"></i> Tải xuống
                                </a>
                                <!-- END: can_download -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END: source -->
        </div>
        <!-- END: sources -->

        <!-- BEGIN: no_results -->
        <div class="no-results">
            <div class="text-center">
                <i class="fa fa-search fa-5x text-muted"></i>
                <h3>Không tìm thấy kết quả nào</h3>
                <p>Vui lòng thử lại với từ khóa khác hoặc điều chỉnh bộ lọc.</p>
            </div>
        </div>
        <!-- END: no_results -->

        <!-- BEGIN: pagination -->
        <div class="pagination-wrapper">
            {PAGINATION}
        </div>
        <!-- END: pagination -->
    </div>
</div>

<style>
.search-title {
    margin: 0;
    font-size: 28px;
    color: white;
}

.item-count {
    font-size: 16px;
    opacity: 0.8;
}

.search-stats {
    text-align: center;
}

.stat-item {
    display: inline-block;
    margin-left: 20px;
}

.stat-number {
    display: block;
    font-size: 24px;
    font-weight: bold;
}

.stat-label {
    font-size: 12px;
    opacity: 0.8;
}

/* Search Filters */
.search-filters-section {
    margin-bottom: 20px;
}

.search-filters-section .panel-heading {
    background-color: #f5f5f5;
    border-bottom: 1px solid #ddd;
}

/* Sort Bar */
.sort-bar {
    background-color: #f9f9f9;
    padding: 15px 0;
    border: 1px solid #ddd;
    margin-bottom: 20px;
    border-radius: 4px;
}

.results-info {
    margin: 5px 0;
    color: #666;
}

/* Sources List */
.sources-list {
    margin-bottom: 30px;
}

.source-item {
    background: white;
    border: 1px solid #ddd;
    border-radius: 6px;
    margin-bottom: 20px;
    padding: 20px;
    transition: all 0.3s ease;
}

.source-item:hover {
    box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    border-color: #337ab7;
}

.source-image {
    text-align: center;
    margin-bottom: 15px;
}

.source-image img {
    width: 100%;
    max-width: 200px;
    height: 150px;
    object-fit: cover;
    border-radius: 4px;
    border: 1px solid #eee;
}

.source-content {
    padding-left: 0;
}

.source-header {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-bottom: 10px;
    flex-wrap: wrap;
}

.source-title {
    margin: 0;
    font-size: 18px;
    font-weight: bold;
    flex: 1;
    margin-right: 15px;
}

.source-title a {
    color: #333;
    text-decoration: none;
}

.source-title a:hover {
    color: #337ab7;
    text-decoration: underline;
}

.source-price {
    font-size: 16px;
    font-weight: bold;
    white-space: nowrap;
}

.price-badge {
    display: inline-block;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 500;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.badge-success {
    background-color: #28a745;
    color: white;
}

.badge-warning {
    background-color: #ffc107;
    color: #212529;
}

.badge-info {
    background-color: #17a2b8;
    color: white;
}

.price-badge:hover {
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
    transition: all 0.2s ease;
}

.source-meta {
    margin-bottom: 12px;
    font-size: 13px;
    color: #666;
}

.source-meta span {
    margin-right: 20px;
}

.source-description {
    font-size: 14px;
    color: #555;
    line-height: 1.5;
    margin-bottom: 15px;
    max-height: 75px;
    overflow: hidden;
    text-overflow: ellipsis;
}

.source-stats {
    margin-bottom: 15px;
    font-size: 13px;
    color: #666;
}

.source-stats .stat-item {
    margin-right: 20px;
    display: inline-block;
}

.source-actions {
    text-align: left;
}

.source-actions .btn {
    margin-right: 10px;
    margin-bottom: 5px;
}

/* No Results */
.no-results {
    text-align: center;
    padding: 60px 20px;
    color: #666;
}

.no-results .fa {
    margin-bottom: 20px;
}

/* Responsive */
@media (max-width: 768px) {
    .search-title {
        font-size: 20px;
    }
    
    .source-header {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .source-title {
        margin-right: 0;
        margin-bottom: 10px;
    }
    
    .source-content {
        padding-left: 15px;
        margin-top: 15px;
    }
    
    .source-meta span {
        display: block;
        margin-bottom: 5px;
    }
    
    .source-stats .stat-item {
        display: block;
        margin-bottom: 5px;
    }
}

@media (max-width: 480px) {
    .source-item {
        padding: 15px;
    }
    
    .source-image img {
        max-width: 150px;
        height: 120px;
    }
    
    .source-title {
        font-size: 16px;
    }
}
</style>

<script>
// Auto-submit sort form when changed
document.addEventListener('DOMContentLoaded', function() {
    // Copy current search parameters to sort form
    const searchForm = document.getElementById('search-form');
    const sortForm = document.getElementById('sort-form');
    
    if (searchForm && sortForm) {
        // Copy search parameters
        const qInput = searchForm.querySelector('input[name="q"]');
        const categorySelect = searchForm.querySelector('select[name="category"]');
        const priceRadios = searchForm.querySelectorAll('input[name="price_filter"]:checked');
        
        if (qInput) {
            sortForm.querySelector('input[name="q"]').value = qInput.value;
        }
        if (categorySelect) {
            sortForm.querySelector('input[name="category"]').value = categorySelect.value;
        }
        if (priceRadios.length > 0) {
            sortForm.querySelector('input[name="price_filter"]').value = priceRadios[0].value;
        }
    }
});
</script>
<!-- END: main -->