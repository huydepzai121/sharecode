<!-- BEGIN: main -->
<div class="search-results-section">
    <div class="author-page">
        <div class="author-header-simple">
        <div class="container">
            <div class="author-header-inner">
                <div class="author-avatar">
                    <img src="{AUTHOR.avatar_url}" alt="{AUTHOR.display_name}" class="img-responsive">
                </div>
                <div class="author-details">
                    <div class="author-title-row">
                        <h1 class="author-name">{AUTHOR.display_name}</h1>
                        <span class="author-username">@{AUTHOR.username}</span>
                    </div>
                    <!-- BEGIN: has_rating -->
                    <div class="author-rating">
                        <span class="rating-stars">{AUTHOR.rating_stars}</span>
                        <span class="rating-value">({AUTHOR.avg_rating}/5)</span>
                        <span class="rating-count">• {AUTHOR.total_reviews} đánh giá</span>
                    </div>
                    <!-- END: has_rating -->
                    <div class="author-meta">
                        <span class="meta-item">
                            <i class="fa fa-code"></i> {AUTHOR.total_codes} mã nguồn
                        </span>
                        <span class="meta-item">
                            <i class="fa fa-download"></i> {AUTHOR.total_downloads} lượt tải
                        </span>
                        <span class="meta-item">
                            <i class="fa fa-eye"></i> {AUTHOR.total_views} lượt xem
                        </span>
                        <span class="meta-item">
                            <i class="fa fa-calendar"></i> Tham gia {AUTHOR.join_date}
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="author-toolbar">
        <div class="container">
            <div class="author-toolbar-row">
                <div class="toolbar-left">
                    <span class="results-count">
                        <i class="fa fa-list"></i> {TOTAL_SOURCES} sản phẩm
                    </span>
                </div>
                <div class="toolbar-right">
                    <form method="get" class="toolbar-form">
                        <input type="hidden" name="id" value="{AUTHOR.id}">

                        <div class="control-item">
                            <label for="author-category-filter"><i class="fa fa-folder-open"></i> Danh mục:</label>
                            <select id="author-category-filter" name="category" class="form-control" onchange="this.form.submit()">
                                <option value="">Tất cả danh mục</option>
                                <!-- BEGIN: category_filter -->
                                <option value="{CATEGORY.id}" {CATEGORY.selected}>{CATEGORY.title}</option>
                                <!-- END: category_filter -->
                            </select>
                        </div>

                        <div class="control-item">
                            <label for="author-sort-select"><i class="fa fa-sort"></i> Sắp xếp:</label>
                            <select id="author-sort-select" name="sort" class="form-control" onchange="this.form.submit()">
                                <!-- BEGIN: sort_option -->
                                <option value="{SORT.key}" {SORT.selected}>{SORT.name}</option>
                                <!-- END: sort_option -->
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="author-content">
        <div class="container">
            <!-- BEGIN: sources -->
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
                    <p>Tác giả này chưa có mã nguồn nào được phê duyệt.</p>
                </div>
            </div>
            <!-- END: no_sources -->

            <!-- BEGIN: pagination -->
            <div class="pagination-wrapper">
                {PAGINATION}
            </div>
            <!-- END: pagination -->
        </div>
    </div>
</div>

<style>
.author-page {
    background: transparent;
}

.author-header-simple {
    background: #fff;
    border-bottom: 1px solid #e9ecef;
    padding: 30px 0;
}

.author-header-inner {
    display: flex;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
}

.author-avatar img {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    object-fit: cover;
}

.author-details {
    flex: 1;
    min-width: 220px;
}

.author-title-row {
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
    margin-bottom: 8px;
}

.author-name {
    font-size: 24px;
    margin: 0;
    color: #2c3e50;
}

.author-username {
    background: #eef2ff;
    color: #6366f1;
    font-weight: 600;
    padding: 4px 10px;
    border-radius: 999px;
    font-size: 13px;
}

.author-rating {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
    color: #495057;
}

.author-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    margin-top: 10px;
    font-size: 14px;
    color: #6c757d;
}

.author-meta .meta-item {
    display: flex;
    align-items: center;
    gap: 6px;
}

.author-meta .meta-item i {
    color: #667eea;
}

.author-toolbar {
    background: #fff;
    border-bottom: 1px solid #e9ecef;
    padding: 20px 0;
    margin-bottom: 30px;
}

.author-toolbar-row {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
}

.results-count {
    font-size: 16px;
    font-weight: 500;
    color: #495057;
    display: flex;
    align-items: center;
    gap: 8px;
}

.results-count i {
    color: #667eea;
}

.toolbar-right {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
}

.toolbar-form {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    gap: 12px;
}

.toolbar-form .control-item {
    display: flex;
    align-items: center;
    gap: 8px;
}

.toolbar-form label {
    margin: 0;
    font-weight: 500;
    color: #495057;
    white-space: nowrap;
}

.toolbar-form select {
    min-width: 180px;
}

.author-content {
    padding: 30px 0 50px;
}

.source-actions .btn + .btn {
    margin-left: 10px;
}

@media (max-width: 768px) {
    .author-header-simple {
        padding: 20px 0;
    }

    .author-name {
        font-size: 20px;
    }

    .author-toolbar {
        padding: 15px 0;
    }

    .toolbar-form select {
        min-width: 150px;
        width: 100%;
    }

    .source-actions {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .source-actions .btn + .btn {
        margin-left: 0;
    }
}
</style>
<!-- END: main -->
