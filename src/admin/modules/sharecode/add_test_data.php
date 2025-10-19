<?php

/**
 * Script thêm dữ liệu test cho ShareCode
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    exit('Stop!!!');
}

// Dữ liệu test cho 10 mã nguồn
$test_sources = [
    [
        'title' => 'Website Bán Hàng Online',
        'alias' => 'website-ban-hang-online',
        'description' => 'Website bán hàng online hoàn chỉnh với giỏ hàng, thanh toán, quản lý đơn hàng và nhiều tính năng khác',
        'content' => 'Website bán hàng online được xây dựng bằng PHP/MySQL với đầy đủ tính năng: quản lý sản phẩm, giỏ hàng, thanh toán online, quản lý đơn hàng, báo cáo doanh thu.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/ecommerce-website',
        'demo_link' => 'https://demo.ecommerce-website.com',
        'fee_type' => 'free',
        'status' => 1
    ],
    [
        'title' => 'Hệ Thống Quản Lý Học Sinh',
        'alias' => 'he-thong-quan-ly-hoc-sinh',
        'description' => 'Hệ thống quản lý học sinh, điểm số, lịch học và thông tin giáo viên cho trường học',
        'content' => 'Hệ thống quản lý học sinh toàn diện với các chức năng: quản lý thông tin học sinh, điểm số, lịch học, thông báo, báo cáo học tập.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/student-management',
        'demo_link' => 'https://demo.student-management.com',
        'fee_type' => 'paid',
        'price' => 500000,
        'status' => 1
    ],
    [
        'title' => 'Blog Cá Nhân Responsive',
        'alias' => 'blog-ca-nhan-responsive',
        'description' => 'Template blog cá nhân responsive với thiết kế hiện đại, tối ưu SEO',
        'content' => 'Template blog cá nhân được thiết kế responsive, tương thích mọi thiết bị. Tích hợp SEO, comment system, social sharing.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/personal-blog',
        'demo_link' => 'https://demo.personal-blog.com',
        'fee_type' => 'free',
        'status' => 1
    ],
    [
        'title' => 'Ứng Dụng Chat Realtime',
        'alias' => 'ung-dung-chat-realtime',
        'description' => 'Ứng dụng chat realtime sử dụng WebSocket, hỗ trợ nhóm chat và file sharing',
        'content' => 'Ứng dụng chat realtime với WebSocket, hỗ trợ chat 1-1, nhóm chat, gửi file, emoji, notification push.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/realtime-chat',
        'demo_link' => 'https://demo.realtime-chat.com',
        'fee_type' => 'paid',
        'price' => 300000,
        'status' => 1
    ],
    [
        'title' => 'Hệ Thống Đặt Phòng Khách Sạn',
        'alias' => 'he-thong-dat-phong-khach-san',
        'description' => 'Hệ thống đặt phòng khách sạn online với quản lý phòng, booking và thanh toán',
        'content' => 'Hệ thống đặt phòng khách sạn hoàn chỉnh: tìm kiếm phòng, đặt phòng online, quản lý booking, thanh toán, check-in/out.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/hotel-booking',
        'demo_link' => 'https://demo.hotel-booking.com',
        'fee_type' => 'paid',
        'price' => 800000,
        'status' => 1
    ],
    [
        'title' => 'Game Puzzle HTML5',
        'alias' => 'game-puzzle-html5',
        'description' => 'Game puzzle HTML5 với nhiều level, hỗ trợ mobile và desktop',
        'content' => 'Game puzzle HTML5 với graphics đẹp, nhiều level thử thách, hỗ trợ touch control cho mobile.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/html5-puzzle',
        'demo_link' => 'https://demo.html5-puzzle.com',
        'fee_type' => 'free',
        'status' => 1
    ],
    [
        'title' => 'API REST với Node.js',
        'alias' => 'api-rest-nodejs',
        'description' => 'API REST hoàn chỉnh với Node.js, Express, MongoDB và JWT authentication',
        'content' => 'API REST được xây dựng với Node.js, Express framework, MongoDB database, JWT authentication, validation, error handling.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/nodejs-api',
        'demo_link' => 'https://api.nodejs-demo.com',
        'fee_type' => 'paid',
        'price' => 400000,
        'status' => 1
    ],
    [
        'title' => 'Dashboard Admin Bootstrap',
        'alias' => 'dashboard-admin-bootstrap',
        'description' => 'Template dashboard admin responsive với Bootstrap, charts và tables',
        'content' => 'Template dashboard admin hiện đại với Bootstrap 5, charts đẹp, data tables, form validation, responsive design.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/admin-dashboard',
        'demo_link' => 'https://demo.admin-dashboard.com',
        'fee_type' => 'free',
        'status' => 1
    ],
    [
        'title' => 'Ứng Dụng Todo List Vue.js',
        'alias' => 'ung-dung-todo-list-vuejs',
        'description' => 'Ứng dụng Todo List với Vue.js, Vuex và local storage',
        'content' => 'Ứng dụng Todo List được xây dựng với Vue.js 3, Vuex state management, local storage, drag & drop.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/vuejs-todo',
        'demo_link' => 'https://demo.vuejs-todo.com',
        'fee_type' => 'free',
        'status' => 1
    ],
    [
        'title' => 'Hệ Thống CRM Doanh Nghiệp',
        'alias' => 'he-thong-crm-doanh-nghiep',
        'description' => 'Hệ thống CRM quản lý khách hàng, bán hàng và báo cáo cho doanh nghiệp',
        'content' => 'Hệ thống CRM hoàn chỉnh: quản lý khách hàng, lead, opportunity, pipeline bán hàng, báo cáo chi tiết.',
        'catid' => 1,
        'download_link' => 'https://github.com/example/enterprise-crm',
        'demo_link' => 'https://demo.enterprise-crm.com',
        'fee_type' => 'paid',
        'price' => 1200000,
        'status' => 1
    ]
];

$page_title = 'Thêm dữ liệu test';

$contents = '<h1>🚀 Thêm dữ liệu test cho ShareCode</h1>';

if ($nv_Request->isset_request('add', 'get')) {
    foreach ($test_sources as $index => $source) {
        try {
            $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources 
                    (title, alias, description, content, catid, download_link, demo_link, fee_type, fee_amount, status, add_time, userid, username) 
                    VALUES (
                        " . $db->quote($source['title']) . ",
                        " . $db->quote($source['alias']) . ",
                        " . $db->quote($source['description']) . ",
                        " . $db->quote($source['content']) . ",
                        " . intval($source['catid']) . ",
                        " . $db->quote($source['download_link']) . ",
                        " . $db->quote($source['demo_link']) . ",
                        " . $db->quote($source['fee_type']) . ",
                        " . floatval($source['price'] ?? 0) . ",
                        " . intval($source['status']) . ",
                        " . NV_CURRENTTIME . ",
                        1,
                        'admin'
                    )";
            
            $result = $db->exec($sql);
            
            if ($result) {
                $contents .= "<p style='color: green'>✅ " . ($index + 1) . ". Đã thêm: " . $source['title'] . "</p>";
            } else {
                $contents .= "<p style='color: red'>❌ " . ($index + 1) . ". Lỗi thêm: " . $source['title'] . "</p>";
            }
            
        } catch (Exception $e) {
            $contents .= "<p style='color: red'>❌ " . ($index + 1) . ". Lỗi: " . $e->getMessage() . "</p>";
        }
    }
    
    $contents .= '<h2>🎉 Hoàn thành thêm dữ liệu test!</h2>';
    $contents .= '<p><a href="http://sharecode2.local/sharecode/" target="_blank">🔗 Truy cập ShareCode để xem kết quả</a></p>';
} else {
    $contents .= '<p>Click nút bên dưới để thêm 10 mã nguồn test vào hệ thống:</p>';
    $contents .= '<p><a href="' . NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=add_test_data&add=1" class="btn btn-primary">Thêm dữ liệu test</a></p>';
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
