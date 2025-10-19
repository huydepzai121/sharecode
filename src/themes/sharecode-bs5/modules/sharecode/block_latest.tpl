<!-- BEGIN: main -->
<div class="sharecode-block-latest">
    <div class="row">
        <!-- BEGIN: source -->
        <div class="col-lg-6 col-md-8 col-sm-12 col-xs-24 mb-4">
            <div class="source-card">
                <!-- BEGIN: image -->
                <div class="source-image">
                    <a href="{SOURCE.link}">
                        <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="img-responsive">
                    </a>
                    <div class="source-overlay">
                        <div class="source-stats">
                            <span class="stat-downloads">
                                <i class="fa fa-download"></i> {SOURCE.num_download}
                            </span>
                        </div>
                        <div class="source-rating">
                            <span class="rating-number">4</span>
                            <div class="rating-stars">
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                        </div>
                    </div>
                    <div class="source-category">
                        <span class="category-tag">{SOURCE.category_title}</span>
                    </div>
                </div>
                <!-- END: image -->

                <div class="source-content">
                    <h4 class="source-title">
                        <a href="{SOURCE.link}" title="{SOURCE.title}">{SOURCE.title}</a>
                    </h4>

                    <div class="source-meta">
                        <span class="source-date">
                            <i class="fa fa-calendar"></i> {SOURCE.add_time_format}
                        </span>
                        <span class="source-views">
                            <i class="fa fa-eye"></i> {SOURCE.num_view}
                        </span>
                    </div>

                    <p class="source-description">{SOURCE.description_short}</p>

                    <div class="source-footer">
                        <!-- BEGIN: free -->
                        <div class="source-price free">
                            <span class="price-label">Miễn phí</span>
                        </div>
                        <!-- END: free -->
                        <!-- BEGIN: paid -->
                        <div class="source-price paid">
                            <span class="price-amount">{SOURCE.price_text}</span>
                        </div>
                        <!-- END: paid -->
                    </div>
                </div>
            </div>
        </div>
        <!-- END: source -->
    </div>
</div>

<style>
.sharecode-block-latest {
    margin-bottom: 20px;
}

.sharecode-block-latest .source-card {
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    transition: all 0.3s ease;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.sharecode-block-latest .source-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.sharecode-block-latest .source-image {
    position: relative;
    height: 180px;
    overflow: hidden;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.sharecode-block-latest .source-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.sharecode-block-latest .source-card:hover .source-image img {
    transform: scale(1.1);
}

.sharecode-block-latest .source-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(to bottom, rgba(0,0,0,0.1) 0%, rgba(0,0,0,0.6) 100%);
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 12px;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.sharecode-block-latest .source-card:hover .source-overlay {
    opacity: 1;
}

.sharecode-block-latest .source-stats {
    display: flex;
    justify-content: flex-end;
}

.sharecode-block-latest .stat-downloads {
    background: rgba(255,255,255,0.9);
    color: #333;
    padding: 4px 8px;
    border-radius: 15px;
    font-size: 11px;
    font-weight: 600;
}

.sharecode-block-latest .source-rating {
    display: flex;
    align-items: center;
    color: #fff;
}

.sharecode-block-latest .rating-number {
    background: #4CAF50;
    color: #fff;
    width: 32px;
    height: 32px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 14px;
    margin-right: 8px;
}

.sharecode-block-latest .rating-stars {
    color: #FFD700;
    font-size: 12px;
}

.sharecode-block-latest .source-category {
    position: absolute;
    top: 12px;
    left: 12px;
}

.sharecode-block-latest .category-tag {
    background: rgba(255,255,255,0.9);
    color: #333;
    padding: 4px 10px;
    border-radius: 12px;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
}

.sharecode-block-latest .source-content {
    padding: 16px;
    flex: 1;
    display: flex;
    flex-direction: column;
}

.sharecode-block-latest .source-title {
    margin: 0 0 8px 0;
    font-size: 15px;
    font-weight: 700;
    line-height: 1.3;
    height: 40px;
}

.sharecode-block-latest .source-title a {
    color: #333;
    text-decoration: none;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.sharecode-block-latest .source-title a:hover {
    color: #007bff;
}

.sharecode-block-latest .source-meta {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
    font-size: 11px;
    color: #999;
}

.sharecode-block-latest .source-meta i {
    margin-right: 4px;
}

.sharecode-block-latest .source-description {
    font-size: 12px;
    color: #666;
    line-height: 1.4;
    margin-bottom: 12px;
    flex: 1;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    height: 32px;
}

.sharecode-block-latest .source-footer {
    margin-top: auto;
    padding-top: 8px;
    border-top: 1px solid #f0f0f0;
}

.sharecode-block-latest .source-price {
    text-align: center;
}

.sharecode-block-latest .source-price.free .price-label {
    background: linear-gradient(135deg, #4CAF50, #45a049);
    color: #fff;
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    display: inline-block;
}

.sharecode-block-latest .source-price.paid .price-amount {
    background: linear-gradient(135deg, #FF9800, #F57C00);
    color: #fff;
    padding: 6px 16px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 700;
    display: inline-block;
}

/* Responsive */
@media (max-width: 768px) {
    .sharecode-block-latest .col-sm-6 {
        margin-bottom: 20px;
    }

    .sharecode-block-latest .source-image {
        height: 160px;
    }
}

@media (max-width: 576px) {
    .sharecode-block-latest .col-xs-12 {
        margin-bottom: 20px;
    }

    .sharecode-block-latest .source-image {
        height: 140px;
    }

    .sharecode-block-latest .source-content {
        padding: 12px;
    }
}
</style>
<!-- END: main -->
