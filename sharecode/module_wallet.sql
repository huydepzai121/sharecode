-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 02, 2025 lúc 03:59 PM
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
-- Cấu trúc bảng cho bảng `nv5_wallet_admins`
--

DROP TABLE IF EXISTS `nv5_wallet_admins`;
CREATE TABLE `nv5_wallet_admins` (
  `admin_id` mediumint(8) NOT NULL,
  `gid` smallint(4) NOT NULL,
  `add_time` int(11) NOT NULL DEFAULT 0,
  `update_time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv5_wallet_admins`
--

INSERT INTO `nv5_wallet_admins` (`admin_id`, `gid`, `add_time`, `update_time`) VALUES
(30, 0, 1745111196, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_wallet_admin_groups`
--

DROP TABLE IF EXISTS `nv5_wallet_admin_groups`;
CREATE TABLE `nv5_wallet_admin_groups` (
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
-- Cấu trúc bảng cho bảng `nv5_wallet_bank_info`
--

DROP TABLE IF EXISTS `nv5_wallet_bank_info`;
CREATE TABLE `nv5_wallet_bank_info` (
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
-- Đang đổ dữ liệu cho bảng `nv5_wallet_bank_info`
--

INSERT INTO `nv5_wallet_bank_info` (`id`, `title`, `account_holder`, `account_number`, `bank_name`, `description_content`, `note`, `status`, `url_config`) VALUES
(1, 'VIETCOMBANK', 'NGUYEN VAN LAM', '0301000384792', '/uploads/wallet/vcb.png', '', '', 1, 'smtraffic.com'),
(2, 'MOMO', 'Nguyễn Văn Lâm', '0363149147', '/uploads/wallet/momo_logo.png', '', '', 1, 'smtraffic.com'),
(5, 'VIETCOMBANK', 'NGUYỄN VĂN LÂM', '0301000384792', '/uploads/wallet/vcb.png', '', '', 1, 'sharecode.local'),
(6, 'MOMO', 'Nguyễn Văn Lâm', '0363149147', 'https://smtraffic.com/uploads/wallet/momo_logo.png', '', '', 1, 'sharecode.local');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_wallet_epay_log`
--

DROP TABLE IF EXISTS `nv5_wallet_epay_log`;
CREATE TABLE `nv5_wallet_epay_log` (
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
-- Cấu trúc bảng cho bảng `nv5_wallet_exchange`
--

DROP TABLE IF EXISTS `nv5_wallet_exchange`;
CREATE TABLE `nv5_wallet_exchange` (
  `id` int(10) UNSIGNED NOT NULL,
  `money_unit` char(3) NOT NULL DEFAULT '',
  `than_unit` char(3) NOT NULL DEFAULT '',
  `exchange_from` double NOT NULL DEFAULT 1,
  `exchange_to` double NOT NULL DEFAULT 1,
  `time_update` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv5_wallet_exchange`
--

INSERT INTO `nv5_wallet_exchange` (`id`, `money_unit`, `than_unit`, `exchange_from`, `exchange_to`, `time_update`, `status`) VALUES
(1, 'USD', 'VND', 1, 22675, 1312000118, 1),
(2, 'VND', 'USD', 22675, 1, 1439725873, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_wallet_exchange_log`
--

DROP TABLE IF EXISTS `nv5_wallet_exchange_log`;
CREATE TABLE `nv5_wallet_exchange_log` (
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
-- Cấu trúc bảng cho bảng `nv5_wallet_ipn_logs`
--

DROP TABLE IF EXISTS `nv5_wallet_ipn_logs`;
CREATE TABLE `nv5_wallet_ipn_logs` (
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
-- Cấu trúc bảng cho bảng `nv5_wallet_money`
--

DROP TABLE IF EXISTS `nv5_wallet_money`;
CREATE TABLE `nv5_wallet_money` (
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
-- Đang đổ dữ liệu cho bảng `nv5_wallet_money`
--

INSERT INTO `nv5_wallet_money` (`userid`, `created_time`, `created_userid`, `status`, `money_unit`, `money_in`, `money_out`, `money_total`, `note`, `tokenkey`) VALUES
(1, 1684770292, 0, 1, 'VND', 1620000, 844660, 775340, '', ''),
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
-- Cấu trúc bảng cho bảng `nv5_wallet_money_sys`
--

DROP TABLE IF EXISTS `nv5_wallet_money_sys`;
CREATE TABLE `nv5_wallet_money_sys` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` char(3) NOT NULL DEFAULT '',
  `currency` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv5_wallet_money_sys`
--

INSERT INTO `nv5_wallet_money_sys` (`id`, `code`, `currency`) VALUES
(704, 'VND', 'Vietnam Dong'),
(840, 'USD', 'US Dollar');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_wallet_orders`
--

DROP TABLE IF EXISTS `nv5_wallet_orders`;
CREATE TABLE `nv5_wallet_orders` (
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
-- Cấu trúc bảng cho bảng `nv5_wallet_payment`
--

DROP TABLE IF EXISTS `nv5_wallet_payment`;
CREATE TABLE `nv5_wallet_payment` (
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
-- Đang đổ dữ liệu cho bảng `nv5_wallet_payment`
--

INSERT INTO `nv5_wallet_payment` (`payment`, `paymentname`, `domain`, `active`, `weight`, `config`, `discount`, `discount_transaction`, `images_button`, `bodytext`, `term`, `currency_support`, `allowedoptionalmoney`, `active_completed_email`, `active_incomplete_email`) VALUES
('ATM', 'Thanh toán qua ATM', 'http://nukeviet.vn', 0, 3, 'YTo0OntzOjE1OiJjb21wbGV0ZW1lc3NhZ2UiO3M6MTQwOiJUaMO0bmcgdGluIGPhu6dhIGLhuqFuIMSRw6MgxJHGsOG7o2MgZ2hpIG5o4bqtbi4gQ2jDum5nIHTDtGkgc-G6vSBraeG7g20gdHJhIGdpYW8gZOG7i2NoIG7DoHkgdHJvbmcgdGjhu51pIGdpYW4gc-G7m20gbmjhuqV0LiBYaW4gY-G6o20gxqFuISI7czo2OiJhY3FfaWQiO3M6MTM6IjAzMDEwMDAzODQ3OTIiO3M6MTA6ImFjY291bnRfbm8iO3M6MTQ6Ik5HVVlFTiBWQU4gTEFNIjtzOjEyOiJhY2NvdW50X25hbWUiO3M6MTE6IlZJRVRDT01CQU5LIjt9', 0, 20000, 'logo-vietcombank-khong-slogan.png', '', '', 'VND', 1, 1, 1),
('manual', 'Thanh toán trực tiếp tại website', '', 1, 5, 'YToxOntzOjE1OiJjb21wbGV0ZW1lc3NhZ2UiO3M6MTM2OiJC4bqhbiDEkcOjIGzhu7FhIGNo4buNbiBow6xuaCB0aOG7qWMgdGhhbmggdG_DoW4gdHLhu7FjIHRp4bq_cCwgdnVpIGzDsm5nIMSR4bq_biBjw7RuZyB0eSDEkeG7gyBu4bqhcCB0aeG7gW4gdsOgIGhvw6BuIHThuqV0IHRoYW5oIHRvw6FuIjt9', 0, 20000, '/themes/default/images/wallet/pay-manual.png', '', '', 'VND,USD', 1, 0, 0),
('onepaydomestic', 'Cổng thanh toán nội địa OnePay', 'http://www.onepay.vn/', 1, 1, 'YToxMDp7czoxMjoidnBjX01lcmNoYW50IjtzOjY6Ik9ORVBBWSI7czoxNDoidnBjX0FjY2Vzc0NvZGUiO3M6ODoiRDY3MzQyQzIiO3M6MTE6InZwY19WZXJzaW9uIjtzOjE6IjIiO3M6MTE6InZwY19Db21tYW5kIjtzOjM6InBheSI7czoxMDoidnBjX0xvY2FsZSI7czoyOiJ2biI7czoyMzoidmlydHVhbFBheW1lbnRDbGllbnRVUkwiO3M6NDA6Imh0dHBzOi8vbXRmLm9uZXBheS52bi9vbmVjb21tLXBheS92cGMub3AiO3M6MTM6InNlY3VyZV9zZWNyZXQiO3M6MzI6IkEzRUZERkFCQTg2NTNERjIzNDJFOERBQzI5QjUxQUYwIjtzOjExOiJRdWVyeURSX3VybCI7czo0MjoiaHR0cDovL210Zi5vbmVwYXkudm4vb25lY29tbS1wYXkvVnBjZHBzLm9wIjtzOjg6InZwY19Vc2VyIjtzOjQ6Im9wMDEiO3M6MTI6InZwY19QYXNzd29yZCI7czo4OiJvcDEyMzQ1NiI7fQ,,', 1, 1600, '/themes/default/images/wallet/pay-onepay.png', '', '', 'VND', 1, 0, 0),
('VietQR', 'Quét QRcode qua App', 'https://vietqr.net/', 1, 6, 'YTo0OntzOjE1OiJjb21wbGV0ZW1lc3NhZ2UiO3M6MTQwOiJUaMO0bmcgdGluIGPhu6dhIGLhuqFuIMSRw6MgxJHGsOG7o2MgZ2hpIG5o4bqtbi4gQ2jDum5nIHTDtGkgc-G6vSBraeG7g20gdHJhIGdpYW8gZOG7i2NoIG7DoHkgdHJvbmcgdGjhu51pIGdpYW4gc-G7m20gbmjhuqV0LiBYaW4gY-G6o20gxqFuISI7czo2OiJhY3FfaWQiO3M6MDoiIjtzOjEwOiJhY2NvdW50X25vIjtzOjA6IiI7czoxMjoiYWNjb3VudF9uYW1lIjtzOjA6IiI7fQ,,', 0, 0, '/themes/default/images/wallet/VietQR.png', '', '', 'VND', 1, 0, 0),
('vnpay', 'VNPAYQR', 'https://vnpay.vn/', 1, 4, 'YToxMDp7czoxMToidm5wX1RtbkNvZGUiO3M6MTA6Ik5VS0VWSUVUIDEiO3M6MTQ6InZucF9IYXNoU2VjcmV0IjtzOjM0OiJDWlJLWUlFTkNNTEdTVVpBT0xLTFhUUFNVU0VORUtFSCAxIjtzOjc6InZucF9VcmwiO3M6MzI6Imh0dHBzOi8vcGF5LnZucGF5LnZuL3ZwY3BheS5odG1sIjtzOjExOiJ2bnBfVmVyc2lvbiI7czo1OiIyLjAuMCI7czoxMToidm5wX0NvbW1hbmQiO3M6MzoicGF5IjtzOjEyOiJ2bnBfQ3VyckNvZGUiO3M6MzoiVk5EIjtzOjk6InZucF9JUElQTiI7czoxMzoiMTQuMTYwLjg3LjEyNCI7czo4OiJJUE5BbGVydCI7czoxOiIxIjtzOjEzOiJJUE5BbGVydEVtYWlsIjtzOjA6IiI7czoxMjoiSVBOQWxlcnROb3RpIjtzOjE6IjEiO30,', 0, 20000, '/themes/default/images/wallet/pay-vnpay.jpg', '', '', 'VND', 1, 0, 0),
('vnptepay', 'VNPT EBAY', 'http://vnptepay.com.vn/', 0, 2, 'YTo2OntzOjExOiJtX1BhcnRuZXJJRCI7czoxMDoiY2hhcmdpbmcwMSI7czo2OiJtX01QSU4iO3M6OToicGFqd3RsemNiIjtzOjEwOiJtX1VzZXJOYW1lIjtzOjEwOiJjaGFyZ2luZzAxIjtzOjY6Im1fUGFzcyI7czo5OiJnbXd0d2pmd3MiO3M6MTM6Im1fUGFydG5lckNvZGUiO3M6NToiMDA0NzciO3M6MTA6IndlYnNlcnZpY2UiO3M6ODQ6Imh0dHA6Ly9jaGFyZ2luZy10ZXN0Lm1lZ2FwYXkubmV0LnZuOjEwMDAxL0NhcmRDaGFyZ2luZ0dXX1YyLjAvc2VydmljZXMvU2VydmljZXM_d3NkbCI7fQ,,', 0, 0, '/themes/default/images/wallet/pay-vnpt-epay.png', '', '', 'VND', 0, 0, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_wallet_payment_discount`
--

DROP TABLE IF EXISTS `nv5_wallet_payment_discount`;
CREATE TABLE `nv5_wallet_payment_discount` (
  `payment` varchar(100) NOT NULL DEFAULT '' COMMENT 'Cổng thanh toán',
  `revenue_from` double NOT NULL DEFAULT 0 COMMENT 'Doanh thu từ: Quan hệ lớn hơn hoặc bằng',
  `revenue_to` double NOT NULL DEFAULT 0 COMMENT 'Doanh thu đến: Quan hệ nhỏ hơn',
  `provider` varchar(10) NOT NULL DEFAULT '0' COMMENT 'Nhà cung cấp',
  `discount` double NOT NULL DEFAULT 0 COMMENT 'Mức phí %'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nv5_wallet_payment_discount`
--

INSERT INTO `nv5_wallet_payment_discount` (`payment`, `revenue_from`, `revenue_to`, `provider`, `discount`) VALUES
('vnptepay', 1, 1000000, 'FPT', 10),
('vnptepay', 1, 1000000, 'MGC', 10),
('vnptepay', 1, 1000000, 'VMS', 10),
('vnptepay', 1, 1000000, 'VNP', 10),
('vnptepay', 1, 1000000, 'VTC', 10),
('vnptepay', 1, 1000000, 'VTT', 10);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nv5_wallet_smslog`
--

DROP TABLE IF EXISTS `nv5_wallet_smslog`;
CREATE TABLE `nv5_wallet_smslog` (
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
-- Cấu trúc bảng cho bảng `nv5_wallet_transaction`
--

DROP TABLE IF EXISTS `nv5_wallet_transaction`;
CREATE TABLE `nv5_wallet_transaction` (
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
-- Đang đổ dữ liệu cho bảng `nv5_wallet_transaction`
--

INSERT INTO `nv5_wallet_transaction` (`id`, `created_time`, `status`, `money_unit`, `money_total`, `money_net`, `money_discount`, `money_revenue`, `userid`, `adminid`, `order_id`, `customer_id`, `customer_name`, `customer_email`, `customer_phone`, `customer_address`, `customer_info`, `transaction_id`, `transaction_type`, `transaction_status`, `transaction_time`, `transaction_info`, `transaction_data`, `payment`, `provider`, `tokenkey`, `is_expired`, `detail_money`, `status_tb`) VALUES
(1, 1754131002, 1, 'VND', 120000, 120000, 0, 120000, 1, 1, 0, 0, '', '', '', '', '', '', 1, 4, 1754131002, 'Hệ thống thực hiện +120,000 VND vào tài khoản của bạn', '', '', '', '', 0, '{\"userid\":1,\"created_time\":1684770292,\"created_userid\":0,\"status\":1,\"money_unit\":\"VND\",\"money_in\":1500000,\"money_out\":844660,\"money_total\":655340,\"note\":\"\",\"tokenkey\":\"\"}', 0);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `nv5_wallet_admins`
--
ALTER TABLE `nv5_wallet_admins`
  ADD PRIMARY KEY (`admin_id`),
  ADD KEY `gid` (`gid`);

--
-- Chỉ mục cho bảng `nv5_wallet_admin_groups`
--
ALTER TABLE `nv5_wallet_admin_groups`
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
-- Chỉ mục cho bảng `nv5_wallet_bank_info`
--
ALTER TABLE `nv5_wallet_bank_info`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nv5_wallet_epay_log`
--
ALTER TABLE `nv5_wallet_epay_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `time` (`time`),
  ADD KEY `telco` (`telco`,`code`);

--
-- Chỉ mục cho bảng `nv5_wallet_exchange`
--
ALTER TABLE `nv5_wallet_exchange`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `type` (`money_unit`,`than_unit`);

--
-- Chỉ mục cho bảng `nv5_wallet_exchange_log`
--
ALTER TABLE `nv5_wallet_exchange_log`
  ADD PRIMARY KEY (`log_id`);

--
-- Chỉ mục cho bảng `nv5_wallet_ipn_logs`
--
ALTER TABLE `nv5_wallet_ipn_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userid` (`userid`),
  ADD KEY `log_ip` (`log_ip`),
  ADD KEY `request_method` (`request_method`),
  ADD KEY `request_time` (`request_time`);

--
-- Chỉ mục cho bảng `nv5_wallet_money`
--
ALTER TABLE `nv5_wallet_money`
  ADD UNIQUE KEY `userid` (`userid`,`money_unit`);

--
-- Chỉ mục cho bảng `nv5_wallet_money_sys`
--
ALTER TABLE `nv5_wallet_money_sys`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `nv5_wallet_orders`
--
ALTER TABLE `nv5_wallet_orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_key` (`order_mod`,`order_id`),
  ADD UNIQUE KEY `secret_code` (`secret_code`),
  ADD KEY `paid_status` (`paid_status`);

--
-- Chỉ mục cho bảng `nv5_wallet_payment`
--
ALTER TABLE `nv5_wallet_payment`
  ADD PRIMARY KEY (`payment`);

--
-- Chỉ mục cho bảng `nv5_wallet_payment_discount`
--
ALTER TABLE `nv5_wallet_payment_discount`
  ADD UNIQUE KEY `payment` (`payment`,`revenue_from`,`revenue_to`,`provider`);

--
-- Chỉ mục cho bảng `nv5_wallet_smslog`
--
ALTER TABLE `nv5_wallet_smslog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `User_ID` (`User_ID`),
  ADD KEY `set_time` (`set_time`);

--
-- Chỉ mục cho bảng `nv5_wallet_transaction`
--
ALTER TABLE `nv5_wallet_transaction`
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
-- AUTO_INCREMENT cho bảng `nv5_wallet_admin_groups`
--
ALTER TABLE `nv5_wallet_admin_groups`
  MODIFY `gid` smallint(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_bank_info`
--
ALTER TABLE `nv5_wallet_bank_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_epay_log`
--
ALTER TABLE `nv5_wallet_epay_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_exchange`
--
ALTER TABLE `nv5_wallet_exchange`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_exchange_log`
--
ALTER TABLE `nv5_wallet_exchange_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_ipn_logs`
--
ALTER TABLE `nv5_wallet_ipn_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_money_sys`
--
ALTER TABLE `nv5_wallet_money_sys`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=841;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_orders`
--
ALTER TABLE `nv5_wallet_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_smslog`
--
ALTER TABLE `nv5_wallet_smslog`
  MODIFY `id` int(12) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `nv5_wallet_transaction`
--
ALTER TABLE `nv5_wallet_transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
