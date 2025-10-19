<!-- BEGIN: main -->
<div class="author-profile">
    <!-- Author Header Section -->
    <section class="author-header bg-white py-5">
        <div class="container">
            <div class="row g-4 align-items-center">
                <div class="col-12 col-md-4 text-center">
                    <div class="author-avatar-wrapper">
                        <img src="{AUTHOR.avatar_url}" alt="{AUTHOR.display_name}" class="rounded-circle shadow-lg"
                            style="width: 150px; height: 150px; object-fit: cover; border: 4px solid #fff;">
                    </div>
                </div>
                <div class="col-12 col-md-8">
                    <div class="author-info">
                        <h1 class="author-name h2 fw-bold text-dark mb-2">{AUTHOR.display_name}</h1>
                        <p class="author-username text-muted h5 mb-3">@{AUTHOR.username}</p>

                        <!-- BEGIN: has_rating -->
                        <div class="author-rating mb-4 p-3 bg-white rounded-3 shadow-sm">
                            <div class="d-flex align-items-center">
                                <span class="rating-stars text-warning me-2 fs-5">{AUTHOR.rating_stars}</span>
                                <span class="rating-value fw-bold text-primary">({AUTHOR.avg_rating}/5)</span>
                                <span class="text-muted ms-2">• {AUTHOR.total_reviews} đánh giá</span>
                            </div>
                        </div>
                        <!-- END: has_rating -->

                        <div class="author-stats">
                            <div class="row g-3">
                                <div class="col-6 col-lg-3">
                                    <div
                                        class="stat-item text-center p-3 bg-white rounded-3 shadow-sm h-100 d-flex flex-column justify-content-center">
                                        <div class="stat-number fw-bold text-primary mb-1"
                                            style="font-size: clamp(0.8rem, 3.5vw, 1.3rem); line-height: 1.1; word-wrap: break-word; overflow-wrap: break-word;">
                                            {AUTHOR.total_codes}</div>
                                        <div class="stat-label small text-muted">Mã nguồn</div>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-3">
                                    <div
                                        class="stat-item text-center p-3 bg-white rounded-3 shadow-sm h-100 d-flex flex-column justify-content-center">
                                        <div class="stat-number fw-bold text-success mb-1"
                                            style="font-size: clamp(0.8rem, 3.5vw, 1.3rem); line-height: 1.1; word-wrap: break-word; overflow-wrap: break-word;">
                                            {AUTHOR.total_downloads}</div>
                                        <div class="stat-label small text-muted">Lượt tải</div>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-3">
                                    <div
                                        class="stat-item text-center p-3 bg-white rounded-3 shadow-sm h-100 d-flex flex-column justify-content-center">
                                        <div class="stat-number fw-bold text-info mb-1"
                                            style="font-size: clamp(0.8rem, 3.5vw, 1.3rem); line-height: 1.1; word-wrap: break-word; overflow-wrap: break-word;">
                                            {AUTHOR.total_views}</div>
                                        <div class="stat-label small text-muted">Lượt xem</div>
                                    </div>
                                </div>
                                <div class="col-6 col-lg-3">
                                    <div
                                        class="stat-item text-center p-3 bg-white rounded-3 shadow-sm h-100 d-flex flex-column justify-content-center">
                                        <div class="stat-number fw-bold text-secondary mb-1"
                                            style="font-size: clamp(0.7rem, 2.8vw, 1rem); line-height: 1.1; word-wrap: break-word; overflow-wrap: break-word;">
                                            {AUTHOR.join_date}</div>
                                        <div class="stat-label small text-muted">Tham gia</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Content Section -->
    <section class="author-content py-5">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <!-- Filters -->
                    <div class="content-filters mb-4">
                        <div class="row g-3 align-items-center">
                            <div class="col-12 col-lg-8">
                                <h3 class="h4 mb-0 text-dark">
                                    Mã nguồn của {AUTHOR.display_name}
                                    <span class="badge bg-primary rounded-pill ms-2">{TOTAL_SOURCES}</span>
                                </h3>
                            </div>
                            <div class="col-12 col-lg-4">
                                <form method="get" class="filter-form">
                                    <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}">
                                    <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}">
                                    <input type="hidden" name="{NV_OP_VARIABLE}" value="author">
                                    <input type="hidden" name="id" value="{AUTHOR.id}">

                                    <div class="row g-2">
                                        <div class="col-6">
                                            <select name="category" class="form-select form-select-sm"
                                                onchange="this.form.submit()">
                                                <option value="">Tất cả danh mục</option>
                                                <!-- BEGIN: category_filter -->
                                                <option value="{CATEGORY.id}" {CATEGORY.selected}>{CATEGORY.title}
                                                </option>
                                                <!-- END: category_filter -->
                                            </select>
                                        </div>
                                        <div class="col-6">
                                            <select name="sort" class="form-select form-select-sm"
                                                onchange="this.form.submit()">
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
                        <div class="row g-4">
                            <!-- BEGIN: source -->
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="source-card card h-100 border-0 shadow-sm">
                                    <div class="source-image position-relative overflow-hidden">
                                        <a href="{SOURCE.link}" class="d-block">
                                            <img src="{SOURCE.image_url}" alt="{SOURCE.title}" class="card-img-top"
                                                style="height: 200px; object-fit: cover;">
                                        </a>
                                        <div class="source-price position-absolute top-0 end-0 m-2">
                                            <!-- BEGIN: free_price -->
                                            <span class="badge bg-success rounded-pill">Miễn phí</span>
                                            <!-- END: free_price -->
                                            <!-- BEGIN: paid_price -->
                                            <span class="badge bg-primary rounded-pill">{SOURCE.price_text}</span>
                                            <!-- END: paid_price -->
                                        </div>
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="source-title card-title">
                                            <a href="{SOURCE.link}"
                                                class="text-decoration-none text-dark">{SOURCE.title}</a>
                                        </h5>

                                        <div class="source-meta mb-3">
                                            <div class="source-category mb-2">
                                                <i class="fa fa-folder text-primary me-1"></i>
                                                <a href="{SOURCE.category_link}"
                                                    class="text-decoration-none small text-muted">{SOURCE.category_title}</a>
                                            </div>
                                            <div class="source-date">
                                                <i class="fa fa-calendar text-secondary me-1"></i>
                                                <span class="small text-muted">{SOURCE.add_time_format}</span>
                                            </div>
                                        </div>

                                        <!-- BEGIN: rating -->
                                        <div class="source-rating mb-3">
                                            <span class="rating-stars text-warning">{SOURCE.rating_stars}</span>
                                            <span class="rating-count text-muted small">({SOURCE.total_reviews})</span>
                                        </div>
                                        <!-- END: rating -->

                                        <div class="source-stats mt-auto">
                                            <div class="d-flex justify-content-between text-muted small">
                                                <span class="downloads">
                                                    <i class="fa fa-download text-success me-1"></i>
                                                    {SOURCE.num_download}
                                                </span>
                                                <span class="views">
                                                    <i class="fa fa-eye text-info me-1"></i> {SOURCE.num_view}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- END: source -->
                        </div>
                    </div>
                    <!-- END: sources -->

                    <!-- BEGIN: no_sources -->
                    <div class="no-sources text-center py-5">
                        <div class="mb-4">
                            <i class="fa fa-code display-1 text-muted"></i>
                        </div>
                        <h3 class="h4 text-dark mb-3">Chưa có mã nguồn</h3>
                        <p class="text-muted">Tác giả này chưa có mã nguồn nào được phê duyệt.</p>
                    </div>
                    <!-- END: no_sources -->

                    <!-- Pagination -->
                    <!-- BEGIN: pagination -->
                    <div class="pagination-wrapper text-center mt-5">
                        {GENERATE_PAGE}
                    </div>
                    <!-- END: pagination -->
                </div>
            </div>
        </div>
</div>

<style>
    /* ===== AUTHOR PROFILE PAGE STYLES ===== */

    /* Author Header Section */
    .author-header {
        background: #ffffff;
        position: relative;
        overflow: hidden;
        border-bottom: 1px solid #e9ecef;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .author-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(45deg, #f8f9fa 25%, transparent 25%),
            linear-gradient(-45deg, #f8f9fa 25%, transparent 25%),
            linear-gradient(45deg, transparent 75%, #f8f9fa 75%),
            linear-gradient(-45deg, transparent 75%, #f8f9fa 75%);
        background-size: 20px 20px;
        background-position: 0 0, 0 10px, 10px -10px, -10px 0px;
        opacity: 0.03;
    }

    .author-avatar-wrapper {
        position: relative;
        display: inline-block;
    }

    .author-avatar-wrapper::after {
        content: '';
        position: absolute;
        top: -10px;
        left: -10px;
        right: -10px;
        bottom: -10px;
        background: linear-gradient(45deg, #007bff, #0056b3);
        border-radius: 50%;
        z-index: -1;
        opacity: 0.1;
    }

    /* Source Cards */
    .source-card {
        transition: all 0.3s ease;
        border-radius: 12px;
        overflow: hidden;
    }

    .source-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
    }

    .source-card .source-image {
        position: relative;
        overflow: hidden;
    }

    .source-card .source-image img {
        transition: transform 0.3s ease;
    }

    .source-card:hover .source-image img {
        transform: scale(1.05);
    }

    .source-card .card-title a {
        transition: color 0.3s ease;
    }

    .source-card:hover .card-title a {
        color: #007bff !important;
    }

    /* Stats Cards */
    .stat-item {
        transition: all 0.3s ease;
        border-radius: 8px;
        min-height: 90px;
        overflow: visible;
        word-wrap: break-word;
    }

    .stat-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1) !important;
    }

    .stat-number {
        word-break: break-word;
        overflow-wrap: break-word;
        hyphens: auto;
        max-width: 100%;
        display: block;
        white-space: normal;
        text-align: center;
    }

    .stat-label {
        font-size: 0.75rem !important;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 600;
        white-space: normal;
        word-wrap: break-word;
    }

    /* Filter Form */
    .filter-form .form-select {
        border-radius: 6px;
        border: 1px solid #dee2e6;
        transition: all 0.3s ease;
    }

    .filter-form .form-select:focus {
        border-color: #007bff;
        box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    /* Content Filters */
    .content-filters {
        background: #fff;
        border-radius: 12px;
        padding: 1.5rem;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        border: 1px solid #e9ecef;
    }

    /* No Sources State */
    .no-sources {
        background: #fff;
        border-radius: 12px;
        padding: 3rem 2rem;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        border: 1px solid #e9ecef;
    }

    /* Pagination */
    .pagination-wrapper {
        margin-top: 2rem;
    }

    /* Responsive Design */
    @media (max-width: 991.98px) {
        .author-stats .row {
            gap: 0.75rem !important;
        }

        .stat-item {
            min-height: 85px;
            padding: 0.75rem !important;
        }

        .stat-number {
            font-size: clamp(0.8rem, 3.2vw, 1.2rem) !important;
            line-height: 1.2 !important;
        }
    }

    @media (max-width: 767.98px) {
        .author-header {
            padding: 2rem 0;
        }

        .author-avatar-wrapper img {
            width: 120px !important;
            height: 120px !important;
        }

        .author-stats .row {
            gap: 0.5rem !important;
        }

        .stat-item {
            padding: 0.75rem 0.5rem !important;
            min-height: 80px;
        }

        .stat-number {
            font-size: clamp(0.75rem, 2.8vw, 1rem) !important;
            line-height: 1.2 !important;
            margin-bottom: 0.25rem !important;
        }

        .stat-label {
            font-size: 0.65rem !important;
            line-height: 1.3;
        }

        .content-filters .row {
            gap: 1rem !important;
        }

        .filter-form .row {
            gap: 0.5rem !important;
        }
    }

    @media (max-width: 575.98px) {
        .author-header {
            padding: 1.5rem 0;
        }

        .author-info h1 {
            font-size: 1.5rem !important;
        }

        .author-username {
            font-size: 1rem !important;
        }

        .stat-item {
            padding: 0.6rem 0.4rem !important;
            min-height: 75px;
        }

        .stat-number {
            font-size: clamp(0.7rem, 2.3vw, 0.9rem) !important;
            line-height: 1.2 !important;
            margin-bottom: 0.3rem !important;
        }

        .stat-label {
            font-size: 0.6rem !important;
            line-height: 1.3;
        }

        .content-filters {
            padding: 1rem;
        }

        /* Ensure 2x2 grid on very small screens */
        .author-stats .col-6 {
            flex: 0 0 50%;
            max-width: 50%;
        }
    }

    @media (max-width: 375px) {
        .stat-item {
            padding: 0.5rem 0.3rem !important;
            min-height: 70px;
        }

        .stat-number {
            font-size: clamp(0.65rem, 2vw, 0.8rem) !important;
            line-height: 1.2 !important;
        }

        .stat-label {
            font-size: 0.55rem !important;
            line-height: 1.3;
        }
    }
</style>

<script>
    // Initialize AOS and other interactions for Author Profile page
    document.addEventListener('DOMContentLoaded', function () {
        // Initialize AOS animations - Tắt để tối ưu hiệu suất
        // if (typeof AOS !== 'undefined') {
        //     AOS.init({
        //         duration: 800,
        //         easing: 'ease-in-out',
        //         once: true,
        //         offset: 100,
        //         delay: 0,
        //         disable: function () {
        //             // Disable AOS on mobile devices for better performance
        //             return window.innerWidth < 768;
        //         }
        //     });
        // }

        // Add stagger effect to source cards - Tắt để tối ưu hiệu suất
        // const sourceCards = document.querySelectorAll('.source-card');
        // sourceCards.forEach((card, index) => {
        //     if (card.hasAttribute('data-aos')) {
        //         card.setAttribute('data-aos-delay', (index % 6) * 100);
        //     }
        // });

        // Enhanced hover effects for stat items
        const statItems = document.querySelectorAll('.stat-item');
        statItems.forEach(item => {
            item.addEventListener('mouseenter', function () {
                this.style.transform = 'translateY(-3px) scale(1.02)';
            });

            item.addEventListener('mouseleave', function () {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });

        // Add thousand separators to large numbers for better readability
        const statNumbers = document.querySelectorAll('.stat-number');
        statNumbers.forEach(statNumber => {
            const text = statNumber.textContent.trim();
            // Skip if it looks like a date (contains /)
            if (!text.includes('/') && !isNaN(text.replace(/,/g, ''))) {
                const number = parseInt(text.replace(/,/g, ''));
                if (number >= 1000) {
                    // Add thousand separators but keep full number
                    statNumber.textContent = number.toLocaleString('vi-VN');
                }
            }
        });

        // Smooth scroll for pagination links
        const paginationLinks = document.querySelectorAll('.pagination a');
        paginationLinks.forEach(link => {
            link.addEventListener('click', function (e) {
                // Add loading state
                const button = this;
                const originalText = button.innerHTML;
                button.innerHTML = '<i class="fa fa-spinner fa-spin"></i>';

                // Restore after a short delay (will be replaced by actual page load)
                setTimeout(() => {
                    button.innerHTML = originalText;
                }, 1000);
            });
        });

        // Add ripple effect to filter selects
        const filterSelects = document.querySelectorAll('.filter-form select');
        filterSelects.forEach(select => {
            select.addEventListener('change', function () {
                this.style.transform = 'scale(0.98)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 150);
            });
        });
    });
</script>

<!-- END: main -->