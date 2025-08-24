-- Tạo bảng keywords cho module ShareCode
CREATE TABLE IF NOT EXISTS `nv4_vi_sharecode_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'Tên từ khóa',
  `alias` varchar(255) NOT NULL COMMENT 'Alias URL thân thiện',
  `description` text COMMENT 'Mô tả từ khóa',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Thứ tự sắp xếp',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Trạng thái (1: hoạt động, 0: tạm khóa)',
  `add_time` int(11) NOT NULL DEFAULT '0' COMMENT 'Thời gian tạo',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `alias` (`alias`),
  KEY `status` (`status`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bảng quản lý từ khóa';

-- Thêm một số từ khóa mẫu
INSERT INTO `nv4_vi_sharecode_keywords` (`name`, `alias`, `description`, `weight`, `status`, `add_time`) VALUES
('PHP', 'php', 'Ngôn ngữ lập trình PHP', 1, 1, UNIX_TIMESTAMP()),
('JavaScript', 'javascript', 'Ngôn ngữ lập trình JavaScript', 2, 1, UNIX_TIMESTAMP()),
('HTML', 'html', 'Ngôn ngữ đánh dấu HTML', 3, 1, UNIX_TIMESTAMP()),
('CSS', 'css', 'Cascading Style Sheets', 4, 1, UNIX_TIMESTAMP()),
('Bootstrap', 'bootstrap', 'Framework CSS Bootstrap', 5, 1, UNIX_TIMESTAMP()),
('jQuery', 'jquery', 'Thư viện JavaScript jQuery', 6, 1, UNIX_TIMESTAMP()),
('Vue.js', 'vuejs', 'Framework JavaScript Vue.js', 7, 1, UNIX_TIMESTAMP()),
('React', 'react', 'Thư viện JavaScript React', 8, 1, UNIX_TIMESTAMP()),
('Laravel', 'laravel', 'Framework PHP Laravel', 9, 1, UNIX_TIMESTAMP()),
('MySQL', 'mysql', 'Hệ quản trị cơ sở dữ liệu MySQL', 10, 1, UNIX_TIMESTAMP()),
('Responsive', 'responsive', 'Thiết kế đáp ứng', 11, 1, UNIX_TIMESTAMP()),
('Admin Panel', 'admin-panel', 'Bảng điều khiển quản trị', 12, 1, UNIX_TIMESTAMP()),
('E-commerce', 'ecommerce', 'Thương mại điện tử', 13, 1, UNIX_TIMESTAMP()),
('CMS', 'cms', 'Hệ thống quản lý nội dung', 14, 1, UNIX_TIMESTAMP()),
('API', 'api', 'Giao diện lập trình ứng dụng', 15, 1, UNIX_TIMESTAMP());
