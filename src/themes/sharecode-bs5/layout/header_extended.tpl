    <noscript>
        <div class="alert alert-danger">{LANG.nojs}</div>
    </noscript>
    <header id="header" class="fixed-top">
    <div class="container d-flex align-items-center">
        [MENU_SITE]
    </div>
    </header>

    <!-- BEGIN: hero_section -->
    <!-- Hero Section - Chỉ hiển thị khi ở trang home -->
    <div class="hero-section">
        <div class="container">
            <div class="hero-content">
                <div class="row">
                    <!-- Hero Left -->
                    <div class="col-12 hero-left">
                        <h1 class="hero-title">Khám phá nguồn mã chất lượng để tăng tốc dự án của bạn</h1>
                        <p class="hero-description">
                            Hơn 3.000 sản phẩm được kiểm duyệt: web, mobile, AI, game và nhiều hơn nữa. Mua nhanh, triển khai dễ.
                        </p>

                        <!-- Stats -->
                        <div class="row g-3 mt-4 hero-stats-animated">
                            <div class="col-4">
                                <div class="text-center p-3 hero-stats-card rounded">
                                    <div class="h4 mb-1 hero-stats-number fw-bold">3.2k+</div>
                                    <div class="small hero-stats-label">Sản phẩm</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="text-center p-3 hero-stats-card rounded">
                                    <div class="h4 mb-1 hero-stats-number fw-bold">1.5k+</div>
                                    <div class="small hero-stats-label">Nhà phát triển</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="text-center p-3 hero-stats-card rounded">
                                    <div class="h4 mb-1 hero-stats-number fw-bold">4.8/5</div>
                                    <div class="small hero-stats-label">Đánh giá trung bình</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- END: hero_section -->

    <div class="section-body">
        <div class="wraper">
            <section>
                <div class="container" id="body">
                    <!-- BEGIN: breadcrumbs -->
                    <!-- Bootstrap 5 Breadcrumb Section -->
                    <nav class="bg-light py-3 border-bottom" aria-label="breadcrumb">
                        <div class="container">
                            <div class="row">
                                <div class="col-12">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0 bg-transparent p-0" itemscope itemtype="https://schema.org/BreadcrumbList">
                                            <li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                                <a href="{THEME_SITE_HREF}" class="text-decoration-none" itemprop="item" title="{LANG.Home}">
                                                    <i class="fa fa-home me-1"></i>
                                                    <span itemprop="name">{LANG.Home}</span>
                                                </a>
                                                <meta itemprop="position" content="1" />
                                            </li>
                                            <!-- BEGIN: loop -->
                                            <li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                                                <a href="{BREADCRUMBS.link}" class="text-decoration-none" itemprop="item" title="{BREADCRUMBS.title}">
                                                    <span itemprop="name">{BREADCRUMBS.title}</span>
                                                </a>
                                                <meta itemprop="position" content="{BREADCRUMBS.position}" />
                                            </li>
                                            <!-- END: loop -->
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </nav>
                    <!-- END: breadcrumbs -->
                    [THEME_ERROR_INFO]
