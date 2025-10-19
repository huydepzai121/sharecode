<!-- BEGIN: main -->
<div class="search-block">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="card-title mb-0">
                <i class="fa fa-search me-2"></i>Tìm kiếm sản phẩm
            </h5>
        </div>
        <div class="card-body">
            <form action="{NV_BASE_SITEURL}index.php" method="get" role="form" class="search-form">
                <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
                <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
                <input type="hidden" name="{NV_OP_VARIABLE}" value="main" />

                <!-- Search Input -->
                <div class="mb-3">
                    <label for="search-input" class="form-label fw-semibold">
                        <i class="fa fa-keyboard text-primary me-1"></i>Từ khóa tìm kiếm
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light border-end-0">
                            <i class="fa fa-search text-muted"></i>
                        </span>
                        <input type="text"
                               id="search-input"
                               name="q"
                               value="{SEARCH.q}"
                               placeholder="Nhập tên sản phẩm, từ khóa..."
                               class="form-control border-start-0 ps-0"
                               autocomplete="off">
                        <button type="button" class="btn btn-outline-secondary clear-search" title="Xóa từ khóa">
                            <i class="fa fa-times"></i>
                        </button>
                    </div>
                    <div class="form-text">
                        <i class="fa fa-lightbulb text-warning me-1"></i>
                        Gợi ý: Thử tìm "website", "mobile app", "wordpress theme"...
                    </div>
                </div>

                <!-- Category Filter -->
                <!-- BEGIN: category_filter -->
                <div class="mb-3">
                    <label for="category-select" class="form-label fw-semibold">
                        <i class="fa fa-folder text-info me-1"></i>Danh mục
                    </label>
                    <select name="category" id="category-select" class="form-select">
                        <!-- BEGIN: category -->
                        <option value="{CATEGORY.id}" {CATEGORY.selected}>
                            {CATEGORY.title}
                        </option>
                        <!-- END: category -->
                    </select>
                    <div class="form-text">Chọn danh mục để tìm kiếm chính xác hơn</div>
                </div>
                <!-- END: category_filter -->

                <!-- Advanced Filters -->
                <div class="mb-3">
                    <div class="row g-2">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                <i class="fa fa-tag text-success me-1"></i>Loại sản phẩm
                            </label>
                            <select name="fee_type" class="form-select form-select-sm">
                                <!-- BEGIN: fee_type -->
                                <option value="{FEE_TYPE.value}" {FEE_TYPE.selected}>{FEE_TYPE.label}</option>
                                <!-- END: fee_type -->
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                <i class="fa fa-sort text-warning me-1"></i>Sắp xếp theo
                            </label>
                            <select name="sort" class="form-select form-select-sm">
                                <!-- BEGIN: sort_option -->
                                <option value="{SORT_OPTION.value}" {SORT_OPTION.selected}>{SORT_OPTION.label}</option>
                                <!-- END: sort_option -->
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Search Button -->
                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg search-btn">
                        <i class="fa fa-search me-2"></i>Tìm kiếm ngay
                    </button>
                </div>

                <!-- Quick Search Tags -->
                <div class="mt-3">
                    <div class="d-flex flex-wrap gap-1 align-items-center">
                        <small class="text-muted me-2">Tìm kiếm nhanh:</small>
                        <button type="button" class="btn btn-outline-primary btn-sm quick-search" data-keyword="website">
                            Website
                        </button>
                        <button type="button" class="btn btn-outline-primary btn-sm quick-search" data-keyword="mobile app">
                            Mobile App
                        </button>
                        <button type="button" class="btn btn-outline-primary btn-sm quick-search" data-keyword="wordpress">
                            WordPress
                        </button>
                        <button type="button" class="btn btn-outline-primary btn-sm quick-search" data-keyword="ecommerce">
                            E-commerce
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<style>
/* Search Block Styles */
.search-block .card {
    border-radius: 12px;
    overflow: hidden;
    transition: all 0.3s ease;
}

.search-block .card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important;
}

.search-block .card-header {
    background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
    border-bottom: none;
    padding: 1rem 1.25rem;
}

.search-block .card-body {
    padding: 1.5rem 1.25rem;
}

/* Input Group Enhancements */
.search-block .input-group-text {
    background: #f8f9fa;
    border-color: #dee2e6;
}

.search-block .form-control:focus {
    border-color: #007bff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

.search-block .form-select:focus {
    border-color: #007bff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

/* Clear Search Button */
.clear-search {
    border-left: none !important;
}

.clear-search:hover {
    background: #dc3545;
    border-color: #dc3545;
    color: white;
}

/* Search Button */
.search-btn {
    background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
    border: none;
    border-radius: 8px;
    padding: 12px 24px;
    font-weight: 600;
    transition: all 0.2s ease;
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
}

.search-btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 6px 16px rgba(0, 123, 255, 0.4);
}

.search-btn:active {
    transform: translateY(0);
}

/* Quick Search Tags */
.quick-search {
    border-radius: 20px;
    font-size: 0.75rem;
    padding: 0.25rem 0.75rem;
    transition: all 0.2s ease;
}

.quick-search:hover {
    background: #007bff;
    border-color: #007bff;
    color: white;
    transform: scale(1.05);
}

/* Form Labels */
.search-block .form-label {
    color: #495057;
    margin-bottom: 0.5rem;
}

.search-block .form-text {
    font-size: 0.8rem;
    color: #6c757d;
    margin-top: 0.25rem;
}

/* Select States */
.search-block .form-select.selected {
    border-color: #007bff;
    background-color: #f8f9ff;
    font-weight: 500;
}

.search-block .form-select:focus {
    border-color: #007bff;
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
}

/* Quick Search Active State */
.quick-search.active {
    background: #007bff !important;
    border-color: #007bff !important;
    color: white !important;
    transform: scale(0.95);
}

/* Submit Button States */
.search-btn.has-content {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
}

.search-btn.loading {
    pointer-events: none;
    opacity: 0.8;
}

/* Form Validation */
.search-block .form-control.is-invalid {
    border-color: #dc3545;
    background-image: none;
}

.search-block .invalid-feedback {
    display: block;
    font-size: 0.8rem;
    color: #dc3545;
    margin-top: 0.25rem;
}

/* Enhanced Visual Feedback */
.search-block .form-control:valid {
    border-color: #28a745;
}

.search-block .form-select option:checked {
    background-color: #007bff;
    color: white;
}

/* Responsive */
@media (max-width: 768px) {
    .search-block .card-body {
        padding: 1rem;
    }

    .quick-search {
        font-size: 0.7rem;
        padding: 0.2rem 0.6rem;
    }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Clear search functionality
    const clearBtn = document.querySelector('.clear-search');
    const searchInput = document.querySelector('#search-input');

    if (clearBtn && searchInput) {
        clearBtn.addEventListener('click', function() {
            searchInput.value = '';
            searchInput.focus();
            updateClearButtonVisibility();
        });

        // Show/hide clear button based on input
        searchInput.addEventListener('input', updateClearButtonVisibility);

        // Initial state
        updateClearButtonVisibility();

        function updateClearButtonVisibility() {
            clearBtn.style.display = searchInput.value.trim() ? 'block' : 'none';
        }
    }

    // Quick search tags
    const quickSearchBtns = document.querySelectorAll('.quick-search');
    quickSearchBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const keyword = this.dataset.keyword;
            if (searchInput) {
                searchInput.value = keyword;
                searchInput.focus();
                updateClearButtonVisibility();

                // Add visual feedback
                this.classList.add('active');
                setTimeout(() => {
                    this.classList.remove('active');
                }, 200);
            }
        });
    });

    // Form submission enhancement
    const searchForm = document.querySelector('.search-form');
    if (searchForm) {
        searchForm.addEventListener('submit', function(e) {
            const submitBtn = this.querySelector('.search-btn');
            const searchValue = searchInput ? searchInput.value.trim() : '';

            // Validate search input
            if (!searchValue) {
                e.preventDefault();
                searchInput.focus();
                searchInput.classList.add('is-invalid');

                // Show error message
                let errorMsg = searchInput.parentNode.querySelector('.invalid-feedback');
                if (!errorMsg) {
                    errorMsg = document.createElement('div');
                    errorMsg.className = 'invalid-feedback';
                    errorMsg.textContent = 'Vui lòng nhập từ khóa tìm kiếm';
                    searchInput.parentNode.appendChild(errorMsg);
                }

                // Remove error after user types
                searchInput.addEventListener('input', function() {
                    this.classList.remove('is-invalid');
                }, { once: true });

                return false;
            }

            // Show loading state
            if (submitBtn) {
                submitBtn.innerHTML = '<i class="fa fa-spinner fa-spin me-2"></i>Đang tìm kiếm...';
                submitBtn.disabled = true;
                submitBtn.classList.add('loading');
            }
        });
    }

    // Enhanced select styling
    const selects = document.querySelectorAll('.form-select');
    selects.forEach(select => {
        select.addEventListener('change', function() {
            // Add visual feedback for selection
            this.classList.add('selected');

            // Update form state
            updateFormState();
        });

        // Initial state check
        if (select.value && select.value !== '' && select.value !== '0') {
            select.classList.add('selected');
        }
    });

    // Update form state function
    function updateFormState() {
        const hasFilters = Array.from(selects).some(select =>
            select.value && select.value !== '' && select.value !== '0'
        );

        const hasSearch = searchInput && searchInput.value.trim();

        // Update submit button state
        const submitBtn = document.querySelector('.search-btn');
        if (submitBtn) {
            if (hasSearch || hasFilters) {
                submitBtn.classList.add('has-content');
            } else {
                submitBtn.classList.remove('has-content');
            }
        }
    }

    // Initial form state
    updateFormState();

    // Auto-focus search input if no value
    if (searchInput && !searchInput.value.trim()) {
        searchInput.focus();
    }
});
</script>

<!-- END: main -->