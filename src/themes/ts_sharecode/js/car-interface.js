/**
 * Car Interface JavaScript
 * Xử lý bộ lọc và các tương tác
 */

$(document).ready(function() {

    // Initialize car features
    initCarFeatures();

    // Initialize header search
    initHeaderSearch();

    // Xử lý bộ lọc - KHÔI PHỤC VÀ SỬA LẠI
    $('#apply-filter').click(function() {
        var filters = {
            car_name: $('#name-filter').val().trim(),
            car_type_alias: $('#type-filter').val(), // Lưu alias thay vì ID
            price_range: $('#price-filter').val(),
            year: $('#year-filter').val(),
            sort_by: $('#sort-filter').val()
        };

        // Xây dựng URL mới
        var currentPath = window.location.pathname;
        var pathParts = currentPath.split('/').filter(part => part !== '');
        var newUrl;

        // Xử lý URL path cho category alias
        if (filters.car_type_alias) {
            // Có chọn loại xe -> URL dạng /category/alias
            if (pathParts.length >= 1) {
                newUrl = window.location.origin + '/' + pathParts[0] + '/' + filters.car_type_alias;
            } else {
                newUrl = window.location.origin + '/' + filters.car_type_alias;
            }
        } else {
            // Không chọn loại xe -> URL gốc /category/
            if (pathParts.length >= 1) {
                newUrl = window.location.origin + '/' + pathParts[0] + '/';
            } else {
                newUrl = window.location.origin + '/';
            }
        }

        var url = new URL(newUrl);

        // Thêm các filter khác vào query string (KHÔNG thêm car_type)
        if (filters.car_name) url.searchParams.set('car_name', filters.car_name);
        if (filters.price_range) url.searchParams.set('price_range', filters.price_range);
        if (filters.year) url.searchParams.set('year', filters.year);
        if (filters.sort_by && filters.sort_by !== 'newest') url.searchParams.set('sort_by', filters.sort_by);

        history.pushState("", "", url);

        // Reload trang để backend xử lý
        window.location.href = url.toString();
    });

    // Đặt lại bộ lọc - KHÔI PHỤC
    $('#reset-filter').click(function() {
        $('#name-filter').val('');
        $('#type-filter').val('');
        $('#price-filter').val('');
        $('#year-filter').val('');
        $('#sort-filter').val('newest');

        // Quay về URL gốc /category/
        var currentPath = window.location.pathname;
        var pathParts = currentPath.split('/').filter(part => part !== '');
        var resetUrl;
        if (pathParts.length >= 1) {
            resetUrl = window.location.origin + '/' + pathParts[0] + '/';
        } else {
            resetUrl = window.location.origin + '/';
        }

        window.location.href = resetUrl;
    });

    // Xử lý tìm kiếm khi nhấn Enter - VÔ HIỆU HÓA CODE CŨ
    // Code mới đã được xử lý trong category.tpl
    // $('#name-filter').on('keypress', function(e) {
    //     ... code cũ đã bị vô hiệu hóa ...
    // });

    // Khôi phục bộ lọc từ URL - VÔ HIỆU HÓA CODE CŨ
    // Code mới đã được xử lý trong category.tpl
    // function restoreFilterFromURL() {
    //     ... code cũ đã bị vô hiệu hóa ...
    // }
    // restoreFilterFromURL();
    
    // Xử lý thay đổi ảnh chính trong trang chi tiết
    $('.thumbnail-image').click(function() {
        var newSrc = $(this).attr('src');
        $('.main-car-image').attr('src', newSrc);
        
        // Highlight thumbnail được chọn
        $('.thumbnail-image').removeClass('active');
        $(this).addClass('active');
    });
    
    // Xử lý form liên hệ
    $('.contact-form').submit(function(e) {
        e.preventDefault();
        
        var formData = {
            name: $(this).find('input[type="text"]').val(),
            phone: $(this).find('input[type="tel"]').val(),
            email: $(this).find('input[type="email"]').val(),
            message: $(this).find('textarea').val()
        };
        
        // Validate form
        if (!formData.name || !formData.phone) {
            showNotification('Vui lòng nhập đầy đủ họ tên và số điện thoại!', 'warning');
            return;
        }
        
        // Hiển thị loading
        showLoading();
        
        // Gửi AJAX request
        $.ajax({
            url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax-contact',
            type: 'POST',
            data: formData,
            dataType: 'json',
            success: function(response) {
                hideLoading();
                if (response.status === 'success') {
                    showNotification('Gửi liên hệ thành công! Chúng tôi sẽ liên hệ lại với bạn sớm nhất.', 'success');
                    $('.contact-form')[0].reset();
                } else {
                    showNotification(response.message || 'Có lỗi xảy ra khi gửi liên hệ!', 'error');
                }
            },
            error: function() {
                hideLoading();
                showNotification('Có lỗi xảy ra khi kết nối server!', 'error');
            }
        });
    });
    
    // Xử lý nút yêu thích
    $('.btn:contains("Yêu thích")').click(function(e) {
        e.preventDefault();
        
        var $btn = $(this);
        var carId = getCarIdFromUrl();
        
        if (!carId) {
            showNotification('Không tìm thấy thông tin xe!', 'error');
            return;
        }
        
        $.ajax({
            url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=ajax-favorite',
            type: 'POST',
            data: { car_id: carId },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    if (response.action === 'added') {
                        $btn.removeClass('btn-outline-primary').addClass('btn-danger');
                        $btn.html('<i class="bx bx-heart"></i> Đã yêu thích');
                        showNotification('Đã thêm vào danh sách yêu thích!', 'success');
                    } else {
                        $btn.removeClass('btn-danger').addClass('btn-outline-primary');
                        $btn.html('<i class="bx bx-heart"></i> Yêu thích');
                        showNotification('Đã xóa khỏi danh sách yêu thích!', 'info');
                    }
                } else {
                    showNotification(response.message || 'Có lỗi xảy ra!', 'error');
                }
            },
            error: function() {
                showNotification('Có lỗi xảy ra khi kết nối server!', 'error');
            }
        });
    });
    
    // Smooth scroll cho tabs
    $('.car-tabs .nav-link').click(function(e) {
        e.preventDefault();
        var target = $(this).attr('href');
        
        // Activate tab
        $('.car-tabs .nav-link').removeClass('active');
        $(this).addClass('active');
        
        $('.tab-pane').removeClass('show active');
        $(target).addClass('show active');
        
        // Smooth scroll
        $('html, body').animate({
            // scrollTop: $(target).offset().top - 100
        }, 500);
    });
});

// Utility functions
function showLoading() {
    if ($('.loading-overlay').length === 0) {
        $('body').append('<div class="loading-overlay"><div class="loading-spinner"></div></div>');
    }
    $('.loading-overlay').show();
}

function hideLoading() {
    $('.loading-overlay').hide();
}

function showNotification(message, type) {
    type = type || 'info';
    
    // Tạo notification element
    var notification = $('<div class="notification notification-' + type + '">' + message + '</div>');
    
    // Thêm vào body
    $('body').append(notification);
    
    // Hiển thị với animation
    setTimeout(function() {
        notification.addClass('show');
    }, 100);
    
    // Tự động ẩn sau 3 giây
    setTimeout(function() {
        notification.removeClass('show');
        setTimeout(function() {
            notification.remove();
        }, 300);
    }, 3000);
}

function getCarIdFromUrl() {
    var urlParams = new URLSearchParams(window.location.search);
    return urlParams.get('id');
}

// Change main image function (for detail page)
function changeMainImage(src) {
    $('.main-car-image').attr('src', src);

    // Highlight thumbnail
    $('.thumbnail-image').removeClass('active');
    $('.thumbnail-image[src="' + src + '"]').addClass('active');
}

/**
 * Initialize Car Features
 * Xử lý các tính năng mới: promotion badge, option icons
 */
function initCarFeatures() {

    // Tooltip cho option icons
    $('.option-icon').each(function() {
        var $this = $(this);
        var title = $this.attr('title');

        if (title) {
            $this.tooltip({
                placement: 'left',
                trigger: 'hover',
                title: title
            });
        }
    });

    // Animation cho promotion badge
    $('.promotion-badge').hover(
        function() {
            $(this).find('.discount-percent').addClass('animate__pulse');
        },
        function() {
            $(this).find('.discount-percent').removeClass('animate__pulse');
        }
    );

    // Click tracking cho option icons
    $('.option-icon').click(function(e) {
        e.preventDefault();
        var optionType = $(this).find('i').attr('class');
        var optionValue = $(this).find('span').text();

        // Show detailed info in modal or tooltip
        showOptionDetails(optionType, optionValue);
    });

    // Lazy load promotion animations
    setTimeout(function() {
        $('.promotion-badge .discount-percent').addClass('animate__animated animate__pulse');
    }, 1000);

    // Responsive adjustments
    handleResponsiveFeatures();

    // Window resize handler
    $(window).resize(function() {
        handleResponsiveFeatures();
    });
}

/**
 * Show option details
 */
function showOptionDetails(optionType, optionValue) {
    var title = '';
    var content = '';

    if (optionType.includes('tachometer')) {
        title = 'Công suất động cơ';
        content = 'Thông số: ' + optionValue + '<br>Động cơ mạnh mẽ, vận hành êm ái và tiết kiệm nhiên liệu.';
    } else if (optionType.includes('gas-pump')) {
        title = 'Loại nhiên liệu';
        content = 'Nhiên liệu: ' + optionValue + '<br>Hệ thống nhiên liệu hiện đại, thân thiện với môi trường.';
    } else if (optionType.includes('user')) {
        title = 'Số chỗ ngồi';
        content = 'Sức chứa: ' + optionValue + ' người<br>Ghế ngồi thoải mái với chất liệu cao cấp.';
    } else if (optionType.includes('calendar')) {
        title = 'Năm sản xuất';
        content = 'Năm: ' + optionValue + '<br>Xe mới với công nghệ tiên tiến nhất.';
    } else if (optionType.includes('palette')) {
        title = 'Màu sắc';
        content = 'Màu: ' + optionValue + '<br>Sơn cao cấp, bền màu theo thời gian.';
    }

    // Show notification with details
    showNotification(title + ': ' + optionValue, 'info');
}

/**
 * Handle responsive features
 */
function handleResponsiveFeatures() {
    var windowWidth = $(window).width();

    if (windowWidth <= 480) {
        // Very small screens - hide option text, show only icons
        $('.option-icon span').hide();
        $('.car-options-icons').addClass('mobile-compact');
    } else if (windowWidth <= 768) {
        // Mobile screens - show abbreviated text
        $('.option-icon span').show();
        $('.car-options-icons').removeClass('mobile-compact');

        // Truncate long text
        $('.option-icon span').each(function() {
            var text = $(this).text();
            if (text.length > 10) {
                $(this).text(text.substring(0, 8) + '...');
            }
        });
    } else {
        // Desktop - show full text
        $('.option-icon span').show();
        $('.car-options-icons').removeClass('mobile-compact');
    }
}

/**
 * Initialize Header Search functionality
 */
function initHeaderSearch() {
    var searchTimeout;
    var searchContainer = $('#search-container');
    var searchInput = $('#search-input');
    var searchResults = $('#search-results');
    var searchCloseBtn = $('#search-close');
    var linkSearch = $('.link-search');

    // Show search box when click search icon
    linkSearch.on('click', function(e) {
        e.preventDefault();
        searchContainer.fadeIn(300);
        searchInput.focus();
        $('body').addClass('search-active');
        searchResults.html('<div class="search-no-results">Vui lòng chọn xe theo nhu cầu của bạn để tìm kiếm</div>');
    });

    // Hide search box when click close button
    searchCloseBtn.on('click', function() {
        hideSearchBox();
    });

    // Hide search box when click outside
    searchContainer.on('click', function(e) {
        if (e.target === this) {
            hideSearchBox();
        }
    });

    // Hide search box when press ESC
    $(document).on('keydown', function(e) {
        if (e.keyCode === 27 && searchContainer.is(':visible')) {
            hideSearchBox();
        }
    });

    // Search input handler
    searchInput.on('input', function() {
        var query = $(this).val().trim();

        // Clear previous timeout
        if (searchTimeout) {
            clearTimeout(searchTimeout);
        }

        if (query.length === 0) {
            searchResults.empty();
            return;
        }

        // if (query.length < 2) {
        //     searchResults.html('<div class="search-no-results">Vui lòng nhập ít nhất 2 ký tự để tìm kiếm</div>');
        //     return;
        // }

        // Show loading
        searchResults.html('<div class="search-loading"><i class="fa fa-spinner fa-spin"></i> Đang tìm kiếm...</div>');
    });

    // Perform AJAX search
    function performSearch(query) {
        $.ajax({
            url: nv_base_siteurl + 'index.php?language=' + nv_lang_data + '&nv=car-interface&op=ajax',
            type: 'POST',
            data: {
                action: 'search_cars',
                query: query
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    displaySearchResults(response.data);
                } else {
                    searchResults.html('<div class="search-no-results">' + (response.message || 'Có lỗi xảy ra khi tìm kiếm') + '</div>');
                }
            },
            error: function() {
                searchResults.html('<div class="search-no-results">Có lỗi xảy ra khi tìm kiếm. Vui lòng thử lại.</div>');
            }
        });
    }

    // Display search results
    function displaySearchResults(cars) {
        if (!cars || cars.length === 0) {
            searchResults.html('<div class="search-no-results"><i class="fa fa-search"></i> Không tìm thấy xe nào phù hợp</div>');
            return;
        }

        var html = '';
        cars.forEach(function(car) {
            var imageUrl = car.main_image || (nv_base_siteurl + 'themes/car_mercedes/images/no-image.jpg');
            var priceText = car.price_formatted || 'Liên hệ';

            html += '<a href="' + car.detail_url + '" class="search-result-item">';
            html += '    <img src="' + imageUrl + '" alt="' + car.title + '" class="search-result-image">';
            html += '    <div class="search-result-content">';
            html += '        <div class="search-result-title">';
            html += '            <i class="fa fa-car text-primary"></i> ' + car.title;
            html += '        </div>';
            html += '        <div class="search-result-info">';
            html += '            <span class="search-result-price">';
            html += '                <i class="fa fa-money text-success"></i> ' + priceText;
            html += '            </span>';
            if (car.year) {
                html += '            <span class="search-result-year">';
                html += '                <i class="fa fa-calendar text-info"></i> ' + car.year;
                html += '            </span>';
            }
            if (car.fuel_type) {
                html += '            <span class="search-result-fuel">';
                html += '                <i class="fa fa-tint text-warning"></i> ' + car.fuel_type;
                html += '            </span>';
            }
            if (car.seats) {
                html += '            <span class="search-result-seats">';
                html += '                <i class="fa fa-users text-muted"></i> ' + car.seats + ' chỗ';
                html += '            </span>';
            }
            html += '        </div>';
            html += '    </div>';
            html += '    <div class="search-result-arrow">';
            html += '        <i class="fa fa-chevron-right"></i>';
            html += '    </div>';
            html += '</a>';
        });

        searchResults.html(html);
    }

    // Hide search box
    function hideSearchBox() {
        searchContainer.fadeOut(300);
        searchInput.val('');
        searchResults.empty();
        $('body').removeClass('search-active');
    }
}
