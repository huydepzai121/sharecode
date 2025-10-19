<!-- BEGIN: main -->
<div class="search-results-page py-4">
    <div class="container">
        <!-- Sort & Filter Toolbar -->
        <div class="search-toolbar mb-4">
            <div class="card border-0 shadow-sm">
                <div class="card-body p-3">
                    <div class="row align-items-center">
                        <div class="col-12 col-md-6">
                            <div class="results-info">
                                <span class="results-count fw-semibold text-dark">
                                    <i class="fa fa-list-ul text-primary me-2"></i>
                                    Hiển thị <strong>{TOTAL_SOURCES}</strong> kết quả
                                </span>
                            </div>
                        </div>
                        <div class="col-12 col-md-6 text-md-end mt-3 mt-md-0">
                            <form action="{BASE_URL}" method="get" class="sort-form" id="sort-form">
                                <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                                <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
                                <input type="hidden" name="q" value="{SEARCH_KEY}" />
                                <input type="hidden" name="category" value="" />
                                <input type="hidden" name="price_filter" value="" />

                                <div class="d-flex align-items-center justify-content-md-end">
                                    <label class="form-label fw-semibold text-dark me-3 mb-0">Sắp xếp:</label>
                                    <select name="sort" class="form-select form-select-sm" onchange="document.getElementById('sort-form').submit();" style="width: auto; min-width: 150px;">
                                        <!-- BEGIN: sort_option -->
                                        <option value="{SORT.key}" {SORT.selected}>{SORT.label}</option>
                                        <!-- END: sort_option -->
                                    </select>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Sources Grid -->
        <!-- BEGIN: sources -->
        <div class="sources-grid mb-5">
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
                                <!-- BEGIN: contact_price -->
                                <span class="badge bg-info rounded-pill">
                                    <i class="fa fa-phone me-1"></i> LIÊN HỆ
                                </span>
                                <!-- END: contact_price -->
                            </div>
                        </div>

                        <div class="card-body d-flex flex-column">
                            <h5 class="source-title card-title">
                                <a href="{SOURCE.link}" class="text-decoration-none text-dark">{SOURCE.title}</a>
                            </h5>

                            <div class="source-meta mb-3">
                                <div class="source-category mb-2">
                                    <i class="fa fa-folder text-primary me-1"></i>
                                    <a href="{SOURCE.category_link}" class="text-decoration-none small text-muted">{SOURCE.category_title}</a>
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

        <!-- No Results -->
        <!-- BEGIN: no_results -->
        <div class="no-results text-center py-5">
            <div class="mb-4">
                <i class="fa fa-search display-1 text-muted"></i>
            </div>
            <h3 class="h4 text-dark mb-3">Không tìm thấy kết quả nào</h3>
            <p class="text-muted">Vui lòng thử lại với từ khóa khác hoặc điều chỉnh bộ lọc.</p>
        </div>
        <!-- END: no_results -->

        <!-- Pagination -->
        <!-- BEGIN: pagination -->
        <div class="pagination-wrapper text-center mt-5">
            {PAGINATION}
        </div>
        <!-- END: pagination -->
    </div>
</div>

<script>
// Search results page functionality with AOS
document.addEventListener('DOMContentLoaded', function() {
    // Initialize AOS animations - Tắt để tối ưu hiệu suất
    // if (typeof AOS !== 'undefined') {
    //     AOS.init({
    //         duration: 800,
    //         easing: 'ease-in-out',
    //         once: true,
    //         offset: 100,
    //         delay: 0,
    //         disable: function() {
    //             return window.innerWidth < 768;
    //         }
    //     });
    // }

    // Add stagger effect to source cards - Tắt để tối ưu hiệu suất
    // const sourceCards = document.querySelectorAll('.source-card');
    // sourceCards.forEach((card, index) => {
    //     if (card.closest('[data-aos]')) {
    //         card.closest('[data-aos]').setAttribute('data-aos-delay', (index % 6) * 100);
    //     }
    // });

    // Copy current search parameters to sort form
    const searchForm = document.getElementById('search-form');
    const sortForm = document.getElementById('sort-form');

    if (searchForm && sortForm) {
        // Copy search parameters
        const qInput = searchForm.querySelector('input[name="q"]');
        const categorySelect = searchForm.querySelector('select[name="category"]');
        const priceRadios = searchForm.querySelectorAll('input[name="price_filter"]:checked');

        if (qInput) {
            sortForm.querySelector('input[name="q"]').value = qInput.value;
        }
        if (categorySelect) {
            sortForm.querySelector('input[name="category"]').value = categorySelect.value;
        }
        if (priceRadios.length > 0) {
            sortForm.querySelector('input[name="price_filter"]').value = priceRadios[0].value;
        }
    }
});
</script>

<style>
/* ===== SEARCH RESULTS PAGE STYLES - BOOTSTRAP 5 ===== */

/* Search Toolbar */
.search-toolbar .card {
    border-radius: 12px !important;
}

/* Source Cards */
.source-card {
    transition: all 0.3s ease;
    border-radius: 16px !important;
}

.source-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15) !important;
}

.source-image img {
    transition: transform 0.3s ease;
}

.source-card:hover .source-image img {
    transform: scale(1.05);
}

.source-title a {
    transition: color 0.3s ease;
}

.source-card:hover .source-title a {
    color: var(--bs-primary) !important;
}

/* No Results */
.no-results {
    padding: 4rem 2rem;
}

.no-results i {
    transition: all 0.3s ease;
}

.no-results:hover i {
    transform: scale(1.1);
}

/* Responsive Design */
@media (max-width: 767.98px) {
    .sort-form {
        flex-direction: column;
        align-items: flex-start !important;
    }

    .sort-form label {
        margin-bottom: 0.5rem;
    }

    .form-select {
        width: 100% !important;
        min-width: auto !important;
    }

    .source-image img {
        height: 180px !important;
    }

    .no-results {
        padding: 3rem 1rem;
    }
}
</style>
<!-- END: main -->