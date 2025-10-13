<!-- BEGIN: main -->
<!-- Modern Category Header with Gradient Background -->
<div class="marketplace-header-modern">
    <div class="container">
        <div class="row g-4 align-items-center">
            <div class="col-12 col-lg-8">
                <div class="d-flex align-items-center mb-3">
                    <!-- Animated Category Icon -->
                    <div class="category-icon-modern me-3" role="img" aria-label="Category icon">
                        <div class="icon-background"></div>
                        <i class="fa fa-folder-open fa-3x"></i>
                    </div>
                    <div>
                        <h1 class="category-title-modern display-5 fw-bold mb-2">{CATEGORY.title}</h1>
                        <div class="category-breadcrumb">
                            <span class="badge rounded-pill bg-primary-subtle text-primary px-3 py-2">
                                <i class="fa fa-check-circle me-1"></i> {TOTAL_SOURCES} sản phẩm
                            </span>
                        </div>
                    </div>
                </div>
                <!-- BEGIN: category_description -->
                <div class="category-description-modern">
                    <p class="lead text-white-75 mb-0 lh-base">{CATEGORY.description}</p>
                </div>
                <!-- END: category_description -->
            </div>
            <div class="col-12 col-lg-4">
                <div class="category-stats d-flex justify-content-lg-end justify-content-center">
                    <div class="stat-card-modern card border-0 shadow-lg">
                        <div class="card-body text-center p-4">
                            <div class="stat-icon mb-3">
                                <i class="fa fa-cubes fa-2x text-primary"></i>
                            </div>
                            <div class="stat-number h2 fw-bold text-dark mb-1">{TOTAL_SOURCES}</div>
                            <div class="stat-label text-muted small text-uppercase fw-semibold tracking-wide">Sản phẩm có sẵn</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Subcategories section -->
<!-- BEGIN: subcategories -->
<div class="subcategories-section bg-light py-5">
    <div class="container">
        <h3 class="section-title h4 fw-bold text-dark mb-4">
            <i class="fa fa-sitemap text-primary me-2"></i> Danh mục con
        </h3>
        <div class="row g-4">
            <!-- BEGIN: subcat -->
            <div class="col-12 col-sm-6 col-lg-4 col-xl-3">
                <a href="{SUBCAT.link}" class="subcat-card text-decoration-none">
                    <div class="card h-100 border-0 shadow-sm hover-lift">
                        <div class="card-body text-center p-4">
                            <div class="subcat-icon mb-3">
                                <i class="fa fa-folder fa-2x text-primary"></i>
                            </div>
                            <div class="subcat-info">
                                <h5 class="subcat-name h6 fw-semibold text-dark mb-2">{SUBCAT.title}</h5>
                                <span class="subcat-count badge bg-primary-subtle text-primary">{SUBCAT.total_sources} sản phẩm</span>
                            </div>
                            <div class="subcat-arrow mt-3">
                                <i class="fa fa-chevron-right text-primary"></i>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <!-- END: subcat -->
        </div>
    </div>
</div>
<!-- END: subcategories -->
<!-- Modern Sticky Toolbar with Dropdown Sorting -->
<div class="marketplace-toolbar-modern" id="stickyToolbar">
    <div class="container">
        <div class="row g-3 align-items-center">
            <div class="col-12 col-md-6">
                <div class="toolbar-left">
                    <span class="results-count-modern fw-semibold">
                        <i class="fa fa-check-circle me-2"></i>
                        <span class="count-number">{TOTAL_SOURCES}</span> sản phẩm được tìm thấy
                    </span>
                </div>
            </div>
            <div class="col-12 col-md-6">
                <div class="toolbar-right d-flex align-items-center justify-content-md-end gap-3">
                    <!-- Modern Dropdown Sort -->
                    <div class="dropdown sort-dropdown-modern">
                        <button class="btn btn-outline-primary dropdown-toggle" type="button" id="sortDropdown"
                                data-bs-toggle="dropdown" aria-expanded="false" aria-label="Sort products">
                            <i class="fa fa-sort me-2"></i>
                            <span class="sort-label">Sắp xếp</span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg" aria-labelledby="sortDropdown">
                            <!-- BEGIN: sort_links -->
                            <!-- BEGIN: sort -->
                            <!-- BEGIN: active -->
                            <li>
                                <a class="dropdown-item active" href="{SORT.link}">
                                    <i class="fa fa-check me-2"></i>{SORT.name}
                                </a>
                            </li>
                            <!-- END: active -->
                            <!-- BEGIN: inactive -->
                            <li>
                                <a class="dropdown-item" href="{SORT.link}">{SORT.name}</a>
                            </li>
                            <!-- END: inactive -->
                            <!-- END: sort -->
                            <!-- END: sort_links -->
                        </ul>
                    </div>

                    <!-- View Toggle Buttons -->
                    <div class="btn-group view-toggle-modern" role="group" aria-label="View toggle">
                        <button type="button" class="btn btn-outline-primary active" data-view="grid"
                                aria-label="Grid view" title="Xem dạng lưới">
                            <i class="fa fa-th"></i>
                        </button>
                        <button type="button" class="btn btn-outline-primary" data-view="list"
                                aria-label="List view" title="Xem dạng danh sách">
                            <i class="fa fa-list"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modern Products Grid with Animations -->
<!-- BEGIN: sources -->
<div class="marketplace-products-modern py-5">
    <div class="container">
        <div class="row g-4" id="productsGrid">
            <!-- BEGIN: source -->
            <div class="col-12 col-md-6 col-lg-4 product-col-modern">
                <div class="product-card-modern card h-100 border-0 shadow-sm">
                    <!-- Product Image with Overlay -->
                    <div class="product-image-wrapper">
                        <a href="{SOURCE.link}" class="d-block">
                            <img src="{SOURCE.image_url}" alt="{SOURCE.title}"
                                 class="product-image" loading="lazy">
                        </a>

                        <!-- Price Badge with Gradient -->
                        <div class="price-badge-modern">
                            <!-- BEGIN: badge_free -->
                            <span class="badge badge-free">
                                <i class="fa fa-gift me-1"></i>Miễn phí
                            </span>
                            <!-- END: badge_free -->
                            <!-- BEGIN: badge_paid -->
                            <span class="badge badge-paid">
                                <i class="fa fa-tag me-1"></i>{SOURCE.fee_amount_formatted}
                            </span>
                            <!-- END: badge_paid -->
                            <!-- BEGIN: badge_contact -->
                            <span class="badge badge-contact">
                                <i class="fa fa-phone me-1"></i>Liên hệ
                            </span>
                            <!-- END: badge_contact -->
                        </div>

                        <!-- Hover Overlay with Actions -->
                        <div class="product-overlay">
                            <div class="overlay-actions">
                                <button class="btn-icon-modern btn-quick-view" data-id="{SOURCE.id}"
                                        aria-label="Quick view" title="Xem nhanh">
                                    <i class="fa fa-eye"></i>
                                </button>
                                <button class="btn-icon-modern btn-favorite" data-id="{SOURCE.id}"
                                        aria-label="Add to favorites" title="Yêu thích">
                                    <i class="fa fa-heart-o"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Product Info -->
                    <div class="card-body d-flex flex-column p-3">
                        <!-- Product Meta -->
                        <div class="product-meta-modern mb-2">
                            <span class="meta-item">
                                <i class="fa fa-folder-o me-1"></i>{SOURCE.category_title}
                            </span>
                            <span class="meta-separator">•</span>
                            <span class="meta-item">
                                <i class="fa fa-clock-o me-1"></i>{SOURCE.add_time_format}
                            </span>
                        </div>

                        <!-- Product Title -->
                        <h5 class="product-title-modern mb-2">
                            <a href="{SOURCE.link}" class="text-decoration-none">{SOURCE.title}</a>
                        </h5>

                        <!-- BEGIN: rating -->
                        <div class="product-rating-modern mb-3">
                            <span class="rating-stars text-warning">{SOURCE.rating_stars}</span>
                            <span class="rating-count">({SOURCE.total_reviews})</span>
                        </div>
                        <!-- END: rating -->

                        <!-- Product Stats -->
                        <div class="product-stats-modern mt-auto">
                            <div class="stat-item">
                                <i class="fa fa-download"></i>
                                <span>{SOURCE.num_download}</span>
                            </div>
                            <div class="stat-item">
                                <i class="fa fa-eye"></i>
                                <span>{SOURCE.num_view}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END: source -->
        </div>
    </div>
</div>
<!-- END: sources -->
<!-- No sources message -->
<!-- BEGIN: no_sources -->
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-6">
            <div class="text-center">
                <div class="mb-4">
                    <i class="fa fa-code display-1 text-muted"></i>
                </div>
                <h4 class="h5 fw-semibold text-dark mb-3">Không có mã nguồn nào</h4>
                <p class="text-muted">Hiện tại chưa có mã nguồn nào trong danh mục này.</p>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}=sharecode" class="btn btn-primary">
                    <i class="fa fa-arrow-left me-2"></i> Quay lại trang chủ
                </a>
            </div>
        </div>
    </div>
</div>
<!-- END: no_sources -->

<!-- Pagination -->
<!-- BEGIN: pagination -->
<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="d-flex justify-content-center">
                {GENERATE_PAGE}
            </div>
        </div>
    </div>
</div>
<!-- END: pagination -->
<!-- END: main -->
<style>
/* ===== MODERN CATEGORY PAGE DESIGN SYSTEM ===== */

/* ===== CSS CUSTOM PROPERTIES (Design Tokens) ===== */
:root {
    /* Color System */
    --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    --success-gradient: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
    --primary-color: #667eea;
    --primary-dark: #764ba2;
    --success-color: #11998e;
    --success-light: #38ef7d;
    --text-primary: #2c3e50;
    --text-secondary: #6c757d;
    --text-white: #ffffff;
    --text-white-75: rgba(255, 255, 255, 0.75);

    /* Shadows */
    --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.08);
    --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.12);
    --shadow-lg: 0 8px 24px rgba(0, 0, 0, 0.15);
    --shadow-xl: 0 12px 32px rgba(0, 0, 0, 0.18);

    /* Border Radius */
    --radius-sm: 8px;
    --radius-md: 12px;
    --radius-lg: 16px;
    --radius-xl: 20px;

    /* Typography Scale */
    --font-display-1: 3.5rem;
    --font-h1: 2.5rem;
    --font-h2: 2rem;
    --font-h3: 1.75rem;
    --font-lead: 1.25rem;
    --font-body: 1rem;
    --font-small: 0.875rem;
    --font-tiny: 0.75rem;

    /* Spacing (8px grid) */
    --space-1: 8px;
    --space-2: 16px;
    --space-3: 24px;
    --space-4: 32px;
    --space-5: 48px;
    --space-6: 64px;

    /* Transitions */
    --transition-base: cubic-bezier(0.4, 0, 0.2, 1);
    --transition-duration: 0.3s;
}

/* ===== MODERN HEADER WITH GRADIENT ===== */
.marketplace-header-modern {
    background: var(--primary-gradient);
    padding: var(--space-5) 0;
    position: relative;
    overflow: hidden;
    color: var(--text-white);
}

/* Animated pattern overlay */
.marketplace-header-modern::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-image:
        repeating-linear-gradient(45deg, transparent, transparent 10px, rgba(255,255,255,.05) 10px, rgba(255,255,255,.05) 20px);
    pointer-events: none;
}

/* Animated Category Icon */
.category-icon-modern {
    position: relative;
    width: 80px;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--text-white);
}

.category-icon-modern .icon-background {
    position: absolute;
    width: 100%;
    height: 100%;
    background: rgba(255, 255, 255, 0.2);
    border-radius: var(--radius-md);
    transform: rotate(45deg);
    animation: pulse 2s ease-in-out infinite;
}

@keyframes pulse {
    0%, 100% {
        transform: rotate(45deg) scale(1);
        opacity: 0.8;
    }
    50% {
        transform: rotate(45deg) scale(1.1);
        opacity: 1;
    }
}

.category-icon-modern i {
    position: relative;
    z-index: 1;
}

/* Category Title */
.category-title-modern {
    color: var(--text-white);
    font-size: var(--font-h1);
    line-height: 1.2;
    margin-bottom: var(--space-2);
}

.category-description-modern {
    max-width: 600px;
}

.text-white-75 {
    color: var(--text-white-75);
}

/* Stat Card */
.stat-card-modern {
    transition: all var(--transition-duration) var(--transition-base);
    border-radius: var(--radius-lg) !important;
    backdrop-filter: blur(10px);
    background: rgba(255, 255, 255, 0.95) !important;
}

.stat-card-modern:hover {
    transform: translateY(-8px);
    box-shadow: var(--shadow-xl) !important;
}

.stat-card-modern .stat-icon {
    transition: all var(--transition-duration) var(--transition-base);
}

.stat-card-modern:hover .stat-icon {
    transform: scale(1.15) rotate(5deg);
}

.tracking-wide {
    letter-spacing: 0.05em;
}

/* ===== SUBCATEGORIES SECTION ===== */
.subcategories-section {
    border-bottom: 1px solid #e9ecef;
}

.subcat-card {
    transition: all var(--transition-duration) var(--transition-base);
    position: relative;
}

.subcat-card:hover {
    text-decoration: none;
}

.subcat-card .card {
    transition: all var(--transition-duration) var(--transition-base);
    border: 1px solid #e9ecef;
    border-radius: var(--radius-md);
}

.subcat-card:hover .card {
    transform: translateY(-5px);
    box-shadow: var(--shadow-lg) !important;
    border-color: var(--primary-color);
}

.subcat-arrow {
    transition: all var(--transition-duration) var(--transition-base);
    opacity: 0.6;
}

.subcat-card:hover .subcat-arrow {
    opacity: 1;
    transform: translateX(3px);
}

/* ===== MODERN STICKY TOOLBAR ===== */
.marketplace-toolbar-modern {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    padding: var(--space-2) 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
    box-shadow: var(--shadow-sm);
    position: sticky;
    top: 0;
    z-index: 1020;
    transition: all var(--transition-duration) var(--transition-base);
}

.marketplace-toolbar-modern.scrolled {
    box-shadow: var(--shadow-md);
}

/* Results Count */
.results-count-modern {
    color: var(--text-primary);
    font-size: var(--font-body);
}

.results-count-modern .count-number {
    color: var(--primary-color);
    font-weight: 700;
}

/* Modern Dropdown Sort */
.sort-dropdown-modern .dropdown-toggle {
    border-radius: var(--radius-md);
    padding: 0.5rem 1rem;
    font-weight: 500;
    transition: all var(--transition-duration) var(--transition-base);
}

.sort-dropdown-modern .dropdown-toggle:hover {
    transform: translateY(-2px);
    box-shadow: var(--shadow-sm);
}

.sort-dropdown-modern .dropdown-menu {
    border-radius: var(--radius-md);
    border: none;
    box-shadow: var(--shadow-lg);
    padding: 0.5rem;
    margin-top: 0.5rem;
}

.sort-dropdown-modern .dropdown-item {
    border-radius: var(--radius-sm);
    padding: 0.5rem 1rem;
    transition: all 0.2s ease;
    font-size: var(--font-small);
}

.sort-dropdown-modern .dropdown-item:hover {
    background: rgba(102, 126, 234, 0.1);
    color: var(--primary-color);
    transform: translateX(4px);
}

.sort-dropdown-modern .dropdown-item.active {
    background: var(--primary-gradient);
    color: var(--text-white);
}

.sort-dropdown-modern .dropdown-item.active i {
    color: var(--text-white);
}

/* View Toggle Buttons */
.view-toggle-modern .btn {
    border-radius: var(--radius-sm);
    padding: 0.5rem 0.75rem;
    transition: all var(--transition-duration) var(--transition-base);
}

.view-toggle-modern .btn:hover {
    transform: translateY(-2px);
}

.view-toggle-modern .btn.active {
    background: var(--primary-gradient);
    border-color: var(--primary-color);
    color: var(--text-white);
}

.view-toggle-modern .btn:first-child {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}

.view-toggle-modern .btn:last-child {
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}

/* ===== MODERN PRODUCT CARDS ===== */
.marketplace-products-modern {
    background: #f8f9fa;
}

.product-col-modern {
    animation: fadeInUp 0.6s var(--transition-base) both;
}

/* Staggered animation delays */
.product-col-modern:nth-child(1) { animation-delay: 0.1s; }
.product-col-modern:nth-child(2) { animation-delay: 0.2s; }
.product-col-modern:nth-child(3) { animation-delay: 0.3s; }
.product-col-modern:nth-child(4) { animation-delay: 0.4s; }

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.product-card-modern {
    transition: all var(--transition-duration) var(--transition-base);
    border-radius: var(--radius-lg);
    overflow: hidden;
    background: var(--text-white);
}

.product-card-modern:hover {
    transform: translateY(-8px);
    box-shadow: var(--shadow-xl) !important;
}

/* Product Image with 16:10 Aspect Ratio */
.product-image-wrapper {
    position: relative;
    overflow: hidden;
    aspect-ratio: 16 / 10;
    background: #f0f0f0;
}

.product-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform var(--transition-duration) var(--transition-base);
}

.product-card-modern:hover .product-image {
    transform: scale(1.08);
}

/* Price Badge with Gradient */
.price-badge-modern {
    position: absolute;
    top: var(--space-2);
    right: var(--space-2);
    z-index: 10;
}

.price-badge-modern .badge {
    padding: 0.5rem 1rem;
    font-size: var(--font-small);
    font-weight: 600;
    border-radius: var(--radius-md);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    box-shadow: var(--shadow-md);
}

.badge-free {
    background: var(--success-gradient) !important;
    color: var(--text-white);
}

.badge-paid {
    background: var(--primary-gradient) !important;
    color: var(--text-white);
}

.badge-contact {
    background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%) !important;
    color: var(--text-white);
}

/* Hover Overlay */
.product-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.7) 0%, transparent 50%);
    opacity: 0;
    transition: opacity var(--transition-duration) var(--transition-base);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 5;
}

.product-card-modern:hover .product-overlay {
    opacity: 1;
}

/* Overlay Action Buttons */
.overlay-actions {
    display: flex;
    gap: var(--space-2);
    transform: translateY(20px);
    transition: transform var(--transition-duration) var(--transition-base);
}

.product-card-modern:hover .overlay-actions {
    transform: translateY(0);
}

.btn-icon-modern {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background: var(--text-white);
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: var(--shadow-md);
}

.btn-icon-modern:hover {
    transform: scale(1.1);
    background: var(--primary-gradient);
    color: var(--text-white);
}

.btn-icon-modern i {
    font-size: 1.25rem;
}

/* Product Info Section */
.product-meta-modern {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: var(--font-tiny);
    color: var(--text-secondary);
}

.meta-item {
    display: inline-flex;
    align-items: center;
}

.meta-separator {
    opacity: 0.5;
}

/* Product Title */
.product-title-modern {
    font-size: 1.125rem;
    line-height: 1.4;
    min-height: 2.8em;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.product-title-modern a {
    color: var(--text-primary);
    transition: color 0.2s ease;
}

.product-title-modern a:hover {
    color: var(--primary-color);
}

/* Product Rating */
.product-rating-modern {
    font-size: var(--font-small);
}

.rating-count {
    color: var(--text-secondary);
    margin-left: 0.25rem;
}

/* Product Stats */
.product-stats-modern {
    display: flex;
    gap: var(--space-2);
    padding-top: var(--space-2);
    border-top: 1px solid #e9ecef;
}

.product-stats-modern .stat-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: var(--font-small);
    color: var(--text-secondary);
}

.product-stats-modern .stat-item i {
    color: var(--primary-color);
}

/* ===== RESPONSIVE DESIGN ===== */

/* Tablet (< 992px) */
@media (max-width: 991.98px) {
    .category-title-modern {
        font-size: var(--font-h2);
    }

    .product-col-modern:nth-child(n+5) {
        animation-delay: 0.1s;
    }
}

/* Mobile (< 768px) */
@media (max-width: 767.98px) {
    .marketplace-header-modern {
        padding: var(--space-4) 0;
        text-align: center;
    }

    .category-icon-modern {
        margin: 0 auto var(--space-2);
    }

    .category-title-modern {
        font-size: var(--font-h3);
    }

    .marketplace-toolbar-modern .row {
        flex-direction: column;
        gap: var(--space-2);
    }

    .toolbar-right {
        flex-direction: column !important;
        width: 100%;
    }

    .sort-dropdown-modern,
    .view-toggle-modern {
        width: 100%;
    }

    .sort-dropdown-modern .dropdown-toggle {
        width: 100%;
        justify-content: space-between;
    }

    .product-col-modern {
        animation-delay: 0s !important;
    }
}

/* Small Mobile (< 576px) */
@media (max-width: 575.98px) {
    .marketplace-header-modern {
        padding: var(--space-3) 0;
    }

    .category-title-modern {
        font-size: 1.75rem;
    }

    .category-icon-modern {
        width: 60px;
        height: 60px;
    }

    .category-icon-modern i {
        font-size: 2rem;
    }

    .stat-card-modern {
        min-width: auto !important;
    }

    .btn-icon-modern {
        width: 40px;
        height: 40px;
    }

    .btn-icon-modern i {
        font-size: 1rem;
    }
}

/* ===== ACCESSIBILITY IMPROVEMENTS ===== */

/* Focus States */
.product-card-modern:focus-within {
    outline: 2px solid var(--primary-color);
    outline-offset: 2px;
}

.btn-icon-modern:focus,
.sort-dropdown-modern .dropdown-toggle:focus,
.view-toggle-modern .btn:focus {
    outline: 2px solid var(--primary-color);
    outline-offset: 2px;
}

/* Reduced Motion */
@media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }
}

/* High Contrast Mode */
@media (prefers-contrast: high) {
    .product-card-modern {
        border: 2px solid var(--text-primary);
    }

    .btn-icon-modern {
        border: 2px solid var(--text-primary);
    }
}

</style>

<script>
// Modern Category Page Functionality
document.addEventListener('DOMContentLoaded', function() {
    // ===== STICKY TOOLBAR SCROLL EFFECT =====
    const toolbar = document.getElementById('stickyToolbar');
    if (toolbar) {
        let lastScroll = 0;
        window.addEventListener('scroll', function() {
            const currentScroll = window.pageYOffset;

            if (currentScroll > 100) {
                toolbar.classList.add('scrolled');
            } else {
                toolbar.classList.remove('scrolled');
            }

            lastScroll = currentScroll;
        }, { passive: true });
    }

    // ===== VIEW TOGGLE FUNCTIONALITY =====
    const viewToggleBtns = document.querySelectorAll('.view-toggle-modern .btn');
    const productsGrid = document.getElementById('productsGrid');

    viewToggleBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const view = this.getAttribute('data-view');

            // Update active state
            viewToggleBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');

            // Toggle grid/list view
            if (view === 'list') {
                productsGrid.classList.add('list-view');
                productsGrid.querySelectorAll('.product-col-modern').forEach(col => {
                    col.classList.remove('col-md-6', 'col-lg-4');
                    col.classList.add('col-12');
                });
            } else {
                productsGrid.classList.remove('list-view');
                productsGrid.querySelectorAll('.product-col-modern').forEach(col => {
                    col.classList.remove('col-12');
                    col.classList.add('col-md-6', 'col-lg-4');
                });
            }

            // Save preference to localStorage
            localStorage.setItem('sharecode_view_preference', view);
        });
    });

    // Restore view preference
    const savedView = localStorage.getItem('sharecode_view_preference');
    if (savedView === 'list') {
        const listBtn = document.querySelector('.view-toggle-modern .btn[data-view="list"]');
        if (listBtn) {
            listBtn.click();
        }
    }

    // ===== FAVORITE BUTTON FUNCTIONALITY =====
    document.querySelectorAll('.btn-favorite').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();

            const sourceId = this.getAttribute('data-id');
            const icon = this.querySelector('i');

            // Toggle favorite state
            if (icon.classList.contains('fa-heart-o')) {
                icon.classList.remove('fa-heart-o');
                icon.classList.add('fa-heart');
                this.classList.add('favorited');
                addToFavorites(sourceId);
                nukeviet.toast('success', 'Đã thêm vào yêu thích');
            } else {
                icon.classList.remove('fa-heart');
                icon.classList.add('fa-heart-o');
                this.classList.remove('favorited');
                removeFromFavorites(sourceId);
                nukeviet.toast('info', 'Đã xóa khỏi yêu thích');
            }
        });
    });

    // Load favorite states
    loadFavoriteStates();

    // ===== QUICK VIEW HANDLER =====
    document.querySelectorAll('.btn-quick-view').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();

            const sourceId = this.getAttribute('data-id');
            showPreview(sourceId);
        });
    });

    // ===== LAZY LOADING IMAGES =====
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    if (img.dataset.src) {
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                    }
                    observer.unobserve(img);
                }
            });
        }, {
            rootMargin: '50px'
        });

        document.querySelectorAll('img[loading="lazy"]').forEach(img => {
            imageObserver.observe(img);
        });
    }

    // ===== KEYBOARD NAVIGATION =====
    document.querySelectorAll('.product-card-modern').forEach(card => {
        card.setAttribute('tabindex', '0');
        card.addEventListener('keypress', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                const link = this.querySelector('.product-title-modern a');
                if (link) {
                    link.click();
                }
            }
        });
    });
});

// ===== FAVORITES MANAGEMENT =====
function addToFavorites(sourceId) {
    let favorites = JSON.parse(localStorage.getItem('sharecode_favorites') || '[]');
    if (!favorites.includes(sourceId)) {
        favorites.push(sourceId);
        localStorage.setItem('sharecode_favorites', JSON.stringify(favorites));
    }
}

function removeFromFavorites(sourceId) {
    let favorites = JSON.parse(localStorage.getItem('sharecode_favorites') || '[]');
    favorites = favorites.filter(id => id !== sourceId);
    localStorage.setItem('sharecode_favorites', JSON.stringify(favorites));
}

function loadFavoriteStates() {
    const favorites = JSON.parse(localStorage.getItem('sharecode_favorites') || '[]');
    favorites.forEach(sourceId => {
        const btn = document.querySelector(`.btn-favorite[data-id="${sourceId}"]`);
        if (btn) {
            const icon = btn.querySelector('i');
            icon.classList.remove('fa-heart-o');
            icon.classList.add('fa-heart');
            btn.classList.add('favorited');
        }
    });
}

// ===== PREVIEW MODAL =====
function showPreview(sourceId) {
    // Show loading state
    nukeviet.toast('info', 'Đang tải xem trước...');

    // Fetch preview data via AJAX
    fetch(nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=sharecode&' + nv_op_variable + '=preview&id=' + sourceId)
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                showPreviewModal(data.content);
            } else {
                nukeviet.toast('error', data.message || 'Không thể tải xem trước');
            }
        })
        .catch(error => {
            console.error('Preview error:', error);
            nukeviet.toast('error', 'Có lỗi xảy ra khi tải xem trước');
        });
}

function showPreviewModal(content) {
    // Create and show Bootstrap 5 modal with preview content
    const modalHtml = `
        <div class="modal fade" id="previewModal" tabindex="-1" aria-labelledby="previewModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="previewModalLabel">
                            <i class="fa fa-eye me-2"></i>Xem trước sản phẩm
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ${content}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    `;

    // Remove existing modal
    const existingModal = document.getElementById('previewModal');
    if (existingModal) {
        existingModal.remove();
    }

    // Add new modal
    document.body.insertAdjacentHTML('beforeend', modalHtml);

    // Show modal
    const modal = new bootstrap.Modal(document.getElementById('previewModal'));
    modal.show();
}

// ===== PERFORMANCE MONITORING =====
if (window.performance && window.performance.timing) {
    window.addEventListener('load', function() {
        setTimeout(function() {
            const perfData = window.performance.timing;
            const pageLoadTime = perfData.loadEventEnd - perfData.navigationStart;

            // Log performance metrics (for development)
            if (pageLoadTime > 3000) {
                console.warn('Page load time exceeds 3 seconds:', pageLoadTime + 'ms');
            }

            // Send to analytics if available
            if (typeof gtag !== 'undefined') {
                gtag('event', 'timing_complete', {
                    'name': 'category_page_load',
                    'value': pageLoadTime,
                    'event_category': 'Performance'
                });
            }
        }, 0);
    });
}

// ===== ACCESSIBILITY: Skip to content =====
const skipLink = document.createElement('a');
skipLink.href = '#productsGrid';
skipLink.className = 'visually-hidden-focusable';
skipLink.textContent = 'Bỏ qua đến danh sách sản phẩm';
skipLink.style.cssText = 'position:absolute;top:0;left:0;padding:1rem;background:#fff;z-index:9999;';
document.body.insertBefore(skipLink, document.body.firstChild);
</script>

<style>
/* Additional CSS for favorited state */
.btn-favorite.favorited {
    background: var(--primary-gradient) !important;
    color: var(--text-white) !important;
}

.btn-favorite.favorited i {
    color: var(--text-white) !important;
}

/* List view styles */
#productsGrid.list-view .product-card-modern {
    display: flex;
    flex-direction: row;
}

#productsGrid.list-view .product-image-wrapper {
    width: 300px;
    flex-shrink: 0;
}

#productsGrid.list-view .card-body {
    flex: 1;
    display: flex;
    flex-direction: column;
}

@media (max-width: 767.98px) {
    #productsGrid.list-view .product-card-modern {
        flex-direction: column;
    }

    #productsGrid.list-view .product-image-wrapper {
        width: 100%;
    }
}

/* Visually hidden but focusable for accessibility */
.visually-hidden-focusable:not(:focus):not(:focus-within) {
    position: absolute !important;
    width: 1px !important;
    height: 1px !important;
    padding: 0 !important;
    margin: -1px !important;
    overflow: hidden !important;
    clip: rect(0, 0, 0, 0) !important;
    white-space: nowrap !important;
    border: 0 !important;
}
</style>
