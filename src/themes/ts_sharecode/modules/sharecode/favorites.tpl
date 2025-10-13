<!-- BEGIN: main -->
<!-- CSS imports - Nhất quán với detail.tpl -->
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/assets/vendor/boxicons/css/boxicons.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/assets/vendor/remixicon/remixicon.css">

<div class="container">
    <div class="favorites-page">
        <div class="page-header">
            <h1><i class="bx bxs-heart text-danger"></i> Sản phẩm yêu thích</h1>
            <p class="text-muted">Tổng số: <strong>{TOTAL_FAVORITES}</strong></p>
        </div>

        <!-- BEGIN: favorites -->
        <!-- Danh sách favorites: Sử dụng CSS Grid giống main.tpl -->
        <div class="sources-list">
            <!-- BEGIN: favorite -->
            <!-- Block favorite: Loop qua từng item trong danh sách favorites -->
            <div class="source-item favorite-card">
                <div class="source-image">
                    <div class="source-price">
                        <span class="price-badge badge-{FAVORITE.price_class}">
                            <i class="bx bx-tag"></i> {FAVORITE.price_display}
                        </span>
                    </div>
                    <a href="{FAVORITE.link}">
                        <img src="{FAVORITE.image_url}" alt="{FAVORITE.title}" class="img-responsive">
                    </a>
                </div>

                <div class="source-content">
                    <div class="source-header">
                        <h3 class="source-title">
                            <a href="{FAVORITE.link}">{FAVORITE.title}</a>
                        </h3>
                    </div>

                    <div class="source-meta">
                        <span class="source-category">
                            <i class="bx bx-folder"></i> {FAVORITE.category_title}
                        </span>
                        <span class="source-date">
                            <i class="bx bx-time"></i> {FAVORITE.add_time_format}
                        </span>
                    </div>

                    <!-- Star Rating -->
                    <div class="star-rating">
                        <span class="text-warning">{FAVORITE.rating_stars}</span>
                        <span class="rating-text">({FAVORITE.avg_rating})</span>
                    </div>

                    <div class="source-stats">
                        <span class="stat-item">
                            <i class="bx bx-show"></i> {FAVORITE.num_view}
                        </span>
                        <span class="stat-item">
                            <i class="bx bx-download"></i> {FAVORITE.num_download}
                        </span>
                    </div>

                    <div class="source-actions">
                        <a href="{FAVORITE.link}" class="btn btn-primary">
                            <i class="bx bx-show"></i> Xem chi tiết
                        </a>
                        <button type="button" class="btn btn-danger remove-favorite"
                            data-source-id="{FAVORITE.id}" data-checkss="{FAVORITE.remove_checkss}"
                            title="Xóa khỏi yêu thích">
                            <i class="bx bxs-heart"></i> Xóa
                        </button>
                    </div>
                </div>
            </div>
            <!-- END: favorite -->
        </div>
        <!-- END: favorites -->

        <!-- BEGIN: no_favorites -->
        <!-- Block no_favorites: Hiển thị khi không có favorites nào -->
        <div class="row">
            <div class="col-md-24">
                <div class="empty-state text-center">
                    <div class="empty-icon">
                        <i class="bx bx-heart"></i>
                    </div>
                    <h3>Chưa có sản phẩm yêu thích nào</h3>
                    <p class="text-muted">
                        Bạn chưa có sản phẩm yêu thích nào. Hãy khám phá và thêm những sản phẩm bạn quan tâm vào danh sách yêu thích.
                    </p>
                    <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary">
                        <i class="bx bx-search"></i> Khám phá sản phẩm
                    </a>
                </div>
            </div>
        </div>
        <!-- END: no_favorites -->

        <!-- BEGIN: generate_page -->
        <!-- Block generate_page: Hiển thị pagination khi có nhiều trang -->
        <div class="row">
            <div class="col-md-24">
                <div class="text-center pagination-wrapper">
                    {GENERATE_PAGE}
                </div>
            </div>
        </div>
        <!-- END: generate_page -->
    </div>    
</div>

<script>
    $(document).ready(function () {
        /**
         * Xử lý xóa sản phẩm khỏi danh sách yêu thích
         * - Sử dụng nukeviet.toast() thay vì alert()
         * - Hiển thị spinner bx bx-loader bx-spin khi processing
         * - Gửi AJAX request với checkss validation (CSRF protection)
         * - Cập nhật số lượng trong .page-header strong
         * - Fade out card và reload nếu hết favorites
         */
        $('.remove-favorite').click(function (e) {
            e.preventDefault();

            var $btn = $(this);
            var sourceId = $btn.data('source-id');
            var checkss = $btn.data('checkss');
            var $card = $btn.closest('.source-item');

            // Sử dụng nukeviet.toast để confirm thay vì alert
            if (confirm('Bạn có chắc chắn muốn xóa khỏi danh sách yêu thích?')) {
                // Hiển thị spinner Boxicons khi processing
                $btn.prop('disabled', true).html('<i class="bx bx-loader bx-spin"></i> Đang xử lý');

                // Gửi AJAX request với checkss validation (CSRF protection)
                $.ajax({
                    url: '{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=favorites&remove=' + sourceId + '&checkss=' + checkss,
                    type: 'GET',
                    dataType: 'json',
                    success: function (response) {
                        if (response.status === 'success') {
                            // Hiệu ứng fade out và remove card
                            $card.fadeOut(300, function () {
                                $(this).remove();

                                // Cập nhật số lượng trong page header
                                var currentTotal = parseInt($('.page-header strong').text());
                                $('.page-header strong').text(currentTotal - 1);

                                // Kiểm tra nếu không còn favorites nào thì reload
                                if ($('.favorite-card').length === 0) {
                                    location.reload();
                                }
                            });

                            // Hiển thị thông báo thành công bằng nukeviet.toast
                            if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                                nukeviet.toast(response.message || 'Đã xóa khỏi danh sách yêu thích', 'success');
                            }
                        } else {
                            // Hiển thị thông báo lỗi bằng nukeviet.toast
                            if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                                nukeviet.toast(response.message || 'Có lỗi xảy ra', 'error');
                            }
                            // Khôi phục button về trạng thái ban đầu
                            $btn.prop('disabled', false).html('<i class="bx bxs-heart"></i> Xóa khỏi yêu thích');
                        }
                    },
                    error: function () {
                        // Hiển thị thông báo lỗi hệ thống bằng nukeviet.toast
                        if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                            nukeviet.toast('Lỗi hệ thống, vui lòng thử lại', 'error');
                        }
                        // Khôi phục button về trạng thái ban đầu
                        $btn.prop('disabled', false).html('<i class="bx bxs-heart"></i> Xóa khỏi yêu thích');
                    }
                });
            }
        });
    });
</script>
<!-- END: main -->

<style>
    /* Favorites Page Styles - Sử dụng CSS Grid giống main.tpl */
    .favorites-page {
        min-height: 100vh;
        padding: 20px 0;
    }

    .favorites-page .page-header {
        margin-bottom: 30px;
        padding: 30px 20px;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 8px;
    }

    .favorites-page .page-header h1 {
        color: white;
        font-weight: 300;
        margin: 0;
        font-size: 28px;
    }

    .favorites-page .page-header p {
        color: rgba(255, 255, 255, 0.9);
        margin: 5px 0 0 0;
    }

    /* Empty state styling */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: #fff;
        border-radius: 15px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }

    .empty-icon {
        margin-bottom: 20px;
    }

    .empty-icon i {
        font-size: 80px;
        color: #ccc;
        opacity: 0.5;
    }

    .empty-state h3 {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 15px;
        color: #333;
    }

    .empty-state p {
        font-size: 14px;
        margin-bottom: 25px;
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
        color: #999;
    }

    /* Pagination wrapper */
    .pagination-wrapper {
        margin-top: 40px;
        text-align: center;
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .favorites-page .page-header {
            padding: 20px 15px;
        }

        .favorites-page .page-header h1 {
            font-size: 22px;
        }

        .empty-state {
            padding: 40px 15px;
        }

        .empty-icon i {
            font-size: 60px;
        }
    }
</style>