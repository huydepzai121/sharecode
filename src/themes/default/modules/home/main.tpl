<!-- BEGIN: main -->
<link rel="stylesheet" type="text/css" href="{NV_BASE_SITEURL}themes/{THEMES}/css/home.css">

<div class="home-page">
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-xs-24">
                    <div class="hero-content text-center">
                        <h1 class="hero-title">
                            <i class="fa fa-code"></i> ShareCode Marketplace
                        </h1>
                        <p class="hero-description">
                            Nền tảng chia sẻ và mua bán mã nguồn chất lượng cao. 
                            Tìm kiếm, tải xuống và chia sẻ các dự án coding tuyệt vời.
                        </p>
                        
                        <!-- Search Box -->
                        <div class="hero-search">
                            <form action="{NV_BASE_SITEURL}index.php" method="get" class="search-form">
                                <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                                <input type="hidden" name="{NV_NAME_VARIABLE}" value="sharecode" />
                                <input type="hidden" name="{NV_OP_VARIABLE}" value="main" />
                                
                                <div class="input-group input-group-lg">
                                    <input type="text" name="q" class="form-control search-input" placeholder="Tìm kiếm mã nguồn..." />
                                    <span class="input-group-btn">
                                        <button class="btn btn-search" type="submit">
                                            <i class="fa fa-search"></i> Tìm kiếm
                                        </button>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Stats Section -->
    <div class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-xs-24 col-sm-6">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fa fa-code"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number">{STATS.total_sources}</h3>
                            <p class="stat-label">Mã nguồn</p>
                        </div>
                    </div>
                </div>
                <div class="col-xs-24 col-sm-6">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fa fa-download"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number">{STATS.total_downloads}</h3>
                            <p class="stat-label">Lượt tải</p>
                        </div>
                    </div>
                </div>
                <div class="col-xs-24 col-sm-6">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fa fa-folder"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number">{STATS.total_categories}</h3>
                            <p class="stat-label">Danh mục</p>
                        </div>
                    </div>
                </div>
                <div class="col-xs-24 col-sm-6">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fa fa-gift"></i>
                        </div>
                        <div class="stat-content">
                            <h3 class="stat-number">{STATS.total_free}</h3>
                            <p class="stat-label">Miễn phí</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- BEGIN: categories -->
    <!-- Danh Mục Sản Phẩm -->
    <section class="categories-section" style="padding: 60px 0; background-color: #ffffff;">
        <div class="container">
            <div class="text-center section-header" style="margin-bottom: 60px;">
                <h2 class="section-title">Danh Mục Sản Phẩm</h2>
                <div class="title-divider"></div>
                <p class="section-subtitle">Tìm source code phù hợp với nhu cầu của bạn</p>
            </div>

            <div class="category-slider">
                <div class="row category-grid">
                    <!-- BEGIN: category -->
                    <div class="col-xs-24 col-sm-8 col-md-4" style="margin-bottom: 20px;">
                        <a href="{CATEGORY.link}" class="category-card">
                            <div class="category-item-simple">
                                <div class="category-icon-simple">
                                    <i class="fa fa-code"></i>
                                </div>
                                <h4 class="category-title-simple">{CATEGORY.title}</h4>
                                <p class="category-count-simple">{CATEGORY.total_sources}</p>
                            </div>
                        </a>
                    </div>
                    <!-- END: category -->
                </div>
            </div>
        </div>
    </section>
    <!-- END: categories -->

    <!-- BEGIN: popular_sources -->
    <!-- Sản Phẩm Nổi Bật -->
    <section class="products-section" style="padding: 80px 0; background-color: #ffffff;">
        <div class="container">
            <div class="text-center section-header" style="margin-bottom: 60px;">
                <h2 class="section-title">Sản Phẩm Nổi Bật</h2>
                <div class="title-divider"></div>
                <p class="section-subtitle">Những source code được yêu thích nhất</p>
            </div>
            
            <div class="row">
                <!-- BEGIN: source -->
                <div class="col-xs-24 col-sm-12 col-md-6" style="margin-bottom: 30px;">
                    <div class="product-card-wrapper">
                        <div class="product-card">
                            <!-- BEGIN: discount -->
                            <div class="discount-badge">-{SOURCE.discount_percent}%</div>
                            <!-- END: discount -->
                            
                            <div class="product-image">
                                <!-- BEGIN: has_image -->
                                <img src="{SOURCE.image_url}" alt="{SOURCE.title}">
                                <!-- END: has_image -->
                                <!-- BEGIN: no_image -->
                                <div class="no-image">
                                    <i class="fa fa-code" style="font-size: 40px; color: #ddd;"></i>
                                </div>
                                <!-- END: no_image -->
                                <div class="image-overlay">
                                    <a href="{SOURCE.link}" class="btn btn-white btn-sm">
                                        <i class="fa fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                            
                            <div class="product-content">
                                <div class="product-category">
                                    <span class="category-badge">{SOURCE.category_title}</span>
                                </div>
                                
                                <h3 class="product-title">
                                    <a href="{SOURCE.link}">{SOURCE.title}</a>
                                </h3>
                                
                                <p class="product-description">{SOURCE.description}</p>
                                
                                <div class="product-stats">
                                    <div class="rating">
                                        <i class="fa fa-star"></i>
                                        <span>{SOURCE.rating}</span>
                                    </div>
                                    <div class="sold-count">{SOURCE.total_sold} đã bán</div>
                                </div>
                                
                                <div class="product-price">
                                    <span class="current-price">{SOURCE.price_text}</span>
                                    <!-- BEGIN: original_price -->
                                    <span class="original-price">{SOURCE.original_price_text}</span>
                                    <!-- END: original_price -->
                                </div>
                                
                                <div class="product-actions">
                                    <a href="{SOURCE.link}" class="btn btn-primary btn-block btn-buy">
                                        <i class="fa fa-shopping-cart"></i> Mua ngay
                                    </a>
                                    <div class="action-buttons">
                                        <button class="btn-action btn-favorite">
                                            <i class="fa fa-heart-o"></i>
                                        </button>
                                        <button class="btn-action btn-download">
                                            <i class="fa fa-download"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: source -->
            </div>
            
            <div class="text-center" style="margin-top: 24px;">
                <a href="{LINK_MORE}" class="btn btn-primary btn-lg">
                    <i class="fa fa-eye"></i> Xem tất cả sản phẩm
                </a>
            </div>
        </div>
    </section>
    <!-- END: popular_sources -->

    <!-- CTA Section -->
    <div class="cta-section">
        <div class="container">
            <div class="row">
                <div class="col-xs-24">
                    <div class="cta-content text-center">
                        <h2 class="cta-title">Bạn có mã nguồn chất lượng?</h2>
                        <p class="cta-description">
                            Chia sẻ mã nguồn của bạn với cộng đồng và kiếm thu nhập từ các dự án coding của mình.
                        </p>
                        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}=sharecode&{NV_OP_VARIABLE}=submit" class="btn btn-cta btn-lg">
                            <i class="fa fa-upload"></i> Đăng mã nguồn ngay
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- END: main -->
