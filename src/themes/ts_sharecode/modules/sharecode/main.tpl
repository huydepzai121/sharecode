<!-- BEGIN: main -->
<div class="search-results-section">
    <div class="container">
        <!-- Search Form -->
        <div class="search-form-section">
            <h3 class="search-form-title">
                <i class="fa fa-search"></i>
                Từ khóa tìm kiếm
            </h3>

            <form action="{BASE_URL}" method="get" id="search-form">
                <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />

                <div class="search-input-group">
                    <input type="text" name="q" value="{SEARCH_KEY}" placeholder="Nhập tên sản phẩm, từ khóa..." class="form-control">
                    <i class="fa fa-search search-icon"></i>
                </div>

                <div class="search-filters">
                    <div class="filter-group">
                        <label><i class="fa fa-list"></i> Danh mục</label>
                        <select name="category" class="form-control">
                            <!-- BEGIN: category_option -->
                            <option value="{CATEGORY.id}" {CATEGORY.selected}>{CATEGORY.title}</option>
                            <!-- END: category_option -->
                        </select>
                    </div>

                    <div class="filter-group">
                        <label><i class="fa fa-sort"></i> Sắp xếp theo</label>
                        <select name="sort" class="form-control">
                            <!-- BEGIN: sort_option -->
                            <option value="{SORT.key}" {SORT.selected}>{SORT.label}</option>
                            <!-- END: sort_option -->
                        </select>
                    </div>

                    <button type="submit" class="btn btn-success search-btn">
                        <i class="fa fa-search"></i>
                        Tìm kiếm ngay
                    </button>
                </div>

                <div class="search-suggestions">
                    <span>Tìm kiếm nhanh:</span>
                    <a href="?q=Website" class="suggestion-tag">Website</a>
                    <a href="?q=Mobile App" class="suggestion-tag">Mobile App</a>
                    <a href="?q=WordPress" class="suggestion-tag">WordPress</a>
                    <a href="?q=E-commerce" class="suggestion-tag">E-commerce</a>
                </div>
            </form>
        </div>

        <!-- BEGIN: sources -->
        <!-- Sources List -->
        <div class="sources-list">
            <!-- BEGIN: source -->
            <div class="source-item">
                <div class="source-image">
                    <div class="source-price hidden">
                        <span class="price-badge badge-{SOURCE.price_badge}">
                            <i class="fa fa-tag"></i> {SOURCE.price_text}
                        </span>
                    </div>
                    <a href="{SOURCE.link}">
                        <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-responsive">
                    </a>
                </div>

                <div class="source-content">
                    <div class="source-header">
                        <h3 class="source-title">
                            <a href="{SOURCE.link}">{SOURCE.title}</a>
                        </h3>
                    </div>

                    <div class="source-meta">
                        <span class="source-category">
                            <i class="fa fa-folder"></i> {SOURCE.category_title}
                        </span>
                        <span class="source-date">
                            <i class="fa fa-calendar"></i> {SOURCE.add_time_format}
                        </span>
                    </div>

                    <!-- Star Rating -->
                    <div class="star-rating">
                        <!-- BEGIN: rating_stars -->
                        <i class="fa fa-star star {STAR.class}"></i>
                        <!-- END: rating_stars -->
                        <span class="rating-text">({SOURCE.total_reviews} đánh giá)</span>
                    </div>

                    <div class="source-stats">
                        <span class="stat-item">
                            <i class="fa fa-eye"></i> {SOURCE.num_view}
                        </span>
                        <span class="stat-item">
                            <i class="fa fa-download"></i> {SOURCE.num_download}
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