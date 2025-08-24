-- Tạo bảng liên kết giữa source và keywords
CREATE TABLE IF NOT EXISTS `nv4_vi_sharecode_source_keywords` (
    `source_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID mã nguồn',
    `keyword_id` int(11) NOT NULL DEFAULT 0 COMMENT 'ID từ khóa',
    PRIMARY KEY (`source_id`, `keyword_id`),
    KEY `idx_keyword_id` (`keyword_id`)
) ENGINE=MyISAM COMMENT='Bảng liên kết mã nguồn và từ khóa';
