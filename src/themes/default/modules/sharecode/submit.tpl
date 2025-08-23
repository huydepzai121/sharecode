<!-- BEGIN: main -->
<link rel="stylesheet" href="{ASSETS_STATIC_URL}/js/select2/select2.min.css">
<script type="text/javascript" src="{ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>
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
                                <input type="text" name="title" class="form-input" placeholder="Nhập tiêu đề hấp dẫn cho sản phẩm của bạn" value="{DATA.title}" required>
                                <small class="form-help">Tiêu đề ngắn gọn, súc tích và thu hút người mua</small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Liên kết tĩnh:</label>
                                <input type="text" name="alias" class="form-input" placeholder="Tự động tạo từ tiêu đề..." value="{DATA.alias}">
                                <small class="form-help">
                                    <i class="fa fa-magic"></i>
                                    Tự động tạo từ tiêu đề. Bạn có thể chỉnh sửa nếu muốn tùy chỉnh URL
                                </small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group half-width">
                                <label class="form-label required">Danh mục:</label>
                                <select name="catid" class="form-select" required>
                                    <option value="">-- Chọn danh mục --</option>
                                    <!-- BEGIN: category -->
                                    <option value="{CATEGORY.id}" {CATEGORY.selected}>{CATEGORY.level_prefix}{CATEGORY.title}</option>
                                    <!-- END: category -->
                                </select>
                            </div>
                            <div class="form-group half-width">
                                <label class="form-label">Demo trực tiếp:</label>
                                <input type="url" name="demo_link" class="form-input" placeholder="https://demo.yoursite.com" value="{DATA.demo_link}">
                                <small class="form-help">Link demo để khách hàng xem thử trước khi mua</small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label">Link nguồn bên ngoài:</label>
                                <input type="url" name="external_source_link" class="form-input" placeholder="https://github.com/yourproject" value="{DATA.external_source_link}">
                                <small class="form-help">Link GitHub, GitLab hoặc nguồn code gốc (nếu có)</small>
                            </div>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="form-section">
                        <h3 class="section-title">
                            <i class="fa fa-file-text"></i> Mô tả sản phẩm
                        </h3>
                        
                        <div class="form-group">
                            <label class="form-label required">Mô tả ngắn:</label>
                            <textarea name="description" class="form-textarea" rows="4" placeholder="Mô tả ngắn gọn về sản phẩm...">{DATA.description}</textarea>
                            <small class="form-help">Mô tả ngắn gọn hiển thị trong danh sách sản phẩm</small>
                        </div>

                        <div class="form-group">
                            <label class="form-label required">Mô tả chi tiết:</label>
                            <textarea name="content" class="form-textarea" rows="12" placeholder="Mô tả chi tiết về sản phẩm, tính năng, công nghệ sử dụng, hướng dẫn cài đặt...">{DATA.content}</textarea>
                            <small class="form-help">Mô tả càng chi tiết càng tăng khả năng bán hàng. Hỗ trợ HTML</small>
                        </div>

                        <!-- Keywords Section -->
                        <div class="form-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-8">
                                            <h4 class="panel-title">
                                                <i class="fa fa-key"></i> Từ khóa tìm kiếm
                                            </h4>
                                        </div>
                                        <div class="col-xs-4 text-right">
                                            <button type="button" class="btn btn-default btn-xs" title="Tạo tự động từ khóa từ nội dung" id="keywords-auto-create">
                                                <i class="fa fa-magic"></i> Tự động
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <select id="keywords-select" class="form-control" name="keywords[]" multiple data-placeholder="Chọn từ khóa...">
                                    </select>
                                    <small class="form-help">
                                        <i class="fa fa-info-circle"></i>
                                        Chọn từ danh sách có sẵn hoặc nhập từ khóa mới. Tối đa 15 từ khóa.
                                    </small>
                                </div>
                            </div>
                        </div>

                        <!-- Tags Section -->
                        <div class="form-group">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-8">
                                            <h4 class="panel-title">
                                                <i class="fa fa-tags"></i> Tags cho mã nguồn
                                            </h4>
                                        </div>
                                        <div class="col-xs-4 text-right">
                                            <button type="button" class="btn btn-default btn-xs" title="Tạo tự động tags dựa vào nội dung mã nguồn" id="tags-auto-create">
                                                <i class="fa fa-magic"></i> Tự động
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <select id="tags-select" class="form-control" name="tags[]" multiple data-placeholder="Nhập tag...">
                                    </select>
                                    <small class="form-help">
                                        <i class="fa fa-tags"></i>
                                        Chọn từ danh sách có sẵn hoặc nhập tag mới. Tối đa 20 tags.
                                    </small>
                                </div>
                            </div>
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
                            <input type="number" name="fee_amount" class="form-input" placeholder="50000" value="{DATA.fee_amount}" min="1000" step="1000">
                            <small class="form-help">Giá tối thiểu 1,000 VNĐ</small>
                        </div>
                    </div>

                    <!-- Download Method -->
                    <div class="form-section">
                        <h3 class="section-title">
                            <i class="fa fa-download"></i> Phương thức tải xuống
                        </h3>
                        
                        <div class="form-group">
                            <label class="form-label required">Link tải xuống:</label>
                            <input type="url" name="download_link" class="form-input" placeholder="https://drive.google.com/file/d/..." value="{DATA.download_link}" required>
                            <input type="hidden" name="download_link_type" value="external">
                            <small class="form-help">
                                <i class="fa fa-info-circle"></i>
                                Khuyến nghị sử dụng: Google Drive, Dropbox, GitHub, OneDrive hoặc các dịch vụ lưu trữ đáng tin cậy khác
                            </small>
                            <div class="form-help-examples">
                                <strong>Ví dụ link hợp lệ:</strong>
                                <ul>
                                    <li>Google Drive: https://drive.google.com/file/d/1ABC.../view</li>
                                    <li>Dropbox: https://www.dropbox.com/s/abc123/file.zip</li>
                                    <li>GitHub: https://github.com/user/repo/archive/main.zip</li>
                                    <li>OneDrive: https://1drv.ms/u/s!ABC123...</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Information -->
                    <div class="form-section">
                        <h3 class="section-title">
                            <i class="fa fa-phone"></i> Thông tin liên hệ
                        </h3>

                        <div class="form-row">
                            <div class="form-group half-width">
                                <label class="form-label">Số điện thoại:</label>
                                <input type="tel" name="contact_phone" class="form-input" placeholder="0123456789" value="{DATA.contact_phone}">
                                <small class="form-help">Số điện thoại để khách hàng liên hệ</small>
                            </div>
                            <div class="form-group half-width">
                                <label class="form-label">Email:</label>
                                <input type="email" name="contact_email" class="form-input" placeholder="contact@example.com" value="{DATA.contact_email}">
                                <small class="form-help">Email để khách hàng liên hệ</small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group half-width">
                                <label class="form-label">Skype:</label>
                                <input type="text" name="contact_skype" class="form-input" placeholder="your.skype.id" value="{DATA.contact_skype}">
                                <small class="form-help">ID Skype của bạn</small>
                            </div>
                            <div class="form-group half-width">
                                <label class="form-label">Telegram:</label>
                                <input type="text" name="contact_telegram" class="form-input" placeholder="@yourtelegram" value="{DATA.contact_telegram}">
                                <small class="form-help">Username Telegram của bạn</small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group half-width">
                                <label class="form-label">Zalo:</label>
                                <input type="text" name="contact_zalo" class="form-input" placeholder="0123456789" value="{DATA.contact_zalo}">
                                <small class="form-help">Số Zalo của bạn</small>
                            </div>
                            <div class="form-group half-width">
                                <label class="form-label">Facebook:</label>
                                <input type="url" name="contact_facebook" class="form-input" placeholder="https://facebook.com/yourprofile" value="{DATA.contact_facebook}">
                                <small class="form-help">Link Facebook của bạn</small>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group half-width">
                                <label class="form-label">Website:</label>
                                <input type="url" name="contact_website" class="form-input" placeholder="https://yourwebsite.com" value="{DATA.contact_website}">
                                <small class="form-help">Website cá nhân hoặc công ty</small>
                            </div>
                            <div class="form-group half-width">
                                <label class="form-label">Địa chỉ:</label>
                                <textarea name="contact_address" class="form-textarea" rows="3" placeholder="Địa chỉ liên hệ...">{DATA.contact_address}</textarea>
                                <small class="form-help">Địa chỉ liên hệ (nếu cần)</small>
                            </div>
                        </div>
                    </div>

                    <!-- Image Upload -->
                    <div class="form-section">
                        <h3 class="section-title">
                            <i class="fa fa-image"></i> Hình ảnh sản phẩm
                        </h3>
                        
                        <div class="form-group">
                            <label class="form-label">Hình ảnh đại diện:</label>
                            <div class="image-upload-container">
                                <input type="file" name="product_image" id="product_image" class="image-input" accept="image/*" style="display: none;">
                                <div class="image-upload-area" onclick="document.getElementById('product_image').click();">
                                    <div class="image-upload-preview">
                                        <i class="fa fa-cloud-upload fa-3x"></i>
                                        <p><strong>Click để chọn hình ảnh đại diện</strong></p>
                                        <p>hoặc kéo thả file vào đây</p>
                                        <small>JPG, PNG, GIF (tối đa 5MB, kích thước khuyến nghị: 800x600px)</small>
                                    </div>
                                </div>
                                <div class="upload-buttons">
                                    <button type="button" class="btn btn-primary btn-upload" onclick="document.getElementById('product_image').click();">
                                        <i class="fa fa-upload"></i> Chọn ảnh từ máy tính
                                    </button>
                                    <button type="button" class="btn btn-secondary btn-clear" onclick="clearImageUpload()" style="display: none;">
                                        <i class="fa fa-times"></i> Xóa ảnh
                                    </button>
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
$(document).ready(function() {
    // Initialize Select2 for keywords
    $('#keywords-select').select2({
        width: '100%',
        tags: true,
        tokenSeparators: [',', ' '],
        placeholder: 'Chọn từ khóa...',
        allowClear: true,
        maximumSelectionLength: 15,
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

    // Initialize Select2 for tags
    $('#tags-select').select2({
        width: '100%',
        tags: true,
        tokenSeparators: [',', ' '],
        placeholder: 'Nhập tag...',
        allowClear: true,
        maximumSelectionLength: 20,
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

    // Load available keywords and tags
    var availableKeywords = {AVAILABLE_KEYWORDS_JSON};
    var availableTags = {AVAILABLE_TAGS_JSON};

    // Add keywords to select2
    if (availableKeywords && availableKeywords.length > 0) {
        availableKeywords.forEach(function(keyword) {
            var newOption = new Option(keyword.name, keyword.name, false, false);
            $('#keywords-select').append(newOption);
        });
    }

    // Add tags to select2
    if (availableTags && availableTags.length > 0) {
        availableTags.forEach(function(tag) {
            var newOption = new Option(tag.name, tag.name, false, false);
            $('#tags-select').append(newOption);
        });
    }
    $('input[name="title"]').on('input', function() {
        var title = $(this).val();
        var aliasField = $('input[name="alias"]');

        if (aliasField.val() === '' || aliasField.data('auto-generated')) {
            var alias = generateAlias(title);
            aliasField.val(alias).data('auto-generated', true);
        }
    });

    // Mark alias as manually edited when user types in it
    $('input[name="alias"]').on('input', function() {
        $(this).data('auto-generated', false);
    });

    // Toggle price input based on fee type
    $('input[name="fee_type"]').change(function() {
        if ($(this).val() === 'paid') {
            $('.price-input').show();
        } else {
            $('.price-input').hide();
        }
    });

    // Initialize based on current values
    if ($('input[name="fee_type"]:checked').val() === 'paid') {
        $('.price-input').show();
    }

    // Auto-create keywords button functionality
    $('#keywords-auto-create').on('click', function() {
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
            autoKeywords.forEach(function(keyword) {
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
    $('#tags-auto-create').on('click', function() {
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
            autoTags.forEach(function(tag) {
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



    // Image upload preview
    $('#product_image').change(function() {
        var file = this.files[0];
        if (file) {
            // Kiểm tra kích thước file (5MB = 5 * 1024 * 1024 bytes)
            if (file.size > 5 * 1024 * 1024) {
                alert('File quá lớn! Vui lòng chọn file nhỏ hơn 5MB.');
                this.value = '';
                return;
            }

            // Kiểm tra định dạng file
            var allowedTypes = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
            if (!allowedTypes.includes(file.type)) {
                alert('Định dạng file không hợp lệ! Chỉ chấp nhận JPG, PNG, GIF.');
                this.value = '';
                return;
            }

            var reader = new FileReader();
            reader.onload = function(e) {
                $('.image-upload-preview').html(
                    '<img src="' + e.target.result + '" style="max-width: 200px; max-height: 150px; border-radius: 8px; border: 1px solid #ddd;">' +
                    '<p style="margin-top: 10px; color: #333;"><strong>' + file.name + '</strong></p>' +
                    '<p style="margin: 5px 0; color: #666; font-size: 12px;">Kích thước: ' + (file.size / 1024 / 1024).toFixed(2) + ' MB</p>'
                );
                $('.btn-clear').show();
            };
            reader.readAsDataURL(file);
        }
    });

    // Function to remove selected image
    window.removeImage = function() {
        $('#product_image').val('');
        $('.image-upload-preview').html(
            '<i class="fa fa-cloud-upload fa-3x"></i>' +
            '<p><strong>Click để chọn hình ảnh đại diện</strong></p>' +
            '<p>hoặc kéo thả file vào đây</p>' +
            '<small>JPG, PNG, GIF (tối đa 5MB, kích thước khuyến nghị: 800x600px)</small>'
        );
        $('.btn-clear').hide();
    };

    // Function to clear image upload
    window.clearImageUpload = function() {
        window.removeImage();
    };

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
        techKeywords.forEach(function(keyword) {
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
        techKeywords.forEach(function(keyword) {
            if (content.includes(keyword) && tags.indexOf(keyword) === -1) {
                tags.push(keyword);
            }
        });

        // Extract words that might be tags (2-15 characters, alphanumeric)
        var words = content.match(/\b[a-zA-Z][a-zA-Z0-9]{1,14}\b/g) || [];
        var commonWords = ['the', 'and', 'for', 'are', 'but', 'not', 'you', 'all', 'can', 'had', 'her', 'was', 'one', 'our', 'out', 'day', 'get', 'has', 'him', 'how', 'man', 'new', 'now', 'old', 'see', 'two', 'way', 'who', 'boy', 'did', 'its', 'let', 'put', 'say', 'she', 'too', 'use', 'that', 'with', 'have', 'this', 'will', 'your', 'from', 'they', 'know', 'want', 'been', 'good', 'much', 'some', 'time', 'very', 'when', 'come', 'here', 'just', 'like', 'long', 'make', 'many', 'over', 'such', 'take', 'than', 'them', 'well', 'were'];

        words.forEach(function(word) {
            if (word.length >= 3 && word.length <= 15 &&
                commonWords.indexOf(word.toLowerCase()) === -1 &&
                tags.indexOf(word.toLowerCase()) === -1 &&
                tags.length < 8) {
                tags.push(word.toLowerCase());
            }
        });

        return tags.slice(0, 8); // Limit to 8 auto-generated tags
    }
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
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
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

#sharecode-submit .radio-option input[type="radio"]:checked + .radio-custom {
    border-color: #667eea;
}

#sharecode-submit .radio-option input[type="radio"]:checked + .radio-custom::after {
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
    background: #fafbfc;
    position: relative;
}

#sharecode-submit .file-upload-area:hover,
#sharecode-submit .image-upload-area:hover {
    border-color: #667eea;
    background: #f0f4ff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.15);
}

#sharecode-submit .image-upload-area::before {
    content: '';
    position: absolute;
    top: 10px;
    right: 10px;
    width: 20px;
    height: 20px;
    background: #667eea;
    border-radius: 50%;
    opacity: 0.7;
}

#sharecode-submit .image-upload-area::after {
    content: '+';
    position: absolute;
    top: 13px;
    right: 16px;
    color: white;
    font-size: 14px;
    font-weight: bold;
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
    display: block;
}

#sharecode-submit .image-upload-preview p {
    margin: 10px 0 5px 0;
    font-size: 16px;
}

#sharecode-submit .image-upload-preview p:first-of-type {
    color: #333;
    font-weight: 600;
}

#sharecode-submit .image-upload-preview p:nth-of-type(2) {
    color: #667eea;
    font-size: 14px;
    margin-bottom: 15px;
}

#sharecode-submit .image-upload-preview small {
    color: #6c757d;
    font-size: 12px;
    display: block;
    margin-top: 10px;
}

#sharecode-submit .upload-link {
    color: #667eea;
    text-decoration: underline;
}

/* Upload buttons */
#sharecode-submit .image-upload-container {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

#sharecode-submit .upload-buttons {
    display: flex;
    gap: 10px;
    justify-content: center;
}

#sharecode-submit .btn-upload {
    background: #667eea;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

#sharecode-submit .btn-upload:hover {
    background: #5a6fd8;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
}

#sharecode-submit .btn-clear {
    background: #dc3545;
    color: white;
    border: none;
    padding: 12px 24px;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
}

#sharecode-submit .btn-clear:hover {
    background: #c82333;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
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

/* Panel styles for Bootstrap 3 */
#sharecode-submit .panel {
    margin-bottom: 20px;
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    box-shadow: 0 1px 1px rgba(0,0,0,.05);
}

#sharecode-submit .panel-heading {
    padding: 10px 15px;
    border-bottom: 1px solid #ddd;
    border-top-left-radius: 3px;
    border-top-right-radius: 3px;
    background-color: #f5f5f5;
}

#sharecode-submit .panel-title {
    margin: 0;
    font-size: 16px;
    color: #333;
}

#sharecode-submit .panel-body {
    padding: 15px;
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