-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 02, 2025 lúc 03:56 PM
-- Phiên bản máy phục vụ: 11.7.2-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `sharecode`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_categories`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_categories`;
CREATE TABLE `nv5_vi_sharecode_categories` (
  `id` int(11) NOT NULL COMMENT 'ID danh mục',
  `parentid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID danh mục cha',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Tên danh mục',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'Đường dẫn tĩnh',
  `description` text DEFAULT NULL COMMENT 'Mô tả danh mục',
  `image` varchar(255) DEFAULT '' COMMENT 'Hình ảnh đại diện',
  `weight` int(11) DEFAULT 0 COMMENT 'Thứ tự sắp xếp',
  `status` tinyint(4) DEFAULT 1 COMMENT 'Trạng thái (0: tắt, 1: bật)',
  `add_time` int(11) DEFAULT 0 COMMENT 'Thời gian tạo'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng danh mục';

--
-- Đang đổ dữ liệu cho bảng `nv5_vi_sharecode_categories`
--

INSERT INTO `nv5_vi_sharecode_categories` (`id`, `parentid`, `title`, `alias`, `description`, `image`, `weight`, `status`, `add_time`) VALUES
(1, 0, 'PHP Scripts', 'php-scripts', 'Các script và ứng dụng PHP chất lượng cao cho website và ứng dụng web', '', 1, 1, 1754126673),
(2, 0, 'JavaScript', 'javascript', 'Thư viện và script JavaScript hiện đại', '', 2, 1, 1754126673),
(3, 0, 'HTML Templates', 'html-templates', 'Template HTML responsive và hiện đại', '', 3, 1, 1754126673),
(4, 0, 'CSS Frameworks', 'css-frameworks', 'Framework và thư viện CSS', '', 4, 1, 1754126673),
(5, 0, 'WordPress', 'wordpress', 'Theme và plugin WordPress', '', 5, 1, 1754126673),
(6, 0, 'Mobile Apps', 'mobile-apps', 'Ứng dụng di động cho Android và iOS', '', 6, 1, 1754126673);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_download_logs`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_download_logs`;
CREATE TABLE `nv5_vi_sharecode_download_logs` (
  `id` int(11) NOT NULL COMMENT 'ID log tải xuống',
  `source_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
  `user_id` int(11) DEFAULT 0 COMMENT 'ID người tải (0 nếu guest)',
  `ip_address` varchar(45) DEFAULT '' COMMENT 'Địa chỉ IP',
  `download_time` int(11) DEFAULT 0 COMMENT 'Thời gian tải xuống',
  `user_agent` text DEFAULT NULL COMMENT 'User Agent của trình duyệt'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng log tải xuống';

--
-- Đang đổ dữ liệu cho bảng `nv5_vi_sharecode_download_logs`
--

INSERT INTO `nv5_vi_sharecode_download_logs` (`id`, `source_id`, `user_id`, `ip_address`, `download_time`, `user_agent`) VALUES
(1, 1, 1, '127.0.0.1', 1754126673, NULL),
(2, 2, 1, '127.0.0.1', 1754126673, NULL),
(3, 3, 1, '127.0.0.1', 1754126673, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_favorites`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_favorites`;
CREATE TABLE `nv5_vi_sharecode_favorites` (
  `id` int(11) NOT NULL COMMENT 'ID yêu thích',
  `userid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID người dùng',
  `source_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng mã nguồn yêu thích';

--
-- Đang đổ dữ liệu cho bảng `nv5_vi_sharecode_favorites`
--

INSERT INTO `nv5_vi_sharecode_favorites` (`id`, `userid`, `source_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_logs`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_logs`;
CREATE TABLE `nv5_vi_sharecode_logs` (
  `id` int(11) NOT NULL COMMENT 'ID log',
  `userid` int(11) DEFAULT 0 COMMENT 'ID người dùng',
  `source_id` int(11) DEFAULT 0 COMMENT 'ID mã nguồn liên quan',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT 'Hành động (view/download/upload/etc)',
  `ip` varchar(45) DEFAULT '' COMMENT 'Địa chỉ IP',
  `user_agent` text DEFAULT NULL COMMENT 'User Agent của trình duyệt',
  `log_time` int(11) DEFAULT 0 COMMENT 'Thời gian ghi log',
  `details` longtext DEFAULT NULL COMMENT 'Chi tiết bổ sung'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng ghi log hệ thống';

--
-- Đang đổ dữ liệu cho bảng `nv5_vi_sharecode_logs`
--

INSERT INTO `nv5_vi_sharecode_logs` (`id`, `userid`, `source_id`, `action`, `ip`, `user_agent`, `log_time`, `details`) VALUES
(1, 1, 1, 'view', '127.0.0.1', NULL, 1754126673, 'Xem chi tiết mã nguồn PHP CMS System'),
(2, 1, 1, 'download', '127.0.0.1', NULL, 1754126673, 'Tải xuống mã nguồn PHP CMS System'),
(3, 1, 2, 'view', '127.0.0.1', NULL, 1754126673, 'Xem chi tiết E-commerce Platform');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_notifications`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_notifications`;
CREATE TABLE `nv5_vi_sharecode_notifications` (
  `id` int(11) NOT NULL COMMENT 'ID thông báo',
  `userid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID người nhận',
  `type` varchar(50) NOT NULL DEFAULT '' COMMENT 'Loại thông báo (new_source/review/etc)',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Tiêu đề thông báo',
  `content` text DEFAULT NULL COMMENT 'Nội dung thông báo',
  `source_id` int(11) DEFAULT 0 COMMENT 'ID mã nguồn liên quan',
  `url` varchar(255) DEFAULT '' COMMENT 'URL liên kết',
  `is_read` tinyint(4) DEFAULT 0 COMMENT 'Đã đọc (0: chưa, 1: rồi)'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng thông báo';

--
-- Đang đổ dữ liệu cho bảng `nv5_vi_sharecode_notifications`
--

INSERT INTO `nv5_vi_sharecode_notifications` (`id`, `userid`, `type`, `title`, `content`, `source_id`, `url`, `is_read`) VALUES
(1, 1, 'new_source', 'Mã nguồn mới được đăng', 'PHP CMS System vừa được đăng tải bởi admin', 1, '/sharecode/detail/php-cms-system/', 0),
(2, 1, 'new_review', 'Đánh giá mới', 'Có đánh giá mới cho E-commerce Platform', 2, '/sharecode/detail/ecommerce-platform/', 0),
(3, 1, 'purchase', 'Giao dịch thành công', 'Bạn đã mua thành công E-commerce Platform', 2, '/sharecode/detail/ecommerce-platform/', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_purchases`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_purchases`;
CREATE TABLE `nv5_vi_sharecode_purchases` (
  `id` varchar(32) NOT NULL COMMENT 'ID giao dịch mua',
  `userid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID người mua',
  `source_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
  `amount` decimal(15,2) NOT NULL DEFAULT 0.00 COMMENT 'Số tiền',
  `currency` varchar(3) DEFAULT 'VND' COMMENT 'Loại tiền tệ',
  `payment_method` varchar(50) DEFAULT '' COMMENT 'Phương thức thanh toán',
  `transaction_id` varchar(100) DEFAULT '' COMMENT 'Mã giao dịch từ gateway',
  `status` varchar(20) DEFAULT 'pending' COMMENT 'Trạng thái (pending/completed/failed/cancelled)',
  `purchase_time` int(11) DEFAULT 0 COMMENT 'Thời gian đặt mua',
  `payment_time` int(11) DEFAULT 0 COMMENT 'Thời gian thanh toán',
  `notes` text DEFAULT NULL COMMENT 'Ghi chú'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng giao dịch mua';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_reviews`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_reviews`;
CREATE TABLE `nv5_vi_sharecode_reviews` (
  `id` int(11) NOT NULL COMMENT 'ID đánh giá',
  `source_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
  `userid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID người đánh giá',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên người đánh giá',
  `title` varchar(255) DEFAULT '' COMMENT 'Tiêu đề đánh giá',
  `content` text DEFAULT NULL COMMENT 'Nội dung đánh giá',
  `rating` tinyint(4) DEFAULT 5 COMMENT 'Số sao đánh giá (1-5)',
  `status` tinyint(4) DEFAULT 0 COMMENT 'Trạng thái (0: chờ duyệt, 1: đã duyệt, 2: từ chối)',
  `add_time` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng đánh giá';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_sources`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_sources`;
CREATE TABLE `nv5_vi_sharecode_sources` (
  `id` int(11) NOT NULL COMMENT 'ID mã nguồn',
  `catid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID danh mục',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Tiêu đề mã nguồn',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'Đường dẫn tĩnh',
  `description` text DEFAULT NULL COMMENT 'Mô tả ngắn',
  `content` longtext DEFAULT NULL COMMENT 'Nội dung chi tiết',
  `image` varchar(255) DEFAULT '' COMMENT 'Hình ảnh đại diện',
  `file_path` varchar(255) DEFAULT '' COMMENT 'Đường dẫn file',
  `file_name` varchar(255) DEFAULT '' COMMENT 'Tên file gốc',
  `file_size` int(11) DEFAULT 0 COMMENT 'Kích thước file (bytes)',
  `download_link` varchar(255) DEFAULT '' COMMENT 'Link tải xuống',
  `download_link_type` enum('internal','external') DEFAULT 'internal' COMMENT 'Loại link (nội bộ/bên ngoài)',
  `demo_link` varchar(255) DEFAULT '' COMMENT 'Link demo',
  `keywords` varchar(255) DEFAULT '' COMMENT 'Từ khóa tìm kiếm',
  `fee_type` enum('free','paid','contact') DEFAULT 'free' COMMENT 'Loại phí (free/paid/contact)',
  `fee_amount` decimal(15,2) DEFAULT 0.00 COMMENT 'Số tiền',
  `contact_phone` varchar(20) DEFAULT '' COMMENT 'Số điện thoại liên hệ',
  `contact_email` varchar(100) DEFAULT '' COMMENT 'Email liên hệ',
  `contact_skype` varchar(100) DEFAULT '' COMMENT 'Skype liên hệ',
  `contact_telegram` varchar(100) DEFAULT '' COMMENT 'Telegram liên hệ',
  `contact_zalo` varchar(20) DEFAULT '' COMMENT 'Zalo liên hệ',
  `contact_facebook` varchar(255) DEFAULT '' COMMENT 'Facebook liên hệ',
  `contact_website` varchar(255) DEFAULT '' COMMENT 'Website liên hệ',
  `contact_address` text DEFAULT NULL COMMENT 'Địa chỉ liên hệ',
  `num_view` int(11) DEFAULT 0 COMMENT 'Số lượt xem',
  `num_download` int(11) DEFAULT 0 COMMENT 'Số lượt tải',
  `avg_rating` decimal(3,2) DEFAULT 0.00 COMMENT 'Điểm đánh giá trung bình',
  `status` tinyint(4) DEFAULT 1 COMMENT 'Trạng thái (0: tắt, 1: bật, 2: chờ duyệt)',
  `userid` int(11) DEFAULT 0 COMMENT 'ID người đăng',
  `username` varchar(100) DEFAULT '' COMMENT 'Tên người đăng',
  `add_time` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng mã nguồn';

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_source_tags`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_source_tags`;
CREATE TABLE `nv5_vi_sharecode_source_tags` (
  `source_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
  `tag_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID thẻ tag'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng liên kết mã nguồn và thẻ tag';

--
-- Đang đổ dữ liệu cho bảng `nv5_vi_sharecode_source_tags`
--

INSERT INTO `nv5_vi_sharecode_source_tags` (`source_id`, `tag_id`) VALUES
(1, 1),
(1, 4),
(1, 6),
(1, 7),
(2, 5),
(2, 7),
(2, 8),
(3, 6),
(3, 7),
(4, 1),
(4, 3),
(6, 1),
(6, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_vi_sharecode_tags`
--

DROP TABLE IF EXISTS `nv5_vi_sharecode_tags`;
CREATE TABLE `nv5_vi_sharecode_tags` (
  `id` int(11) NOT NULL COMMENT 'ID thẻ tag',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên thẻ tag',
  `alias` varchar(100) NOT NULL DEFAULT '' COMMENT 'Đường dẫn tĩnh',
  `description` text DEFAULT NULL COMMENT 'Mô tả thẻ tag',
  `weight` int(11) DEFAULT 0 COMMENT 'Thứ tự sắp xếp',
  `status` tinyint(4) DEFAULT 1 COMMENT 'Trạng thái (0: tắt, 1: bật)',
  `total_sources` int(11) DEFAULT 0 COMMENT 'Tổng số mã nguồn có tag này'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng thẻ tag';

--
-- Đang đổ dữ liệu cho bảng `nv5_vi_sharecode_tags`
--

INSERT INTO `nv5_vi_sharecode_tags` (`id`, `name`, `alias`, `description`, `weight`, `status`, `total_sources`) VALUES
(1, 'responsive', 'responsive', 'Hỗ trợ responsive design', 1, 1, 3),
(2, 'bootstrap', 'bootstrap', 'Sử dụng Bootstrap framework', 2, 1, 1),
(3, 'jquery', 'jquery', 'Sử dụng jQuery library', 3, 1, 1),
(4, 'admin', 'admin', 'Giao diện quản trị', 4, 1, 1),
(5, 'ecommerce', 'ecommerce', 'Thương mại điện tử', 5, 1, 1),
(6, 'cms', 'cms', 'Hệ thống quản lý nội dung', 6, 1, 2),
(7, 'php', 'php', 'Ngôn ngữ lập trình PHP', 7, 1, 3),
(8, 'mysql', 'mysql', 'Hệ quản trị cơ sở dữ liệu MySQL', 8, 1, 1),
(9, 'laravel', 'laravel', 'Framework Laravel PHP', 9, 1, 0),
(10, 'vue', 'vue', 'Vue.js framework', 10, 1, 0),
(11, 'react', 'react', 'React library', 11, 1, 0),
(12, 'nodejs', 'nodejs', 'Node.js runtime', 12, 1, 0);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_categories`
--
ALTER TABLE `nv5_vi_sharecode_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_alias` (`alias`(250)),
  ADD KEY `idx_parentid` (`parentid`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_weight` (`weight`),
  ADD KEY `idx_status_weight` (`status`,`weight`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_download_logs`
--
ALTER TABLE `nv5_vi_sharecode_download_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_source_id` (`source_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_download_time` (`download_time`),
  ADD KEY `idx_source_id_download_time` (`source_id`,`download_time`),
  ADD KEY `idx_user_id_download_time` (`user_id`,`download_time`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_favorites`
--
ALTER TABLE `nv5_vi_sharecode_favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_favorite` (`userid`,`source_id`),
  ADD KEY `idx_userid` (`userid`),
  ADD KEY `idx_source_id` (`source_id`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_logs`
--
ALTER TABLE `nv5_vi_sharecode_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_userid` (`userid`),
  ADD KEY `idx_source_id` (`source_id`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_log_time` (`log_time`),
  ADD KEY `idx_action_log_time` (`action`,`log_time`),
  ADD KEY `idx_userid_action` (`userid`,`action`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_notifications`
--
ALTER TABLE `nv5_vi_sharecode_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_userid` (`userid`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_userid_is_read` (`userid`,`is_read`),
  ADD KEY `idx_userid_type` (`userid`,`type`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_purchases`
--
ALTER TABLE `nv5_vi_sharecode_purchases`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_userid` (`userid`),
  ADD KEY `idx_source_id` (`source_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_purchase_time` (`purchase_time`),
  ADD KEY `idx_payment_time` (`payment_time`),
  ADD KEY `idx_userid_status` (`userid`,`status`),
  ADD KEY `idx_source_id_status` (`source_id`,`status`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_reviews`
--
ALTER TABLE `nv5_vi_sharecode_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_source_id` (`source_id`),
  ADD KEY `idx_userid` (`userid`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_rating` (`rating`),
  ADD KEY `idx_source_id_status` (`source_id`,`status`),
  ADD KEY `idx_source_id_rating` (`source_id`,`rating`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_sources`
--
ALTER TABLE `nv5_vi_sharecode_sources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_alias` (`alias`(250)),
  ADD KEY `idx_catid` (`catid`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_fee_type` (`fee_type`),
  ADD KEY `idx_userid` (`userid`),
  ADD KEY `idx_catid_status` (`catid`,`status`),
  ADD KEY `idx_fee_type_status` (`fee_type`,`status`),
  ADD KEY `idx_num_view` (`num_view`),
  ADD KEY `idx_num_download` (`num_download`),
  ADD KEY `idx_avg_rating` (`avg_rating`),
  ADD KEY `add_time` (`add_time`);
ALTER TABLE `nv5_vi_sharecode_sources` ADD FULLTEXT KEY `idx_title_keywords` (`title`,`keywords`,`description`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_source_tags`
--
ALTER TABLE `nv5_vi_sharecode_source_tags`
  ADD PRIMARY KEY (`source_id`,`tag_id`),
  ADD KEY `idx_tag_id` (`tag_id`);

--
-- Chỉ mục cho bảng `nv5_vi_sharecode_tags`
--
ALTER TABLE `nv5_vi_sharecode_tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_name` (`name`),
  ADD KEY `idx_alias` (`alias`),
  ADD KEY `idx_weight` (`weight`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_total_sources` (`total_sources`),
  ADD KEY `idx_status_weight` (`status`,`weight`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `nv5_vi_sharecode_categories`
--
ALTER TABLE `nv5_vi_sharecode_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID danh mục', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `nv5_vi_sharecode_download_logs`
--
ALTER TABLE `nv5_vi_sharecode_download_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID log tải xuống', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `nv5_vi_sharecode_favorites`
--
ALTER TABLE `nv5_vi_sharecode_favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID yêu thích', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `nv5_vi_sharecode_logs`
--
ALTER TABLE `nv5_vi_sharecode_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID log', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `nv5_vi_sharecode_notifications`
--
ALTER TABLE `nv5_vi_sharecode_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID thông báo', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `nv5_vi_sharecode_reviews`
--
ALTER TABLE `nv5_vi_sharecode_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID đánh giá';

--
-- AUTO_INCREMENT cho bảng `nv5_vi_sharecode_sources`
--
ALTER TABLE `nv5_vi_sharecode_sources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID mã nguồn';

--
-- AUTO_INCREMENT cho bảng `nv5_vi_sharecode_tags`
--
ALTER TABLE `nv5_vi_sharecode_tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID thẻ tag', AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
