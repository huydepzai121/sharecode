<?php

/**
 * @Project SHARECODE 5.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2025 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Friday, January 18, 2025 10:00:00 AM
 */

if (!defined('NV_ADMIN')) {
    die('Stop!!!');
}

/**
 * Note:
 * 	- Module var is: $lang, $module_file, $module_data, $module_upload, $module_theme, $module_name
 * 	- Accept global var: $db, $db_config, $global_config
 */

$arrSQL = [];

// Insert sample categories - Match action_mysql.php structure
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_categories (parentid, title, alias, description, weight, status, add_time) VALUES(0, 'PHP Scripts', 'php-scripts', 'Các script và ứng dụng PHP chất lượng cao cho website và ứng dụng web', 1, 1, " . NV_CURRENTTIME . ")";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_categories (parentid, title, alias, description, weight, status, add_time) VALUES(0, 'JavaScript', 'javascript', 'Thư viện và script JavaScript hiện đại', 2, 1, " . NV_CURRENTTIME . ")";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_categories (parentid, title, alias, description, weight, status, add_time) VALUES(0, 'HTML Templates', 'html-templates', 'Template HTML responsive và hiện đại', 3, 1, " . NV_CURRENTTIME . ")";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_categories (parentid, title, alias, description, weight, status, add_time) VALUES(0, 'CSS Frameworks', 'css-frameworks', 'Framework và thư viện CSS', 4, 1, " . NV_CURRENTTIME . ")";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_categories (parentid, title, alias, description, weight, status, add_time) VALUES(0, 'WordPress', 'wordpress', 'Theme và plugin WordPress', 5, 1, " . NV_CURRENTTIME . ")";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_categories (parentid, title, alias, description, weight, status, add_time) VALUES(0, 'Mobile Apps', 'mobile-apps', 'Ứng dụng di động cho Android và iOS', 6, 1, " . NV_CURRENTTIME . ")";

// Insert sample tags - Match updated structure with weight, status, total_sources fields
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('responsive', 'responsive', 'Hỗ trợ responsive design', 1, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('bootstrap', 'bootstrap', 'Sử dụng Bootstrap framework', 2, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('jquery', 'jquery', 'Sử dụng jQuery library', 3, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('admin', 'admin', 'Giao diện quản trị', 4, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('ecommerce', 'ecommerce', 'Thương mại điện tử', 5, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('cms', 'cms', 'Hệ thống quản lý nội dung', 6, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('php', 'php', 'Ngôn ngữ lập trình PHP', 7, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('mysql', 'mysql', 'Hệ quản trị cơ sở dữ liệu MySQL', 8, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('laravel', 'laravel', 'Framework Laravel PHP', 9, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('vue', 'vue', 'Vue.js framework', 10, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('react', 'react', 'React library', 11, 1, 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, total_sources) VALUES('nodejs', 'nodejs', 'Node.js runtime', 12, 1, 0)";

// Insert sample sources - Match new marketplace structure  
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (catid, title, alias, description, content, demo_link, fee_type, fee_amount, num_view, num_download, avg_rating, status, add_time, userid, username) VALUES(1, 'PHP CMS System', 'php-cms-system', 'Hệ thống quản lý nội dung (CMS) được xây dựng hoàn toàn bằng PHP và MySQL.', 'Đây là một giải pháp hoàn chỉnh cho việc quản lý website với giao diện admin hiện đại và nhiều tính năng mạnh mẽ như: quản lý người dùng, SEO tối ưu, bảo mật cao, responsive design.', 'https://demo.example.com/cms', 'free', 0.00, 1234, 345, 4.8, 1, " . NV_CURRENTTIME . ", 1, 'admin')";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (catid, title, alias, description, content, demo_link, fee_type, fee_amount, num_view, num_download, avg_rating, status, add_time, userid, username) VALUES(1, 'E-commerce Platform', 'ecommerce-platform', 'Hệ thống bán hàng trực tuyến với đầy đủ tính năng thanh toán, quản lý sản phẩm, đơn hàng.', 'Platform thương mại điện tử hoàn chỉnh với tích hợp nhiều cổng thanh toán (VNPay, PayPal, Stripe), quản lý kho hàng, báo cáo doanh thu, hệ thống khuyến mãi và nhiều tính năng khác.', 'https://demo.example.com/shop', 'paid', 199000.00, 892, 156, 4.9, 1, " . NV_CURRENTTIME . ", 1, 'admin')";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (catid, title, alias, description, content, demo_link, fee_type, fee_amount, num_view, num_download, avg_rating, status, add_time, userid, username) VALUES(1, 'Blog Management System', 'blog-management-system', 'Hệ thống blog đơn giản với editor WYSIWYG và quản lý bài viết hiệu quả.', 'Blog system với editor WYSIWYG mạnh mẽ, hệ thống comment, phân loại bài viết, SEO tối ưu và giao diện responsive đẹp mắt.', '', 'free', 0.00, 567, 189, 4.6, 1, " . NV_CURRENTTIME . ", 1, 'admin')";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (catid, title, alias, description, content, demo_link, fee_type, fee_amount, num_view, num_download, avg_rating, status, add_time, userid, username) VALUES(2, 'jQuery Photo Gallery', 'jquery-photo-gallery', 'Plugin jQuery tạo gallery hình ảnh với lightbox và slideshow chuyên nghiệp.', 'Gallery plugin với nhiều hiệu ứng chuyển đổi, lightbox responsive, hỗ trợ touch gesture trên mobile, lazy loading và tối ưu performance.', 'https://demo.example.com/gallery', 'free', 0.00, 789, 234, 4.7, 1, " . NV_CURRENTTIME . ", 1, 'admin')";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (catid, title, alias, description, content, demo_link, fee_type, fee_amount, num_view, num_download, avg_rating, status, add_time, userid, username) VALUES(2, 'React Data Table', 'react-data-table', 'Component React cho bảng dữ liệu với tính năng sort, filter, pagination.', 'Data table component mạnh mẽ với virtual scrolling, export Excel/PDF, inline editing, custom cell renderer và nhiều tính năng khác.', 'https://demo.example.com/datatable', 'paid', 89000.00, 543, 98, 4.8, 1, " . NV_CURRENTTIME . ", 1, 'admin')";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (catid, title, alias, description, content, demo_link, fee_type, fee_amount, num_view, num_download, avg_rating, status, add_time, userid, username) VALUES(3, 'Bootstrap Business Template', 'bootstrap-business-template', 'Template HTML Business responsive với Bootstrap và nhiều component.', 'Template business hoàn chỉnh với 15+ trang mẫu, animation CSS3, contact form, testimonials, portfolio showcase và tối ưu SEO.', 'https://demo.example.com/business', 'paid', 149000.00, 654, 123, 4.9, 1, " . NV_CURRENTTIME . ", 1, 'admin')";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (catid, title, alias, description, content, demo_link, fee_type, fee_amount, num_view, num_download, avg_rating, status, add_time, userid, username) VALUES(5, 'WordPress Corporate Theme', 'wordpress-corporate-theme', 'Theme WordPress cho doanh nghiệp với page builder và SEO tối ưu.', 'Theme doanh nghiệp với Visual Composer, WooCommerce ready, multilingual support, custom post types và optimization cho tốc độ.', 'https://demo.example.com/wp-corporate', 'paid', 299000.00, 432, 78, 4.8, 1, " . NV_CURRENTTIME . ", 1, 'admin')";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (catid, title, alias, description, content, demo_link, fee_type, fee_amount, num_view, num_download, avg_rating, status, add_time, userid, username) VALUES(6, 'React Native Food App', 'react-native-food-app', 'Ứng dụng đặt đồ ăn React Native với tích hợp thanh toán và tracking.', 'Food delivery app với real-time tracking, multiple payment methods, push notifications, rating system và admin dashboard.', '', 'paid', 499000.00, 321, 45, 4.9, 1, " . NV_CURRENTTIME . ", 1, 'admin')";

// Insert sample reviews - Match new structure with username field
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_reviews (source_id, userid, username, title, content, rating, status, add_time) VALUES(1, 1, 'admin', 'Code chất lượng cao', 'Code rất sạch và dễ hiểu. Documentation đầy đủ, cài đặt dễ dàng. Recommend cho ai cần một CMS đơn giản nhưng mạnh mẽ.', 5, 1, " . NV_CURRENTTIME . ")";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_reviews (source_id, userid, username, title, content, rating, status, add_time) VALUES(1, 1, 'admin', 'Tính năng đầy đủ', 'Tính năng đầy đủ, giao diện admin đẹp. Chỉ có điều muốn thêm tính năng multi-site management.', 4, 1, " . NV_CURRENTTIME . ")";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_reviews (source_id, userid, username, title, content, rating, status, add_time) VALUES(2, 1, 'admin', 'Excellent platform!', 'Đã sử dụng cho 3 dự án và rất hài lòng. Performance tốt, bảo mật chắc chắn, tích hợp payment gateway dễ dàng.', 5, 1, " . NV_CURRENTTIME . ")";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_reviews (source_id, userid, username, title, content, rating, status, add_time) VALUES(3, 1, 'admin', 'Blog system tuyệt vời', 'Blog system đơn giản nhưng hiệu quả. Dễ customize và extend thêm tính năng. Editor WYSIWYG rất mượt.', 4, 1, " . NV_CURRENTTIME . ")";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_reviews (source_id, userid, username, title, content, rating, status, add_time) VALUES(4, 1, 'admin', 'jQuery gallery xuất sắc', 'jQuery gallery tuyệt vời, dễ customize. Lightbox smooth và responsive tốt. Performance trên mobile rất ổn.', 5, 1, " . NV_CURRENTTIME . ")";

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_reviews (source_id, userid, username, title, content, rating, status, add_time) VALUES(5, 1, 'admin', 'React component chất lượng', 'React data table component rất mạnh mẽ. Virtual scrolling làm việc tốt với big data. Export feature rất tiện.', 5, 1, " . NV_CURRENTTIME . ")";

// Insert some sample source-tag relationships
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(1, 1)"; // PHP CMS - responsive
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(1, 4)"; // PHP CMS - admin
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(1, 6)"; // PHP CMS - cms
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(1, 7)"; // PHP CMS - php

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(2, 5)"; // E-commerce - ecommerce
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(2, 7)"; // E-commerce - php
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(2, 8)"; // E-commerce - mysql

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(3, 6)"; // Blog - cms
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(3, 7)"; // Blog - php

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(4, 3)"; // jQuery Gallery - jquery
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(4, 1)"; // jQuery Gallery - responsive

$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(6, 2)"; // Bootstrap Template - bootstrap
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES(6, 1)"; // Bootstrap Template - responsive

// Insert sample logs
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_logs (userid, source_id, action, ip, log_time, details) VALUES(1, 1, 'view', '127.0.0.1', " . NV_CURRENTTIME . ", 'Xem chi tiết mã nguồn PHP CMS System')";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_logs (userid, source_id, action, ip, log_time, details) VALUES(1, 1, 'download', '127.0.0.1', " . NV_CURRENTTIME . ", 'Tải xuống mã nguồn PHP CMS System')";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_logs (userid, source_id, action, ip, log_time, details) VALUES(1, 2, 'view', '127.0.0.1', " . NV_CURRENTTIME . ", 'Xem chi tiết E-commerce Platform')";

// Insert sample download logs
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_download_logs (source_id, user_id, ip_address, download_time) VALUES(1, 1, '127.0.0.1', " . NV_CURRENTTIME . ")";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_download_logs (source_id, user_id, ip_address, download_time) VALUES(2, 1, '127.0.0.1', " . NV_CURRENTTIME . ")";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_download_logs (source_id, user_id, ip_address, download_time) VALUES(3, 1, '127.0.0.1', " . NV_CURRENTTIME . ")";

// Insert sample favorites
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_favorites (userid, source_id) VALUES(1, 1)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_favorites (userid, source_id) VALUES(1, 2)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_favorites (userid, source_id) VALUES(1, 4)";

// Insert sample notifications
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_notifications (userid, type, title, content, source_id, url, is_read) VALUES(1, 'new_source', 'Mã nguồn mới được đăng', 'PHP CMS System vừa được đăng tải bởi admin', 1, '/sharecode/detail/php-cms-system/', 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_notifications (userid, type, title, content, source_id, url, is_read) VALUES(1, 'new_review', 'Đánh giá mới', 'Có đánh giá mới cho E-commerce Platform', 2, '/sharecode/detail/ecommerce-platform/', 0)";
$arrSQL[] = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_notifications (userid, type, title, content, source_id, url, is_read) VALUES(1, 'purchase', 'Giao dịch thành công', 'Bạn đã mua thành công E-commerce Platform', 2, '/sharecode/detail/ecommerce-platform/', 1)";

foreach ($arrSQL as $sql) {
    try {
        if (!$db->query($sql)) {
            $install_lang[$lang]['data_insert_error'] = "Lỗi thêm dữ liệu mẫu";
        }
    } catch (PDOException $e) {
        $install_lang[$lang]['data_insert_error'] = "Lỗi thêm dữ liệu mẫu: " . $e->getMessage();
    }
}