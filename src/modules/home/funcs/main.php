<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2017 VINADES.,JSC. All rights reserved
 * @License: Not free read more http://nukeviet.vn/vi/store/modules/nvtools/
 * @Createdate Thu, 02 Feb 2017 08:48:59 GMT
 */

if (!defined('NV_IS_MOD_HOME')) {
    die('Stop!!!');
}

$page_title = $module_info['custom_title'];
$key_words = $module_info['keywords'];
$module_sharecode = 'sharecode';

if (!$home) {
    nv_redirect_location(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA);
}

// Cache lại nội dung trang chủ 5 phút
$cache_file = NV_LANG_DATA . '_' . md5($global_config['cdn_url'] . '-block-sharecode-home') . '_' . NV_CACHE_PREFIX . '.cache';
if (($cache = $nv_Cache->getItem('home', $cache_file, 300)) != false) {
    $contents = $cache;
} else {
    global $module_sharecode, $site_mods;

    // Lấy thống kê ShareCode
    $array_stats = [
        'total_sources' => 0,
        'total_downloads' => 0,
        'total_categories' => 0,
        'total_free' => 0
    ];

    /* Lấy thông tin module ShareCode */
    // 1. Lấy danh sách mã nguồn mới nhất
    $array_data = [];
    if (isset($site_mods[$module_sharecode])) {
        $db->sqlreset()
            ->select('*')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_sources')
            ->where('status = 1')
            ->order('add_time DESC');

        $result = $db_slave->query($db_slave->sql());
        while ($view = $result->fetch()) {
            $view['add_time_format'] = nv_date('d/m/Y', $view['add_time']);
            switch ($view['fee_type']) {
                case 'free':
                    $view['price_text'] = 'Miễn phí';
                    $view['price_class'] = 'text-success';
                    break;
                case 'contact':
                    $view['price_text'] = 'Liên hệ để biết giá';
                    $view['price_class'] = 'text-info';
                    break;
                default: // 'paid'
                    $view['price_text'] = number_format($view['fee_amount']) . ' VNĐ';
                    $view['price_class'] = 'text-warning';
            }
            $view['link'] = NV_BASE_SITEURL . $module_sharecode . '/detail/' . $view['alias'];

            // Xử lý hình ảnh từ database - paths now include 'uploads/' prefix
            if (!empty($view['image']) && file_exists(NV_ROOTDIR . '/' . $view['image'])) {
                $view['image_url'] = NV_BASE_SITEURL . $view['image'];
            } elseif (!empty($view['avatar']) && file_exists(NV_ROOTDIR . '/' . $view['avatar'])) {
                $view['image_url'] = NV_BASE_SITEURL . $view['avatar'];
            } else {
                $view['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
            }

            $array_data[$view['id']] = $view;
        }
    }

    $link_more = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_sharecode;

    // pr($array_data);

    // 2. Lấy danh sách danh mục ShareCode (6 danh mục cho categories section)
    $array_plans = [];
    if (isset($site_mods[$module_sharecode])) {
        $db->sqlreset()
            ->select('c.*, COUNT(s.id) as total_sources')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_categories c')
            ->join('LEFT JOIN ' . NV_PREFIXLANG . '_' . $module_sharecode . '_sources s ON c.id = s.catid AND s.status = 1')
            ->where('c.status = 1')
            ->group('c.id')
            ->order('total_sources DESC, c.weight ASC');

        $result = $db_slave->query($db_slave->sql());
        while ($view = $result->fetch()) {
            $view['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_sharecode . '&amp;' . NV_OP_VARIABLE . '=category&amp;t=' . $view['alias'];
            $array_plans[] = $view;
        }
    }

    // Lấy thống kê ShareCode
    if (isset($site_mods[$module_sharecode])) {
        // Tổng số mã nguồn
        $db->sqlreset()
            ->select('COUNT(*)')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_sources')
            ->where('status = 1');
        $array_stats['total_sources'] = $db_slave->query($db_slave->sql())->fetchColumn();

        // Tổng lượt tải
        $db->sqlreset()
            ->select('SUM(num_download)')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_sources')
            ->where('status = 1');
        $array_stats['total_downloads'] = (int)$db_slave->query($db_slave->sql())->fetchColumn();

        // Tổng danh mục
        $db->sqlreset()
            ->select('COUNT(*)')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_categories')
            ->where('status = 1');
        $array_stats['total_categories'] = $db_slave->query($db_slave->sql())->fetchColumn();

        // Tổng mã nguồn miễn phí
        $db->sqlreset()
            ->select('COUNT(*)')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_sources')
            ->where('status = 1 AND fee_type = "free"');
        $array_stats['total_free'] = $db_slave->query($db_slave->sql())->fetchColumn();
    }

    // Lấy thêm thông tin cho các mã nguồn
    foreach ($array_data as $key => $data) {
        // Lấy thông tin danh mục
        $db->sqlreset()
            ->select('title')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_categories')
            ->where('id = ' . $data['catid']);
        $result = $db_slave->query($db_slave->sql());
        if ($result) {
            $category = $result->fetch();
            $array_data[$key]['category_title'] = $category ? $category['title'] : 'Khác';
        } else {
            $array_data[$key]['category_title'] = 'Khác';
        }

        // Thêm hình ảnh mặc định nếu chưa có
        if (empty($array_data[$key]['image_url'])) {
            $array_data[$key]['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.jpg';
        }
    }

    // Lấy thêm mã nguồn phổ biến
    $array_popular_sources = [];
    if (isset($site_mods[$module_sharecode])) {
        $db->sqlreset()
            ->select('*')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_sources')
            ->where('status = 1');

        $result = $db_slave->query($db_slave->sql());
        while ($view = $result->fetch()) {
            $view['add_time_format'] = nv_date('d/m/Y', $view['add_time']);
            switch ($view['fee_type']) {
                case 'free':
                    $view['price_text'] = 'Miễn phí';
                    $view['price_class'] = 'text-success';
                    break;
                case 'contact':
                    $view['price_text'] = 'Liên hệ để biết giá';
                    $view['price_class'] = 'text-info';
                    break;
                default: // 'paid'
                    $view['price_text'] = number_format($view['fee_amount']) . ' VNĐ';
                    $view['price_class'] = 'text-warning';
            }
            $view['link'] = NV_BASE_SITEURL . $module_sharecode . '/detail/' . $view['alias'];

            // Lấy thông tin danh mục
            $db->sqlreset()
                ->select('title')
                ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_categories')
                ->where('id = ' . $view['catid']);
            $cat_result = $db_slave->query($db_slave->sql());
            if ($cat_result) {
                $category = $cat_result->fetch();
                $view['category_title'] = $category ? $category['title'] : 'Khác';
            } else {
                $view['category_title'] = 'Khác';
            }

            // Xử lý hình ảnh từ database
            $module_upload = $module_sharecode;
            if (!empty($view['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $view['image'])) {
                $view['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $view['image'];
            } elseif (!empty($view['avatar']) && file_exists(NV_ROOTDIR . $view['avatar'])) {
                $view['image_url'] = NV_BASE_SITEURL . ltrim($view['avatar'], '/');
            } else {
                $view['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
            }

            $array_popular_sources[$view['id']] = $view;
        }
    }

    $featured_product = null;
    if (isset($site_mods[$module_sharecode]) && !empty($array_popular_sources)) {
        $highest_rating = 0;
        foreach ($array_popular_sources as $source) {
            if ($source['avg_rating'] > $highest_rating) {
                $highest_rating = $source['avg_rating'];
                $featured_product = $source;
            }
        }

        if ($featured_product === null && !empty($array_popular_sources)) {
            $featured_product = reset($array_popular_sources);
        }
    }

    $array_latest_sources = [];
    if (isset($site_mods[$module_sharecode])) {
        $popular_ids = array_keys($array_popular_sources);
        $exclude_condition = '';
        if (!empty($popular_ids)) {
            $exclude_condition = ' AND id NOT IN (' . implode(',', $popular_ids) . ')';
        }

        $db->sqlreset()
            ->select('*')
            ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_sources')
            ->where('status = 1' . $exclude_condition)
            ->order('add_time DESC');

        $result = $db_slave->query($db_slave->sql());
        while ($view = $result->fetch()) {
            // Xử lý giá tiền
            if ($view['fee_type'] == 'free') {
                $view['price_text'] = 'Miễn phí';
                $view['original_price_text'] = '';
            } else {
                $view['price_text'] = number_format($view['price'], 0, ',', '.') . ' VNĐ';
                if ($view['original_price'] > $view['price']) {
                    $view['original_price_text'] = number_format($view['original_price'], 0, ',', '.') . ' VNĐ';
                    $view['discount_percent'] = round((($view['original_price'] - $view['price']) / $view['original_price']) * 100);
                } else {
                    $view['original_price_text'] = '';
                    $view['discount_percent'] = 0;
                }
            }

            // Xử lý rating
            $view['rating'] = number_format($view['avg_rating'], 1);
            if ($view['avg_rating'] == 0) {
                $view['rating'] = '0.0';
            }

            // Xử lý link
            $view['link'] = NV_BASE_SITEURL . $module_sharecode . '/detail/' . $view['alias'];

            // Lấy thông tin danh mục
            $db->sqlreset()
                ->select('title')
                ->from(NV_PREFIXLANG . '_' . $module_sharecode . '_categories')
                ->where('id = ' . $view['catid']);
            $cat_result = $db_slave->query($db_slave->sql());
            if ($cat_result) {
                $category = $cat_result->fetch();
                $view['category_title'] = $category ? $category['title'] : 'Khác';
            } else {
                $view['category_title'] = 'Khác';
            }

            // Xử lý hình ảnh từ database
            $module_upload = $module_sharecode;
            if (!empty($view['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $view['image'])) {
                $view['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $view['image'];
            } elseif (!empty($view['avatar']) && file_exists(NV_ROOTDIR . $view['avatar'])) {
                $view['image_url'] = NV_BASE_SITEURL . ltrim($view['avatar'], '/');
            } else {
                $view['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
            }

            $array_latest_sources[$view['id']] = $view;
        }
    }

    $contents = nv_theme_home_main([], $array_data, $link_more, $array_plans, $array_stats, $array_popular_sources, $featured_product, $array_latest_sources);
    $nv_Cache->setItem('home', $cache_file, $contents);
}

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
