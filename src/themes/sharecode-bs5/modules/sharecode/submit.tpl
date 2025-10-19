<!-- BEGIN: main -->
<link rel="stylesheet" href="{ASSETS_STATIC_URL}/js/select2/select2.min.css">
<script type="text/javascript" src="{ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>

<div id="sharecode-submit" class="py-4">
    <div class="container">
        <!-- BEGIN: errors -->
        <div class="alert alert-danger border-0 shadow-sm mb-4">
            <div class="d-flex align-items-center mb-3">
                <i class="fa fa-exclamation-triangle fa-lg text-danger me-2"></i>
                <h5 class="alert-heading mb-0">Có lỗi xảy ra:</h5>
            </div>
            <ul class="error-list mb-0 ps-4">
                <!-- BEGIN: error -->
                <li class="mb-1">{ERROR}</li>
                <!-- END: error -->
            </ul>
        </div>
        <!-- END: errors -->
        <!-- Submit Form -->
        <div class="submit-form-container">
            <form method="post" action="" enctype="multipart/form-data" class="submit-form">
                {NV_CHECK_SESSION}

                <!-- Basic Information Section -->
                <div class="form-section mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white border-0 py-3">
                            <h5 class="card-title mb-0 fw-bold">
                                <i class="fa fa-info-circle text-primary me-2"></i>
                                Thông tin cơ bản
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-4">
                                <div class="col-12">
                                    <label class="form-label fw-semibold">
                                        Tên mã nguồn <span class="text-danger">(*)</span>
                                    </label>
                                    <input type="text" name="title" class="form-control form-control-lg"
                                        placeholder="Nhập tiêu đề hấp dẫn cho sản phẩm của bạn" value="{DATA.title}" required>
                                    <div class="form-text">Tiêu đề ngắn gọn, súc tích và thu hút người mua</div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold">Liên kết tĩnh</label>
                                    <div class="input-group">
                                        <input type="text" name="alias" class="form-control"
                                            placeholder="Tự động tạo từ tiêu đề..." value="{DATA.alias}">
                                        <button class="btn btn-secondary" type="button"
                                            title="Tạo liên kết tĩnh từ tiêu đề">
                                            <i class="fa fa-refresh"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold">Hình đại diện</label>
                                    <div class="image-upload-container">
                                        <input type="file" name="product_image" id="product_image" class="image-input"
                                            accept="image/*" style="display: none;">
                                        <div class="image-upload-area border border-2 border-dashed rounded-3 p-4 text-center"
                                            onclick="document.getElementById('product_image').click();"
                                            style="cursor: pointer; transition: all 0.3s ease;">
                                            <div class="image-upload-preview">
                                                <i class="fa fa-cloud-upload fa-3x text-muted mb-3"></i>
                                                <p class="fw-semibold mb-1">Chọn ảnh đại diện</p>
                                                <small class="text-muted">JPG, PNG, GIF (tối đa 5MB)</small>
                                            </div>
                                        </div>
                                        <div class="upload-buttons mt-3 d-flex gap-2">
                                            <button type="button" class="btn btn-primary btn-upload"
                                                onclick="document.getElementById('product_image').click();">
                                                <i class="fa fa-upload me-2"></i> Chọn ảnh
                                            </button>
                                            <button type="button" class="btn btn-secondary btn-clear"
                                                onclick="clearImageUpload()" style="display: none;">
                                                <i class="fa fa-times me-2"></i> Xóa
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold">
                                        Mô tả ngắn <span class="text-danger">(*)</span>
                                    </label>
                                    <textarea name="description" class="form-control" rows="4"
                                        placeholder="Mô tả ngắn gọn về sản phẩm..." required>{DATA.description}</textarea>
                                    <div class="form-text">Mô tả ngắn gọn hiển thị trong danh sách sản phẩm</div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold">
                                        Mô tả chi tiết <span class="text-danger">(*)</span>
                                    </label>
                                    {CONTENT_EDITOR}
                                    <div class="form-text">Mô tả càng chi tiết càng tăng khả năng bán hàng. Hỗ trợ HTML</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Links & Demo Section -->
                <div class="form-section mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white border-0 py-3">
                            <h5 class="card-title mb-0 fw-bold">
                                <i class="fa fa-link text-primary me-2"></i>
                                Liên kết & Demo
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-4">
                                <div class="col-12">
                                    <label class="form-label fw-semibold">
                                        Danh mục <span class="text-danger">(*)</span>
                                    </label>
                                    <select name="catid" class="form-select form-select-lg" required>
                                        <option value="">-- Chọn danh mục --</option>
                                        <option value="{CATEGORY.id}" {CATEGORY.selected}>
                                            {CATEGORY.level_prefix}{CATEGORY.title}
                                        </option>
                                    </select>
                                </div>

                                <div class="col-12 col-md-6">
                                    <label class="form-label fw-semibold">Link mã nguồn bên ngoài</label>
                                    <input type="url" name="external_source_link" class="form-control"
                                        placeholder="https://github.com/yourproject" value="{DATA.external_source_link}">
                                    <div class="form-text">Link đến repository GitHub, GitLab hoặc trang web mã nguồn</div>
                                </div>

                                <div class="col-12 col-md-6">
                                    <label class="form-label fw-semibold">Link demo</label>
                                    <input type="url" name="demo_link" class="form-control"
                                        placeholder="https://demo.yoursite.com" value="{DATA.demo_link}">
                                    <div class="form-text">Link xem demo trực tiếp của mã nguồn</div>
                                </div>

                                <div class="col-12">
                                    <label class="form-label fw-semibold">
                                        Link download <span class="text-danger">(*)</span>
                                    </label>
                                    <input type="url" name="download_link" class="form-control form-control-lg"
                                        placeholder="https://drive.google.com/file/d/..." value="{DATA.download_link}" required>
                                    <input type="hidden" name="download_link_type" value="external">
                                    <div class="form-text">
                                        <i class="fa fa-info-circle text-info me-1"></i>
                                        Khuyến nghị sử dụng: Google Drive, Dropbox, GitHub, OneDrive hoặc các dịch vụ lưu trữ đáng tin cậy khác
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Keywords Section -->
                <div class="form-section mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white border-0 py-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="card-title mb-0 fw-bold">
                                    <i class="fa fa-key text-primary me-2"></i>
                                    Từ khóa tìm kiếm
                                </h5>
                                <button type="button" class="btn btn-primary btn-sm"
                                    title="Tạo tự động từ khóa từ nội dung" id="keywords-auto-create">
                                    <i class="fa fa-magic me-1"></i> Tự động
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-4">
                            <select id="keywords-select" class="form-select" name="keywords[]" multiple
                                data-placeholder="Chọn từ khóa...">
                            </select>
                            <div class="form-text mt-2">
                                <i class="fa fa-info-circle text-info me-1"></i>
                                Chọn từ danh sách có sẵn hoặc nhập từ khóa mới. Tối đa 15 từ khóa.
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tags Section -->
                <div class="form-section mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white border-0 py-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="card-title mb-0 fw-bold">
                                    <i class="fa fa-tags text-primary me-2"></i>
                                    Tags cho mã nguồn
                                </h5>
                                <button type="button" class="btn btn-primary btn-sm"
                                    title="Tạo tự động tags dựa vào nội dung mã nguồn" id="tags-auto-create">
                                    <i class="fa fa-magic me-1"></i> Tự động
                                </button>
                            </div>
                        </div>
                        <div class="card-body p-4">
                            <select id="tags-select" class="form-select" name="tags[]" multiple data-placeholder="Nhập tag...">
                            </select>
                            <div class="form-text mt-2">
                                <i class="fa fa-tags text-info me-1"></i>
                                Chọn từ danh sách có sẵn hoặc nhập tag mới. Tối đa 20 tags.
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pricing Section -->
                <div class="form-section mb-4">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white border-0 py-3">
                            <h5 class="card-title mb-0 fw-bold">
                                <i class="fa fa-money text-success me-2"></i>
                                Thông tin giá cả
                            </h5>
                        </div>
                        <div class="card-body p-4">
                            <div class="row g-4">
                                <div class="col-12">
                                    <label class="form-label fw-semibold">Loại phí</label>
                                    <select class="form-select form-select-lg" name="fee_type" id="fee_type">
                                        <option value="free" {CHECKED_FREE}>Miễn phí</option>
                                        <option value="paid" {CHECKED_PAID}>Có phí</option>
                                        <option value="contact" {CHECKED_CONTACT}>Liên hệ để biết giá</option>
                                    </select>
                                </div>

                                <div class="col-12 price-input" style="display: none;">
                                    <label class="form-label fw-semibold">Số tiền (VNĐ)</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text"><i class="fa fa-money text-success"></i></span>
                                        <input type="text" name="fee_amount_display" class="form-control" placeholder="50,000"
                                            value="{DATA.fee_amount}" onkeyup="updateFeeAmount(this.value, true);"
                                            oninput="updateFeeAmount(this.value, true);" id="fee_amount_display">
                                        <input type="hidden" name="fee_amount" id="fee_amount" value="{DATA.fee_amount}">
                                        <span class="input-group-text">VNĐ</span>
                                    </div>
                                    <div class="form-text">
                                        <i class="fa fa-info-circle text-info me-1"></i>
                                        Giá tối thiểu 1,000 VNĐ. Ví dụ: 50,000 VNĐ cho script đơn giản, 500,000 VNĐ cho hệ thống phức tạp
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <i class="fa fa-image"></i> Ảnh demo
                    </h4>
                </div>
                <div class="panel-body">
                    <div id="demo-images-container">
                        <div class="demo-image-item">
                            <div class="form-group">
                                <div class="image-upload-container">
                                    <input type="file" name="demo_images[]" class="demo-image-input image-input"
                                        accept="image/*" style="display: none;">
                                    <div class="image-upload-area" onclick="this.previousElementSibling.click();">
                                        <div class="image-upload-preview">
                                            <i class="fa fa-cloud-upload fa-2x"></i>
                                            <p><strong>Chọn ảnh demo #1</strong></p>
                                            <small>JPG, PNG, GIF (tối đa 5MB)</small>
                                        </div>
                                    </div>
                                    <div class="upload-buttons">
                                        <button type="button" class="btn btn-primary btn-sm"
                                            onclick="this.closest('.demo-image-item').querySelector('.demo-image-input').click();">
                                            <i class="fa fa-upload"></i> Chọn ảnh
                                        </button>
                                        <button type="button" class="btn btn-default btn-sm btn-clear"
                                            onclick="clearDemoImage(this)" style="display: none;">
                                            <i class="fa fa-times"></i> Xóa
                                        </button>
                                        <button type="button" class="btn btn-danger btn-sm btn-remove"
                                            onclick="removeDemoImage(this)" style="display: none;">
                                            <i class="fa fa-trash"></i> Gỡ bỏ
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button type="button" class="btn btn-success btn-sm" onclick="addDemoImage()">
                        <i class="fa fa-plus"></i> Thêm ảnh demo
                    </button>
                    <div class="help-block">Ảnh demo hoặc screenshot sản phẩm (tối đa 5 ảnh)</div>
                </div>
            </div>

            <div class="panel panel-warning" id="contact-section" style="display: none;">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <i class="fa fa-phone"></i> Thông tin liên hệ
                        <small class="text-muted">(Bắt buộc khi chọn "Liên hệ để biết giá")</small>
                    </h4>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label">Số điện thoại:</label>
                                <input type="tel" name="contact_phone" class="form-control" placeholder="0123456789"
                                    value="{DATA.contact_phone}">
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label">Email:</label>
                                <input type="email" name="contact_email" class="form-control"
                                    placeholder="contact@example.com" value="{DATA.contact_email}">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label">Skype:</label>
                                <input type="text" name="contact_skype" class="form-control" placeholder="your.skype.id"
                                    value="{DATA.contact_skype}">
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label">Telegram:</label>
                                <input type="text" name="contact_telegram" class="form-control"
                                    placeholder="@yourtelegram" value="{DATA.contact_telegram}">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label">Zalo:</label>
                                <input type="text" name="contact_zalo" class="form-control" placeholder="0123456789"
                                    value="{DATA.contact_zalo}">
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="control-label">Facebook:</label>
                                <input type="url" name="contact_facebook" class="form-control"
                                    placeholder="https://facebook.com/yourprofile" value="{DATA.contact_facebook}">
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="control-label">Website:</label>
                        <input type="url" name="contact_website" class="form-control"
                            placeholder="https://yourwebsite.com" value="{DATA.contact_website}">
                    </div>

                    <div class="form-group">
                        <label class="control-label">Địa chỉ:</label>
                        <textarea name="contact_address" class="form-control" rows="3"
                            placeholder="Địa chỉ liên hệ...">{DATA.contact_address}</textarea>
                    </div>
                </div>
            </div>

                <!-- Submit Section -->
                <div class="submit-section text-center mt-5 pt-4 border-top">
                    <button type="submit" name="submit_product" class="btn btn-primary btn-lg px-5 py-3 mb-4">
                        <i class="fa fa-paper-plane me-2"></i> Gửi sản phẩm để duyệt
                    </button>

                    <div class="alert alert-info border-0 shadow-sm">
                        <div class="d-flex align-items-center mb-3">
                            <i class="fa fa-info-circle fa-lg text-info me-2"></i>
                            <strong class="text-info">Lưu ý quan trọng:</strong>
                        </div>
                        <ul class="list-unstyled mb-0 text-start">
                            <li class="mb-2"><i class="fa fa-check text-success me-2"></i> Sản phẩm sẽ được admin kiểm duyệt trong vòng 24-48h</li>
                            <li class="mb-2"><i class="fa fa-check text-success me-2"></i> Bạn sẽ nhận được thông báo qua email khi sản phẩm được phê duyệt</li>
                            <li class="mb-2"><i class="fa fa-check text-success me-2"></i> Đảm bảo thông tin chính xác và link download hoạt động tốt</li>
                            <li class="mb-0"><i class="fa fa-times text-danger me-2"></i> Sản phẩm vi phạm bản quyền sẽ bị từ chối</li>
                        </ul>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
// Submit page functionality with AOS
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

    // Add hover effects to image upload areas
    const uploadAreas = document.querySelectorAll('.image-upload-area');
    uploadAreas.forEach(area => {
        area.addEventListener('mouseenter', function() {
            this.style.borderColor = 'var(--bs-primary)';
            this.style.backgroundColor = 'rgba(13, 110, 253, 0.05)';
        });

        area.addEventListener('mouseleave', function() {
            this.style.borderColor = '';
            this.style.backgroundColor = '';
        });
    });
});

$(document).ready(function () {
    // Initialize Select2 for keywords with Bootstrap 5 theme
    $('#keywords-select').select2({
        width: '100%',
        tags: true,
        tokenSeparators: [',', ' '],
        placeholder: 'Chọn từ khóa...',
        allowClear: true,
        maximumSelectionLength: 15,
        theme: 'bootstrap-5',
        createTag: function (params) {
            var term = $.trim(params.term);
            if (term === '' || term.length < 2 || term.length > 50) {
                return null;
            }
            return {
                id: term,
                text: term,
                newTag: true
            };
        }
    });

    // Initialize Select2 for tags with Bootstrap 5 theme
    $('#tags-select').select2({
        width: '100%',
        tags: true,
        tokenSeparators: [',', ' '],
        placeholder: 'Nhập tag...',
        allowClear: true,
        maximumSelectionLength: 20,
        theme: 'bootstrap-5',
        createTag: function (params) {
            var term = $.trim(params.term);
            if (term === '' || term.length < 2 || term.length > 30) {
                return null;
            }
            return {
                id: term,
                text: term,
                newTag: true
            };
        }
    });

        var availableKeywords = {AVAILABLE_KEYWORDS_JSON};
        var availableTags = {AVAILABLE_TAGS_JSON};

        if (availableKeywords && availableKeywords.length > 0) {
            availableKeywords.forEach(function (keyword) {
                var newOption = new Option(keyword.name, keyword.name, false, false);
                $('#keywords-select').append(newOption);
            });
        }

        // Add tags to select2
        if (availableTags && availableTags.length > 0) {
            availableTags.forEach(function (tag) {
                var newOption = new Option(tag.name, tag.name, false, false);
                $('#tags-select').append(newOption);
            });
        }
        $('input[name="title"]').on('input', function () {
            var title = $(this).val();
            var aliasField = $('input[name="alias"]');

            if (aliasField.val() === '' || aliasField.data('auto-generated')) {
                var alias = generateAlias(title);
                aliasField.val(alias).data('auto-generated', true);
            }
        });

        // Mark alias as manually edited when user types in it
        $('input[name="alias"]').on('input', function () {
            $(this).data('auto-generated', false);
        });

        // Toggle price input and contact section based on fee type (using select dropdown)
        $('#fee_type').change(function () {
            var feeType = $(this).val();

            if (feeType === 'paid') {
                $('.price-input').show();
                $('#contact-section').hide();
            } else if (feeType === 'contact') {
                $('.price-input').hide();
                $('#contact-section').show();
            } else {
                $('.price-input').hide();
                $('#contact-section').hide();
            }
        });

        // Initialize based on current values
        var currentFeeType = $('#fee_type').val() || 'free';
        if (currentFeeType === 'paid') {
            $('.price-input').show();
            $('#contact-section').hide();
        } else if (currentFeeType === 'contact') {
            $('.price-input').hide();
            $('#contact-section').show();
        } else {
            $('.price-input').hide();
            $('#contact-section').hide();
        }

        // Image upload preview for product image
        $('#product_image').change(function () {
            var file = this.files[0];
            if (file) {
                // Kiểm tra kích thước file (5MB = 5 * 1024 * 1024 bytes)
                if (file.size > 5 * 1024 * 1024) {
                    alert('Hình ảnh quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                    this.value = '';
                    return;
                }

                // Kiểm tra định dạng file
                var allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                if (!allowedTypes.includes(file.type)) {
                    alert('Định dạng hình ảnh không hợp lệ! Chỉ chấp nhận JPG, PNG, GIF.');
                    this.value = '';
                    return;
                }

                var reader = new FileReader();
                reader.onload = function (e) {
                    $(this).closest('.image-upload-container').find('.image-upload-preview').html(
                        '<img src="' + e.target.result + '" style="max-width: 100%; max-height: 150px; border-radius: 6px;">' +
                        '<p style="margin-top: 10px; color: #333;"><strong>' + file.name + '</strong></p>' +
                        '<p style="margin: 5px 0; color: #666; font-size: 12px;">Kích thước: ' + (file.size / 1024 / 1024).toFixed(2) + ' MB</p>' +
                        '<p style="margin: 5px 0; color: #28a745; font-size: 12px;"><i class="fa fa-check-circle"></i> Hình ảnh hợp lệ</p>'
                    );
                    $(this).closest('.image-upload-container').find('.btn-clear').show();
                }.bind(this);
                reader.readAsDataURL(file);
            }
        });

        // Function to clear image upload
        window.clearImageUpload = function () {
            $('#product_image').val('');
            $('#product_image').closest('.image-upload-container').find('.image-upload-preview').html(
                '<i class="fa fa-cloud-upload fa-2x"></i>' +
                '<p><strong>Chọn ảnh đại diện</strong></p>' +
                '<small>JPG, PNG, GIF (tối đa 5MB)</small>'
            );
            $('#product_image').closest('.image-upload-container').find('.btn-clear').hide();
        };

        // This section is now handled by the new demo images system above

        // Multiple demo images handling
        var demoImageCount = 1;
        var maxDemoImages = 5;

        // Function to add new demo image input
        window.addDemoImage = function () {
            if (demoImageCount >= maxDemoImages) {
                alert('Tối đa ' + maxDemoImages + ' ảnh demo');
                return;
            }

            demoImageCount++;
            var newImageHtml = `
            <div class="demo-image-item mt-3">
                <div class="image-upload-container">
                    <input type="file" name="demo_images[]" class="demo-image-input image-input" accept="image/*" style="display: none;">
                    <div class="image-upload-area" onclick="this.previousElementSibling.click();">
                        <div class="image-upload-preview">
                            <i class="fa fa-cloud-upload fa-2x"></i>
                            <p><strong>Chọn ảnh demo #${demoImageCount}</strong></p>
                            <small>JPG, PNG, GIF (tối đa 5MB)</small>
                        </div>
                    </div>
                    <div class="upload-buttons">
                        <button type="button" class="btn btn-primary btn-upload btn-sm" onclick="this.closest('.demo-image-item').querySelector('.demo-image-input').click();">
                            <i class="fa fa-upload"></i> Chọn ảnh
                        </button>
                        <button type="button" class="btn btn-secondary btn-clear btn-sm" onclick="clearDemoImage(this)" style="display: none;">
                            <i class="fa fa-times"></i> Xóa
                        </button>
                        <button type="button" class="btn btn-danger btn-remove btn-sm" onclick="removeDemoImage(this)">
                            <i class="fa fa-trash"></i> Gỡ bỏ
                        </button>
                    </div>
                </div>
            </div>
        `;

            $('#demo-images-container').append(newImageHtml);
            updateDemoImageNumbers();
        };

        // Function to remove demo image
        window.removeDemoImage = function (button) {
            if (demoImageCount <= 1) {
                alert('Phải có ít nhất 1 ảnh demo');
                return;
            }

            $(button).closest('.demo-image-item').remove();
            demoImageCount--;
            updateDemoImageNumbers();
        };

        // Function to clear individual demo image
        window.clearDemoImage = function (button) {
            var container = $(button).closest('.demo-image-item');
            var input = container.find('.demo-image-input');
            var preview = container.find('.image-upload-preview');
            var imageNumber = container.index() + 1;

            input.val('');
            preview.html(
                '<i class="fa fa-cloud-upload fa-2x"></i>' +
                '<p><strong>Chọn ảnh demo #' + imageNumber + '</strong></p>' +
                '<small>JPG, PNG, GIF (tối đa 5MB)</small>'
            );
            container.find('.btn-clear').hide();
            container.find('.btn-remove').show();
        };

        // Function to update demo image numbers
        function updateDemoImageNumbers() {
            $('#demo-images-container .demo-image-item').each(function (index) {
                var imageNumber = index + 1;
                $(this).find('.image-upload-preview p strong').text('Chọn ảnh demo #' + imageNumber);
            });
        }

        // Handle demo image uploads
        $(document).on('change', '.demo-image-input', function () {
            var file = this.files[0];
            var container = $(this).closest('.demo-image-item');
            var preview = container.find('.image-upload-preview');
            var imageNumber = container.index() + 1;

            if (file) {
                // Kiểm tra kích thước file (5MB = 5 * 1024 * 1024 bytes)
                if (file.size > 5 * 1024 * 1024) {
                    alert('Ảnh demo quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                    this.value = '';
                    return;
                }

                // Kiểm tra định dạng file
                var allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
                if (!allowedTypes.includes(file.type)) {
                    alert('Định dạng ảnh demo không hợp lệ! Chỉ chấp nhận JPG, PNG, GIF.');
                    this.value = '';
                    return;
                }

                var reader = new FileReader();
                reader.onload = function (e) {
                    preview.html(
                        '<img src="' + e.target.result + '" style="max-width: 100%; max-height: 150px; border-radius: 6px;">' +
                        '<p style="margin-top: 10px; color: #333;"><strong>' + file.name + '</strong></p>' +
                        '<p style="margin: 5px 0; color: #666; font-size: 12px;">Kích thước: ' + (file.size / 1024 / 1024).toFixed(2) + ' MB</p>' +
                        '<p style="margin: 5px 0; color: #28a745; font-size: 12px;"><i class="fa fa-check-circle"></i> Ảnh demo hợp lệ</p>'
                    );
                    container.find('.btn-clear').show();
                    container.find('.btn-remove').hide();
                };
                reader.readAsDataURL(file);
            }
        });

        // Auto-create keywords button functionality
        $('#keywords-auto-create').on('click', function () {
            var title = $('input[name="title"]').val().trim();
            var description = $('textarea[name="description"]').val().trim();
            var content = $('textarea[name="content"]').val().trim();

            var allContent = title + ' ' + description + ' ' + content;
            var autoKeywords = extractKeywordsFromContent(allContent);

            if (autoKeywords.length > 0) {
                // Add auto-generated keywords to select2
                var currentKeywords = $('#keywords-select').val() || [];
                var newKeywords = [...new Set([...currentKeywords, ...autoKeywords])]; // Remove duplicates

                // Add new options if they don't exist
                autoKeywords.forEach(function (keyword) {
                    if ($('#keywords-select option[value="' + keyword + '"]').length === 0) {
                        var newOption = new Option(keyword, keyword, false, false);
                        $('#keywords-select').append(newOption);
                    }
                });

                $('#keywords-select').val(newKeywords).trigger('change');
                alert('Đã tạo ' + autoKeywords.length + ' từ khóa tự động: ' + autoKeywords.join(', '));
            } else {
                alert('Không thể tạo từ khóa tự động. Vui lòng nhập thêm nội dung.');
            }
        });

        // Auto-create tags button functionality
        $('#tags-auto-create').on('click', function () {
            var title = $('input[name="title"]').val().trim();
            var description = $('textarea[name="description"]').val().trim();
            var content = $('textarea[name="content"]').val().trim();

            var allContent = title + ' ' + description + ' ' + content;
            var autoTags = extractTagsFromContent(allContent);

            if (autoTags.length > 0) {
                // Add auto-generated tags to select2
                var currentTags = $('#tags-select').val() || [];
                var newTags = [...new Set([...currentTags, ...autoTags])]; // Remove duplicates

                // Add new options if they don't exist
                autoTags.forEach(function (tag) {
                    if ($('#tags-select option[value="' + tag + '"]').length === 0) {
                        var newOption = new Option(tag, tag, false, false);
                        $('#tags-select').append(newOption);
                    }
                });

                $('#tags-select').val(newTags).trigger('change');
                alert('Đã tạo ' + autoTags.length + ' tags tự động: ' + autoTags.join(', '));
            } else {
                alert('Không thể tạo tags tự động. Vui lòng nhập thêm nội dung.');
            }
        });

        // Function to generate alias from title
        function generateAlias(title) {
            if (!title) return '';

            // Vietnamese character mapping
            var map = {
                'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ': 'a',
                'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ': 'e',
                'ì|í|ị|ỉ|ĩ': 'i',
                'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ': 'o',
                'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ': 'u',
                'ỳ|ý|ỵ|ỷ|ỹ': 'y',
                'đ': 'd',
                'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ': 'A',
                'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ': 'E',
                'Ì|Í|Ị|Ỉ|Ĩ': 'I',
                'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ': 'O',
                'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ': 'U',
                'Ỳ|Ý|Ỵ|Ỷ|Ỹ': 'Y',
                'Đ': 'D'
            };

            // Convert to lowercase and replace Vietnamese characters
            var text = title.toLowerCase();
            for (var char in map) {
                text = text.replace(new RegExp(char, 'g'), map[char]);
            }

            // Remove special characters and replace spaces with hyphens
            text = text.replace(/[^a-z0-9\s-]/g, '');
            text = text.replace(/\s+/g, '-');
            text = text.replace(/-+/g, '-');
            text = text.replace(/^-|-$/g, '');

            return text;
        }

        // Function to extract keywords from content
        function extractKeywordsFromContent(content) {
            if (!content || content.length < 10) return [];

            // Common programming and technology keywords
            var techKeywords = [
                'php', 'mysql', 'javascript', 'html', 'css', 'bootstrap', 'jquery', 'ajax', 'json', 'xml',
                'cms', 'nukeviet', 'wordpress', 'laravel', 'codeigniter', 'framework', 'api', 'rest',
                'mobile', 'responsive', 'admin', 'dashboard', 'ecommerce', 'shop', 'cart', 'payment',
                'user', 'login', 'register', 'authentication', 'authorization', 'security', 'seo',
                'blog', 'news', 'article', 'content', 'management', 'template', 'theme', 'plugin',
                'module', 'extension', 'widget', 'slider', 'gallery', 'portfolio', 'contact', 'form',
                'website', 'web', 'online', 'digital', 'system', 'software', 'application', 'tool'
            ];

            var keywords = [];
            content = content.toLowerCase();

            // Extract tech keywords
            techKeywords.forEach(function (keyword) {
                if (content.includes(keyword) && keywords.indexOf(keyword) === -1) {
                    keywords.push(keyword);
                }
            });

            return keywords.slice(0, 10); // Limit to 10 auto-generated keywords
        }

        // Function to extract tags from content
        function extractTagsFromContent(content) {
            if (!content || content.length < 10) return [];

            // Common programming and technology keywords
            var techKeywords = [
                'php', 'mysql', 'javascript', 'html', 'css', 'bootstrap', 'jquery', 'ajax', 'json', 'xml',
                'cms', 'nukeviet', 'wordpress', 'laravel', 'codeigniter', 'framework', 'api', 'rest',
                'mobile', 'responsive', 'admin', 'dashboard', 'ecommerce', 'shop', 'cart', 'payment',
                'user', 'login', 'register', 'authentication', 'authorization', 'security', 'seo',
                'blog', 'news', 'article', 'content', 'management', 'template', 'theme', 'plugin',
                'module', 'extension', 'widget', 'slider', 'gallery', 'portfolio', 'contact', 'form',
                'website', 'web', 'online', 'digital', 'system', 'software', 'application', 'tool'
            ];

            var tags = [];
            content = content.toLowerCase();

            // Extract tech keywords
            techKeywords.forEach(function (keyword) {
                if (content.includes(keyword) && tags.indexOf(keyword) === -1) {
                    tags.push(keyword);
                }
            });

            // Extract words that might be tags (2-15 characters, alphanumeric)
            var words = content.match(/\b[a-zA-Z][a-zA-Z0-9]{1,14}\b/g) || [];
            var commonWords = ['the', 'and', 'for', 'are', 'but', 'not', 'you', 'all', 'can', 'had', 'her', 'was', 'one', 'our', 'out', 'day', 'get', 'has', 'him', 'how', 'man', 'new', 'now', 'old', 'see', 'two', 'way', 'who', 'boy', 'did', 'its', 'let', 'put', 'say', 'she', 'too', 'use', 'that', 'with', 'have', 'this', 'will', 'your', 'from', 'they', 'know', 'want', 'been', 'good', 'much', 'some', 'time', 'very', 'when', 'come', 'here', 'just', 'like', 'long', 'make', 'many', 'over', 'such', 'take', 'than', 'them', 'well', 'were'];

            words.forEach(function (word) {
                if (word.length >= 3 && word.length <= 15 &&
                    commonWords.indexOf(word.toLowerCase()) === -1 &&
                    tags.indexOf(word.toLowerCase()) === -1 &&
                    tags.length < 8) {
                    tags.push(word.toLowerCase());
                }
            });

            return tags.slice(0, 8); // Limit to 8 auto-generated tags
        }

        // Number formatting functions (modified for integer display)
        window.FormatNumber = function (str) {
            var strTemp = GetNumber(str);
            if (strTemp.length <= 3) {
                return strTemp;
            }

            // Remove commas first
            for (var i = 0; i < strTemp.length; i++) {
                strTemp = strTemp.replace(",", "");
            }

            // Convert to integer (remove decimal part for money display)
            var numValue = parseFloat(strTemp);
            if (isNaN(numValue)) {
                return strTemp;
            }

            // Convert to integer string (remove decimal part)
            strTemp = Math.floor(numValue).toString();

            var strResult = "";
            // Format with commas (integer only)
            for (var i = strTemp.length; i >= 0; i--) {
                if (strResult.length > 0 && (strTemp.length - i - 1) % 3 == 0) {
                    strResult = "," + strResult;
                }
                strResult = strTemp.substring(i, i + 1) + strResult;
            }

            return strResult;
        };

        window.GetNumber = function (str) {
            var count = 0;
            for (var i = 0; i < str.length; i++) {
                var temp = str.substring(i, i + 1);
                if (!(temp == "," || temp == "." || (temp >= 0 && temp <= 9))) {
                    return str.substring(0, i);
                }
                if (temp == " ") {
                    return str.substring(0, i);
                }
                if (temp == ".") {
                    if (count > 0) {
                        return str.substring(0, i);
                    }
                    count++;
                }
            }
            return str;
        };

        // Update fee amount function
        window.updateFeeAmount = function (displayValue, preserveCursor) {
            if (!displayValue) {
                $('#fee_amount_display').val('');
                $('#fee_amount').val('');
                return;
            }

            var field = $('#fee_amount_display')[0];
            var cursorPos = preserveCursor ? field.selectionStart : null;
            var oldLength = displayValue.length;

            // Remove all non-numeric characters (only allow digits)
            var cleanValue = displayValue.replace(/[^0-9]/g, '');

            // Only process if we have a valid number
            if (cleanValue && !isNaN(cleanValue)) {
                // Convert to integer (remove any decimal part)
                var intValue = Math.floor(parseFloat(cleanValue));
                cleanValue = intValue.toString();

                // Format the number with commas
                var formatted = FormatNumber(cleanValue);

                // Update both fields
                $('#fee_amount_display').val(formatted);
                $('#fee_amount').val(cleanValue);

                // Restore cursor position if needed
                if (preserveCursor && cursorPos !== null) {
                    var newLength = formatted.length;
                    var newPos = cursorPos + (newLength - oldLength);
                    if (newPos >= 0 && newPos <= newLength) {
                        field.setSelectionRange(newPos, newPos);
                    }
                }
            }
        };

        // Format fee amount on page load if exists
        var feeAmountDisplayField = $('#fee_amount_display');
        var feeAmountHiddenField = $('#fee_amount');

        // Initialize display field with formatted value from hidden field
        if (feeAmountHiddenField.val() && feeAmountHiddenField.val() !== '0' && feeAmountHiddenField.val() !== '') {
            var initialValue = feeAmountHiddenField.val();
            feeAmountDisplayField.val(FormatNumber(initialValue));
        } else if (feeAmountDisplayField.val()) {
            // If display field has value but hidden doesn't, format the display value
            updateFeeAmount(feeAmountDisplayField.val());
        }

        // Add focus/blur events for better UX
        $('#fee_amount_display').on('focus', function () {
            $(this).select(); // Select all text on focus
        }).on('blur', function () {
            // Ensure proper formatting on blur
            if ($(this).val()) {
                updateFeeAmount($(this).val());
            }
        }).on('input', function () {
            // Real-time formatting as user types
            updateFeeAmount($(this).val());
        });

        // Form validation before submit
        $('.submit-form').on('submit', function (e) {
            var errors = [];

            // Ensure fee_amount hidden field is updated from display field
            var feeAmountDisplayField = $('#fee_amount_display');
            if (feeAmountDisplayField.val()) {
                updateFeeAmount(feeAmountDisplayField.val());
            }

            // Validate title
            var title = $('input[name="title"]').val().trim();
            if (title.length < 3) {
                errors.push('Tên mã nguồn phải có ít nhất 3 ký tự');
            }

            // Validate description
            var description = $('textarea[name="description"]').val().trim();
            if (description.length < 10) {
                errors.push('Mô tả ngắn phải có ít nhất 10 ký tự');
            }

            // Validate category
            if ($('select[name="catid"]').val() == '') {
                errors.push('Vui lòng chọn danh mục');
            }

            // Validate download link
            var downloadLink = $('input[name="download_link"]').val().trim();
            if (downloadLink === '') {
                errors.push('Vui lòng nhập link download');
            }

            // Validate fee amount for paid type
            var feeType = $('#fee_type').val();
            if (feeType === 'paid') {
                var feeAmountStr = $('#fee_amount').val(); // Use hidden field value
                var feeAmount = parseFloat(feeAmountStr);
                if (isNaN(feeAmount) || feeAmount < 1000) {
                    errors.push('Số tiền phải ít nhất 1,000 VNĐ');
                }
            }

            // Validate contact info for contact type
            if (feeType === 'contact') {
                var hasContact = false;
                var contactFields = ['contact_phone', 'contact_email', 'contact_skype', 'contact_telegram', 'contact_zalo', 'contact_facebook', 'contact_website'];
                contactFields.forEach(function (field) {
                    if ($('input[name="' + field + '"]').val().trim() !== '') {
                        hasContact = true;
                    }
                });
                if (!hasContact) {
                    errors.push('Vui lòng nhập ít nhất một thông tin liên hệ');
                }
            }

            if (errors.length > 0) {
                e.preventDefault();
                alert('Có lỗi xảy ra:\n\n' + errors.join('\n'));
                return false;
            }
        });
    });
</script>

<style>
/* ===== SUBMIT PAGE STYLES - BOOTSTRAP 5 ===== */

/* Page Header */
.submit-header {
    text-align: center;
}

.header-icon {
    transition: all 0.3s ease;
}

.header-icon:hover {
    transform: scale(1.1);
}

/* Form Sections */
.form-section .card {
    border-radius: 16px !important;
    transition: all 0.3s ease;
}

.form-section .card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1) !important;
}

.form-section .card-header {
    border-radius: 16px 16px 0 0 !important;
}

/* Image Upload Areas */
.image-upload-area {
    transition: all 0.3s ease;
    min-height: 150px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.image-upload-area:hover {
    border-color: var(--bs-primary) !important;
    background-color: rgba(13, 110, 253, 0.05) !important;
    transform: scale(1.02);
}

.image-upload-preview {
    text-align: center;
}

.upload-buttons .btn {
    transition: all 0.3s ease;
}

.upload-buttons .btn:hover {
    transform: translateY(-2px);
}

/* Form Controls */
.form-control,
.form-select {
    border-radius: 8px;
    border: 1px solid #ced4da;
    transition: all 0.3s ease;
}

.form-control:focus,
.form-select:focus {
    border-color: var(--bs-primary);
    box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
}

.form-control-lg,
.form-select-lg {
    font-size: 1.1rem;
    padding: 0.75rem 1rem;
}

/* Submit Button */
.submit-section .btn-primary {
    background: linear-gradient(45deg, var(--bs-primary), #0d6efd);
    border: none;
    border-radius: 50px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
}

.submit-section .btn-primary:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(13, 110, 253, 0.4);
}

/* Alert Styling */
.alert {
    border-radius: 12px;
}

.alert-info {
    background-color: rgba(13, 202, 240, 0.1);
    border-color: rgba(13, 202, 240, 0.2);
}

/* Select2 Bootstrap 5 Integration */
.select2-container--bootstrap-5 .select2-selection {
    border-radius: 8px !important;
}

/* Responsive Design */
@media (max-width: 767.98px) {
    .submit-header {
        padding: 2rem 1rem;
    }

    .form-section .card-body {
        padding: 1.5rem !important;
    }

    .submit-section .btn-lg {
        width: 100%;
        padding: 1rem 2rem;
    }
}

/* Animation Classes */
.fade-in-up {
    animation: fadeInUp 0.6s ease forwards;
    opacity: 0;
}

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
</style>
<!-- END: main -->