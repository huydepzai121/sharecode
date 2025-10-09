<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fa fa-heart text-danger"></i> {LANG.my_favorites}
                </h1>
                <div class="page-subtitle">
                    {LANG.total_favorites}: <strong>{TOTAL_FAVORITES}</strong>
                </div>
            </div>
        </div>
    </div>

    <!-- BEGIN: favorites -->
    <div class="row">
        <!-- BEGIN: favorite -->
        <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
            <div class="card h-100 shadow-sm">
                <div class="position-relative">
                    <img src="{FAVORITE.image_url}" class="card-img-top" alt="{FAVORITE.title}" style="height: 200px; object-fit: cover;">
                    <div class="position-absolute top-0 end-0 p-2">
                        <span class="badge bg-{FAVORITE.price_class} fs-6">{FAVORITE.price_display}</span>
                    </div>
                </div>
                
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">
                        <a href="{FAVORITE.link}" class="text-decoration-none text-dark">
                            {FAVORITE.title}
                        </a>
                    </h5>
                    
                    <div class="mb-2">
                        <!-- BEGIN: category_link -->
                        <small class="text-muted">
                            <i class="fa fa-folder-o"></i>
                            <a href="{FAVORITE.category_link}" class="text-muted">{FAVORITE.category_title}</a>
                        </small>
                        <!-- END: category_link -->
                    </div>
                    
                    <!-- BEGIN: description -->
                    <p class="card-text text-muted small flex-grow-1">
                        {FAVORITE.description_short}
                    </p>
                    <!-- END: description -->
                    
                    <div class="mb-3">
                        <div class="row text-center">
                            <div class="col-4">
                                <small class="text-muted">
                                    <i class="fa fa-eye"></i><br>
                                    {FAVORITE.num_view}
                                </small>
                            </div>
                            <div class="col-4">
                                <small class="text-muted">
                                    <i class="fa fa-download"></i><br>
                                    {FAVORITE.num_download}
                                </small>
                            </div>
                            <div class="col-4">
                                <small class="text-muted">
                                    <i class="fa fa-star text-warning"></i><br>
                                    {FAVORITE.avg_rating}
                                </small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="rating mb-2 text-center">
                        <span class="text-warning">{FAVORITE.rating_stars}</span>
                    </div>
                    
                    <div class="mt-auto">
                        <div class="d-grid gap-2">
                            <a href="{FAVORITE.link}" class="btn btn-primary btn-sm">
                                <i class="fa fa-eye"></i> {LANG.detail}
                            </a>
                            <button type="button" class="btn btn-outline-danger btn-sm remove-favorite"
                                    data-source-id="{FAVORITE.source_id}"
                                    data-checkss="{FAVORITE.remove_checkss}"
                                    title="{LANG.remove_from_favorites}">
                                <i class="fa fa-heart"></i> {LANG.remove_from_favorites}
                            </button>
                        </div>
                    </div>
                </div>
                
                <div class="card-footer text-muted small">
                    <i class="fa fa-clock-o"></i> {LANG.created_date}: {FAVORITE.add_time_format}
                </div>
            </div>
        </div>
        <!-- END: favorite -->
    </div>
    <!-- END: favorites -->

    <!-- BEGIN: no_favorites -->
    <div class="row">
        <div class="col-12">
            <div class="text-center py-5">
                <div class="mb-4">
                    <i class="fa fa-heart-o fa-5x text-muted"></i>
                </div>
                <h3 class="text-muted">{LANG.no_favorites}</h3>
                <p class="text-muted">{LANG.no_favorites_desc}</p>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary">
                    <i class="fa fa-search"></i> {LANG.browse_sources}
                </a>
            </div>
        </div>
    </div>
    <!-- END: no_favorites -->

    <!-- BEGIN: generate_page -->
    <div class="row">
        <div class="col-12">
            <div class="d-flex justify-content-center mt-4">
                {GENERATE_PAGE}
            </div>
        </div>
    </div>
    <!-- END: generate_page -->
</div>

<script>
$(document).ready(function() {
    // Xử lý xóa khỏi yêu thích
    $('.remove-favorite').click(function(e) {
        e.preventDefault();
        
        var $btn = $(this);
        var sourceId = $btn.data('source-id');
        var checkss = $btn.data('checkss');
        var $card = $btn.closest('.col-lg-4');
        
        if (confirm('{LANG.confirm_remove_favorite}')) {
            $btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> {LANG.processing}');
            
            $.ajax({
                url: '{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=favorite_action',
                type: 'POST',
                data: {
                    ajax: 1,
                    source_id: sourceId,
                    action: 'remove',
                    checkss: checkss
                },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        // Hiệu ứng fade out và remove
                        $card.fadeOut(300, function() {
                            $(this).remove();
                            
                            // Cập nhật số lượng
                            var currentTotal = parseInt($('.page-subtitle strong').text());
                            $('.page-subtitle strong').text(currentTotal - 1);
                            
                            // Kiểm tra nếu không còn favorites nào
                            if ($('.card').length === 0) {
                                location.reload();
                            }
                        });
                        
                        // Hiển thị thông báo
                        nukeviet.toast(response.message, 'success');
                    } else {
                        nukeviet.toast(response.message, 'error');
                        $btn.prop('disabled', false).html('<i class="fa fa-heart"></i> {LANG.remove_from_favorites}');
                    }
                },
                error: function() {
                    nukeviet.toast('{LANG.system_error}', 'error');
                    $btn.prop('disabled', false).html('<i class="fa fa-heart"></i> {LANG.remove_from_favorites}');
                }
            });
        }
    });
    
    // Hàm hiển thị thông báo
    function showAlert(type, message) {
        var alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
        var alertHtml = '<div class="alert ' + alertClass + ' alert-dismissible fade show" role="alert">' +
                       message +
                       '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                       '</div>';
        
        // Thêm alert vào đầu container
        $('.container-fluid').prepend(alertHtml);
        
        // Tự động ẩn sau 3 giây
        setTimeout(function() {
            $('.alert').fadeOut();
        }, 3000);
    }
});
</script>

<style>
.card {
    transition: transform 0.2s ease-in-out;
}

.card:hover {
    transform: translateY(-5px);
}

.rating {
    font-size: 1.2em;
}

.remove-favorite:hover {
    background-color: #dc3545;
    color: white;
}

.page-header {
    margin-bottom: 2rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #dee2e6;
}

.page-title {
    margin-bottom: 0.5rem;
    color: #495057;
}

.page-subtitle {
    color: #6c757d;
    font-size: 0.9rem;
}
</style>
<!-- END: main -->
