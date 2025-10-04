<!-- BEGIN: main -->
 <link rel="stylesheet" href="{NV_STATIC_URL}themes/default/css/aos.css?v={NV_CURRENTTIME}">
<script src="{NV_STATIC_URL}themes/default/js/aos.js?v={NV_CURRENTTIME}"></script>

<div class="home-page">
    <!-- Hero Section -->
    <div class="hero-section" data-aos="fade-up">
        <div class="container">
            <div class="hero-content">
                <div class="row">
                    <!-- Hero Left -->
                    <div class="sc-col-full hero-left" data-aos="fade-right" data-aos-delay="150">
                        <h1 class="hero-title">Khám phá nguồn mã chất lượng để tăng tốc dự án của bạn</h1>
                        <p class="hero-description">
                            Hơn 3.000 sản phẩm được kiểm duyệt: web, mobile, AI, game và nhiều hơn nữa. Mua nhanh, triển khai dễ.
                        </p>

                        <!-- Stats -->
                        <div class="sc-hero-stats highlight" data-aos="fade-left" data-aos-delay="450">
                            <div class="sc-hero-stats-card">
                                <div class="sc-hero-stats-number">3.2k+</div>
                                <div class="sc-hero-stats-label">Sản phẩm</div>
                            </div>
                            <div class="sc-hero-stats-card">
                                <div class="sc-hero-stats-number">1.5k+</div>
                                <div class="sc-hero-stats-label">Nhà phát triển</div>
                            </div>
                            <div class="sc-hero-stats-card">
                                <div class="sc-hero-stats-number">4.8/5</div>
                                <div class="sc-hero-stats-label">Đánh giá trung bình</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- BEGIN: categories_section -->
    <!-- Categories Section -->
    <section class="categories-section" style="padding: 32px 0; background-color: #ffffff;" data-aos="fade-up" data-aos-delay="200">
        <div class="container">
            <div class="section-header" style="text-align: center; margin-bottom: 24px;" data-aos="fade-up" data-aos-delay="250">
                <div class="section-title">
                    <h2>Danh mục phổ biến</h2>
                    <p>Chọn lĩnh vực bạn quan tâm</p>
                </div>
            </div>

            <div class="categories-grid" style="display: flex; flex-wrap: wrap; margin: 0 -15px;">
                <!-- BEGIN: category -->
                <div class="sc-col-half sc-col-sm-third sc-col-md-quarter sc-col-lg-quarter" style="padding: 0 15px; margin-bottom: 12px;" data-aos="zoom-in" data-aos-delay="{CATEGORY.aos_delay}">
                    <a href="{CATEGORY.link}" class="category-card" style="text-decoration: none; display: block;">
                        <div class="category-item-simple">
                            <div class="category-icon-simple">
                                <i class="fa fa-folder" style="font-size: 2rem; color: var(--nv-primary);"></i>
                            </div>
                            <h3 class="category-title-simple">{CATEGORY.title}</h3>
                            <p class="category-count-simple">{CATEGORY.total_sources} sản phẩm</p>
                        </div>
                    </a>
                </div>
                <!-- END: category -->
            </div>
        </div>
    </section>
    <!-- END: categories_section -->

    <!-- BEGIN: popular_sources -->
    <!-- Sản Phẩm Nổi Bật -->
    <section class="products-section" style="padding: 80px 0; background-color: #ffffff;" data-aos="fade-up" data-aos-delay="150">
        <div class="container">
            <div class="text-center section-header" style="margin-bottom: 60px;" data-aos="fade-up" data-aos-delay="200">
                <h2 class="section-title">Nổi bật tuần này</h2>
                <div class="title-divider"></div>
                <p class="section-subtitle">Các bộ mã được cộng đồng quan tâm</p>
            </div>

            <div class="row products-grid">
                <!-- BEGIN: source -->
                <div class="sc-col-full sc-col-sm-half sc-col-md-quarter sc-col-lg-quarter product-col" data-aos="fade-up" data-aos-delay="{SOURCE.aos_delay}">
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
                                    <a href="{SOURCE.link}" class="sc-button sc-button-white btn-sm" aria-label="Xem chi tiết {SOURCE.title}">
                                        <i class="fa fa-eye" aria-hidden="true"></i> Xem chi tiết
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
                                    <a href="{SOURCE.link}" class="sc-button sc-button-primary btn-block sc-button-buy" aria-label="Mua {SOURCE.title}">
                                        <i class="fa fa-shopping-cart" aria-hidden="true"></i> Mua ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: source -->
            </div>
            
            <div class="text-center" style="margin-top: 24px;">
                <a href="{LINK_MORE}" class="sc-button sc-button-primary btn-lg figma-gradient-btn">
                    Xem tất cả
                </a>
            </div>
        </div>
    </section>
    <!-- END: popular_sources -->

    <!-- BEGIN: latest_section -->
    <!-- Latest Products Section -->
    <section class="latest-section" style="padding: 32px 0; background-color: #ffffff;" data-aos="fade-up" data-aos-delay="250">
        <div class="container">
            <div class="section-header" style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 24px;" data-aos="fade-up" data-aos-delay="300">
                <div class="section-title">
                    <h2>Mới nhất</h2>
                    <p>Cập nhật liên tục mỗi ngày</p>
                </div>
                <a href="{LINK_MORE}" class="sc-button btn-outline">Khám phá thêm</a>
            </div>

            <div class="row products-grid">
                <!-- BEGIN: latest_source -->
                <div class="sc-col-full sc-col-sm-half sc-col-md-quarter sc-col-lg-quarter product-col" data-aos="fade-up" data-aos-delay="{LATEST_SOURCE.aos_delay}">
                    <div class="product-card-wrapper">
                        <div class="product-card">
                            <!-- BEGIN: discount -->
                            <div class="discount-badge">-{LATEST_SOURCE.discount_percent}%</div>
                            <!-- END: discount -->

                            <div class="product-image">
                                <!-- BEGIN: has_image -->
                                <img src="{LATEST_SOURCE.image_url}" alt="{LATEST_SOURCE.title}">
                                <!-- END: has_image -->
                                <!-- BEGIN: no_image -->
                                <div class="no-image">
                                    <i class="fa fa-code" style="font-size: 40px; color: #ddd;"></i>
                                </div>
                                <!-- END: no_image -->
                                <div class="image-overlay">
                                    <a href="{LATEST_SOURCE.link}" class="sc-button sc-button-white btn-sm" aria-label="Xem chi tiết {LATEST_SOURCE.title}">
                                        <i class="fa fa-eye" aria-hidden="true"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>

                            <div class="product-content">
                                <div class="product-category">
                                    <span class="category-badge">{LATEST_SOURCE.category_title}</span>
                                </div>

                                <h3 class="product-title">
                                    <a href="{LATEST_SOURCE.link}">{LATEST_SOURCE.title}</a>
                                </h3>

                                <p class="product-description">{LATEST_SOURCE.description}</p>

                                <div class="product-stats">
                                    <div class="rating">
                                        <i class="fa fa-star"></i>
                                        <span>{LATEST_SOURCE.rating}</span>
                                    </div>
                                    <div class="sold-count">{LATEST_SOURCE.total_sold} đã bán</div>
                                </div>

                                <div class="product-price">
                                    <span class="current-price">{LATEST_SOURCE.price_text}</span>
                                    <!-- BEGIN: original_price -->
                                    <span class="original-price">{LATEST_SOURCE.original_price_text}</span>
                                    <!-- END: original_price -->
                                </div>

                                <div class="product-actions">
                                    <a href="{LATEST_SOURCE.link}" class="sc-button sc-button-primary btn-block sc-button-buy" aria-label="Mua {LATEST_SOURCE.title}">
                                        <i class="fa fa-shopping-cart" aria-hidden="true"></i> Mua ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: latest_source -->
            </div>

            <div class="text-center" style="margin-top: 24px;">
                <a href="{LINK_MORE}" class="sc-button sc-button-primary btn-lg figma-gradient-btn">
                    Khám phá thêm
                </a>
            </div>
        </div>
    </section>
    <!-- END: latest_section -->

    <!-- CTA Section -->
    <div class="cta-section" data-aos="fade-up" data-aos-delay="200">
        <div class="container">
            <div class="row">
                <div class="col-xs-24">
                    <div class="cta-content text-center">
                        <h2 class="cta-title" data-aos="fade-up" data-aos-delay="250">Bạn có mã nguồn chất lượng?</h2>
                        <p class="cta-description" data-aos="fade-up" data-aos-delay="300">
                            Chia sẻ mã nguồn của bạn với cộng đồng và kiếm thu nhập từ các dự án coding của mình.
                        </p>
                        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}=sharecode&{NV_OP_VARIABLE}=submit" class="sc-button sc-button-cta btn-lg" aria-label="Đăng mã nguồn của bạn" data-aos="zoom-in" data-aos-delay="350">
                            <i class="fa fa-upload" aria-hidden="true"></i> Đăng mã nguồn ngay
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- END: main -->
