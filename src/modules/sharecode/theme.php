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
 * @param array $author_info
 * @param array $demo_images
 * @param bool $already_purchased
 * @param bool $need_login
 * @param bool $need_contact
 * @param array $user_balance_data
 * @param float $balance_after
 * @param string $balance_after_class
 * @param bool $can_pay
 * @param bool $need_topup
 * @param array $rating_breakdown
 * @param bool $can_review
 * @param bool $need_login_review
 * @param array $comments
 * @param int $total_comments
 * @param bool $can_comment
 * @param bool $need_login_comment
 * @return string
 */
function nv_theme_sharecode_detail($source, $category, $tags, $reviews, $avg_rating, $total_reviews, $related_sources, $can_download, $author_info = [], $demo_images = [], $already_purchased = false, $need_login = false, $need_contact = false, $user_balance_data = null, $balance_after = 0, $balance_after_class = 'text-success', $can_pay = false, $need_topup = false, $rating_breakdown = [], $can_review = false, $need_login_review = false, $comments = [], $total_comments = 0, $can_comment = false, $need_login_comment = false, $is_admin = false, $is_author = false)
{
    global $module_file, $global_config, $lang_module, $module_name, $user_info;

    $xtpl = new XTemplate('detail.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('SOURCE', $source);
    $xtpl->assign('CATEGORY', $category);
    $xtpl->assign('AUTHOR', $author_info);
    $xtpl->assign('AVG_RATING', $avg_rating);
    $xtpl->assign('TOTAL_REVIEWS', $total_reviews);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);

    // History URL để redirect sau khi thanh toán
    if (defined('NV_IS_USER')) {
        $history_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=history&userid=' . $user_info['userid'];
    } else {
        $history_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name;
    }
    $xtpl->assign('HISTORY_URL', $history_url);

    // Xử lý giá
    if ($source['fee_type'] == 'free') {
        $xtpl->parse('main.free_price');
    } elseif ($source['fee_type'] == 'contact') {
        $xtpl->parse('main.contact_price');
    } else {
        $xtpl->parse('main.paid_price');
    }

    // Xử lý hiển thị link mã nguồn - chỉ hiện khi đã mua
    if ($already_purchased && !empty($source['external_source_link'])) {
        $xtpl->parse('main.source_link_purchased');
    }

    // Xử lý hiển thị giá khi có phí
    if ($source['fee_type'] == 'paid' && $source['fee_amount'] > 0) {
        $xtpl->parse('main.has_fee_amount');
    }

    // Xử lý demo images
    if (!empty($demo_images)) {
        foreach ($demo_images as $demo_img) {
            $xtpl->assign('DEMO_IMAGE', $demo_img);
            $xtpl->parse('main.demo_images.demo_image');
        }
        $xtpl->parse('main.demo_images');
    }

    // Xử lý quyền download - Sử dụng block names riêng biệt để tránh duplicate content
    if ($already_purchased) {
        // Hiển thị thông báo đặc biệt cho tác giả và admin
        if ($is_author) {
            $xtpl->assign('SPECIAL_MESSAGE', 'Bạn là tác giả của mã nguồn này');
            $xtpl->parse('main.special_messages.author_message');
        } elseif ($is_admin) {
            $xtpl->assign('SPECIAL_MESSAGE', 'Bạn có quyền admin - tải xuống miễn phí');
            $xtpl->parse('main.special_messages.admin_message');
        }

        // Parse special messages block nếu có thông báo
        if ($is_author || $is_admin) {
            $xtpl->parse('main.special_messages');
        }

        // Hiển thị nút download riêng biệt
        $xtpl->parse('main.download_button');
    } elseif ($need_login) {
        $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login';
        $xtpl->assign('LOGIN_URL', $login_url);
        $xtpl->parse('main.need_login');
    } elseif ($need_contact) {
        // Contact information will be handled by JavaScript modalShow
        $xtpl->parse('main.need_contact');
    } else {
        $xtpl->parse('main.can_download');
    }

    // Chuẩn bị dữ liệu cho nút yêu thích - chỉ hiển thị khi user đã đăng nhập
    if (defined('NV_IS_USER')) {
        $is_favorite = false;
        if (function_exists('nv_sharecode_is_favorite')) {
            $is_favorite = nv_sharecode_is_favorite($source['id'], $user_info['userid']);
        }
        $favorite_action = $is_favorite ? 'remove' : 'add';
        $favorite_text = $is_favorite ? 'Xóa khỏi yêu thích' : 'Thêm vào yêu thích';
        $favorite_class = $is_favorite ? 'btn-danger' : 'btn-danger';
        $favorite_icon = $is_favorite ? 'fa-heart' : 'fa-heart-o';

        $favorite_data = [
            'is_favorite' => $is_favorite,
            'action' => $favorite_action,
            'text' => $favorite_text,
            'class' => $favorite_class,
            'icon' => $favorite_icon,
            'source_id' => $source['id'],
            'checkss' => md5($source['id'] . '_' . $favorite_action . '_' . NV_CHECK_SESSION . '_' . $user_info['userid']),
            'ajax_url' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=favorites'
        ];

        $xtpl->assign('FAVORITE', $favorite_data);
        $xtpl->parse('main.favorite_button');
    }

    // Chuẩn bị data cho modal
    if ($source['fee_type'] == 'free') {
        $xtpl->parse('main.free_modal');
    } elseif ($source['fee_type'] == 'contact') {
        $xtpl->parse('main.contact_modal');
    } else {
        $xtpl->parse('main.paid_modal');
    }

    if ($user_balance_data !== null && is_array($user_balance_data)) {
        $current_balance = isset($user_balance_data['balance']) ? floatval($user_balance_data['balance']) : 0;
        $xtpl->assign('USER_BALANCE', number_format($current_balance, 0, '.', ','));
        $xtpl->assign('BALANCE_AFTER', number_format($balance_after, 0, '.', ','));
        $xtpl->assign('BALANCE_AFTER_CLASS', $balance_after_class);
        $xtpl->parse('main.user_balance');
    }

    if ($need_topup) {
        $topup_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=wallet&' . NV_OP_VARIABLE . '=recharge';
        $xtpl->assign('TOPUP_URL', $topup_url);
        $xtpl->parse('main.need_topup');
        $xtpl->parse('main.insufficient_balance');
    } elseif ($can_pay) {
        $xtpl->parse('main.can_pay');
    }

    // Xử lý tags
    if (!empty($tags)) {
        foreach ($tags as $tag) {
            $xtpl->assign('TAG', $tag);
            $xtpl->parse('main.tags.tag');
        }
        $xtpl->parse('main.tags');
    }

    // Xử lý reviews section
    if ($total_reviews > 0) {
        $xtpl->assign('TOTAL_REVIEWS', $total_reviews);
        $xtpl->assign('AVG_RATING', $avg_rating);
        $rating_stars = max(0, min(5, round(floatval($avg_rating))));
        $xtpl->assign('AVG_RATING_STARS', str_repeat('★', $rating_stars) . str_repeat('☆', 5 - $rating_stars));

        // Rating breakdown
        if (!empty($rating_breakdown)) {
            for ($i = 5; $i >= 1; $i--) {
                $xtpl->assign('RATING_' . $i . '_COUNT', isset($rating_breakdown[$i]['count']) ? $rating_breakdown[$i]['count'] : 0);
                $xtpl->assign('RATING_' . $i . '_PERCENT', isset($rating_breakdown[$i]['percent']) ? $rating_breakdown[$i]['percent'] : 0);
            }
        }

        // Hiển thị rating trong hero
        $xtpl->parse('main.has_reviews');
        $xtpl->parse('main.reviews_summary');
    } else {
        // Hiển thị "chưa có đánh giá" trong hero
        $xtpl->parse('main.no_reviews_hero');
    }

    // Form đánh giá
    if ($can_review) {
        $xtpl->parse('main.can_review');
    } elseif ($need_login_review) {
        $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login';
        $xtpl->assign('LOGIN_URL', $login_url);
        $xtpl->parse('main.need_login_review');
    }

    if (!empty($reviews)) {
        foreach ($reviews as $review) {
            $xtpl->assign('REVIEW', $review);

            // Xử lý admin reply block
            if ($review['has_admin_reply']) {
                $xtpl->parse('main.reviews_list.review.has_admin_reply');

                // Nếu là admin, cho phép sửa reply
                if ($is_admin) {
                    $xtpl->parse('main.reviews_list.review.has_admin_reply.is_admin');
                }
            }

            // Admin form reply - chỉ hiển thị cho admin
            if ($is_admin) {
                // Nếu chưa có admin reply, hiển thị nút "Trả lời"
                if (!$review['has_admin_reply']) {
                    $xtpl->parse('main.reviews_list.review.is_admin.no_admin_reply');
                }

                // Luôn hiển thị form reply cho admin (ẩn bằng CSS)
                $xtpl->parse('main.reviews_list.review.is_admin');
            }

            $xtpl->parse('main.reviews_list.review');
        }
        $xtpl->parse('main.reviews_list');
    } else {
        $xtpl->parse('main.no_reviews');
    }

    $xtpl->assign('TOTAL_COMMENTS', $total_comments);

    if ($can_comment) {
        $xtpl->parse('main.can_comment');
    } elseif ($need_login_comment) {
        $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login';
        $xtpl->assign('LOGIN_URL', $login_url);
        $xtpl->parse('main.need_login_comment');
    }

    // Danh sách comments
    if (!empty($comments)) {
        foreach ($comments as $comment) {
            // Kiểm tra có thể trả lời comment này không
            // Admin có thể reply tất cả comment, User có thể reply comment không phải của mình
            $comment['can_reply'] = false;
            if ($is_admin) {
                // Admin có thể reply tất cả comment
                $comment['can_reply'] = true;
            } elseif ($can_comment && defined('NV_IS_USER')) {
                // User có thể reply comment không phải của mình
                $comment['can_reply'] = ($comment['userid'] != $user_info['userid']);
            }

            $comment['is_own_comment'] = defined('NV_IS_USER') && $comment['userid'] == $user_info['userid'];
            $xtpl->assign('COMMENT', $comment);

            // Hiển thị badge "Bạn" nếu là comment của user hiện tại
            if ($comment['is_own_comment']) {
                $xtpl->parse('main.comments_list.comment.is_own_comment');
            }

            // Hiển thị badge "Admin" nếu là comment của admin
            if (!empty($comment['is_admin_comment'])) {
                $xtpl->parse('main.comments_list.comment.is_admin_comment');
            }

            // Hiển thị nút reply nếu có thể trả lời
            if ($comment['can_reply']) {
                $xtpl->parse('main.comments_list.comment.can_reply_comment');
            }

            // Hiển thị admin reply nếu có
            if ($comment['has_admin_reply']) {
                if (!empty($comment['admin_reply_username'])) {
                    $xtpl->parse('main.comments_list.comment.has_admin_reply.admin_name');
                }
                $xtpl->parse('main.comments_list.comment.has_admin_reply');
            }

            // Xử lý replies
            if (!empty($comment['replies'])) {
                foreach ($comment['replies'] as $reply) {
                    // Kiểm tra có thể trả lời reply này không
                    $reply['can_reply'] = false;
                    if ($is_admin) {
                        // Admin có thể reply tất cả
                        $reply['can_reply'] = true;
                    } elseif ($can_comment && defined('NV_IS_USER')) {
                        // User có thể reply reply không phải của mình
                        $reply['can_reply'] = ($reply['userid'] != $user_info['userid']);
                    }

                    $reply['is_own_comment'] = defined('NV_IS_USER') && $reply['userid'] == $user_info['userid'];
                    $xtpl->assign('REPLY', $reply);

                    // Hiển thị badge "Bạn" nếu là reply của user hiện tại
                    if ($reply['is_own_comment']) {
                        $xtpl->parse('main.comments_list.comment.replies.reply.is_own_comment');
                    }

                    // Hiển thị badge "Admin" nếu là reply của admin
                    if (!empty($reply['is_admin_comment'])) {
                        $xtpl->parse('main.comments_list.comment.replies.reply.is_admin_comment');
                    }

                    // Hiển thị nút reply cho reply nếu có thể trả lời
                    if ($reply['can_reply']) {
                        $xtpl->parse('main.comments_list.comment.replies.reply.can_reply_reply');
                    }

                    // Hiển thị admin reply cho reply nếu có
                    if ($reply['has_admin_reply']) {
                        if (!empty($reply['admin_reply_username'])) {
                            $xtpl->parse('main.comments_list.comment.replies.reply.has_admin_reply.admin_name');
                        }
                        $xtpl->parse('main.comments_list.comment.replies.reply.has_admin_reply');
                    }

                    $xtpl->parse('main.comments_list.comment.replies.reply');
                }
                $xtpl->parse('main.comments_list.comment.replies');
            }

            // Reply forms are now handled by JavaScript

            $xtpl->parse('main.comments_list.comment');
        }
        $xtpl->parse('main.comments_list');
    } else {
        $xtpl->parse('main.no_comments');
    }

    // Xử lý related sources
    if (!empty($related_sources)) {
        foreach ($related_sources as $related) {
            $xtpl->assign('RELATED', $related);
            $xtpl->parse('main.related_sources.related');
        }
        $xtpl->parse('main.related_sources');
    }

    // Demo link
    if (!empty($source['demo_link'])) {
        $xtpl->assign('DEMO_LINK', $source['demo_link']);
        $xtpl->parse('main.demo_link');
    }

    // Admin features
    if ($is_admin) {
        $xtpl->parse('main.is_admin');
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
    $xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);

    // Category description
    if (!empty($category['description'])) {
        $xtpl->parse('main.category_description');
    }

    // Subcategories
    if (!empty($subcategories)) {
        foreach ($subcategories as $subcat) {
            $xtpl->assign('SUBCAT', $subcat);
            $xtpl->parse('main.subcategories.subcat');
        }
        $xtpl->parse('main.subcategories');
    }

    // Sources
    if (!empty($sources)) {
        foreach ($sources as $source) {
            $xtpl->assign('SOURCE', $source);

            // Price badge display (chỉ badge, không có actions)
            if (isset($source['is_free']) && $source['is_free']) {
                $xtpl->parse('main.sources.source.badge_free');
            } elseif (isset($source['is_contact']) && $source['is_contact']) {
                $xtpl->parse('main.sources.source.badge_contact');
            } elseif (isset($source['is_paid']) && $source['is_paid']) {
                $xtpl->parse('main.sources.source.badge_paid');
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

    // Image - logic fallback: image > avatar > default
    // Database paths now include 'uploads/' prefix
    if (!empty($source['image']) && file_exists(NV_ROOTDIR . '/' . $source['image'])) {
        $source['image_url'] = NV_BASE_SITEURL . $source['image'];
    } elseif (!empty($source['avatar']) && file_exists(NV_ROOTDIR . '/' . $source['avatar'])) {
        $source['image_url'] = NV_BASE_SITEURL . $source['avatar'];
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
        $xtpl->parse('main.no_purchases');
    } else {
        foreach ($purchases as $purchase) {
            $xtpl->assign('PURCHASE', $purchase);
            $xtpl->parse('main.purchases.purchase');
        }
        $xtpl->parse('main.purchases');
    }

    // Pagination (outside purchases block)
    if (!empty($generate_page)) {
        $xtpl->assign('PAGINATION', $generate_page);
        $xtpl->parse('main.pagination');
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
    if (isset($author_info['avg_rating']) && $author_info['avg_rating'] > 0) {
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
            } elseif ($source['fee_type'] == 'paid') {
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
    global $module_file, $lang_module, $module_name, $nv_Request, $global_config, $module_upload, $module_data;

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

    // Format fee_amount using NukeViet number format
    if (isset($data['fee_amount']) && $data['fee_amount'] > 0) {
        $data['fee_amount_formatted'] = nv_number_format($data['fee_amount'], 0);
    } else {
        $data['fee_amount_formatted'] = '';
    }

    // Ensure module_upload is defined
    if (empty($module_upload)) {
        $module_upload = $module_data;
    }

    // Initialize editor if available
    if (defined('NV_EDITOR')) {
        require_once NV_ROOTDIR . '/' . NV_EDITORSDIR . '/' . NV_EDITOR . '/nv.php';
    }

    // Prepare content for editor - ensure it's never null or undefined
    $content_value = isset($data['content']) ? $data['content'] : '';
    $content_value = htmlspecialchars(nv_editor_br2nl($content_value));

    // Create content editor
    if (defined('NV_EDITOR') and nv_function_exists('nv_aleditor')) {
        $upload_path = NV_UPLOADS_DIR . '/' . $module_upload;
        $content_editor = nv_aleditor('content', '100%', '400px', $content_value, '', $upload_path, $upload_path);
    } else {
        $content_editor = '<textarea name="content" class="form-control" rows="10" placeholder="Mô tả chi tiết về sản phẩm..." required>' . $content_value . '</textarea>';
    }

    $xtpl->assign('DATA', $data);
    $xtpl->assign('CONTENT_EDITOR', $content_editor);

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
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);

    if (!empty($favorites)) {
        foreach ($favorites as $item) {
            $xtpl->assign('FAVORITE', $item);
            $xtpl->parse('main.favorites.favorite');
        }
        $xtpl->parse('main.favorites');

        if (!empty($generate_page)) {
            $xtpl->assign('GENERATE_PAGE', $generate_page);
            $xtpl->parse('main.generate_page');
        }
    } else {
        $xtpl->parse('main.no_favorites');
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

/**
 * nv_theme_sharecode_revenue()
 * Hiển thị trang doanh thu
 *
 * @param array $stats
 * @param array $products
 * @param array $chart_data
 * @param array $transactions
 * @param string $generate_page
 * @param string $time_filter
 * @param int $year
 * @param int $month
 * @param float $commission_rate
 * @return string
 */
function nv_theme_sharecode_revenue($stats, $products, $chart_data, $transactions, $generate_page, $time_filter, $year, $month, $commission_rate)
{
    global $module_file, $lang_module, $module_name, $global_config;

    $xtpl = new XTemplate('revenue.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);

    $xtpl->assign('LANG', $lang_module);
    $xtpl->assign('MODULE_NAME', $module_name);
    $xtpl->assign('STATS', $stats);
    $xtpl->assign('COMMISSION_RATE', $commission_rate);
    $xtpl->assign('AUTHOR_RATE', 100 - $commission_rate);
    $xtpl->assign('TIME_FILTER', $time_filter);
    $xtpl->assign('YEAR', $year);
    $xtpl->assign('MONTH', $month);
    $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
    $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
    $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);
    $xtpl->assign('BASE_URL', NV_BASE_SITEURL);

    // Chart data
    $xtpl->assign('CHART_DATA', json_encode($chart_data));

    // Time filter options
    $time_filters = [
        'all' => 'Tất cả',
        'today' => 'Hôm nay',
        'yesterday' => 'Hôm qua',
        'this_week' => 'Tuần này',
        'last_week' => 'Tuần trước',
        'this_month' => 'Tháng này',
        'last_month' => 'Tháng trước',
        'this_year' => 'Năm này',
        'custom' => 'Tùy chọn'
    ];

    foreach ($time_filters as $key => $label) {
        $selected = ($time_filter == $key) ? 'selected="selected"' : '';
        $xtpl->assign('TIME_OPTION', [
            'value' => $key,
            'text' => $label,
            'selected' => $selected
        ]);
        $xtpl->parse('main.time_option');
    }

    // Year options
    $current_year = date('Y');
    for ($i = $current_year; $i >= $current_year - 5; $i--) {
        $selected = ($year == $i) ? 'selected="selected"' : '';
        $xtpl->assign('YEAR_OPTION', [
            'value' => $i,
            'selected' => $selected
        ]);
        $xtpl->parse('main.year_option');
    }

    // Month options
    for ($i = 1; $i <= 12; $i++) {
        $selected = ($month == $i) ? 'selected="selected"' : '';
        $xtpl->assign('MONTH_OPTION', [
            'value' => $i,
            'name' => 'Tháng ' . $i,
            'selected' => $selected
        ]);
        $xtpl->parse('main.month_option');
    }

    // Products list
    if (!empty($products)) {
        foreach ($products as $product) {
            $xtpl->assign('PRODUCT', $product);
            $xtpl->parse('main.products.product');
        }
        $xtpl->parse('main.products');
    } else {
        $xtpl->parse('main.no_products');
    }

    // Transactions list
    if (!empty($transactions)) {
        foreach ($transactions as $transaction) {
            $xtpl->assign('TRANSACTION', $transaction);
            $xtpl->parse('main.transactions.transaction');
        }
        $xtpl->parse('main.transactions');

        // Pagination
        if (!empty($generate_page)) {
            $xtpl->assign('PAGINATION', $generate_page);
            $xtpl->parse('main.pagination');
        }
    } else {
        $xtpl->parse('main.no_transactions');
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
}
