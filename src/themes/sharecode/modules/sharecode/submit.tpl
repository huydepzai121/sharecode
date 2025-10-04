<!-- BEGIN: main -->
<div id="sharecode-submit" class="container">
    <div class="submit-header">
        <h1 class="submit-title">
            <i class="fa fa-upload"></i> Đăng bán sản phẩm
        </h1>
        <p class="submit-subtitle">Chia sẻ code của bạn với cộng đồng và kiếm thu nhập</p>
    </div>

    <!-- BEGIN: errors -->
    <div class="alert alert-danger">
        <h4><i class="fa fa-exclamation-triangle"></i> Có lỗi xảy ra:</h4>
        <ul class="error-list">
            <!-- BEGIN: error -->
            <li>{ERROR}</li>
            <!-- END: error -->
        </ul>
    </div>
    <!-- END: errors -->

    <!-- Submit Form -->
    <div class="submit-form-container">
        <form method="post" enctype="multipart/form-data" class="submit-form">
            <div class="form-sections">
                <!-- Basic Information -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fa fa-info-circle"></i> Thông tin cơ bản
                    </h3>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label required">Tiêu đề sản phẩm:</label>
                            <input type="text" name="title" class="form-input"
                                placeholder="Nhập tiêu đề hấp dẫn cho sản phẩm của bạn" value="{DATA.title}" required>
                            <small class="form-help">Tiêu đề ngắn gọn, súc tích và thu hút người mua</small>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group half-width">
                            <label class="form-label required">Danh mục:</label>
                            <select name="catid" class="form-select" required>
                                <option value="">-- Chọn danh mục --</option>
                                <!-- BEGIN: category -->
                                <option value="{CATEGORY.id}" {CATEGORY.selected}>{CATEGORY.title}</option>
                                <!-- END: category -->
                            </select>
                        </div>
                        <div class="form-group half-width">
                            <label class="form-label">Demo trực tiếp:</label>
                            <input type="url" name="demo_link" class="form-input"
                                placeholder="https://demo.yoursite.com" value="{DATA.demo_link}">
                            <small class="form-help">Link demo để khách hàng xem thử trước khi mua</small>
                        </div>
                    </div>
                </div>

                <!-- Description -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fa fa-file-text"></i> Mô tả sản phẩm
                    </h3>

                    <div class="form-group">
                        <label class="form-label required">Mô tả chi tiết:</label>
                        <textarea name="description" class="form-textarea" rows="8"
                            placeholder="Mô tả chi tiết về sản phẩm, tính năng, công nghệ sử dụng...">{DATA.description}</textarea>
                        <small class="form-help">Mô tả càng chi tiết càng tăng khả năng bán hàng</small>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Từ khóa SEO:</label>
                        <input type="text" name="keywords" class="form-input"
                            placeholder="web, php, javascript, bootstrap" value="{DATA.keywords}">
                        <small class="form-help">Các từ khóa cách nhau bởi dấu phẩy</small>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Tags:</label>
                        <input type="text" name="tags" class="form-input"
                            placeholder="responsive, admin panel, ecommerce" value="{DATA.tags}">
                        <small class="form-help">Thẻ tag giúp người dùng tìm kiếm dễ dàng hơn</small>
                    </div>
                </div>

                <!-- Pricing -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fa fa-money"></i> Thông tin giá bán
                    </h3>

                    <div class="form-group">
                        <label class="form-label">Loại sản phẩm:</label>
                        <div class="radio-group">
                            <label class="radio-option">
                                <input type="radio" name="fee_type" value="free" {CHECKED_FREE}>
                                <span class="radio-custom"></span>
                                <span class="radio-text">
                                    <strong>Miễn phí</strong>
                                    <small>Chia sẻ miễn phí với cộng đồng</small>
                                </span>
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="fee_type" value="paid" {CHECKED_PAID}>
                                <span class="radio-custom"></span>
                                <span class="radio-text">
                                    <strong>Có phí</strong>
                                    <small>Bán với giá cố định</small>
                                </span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group price-input" style="display: none;">
                        <label class="form-label">Giá bán (VNĐ):</label>
                        <input type="text" name="fee_amount" class="form-input price-format" placeholder="50,000"
                            value="{DATA.fee_amount_formatted}" data-raw-value="{DATA.fee_amount}">
                        <small class="form-help">Giá tối thiểu 1,000 VNĐ. Nhập số, hệ thống sẽ tự động format.</small>
                    </div>
                </div>

                <!-- Download Method -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fa fa-download"></i> Phương thức tải xuống
                    </h3>

                    <div class="form-group">
                        <label class="form-label">Cách thức cung cấp file:</label>
                        <div class="radio-group">
                            <label class="radio-option">
                                <input type="radio" name="download_link_type" value="file" {CHECKED_FILE}>
                                <span class="radio-custom"></span>
                                <span class="radio-text">
                                    <strong>Upload file</strong>
                                    <small>Upload file zip lên hệ thống (Khuyến nghị)</small>
                                </span>
                            </label>
                            <label class="radio-option">
                                <input type="radio" name="download_link_type" value="external" {CHECKED_EXTERNAL}>
                                <span class="radio-custom"></span>
                                <span class="radio-text">
                                    <strong>Link bên ngoài</strong>
                                    <small>Cung cấp link Google Drive, Dropbox, etc.</small>
                                </span>
                            </label>
                        </div>
                    </div>

                    <div class="form-group file-upload" style="display: none;">
                        <label class="form-label">Upload file:</label>
                        <div class="file-upload-area">
                            <input type="file" name="source_file" class="file-input" accept=".zip,.rar,.7z">
                            <div class="file-upload-text">
                                <i class="fa fa-cloud-upload fa-2x"></i>
                                <p>Kéo thả file vào đây hoặc <span class="upload-link">click để chọn file</span></p>
                                <small>Chỉ chấp nhận file .zip, .rar, .7z (tối đa 50MB)</small>
                            </div>
                        </div>
                    </div>

                    <div class="form-group external-link" style="display: none;">
                        <label class="form-label">Link tải xuống:</label>
                        <input type="url" name="download_link" class="form-input"
                            placeholder="https://drive.google.com/..." value="{DATA.download_link}">
                        <small class="form-help">Link trực tiếp đến file hoặc thư mục chia sẻ</small>
                    </div>
                </div>

                <!-- Image Upload -->
                <div class="form-section">
                    <h3 class="section-title">
                        <i class="fa fa-image"></i> Hình ảnh sản phẩm
                    </h3>

                    <div class="form-group">
                        <label class="form-label">Hình ảnh đại diện:</label>
                        <div class="image-upload-area">
                            <input type="file" name="product_image" class="image-input" accept="image/*">
                            <div class="image-upload-preview">
                                <i class="fa fa-image fa-3x"></i>
                                <p>Chọn hình ảnh đại diện cho sản phẩm</p>
                                <small>JPG, PNG, GIF (tối đa 5MB, kích thước khuyến nghị: 800x600px)</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Submit Button -->
            <div class="submit-actions">
                <button type="submit" name="submit_product" class="submit-btn">
                    <i class="fa fa-paper-plane"></i> Gửi sản phẩm để duyệt
                </button>
                <p class="submit-note">
                    <i class="fa fa-info-circle"></i>
                    Sản phẩm sẽ được admin kiểm duyệt trong vòng 24-48h.
                    Bạn sẽ nhận được thông báo qua email khi sản phẩm được phê duyệt.
                </p>
            </div>
        </form>
    </div>
</div>

<script>
    $(document).ready(function () {
        // Toggle price input based on fee type
        $('input[name="fee_type"]').change(function () {
            if ($(this).val() === 'paid') {
                $('.price-input').show();
            } else {
                $('.price-input').hide();
            }
        });

        // Toggle download method
        $('input[name="download_link_type"]').change(function () {
            if ($(this).val() === 'file') {
                $('.file-upload').show();
                $('.external-link').hide();
            } else {
                $('.file-upload').hide();
                $('.external-link').show();
            }
        });

        // Price formatting
        $('.price-format').on('input', function () {
            var value = $(this).val().replace(/[^\d]/g, ''); // Remove non-digits
            if (value) {
                var formatted = parseInt(value).toLocaleString('vi-VN');
                $(this).val(formatted);
                $(this).attr('data-raw-value', value);
            } else {
                $(this).attr('data-raw-value', '0');
            }
        });

        // Before form submit, convert formatted price back to number
        $('form').on('submit', function () {
            var priceInput = $('.price-format');
            var rawValue = priceInput.attr('data-raw-value') || '0';
            priceInput.val(rawValue);
        });

        // Initialize based on current values
        if ($('input[name="fee_type"]:checked').val() === 'paid') {
            $('.price-input').show();
        }

        if ($('input[name="download_link_type"]:checked').val() === 'external') {
            $('.external-link').show();
        } else {
            $('.file-upload').show();
        }

        // File upload preview
        $('.file-input').change(function () {
            var file = this.files[0];
            if (file) {
                var fileName = file.name;
                var fileSize = (file.size / 1024 / 1024).toFixed(2) + ' MB';
                $('.file-upload-text p').html('<i class="fa fa-file-archive-o"></i> ' + fileName + ' (' + fileSize + ')');
            }
        });

        // Image upload preview
        $('.image-input').change(function () {
            var file = this.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('.image-upload-preview').html(
                        '<img src="' + e.target.result + '" style="max-width: 200px; max-height: 150px; border-radius: 8px;">' +
                        '<p style="margin-top: 10px;">' + file.name + '</p>'
                    );
                };
                reader.readAsDataURL(file);
            }
        });
    });
</script>

<style>
    /* Submit Page Styles */
    #sharecode-submit {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        padding: 20px 0;
    }

    #sharecode-submit .submit-container {
        max-width: 900px;
        margin: 0 auto;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        overflow: hidden;
    }

    #sharecode-submit .submit-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 40px 30px;
        text-align: center;
    }

    #sharecode-submit .submit-title {
        font-size: 32px;
        font-weight: 700;
        margin: 0 0 10px 0;
    }

    #sharecode-submit .submit-subtitle {
        font-size: 16px;
        opacity: 0.9;
        margin: 0;
    }

    #sharecode-submit .submit-form-container {
        padding: 40px 30px;
    }

    #sharecode-submit .form-section {
        margin-bottom: 40px;
        padding-bottom: 30px;
        border-bottom: 1px solid #e9ecef;
    }

    #sharecode-submit .form-section:last-child {
        border-bottom: none;
        margin-bottom: 0;
    }

    #sharecode-submit .section-title {
        color: #2c3e50;
        font-size: 20px;
        font-weight: 600;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    #sharecode-submit .section-title i {
        color: #667eea;
    }

    #sharecode-submit .form-row {
        display: flex;
        gap: 20px;
        margin-bottom: 20px;
    }

    #sharecode-submit .form-group {
        flex: 1;
        margin-bottom: 20px;
    }

    #sharecode-submit .form-group.half-width {
        flex: 0 0 calc(50% - 10px);
    }

    #sharecode-submit .form-label {
        display: block;
        color: #495057;
        font-weight: 500;
        margin-bottom: 8px;
        font-size: 14px;
    }

    #sharecode-submit .form-label.required::after {
        content: ' *';
        color: #dc3545;
    }

    #sharecode-submit .form-input,
    #sharecode-submit .form-select,
    #sharecode-submit .form-textarea {
        width: 100%;
        padding: 12px 16px;
        border: 2px solid #dee2e6;
        border-radius: 8px;
        font-size: 14px;
        transition: all 0.3s ease;
        box-sizing: border-box;
    }

    #sharecode-submit .form-input:focus,
    #sharecode-submit .form-select:focus,
    #sharecode-submit .form-textarea:focus {
        border-color: #667eea;
        outline: none;
        box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
    }

    #sharecode-submit .form-textarea {
        resize: vertical;
        min-height: 120px;
        line-height: 1.5;
    }

    #sharecode-submit .form-help {
        color: #6c757d;
        font-size: 12px;
        margin-top: 5px;
        display: block;
    }

    #sharecode-submit .radio-group {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    #sharecode-submit .radio-option {
        display: flex;
        align-items: flex-start;
        gap: 12px;
        padding: 15px;
        border: 2px solid #dee2e6;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    #sharecode-submit .radio-option:hover {
        border-color: #667eea;
        background: #f8f9fa;
    }

    #sharecode-submit .radio-option input[type="radio"] {
        display: none;
    }

    #sharecode-submit .radio-custom {
        width: 20px;
        height: 20px;
        border: 2px solid #dee2e6;
        border-radius: 50%;
        position: relative;
        flex-shrink: 0;
        margin-top: 2px;
    }

    #sharecode-submit .radio-option input[type="radio"]:checked+.radio-custom {
        border-color: #667eea;
    }

    #sharecode-submit .radio-option input[type="radio"]:checked+.radio-custom::after {
        content: '';
        width: 10px;
        height: 10px;
        background: #667eea;
        border-radius: 50%;
        position: absolute;
        top: 3px;
        left: 3px;
    }

    #sharecode-submit .radio-text {
        flex: 1;
    }

    #sharecode-submit .radio-text strong {
        display: block;
        color: #2c3e50;
        margin-bottom: 2px;
    }

    #sharecode-submit .radio-text small {
        color: #6c757d;
        font-size: 12px;
    }

    #sharecode-submit .file-upload-area,
    #sharecode-submit .image-upload-area {
        border: 2px dashed #dee2e6;
        border-radius: 8px;
        padding: 40px 20px;
        text-align: center;
        transition: all 0.3s ease;
        cursor: pointer;
    }

    #sharecode-submit .file-upload-area:hover,
    #sharecode-submit .image-upload-area:hover {
        border-color: #667eea;
        background: #f8f9fa;
    }

    #sharecode-submit .file-input,
    #sharecode-submit .image-input {
        display: none;
    }

    #sharecode-submit .file-upload-text,
    #sharecode-submit .image-upload-preview {
        color: #6c757d;
    }

    #sharecode-submit .file-upload-text i,
    #sharecode-submit .image-upload-preview i {
        color: #667eea;
        margin-bottom: 15px;
    }

    #sharecode-submit .upload-link {
        color: #667eea;
        text-decoration: underline;
    }

    #sharecode-submit .submit-actions {
        text-align: center;
        padding-top: 30px;
        border-top: 1px solid #e9ecef;
    }

    #sharecode-submit .submit-btn {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 15px 40px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 10px;
    }

    #sharecode-submit .submit-btn:hover {
        background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
    }

    #sharecode-submit .submit-note {
        color: #6c757d;
        font-size: 13px;
        margin-top: 15px;
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
    }

    #sharecode-submit .alert {
        margin-bottom: 30px;
        padding: 15px 20px;
        border-radius: 8px;
        border: 1px solid transparent;
    }

    #sharecode-submit .alert-danger {
        background: #f8d7da;
        color: #721c24;
        border-color: #f5c6cb;
    }

    #sharecode-submit .error-list {
        margin: 10px 0 0 0;
        padding-left: 20px;
    }

    /* Responsive */
    @media (max-width: 768px) {
        #sharecode-submit .submit-header {
            padding: 30px 20px;
        }

        #sharecode-submit .submit-title {
            font-size: 24px;
        }

        #sharecode-submit .submit-form-container {
            padding: 30px 20px;
        }

        #sharecode-submit .form-row {
            flex-direction: column;
            gap: 0;
        }

        #sharecode-submit .form-group.half-width {
            flex: none;
        }

        #sharecode-submit .radio-group {
            gap: 10px;
        }

        #sharecode-submit .radio-option {
            padding: 12px;
        }
    }
</style>
<!-- END: main -->