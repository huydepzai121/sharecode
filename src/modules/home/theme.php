<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2017 VINADES.,JSC. All rights reserved
 * @License: Not free read more http://nukeviet.vn/vi/store/modules/nvtools/
 * @Createdate Thu, 02 Feb 2017 08:48:59 GMT
 */
if (!defined('NV_IS_MOD_HOME'))
    die('Stop!!!');

/**
 * nv_theme_home_main()
 *
 * @param array $array_catpage Danh sách trang danh mục
 * @param array $array_data Dữ liệu sản phẩm chính
 * @param string $link_more Link xem thêm
 * @param array $array_plans Danh sách danh mục (6 items cho categories section)
 * @param array $array_stats Thống kê tổng quan
 * @param array $array_popular_sources Sản phẩm phổ biến (cho featured section)
 * @param array $featured_product Sản phẩm nổi bật (cho hero-right showcase)
 * @param array $array_latest_sources 8 sản phẩm mới nhất (cho latest section)
 * @return string
 */
function nv_theme_home_main($array_catpage, $array_data, $link_more, $array_plans, $array_stats, $array_popular_sources, $featured_product = null, $array_latest_sources = [])
{
    global $op, $module_file, $module_info, $global_config, $nv_Lang;

    $xtpl = new XTemplate($op . '.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
    $xtpl->assign('LANG', \NukeViet\Core\Language::$lang_module);
    $xtpl->assign('THEMES', $module_info['template']);
    $xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);
    
    // Assign statistics data
    $xtpl->assign('STATS', $array_stats);
    $xtpl->assign('LINK_MORE', $link_more);
    
    // Categories section - 6 danh mục phổ biến với AOS delay
    if (!empty($array_plans)) {
        $category_index = 0;
        foreach ($array_plans as $category) {
            // Tính toán AOS delay cho categories: 200ms, 230ms, 260ms, 290ms, 320ms, 350ms
            $category['aos_delay'] = 200 + ($category_index * 30);
            $xtpl->assign('CATEGORY', $category);
            $xtpl->parse('main.categories_section.category');
            $category_index++;
        }
        $xtpl->parse('main.categories_section');
    }

    // Hero showcase - use first popular source
    if (!empty($array_popular_sources)) {
        $first_source = reset($array_popular_sources);

        // Calculate discount percentage
        if ($first_source['fee_type'] != 'free' && !empty($first_source['original_price']) && $first_source['original_price'] > $first_source['fee_amount']) {
            $discount = round((($first_source['original_price'] - $first_source['fee_amount']) / $first_source['original_price']) * 100);
            $first_source['discount_percent'] = $discount;
            $first_source['has_discount'] = true;
            $first_source['original_price_text'] = number_format($first_source['original_price']) . ' VNĐ';
        } else {
            $first_source['has_discount'] = false;
        }

        // Add rating (mock data for now)
        $first_source['rating'] = rand(40, 50) / 10;
        $first_source['total_sold'] = rand(50, 500);

        $xtpl->assign('SHOWCASE', $first_source);

        if (!empty($first_source['image_url']) && $first_source['image_url'] != NV_BASE_SITEURL . 'themes/default/images/no_image.gif') {
            $xtpl->parse('main.hero_showcase.has_image');
        } else {
            $xtpl->parse('main.hero_showcase.no_image');
        }

        if ($first_source['has_discount']) {
            $xtpl->parse('main.hero_showcase.has_tags');
        }

        $xtpl->parse('main.hero_showcase');
    }

    // Popular sources loop với AOS delay
    $source_index = 0;
    foreach ($array_popular_sources as $source) {
        if ($source['fee_type'] != 'free' && !empty($source['original_price']) && $source['original_price'] > $source['fee_amount']) {
            $discount = round((($source['original_price'] - $source['fee_amount']) / $source['original_price']) * 100);
            $source['discount_percent'] = $discount;
            $source['has_discount'] = true;
            $source['original_price_text'] = number_format($source['original_price']) . ' VNĐ';
        } else {
            $source['has_discount'] = false;
        }

        // Add rating (mock data for now)
        $source['rating'] = rand(40, 50) / 10;
        $source['total_sold'] = rand(50, 500);

        $source['aos_delay'] = 200 + ($source_index * 50);

        $xtpl->assign('SOURCE', $source);
        $source_index++;
        
        if ($source['has_discount']) {
            $xtpl->parse('main.popular_sources.source.discount');
            $xtpl->parse('main.popular_sources.source.original_price');
        }
        
        if (!empty($source['image_url']) && $source['image_url'] != NV_BASE_SITEURL . 'themes/default/images/no_image.jpg') {
            $xtpl->parse('main.popular_sources.source.has_image');
        } else {
            $xtpl->parse('main.popular_sources.source.no_image');
        }
        
        $xtpl->parse('main.popular_sources.source');
    }
    $xtpl->parse('main.popular_sources');

    // Latest products section - 8 sản phẩm mới nhất với AOS delay
    if (!empty($array_latest_sources)) {
        $latest_index = 0;
        foreach ($array_latest_sources as $source) {
            // Tính toán AOS delay cho latest sources: 280ms, 310ms, 340ms, 370ms
            $source['aos_delay'] = 280 + ($latest_index * 30);
            $xtpl->assign('LATEST_SOURCE', $source);
            $latest_index++;

            // Check for discount
            if (!empty($source['discount_percent']) && $source['discount_percent'] > 0) {
                $xtpl->parse('main.latest_section.latest_source.discount');
            }

            // Check for original price
            if (!empty($source['original_price_text'])) {
                $xtpl->parse('main.latest_section.latest_source.original_price');
            }

            // Check for image
            if (!empty($source['image_url']) && $source['image_url'] != NV_BASE_SITEURL . 'themes/default/images/no_image.gif') {
                $xtpl->parse('main.latest_section.latest_source.has_image');
            } else {
                $xtpl->parse('main.latest_section.latest_source.no_image');
            }

            $xtpl->parse('main.latest_section.latest_source');
        }
        $xtpl->parse('main.latest_section');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}
