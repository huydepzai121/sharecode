<!-- BEGIN: main -->
<div class="well">
    <form action="{FORM_ACTION}" method="post" class="form-horizontal">
        <input type="hidden" name="save_config" value="1" />
        <input type="hidden" name="tokend" value="{NV_CHECK_SESSION}" />
        
        <!-- BEGIN: success -->
        <div class="alert alert-success">
            {SUCCESS_MESSAGE}
        </div>
        <!-- END: success -->
        
        <!-- BEGIN: error -->
        <div class="alert alert-danger">
            {ERROR}
        </div>
        <!-- END: error -->
        
        <h4>{LANG.admin_config}</h4>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">{LANG.items_per_page}:</label>
            <div class="col-sm-9">
                <input type="number" class="form-control" name="items_per_page" value="{CONFIG.items_per_page}" min="1" max="100" />
                <small class="help-block">Số lượng sản phẩm hiển thị trên mỗi trang</small>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">{LANG.config_allow_guest_download}:</label>
            <div class="col-sm-9">
                <label class="checkbox-inline">
                    <input type="checkbox" name="allow_guest_download" value="1" {ALLOW_GUEST_DOWNLOAD_CHECKED} />
                    {LANG.config_allow_guest_download_note}
                </label>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">{LANG.config_allow_guest_submit}:</label>
            <div class="col-sm-9">
                <label class="checkbox-inline">
                    <input type="checkbox" name="allow_guest_submit" value="1" {ALLOW_GUEST_SUBMIT_CHECKED} />
                    {LANG.config_allow_guest_submit_note}
                </label>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Yêu cầu đăng nhập cho sản phẩm trả phí:</label>
            <div class="col-sm-9">
                <label class="checkbox-inline">
                    <input type="checkbox" name="require_login_paid" value="1" {REQUIRE_LOGIN_PAID_CHECKED} />
                    Bắt buộc người dùng đăng nhập để mua sản phẩm trả phí
                </label>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Tự động duyệt đánh giá:</label>
            <div class="col-sm-9">
                <label class="checkbox-inline">
                    <input type="checkbox" name="auto_approve_reviews" value="1" {AUTO_APPROVE_REVIEWS_CHECKED} />
                    Tự động duyệt đánh giá mới (không cần admin phê duyệt)
                </label>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Kích thước file tối đa (MB):</label>
            <div class="col-sm-9">
                <input type="number" class="form-control" name="max_file_size" value="{CONFIG.max_file_size}" min="1" max="1000" />
                <small class="help-block">Kích thước file upload tối đa tính bằng MB</small>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Phần mở rộng cho phép:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" name="allowed_extensions" value="{CONFIG.allowed_extensions}" />
                <small class="help-block">Các phần mở rộng file được phép upload, cách nhau bởi dấu phẩy (ví dụ: zip,rar,7z)</small>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Bật watermark:</label>
            <div class="col-sm-9">
                <label class="checkbox-inline">
                    <input type="checkbox" name="watermark_enable" value="1" {WATERMARK_ENABLE_CHECKED} />
                    Tự động thêm watermark vào hình ảnh
                </label>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Text watermark:</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" name="watermark_text" value="{CONFIG.watermark_text}" />
                <small class="help-block">Văn bản sẽ được thêm làm watermark</small>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Gửi email khi có sản phẩm mới:</label>
            <div class="col-sm-9">
                <label class="checkbox-inline">
                    <input type="checkbox" name="email_notify_new_source" value="1" {EMAIL_NOTIFY_NEW_SOURCE_CHECKED} />
                    Gửi email thông báo cho admin khi có sản phẩm mới
                </label>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Gửi email khi có đánh giá mới:</label>
            <div class="col-sm-9">
                <label class="checkbox-inline">
                    <input type="checkbox" name="email_notify_new_review" value="1" {EMAIL_NOTIFY_NEW_REVIEW_CHECKED} />
                    Gửi email thông báo cho admin khi có đánh giá mới
                </label>
            </div>
        </div>
        
        <div class="form-group">
            <label class="col-sm-3 control-label">Thời gian cache (giây):</label>
            <div class="col-sm-9">
                <input type="number" class="form-control" name="cache_time" value="{CONFIG.cache_time}" min="0" />
                <small class="help-block">Thời gian lưu cache dữ liệu (0 = không cache)</small>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-sm-offset-3 col-sm-9">
                <button type="submit" class="btn btn-primary" id="save-config-btn">
                    {GLANG.save}
                </button>
                <button type="button" class="btn btn-default" onclick="window.location.reload();">
                    Làm mới
                </button>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
$(document).ready(function() {
    // Prevent double form submission
    var submitted = false;
    $('form').on('submit', function(e) {
        if (submitted) {
            e.preventDefault();
            return false;
        }
        submitted = true;
        $('#save-config-btn').prop('disabled', true).text('Đang lưu...');
        
        // Re-enable form after 3 seconds in case of error
        setTimeout(function() {
            submitted = false;
            $('#save-config-btn').prop('disabled', false).text('{GLANG.save}');
        }, 3000);
    });
    
    // Checkbox change tracking
    $('input[type="checkbox"]').on('change', function() {
        var checkbox = $(this);
        var name = checkbox.attr('name');
        console.log('Checkbox ' + name + ' changed to: ' + checkbox.is(':checked'));
    });
});
</script>
<!-- END: main -->