<!-- BEGIN: main -->
<div class="search-results-section">
    <div class="container">
        <!-- Main category header -->
        <div class="category-header-simple">
        <div class="container-fluid">
            <h1 class="category-title-simple">
                <i class="fa fa-folder-open"></i> {CATEGORY.title}
                <span class="category-count-badge">{TOTAL_SOURCES} sản phẩm</span>
            </h1>
            <!-- BEGIN: category_description -->
            <p class="category-desc-simple">{CATEGORY.description}</p>
            <!-- END: category_description -->
        </div>
    </div>

    <!-- Subcategories section -->
    <!-- BEGIN: subcategories -->
    <div class="subcategories-section">
        <div class="container-fluid">
            <h3 class="section-title">
                <i class="fa fa-sitemap"></i> Danh mục con
            </h3>
            <div class="row">
                <!-- BEGIN: subcat -->
                <div class="col-xs-24 col-sm-8 col-md-6">
                    <a href="{SUBCAT.link}" class="subcat-card">
                        <div class="subcat-icon">
                            <i class="fa fa-folder"></i>
                        </div>
                        <div class="subcat-info">
                            <h5 class="subcat-name">{SUBCAT.title}</h5>
                            <span class="subcat-count">{SUBCAT.total_sources} sản phẩm</span>
                        </div>
                        <div class="subcat-arrow">
                            <i class="fa fa-chevron-right"></i>
                        </div>
                    </a>
                </div>
                <!-- END: subcat -->
            </div>
        </div>
    </div>
    <!-- END: subcategories -->

    <!-- Sort toolbar -->
    <div class="category-toolbar">
        <div class="container-fluid">
            <div class="row align-items-center">
                <div class="col-xs-24 col-md-12">
                    <div class="toolbar-left">
                        <span class="results-count"><i class="fa fa-list"></i> {TOTAL_SOURCES} sản phẩm</span>
                    </div>
                </div>
                <div class="col-xs-24 col-md-12">
                    <div class="toolbar-right">
                        <label class="sort-label"><i class="fa fa-sort"></i> Sắp xếp:</label>
                        <select id="category-sort-select" class="form-control sort-select">
                            <!-- BEGIN: sort_links -->
                            <!-- BEGIN: sort -->
                            <option value="{SORT.link}" {SORT.selected}>{SORT.name}</option>
                            <!-- END: sort -->
                            <!-- END: sort_links -->
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- BEGIN: sources -->
    <!-- Sources List (giống main.tpl) -->
    <div class="sources-list">
                <!-- BEGIN: source -->
                <div class="source-item">
                    <div class="source-image">
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
                            <a href="{SOURCE.link}#download" class="btn btn-success">
                                <i class="fa fa-download"></i> Tải xuống
                            </a>
                            <!-- END: can_download -->
                        </div>
                    </div>
                </div>
                <!-- END: source -->
            </div>
            <!-- END: sources -->
    <!-- BEGIN: no_sources -->
    <div class="no-results">
        <div class="text-center">
            <i class="fa fa-search fa-5x text-muted"></i>
            <h3>Không tìm thấy kết quả nào</h3>
            <p>Hiện tại chưa có mã nguồn nào trong danh mục này.</p>
        </div>
    </div>
    <!-- END: no_sources -->

        <!-- BEGIN: pagination -->
        <div class="pagination-wrapper">
            {GENERATE_PAGE}
        </div>
        <!-- END: pagination -->
    </div>
</div>

<style>
/* Category Header - Simple & Clean */
.category-header-simple {
    background: #fff;
    padding: 25px 0 20px;
    border-bottom: 1px solid #e9ecef;
    margin-bottom: 0;
}

.category-title-simple {
    font-size: 24px;
    font-weight: 600;
    margin-bottom: 8px;
    color: #2c3e50;
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 10px;
}

.category-title-simple i {
    color: #3498db;
    font-size: 22px;
}

.category-count-badge {
    font-size: 13px;
    font-weight: 500;
    color: #6c757d;
    background: #f8f9fa;
    padding: 5px 12px;
    border-radius: 4px;
    border: 1px solid #dee2e6;
}

.category-desc-simple {
    font-size: 14px;
    color: #6c757d;
    margin: 0;
    line-height: 1.5;
}

/* Subcategories */
.subcategories-section {
    background: #f8f9fa;
    padding: 30px 0;
    margin-bottom: 30px;
}

.section-title {
    color: #2c3e50;
    font-weight: 600;
    margin-bottom: 25px;
}

.subcat-card {
    display: block;
    background: white;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
    text-decoration: none;
    color: inherit;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
    border: 2px solid transparent;
    position: relative;
}

.subcat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    border-color: #667eea;
    text-decoration: none;
    color: inherit;
}

.subcat-icon {
    text-align: center;
    margin-bottom: 15px;
}

.subcat-icon i {
    font-size: 32px;
    color: #667eea;
}

.subcat-name {
    font-weight: 600;
    margin-bottom: 5px;
    color: #2c3e50;
}

.subcat-count {
    color: #7f8c8d;
    font-size: 14px;
}

.subcat-arrow {
    position: absolute;
    top: 50%;
    right: 15px;
    transform: translateY(-50%);
    color: #667eea;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.subcat-card:hover .subcat-arrow {
    opacity: 1;
}

/* Category Toolbar */
.category-toolbar {
    background: #fff;
    border-bottom: 2px solid #e9ecef;
    padding: 20px 0;
    margin-bottom: 30px;
}

.toolbar-left {
    display: flex;
    align-items: center;
}

.results-count {
    font-size: 16px;
    color: #495057;
    font-weight: 500;
}

.results-count i {
    color: #667eea;
    margin-right: 8px;
}

.toolbar-right {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 10px;
}

.sort-label {
    margin: 0;
    font-weight: 500;
    color: #495057;
    white-space: nowrap;
}

.sort-label i {
    color: #667eea;
    margin-right: 5px;
}

.sort-select {
    width: auto;
    min-width: 200px;
    display: inline-block;
    cursor: pointer;
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .category-header-simple {
        padding: 20px 0 15px;
    }

    .category-title-simple {
        font-size: 20px;
    }

    .category-count-badge {
        font-size: 12px;
        padding: 4px 10px;
    }

    .category-toolbar {
        padding: 15px 0;
    }

    .toolbar-left,
    .toolbar-right {
        justify-content: center;
        margin-bottom: 10px;
    }

    .toolbar-right {
        margin-bottom: 0;
    }

    .sort-select {
        width: 100%;
    }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const sortSelect = document.getElementById('category-sort-select');
    if (sortSelect) {
        sortSelect.addEventListener('change', function() {
            const selectedUrl = this.value;
            if (selectedUrl) {
                window.location.href = selectedUrl;
            }
        });
    }
});
</script>
<!-- END: main -->

