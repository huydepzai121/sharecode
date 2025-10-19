-- Cấu hình DeepSeek AI cho module ShareCode
-- Chạy SQL này để thêm cấu hình AI vào hệ thống

INSERT INTO `nv4_config` (`lang`, `module`, `config_name`, `config_value`) VALUES
('vi', 'sharecode', 'deekseek_base_url', 'https://api.deepseek.com'),
('vi', 'sharecode', 'deekseek_api_key', '');

-- Nếu bạn sử dụng ngôn ngữ khác, thay 'vi' bằng mã ngôn ngữ tương ứng
-- Ví dụ cho tiếng Anh:
-- INSERT INTO `nv4_config` (`lang`, `module`, `config_name`, `config_value`) VALUES
-- ('en', 'sharecode', 'deekseek_base_url', 'https://api.deepseek.com'),
-- ('en', 'sharecode', 'deekseek_api_key', '');

-- Sau khi chạy SQL, vào Admin > Modules > ShareCode > Cấu hình để nhập API key
