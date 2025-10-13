<div class="favorites-page">
    <div class="page-header">
        <h1><i class="fa fa-heart text-danger"></i> Sản phẩm yêu thích</h1>
        <p class="text-muted">Tổng số: <strong>{TOTAL_FAVORITES}</strong></p>
    </div>

    <div class="row">
        <div class="col-md-8 col-sm-12">
            <div class="panel panel-default favorite-card">
                <div class="panel-image">
                    <img src="{FAVORITE.image_url}" alt="{FAVORITE.title}" class="img-responsive">
                    <div class="price-badge">
                        <span class="label {FAVORITE.price_class}">{FAVORITE.price_display}</span>
                    </div>
                </div>

                <div class="panel-body">
                    <h4 class="panel-title">
                        <a href="{FAVORITE.link}" class="text-decoration-none">
                            {FAVORITE.title}
                        </a>
                    </h4>

                    <div class="category-info">
                        <small class="text-muted">
                            <i class="fa fa-folder-o"></i>
                            <a href="{FAVORITE.category_link}" class="text-muted">{FAVORITE.category_title}</a>
                        </small>
                    </div>
                    <p class="description text-muted">
                        {FAVORITE.description_short}
                    </p>
                    <div class="stats-row">
                        <div class="row text-center">
                            <div class="col-sm-8">
                                <small class="text-muted">
                                    <i class="fa fa-eye"></i><br>
                                    {FAVORITE.num_view}
                                </small>
                            </div>
                            <div class="col-sm-8">
                                <small class="text-muted">
                                    <i class="fa fa-download"></i><br>
                                    {FAVORITE.num_download}
                                </small>
                            </div>
                            <div class="col-sm-8">
                                <small class="text-muted">
                                    <i class="fa fa-star text-warning"></i><br>
                                    {FAVORITE.avg_rating}
                                </small>
                            </div>
                        </div>
                    </div>

                    <div class="rating text-center">
                        <span class="text-warning">{FAVORITE.rating_stars}</span>
                    </div>

                    <div class="action-buttons">
                        <a href="{FAVORITE.link}" class="btn btn-primary btn-sm btn-block">
                            <i class="fa fa-eye"></i> Xem chi tiết
                        </a>
                        <button type="button" class="btn btn-danger btn-sm btn-block remove-favorite"
                            data-source-id="{FAVORITE.id}" data-checkss="{FAVORITE.remove_checkss}"
                            title="Xóa khỏi yêu thích">
                            <i class="fa fa-heart"></i> Xóa khỏi yêu thích
                        </button>
                    </div>
                </div>

                <div class="panel-footer text-muted">
                    <small>
                        <i class="fa fa-clock-o"></i> Thêm vào: {FAVORITE.add_time_format}
                    </small>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-24">
            <div class="text-center pagination-wrapper">
                {GENERATE_PAGE}
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Xử lý xóa khỏi yêu thích
        $('.remove-favorite').click(function (e) {
            e.preventDefault();

            var $btn = $(this);
            var sourceId = $btn.data('source-id');
            var checkss = $btn.data('checkss');
            var $card = $btn.closest('.col-md-8, .col-sm-12');

            if (confirm('Bạn có chắc chắn muốn xóa khỏi danh sách yêu thích?')) {
                $btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý');

                $.ajax({
                    url: '{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=favorites&remove=' + sourceId + '&checkss=' + checkss,
                    type: 'GET',
                    dataType: 'json',
                    success: function (response) {
                        if (response.status === 'success') {
                            // Hiệu ứng fade out và remove
                            $card.fadeOut(300, function () {
                                $(this).remove();

                                // Cập nhật số lượng
                                var currentTotal = parseInt($('.page-header strong').text());
                                $('.page-header strong').text(currentTotal - 1);

                                // Kiểm tra nếu không còn favorites nào
                                if ($('.favorite-card').length === 0) {
                                    location.reload();
                                }
                            });

                            // Hiển thị thông báo
                            if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                                nukeviet.toast(response.message, 'success');
                            } else {
                                alert(response.message);
                            }
                        } else {
                            if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                                nukeviet.toast(response.message, 'error');
                            } else {
                                alert(response.message);
                            }
                            $btn.prop('disabled', false).html('<i class="fa fa-heart"></i> Xóa khỏi yêu thích');
                        }
                    },
                    error: function () {
                        if (typeof nukeviet !== 'undefined' && nukeviet.toast) {
                            nukeviet.toast('Lỗi hệ thống, vui lòng thử lại', 'error');
                        } else {
                            alert('Lỗi hệ thống, vui lòng thử lại');
                        }
                        $btn.prop('disabled', false).html('<i class="fa fa-heart"></i> Xóa khỏi yêu thích');
                    }
                });
            }
        });
    });
</script>

<style>
    .favorites-page .page-header {
        margin-bottom: 30px;
        padding-bottom: 20px;
        border-bottom: 2px solid #f0f0f0;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 30px 20px;
        border-radius: 8px;
        margin-top: -15px;
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

    .favorite-card {
        margin-bottom: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        border: 1px solid #e3e3e3;
        border-radius: 6px;
        transition: transform 0.2s ease-in-out;
        height: 100%;
    }

    .favorite-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
    }

    .panel-image {
        position: relative;
        overflow: hidden;
        border-radius: 6px 6px 0 0;
    }

    .panel-image img {
        height: 200px;
        width: 100%;
        object-fit: cover;
    }

    .price-badge {
        position: absolute;
        top: 10px;
        right: 10px;
    }

    .panel-title {
        margin: 0 0 10px 0;
        font-size: 16px;
        font-weight: 600;
    }

    .panel-title a {
        color: #333;
        text-decoration: none;
    }

    .panel-title a:hover {
        color: #007bff;
        text-decoration: none;
    }

    .category-info {
        margin-bottom: 10px;
    }

    .description {
        font-size: 13px;
        line-height: 1.4;
        margin-bottom: 15px;
        height: 60px;
        overflow: hidden;
    }

    .stats-row {
        margin-bottom: 15px;
        padding: 10px 0;
        border-top: 1px solid #f1f3f4;
        border-bottom: 1px solid #f1f3f4;
    }

    .rating {
        margin-bottom: 15px;
        font-size: 1.1em;
    }

    .action-buttons .btn {
        margin-bottom: 5px;
    }

    .panel-footer {
        background-color: #f8f9fa;
        border-top: 1px solid #dee2e6;
        font-size: 12px;
    }

    .empty-state {
        padding: 60px 20px;
    }

    .empty-icon {
        margin-bottom: 20px;
    }

    .pagination-wrapper {
        margin-top: 30px;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .favorite-card {
            margin-bottom: 15px;
        }

        .panel-image img {
            height: 150px;
        }

        .description {
            height: auto;
            max-height: 60px;
        }
    }
</style>