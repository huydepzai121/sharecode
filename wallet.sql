-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th7 18, 2025 lúc 10:32 AM
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
-- Cơ sở dữ liệu: `smtraffic2024`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_admins`
--

DROP TABLE IF EXISTS `nv4_wallet_admins`;
CREATE TABLE `nv4_wallet_admins` (
  `admin_id` mediumint(8) NOT NULL,
  `gid` smallint(4) NOT NULL,
  `add_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv4_wallet_admins`
--

INSERT INTO `nv4_wallet_admins` (`admin_id`, `gid`, `add_time`, `update_time`) VALUES
(30, 0, 1745111196, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_admin_groups`
--

DROP TABLE IF EXISTS `nv4_wallet_admin_groups`;
CREATE TABLE `nv4_wallet_admin_groups` (
  `gid` smallint(4) NOT NULL,
  `group_title` varchar(100) NOT NULL DEFAULT '' COMMENT 'Tên nhóm',
  `add_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `is_wallet` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền xem và cập nhật ví tiền',
  `is_vtransaction` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền xem giao dịch',
  `is_mtransaction` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền xem và xử lý giao dịch',
  `is_vorder` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền xem các đơn hàng kết nối',
  `is_morder` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền xem và xử lý các đơn hàng kết nối',
  `is_exchange` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền quản lý tỷ giá',
  `is_money` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền quản lý tiền tệ',
  `is_payport` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền quản lý các cổng thanh toán',
  `is_configmod` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền thiết lập cấu hình module',
  `is_viewstats` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Quyền xem thống kê'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_bank_info`
--

DROP TABLE IF EXISTS `nv4_wallet_bank_info`;
CREATE TABLE `nv4_wallet_bank_info` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `account_holder` varchar(255) NOT NULL,
  `account_number` varchar(30) NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `description_content` mediumtext NOT NULL,
  `note` mediumtext NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Hiển thị ngoài site:\r\n1 có hiển thị\r\n0 không hiển thị',
  `url_config` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv4_wallet_bank_info`
--

INSERT INTO `nv4_wallet_bank_info` (`id`, `title`, `account_holder`, `account_number`, `bank_name`, `description_content`, `note`, `status`, `url_config`) VALUES
(1, 'VIETCOMBANK', 'NGUYEN VAN LAM', '0301000384792', '/uploads/wallet/vcb.png', '', '', 1, 'smtraffic.com'),
(2, 'MOMO', 'Nguyễn Văn Lâm', '0363149147', '/uploads/wallet/momo_logo.png', '', '', 1, 'smtraffic.com');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_epay_log`
--

DROP TABLE IF EXISTS `nv4_wallet_epay_log`;
CREATE TABLE `nv4_wallet_epay_log` (
  `id` int(11) NOT NULL,
  `time` int(11) NOT NULL DEFAULT 0,
  `telco` char(3) NOT NULL DEFAULT '',
  `code` varchar(30) NOT NULL DEFAULT '',
  `userid` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `SessionID` varchar(255) NOT NULL DEFAULT '',
  `money_card` int(11) NOT NULL DEFAULT 0,
  `money_site` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_exchange`
--

DROP TABLE IF EXISTS `nv4_wallet_exchange`;
CREATE TABLE `nv4_wallet_exchange` (
  `id` int(10) UNSIGNED NOT NULL,
  `money_unit` char(3) NOT NULL DEFAULT '',
  `than_unit` char(3) NOT NULL DEFAULT '',
  `exchange_from` double NOT NULL DEFAULT 1,
  `exchange_to` double NOT NULL DEFAULT 1,
  `time_update` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv4_wallet_exchange`
--

INSERT INTO `nv4_wallet_exchange` (`id`, `money_unit`, `than_unit`, `exchange_from`, `exchange_to`, `time_update`, `status`) VALUES
(1, 'USD', 'VND', 1, 22675, 1312000118, 1),
(2, 'VND', 'USD', 22675, 1, 1439725873, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_exchange_log`
--

DROP TABLE IF EXISTS `nv4_wallet_exchange_log`;
CREATE TABLE `nv4_wallet_exchange_log` (
  `log_id` int(11) NOT NULL,
  `money_unit` char(3) NOT NULL DEFAULT '',
  `than_unit` char(3) NOT NULL DEFAULT '',
  `exchange_from` double NOT NULL DEFAULT 1,
  `exchange_to` double NOT NULL DEFAULT 1,
  `time_begin` int(11) NOT NULL DEFAULT 0,
  `time_end` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_ipn_logs`
--

DROP TABLE IF EXISTS `nv4_wallet_ipn_logs`;
CREATE TABLE `nv4_wallet_ipn_logs` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID thành viên nếu có',
  `log_ip` varchar(64) NOT NULL DEFAULT '' COMMENT 'Địa chỉ IP',
  `log_data` mediumtext DEFAULT NULL COMMENT 'Dữ liệu dạng json_encode',
  `request_method` varchar(20) NOT NULL DEFAULT '' COMMENT 'Loại truy vấn',
  `request_time` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Thời gian log',
  `user_agent` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_money`
--

DROP TABLE IF EXISTS `nv4_wallet_money`;
CREATE TABLE `nv4_wallet_money` (
  `userid` int(11) NOT NULL DEFAULT 0,
  `created_time` int(11) NOT NULL DEFAULT 0,
  `created_userid` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `money_unit` char(3) NOT NULL DEFAULT '',
  `money_in` double NOT NULL DEFAULT 0,
  `money_out` double NOT NULL DEFAULT 0,
  `money_total` double NOT NULL DEFAULT 0,
  `note` text NOT NULL,
  `tokenkey` varchar(32) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv4_wallet_money`
--

INSERT INTO `nv4_wallet_money` (`userid`, `created_time`, `created_userid`, `status`, `money_unit`, `money_in`, `money_out`, `money_total`, `note`, `tokenkey`) VALUES
(1, 1684770292, 0, 1, 'VND', 1020000, 844660, 175340, '', ''),
(27, 1711934954, 0, 1, 'VND', 0, 0, 0, '', ''),
(28, 1712831564, 0, 1, 'VND', 5629200, 5387319, 241881, '', ''),
(29, 1712842120, 0, 1, 'VND', 10000, 2050, 7950, '', ''),
(30, 1713263774, 0, 1, 'VND', 0, 0, 0, '', ''),
(31, 1713540353, 0, 1, 'VND', 0, 0, 0, '', ''),
(32, 1713859085, 0, 1, 'VND', 200500, 195950, 4550, '', ''),
(33, 1713861441, 0, 1, 'VND', 0, 0, 0, '', ''),
(34, 1714098696, 0, 1, 'VND', 0, 0, 0, '', ''),
(36, 1714200186, 0, 1, 'VND', 0, 0, 0, '', ''),
(37, 1714878376, 0, 1, 'VND', 0, 0, 0, '', ''),
(38, 1715145948, 0, 1, 'VND', 250000, 240100, 9900, '', ''),
(39, 1715157694, 0, 1, 'VND', 98046.1, 74350, 23696.1, '', ''),
(40, 1715230090, 0, 1, 'VND', 0, 0, 0, '', ''),
(41, 1715530738, 0, 1, 'VND', 100600, 99840, 760, '', ''),
(42, 1715570173, 0, 1, 'VND', 0, 0, 0, '', ''),
(43, 1715862078, 0, 1, 'VND', 0, 0, 0, '', ''),
(44, 1715964606, 0, 1, 'VND', 0, 0, 0, '', ''),
(45, 1716178078, 0, 1, 'VND', 0, 0, 0, '', ''),
(46, 1716307727, 0, 1, 'VND', 32000, 28600, 3400, '', ''),
(47, 1716342046, 0, 1, 'VND', 1560, 0, 1560, '', ''),
(48, 1716462465, 0, 1, 'VND', 10000, 8500, 1500, '', ''),
(49, 1716466734, 0, 1, 'VND', 0, 0, 0, '', ''),
(50, 1716520438, 0, 1, 'VND', 0, 0, 0, '', ''),
(51, 1716606067, 0, 1, 'VND', 100000, 98720, 1280, '', ''),
(52, 1716716544, 0, 1, 'VND', 0, 0, 0, '', ''),
(53, 1716876202, 0, 1, 'VND', 25000, 23400, 1600, '', ''),
(54, 1716889753, 0, 1, 'VND', 10000, 9984, 16, '', ''),
(55, 1717390322, 0, 1, 'VND', 0, 0, 0, '', ''),
(56, 1717477500, 0, 1, 'VND', 696000, 695935, 65, '', ''),
(57, 1717933583, 0, 1, 'VND', 0, 0, 0, '', ''),
(58, 1717933892, 0, 1, 'VND', 0, 0, 0, '', ''),
(59, 1718162901, 0, 1, 'VND', 0, 0, 0, '', ''),
(60, 1718200800, 0, 1, 'VND', 0, 0, 0, '', ''),
(61, 1718446685, 0, 1, 'VND', 0, 0, 0, '', ''),
(62, 1719249565, 0, 1, 'VND', 95000, 94550, 450, '', ''),
(63, 1719693634, 0, 1, 'VND', 60000, 56300, 3700, '', ''),
(64, 1719884143, 0, 1, 'VND', 0, 0, 0, '', ''),
(65, 1719892177, 0, 1, 'VND', 50000, 49784, 216, '', ''),
(66, 1720784899, 0, 1, 'VND', 0, 0, 0, '', ''),
(67, 1721450647, 0, 1, 'VND', 0, 0, 0, '', ''),
(68, 1721492758, 0, 1, 'VND', 0, 0, 0, '', ''),
(69, 1721546660, 0, 1, 'VND', 70000, 14000, 56000, '', ''),
(70, 1721600845, 0, 1, 'VND', 0, 0, 0, '', ''),
(71, 1721747170, 0, 1, 'VND', 158950, 158538, 412, '', ''),
(72, 1721792725, 0, 1, 'VND', 100000, 55500, 44500, '', ''),
(73, 1721912553, 0, 1, 'VND', 600000, 240000, 360000, '', ''),
(74, 1722041577, 0, 1, 'VND', 0, 0, 0, '', ''),
(76, 1722340258, 0, 1, 'VND', 0, 0, 0, '', ''),
(77, 1722340737, 0, 1, 'VND', 255000, 254987, 13, '', ''),
(78, 1722833921, 0, 1, 'VND', 0, 0, 0, '', ''),
(79, 1722992183, 0, 1, 'VND', 150000, 144650, 5350, '', ''),
(80, 1723061097, 0, 1, 'VND', 50000, 44000, 6000, '', ''),
(81, 1723902222, 0, 1, 'VND', 0, 0, 0, '', ''),
(82, 1724810464, 0, 1, 'VND', 703200, 591260, 111940, '', ''),
(83, 1726049519, 0, 1, 'VND', 0, 0, 0, '', ''),
(84, 1726104267, 0, 1, 'VND', 50000, 49920, 80, '', ''),
(85, 1726110925, 0, 1, 'VND', 0, 0, 0, '', ''),
(86, 1726669582, 0, 1, 'VND', 101000, 100500, 500, '', ''),
(88, 1726965566, 0, 1, 'VND', 50000, 9600, 40400, '', ''),
(89, 1727938987, 0, 1, 'VND', 55000, 54850, 150, '', ''),
(90, 1728015317, 0, 1, 'VND', 0, 0, 0, '', ''),
(91, 1728112016, 0, 1, 'VND', 300000, 261250, 38750, '', ''),
(92, 1728125364, 0, 1, 'VND', 0, 0, 0, '', ''),
(93, 1728540611, 0, 1, 'VND', 104500, 104275, 225, '', ''),
(94, 1728566021, 0, 1, 'VND', 50000, 49674, 326, '', ''),
(95, 1730111766, 0, 1, 'VND', 80000, 17985, 62015, '', ''),
(96, 1731044264, 0, 1, 'VND', 50000, 44000, 6000, '', ''),
(97, 1731374772, 0, 1, 'VND', 200000, 140000, 60000, '', ''),
(98, 1731459833, 0, 1, 'VND', 50000, 49800, 200, '', ''),
(99, 1731465563, 0, 1, 'VND', 48800, 46900, 1900, '', ''),
(100, 1731919845, 0, 1, 'VND', 0, 0, 0, '', ''),
(101, 1732545185, 0, 1, 'VND', 0, 0, 0, '', ''),
(102, 1733093692, 0, 1, 'VND', 0, 0, 0, '', ''),
(103, 1734718956, 0, 1, 'VND', 0, 0, 0, '', ''),
(104, 1734985523, 0, 1, 'VND', 0, 0, 0, '', ''),
(106, 1735195252, 0, 1, 'VND', 0, 0, 0, '', ''),
(107, 1735494802, 0, 1, 'VND', 0, 0, 0, '', ''),
(108, 1735501590, 0, 1, 'VND', 150000, 147000, 3000, '', ''),
(109, 1735551076, 0, 1, 'VND', 0, 0, 0, '', ''),
(110, 1735571127, 0, 1, 'VND', 113000, 112840, 160, '', ''),
(111, 1736711288, 0, 1, 'VND', 55000, 55000, 0, '', ''),
(112, 1737691634, 0, 1, 'VND', 0, 0, 0, '', ''),
(113, 1739026437, 0, 1, 'VND', 50000, 44000, 6000, '', ''),
(114, 1739094455, 0, 1, 'VND', 150000, 149968, 32, '', ''),
(115, 1740060139, 0, 1, 'VND', 50000, 10700, 39300, '', ''),
(116, 1740061480, 0, 1, 'VND', 0, 0, 0, '', ''),
(117, 1740413365, 0, 1, 'VND', 0, 0, 0, '', ''),
(118, 1740535356, 0, 1, 'VND', 50000, 44000, 6000, '', ''),
(120, 1740627185, 0, 1, 'VND', 0, 0, 0, '', ''),
(121, 1740929758, 0, 1, 'VND', 0, 0, 0, '', ''),
(122, 1741326941, 0, 1, 'VND', 0, 0, 0, '', ''),
(123, 1741794123, 0, 1, 'VND', 0, 0, 0, '', ''),
(124, 1742456937, 0, 1, 'VND', 0, 0, 0, '', ''),
(125, 1742531628, 0, 1, 'VND', 50000, 44000, 6000, '', ''),
(126, 1742896224, 0, 1, 'VND', 95000, 94550, 450, '', ''),
(127, 1743428968, 0, 1, 'VND', 0, 0, 0, '', ''),
(128, 1743735768, 0, 1, 'VND', 0, 0, 0, '', ''),
(129, 1744805023, 0, 1, 'VND', 0, 0, 0, '', ''),
(131, 1745730882, 0, 1, 'VND', 0, 0, 0, '', ''),
(132, 1745772202, 0, 1, 'VND', 0, 0, 0, '', ''),
(133, 1746601855, 0, 1, 'VND', 50000, 34100, 15900, '', ''),
(134, 1747224453, 0, 1, 'VND', 78000, 78000, 0, '', ''),
(135, 1747482244, 0, 1, 'VND', 0, 0, 0, '', ''),
(136, 1747577197, 0, 1, 'VND', 50000, 15800, 34200, '', ''),
(137, 1748409956, 0, 1, 'VND', 220000, 219958, 42, '', ''),
(138, 1748500443, 0, 1, 'VND', 80000, 79600, 400, '', ''),
(140, 1749329005, 0, 1, 'VND', 150000, 54900, 95100, '', ''),
(141, 1749361973, 0, 1, 'VND', 0, 0, 0, '', ''),
(142, 1750022362, 0, 1, 'VND', 50000, 44500, 5500, '', ''),
(144, 1750639455, 0, 1, 'VND', 150000, 49560, 100440, '', '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_money_sys`
--

DROP TABLE IF EXISTS `nv4_wallet_money_sys`;
CREATE TABLE `nv4_wallet_money_sys` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` char(3) NOT NULL DEFAULT '',
  `currency` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv4_wallet_money_sys`
--

INSERT INTO `nv4_wallet_money_sys` (`id`, `code`, `currency`) VALUES
(704, 'VND', 'Vietnam Dong'),
(840, 'USD', 'US Dollar');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_orders`
--

DROP TABLE IF EXISTS `nv4_wallet_orders`;
CREATE TABLE `nv4_wallet_orders` (
  `id` int(11) NOT NULL,
  `order_mod` varchar(100) NOT NULL DEFAULT '' COMMENT 'Module title của module thực hiện đơn hàng',
  `order_id` varchar(100) NOT NULL DEFAULT '' COMMENT 'ID đơn hàng',
  `order_message` text NOT NULL COMMENT 'Message gửi cho cổng thanh toán',
  `order_object` varchar(250) NOT NULL DEFAULT '' COMMENT 'Đối tượng thanh toán ví dụ: Giỏ hàng, sản phẩn, ứng dụng...',
  `order_name` varchar(250) NOT NULL DEFAULT '' COMMENT 'Tên đối tượng',
  `money_amount` double NOT NULL DEFAULT 0 COMMENT 'Số tiền thanh toán',
  `money_unit` varchar(3) NOT NULL DEFAULT '' COMMENT 'Loại tiền tệ',
  `secret_code` varchar(50) NOT NULL DEFAULT '' COMMENT 'Mã bí mật của mỗi đơn hàng, không trùng lặp',
  `url_back` text NOT NULL COMMENT 'Dữ liệu trả về khi thanh toán xong',
  `url_admin` text NOT NULL COMMENT 'Url trang quản trị đơn hàng',
  `add_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0,
  `paid_status` varchar(100) NOT NULL DEFAULT '' COMMENT 'Trạng thái giao dịch',
  `paid_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'ID giao dịch',
  `paid_time` int(11) NOT NULL DEFAULT 0 COMMENT 'Thời gian cập nhật của status kia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_payment`
--

DROP TABLE IF EXISTS `nv4_wallet_payment`;
CREATE TABLE `nv4_wallet_payment` (
  `payment` varchar(100) NOT NULL DEFAULT '',
  `paymentname` varchar(255) NOT NULL DEFAULT '',
  `domain` varchar(255) NOT NULL DEFAULT '',
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `weight` int(11) NOT NULL DEFAULT 0,
  `config` text NOT NULL,
  `discount` double NOT NULL DEFAULT 0 COMMENT 'Phí cho nhà cung cấp dịch vụ, phần này chỉ làm đối số để thống kê',
  `discount_transaction` double NOT NULL DEFAULT 0 COMMENT 'Phí giao dịch',
  `images_button` varchar(255) NOT NULL DEFAULT '',
  `bodytext` mediumtext NOT NULL,
  `term` mediumtext NOT NULL,
  `currency_support` varchar(255) NOT NULL DEFAULT '' COMMENT 'Các loại tiền tệ hỗ trợ thanh toán',
  `allowedoptionalmoney` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Cho phép thanh toán số tiền tùy ý hay không',
  `active_completed_email` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Kích hoạt gửi email thông báo các giao dịch chưa hoàn thành',
  `active_incomplete_email` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Kích hoạt gửi email thông báo các giao dịch đã hoàn thành'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv4_wallet_payment`
--

INSERT INTO `nv4_wallet_payment` (`payment`, `paymentname`, `domain`, `active`, `weight`, `config`, `discount`, `discount_transaction`, `images_button`, `bodytext`, `term`, `currency_support`, `allowedoptionalmoney`, `active_completed_email`, `active_incomplete_email`) VALUES
('ATM', 'Thanh toán qua ATM', 'http://nukeviet.vn', 0, 3, 'YTo0OntzOjE1OiJjb21wbGV0ZW1lc3NhZ2UiO3M6MTQwOiJUaMO0bmcgdGluIGPhu6dhIGLhuqFuIMSRw6MgxJHGsOG7o2MgZ2hpIG5o4bqtbi4gQ2jDum5nIHTDtGkgc-G6vSBraeG7g20gdHJhIGdpYW8gZOG7i2NoIG7DoHkgdHJvbmcgdGjhu51pIGdpYW4gc-G7m20gbmjhuqV0LiBYaW4gY-G6o20gxqFuISI7czo2OiJhY3FfaWQiO3M6MTM6IjAzMDEwMDAzODQ3OTIiO3M6MTA6ImFjY291bnRfbm8iO3M6MTQ6Ik5HVVlFTiBWQU4gTEFNIjtzOjEyOiJhY2NvdW50X25hbWUiO3M6MTE6IlZJRVRDT01CQU5LIjt9', 0, 20000, 'logo-vietcombank-khong-slogan.png', '', '', 'VND', 1, 1, 1),
('manual', 'Thanh toán trực tiếp tại website', '', 1, 5, 'YToxOntzOjE1OiJjb21wbGV0ZW1lc3NhZ2UiO3M6MTM2OiJC4bqhbiDEkcOjIGzhu7FhIGNo4buNbiBow6xuaCB0aOG7qWMgdGhhbmggdG_DoW4gdHLhu7FjIHRp4bq_cCwgdnVpIGzDsm5nIMSR4bq_biBjw7RuZyB0eSDEkeG7gyBu4bqhcCB0aeG7gW4gdsOgIGhvw6BuIHThuqV0IHRoYW5oIHRvw6FuIjt9', 0, 20000, '/themes/default/images/wallet/pay-manual.png', '', '', 'VND,USD', 1, 0, 0),
('onepaydomestic', 'Cổng thanh toán nội địa OnePay', 'http://www.onepay.vn/', 1, 1, 'YToxMDp7czoxMjoidnBjX01lcmNoYW50IjtzOjY6Ik9ORVBBWSI7czoxNDoidnBjX0FjY2Vzc0NvZGUiO3M6ODoiRDY3MzQyQzIiO3M6MTE6InZwY19WZXJzaW9uIjtzOjE6IjIiO3M6MTE6InZwY19Db21tYW5kIjtzOjM6InBheSI7czoxMDoidnBjX0xvY2FsZSI7czoyOiJ2biI7czoyMzoidmlydHVhbFBheW1lbnRDbGllbnRVUkwiO3M6NDA6Imh0dHBzOi8vbXRmLm9uZXBheS52bi9vbmVjb21tLXBheS92cGMub3AiO3M6MTM6InNlY3VyZV9zZWNyZXQiO3M6MzI6IkEzRUZERkFCQTg2NTNERjIzNDJFOERBQzI5QjUxQUYwIjtzOjExOiJRdWVyeURSX3VybCI7czo0MjoiaHR0cDovL210Zi5vbmVwYXkudm4vb25lY29tbS1wYXkvVnBjZHBzLm9wIjtzOjg6InZwY19Vc2VyIjtzOjQ6Im9wMDEiO3M6MTI6InZwY19QYXNzd29yZCI7czo4OiJvcDEyMzQ1NiI7fQ,,', 1, 1600, '/themes/default/images/wallet/pay-onepay.png', '', '', 'VND', 1, 0, 0),
('VietQR', 'Quét QRcode qua App', 'https://vietqr.net/', 1, 6, 'YTo0OntzOjE1OiJjb21wbGV0ZW1lc3NhZ2UiO3M6MTQwOiJUaMO0bmcgdGluIGPhu6dhIGLhuqFuIMSRw6MgxJHGsOG7o2MgZ2hpIG5o4bqtbi4gQ2jDum5nIHTDtGkgc-G6vSBraeG7g20gdHJhIGdpYW8gZOG7i2NoIG7DoHkgdHJvbmcgdGjhu51pIGdpYW4gc-G7m20gbmjhuqV0LiBYaW4gY-G6o20gxqFuISI7czo2OiJhY3FfaWQiO3M6MDoiIjtzOjEwOiJhY2NvdW50X25vIjtzOjA6IiI7czoxMjoiYWNjb3VudF9uYW1lIjtzOjA6IiI7fQ,,', 0, 0, '/themes/default/images/wallet/VietQR.png', '', '', 'VND', 1, 0, 0),
('vnpay', 'VNPAYQR', 'https://vnpay.vn/', 1, 4, 'YToxMDp7czoxMToidm5wX1RtbkNvZGUiO3M6MTA6Ik5VS0VWSUVUIDEiO3M6MTQ6InZucF9IYXNoU2VjcmV0IjtzOjM0OiJDWlJLWUlFTkNNTEdTVVpBT0xLTFhUUFNVU0VORUtFSCAxIjtzOjc6InZucF9VcmwiO3M6MzI6Imh0dHBzOi8vcGF5LnZucGF5LnZuL3ZwY3BheS5odG1sIjtzOjExOiJ2bnBfVmVyc2lvbiI7czo1OiIyLjAuMCI7czoxMToidm5wX0NvbW1hbmQiO3M6MzoicGF5IjtzOjEyOiJ2bnBfQ3VyckNvZGUiO3M6MzoiVk5EIjtzOjk6InZucF9JUElQTiI7czoxMzoiMTQuMTYwLjg3LjEyNCI7czo4OiJJUE5BbGVydCI7czoxOiIxIjtzOjEzOiJJUE5BbGVydEVtYWlsIjtzOjA6IiI7czoxMjoiSVBOQWxlcnROb3RpIjtzOjE6IjEiO30,', 0, 20000, '/themes/default/images/wallet/pay-vnpay.jpg', '', '', 'VND', 1, 0, 0),
('vnptepay', 'VNPT EBAY', 'http://vnptepay.com.vn/', 0, 2, 'YTo2OntzOjExOiJtX1BhcnRuZXJJRCI7czoxMDoiY2hhcmdpbmcwMSI7czo2OiJtX01QSU4iO3M6OToicGFqd3RsemNiIjtzOjEwOiJtX1VzZXJOYW1lIjtzOjEwOiJjaGFyZ2luZzAxIjtzOjY6Im1fUGFzcyI7czo5OiJnbXd0d2pmd3MiO3M6MTM6Im1fUGFydG5lckNvZGUiO3M6NToiMDA0NzciO3M6MTA6IndlYnNlcnZpY2UiO3M6ODQ6Imh0dHA6Ly9jaGFyZ2luZy10ZXN0Lm1lZ2FwYXkubmV0LnZuOjEwMDAxL0NhcmRDaGFyZ2luZ0dXX1YyLjAvc2VydmljZXMvU2VydmljZXM_d3NkbCI7fQ,,', 0, 0, '/themes/default/images/wallet/pay-vnpt-epay.png', '', '', 'VND', 0, 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_payment_discount`
--

DROP TABLE IF EXISTS `nv4_wallet_payment_discount`;
CREATE TABLE `nv4_wallet_payment_discount` (
  `payment` varchar(100) NOT NULL DEFAULT '' COMMENT 'Cổng thanh toán',
  `revenue_from` double NOT NULL DEFAULT 0 COMMENT 'Doanh thu từ: Quan hệ lớn hơn hoặc bằng',
  `revenue_to` double NOT NULL DEFAULT 0 COMMENT 'Doanh thu đến: Quan hệ nhỏ hơn',
  `provider` varchar(10) NOT NULL DEFAULT '0' COMMENT 'Nhà cung cấp',
  `discount` double NOT NULL DEFAULT 0 COMMENT 'Mức phí %'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv4_wallet_payment_discount`
--

INSERT INTO `nv4_wallet_payment_discount` (`payment`, `revenue_from`, `revenue_to`, `provider`, `discount`) VALUES
('vnptepay', 1, 1000000, 'FPT', 10),
('vnptepay', 1, 1000000, 'MGC', 10),
('vnptepay', 1, 1000000, 'VMS', 10),
('vnptepay', 1, 1000000, 'VNP', 10),
('vnptepay', 1, 1000000, 'VTC', 10),
('vnptepay', 1, 1000000, 'VTT', 10);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_smslog`
--

DROP TABLE IF EXISTS `nv4_wallet_smslog`;
CREATE TABLE `nv4_wallet_smslog` (
  `id` int(12) UNSIGNED NOT NULL,
  `User_ID` varchar(15) NOT NULL DEFAULT '',
  `Service_ID` varchar(15) NOT NULL DEFAULT '',
  `Command_Code` varchar(160) NOT NULL DEFAULT '',
  `Message` varchar(160) NOT NULL DEFAULT '',
  `Request_ID` varchar(160) NOT NULL DEFAULT '',
  `set_time` int(11) NOT NULL DEFAULT 0,
  `active` tinyint(5) NOT NULL DEFAULT 0,
  `client_ip` varchar(25) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv4_wallet_transaction`
--

DROP TABLE IF EXISTS `nv4_wallet_transaction`;
CREATE TABLE `nv4_wallet_transaction` (
  `id` int(11) NOT NULL,
  `created_time` int(11) NOT NULL DEFAULT 0 COMMENT 'Ngày khởi tạo giao dịch',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT 'Tác động: 1 cộng tiền, -1 trừ tiền',
  `money_unit` char(3) NOT NULL DEFAULT '',
  `money_total` double NOT NULL DEFAULT 0 COMMENT 'Số tiền thực cập nhật vào tài khoản thành viên',
  `money_net` double NOT NULL DEFAULT 0 COMMENT 'Số tiền thành viên thực hiện giao dịch',
  `money_discount` double NOT NULL DEFAULT 0 COMMENT 'Phí doanh nghiệp phải trả cho nhà cung cấp dịch vụ',
  `money_revenue` double NOT NULL DEFAULT 0 COMMENT 'Lợi nhuận mà doanh nghiệp đạt được',
  `userid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID thành viên có tài khoản được tác động',
  `adminid` int(11) NOT NULL DEFAULT 0 COMMENT 'ID admin thực hiện giao dịch, nếu có giá trị này sẽ không tính vào doanh thu khi thống kê',
  `order_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID giao dịch nếu là thanh toán các đơn hàng từ module khác',
  `customer_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID người thực hiện giao dịch (Nạp tiền vào tài khoản)',
  `customer_name` varchar(255) NOT NULL DEFAULT '',
  `customer_email` varchar(255) NOT NULL DEFAULT '',
  `customer_phone` varchar(255) NOT NULL DEFAULT '',
  `customer_address` varchar(255) NOT NULL DEFAULT '',
  `customer_info` text NOT NULL,
  `transaction_id` varchar(255) NOT NULL DEFAULT '',
  `transaction_type` smallint(5) NOT NULL DEFAULT -1 COMMENT 'Loại giao dịch',
  `transaction_status` int(11) NOT NULL DEFAULT 0 COMMENT 'Trạng thái giao dịch được quy ước chuẩn theo module',
  `transaction_time` int(11) NOT NULL DEFAULT 0 COMMENT 'Thời gian thực hiện thanh toán giao dịch',
  `transaction_info` text NOT NULL,
  `transaction_data` text NOT NULL,
  `payment` varchar(50) NOT NULL DEFAULT '' COMMENT 'Cổng thanh toán sử dụng',
  `provider` varchar(50) NOT NULL DEFAULT '' COMMENT 'Nhà cung cấp thẻ sử dụng nếu như đây là cổng thanh toán nạp thẻ, nếu không cần bỏ trống',
  `tokenkey` varchar(32) NOT NULL DEFAULT '',
  `is_expired` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '0: Chưa hết hạn, 1: Hết hạn',
  `detail_money` varchar(255) NOT NULL DEFAULT '',
  `status_tb` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv4_wallet_transaction`
--

INSERT INTO `nv4_wallet_transaction` (`id`, `created_time`, `status`, `money_unit`, `money_total`, `money_net`, `money_discount`, `money_revenue`, `userid`, `adminid`, `order_id`, `customer_id`, `customer_name`, `customer_email`, `customer_phone`, `customer_address`, `customer_info`, `transaction_id`, `transaction_type`, `transaction_status`, `transaction_time`, `transaction_info`, `transaction_data`, `payment`, `provider`, `tokenkey`, `is_expired`, `detail_money`, `status_tb`) VALUES
(376, 1745770737, -1, 'VND', 12200, 12200, 0, 12200, 1, 0, 0, 1, '', '', '', '', '', '', -1, 4, 1745770737, '-12,200đ với giao dịch buff: 284-👍 Like Nhanh Như Gió – Tăng 0–5 Phút | Max 10K', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1001020000,\"money_out\":818960,\"money_total\":1000201040,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(377, 1745801929, -1, 'VND', 1000000000, 1000000000, 0, 1000000000, 1, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1745801929, 'Hệ thống thực hiện -1,000,000,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1001020000,\"money_out\":831160,\"money_total\":1000188840,\"note\":\"\",\"tokenkey\":\"\"}', 0),
(378, 1745849557, -1, 'VND', 1098, 1098, 0, 1098, 71, 0, 0, 71, '', '', '', '', '', '', -1, 4, 1745849557, '-1,098đ với giao dịch buff: 285-🚀 Buff Like Sale Cực Nhanh', '', '', '', '', 0, '{\"userid\":71,\"created_time\":1721747170,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":141600,\"money_out\":140040,\"money_total\":1560,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(379, 1746200772, 1, 'VND', 10000, 10000, 0, 10000, 71, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1746200772, 'Hệ thống thực hiện +10,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":71,\"created_time\":1721747170,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":141600,\"money_out\":141138,\"money_total\":462,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(380, 1746240322, -1, 'VND', 7350, 7350, 0, 7350, 71, 0, 0, 71, '', '', '', '', '', '', -1, 4, 1746240322, '-7,350đ với giao dịch buff: 329-Tăng Page Like + Follow 🔥🔥🔥', '', '', '', '', 0, '{\"userid\":71,\"created_time\":1721747170,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":151600,\"money_out\":141138,\"money_total\":10462,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(381, 1746242731, 1, 'VND', 7350, 7350, 0, 7350, 71, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1746242731, 'Hoàn tiền đơn hàng tăng like + follow', '', '', '', '', 0, '{\"userid\":71,\"created_time\":1721747170,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":151600,\"money_out\":148488,\"money_total\":3112,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(382, 1746260537, -1, 'VND', 7000, 7000, 0, 7000, 71, 0, 0, 71, '', '', '', '', '', '', -1, 4, 1746260537, '-7,000đ với giao dịch buff: 1672-✅ Like page tài nguyên clone VN + world wide, lên ổn định', '', '', '', '', 0, '{\"userid\":71,\"created_time\":1721747170,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":158950,\"money_out\":148488,\"money_total\":10462,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(383, 1746262706, -1, 'VND', 3050, 3050, 0, 3050, 71, 0, 0, 71, '', '', '', '', '', '', -1, 4, 1746262706, '-3,050đ với giao dịch buff: 286-🚀 Tăng like nhanh nhất ❤️ Max 10K', '', '', '', '', 0, '{\"userid\":71,\"created_time\":1721747170,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":158950,\"money_out\":155488,\"money_total\":3462,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(384, 1746376291, -1, 'VND', 24960, 24960, 0, 24960, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746376291, '-24,960đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4832215,\"money_total\":496985,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(385, 1746380536, -1, 'VND', 7800, 7800, 0, 7800, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746380536, '-7,800đ với giao dịch buff: 565-👀 Tăng Lượt Xem Livestream | Thời Gian: 15 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4857175,\"money_total\":472025,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(386, 1746408760, -1, 'VND', 25584, 25584, 0, 25584, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746408760, '-25,584đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4864975,\"money_total\":464225,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(387, 1746409356, -1, 'VND', 12480, 12480, 0, 12480, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746409356, '-12,480đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4890559,\"money_total\":438641,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(388, 1746416931, -1, 'VND', 12480, 12480, 0, 12480, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746416931, '-12,480đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4903039,\"money_total\":426161,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(389, 1746420373, -1, 'VND', 25584, 25584, 0, 25584, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746420373, '-25,584đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4915519,\"money_total\":413681,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(390, 1746430556, -1, 'VND', 18720, 18720, 0, 18720, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746430556, '-18,720đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4941103,\"money_total\":388097,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(391, 1746434221, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746434221, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4959823,\"money_total\":369377,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(392, 1746434380, -1, 'VND', 18720, 18720, 0, 18720, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746434380, '-18,720đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4969183,\"money_total\":360017,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(393, 1746434646, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746434646, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4987903,\"money_total\":341297,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(394, 1746450353, -1, 'VND', 31200, 31200, 0, 31200, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746450353, '-31,200đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":4997263,\"money_total\":331937,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(395, 1746454535, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746454535, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5028463,\"money_total\":300737,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(396, 1746459246, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1746459246, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5037823,\"money_total\":291377,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(397, 1746719307, 1, 'VND', 50000, 50000, 0, 50000, 133, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1746719307, 'Hệ thống thực hiện +50,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":133,\"created_time\":1746601855,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":0,\"money_out\":0,\"money_total\":0,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(398, 1746719442, -1, 'VND', 8800, 8800, 0, 8800, 133, 0, 0, 133, '', '', '', '', '', '', -1, 4, 1746719442, '-8,800đ với giao dịch buff: 289-🚀 Like clone, via. Tốc độ lên khá nhanh ⚡', '', '', '', '', 0, '{\"userid\":133,\"created_time\":1746601855,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":0,\"money_total\":50000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(399, 1747051349, -1, 'VND', 11000, 11000, 0, 11000, 133, 0, 0, 133, '', '', '', '', '', '', -1, 4, 1747051349, '-11,000đ với giao dịch buff: 289-🚀 Like clone, via. Tốc độ lên khá nhanh ⚡', '', '', '', '', 0, '{\"userid\":133,\"created_time\":1746601855,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":8800,\"money_total\":41200,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(400, 1747090581, -1, 'VND', 6600, 6600, 0, 6600, 133, 0, 0, 133, '', '', '', '', '', '', -1, 4, 1747090581, '-6,600đ với giao dịch buff: 289-🚀 Like clone, via. Tốc độ lên khá nhanh ⚡', '', '', '', '', 0, '{\"userid\":133,\"created_time\":1746601855,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":19800,\"money_total\":30200,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(401, 1747090627, -1, 'VND', 7700, 7700, 0, 7700, 133, 0, 0, 133, '', '', '', '', '', '', -1, 4, 1747090627, '-7,700đ với giao dịch buff: 289-🚀 Like clone, via. Tốc độ lên khá nhanh ⚡', '', '', '', '', 0, '{\"userid\":133,\"created_time\":1746601855,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":26400,\"money_total\":23600,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(402, 1747225457, 1, 'VND', 78000, 78000, 0, 78000, 134, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1747225457, 'Hệ thống thực hiện +78,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":134,\"created_time\":1747224453,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":0,\"money_out\":0,\"money_total\":0,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(403, 1747226620, -1, 'VND', 78000, 78000, 0, 78000, 134, 0, 0, 134, '', '', '', '', '', '', -1, 4, 1747226620, '-78,000đ với giao dịch buff: 903-🔎 Vietnam Traffic from Google.com.vn [Organic] [Custom Keywords]', '', '', '', '', 0, '{\"userid\":134,\"created_time\":1747224453,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":78000,\"money_out\":0,\"money_total\":78000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(404, 1747274236, -1, 'VND', 1850, 1850, 0, 1850, 1, 0, 0, 1, '', '', '', '', '', '', -1, 4, 1747274236, '-1,850đ với giao dịch buff: 295-🔥 Tăng Bình Luận Siêu Tốc', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1020000,\"money_out\":831160,\"money_total\":188840,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(405, 1747274468, -1, 'VND', 3700, 3700, 0, 3700, 1, 0, 0, 1, '', '', '', '', '', '', -1, 4, 1747274468, '-3,700đ với giao dịch buff: 291-Tăng cảm xúc ngẫu nhiên 👍❤️😀🤗😲😡.', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1020000,\"money_out\":833010,\"money_total\":186990,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(406, 1747284642, -1, 'VND', 24960, 24960, 0, 24960, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1747284642, '-24,960đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5047183,\"money_total\":282017,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(407, 1747295217, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1747295217, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5072143,\"money_total\":257057,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(408, 1747302742, -1, 'VND', 24300, 24300, 0, 24300, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1747302742, '-24,300đ với giao dịch buff: 593-🔴 Tăng Lượt Xem Livestream Shopee | Thời Gian: 60 Phút| Max 50k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5081503,\"money_total\":247697,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(409, 1747421232, -1, 'VND', 1850, 1850, 0, 1850, 62, 0, 0, 62, '', '', '', '', '', '', -1, 4, 1747421232, '-1,850đ với giao dịch buff: 483-🚀 Like Instagram Ổn Định – View Thật, Tăng Mượt', '', '', '', '', 0, '{\"userid\":62,\"created_time\":1719249565,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":95000,\"money_out\":92700,\"money_total\":2300,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(410, 1747566206, -1, 'VND', 600, 600, 0, 600, 1, 0, 0, 1, '', '', '', '', '', '', -1, 4, 1747566206, '-600đ với giao dịch buff: 542-🚀 Like YouTube Global Lên Từ Từ', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1020000,\"money_out\":836710,\"money_total\":183290,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(411, 1747579546, 1, 'VND', 50000, 50000, 0, 50000, 136, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1747579546, 'Hệ thống thực hiện +50,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":136,\"created_time\":1747577197,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":0,\"money_out\":0,\"money_total\":0,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(412, 1747582766, -1, 'VND', 4000, 4000, 0, 4000, 136, 0, 0, 136, '', '', '', '', '', '', -1, 4, 1747582766, '-4,000đ với giao dịch buff: 367-✅ View TikTok Ổn Định – Ít Rớt, Tăng Tự Nhiên, An Toàn', '', '', '', '', 0, '{\"userid\":136,\"created_time\":1747577197,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":0,\"money_total\":50000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(413, 1747583118, -1, 'VND', 11800, 11800, 0, 11800, 136, 0, 0, 136, '', '', '', '', '', '', -1, 4, 1747583118, '-11,800đ với giao dịch buff: 374-✅ Tăng Lượt Thích – View Thật, Lên Ổn, Không Bay', '', '', '', '', 0, '{\"userid\":136,\"created_time\":1747577197,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":4000,\"money_total\":46000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(414, 1747644569, -1, 'VND', 1850, 1850, 0, 1850, 1, 0, 0, 1, '', '', '', '', '', '', -1, 4, 1747644569, '-1,850đ với giao dịch buff: 293-Tăng cảm xúc ngẫu nhiên 👍❤️😀🤗😲', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1020000,\"money_out\":837310,\"money_total\":182690,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(415, 1747786271, -1, 'VND', 600, 600, 0, 600, 1, 0, 0, 1, '', '', '', '', '', '', -1, 4, 1747786271, '-600đ với giao dịch buff: 542-🚀 Like YouTube Global Lên Từ Từ', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1020000,\"money_out\":839160,\"money_total\":180840,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(416, 1748156544, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1748156544, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5105803,\"money_total\":223397,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(417, 1748411546, 1, 'VND', 50000, 50000, 0, 50000, 137, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1748411546, 'Hệ thống thực hiện +50,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":0,\"money_out\":0,\"money_total\":0,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(418, 1748414671, -1, 'VND', 29500, 29500, 0, 29500, 137, 0, 0, 137, '', '', '', '', '', '', -1, 4, 1748414671, '-29,500đ với giao dịch buff: 911-Vietnam Traffic from YouTube', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":0,\"money_total\":50000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(419, 1748501437, 1, 'VND', 80000, 80000, 0, 80000, 138, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1748501437, 'Hệ thống thực hiện +80,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":138,\"created_time\":1748500443,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":0,\"money_out\":0,\"money_total\":0,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(420, 1748501544, -1, 'VND', 78000, 78000, 0, 78000, 138, 0, 0, 138, '', '', '', '', '', '', -1, 4, 1748501544, '-78,000đ với giao dịch buff: 903-🔎 Vietnam Traffic from Google.com.vn [Organic] [Custom Keywords]', '', '', '', '', 0, '{\"userid\":138,\"created_time\":1748500443,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":80000,\"money_out\":0,\"money_total\":80000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(421, 1748510680, -1, 'VND', 14200, 14200, 0, 14200, 137, 0, 0, 137, '', '', '', '', '', '', -1, 4, 1748510680, '-14,200đ với giao dịch buff: 1030-Choose GEO Target - Mobile Traffic from Android - DIRECT Traffic (Android 11 &amp;amp; 12)', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":29500,\"money_total\":20500,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(422, 1748512061, -1, 'VND', 1600, 1600, 0, 1600, 138, 0, 0, 138, '', '', '', '', '', '', -1, 4, 1748512061, '-1,600đ với giao dịch buff: 971-🟡Basic Web Traffic (Device/OS &amp; Country Control)', '', '', '', '', 0, '{\"userid\":138,\"created_time\":1748500443,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":80000,\"money_out\":78000,\"money_total\":2000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(423, 1748572197, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1748572197, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5115163,\"money_total\":214037,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(424, 1748678936, 1, 'VND', 50000, 50000, 0, 50000, 137, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1748678936, 'Hệ thống thực hiện +50,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":43700,\"money_total\":6300,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(425, 1748679175, -1, 'VND', 56232, 56232, 0, 56232, 137, 0, 0, 137, '', '', '', '', '', '', -1, 4, 1748679175, '-56,232đ với giao dịch buff: 1030-Choose GEO Target - Mobile Traffic from Android - DIRECT Traffic (Android 11 &amp;amp; 12)', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":100000,\"money_out\":43700,\"money_total\":56300,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(426, 1748856032, 1, 'VND', 50000, 50000, 0, 50000, 137, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1748856032, 'Hệ thống thực hiện +50,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":100000,\"money_out\":99932,\"money_total\":68,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(427, 1748856373, -1, 'VND', 50020, 50020, 0, 50020, 137, 0, 0, 137, '', '', '', '', '', '', -1, 4, 1748856373, '-50,020đ với giao dịch buff: 1032-Choose GEO Target - Mobile Traffic from Android - 𝐎𝐫𝐠𝐚𝐧𝐢𝐜 Traffic (Android 11 &amp;amp; 12)', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":99932,\"money_total\":50068,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(428, 1749178145, -1, 'VND', 31200, 31200, 0, 31200, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749178145, '-31,200đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5124523,\"money_total\":204677,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(429, 1749182851, -1, 'VND', 31200, 31200, 0, 31200, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749182851, '-31,200đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5155723,\"money_total\":173477,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(430, 1749185760, -1, 'VND', 31200, 31200, 0, 31200, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749185760, '-31,200đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5186923,\"money_total\":142277,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(431, 1749197906, -1, 'VND', 31200, 31200, 0, 31200, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749197906, '-31,200đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5218123,\"money_total\":111077,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(432, 1749209919, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749209919, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5249323,\"money_total\":79877,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(433, 1749344039, 1, 'VND', 150000, 150000, 0, 150000, 140, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1749344039, 'Hệ thống thực hiện +150,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":0,\"money_out\":0,\"money_total\":0,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(434, 1749353269, 1, 'VND', 70000, 70000, 0, 70000, 137, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1749353269, 'Hệ thống thực hiện +70,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":149952,\"money_total\":48,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(435, 1749360992, -1, 'VND', 1500, 1500, 0, 1500, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749360992, '-1,500đ với giao dịch buff: 975-WorldWide Traffic - Direct Visits ⚡️🔥', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":0,\"money_total\":150000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(436, 1749362615, -1, 'VND', 70006, 70006, 0, 70006, 137, 0, 0, 137, '', '', '', '', '', '', -1, 4, 1749362615, '-70,006đ với giao dịch buff: 1030-Choose GEO Target - Mobile Traffic from Android - DIRECT Traffic (Android 11 &amp;amp; 12)', '', '', '', '', 0, '{\"userid\":137,\"created_time\":1748409956,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":220000,\"money_out\":149952,\"money_total\":70048,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(437, 1749364635, -1, 'VND', 2100, 2100, 0, 2100, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749364635, '-2,100đ với giao dịch buff: 970-🟢Premium Web Traffic (Google Analytics Support / Realistic User Behavior &amp; More)', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":1500,\"money_total\":148500,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(438, 1749364928, -1, 'VND', 1700, 1700, 0, 1700, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749364928, '-1,700đ với giao dịch buff: 973-WorldWide Traffic - Direct Visits [High Bounce] ⚡️🔥', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":3600,\"money_total\":146400,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(439, 1749364973, -1, 'VND', 2100, 2100, 0, 2100, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749364973, '-2,100đ với giao dịch buff: 970-🟢Premium Web Traffic (Google Analytics Support / Realistic User Behavior &amp; More)', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":5300,\"money_total\":144700,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(440, 1749365101, -1, 'VND', 1500, 1500, 0, 1500, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749365101, '-1,500đ với giao dịch buff: 975-WorldWide Traffic - Direct Visits ⚡️🔥', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":7400,\"money_total\":142600,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(441, 1749365313, -1, 'VND', 1500, 1500, 0, 1500, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749365313, '-1,500đ với giao dịch buff: 975-WorldWide Traffic - Direct Visits ⚡️🔥', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":8900,\"money_total\":141100,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(442, 1749368238, -1, 'VND', 4200, 4200, 0, 4200, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749368238, '-4,200đ với giao dịch buff: 970-🟢Premium Web Traffic (Google Analytics Support / Realistic User Behavior &amp; More)', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":10400,\"money_total\":139600,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(443, 1749368398, -1, 'VND', 1600, 1600, 0, 1600, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749368398, '-1,600đ với giao dịch buff: 971-🟡Basic Web Traffic (Device/OS &amp; Country Control)', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":14600,\"money_total\":135400,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(444, 1749368476, -1, 'VND', 1700, 1700, 0, 1700, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749368476, '-1,700đ với giao dịch buff: 973-WorldWide Traffic - Direct Visits [High Bounce] ⚡️🔥', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":16200,\"money_total\":133800,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(445, 1749404681, -1, 'VND', 17000, 17000, 0, 17000, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749404681, '-17,000đ với giao dịch buff: 973-WorldWide Traffic - Direct Visits [High Bounce] ⚡️🔥', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":17900,\"money_total\":132100,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(446, 1749404697, -1, 'VND', 17000, 17000, 0, 17000, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749404697, '-17,000đ với giao dịch buff: 973-WorldWide Traffic - Direct Visits [High Bounce] ⚡️🔥', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":34900,\"money_total\":115100,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(447, 1749456232, -1, 'VND', 3000, 3000, 0, 3000, 140, 0, 0, 140, '', '', '', '', '', '', -1, 4, 1749456232, '-3,000đ với giao dịch buff: 975-WorldWide Traffic - Direct Visits ⚡️🔥', '', '', '', '', 0, '{\"userid\":140,\"created_time\":1749329005,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":150000,\"money_out\":51900,\"money_total\":98100,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(448, 1749626441, -1, 'VND', 24336, 24336, 0, 24336, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749626441, '-24,336đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5258683,\"money_total\":70517,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(449, 1749695247, -1, 'VND', 5350, 5350, 0, 5350, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749695247, '-5,350đ với giao dịch buff: 485-👥 Instagram – Tăng Người Theo Dõi | Max: 20.000 | ⏱️ Bắt đầu: 0–1 Giờ | 🚀 Tốc độ: 1K–10K/ngày', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5283019,\"money_total\":46181,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(450, 1749720815, -1, 'VND', 5350, 5350, 0, 5350, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749720815, '-5,350đ với giao dịch buff: 485-👥 Instagram – Tăng Người Theo Dõi | Max: 20.000 | ⏱️ Bắt đầu: 0–1 Giờ | 🚀 Tốc độ: 1K–10K/ngày', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5288369,\"money_total\":40831,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(451, 1749807313, -1, 'VND', 18720, 18720, 0, 18720, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749807313, '-18,720đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5293719,\"money_total\":35481,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(452, 1749889999, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749889999, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5312439,\"money_total\":16761,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(453, 1749902226, 1, 'VND', 300000, 300000, 0, 300000, 28, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1749902226, 'Hệ thống thực hiện +300,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5329200,\"money_out\":5321799,\"money_total\":7401,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(454, 1749962199, -1, 'VND', 31200, 31200, 0, 31200, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749962199, '-31,200đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5629200,\"money_out\":5321799,\"money_total\":307401,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(455, 1749973147, -1, 'VND', 24960, 24960, 0, 24960, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749973147, '-24,960đ với giao dịch buff: 602-👀 Tăng Lượt Xem Livestream | Thời Gian: 60 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5629200,\"money_out\":5352999,\"money_total\":276201,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(456, 1749986212, -1, 'VND', 9360, 9360, 0, 9360, 28, 0, 0, 28, '', '', '', '', '', '', -1, 4, 1749986212, '-9,360đ với giao dịch buff: 566-👀 Tăng Lượt Xem Livestream | Thời Gian: 30 Phút &nbsp;- Max: 10k', '', '', '', '', 0, '{\"userid\":28,\"created_time\":1712831564,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":5629200,\"money_out\":5377959,\"money_total\":251241,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(457, 1750024938, 1, 'VND', 50000, 50000, 0, 50000, 142, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1750024938, 'Hệ thống thực hiện +50,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":142,\"created_time\":1750022362,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":0,\"money_out\":0,\"money_total\":0,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(458, 1750026059, -1, 'VND', 29500, 29500, 0, 29500, 142, 0, 0, 142, '', '', '', '', '', '', -1, 4, 1750026059, '-29,500đ với giao dịch buff: 905-Vietnam Traffic from Google.com.vn', '', '', '', '', 0, '{\"userid\":142,\"created_time\":1750022362,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":0,\"money_total\":50000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(459, 1750026140, -1, 'VND', 15000, 15000, 0, 15000, 142, 0, 0, 142, '', '', '', '', '', '', -1, 4, 1750026140, '-15,000đ với giao dịch buff: 980-Worldwide Traffic from Google ⚡️', '', '', '', '', 0, '{\"userid\":142,\"created_time\":1750022362,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":29500,\"money_total\":20500,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(460, 1750300817, 1, 'VND', 50000, 50000, 0, 50000, 56, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1750300817, 'Hệ thống thực hiện +50,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":56,\"created_time\":1717477500,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":646000,\"money_out\":639000,\"money_total\":7000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(461, 1750302677, -1, 'VND', 10000, 10000, 0, 10000, 56, 0, 0, 56, '', '', '', '', '', '', -1, 4, 1750302677, '-10,000đ với giao dịch buff: 366-🎯 View TikTok – Rẻ, Ổn, Hợp Lý Cho Mọi Kênh', '', '', '', '', 0, '{\"userid\":56,\"created_time\":1717477500,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":696000,\"money_out\":639000,\"money_total\":57000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(462, 1750302813, -1, 'VND', 37000, 37000, 0, 37000, 56, 0, 0, 56, '', '', '', '', '', '', -1, 4, 1750302813, '-37,000đ với giao dịch buff: 373-&nbsp;👍 Tăng Like – Lên Ổn Định, Tương Tác', '', '', '', '', 0, '{\"userid\":56,\"created_time\":1717477500,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":696000,\"money_out\":649000,\"money_total\":47000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(463, 1750303358, -1, 'VND', 1450, 1450, 0, 1450, 56, 0, 0, 56, '', '', '', '', '', '', -1, 4, 1750303358, '-1,450đ với giao dịch buff: 372-💬 Tăng Like Bài Viết Tiktok Giá Rẻ', '', '', '', '', 0, '{\"userid\":56,\"created_time\":1717477500,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":696000,\"money_out\":686000,\"money_total\":10000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(464, 1750303596, -1, 'VND', 3700, 3700, 0, 3700, 56, 0, 0, 56, '', '', '', '', '', '', -1, 4, 1750303596, '-3,700đ với giao dịch buff: 373-&nbsp;👍 Tăng Like – Lên Ổn Định, Tương Tác', '', '', '', '', 0, '{\"userid\":56,\"created_time\":1717477500,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":696000,\"money_out\":687450,\"money_total\":8550,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(465, 1750303684, -1, 'VND', 1450, 1450, 0, 1450, 56, 0, 0, 56, '', '', '', '', '', '', -1, 4, 1750303684, '-1,450đ với giao dịch buff: 372-💬 Tăng Like Bài Viết Tiktok Giá Rẻ', '', '', '', '', 0, '{\"userid\":56,\"created_time\":1717477500,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":696000,\"money_out\":691150,\"money_total\":4850,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(466, 1750303762, -1, 'VND', 1450, 1450, 0, 1450, 56, 0, 0, 56, '', '', '', '', '', '', -1, 4, 1750303762, '-1,450đ với giao dịch buff: 372-💬 Tăng Like Bài Viết Tiktok Giá Rẻ', '', '', '', '', 0, '{\"userid\":56,\"created_time\":1717477500,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":696000,\"money_out\":692600,\"money_total\":3400,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(467, 1750303862, -1, 'VND', 1885, 1885, 0, 1885, 56, 0, 0, 56, '', '', '', '', '', '', -1, 4, 1750303862, '-1,885đ với giao dịch buff: 372-💬 Tăng Like Bài Viết Tiktok Giá Rẻ', '', '', '', '', 0, '{\"userid\":56,\"created_time\":1717477500,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":696000,\"money_out\":694050,\"money_total\":1950,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(468, 1750691555, 1, 'VND', 50000, 50000, 0, 50000, 144, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1750691555, 'Hệ thống thực hiện +50,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":144,\"created_time\":1750639455,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":0,\"money_out\":0,\"money_total\":0,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(469, 1750724640, -1, 'VND', 49560, 49560, 0, 49560, 144, 0, 0, 144, '', '', '', '', '', '', -1, 4, 1750724640, '-49,560đ với giao dịch buff: 928-Vietnam Traffic from Thethao247.vn', '', '', '', '', 0, '{\"userid\":144,\"created_time\":1750639455,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":0,\"money_total\":50000,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(470, 1750727676, 1, 'VND', 100000, 100000, 0, 100000, 144, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1750727676, 'Hệ thống thực hiện +100,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":144,\"created_time\":1750639455,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":50000,\"money_out\":49560,\"money_total\":440,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(471, 1750732205, -1, 'VND', 3050, 3050, 0, 3050, 1, 0, 0, 1, '', '', '', '', '', '', -1, 4, 1750732205, '-3,050đ với giao dịch buff: 285-🚀 Buff Like Sale Cực Nhanh', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1020000,\"money_out\":839760,\"money_total\":180240,\"note\":\"\",\"tokenkey\":\"\"}', 1),
(472, 1750732727, -1, 'VND', 1850, 1850, 0, 1850, 1, 0, 0, 1, '', '', '', '', '', '', -1, 4, 1750732727, '-1,850đ với giao dịch buff: 295-🔥 Tăng Bình Luận Siêu Tốc', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1020000,\"money_out\":842810,\"money_total\":177190,\"note\":\"\",\"tokenkey\":\"\"}', 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `nv4_wallet_admins`
--
ALTER TABLE `nv4_wallet_admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD KEY `gid` (`gid`);

--
-- Chỉ mục cho bảng `nv4_wallet_admin_groups`
--
ALTER TABLE `nv4_wallet_admin_groups`
  ADD PRIMARY KEY (`gid`),
  ADD UNIQUE KEY `group_title` (`group_title`),
  ADD KEY `is_wallet` (`is_wallet`),
  ADD KEY `is_vtransaction` (`is_vtransaction`),
  ADD KEY `is_mtransaction` (`is_mtransaction`),
  ADD KEY `is_vorder` (`is_vorder`),
  ADD KEY `is_morder` (`is_morder`),
  ADD KEY `is_exchange` (`is_exchange`),
  ADD KEY `is_money` (`is_money`),
  ADD KEY `is_payport` (`is_payport`),
  ADD KEY `is_configmod` (`is_configmod`),
  ADD KEY `is_viewstats` (`is_viewstats`);

--
-- Chỉ mục cho bảng `nv4_wallet_bank_info`
--
ALTER TABLE `nv4_wallet_bank_info`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nv4_wallet_epay_log`
--
ALTER TABLE `nv4_wallet_epay_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `time` (`time`),
  ADD KEY `telco` (`telco`,`code`);

--
-- Chỉ mục cho bảng `nv4_wallet_exchange`
--
ALTER TABLE `nv4_wallet_exchange`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type` (`money_unit`,`than_unit`);

--
-- Chỉ mục cho bảng `nv4_wallet_exchange_log`
--
ALTER TABLE `nv4_wallet_exchange_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Chỉ mục cho bảng `nv4_wallet_ipn_logs`
--
ALTER TABLE `nv4_wallet_ipn_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `log_ip` (`log_ip`),
  ADD KEY `request_method` (`request_method`),
  ADD KEY `request_time` (`request_time`);

--
-- Chỉ mục cho bảng `nv4_wallet_money`
--
ALTER TABLE `nv4_wallet_money`
  ADD UNIQUE KEY `userid` (`userid`,`money_unit`);

--
-- Chỉ mục cho bảng `nv4_wallet_money_sys`
--
ALTER TABLE `nv4_wallet_money_sys`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nv4_wallet_orders`
--
ALTER TABLE `nv4_wallet_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_key` (`order_mod`,`order_id`),
  ADD UNIQUE KEY `secret_code` (`secret_code`),
  ADD KEY `paid_status` (`paid_status`);

--
-- Chỉ mục cho bảng `nv4_wallet_payment`
--
ALTER TABLE `nv4_wallet_payment`
  ADD PRIMARY KEY (`payment`);

--
-- Chỉ mục cho bảng `nv4_wallet_payment_discount`
--
ALTER TABLE `nv4_wallet_payment_discount`
  ADD UNIQUE KEY `payment` (`payment`,`revenue_from`,`revenue_to`,`provider`);

--
-- Chỉ mục cho bảng `nv4_wallet_smslog`
--
ALTER TABLE `nv4_wallet_smslog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `set_time` (`set_time`);

--
-- Chỉ mục cho bảng `nv4_wallet_transaction`
--
ALTER TABLE `nv4_wallet_transaction`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `adminid` (`adminid`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `created_time` (`created_time`),
  ADD KEY `customer_name` (`customer_name`(191)),
  ADD KEY `customer_email` (`customer_email`(191)),
  ADD KEY `transaction_type` (`transaction_type`),
  ADD KEY `is_expired` (`is_expired`),
  ADD KEY `status_tb` (`status_tb`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_admin_groups`
--
ALTER TABLE `nv4_wallet_admin_groups`
  MODIFY `gid` smallint(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_bank_info`
--
ALTER TABLE `nv4_wallet_bank_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_epay_log`
--
ALTER TABLE `nv4_wallet_epay_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_exchange`
--
ALTER TABLE `nv4_wallet_exchange`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_exchange_log`
--
ALTER TABLE `nv4_wallet_exchange_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_ipn_logs`
--
ALTER TABLE `nv4_wallet_ipn_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_money_sys`
--
ALTER TABLE `nv4_wallet_money_sys`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=841;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_orders`
--
ALTER TABLE `nv4_wallet_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_smslog`
--
ALTER TABLE `nv4_wallet_smslog`
  MODIFY `id` int(12) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv4_wallet_transaction`
--
ALTER TABLE `nv4_wallet_transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=473;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
