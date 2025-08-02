<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="page-header">
                <h2><i class="fa fa-heart text-danger"></i> {LANG.my_favorites}</h2>
                <p class="text-muted">Tổng số: <strong>{TOTAL_FAVORITES}</strong> sản phẩm</p>
            </div>

            <!-- BEGIN: favorites -->
            <div class="row">
                <!-- BEGIN: item -->
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="card h-100">
                        <!-- BEGIN: image -->
                        <img src="{ITEM.image}" class="card-img-top" alt="{ITEM.title}" style="height: 200px; object-fit: cover;">
                        <!-- END: image -->
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title">
                                <a href="{ITEM.detail_url}" class="text-decoration-none">{ITEM.title}</a>
                            </h5>
                            
                            <p class="card-text text-muted small flex-grow-1">
                                {ITEM.description}
                            </p>
                            
                            <div class="mt-auto">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="badge bg-primary">{ITEM.price_text}</span>
                                    <small class="text-muted">{ITEM.add_time_format}</small>
                                </div>
                                
                                <div class="d-flex justify-content-between align-items-center">
                                    <small class="text-muted">
                                        <i class="fa fa-eye"></i> {ITEM.num_view}
                                        <i class="fa fa-download ms-2"></i> {ITEM.num_download}
                                    </small>
                                    
                                    <div class="btn-group">
                                        <a href="{ITEM.detail_url}" class="btn btn-sm btn-outline-primary">
                                            <i class="fa fa-eye"></i> Xem
                                        </a>
                                        <button type="button" class="btn btn-sm btn-outline-danger remove-favorite" 
                                                data-id="{ITEM.id}" title="{LANG.remove_from_favorites}">
                                            <i class="fa fa-heart"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: item -->
            </div>
            <!-- END: favorites -->

            <!-- BEGIN: no_favorites -->
            <div class="text-center py-5">
                <i class="fa fa-heart-o fa-5x text-muted mb-3"></i>
                <h4 class="text-muted">{LANG.no_favorites}</h4>
                <p class="text-muted">Hãy thêm một số sản phẩm vào danh sách yêu thích!</p>
                <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-primary">
                    <i class="fa fa-search"></i> Khám phá sản phẩm
                </a>
            </div>
            <!-- END: no_favorites -->

            <!-- BEGIN: pagination -->
            <div class="text-center mt-4">
                {PAGINATION}
            </div>
            <!-- END: pagination -->
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Xử lý xóa favorite
    $('.remove-favorite').click(function(e) {
        e.preventDefault();
        
        var sourceId = $(this).data('id');
        var button = $(this);
        var card = button.closest('.col-md-6, .col-lg-4');
        
        if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi danh sách yêu thích?')) {
            $.post('{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=favorites', {
                ajax_favorite: 1,
                source_id: sourceId,
                action: 'remove'
            }, function(response) {
                if (response.status === 'success') {
                    card.fadeOut(300, function() {
                        $(this).remove();
                        // Kiểm tra nếu không còn item nào
                        if ($('.card').length === 0) {
                            location.reload();
                        }
                    });
                    
                    // Cập nhật số lượng
                    var currentTotal = parseInt($('.page-header strong').text());
                    $('.page-header strong').text(currentTotal - 1);
                } else {
                    alert(response.message || 'Có lỗi xảy ra');
                }
            }, 'json').fail(function() {
                alert('Có lỗi xảy ra khi kết nối với máy chủ');
            });
        }
    });
});
</script>
<!-- END: main -->