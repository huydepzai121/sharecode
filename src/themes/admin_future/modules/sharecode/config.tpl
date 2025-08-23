<!-- BEGIN: main -->
<div class="row">
    <div class="col-md-12">
        <div class="page-header">
            <h1>Cấu hình module <small>ShareCode</small></h1>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-cogs"></i> Cấu hình chung
                </h5>
            </div>
            <div class="card-body">
                <!-- BEGIN: success -->
                <div class="alert alert-success">
                    <i class="fa fa-check-circle"></i> {SUCCESS_MESSAGE}
                </div>
                <!-- END: success -->
                
                <!-- BEGIN: error -->
                <div class="alert alert-danger">
                    <i class="fa fa-exclamation-circle"></i> {ERROR}
                </div>
                <!-- END: error -->
                
                <form action="{FORM_ACTION}" method="post">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Cấu hình hiển thị</h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <label for="items_per_page" class="form-label">Số item trên mỗi trang</label>
                                        <input type="number" class="form-control" name="items_per_page" id="items_per_page" value="{CONFIG.items_per_page}" min="1" max="100">
                                        <small class="form-text text-muted">Từ 1 đến 100</small>
                                    </div>
                                    

                                </div>
                            </div>
                            
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Cấu hình download</h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="allow_guest_download" id="allow_guest_download" value="1" {ALLOW_GUEST_DOWNLOAD_CHECKED}>
                                            <label class="form-check-label" for="allow_guest_download">
                                                Cho phép khách tải file miễn phí
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="require_login_paid" id="require_login_paid" value="1" {REQUIRE_LOGIN_PAID_CHECKED}>
                                            <label class="form-check-label" for="require_login_paid">
                                                Yêu cầu đăng nhập để tải file có phí
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Cấu hình file upload</h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <label for="max_file_size" class="form-label">Kích thước file tối đa (MB)</label>
                                        <input type="number" class="form-control" name="max_file_size" id="max_file_size" value="{CONFIG.max_file_size}" min="1" max="1000">
                                        <small class="form-text text-muted">Từ 1MB đến 1000MB</small>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="allowed_extensions" class="form-label">Phần mở rộng file cho phép</label>
                                        <input type="text" class="form-control" name="allowed_extensions" id="allowed_extensions" value="{CONFIG.allowed_extensions}">
                                        <small class="form-text text-muted">Cách nhau bằng dấu phẩy. VD: zip,rar,7z</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Cấu hình đánh giá</h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="auto_approve_reviews" id="auto_approve_reviews" value="1" {AUTO_APPROVE_REVIEWS_CHECKED}>
                                            <label class="form-check-label" for="auto_approve_reviews">
                                                Tự động duyệt đánh giá
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Cấu hình watermark</h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="watermark_enable" id="watermark_enable" value="1" {WATERMARK_ENABLE_CHECKED}>
                                            <label class="form-check-label" for="watermark_enable">
                                                Bật watermark cho hình ảnh
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <label for="watermark_text" class="form-label">Nội dung watermark</label>
                                        <input type="text" class="form-control" name="watermark_text" id="watermark_text" value="{CONFIG.watermark_text}">
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <h6 class="card-title mb-0">Cấu hình email thông báo</h6>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="email_notify_new_source" id="email_notify_new_source" value="1" {EMAIL_NOTIFY_NEW_SOURCE_CHECKED}>
                                            <label class="form-check-label" for="email_notify_new_source">
                                                Gửi email khi có mã nguồn mới
                                            </label>
                                        </div>
                                    </div>
                                    
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="email_notify_new_review" id="email_notify_new_review" value="1" {EMAIL_NOTIFY_NEW_REVIEW_CHECKED}>
                                            <label class="form-check-label" for="email_notify_new_review">
                                                Gửi email khi có đánh giá mới
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary" name="save_config">
                            <i class="fa fa-save"></i> Lưu cấu hình
                        </button>
                        <a href="{NV_BASE_ADMINURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}" class="btn btn-secondary">
                            <i class="fa fa-arrow-left"></i> Quay lại
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
