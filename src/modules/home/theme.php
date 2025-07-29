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
 * @param mixed $array_data
 * @return
 */
function nv_theme_home_main($array_catpage, $array_data, $link_more, $array_plans, $array_stats, $array_popular_sources)
{
    global $op, $module_file, $module_info, $global_config, $nv_Lang;

    $xtpl = new XTemplate($op . '.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
    $xtpl->assign('LANG', \NukeViet\Core\Language::$lang_module);
    $xtpl->assign('THEMES', $module_info['template']);
    $xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);
    
    // Assign statistics data
    $xtpl->assign('STATS', $array_stats);
    $xtpl->assign('LINK_MORE', $link_more);
    
    // Add "All" category first
    $all_category = array(
        'title' => 'Tất cả',
        'total_sources' => $array_stats['total_sources'],
        'link' => $link_more,
        'is_active' => true
    );
    $xtpl->assign('CATEGORY', $all_category);
    $xtpl->parse('main.categories.category');
    
    // Categories loop - limit to 5 more categories (total 6 for one row)
    $count = 0;
    foreach ($array_plans as $category) {
        if ($count >= 5) break; // Limit to 5 more categories
        $category['is_active'] = false;
        $xtpl->assign('CATEGORY', $category);
        $xtpl->parse('main.categories.category');
        $count++;
    }
    $xtpl->parse('main.categories');
    
    // Popular sources loop  
    foreach ($array_popular_sources as $source) {
        // Calculate discount percentage
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
        
        $xtpl->assign('SOURCE', $source);
        
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

    $xtpl->parse('main');
    return $xtpl->text('main');
}
