<!-- BEGIN: main -->

<div class="home-page">

    <!-- BEGIN: categories_section -->
    <!-- Categories Section -->
    <section class="categories-section py-5 bg-white" data-aos="fade-up" data-aos-delay="200">
        <div class="container">
            <div class="section-header text-center mb-4" data-aos="fade-up" data-aos-delay="250">
                <div class="section-title">
                    <h2>Tất cả danh mục</h2>
                    <p class="text-muted">Chọn lĩnh vực bạn quan tâm</p>
                </div>
            </div>

            <div class="row g-3">
                <!-- BEGIN: category -->
                <div class="col-6 col-sm-4 col-md-3 col-lg-3" data-aos="zoom-in" data-aos-delay="{CATEGORY.aos_delay}">
                    <a href="{CATEGORY.link}" class="text-decoration-none">
                        <div class="card h-100 border-0 shadow-sm">
                            <div class="card-body text-center p-4">
                                <div class="mb-3">
                                    <i class="fa fa-folder fs-1 text-primary"></i>
                                </div>
                                <h5 class="card-title h6 mb-2">{CATEGORY.title}</h5>
                                <p class="card-text text-muted small">{CATEGORY.total_sources} sản phẩm</p>
                            </div>
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
    <section class="products-section py-5 bg-white" data-aos="fade-up" data-aos-delay="150">
        <div class="container">
            <div class="section-header text-center mb-4" data-aos="fade-up" data-aos-delay="200">
                <div class="section-title">
                    <h2>Top 20 Mã Nguồn Hot Nhất</h2>
                    <p class="text-muted">Những mã nguồn được tải và đánh giá cao nhất</p>
                </div>
            </div>

            <div class="row g-4 products-grid">
                <!-- BEGIN: source -->
                <div class="col-12 col-sm-6 col-md-4 col-lg-3 product-col" data-aos="fade-up" data-aos-delay="{SOURCE.aos_delay}">
                    <div class="product-card-wrapper">
                        <div class="card h-100 border-0 shadow-sm">
                            <!-- BEGIN: discount -->
                            <div class="position-absolute top-0 start-0 m-2">
                                <span class="badge bg-danger">-{SOURCE.discount_percent}%</span>
                            </div>
                            <!-- END: discount -->

                            <div class="position-relative overflow-hidden">
                                <!-- BEGIN: has_image -->
                                <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="card-img-top" style="height: 200px; object-fit: cover;">
                                <!-- END: has_image -->
                                <!-- BEGIN: no_image -->
                                <div class="card-img-top d-flex align-items-center justify-content-center bg-light" style="height: 200px;">
                                    <i class="fa fa-code fs-1 text-muted"></i>
                                </div>
                                <!-- END: no_image -->
                                <div class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center opacity-0 hover-overlay">
                                    <a href="{SOURCE.link}" class="btn btn-outline-light btn-sm" aria-label="Xem chi tiết {SOURCE.title}">
                                        <i class="fa fa-eye" aria-hidden="true"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>
                            
                            <div class="card-body d-flex flex-column">
                                <div class="mb-2">
                                    <span class="badge bg-secondary">{SOURCE.category_title}</span>
                                </div>

                                <h5 class="card-title h6 mb-2">
                                    <a href="{SOURCE.link}" class="text-decoration-none text-dark">{SOURCE.title}</a>
                                </h5>

                                <p class="card-text text-muted small mb-3 flex-grow-1">{SOURCE.description}</p>

                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="rating">
                                        <i class="fa fa-star text-warning"></i>
                                        <span class="ms-1 small">{SOURCE.rating}</span>
                                    </div>
                                    <div class="text-muted small">{SOURCE.total_sold} đã bán</div>
                                </div>

                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <div>
                                        <span class="fw-bold text-primary">{SOURCE.price_text}</span>
                                        <!-- BEGIN: original_price -->
                                        <span class="text-muted text-decoration-line-through small ms-2">{SOURCE.original_price_text}</span>
                                        <!-- END: original_price -->
                                    </div>
                                </div>

                                <div class="mt-auto">
                                    <a href="{SOURCE.link}" class="btn btn-primary w-100" aria-label="Mua {SOURCE.title}">
                                        <i class="fa fa-shopping-cart me-1" aria-hidden="true"></i> Mua ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: source -->
            </div>
        </div>
    </section>
    <!-- END: popular_sources -->

    <!-- BEGIN: latest_section -->
    <!-- Latest Products Section -->
    <section class="latest-section py-5 bg-light" data-aos="fade-up" data-aos-delay="250">
        <div class="container">
            <div class="section-header text-center mb-4" data-aos="fade-up" data-aos-delay="300">
                <div class="section-title">
                    <h2>Tất cả sản phẩm mới nhất</h2>
                    <p class="text-muted">Cập nhật liên tục mỗi ngày</p>
                </div>
            </div>

            <div class="row g-4 products-grid">
                <!-- BEGIN: latest_source -->
                <div class="col-12 col-sm-6 col-md-4 col-lg-3 product-col" data-aos="fade-up" data-aos-delay="{LATEST_SOURCE.aos_delay}">
                    <div class="product-card-wrapper">
                        <div class="card h-100 border-0 shadow-sm">
                            <!-- BEGIN: discount -->
                            <div class="position-absolute top-0 start-0 m-2">
                                <span class="badge bg-danger">-{LATEST_SOURCE.discount_percent}%</span>
                            </div>
                            <!-- END: discount -->

                            <div class="position-relative overflow-hidden">
                                <!-- BEGIN: has_image -->
                                <img src="{LATEST_SOURCE.image_url}" alt="{LATEST_SOURCE.title}" class="card-img-top" style="height: 200px; object-fit: cover;">
                                <!-- END: has_image -->
                                <!-- BEGIN: no_image -->
                                <div class="card-img-top d-flex align-items-center justify-content-center bg-light" style="height: 200px;">
                                    <i class="fa fa-code fs-1 text-muted"></i>
                                </div>
                                <!-- END: no_image -->
                                <div class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center justify-content-center opacity-0 hover-overlay">
                                    <a href="{LATEST_SOURCE.link}" class="btn btn-outline-light btn-sm" aria-label="Xem chi tiết {LATEST_SOURCE.title}">
                                        <i class="fa fa-eye" aria-hidden="true"></i> Xem chi tiết
                                    </a>
                                </div>
                            </div>

                            <div class="card-body d-flex flex-column">
                                <div class="mb-2">
                                    <span class="badge bg-secondary">{LATEST_SOURCE.category_title}</span>
                                </div>

                                <h5 class="card-title h6 mb-2">
                                    <a href="{LATEST_SOURCE.link}" class="text-decoration-none text-dark">{LATEST_SOURCE.title}</a>
                                </h5>

                                <p class="card-text text-muted small mb-3 flex-grow-1">{LATEST_SOURCE.description}</p>

                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <div class="rating">
                                        <i class="fa fa-star text-warning"></i>
                                        <span class="ms-1 small">{LATEST_SOURCE.rating}</span>
                                    </div>
                                    <div class="text-muted small">{LATEST_SOURCE.total_sold} đã bán</div>
                                </div>

                                <div class="d-flex align-items-center justify-content-between mb-3">
                                    <div>
                                        <span class="fw-bold text-primary">{LATEST_SOURCE.price_text}</span>
                                        <!-- BEGIN: original_price -->
                                        <span class="text-muted text-decoration-line-through small ms-2">{LATEST_SOURCE.original_price_text}</span>
                                        <!-- END: original_price -->
                                    </div>
                                </div>

                                <div class="mt-auto">
                                    <a href="{LATEST_SOURCE.link}" class="btn btn-primary w-100" aria-label="Mua {LATEST_SOURCE.title}">
                                        <i class="fa fa-shopping-cart me-1" aria-hidden="true"></i> Mua ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: latest_source -->
            </div>
        </div>
    </section>
    <!-- END: latest_section -->

    <!-- CTA Section - Full Width Clean Design -->
    <section class="py-5 my-5 cta-section-full" data-aos="fade-up" data-aos-delay="200">
        <div class="row">
            <div class="col-12">
                <div class="card border-0 shadow-lg cta-card">
                    <div class="card-body p-5 text-center">
                        <!-- Icon -->
                        <div class="mb-4">
                            <div class="bg-success bg-opacity-10 rounded-circle d-inline-flex align-items-center justify-content-center cta-icon">
                                <i class="fa fa-code fs-1 text-success"></i>
                            </div>
                        </div>

                        <!-- Title -->
                        <h2 class="h3 fw-bold text-dark mb-3 cta-title">
                            Bạn có mã nguồn chất lượng?
                        </h2>

                        <!-- Description -->
                        <p class="text-dark mb-4 fs-6 cta-description">
                            Chia sẻ mã nguồn của bạn với cộng đồng và kiếm thu nhập từ các dự án coding của mình.
                            Tham gia cùng hàng nghìn developer đã tin tưởng ShareCode.
                        </p>

                        <!-- Features -->
                        <div class="row g-3 mb-4 cta-features">
                            <div class="col-md-4">
                                <div class="d-flex align-items-center justify-content-center">
                                    <i class="fa fa-check-circle text-success me-2"></i>
                                    <small class="text-dark fw-medium">Duyệt nhanh</small>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center justify-content-center">
                                    <i class="fa fa-shield-alt text-success me-2"></i>
                                    <small class="text-dark fw-medium">Bảo mật cao</small>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="d-flex align-items-center justify-content-center">
                                    <i class="fa fa-money-bill-wave text-success me-2"></i>
                                    <small class="text-dark fw-medium">Thu nhập ổn định</small>
                                </div>
                            </div>
                        </div>

                        <!-- CTA Button -->
                        <div class="mb-4">
                            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}=sharecode&{NV_OP_VARIABLE}=submit"
                               class="btn btn-success btn-lg px-4 py-3 rounded-pill shadow-sm cta-button"
                               aria-label="Đăng mã nguồn của bạn">
                                <i class="fa fa-upload me-2" aria-hidden="true"></i>
                                Đăng mã nguồn ngay
                            </a>
                        </div>

                        <!-- Additional Info -->
                        <div class="cta-info">
                            <small class="text-dark">
                                <i class="fa fa-info-circle me-1"></i>
                                Miễn phí đăng ký • Hỗ trợ 24/7 • Thanh toán nhanh chóng
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<!-- END: main -->
