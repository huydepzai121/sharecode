<!-- BEGIN: main -->
<div class="container">
    <!-- Page Header -->
    <div class="page-header-section">
        <div class="container-fluid">
            <h1 class="page-title">
                <i class="fa fa-tag"></i> Tag: {TAG_NAME}
                <span class="page-count-badge">{TOTAL_SOURCES} sản phẩm</span>
            </h1>
        </div>
    </div>

    <!-- BEGIN: related_tags -->
    <!-- Related Tags Section -->
    <div class="related-tags-section">
        <div class="container-fluid">
            <h3 class="section-title">
                <i class="fa fa-tags"></i> Tags liên quan
            </h3>
            <div class="tag-cloud-modern">
                <!-- BEGIN: tag -->
                <a href="{RELATED_TAG.link}" class="tag-item">
                    <span class="tag-name">{RELATED_TAG.name}</span>
                    <span class="tag-count">{RELATED_TAG.total_sources}</span>
                </a>
                <!-- END: tag -->
            </div>
        </div>
    </div>
    <!-- END: related_tags -->

    <!-- BEGIN: sort_links -->
    <!-- Category Toolbar -->
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
                        <select id="tag-sort-select" class="form-control sort-select">
                            <!-- BEGIN: sort -->
                            <option value="{SORT.link}" <!-- BEGIN: active -->selected<!-- END: active -->>{SORT.name}</option>
                            <!-- END: sort -->
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END: sort_links -->

    <!-- BEGIN: sources -->
    <!-- Sources List -->
    <div class="search-results-section">
        <div class="container-fluid">
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
        </div>
    </div>
    <!-- END: sources -->

    <!-- BEGIN: no_sources -->
    <div class="no-results">
        <div class="text-center">
            <i class="fa fa-search fa-5x text-muted"></i>
            <h3>Không tìm thấy kết quả nào</h3>
            <p>Hiện tại chưa có mã nguồn nào có tag này.</p>
        </div>
    </div>
    <!-- END: no_sources -->

    <!-- BEGIN: pagination -->
    <div class="pagination-wrapper">
        {GENERATE_PAGE}
    </div>
    <!-- END: pagination -->
</div>

<style>
/* Page Header */
.page-header-section {
    background: #fff;
    padding: 25px 0 20px;
    border-bottom: 1px solid #e9ecef;
    margin-bottom: 0;
}

.page-title {
    font-size: 24px;
    font-weight: 600;
    margin-bottom: 8px;
    color: #2c3e50;
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 10px;
}

.page-title i {
    color: #3498db;
    font-size: 22px;
}

.page-count-badge {
    font-size: 13px;
    font-weight: 500;
    color: #6c757d;
    background: #f8f9fa;
    padding: 5px 12px;
    border-radius: 4px;
    border: 1px solid #dee2e6;
}

/* Related Tags Section */
.related-tags-section {
    background: #f8f9fa;
    padding: 30px 0;
    margin-bottom: 30px;
}

.section-title {
    color: #2c3e50;
    font-weight: 600;
    margin-bottom: 25px;
}

.tag-cloud-modern {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
}

.tag-item {
    display: inline-flex;
    align-items: center;
    background: white;
    border: 2px solid #e9ecef;
    border-radius: 25px;
    padding: 8px 16px;
    text-decoration: none;
    color: #495057;
    transition: all 0.3s ease;
    font-weight: 500;
}

.tag-item:hover {
    border-color: #667eea;
    color: #667eea;
    text-decoration: none;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
}

.tag-name {
    margin-right: 8px;
}

.tag-count {
    background: #667eea;
    color: white;
    border-radius: 12px;
    padding: 2px 8px;
    font-size: 12px;
    font-weight: 600;
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
    .page-header-section {
        padding: 20px 0 15px;
    }

    .page-title {
        font-size: 20px;
    }

    .page-count-badge {
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

    .tag-cloud-modern {
        justify-content: center;
    }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const sortSelect = document.getElementById('tag-sort-select');
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