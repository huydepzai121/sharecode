<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) {
    exit('Stop!!!');
}

define('NV_IS_FILE_ADMIN', true);

$allow_func = [
    'main',
    'categories',
    'sources',
    'reviews',
    'logs',
    'config',
    'tags',
    'tag-content',
    'pending',
    'keywords',
    'payments',
    'payment-content',
    'comments',
    'finance'
];

/**
 * Tạo alias từ title
 */
function nv_sharecode_create_alias($title)
{
    return change_alias($title);
}

/**
 * Format file size
 */
function nv_sharecode_format_filesize($bytes)
{
    if ($bytes >= 1073741824) {
        return number_format($bytes / 1073741824, 2) . ' GB';
    } elseif ($bytes >= 1048576) {
        return number_format($bytes / 1048576, 2) . ' MB';
    } elseif ($bytes >= 1024) {
        return number_format($bytes / 1024, 2) . ' KB';
    } else {
        return $bytes . ' bytes';
    }
}

/**
 * Lấy thông tin source
 */
function nv_admin_sharecode_get_source($id)
{
    global $db, $module_data;

    $sql = "SELECT s.*, c.title as category_title
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
            LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
            WHERE s.id = " . intval($id);

    return $db->query($sql)->fetch();
}

/**
 * Lấy tags của source
 */
function nv_admin_sharecode_get_source_tags($source_id)
{
    global $db, $module_data;

    $tags = [];
    $sql = "SELECT t.id, t.name
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags t
            INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st ON t.id = st.tag_id
            WHERE st.source_id = " . intval($source_id) . "
            ORDER BY t.name ASC";
    $result = $db->query($sql);

    while ($row = $result->fetch()) {
        $tags[] = $row;
    }

    return $tags;
}

/**
 * Cập nhật tags cho source
 */
function nv_admin_sharecode_update_source_tags($source_id, $tag_ids)
{
    global $db, $module_data;

    $source_id = intval($source_id);

    if ($source_id <= 0) {
        return false;
    }

    // Lấy danh sách tag cũ để cập nhật count
    $old_tag_ids = [];
    $sql_old = "SELECT tag_id FROM " . NV_PREFIXLANG . "_" . $module_data . "_source_tags WHERE source_id = " . $source_id;
    $result_old = $db->query($sql_old);
    while ($row_old = $result_old->fetch()) {
        $old_tag_ids[] = intval($row_old['tag_id']);
    }

    // Xóa tags cũ
    $sql_delete = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_source_tags WHERE source_id = " . $source_id;
    $db->query($sql_delete);

    // Giảm total_sources cho tags cũ
    if (!empty($old_tag_ids)) {
        foreach ($old_tag_ids as $old_tag_id) {
            $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_tags SET total_sources = GREATEST(total_sources - 1, 0) WHERE id = " . $old_tag_id;
            $db->query($sql_update);
        }
    }

    // Thêm tags mới và cập nhật total_sources
    if (!empty($tag_ids) && is_array($tag_ids)) {
        foreach ($tag_ids as $tag_id) {
            $tag_id = intval($tag_id);
            if ($tag_id > 0) {
                // Thêm liên kết source-tag
                $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES (" . $source_id . ", " . $tag_id . ")";
                $db->query($sql_insert);

                // Tăng total_sources cho tag
                $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_tags SET total_sources = total_sources + 1 WHERE id = " . $tag_id;
                $db->query($sql_update);
            }
        }
    }

    return true;
}

/**
 * Cập nhật keywords cho source
 */
function nv_admin_sharecode_update_source_keywords($source_id, $keyword_ids)
{
    global $db, $module_data;

    $source_id = intval($source_id);

    if ($source_id <= 0) {
        return false;
    }

    // Lấy danh sách keyword cũ để cập nhật count
    $old_keyword_ids = [];
    $sql_old = "SELECT keyword_id FROM " . NV_PREFIXLANG . "_" . $module_data . "_source_keywords WHERE source_id = " . $source_id;
    $result_old = $db->query($sql_old);
    while ($row_old = $result_old->fetch()) {
        $old_keyword_ids[] = intval($row_old['keyword_id']);
    }

    // Xóa keywords cũ
    $sql_delete = "DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_source_keywords WHERE source_id = " . $source_id;
    $db->query($sql_delete);

    // Giảm total_sources cho keywords cũ (nếu có field này)
    if (!empty($old_keyword_ids)) {
        foreach ($old_keyword_ids as $old_keyword_id) {
            // Note: Bảng keywords chưa có field total_sources, có thể thêm sau
            // $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_keywords SET total_sources = GREATEST(total_sources - 1, 0) WHERE id = " . $old_keyword_id;
            // $db->query($sql_update);
        }
    }

    // Thêm keywords mới
    if (!empty($keyword_ids) && is_array($keyword_ids)) {
        foreach ($keyword_ids as $keyword_id) {
            $keyword_id = intval($keyword_id);
            if ($keyword_id > 0) {
                // Thêm liên kết source-keyword
                $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_keywords (source_id, keyword_id) VALUES (" . $source_id . ", " . $keyword_id . ")";
                $db->query($sql_insert);

                // Tăng total_sources cho keyword (nếu có field này)
                // $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_keywords SET total_sources = total_sources + 1 WHERE id = " . $keyword_id;
                // $db->query($sql_update);
            }
        }
    }

    return true;
}

/**
 * Lấy keywords của source
 */
function nv_admin_sharecode_get_source_keywords($source_id)
{
    global $db, $module_data;

    $source_id = intval($source_id);
    $keywords = [];

    if ($source_id > 0) {
        $sql = "SELECT k.id, k.name, k.alias, k.description, k.status
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords k
                INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_keywords sk ON k.id = sk.keyword_id
                WHERE sk.source_id = " . $source_id . " AND k.status = 1
                ORDER BY k.weight ASC, k.name ASC";

        $result = $db->query($sql);
        while ($row = $result->fetch()) {
            $keywords[] = $row;
        }
    }

    return $keywords;
}

/**
 * Lấy tất cả tags
 */
function nv_admin_sharecode_get_all_tags()
{
    global $db, $module_data;

    $tags = [];
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags ORDER BY name ASC";
    $result = $db->query($sql);

    while ($row = $result->fetch()) {
        $tags[] = $row;
    }

    return $tags;
}

/**
 * nv_admin_sharecode_get_categories()
 * Lấy danh sách categories cho admin
 *
 * @param int $parent_id
 * @return array
 */
function nv_admin_sharecode_get_categories($parent_id = 0)
{
    global $db, $module_data, $lang;
    
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories
            WHERE parentid=" . intval($parent_id) . "
            ORDER BY weight ASC";
    $result = $db->query($sql);
    
    $categories = [];
    while ($row = $result->fetch()) {
        $categories[$row['id']] = $row;
    }
    
    return $categories;
}

/**
 * nv_admin_sharecode_get_all_categories()
 * Lấy tất cả categories dạng tree
 *
 * @return array
 */
function nv_admin_sharecode_get_all_categories()
{
    global $db, $module_data, $lang;
    
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories
            ORDER BY parentid ASC, weight ASC";
    $result = $db->query($sql);

    $categories = [];
    while ($row = $result->fetch()) {
        $categories[$row['parentid']][] = $row;
    }
    
    return $categories;
}

/**
 * nv_admin_sharecode_build_category_tree()
 * Xây dựng cây categories
 *
 * @param array $categories
 * @param int $parent_id
 * @param int $level
 * @return array
 */
function nv_admin_sharecode_build_category_tree($categories, $parent_id = 0, $level = 0)
{
    $tree = [];
    
    if (isset($categories[$parent_id])) {
        foreach ($categories[$parent_id] as $category) {
            $category['level'] = $level;
            $tree[] = $category;
            
            $children = nv_admin_sharecode_build_category_tree($categories, $category['id'], $level + 1);
            if (!empty($children)) {
                $tree = array_merge($tree, $children);
            }
        }
    }
    
    return $tree;
}

/**
 * nv_admin_sharecode_get_category_options()
 * Lấy options cho select category
 *
 * @param int $selected_id
 * @param int $exclude_id
 * @return string
 */
function nv_admin_sharecode_get_category_options($selected_id = 0, $exclude_id = 0)
{
    $categories = nv_admin_sharecode_get_all_categories();
    $tree = nv_admin_sharecode_build_category_tree($categories);
    
    $options = '<option value="0">-- Chọn danh mục --</option>';
    
    foreach ($tree as $category) {
        if ($category['id'] == $exclude_id) {
            continue;
        }
        
        $prefix = str_repeat('&nbsp;&nbsp;&nbsp;', $category['level']);
        $selected = ($category['id'] == $selected_id) ? ' selected="selected"' : '';
        $options .= '<option value="' . $category['id'] . '"' . $selected . '>' . $prefix . $category['title'] . '</option>';
    }
    
    return $options;
}

/**
 * nv_admin_sharecode_check_alias()
 * Kiểm tra alias có trùng không
 *
 * @param string $alias
 * @param string $table
 * @param int $exclude_id
 * @return bool
 */
function nv_admin_sharecode_check_alias($alias, $table, $exclude_id = 0)
{
    global $db, $module_data, $lang;
    
    $where = "alias=" . $db->quote($alias);
    if ($exclude_id > 0) {
        $where .= " AND id!=" . intval($exclude_id);
    }
    
    $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_" . $table . " WHERE " . $where;
    $result = $db->query($sql);
    
    return $result->fetchColumn() ? false : true;
}

/**
 * nv_sharecode_set_tag_keywords()
 * Chuẩn hóa keywords cho tags
 *
 * @param string $keywords
 * @param bool $isArr
 * @return string|array
 */
function nv_sharecode_set_tag_keywords($keywords, $isArr = false)
{
    $keywords = nv_strtolower($keywords);
    $keywords = explode(',', $keywords);
    $keywords = array_map('trim', $keywords);
    $keywords = array_filter($keywords);
    $keywords = array_unique($keywords);
    sort($keywords);
    if ($isArr) {
        return $keywords;
    }
    return implode(', ', $keywords);
}

/**
 * nv_sharecode_set_tag_alias()
 * Tạo alias cho tags
 *
 * @param string $keywords
 * @param int $tid
 * @param bool $dbexist
 * @return string
 */
function nv_sharecode_set_tag_alias($keywords, $tid = 0, &$dbexist = false)
{
    global $db, $module_data;
    $alias = change_alias($keywords);
    $dbexist = (bool) $db->query('SELECT COUNT(*) FROM ' . NV_PREFIXLANG . '_' . $module_data . '_tags WHERE alias=' . $db->quote($alias) . ' AND tid!=' . $tid)->fetchColumn();
    return $alias;
}

/**
 * nv_admin_sharecode_create_alias()
 * Tạo alias từ title
 *
 * @param string $title
 * @param string $table
 * @param int $exclude_id
 * @return string
 */
function nv_admin_sharecode_create_alias($title, $table, $exclude_id = 0)
{
    $alias = change_alias($title);
    
    if (!nv_admin_sharecode_check_alias($alias, $table, $exclude_id)) {
        $i = 1;
        while (!nv_admin_sharecode_check_alias($alias . '-' . $i, $table, $exclude_id)) {
            $i++;
        }
        $alias = $alias . '-' . $i;
    }
    
    return $alias;
}

/**
 * nv_admin_sharecode_get_sources()
 * Lấy danh sách sources
 *
 * @param array $where_conditions
 * @param int $page
 * @param int $per_page
 * @return array
 */
function nv_admin_sharecode_get_sources($where_conditions = [], $page = 1, $per_page = 20)
{
    global $db, $module_data, $lang;
    
    $where = "1=1";
    if (!empty($where_conditions)) {
        $where .= " AND " . implode(" AND ", $where_conditions);
    }
    
    $offset = ($page - 1) * $per_page;
    
    $sql = "SELECT s.*, c.title as category_title 
            FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
            LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
            WHERE " . $where . "
            ORDER BY s.add_time DESC
            LIMIT " . $offset . ", " . $per_page;
    $result = $db->query($sql);
    
    $sources = [];
    while ($row = $result->fetch()) {
        $sources[] = $row;
    }
    
    // Đếm tổng số
    $sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s WHERE " . $where;
    $total = $db->query($sql_count)->fetchColumn();
    
    return [
        'data' => $sources,
        'total' => $total,
        'pages' => ceil($total / $per_page)
    ];
}

/**
 * nv_admin_sharecode_delete_source()
 * Xóa source
 *
 * @param int $source_id
 * @return bool
 */
function nv_admin_sharecode_delete_source($source_id)
{
    global $db, $module_data, $lang;
    
    $source_id = intval($source_id);
    
    // Xóa tags liên quan
    $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_source_tags WHERE source_id=" . $source_id);
    
    // Xóa reviews
    $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews WHERE source_id=" . $source_id);
    
    // Xóa download logs
    $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_download_logs WHERE source_id=" . $source_id);
    
    // Xóa comments
    $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_comments WHERE source_id=" . $source_id);

    // Xóa source
    $result = $db->exec("DELETE FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $source_id);

    return $result > 0;
}



/**
 * Thêm watermark vào ảnh
 * @param string $image_path Đường dẫn đến file ảnh
 * @param string $watermark_text Text watermark
 * @return bool
 */
function add_watermark_to_image($image_path, $watermark_text)
{
    if (!file_exists($image_path) || empty($watermark_text)) {
        return false;
    }

    $image_info = getimagesize($image_path);
    if (!$image_info) {
        return false;
    }

    $width = $image_info[0];
    $height = $image_info[1];
    $mime_type = $image_info['mime'];

    // Tạo resource ảnh từ file
    switch ($mime_type) {
        case 'image/jpeg':
            $image = imagecreatefromjpeg($image_path);
            break;
        case 'image/png':
            $image = imagecreatefrompng($image_path);
            break;
        case 'image/gif':
            $image = imagecreatefromgif($image_path);
            break;
        default:
            return false;
    }

    if (!$image) {
        return false;
    }

    // Cấu hình watermark
    $font_size = max(12, $width / 30); // Kích thước font tự động theo ảnh
    $font_color = imagecolorallocatealpha($image, 255, 255, 255, 50); // Trắng, trong suốt 50%
    $shadow_color = imagecolorallocatealpha($image, 0, 0, 0, 50); // Đen, trong suốt 50%

    // Sử dụng imagestring thay vì TTF font để tránh lỗi
    $text_width = strlen($watermark_text) * 10; // Ước tính độ rộng
    $text_height = 15; // Chiều cao font size 5

    $x = $width - $text_width - 20; // Cách lề phải 20px
    $y = $height - $text_height - 20; // Cách lề dưới 20px

    // Vẽ shadow (đổ bóng)
    imagestring($image, 5, $x + 1, $y + 1, $watermark_text, $shadow_color);
    imagestring($image, 5, $x, $y, $watermark_text, $font_color);

    // Lưu ảnh
    $result = false;
    switch ($mime_type) {
        case 'image/jpeg':
            $result = imagejpeg($image, $image_path, 90);
            break;
        case 'image/png':
            $result = imagepng($image, $image_path);
            break;
        case 'image/gif':
            $result = imagegif($image, $image_path);
            break;
    }

    imagedestroy($image);
    return $result;
}

/**
 * Cập nhật lại total_sources cho tất cả tags
 */
function nv_admin_sharecode_update_all_tags_count()
{
    global $db, $module_data;

    // Cập nhật total_sources cho tất cả tags dựa trên số lượng liên kết thực tế
    $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_tags t
            SET total_sources = (
                SELECT COUNT(*)
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st
                WHERE st.tag_id = t.id
            )";

    return $db->query($sql);
}

/**
 * nv_admin_sharecode_get_statistics()
 * Lấy thống kê
 *
 * @return array
 */
function nv_admin_sharecode_get_statistics()
{
    global $db, $module_data, $lang;

    $stats = [];

    // Tổng số categories
    $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories";
    $stats['total_categories'] = $db->query($sql)->fetchColumn();

    // Tổng số sources
    $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources";
    $stats['total_sources'] = $db->query($sql)->fetchColumn();

    // Tổng số sources active
    $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE status=1";
    $stats['active_sources'] = $db->query($sql)->fetchColumn();

    // Tổng số sources pending (chờ duyệt)
    $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE status=0";
    $stats['pending_sources'] = $db->query($sql)->fetchColumn();

    // Tổng lượt download
    $sql = "SELECT SUM(num_download) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources";
    $stats['total_downloads'] = $db->query($sql)->fetchColumn() ?: 0;

    // Tổng lượt xem
    $sql = "SELECT SUM(num_view) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources";
    $stats['total_views'] = $db->query($sql)->fetchColumn() ?: 0;

    // Tổng số reviews (kiểm tra bảng có tồn tại không)
    try {
        $sql = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_reviews";
        $result = $db->query($sql);
        $stats['total_reviews'] = $result ? $result->fetchColumn() : 0;
    } catch (Exception $e) {
        // Bảng reviews chưa tồn tại
        $stats['total_reviews'] = 0;
    }

    // Tổng doanh thu (tính từ các sources có phí)
    try {
        $sql = "SELECT SUM(fee_amount * num_download) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE fee_type != 'free' AND status=1";
        $result = $db->query($sql);
        $stats['total_revenue'] = $result ? ($result->fetchColumn() ?: 0) : 0;
    } catch (Exception $e) {
        // Lỗi truy vấn
        $stats['total_revenue'] = 0;
    }

    return $stats;
}

/**
 * nv_sharecode_send_email_notification()
 * Gửi email thông báo
 *
 * @param string $to_email
 * @param string $to_name
 * @param string $subject
 * @param string $message
 * @return bool
 */
function nv_sharecode_send_email_notification($to_email, $to_name, $subject, $message)
{
    global $global_config, $lang_global;
    
    if (empty($to_email) || empty($subject) || empty($message)) {
        return false;
    }
    
    try {
        // Chuẩn bị email
        $from = [$global_config['site_email'], $global_config['site_name']];
        $to = [$to_email, $to_name];
        
        // Template email cơ bản
        $email_template = '
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
            <div style="background: #f8f9fa; padding: 20px; text-align: center;">
                <h2 style="color: #333; margin: 0;">' . $global_config['site_name'] . '</h2>
                <p style="margin: 5px 0 0 0; color: #666;">ShareCode - Chia sẻ mã nguồn</p>
            </div>
            <div style="padding: 30px 20px;">
                <h3 style="color: #333; margin-top: 0;">' . $subject . '</h3>
                <div style="color: #555; line-height: 1.6;">
                    ' . $message . '
                </div>
            </div>
            <div style="background: #f8f9fa; padding: 15px 20px; text-align: center; font-size: 12px; color: #666;">
                <p>Đây là email tự động, vui lòng không trả lời email này.</p>
                <p>© ' . date('Y') . ' ' . $global_config['site_name'] . '. All rights reserved.</p>
            </div>
        </div>';
        
        return nv_sendmail($from, $to, $subject, $email_template);
    } catch (Exception $e) {
        return false;
    }
}



