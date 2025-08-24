<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

/**
 * nv_theme_sharecode_list_view()
 * Render trang danh sách và tìm kiếm
 *
 * @param array $sources
 * @param array $categories
 * @param string $q
 * @param int $category
 * @param string $price_filter
 * @param string $sort
 * @param int $total_sources
 * @param string $pagination
 * @param string $base_url
 * @return string
 */
function nv_theme_sharecode_list_view($sources, $categories, $q, $category, $price_filter, $sort, $total_sources, $pagination, $base_url)
{
    global $module_file, $global_config, $lang_module, $module_name;

    $xtpl = new XTemplate('main.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('SEARCH_KEY', $q);
    $xtpl->assign('TOTAL_SOURCES', $total_sources);
    $xtpl->assign('PAGINATION', $pagination);
    $xtpl->assign('BASE_URL', $base_url);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);

    // Sort options
    $sort_options = [
        'latest' => 'Mới nhất',
        'popular' => 'Phổ biến',
        'name' => 'Tên A-Z',
        'rating' => 'Đánh giá cao'
    ];
    
    foreach ($sort_options as $key => $label) {
        $selected = ($sort == $key) ? 'selected="selected"' : '';
        $xtpl->assign('SORT', [
            'key' => $key,
            'label' => $label,
            'selected' => $selected
        ]);
        $xtpl->parse('main.sort_option');
    }

    // Categories for filter
    $xtpl->assign('CATEGORY', [
        'id' => 0,
        'title' => 'Tất cả danh mục',
        'selected' => ($category == 0) ? 'selected="selected"' : ''
    ]);
    $xtpl->parse('main.category_option');
    
    foreach ($categories as $cat) {
        $xtpl->assign('CATEGORY', $cat);
        $xtpl->parse('main.category_option');
    }

    // Price filter
    $price_filters = [
        '' => 'Tất cả',
        'free' => 'Miễn phí',
        'paid' => 'Có phí'
    ];
    
    foreach ($price_filters as $key => $label) {
        $checked = ($price_filter == $key) ? 'checked="checked"' : '';
        $xtpl->assign('PRICE_FILTER', [
            'key' => $key,
            'label' => $label,
            'checked' => $checked
        ]);
        $xtpl->parse('main.price_filter_option');
    }

    // Sources
    if (!empty($sources)) {
        foreach ($sources as $source) {
            $xtpl->assign('SOURCE', $source);
            $xtpl->parse('main.sources.source');
        }
        $xtpl->parse('main.sources');
    } else {
        $xtpl->parse('main.no_results');
    }

    // Pagination
    if (!empty($pagination)) {
        $xtpl->parse('main.pagination');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_detail()
 * Render trang chi tiết mã nguồn
 *
 * @param array $source
 * @param array $category
 * @param array $tags
 * @param array $reviews
 * @param float $avg_rating
 * @param int $total_reviews
 * @param array $related_sources
 * @param bool $can_download
 * @return string
 */
function nv_theme_sharecode_detail($source, $category, $tags, $reviews, $avg_rating, $total_reviews, $related_sources, $can_download)
{
    global $module_file, $global_config, $lang_module, $module_name, $user_info;

    $xtpl = new XTemplate('detail.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('SOURCE', $source);
    $xtpl->assign('CATEGORY', $category);
    $xtpl->assign('AVG_RATING', $avg_rating);
    $xtpl->assign('TOTAL_REVIEWS', $total_reviews);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);

    // Download button
    if ($can_download) {
        $xtpl->parse('main.can_download');
    } else {
        if ($source['fee_type'] == 'paid' && $user_info['userid'] == 0) {
            $xtpl->parse('main.need_login');
        } else {
            $xtpl->parse('main.cannot_download');
        }
    }

    // Demo link
    if (!empty($source['demo_link'])) {
        $xtpl->assign('DEMO_LINK', $source['demo_link']);
        $xtpl->parse('main.demo_link');
    }

    // Price display
    if ($source['fee_type'] == 'free') {
        $xtpl->parse('main.free_price');
    } else {
        $xtpl->parse('main.paid_price');
    }

    // Tags
    if (!empty($tags)) {
        foreach ($tags as $tag) {
            $tag['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=tag&amp;t=' . urlencode($tag['name']);

            $xtpl->assign('TAG', $tag);
            $xtpl->parse('main.tags.tag');
        }
        $xtpl->parse('main.tags');
    }

    // Reviews
    if (!empty($reviews)) {
        foreach ($reviews as $review) {
            $xtpl->assign('REVIEW', $review);
            $xtpl->parse('main.reviews.review');
        }
        $xtpl->parse('main.reviews');
    }

    // Related sources
    if (!empty($related_sources)) {
        foreach ($related_sources as $related) {
            $xtpl->assign('RELATED', $related);
            $xtpl->parse('main.related_sources.related');
        }
        $xtpl->parse('main.related_sources');
    }

    // Thêm modal thanh toán
    if (!empty($user_info)) {
        // User đã đăng nhập - hiển thị modal thanh toán
        $xtpl->assign('PAYMENT_MODAL', [
            'source_title' => $source['title'],
            'source_price' => number_format($source['fee_amount']),
            'source_id' => $source['id'],
            'is_free' => $source['fee_type'] == 'free',
            'user_balance' => isset($source['user_balance']) ? $source['user_balance'] : null,
            'can_purchase' => isset($source['can_purchase']) ? $source['can_purchase'] : false,
            'insufficient_funds' => isset($source['insufficient_funds_notice']) ? $source['insufficient_funds_notice'] : '',
            'purchase_notice' => isset($source['purchase_notice']) ? $source['purchase_notice'] : ''
        ]);
        $xtpl->parse('main.payment_modal');
    } else {
        // User chưa đăng nhập - yêu cầu đăng nhập
        $xtpl->parse('main.login_required');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_home_main()
 * Theme function for home module's ShareCode display
 *
 * @param array $array_catpage News articles  
 * @param array $array_data Latest ShareCode sources
 * @param string $link_more Link to more sources
 * @param array $array_plans ShareCode categories
 * @param array $array_stats ShareCode statistics
 * @param array $array_popular_sources Popular ShareCode sources
 * @return string
 */
function nv_theme_home_main($array_catpage, $array_data, $link_more, $array_plans, $array_stats, $array_popular_sources)
{
    global $module_file, $global_config, $lang_module, $module_name;

    // Use ShareCode module's main template
    $xtpl = new XTemplate('main.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/sharecode');

    $xtpl->assign('MODULE_NAME', 'sharecode');
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('NV_OP_VARIABLE', NV_OP_VARIABLE);

    // Assign statistics
    $xtpl->assign('STATS', $array_stats);

    // Latest sources
    if (!empty($array_data)) {
        foreach ($array_data as $source) {
            $xtpl->assign('SOURCE', $source);
            $xtpl->parse('main.latest_sources.source');
        }
        $xtpl->parse('main.latest_sources');
    }

    // Popular sources
    if (!empty($array_popular_sources)) {
        foreach ($array_popular_sources as $source) {
            $xtpl->assign('SOURCE', $source);
            $xtpl->parse('main.popular_sources.source');
        }
        $xtpl->parse('main.popular_sources');
    }

    // Categories
    if (!empty($array_plans)) {
        foreach ($array_plans as $category) {
            $xtpl->assign('CATEGORY', $category);
            $xtpl->parse('main.categories.category');
        }
        $xtpl->parse('main.categories');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_main()
 * Render trang chủ module
 *
 * @param array $stats
 * @param array $popular_tags
 * @return string
 */
function nv_theme_sharecode_main($stats = [], $popular_tags = [])
{
    global $module_file, $global_config, $lang_module, $module_name;

    $xtpl = new XTemplate('main.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);

    // Stats
    $xtpl->assign('TOTAL_SOURCES', isset($stats['total_sources']) ? number_format($stats['total_sources']) : '0');
    $xtpl->assign('TOTAL_DOWNLOADS', isset($stats['total_downloads']) ? number_format($stats['total_downloads']) : '0');
    $xtpl->assign('TOTAL_USERS', isset($stats['total_users']) ? number_format($stats['total_users']) : '0');

    // Popular tags
    if (!empty($popular_tags)) {
        foreach ($popular_tags as $tag) {
            $tag['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=tag&amp;t=' . $tag['alias'];

            $xtpl->assign('TAG', $tag);
            $xtpl->parse('main.popular_tags.tag');
        }
        $xtpl->parse('main.popular_tags');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_category_view()
 * Render trang danh sách theo danh mục
 */
function nv_theme_sharecode_category_view($category, $sources, $total_sources, $generate_page, $base_url, $sort_links = [], $subcategories = [])
{
    global $module_file, $global_config, $lang_module, $module_name;

    $xtpl = new XTemplate('category.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('CATEGORY', $category);
    $xtpl->assign('SOURCES', $sources);
    $xtpl->assign('TOTAL_SOURCES', number_format($total_sources));
    $xtpl->assign('GENERATE_PAGE', $generate_page);
    $xtpl->assign('BASE_URL', $base_url);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);

    // Sources
    if (!empty($sources)) {
        foreach ($sources as $source) {
            $xtpl->assign('SOURCE', $source);

            // Price display
            if (isset($source['fee_type']) && $source['fee_type'] == 'free') {
                $xtpl->parse('main.sources.source.free_price');
            } else {
                $xtpl->parse('main.sources.source.paid_price');
            }

            // Rating
            if (isset($source['avg_rating']) && $source['avg_rating'] > 0) {
                $xtpl->parse('main.sources.source.rating');
            }

            $xtpl->parse('main.sources.source');
        }
        $xtpl->parse('main.sources');
    } else {
        $xtpl->parse('main.no_sources');
    }

    // Sort links
    if (!empty($sort_links)) {
        foreach ($sort_links as $sort_key => $sort_data) {
            $xtpl->assign('SORT', $sort_data);
            if ($sort_data['active']) {
                $xtpl->parse('main.sort_links.sort.active');
            } else {
                $xtpl->parse('main.sort_links.sort.inactive');
            }
            $xtpl->parse('main.sort_links.sort');
        }
        $xtpl->parse('main.sort_links');
    }

    // Pagination
    if (!empty($generate_page)) {
        $xtpl->parse('main.pagination');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_category()
 * Render trang danh mục mã nguồn
 */
function nv_theme_sharecode_category($category, $sources, $subcategories, $sort_links, $current_sort, $generate_page, $total_sources)
{
    global $module_file, $global_config, $lang_module, $module_name;

    $xtpl = new XTemplate('category.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('CATEGORY', $category);
    $xtpl->assign('TOTAL_SOURCES', number_format($total_sources));
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);

    // Subcategories
    if (!empty($subcategories)) {
        foreach ($subcategories as $subcat) {
            $xtpl->assign('SUBCAT', $subcat);
            $xtpl->parse('main.subcategories.subcat');
        }
        $xtpl->parse('main.subcategories');
    }

    // Sort links
    foreach ($sort_links as $sort_key => $sort_data) {
        $xtpl->assign('SORT', $sort_data);
        if ($sort_data['active']) {
            $xtpl->parse('main.sort_links.sort.active');
        } else {
            $xtpl->parse('main.sort_links.sort.inactive');
        }
        $xtpl->parse('main.sort_links.sort');
    }
    $xtpl->parse('main.sort_links');

    // Sources
    if (!empty($sources)) {
        foreach ($sources as $source) {
            $xtpl->assign('SOURCE', $source);
            
            // Price display
            if ($source['fee_type'] == 'free') {
                $xtpl->parse('main.sources.source.free_price');
            } else {
                $xtpl->parse('main.sources.source.paid_price');
            }
            
            // Rating
            if ($source['avg_rating'] > 0) {
                $xtpl->parse('main.sources.source.rating');
            }
            
            $xtpl->parse('main.sources.source');
        }
        $xtpl->parse('main.sources');
    } else {
        $xtpl->parse('main.no_sources');
    }

    // Pagination
    if (!empty($generate_page)) {
        $xtpl->assign('GENERATE_PAGE', $generate_page);
        $xtpl->parse('main.pagination');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_tag()
 * Render trang tag mã nguồn
 */
function nv_theme_sharecode_tag($tag, $sources, $related_tags, $sort_links, $current_sort, $generate_page, $total_sources)
{
    global $module_file, $global_config, $lang_module, $module_name;

    $xtpl = new XTemplate('tag.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('TAG', $tag);
    $xtpl->assign('TOTAL_SOURCES', number_format($total_sources));
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);

    // Related tags
    if (!empty($related_tags)) {
        foreach ($related_tags as $related_tag) {
            $xtpl->assign('RELATED_TAG', $related_tag);
            $xtpl->parse('main.related_tags.tag');
        }
        $xtpl->parse('main.related_tags');
    }

    // Sort links
    foreach ($sort_links as $sort_key => $sort_data) {
        $xtpl->assign('SORT', $sort_data);
        if ($sort_data['active']) {
            $xtpl->parse('main.sort_links.sort.active');
        }
        $xtpl->parse('main.sort_links.sort');
    }
    $xtpl->parse('main.sort_links');

    // Sources
    if (!empty($sources)) {
        foreach ($sources as $source) {
            $xtpl->assign('SOURCE', $source);
            
            // Price display
            if ($source['fee_type'] == 'free') {
                $xtpl->parse('main.sources.source.free_price');
            } else {
                $xtpl->parse('main.sources.source.paid_price');
            }
            
            // Rating
            if ($source['avg_rating'] > 0) {
                $xtpl->parse('main.sources.source.rating');
            }
            
            $xtpl->parse('main.sources.source');
        }
        $xtpl->parse('main.sources');
    } else {
        $xtpl->parse('main.no_sources');
    }

    // Pagination
    if (!empty($generate_page)) {
        $xtpl->assign('GENERATE_PAGE', $generate_page);
        $xtpl->parse('main.pagination');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_download()
 * Render trang download confirmation
 */
function nv_theme_sharecode_download($source, $download_url, $download_type, $category_title, $tags, $file_size)
{
    global $module_file, $global_config, $lang_module, $module_name, $module_upload;

    $xtpl = new XTemplate('download.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('DOWNLOAD_URL', $download_url);
    $xtpl->assign('DOWNLOAD_TYPE', $download_type);
    $xtpl->assign('CATEGORY_TITLE', $category_title);
    $xtpl->assign('FILE_SIZE', $file_size);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);

    // Format data
    $source['add_time_format'] = date('d/m/Y H:i', $source['add_time']);
    $source['price_text'] = $source['fee_type'] == 'free' ? 'Miễn phí' : number_format($source['fee_amount']) . ' VNĐ';
    
    // Image
    if (!empty($source['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $source['image'])) {
        $source['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $source['image'];
    } else {
        $source['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no-image.png';
    }
    
    $xtpl->assign('SOURCE', $source);

    // Download type
    if ($download_type == 'free') {
        $xtpl->parse('main.free_download');
    } else {
        $xtpl->parse('main.purchased_download');
    }

    // Tags
    if (!empty($tags)) {
        foreach ($tags as $tag) {
            $xtpl->assign('TAG_NAME', $tag);
            $xtpl->parse('main.tags.tag');
        }
        $xtpl->parse('main.tags');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_cart()
 * Render trang giỏ hàng
 */
function nv_theme_sharecode_cart($cart_items = [], $total_amount = 0)
{
    global $module_file, $global_config, $lang_module, $module_name;

    $xtpl = new XTemplate("cart.tpl", NV_ROOTDIR . "/themes/" . $global_config["site_theme"] . "/modules/" . $module_file);

    $xtpl->assign("LANG", $lang_module);
    $xtpl->assign("MODULE_NAME", $module_name);
    $xtpl->assign("NV_LANG_VARIABLE", NV_LANG_VARIABLE);
    $xtpl->assign("NV_LANG_DATA", NV_LANG_DATA);
    $xtpl->assign("NV_NAME_VARIABLE", NV_NAME_VARIABLE);
    $xtpl->assign("BASE_URL", NV_BASE_SITEURL);
    $xtpl->assign("MODULE_URL", NV_BASE_SITEURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name);

    $xtpl->parse("main");
    return $xtpl->text("main");
}

/**
 * nv_theme_sharecode_history()
 * Render trang lịch sử mua code
 *
 * @param array $purchases
 * @param string $generate_page
 * @param array $stats
 * @param int $total_purchases
 * @return string
 */
function nv_theme_sharecode_history($purchases, $generate_page, $stats, $total_purchases)
{
    global $module_file, $global_config, $lang_module, $module_name;

    $xtpl = new XTemplate('history.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);
    $xtpl->assign('MODULE_URL', NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name);
    
    // Statistics
    $xtpl->assign('STATS', $stats);
    $xtpl->assign('TOTAL_PURCHASES', $total_purchases);

    if (empty($purchases)) {
        $xtpl->parse('main.empty_list');
    } else {
        foreach ($purchases as $purchase) {
            $xtpl->assign('PURCHASE', $purchase);
            $xtpl->parse('main.purchase_list.purchase');
        }
        
        // Pagination
        if (!empty($generate_page)) {
            $xtpl->assign('PAGINATION', $generate_page);
            $xtpl->parse('main.purchase_list.pagination');
        }
        
        $xtpl->parse('main.purchase_list');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_author()
 * Theme function for author profile page
 */
function nv_theme_sharecode_author($author_info, $sources, $categories, $sort_options, $current_sort, $category_filter, $generate_page, $total_sources)
{
    global $module_file, $global_config, $lang_module, $module_name;

    $xtpl = new XTemplate('author.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('AUTHOR', $author_info);
    $xtpl->assign('TOTAL_SOURCES', number_format($total_sources));
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);

    // Categories filter
    foreach ($categories as $category) {
        $category['selected'] = ($category['id'] == $category_filter) ? 'selected' : '';
        $xtpl->assign('CATEGORY', $category);
        $xtpl->parse('main.category_filter');
    }

    // Sort options
    foreach ($sort_options as $sort_key => $sort_name) {
        $sort_data = [
            'key' => $sort_key,
            'name' => $sort_name,
            'active' => ($sort_key == $current_sort),
            'selected' => ($sort_key == $current_sort) ? 'selected' : ''
        ];
        $xtpl->assign('SORT', $sort_data);
        $xtpl->parse('main.sort_option');
    }

    // Author rating stars
    if ($author_info['avg_rating'] > 0) {
        $author_info['rating_stars'] = str_repeat('★', round($author_info['avg_rating'])) . str_repeat('☆', 5 - round($author_info['avg_rating']));
        $xtpl->assign('AUTHOR', $author_info);
        $xtpl->parse('main.has_rating');
    }

    // Sources list
    if (!empty($sources)) {
        foreach ($sources as $source) {
            $xtpl->assign('SOURCE', $source);
            
            // Price display
            if ($source['fee_type'] == 'free') {
                $xtpl->parse('main.sources.source.free_price');
            } else {
                $xtpl->parse('main.sources.source.paid_price');
            }
            
            // Rating
            if ($source['avg_rating'] > 0) {
                $xtpl->parse('main.sources.source.rating');
            }
            
            $xtpl->parse('main.sources.source');
        }
        $xtpl->parse('main.sources');
    } else {
        $xtpl->parse('main.no_sources');
    }

    // Pagination
    if (!empty($generate_page)) {
        $xtpl->assign('GENERATE_PAGE', $generate_page);
        $xtpl->parse('main.pagination');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_submit()
 * Theme function for submit page
 */
function nv_theme_sharecode_submit($categories, $available_keywords = [], $available_tags = [], $form_data = [], $errors = [])
{
    global $module_file, $lang_module, $module_name, $nv_Request, $global_config;

    $xtpl = new XTemplate('submit.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    // Use provided form data or get from request
    if (empty($form_data)) {
        $data = [
            'title' => $nv_Request->get_textarea('title', 'post', ''),
            'alias' => $nv_Request->get_title('alias', 'post', ''),
            'catid' => $nv_Request->get_int('catid', 'post', 0),
            'description' => $nv_Request->get_textarea('description', 'post', ''),
            'content' => $nv_Request->get_editor('content', 'post', ''),
            'demo_link' => $nv_Request->get_textarea('demo_link', 'post', ''),
            'external_source_link' => $nv_Request->get_textarea('external_source_link', 'post', ''),
            'fee_type' => $nv_Request->get_string('fee_type', 'post', 'free'),
            'fee_amount' => $nv_Request->get_float('fee_amount', 'post', 0),
            'keywords' => $nv_Request->get_textarea('keywords', 'post', ''),
            'tags' => $nv_Request->get_textarea('tags', 'post', ''),
            'download_link_type' => $nv_Request->get_string('download_link_type', 'post', 'external'),
            'download_link' => $nv_Request->get_textarea('download_link', 'post', ''),
            'contact_phone' => $nv_Request->get_title('contact_phone', 'post', ''),
            'contact_email' => $nv_Request->get_title('contact_email', 'post', ''),
            'contact_skype' => $nv_Request->get_title('contact_skype', 'post', ''),
            'contact_telegram' => $nv_Request->get_title('contact_telegram', 'post', ''),
            'contact_zalo' => $nv_Request->get_title('contact_zalo', 'post', ''),
            'contact_facebook' => $nv_Request->get_title('contact_facebook', 'post', ''),
            'contact_website' => $nv_Request->get_title('contact_website', 'post', ''),
            'contact_address' => $nv_Request->get_textarea('contact_address', 'post', '')
        ];
    } else {
        $data = $form_data;
    }

    $xtpl->assign('DATA', $data);

    // Handle errors
    if (!empty($errors)) {
        foreach ($errors as $error) {
            $xtpl->assign('ERROR', $error);
            $xtpl->parse('main.errors.error');
        }
        $xtpl->parse('main.errors');
    }

    // Categories
    foreach ($categories as $category) {
        $category['selected'] = ($category['id'] == $data['catid']) ? 'selected="selected"' : '';
        $xtpl->assign('CATEGORY', $category);
        $xtpl->parse('main.category');
    }

    // Available keywords for select2
    $keywords_json = json_encode($available_keywords);
    $xtpl->assign('AVAILABLE_KEYWORDS_JSON', $keywords_json);

    // Available tags for select2
    $tags_json = json_encode($available_tags);
    $xtpl->assign('AVAILABLE_TAGS_JSON', $tags_json);

    // Radio button checks
    $xtpl->assign('CHECKED_FREE', $data['fee_type'] == 'free' ? 'checked' : '');
    $xtpl->assign('CHECKED_PAID', $data['fee_type'] == 'paid' ? 'checked' : '');
    $xtpl->assign('CHECKED_FILE', $data['download_link_type'] == 'file' ? 'checked' : '');
    $xtpl->assign('CHECKED_EXTERNAL', $data['download_link_type'] == 'external' ? 'checked' : '');

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_favorites()
 * Hiển thị danh sách favorites
 *
 * @param array $favorites
 * @param string $generate_page
 * @param int $total_favorites
 * @return string
 */
function nv_theme_sharecode_favorites($favorites, $generate_page, $total_favorites)
{
    global $module_file, $lang_module, $module_name, $global_config;

    $xtpl = new XTemplate('favorites.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('TOTAL_FAVORITES', $total_favorites);

    if (!empty($favorites)) {
        foreach ($favorites as $item) {
            $xtpl->assign('ITEM', $item);
            $xtpl->parse('main.favorites.item');
        }
        $xtpl->parse('main.favorites');
        
        if (!empty($generate_page)) {
            $xtpl->assign('PAGINATION', $generate_page);
            $xtpl->parse('main.pagination');
        }
    } else {
        $xtpl->parse('main.no_favorites');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_notifications()
 * Hiển thị danh sách notifications
 *
 * @param array $notifications
 * @param string $generate_page
 * @param int $total_notifications
 * @param int $unread_count
 * @return string
 */
function nv_theme_sharecode_notifications($notifications, $generate_page, $total_notifications, $unread_count)
{
    global $module_file, $lang_module, $module_name, $global_config;

    $xtpl = new XTemplate('notifications.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('TOTAL_NOTIFICATIONS', $total_notifications);
    $xtpl->assign('UNREAD_COUNT', $unread_count);

    if (!empty($notifications)) {
        foreach ($notifications as $item) {
            $xtpl->assign('ITEM', $item);
            $xtpl->parse('main.notifications.item');
        }
        $xtpl->parse('main.notifications');
        
        if (!empty($generate_page)) {
            $xtpl->assign('PAGINATION', $generate_page);
            $xtpl->parse('main.pagination');
        }
        
        if ($unread_count > 0) {
            $xtpl->parse('main.mark_all_read');
        }
    } else {
        $xtpl->parse('main.no_notifications');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}

/**
 * nv_theme_sharecode_dashboard()
 * Hiển thị bảng điều khiển user
 *
 * @param array $stats
 * @param array $recent_sources
 * @param array $recent_reviews
 * @param array $user_info
 * @return string
 */
function nv_theme_sharecode_dashboard($stats, $recent_sources, $recent_reviews, $user_info)
{
    global $module_file, $lang_module, $module_name, $global_config;

    $xtpl = new XTemplate('dashboard.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('STATS', $stats);
    $xtpl->assign('USER', $user_info);

    // Recent sources
    if (!empty($recent_sources)) {
        foreach ($recent_sources as $source) {
            $xtpl->assign('SOURCE', $source);
            $xtpl->parse('main.recent_sources.source');
        }
        $xtpl->parse('main.recent_sources');
    } else {
        $xtpl->parse('main.no_recent_sources');
    }

    // Recent reviews
    if (!empty($recent_reviews)) {
        foreach ($recent_reviews as $review) {
            $xtpl->assign('REVIEW', $review);
            $xtpl->parse('main.recent_reviews.review');
        }
        $xtpl->parse('main.recent_reviews');
    } else {
        $xtpl->parse('main.no_recent_reviews');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}