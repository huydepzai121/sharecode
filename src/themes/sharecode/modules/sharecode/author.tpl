<!-- BEGIN: main -->
<div class="author-profile">
    <!-- Author Header -->
    <div class="author-header">
        <div class="container">
            <div class="row">
                <div class="col-xs-24 col-sm-6 text-center">
                    <div class="author-avatar">
                        <img src="{AUTHOR.avatar_url}" alt="{AUTHOR.display_name}" class="img-circle" style="width: 120px; height: 120px; object-fit: cover;">
                    </div>
                </div>
                <div class="col-xs-24 col-sm-18">
                    <div class="author-info">
                        <h1 class="author-name">{AUTHOR.display_name}</h1>
                        <p class="author-username text-muted">@{AUTHOR.username}</p>
                        
                        <!-- BEGIN: has_rating -->
                        <div class="author-rating">
                            <span class="rating-stars">{AUTHOR.rating_stars}</span>
                            <span class="rating-value">({AUTHOR.avg_rating}/5)</span>
                            <span class="text-muted">• {AUTHOR.total_reviews} đánh giá</span>
                        </div>
                        <!-- END: has_rating -->
                        
                        <div class="author-stats">
                            <div class="row">
                                <div class="col-xs-12 col-sm-6">
                                    <div class="stat-item">
                                        <div class="stat-number">{AUTHOR.total_codes}</div>
                                        <div class="stat-label">Mã nguồn</div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="stat-item">
                                        <div class="stat-number">{AUTHOR.total_downloads}</div>
                                        <div class="stat-label">Lượt tải</div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="stat-item">
                                        <div class="stat-number">{AUTHOR.total_views}</div>
                                        <div class="stat-label">Lượt xem</div>
                                    </div>
                                </div>
                                <div class="col-xs-12 col-sm-6">
                                    <div class="stat-item">
                                        <div class="stat-number">{AUTHOR.join_date}</div>
                                        <div class="stat-label">Tham gia</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Content -->
    <div class="container" style="margin-top: 30px;">
        <div class="row">
            <div class="col-xs-24">
                <!-- Filters -->
                <div class="content-filters">
                    <div class="row">
                        <div class="col-xs-24 col-sm-16">
                            <h3>Mã nguồn của {AUTHOR.display_name} <span class="badge">{TOTAL_SOURCES}</span></h3>
                        </div>
                        <div class="col-xs-24 col-sm-8">
                            <form method="get" class="filter-form">
                                <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}">
                                <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}">
                                <input type="hidden" name="{NV_OP_VARIABLE}" value="author">
                                <input type="hidden" name="id" value="{AUTHOR.id}">
                                
                                <div class="row">
                                    <div class="col-xs-12">
                                        <select name="category" class="form-control" onchange="this.form.submit()">
                                            <option value="">Tất cả danh mục</option>
                                            <!-- BEGIN: category_filter -->
                                            <option value="{CATEGORY.id}" {CATEGORY.selected}>{CATEGORY.title}</option>
                                            <!-- END: category_filter -->
                                        </select>
                                    </div>
                                    <div class="col-xs-12">
                                        <select name="sort" class="form-control" onchange="this.form.submit()">
                                            <!-- BEGIN: sort_option -->
                                            <option value="{SORT.key}" {SORT.selected}>{SORT.name}</option>
                                            <!-- END: sort_option -->
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Sources Grid -->
                <!-- BEGIN: sources -->
                <div class="sources-grid">
                    <div class="row">
                        <!-- BEGIN: source -->
                        <div class="col-xs-24 col-sm-12 col-md-8">
                            <div class="source-card">
                                <div class="source-image">
                                    <a href="{SOURCE.link}">
                                        <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-responsive">
                                    </a>
                                </div>
                                <div class="source-content">
                                    <h4 class="source-title">
                                        <a href="{SOURCE.link}">{SOURCE.title}</a>
                                    </h4>
                                    
                                    <div class="source-meta">
                                        <div class="source-category">
                                            <i class="fa fa-folder-o"></i>
                                            <a href="{SOURCE.category_link}">{SOURCE.category_title}</a>
                                        </div>
                                        <div class="source-date">
                                            <i class="fa fa-calendar"></i>
                                            {SOURCE.add_time_format}
                                        </div>
                                    </div>
                                    
                                    <div class="source-price">
                                        <!-- BEGIN: free_price -->
                                        <span class="price free">Miễn phí</span>
                                        <!-- END: free_price -->
                                        <!-- BEGIN: paid_price -->
                                        <span class="price paid">{SOURCE.price_text}</span>
                                        <!-- END: paid_price -->
                                    </div>
                                    
                                    <!-- BEGIN: rating -->
                                    <div class="source-rating">
                                        <span class="rating-stars">{SOURCE.rating_stars}</span>
                                        <span class="rating-count">({SOURCE.total_reviews})</span>
                                    </div>
                                    <!-- END: rating -->
                                    
                                    <div class="source-stats">
                                        <span class="downloads">
                                            <i class="fa fa-download"></i> {SOURCE.num_download}
                                        </span>
                                        <span class="views">
                                            <i class="fa fa-eye"></i> {SOURCE.num_view}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END: source -->
                    </div>
                </div>
                <!-- END: sources -->

                <!-- BEGIN: no_sources -->
                <div class="no-sources text-center">
                    <i class="fa fa-code fa-5x text-muted"></i>
                    <h3>Chưa có mã nguồn</h3>
                    <p class="text-muted">Tác giả này chưa có mã nguồn nào được phê duyệt.</p>
                </div>
                <!-- END: no_sources -->

                <!-- Pagination -->
                <!-- BEGIN: pagination -->
                <div class="pagination-wrapper text-center">
                    {GENERATE_PAGE}
                </div>
                <!-- END: pagination -->
            </div>
        </div>
    </div>
</div>

<style>
.author-profile {
    margin-bottom: 30px;
}

.author-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px 0;
    margin-bottom: 0;
}

.author-avatar img {
    border: 4px solid rgba(255,255,255,0.2);
}

.author-name {
    color: white;
    margin-bottom: 5px;
    font-size: 2.5em;
    font-weight: 300;
}

.author-username {
    color: rgba(255,255,255,0.8);
    font-size: 1.2em;
    margin-bottom: 15px;
}

.author-rating {
    margin-bottom: 20px;
}

.rating-stars {
    color: #ffc107;
    font-size: 1.2em;
}

.rating-value {
    color: white;
    font-weight: bold;
    margin-left: 5px;
}

.author-stats {
    margin-top: 20px;
}

.stat-item {
    text-align: center;
    margin-bottom: 10px;
}

.stat-number {
    font-size: 2em;
    font-weight: bold;
    color: white;
}

.stat-label {
    color: rgba(255,255,255,0.8);
    font-size: 0.9em;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.content-filters {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 30px;
}

.content-filters h3 {
    margin-top: 0;
    color: #333;
}

.filter-form .form-control {
    border-radius: 20px;
}

.sources-grid .source-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    overflow: hidden;
    margin-bottom: 30px;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.sources-grid .source-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 5px 20px rgba(0,0,0,0.2);
}

.source-image {
    height: 200px;
    overflow: hidden;
}

.source-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.source-card:hover .source-image img {
    transform: scale(1.05);
}

.source-content {
    padding: 20px;
}

.source-title {
    margin: 0 0 15px 0;
    font-size: 1.2em;
}

.source-title a {
    color: #333;
    text-decoration: none;
}

.source-title a:hover {
    color: #007bff;
}

.source-meta {
    margin-bottom: 15px;
}

.source-meta > div {
    margin-bottom: 5px;
    font-size: 0.9em;
    color: #666;
}

.source-meta i {
    width: 16px;
    margin-right: 5px;
}

.source-meta a {
    color: #007bff;
    text-decoration: none;
}

.source-price {
    margin-bottom: 10px;
}

.price {
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.9em;
    font-weight: bold;
}

.price.free {
    background: #28a745;
    color: white;
}

.price.paid {
    background: #ffc107;
    color: #333;
}

.source-rating {
    margin-bottom: 10px;
}

.rating-stars {
    color: #ffc107;
}

.rating-count {
    color: #666;
    font-size: 0.9em;
}

.source-stats {
    display: flex;
    justify-content: space-between;
    font-size: 0.9em;
    color: #666;
    padding-top: 10px;
    border-top: 1px solid #eee;
}

.no-sources {
    padding: 60px 20px;
}

.pagination-wrapper {
    margin-top: 40px;
}

@media (max-width: 768px) {
    .author-header {
        padding: 30px 0;
    }
    
    .author-name {
        font-size: 2em;
    }
    
    .content-filters .row > div {
        margin-bottom: 15px;
    }
    
    .filter-form .row > div {
        margin-bottom: 10px;
    }
}
</style>
<!-- END: main -->