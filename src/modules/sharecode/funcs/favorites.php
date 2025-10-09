<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}

if ($nv_Request->isset_request('ajax', 'post')) {
    if (!defined('NV_IS_USER')) {
        nv_jsonOutput([
            'status' => 'error',
            'message' => 'Bạn cần đăng nhập để sử dụng tính năng yêu thích'
        ]);
    }

    $source_id = $nv_Request->get_int('source_id', 'post', 0);
    $action = $nv_Request->get_title('action', 'post', '');
    $checkss = $nv_Request->get_title('checkss', 'post', '');

    if (empty($source_id) || empty($action) || empty($checkss)) {
        nv_jsonOutput([
            'status' => 'error',
            'message' => 'Dữ liệu không hợp lệ'
        ]);
    }

    $valid_checkss = md5($source_id . '_' . $action . '_' . NV_CHECK_SESSION . '_' . $user_info['userid']);
    if ($checkss !== $valid_checkss) {
        nv_jsonOutput([
            'status' => 'error',
            'message' => 'Lỗi bảo mật'
        ]);
    }

    $sql = "SELECT id, title FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id = " . $source_id;
    $source = $db->query($sql)->fetch();
    if (empty($source)) {
        nv_jsonOutput([
            'status' => 'error',
            'message' => 'Mã nguồn không tồn tại'
        ]);
    }

    if ($action == 'add') {
        $result = nv_sharecode_add_favorite($source_id, $user_info['userid']);
        if ($result) {
            $new_checkss = md5($source_id . '_remove_' . NV_CHECK_SESSION . '_' . $user_info['userid']);
            nv_jsonOutput([
                'status' => 'success',
                'message' => 'Đã thêm vào danh sách yêu thích',
                'action' => 'remove',
                'text' => 'Xóa khỏi yêu thích',
                'class' => 'btn-danger',
                'icon' => 'fa-heart',
                'checkss' => $new_checkss
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'message' => 'Không thể thêm vào yêu thích'
            ]);
        }
    } elseif ($action == 'remove') {
        $result = nv_sharecode_remove_favorite($source_id, $user_info['userid']);
        if ($result) {
            $new_checkss = md5($source_id . '_add_' . NV_CHECK_SESSION . '_' . $user_info['userid']);
            nv_jsonOutput([
                'status' => 'success',
                'message' => 'Đã xóa khỏi danh sách yêu thích',
                'action' => 'add',
                'text' => 'Thêm vào yêu thích',
                'class' => 'btn-danger',
                'icon' => 'fa-heart-o',
                'checkss' => $new_checkss
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'message' => 'Không thể xóa khỏi yêu thích'
            ]);
        }
    } else {
        nv_jsonOutput([
            'status' => 'error',
            'message' => 'Hành động không hợp lệ'
        ]);
    }
}

if (!defined('NV_IS_ADMIN')) {
    nv_redirect_location(NV_MY_DOMAIN);
}

if (!defined('NV_IS_USER')) {
    $page_url = NV_MY_DOMAIN . $nv_Request->get_string('REQUEST_URI', 'server');
    $url = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login&nv_redirect=' . nv_redirect_encrypt($page_url), true);
    $contents = nv_theme_alert($nv_Lang->getModule('info'), 'Bạn cần đăng nhập để xem danh sách yêu thích', 'info', $url, $nv_Lang->getModule('info_redirect_click'), 5);
    include NV_ROOTDIR . '/includes/header.php';
    echo nv_site_theme($contents);
    include NV_ROOTDIR . '/includes/footer.php';
    exit();
}

$page_title = 'Danh sách yêu thích';
$key_words = $module_info['keywords'];
$description = 'Xem danh sách mã nguồn yêu thích';

if ($nv_Request->isset_request('remove', 'get')) {
    $source_id = $nv_Request->get_int('remove', 'get', 0);
    $checkss = $nv_Request->get_title('checkss', 'get', '');

    if ($source_id > 0) {
        if (nv_sharecode_remove_favorite($source_id, $user_info['userid'])) {
            nv_jsonOutput([
                'status' => 'success',
                'message' => 'Đã xóa khỏi danh sách yêu thích'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'error',
                'message' => 'Có lỗi xảy ra khi xóa khỏi yêu thích'
            ]);
        }
    }

    nv_jsonOutput([
        'status' => 'error',
        'message' => 'Dữ liệu không hợp lệ'
    ]);
}

$per_page = 20;
$page = $nv_Request->get_int('page', 'get', 1);
if ($page < 1) {
    $page = 1;
}
$favorites_data = nv_sharecode_get_user_favorites($user_info['userid'], $page, $per_page);
$favorites = $favorites_data['items'];
$total_favorites = $favorites_data['total'];

$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=favorites';
$generate_page = nv_generate_page($base_url, $total_favorites, $per_page, $page);

$array_mod_title[] = [
    'title' => 'Danh sách yêu thích',
    'link' => nv_url_rewrite($base_url, true)
];

$favorites_list = [];
foreach ($favorites as $favorite) {
    $detail_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $favorite['alias'];
    $favorite['link'] = nv_url_rewrite($detail_url, true);

    if (!empty($favorite['category_alias'])) {
        $category_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=category/' . $favorite['category_alias'];
        $favorite['category_link'] = nv_url_rewrite($category_url, true);
    } else {
        $favorite['category_link'] = '';
    }

    $favorite['image_url'] = '';

    if (!empty($favorite['image'])) {
        if (is_file(NV_ROOTDIR . '/' . $favorite['image'])) {
            $favorite['image_url'] = NV_BASE_SITEURL . $favorite['image'];
        }
    }

    if (empty($favorite['image_url']) && !empty($favorite['avatar'])) {
        if (is_file(NV_ROOTDIR . '/' . $favorite['avatar'])) {
            $favorite['image_url'] = $favorite['avatar'];
        }
    }

    if (empty($favorite['image_url']) && !empty($favorite['demo_image'])) {
        $demo_images = json_decode($favorite['demo_image'], true);
        if (is_array($demo_images) && !empty($demo_images[0])) {
            if (is_file(NV_ROOTDIR . '/' . $demo_images[0])) {
                $favorite['image_url'] =  $demo_images[0];
            }
        }
    }

    if (empty($favorite['image_url'])) {
        $favorite['image_url'] = NV_BASE_SITEURL . 'themes/default/images/no-image.png';
    }

    if ($favorite['fee_type'] == 'free') {
        $favorite['price_display'] = 'Miễn phí';
        $favorite['price_class'] = 'label-success';
    } elseif ($favorite['fee_type'] == 'paid') {
        $favorite['price_display'] = number_format($favorite['fee_amount'], 0, ',', '.') . ' VNĐ';
        $favorite['price_class'] = 'label-primary';
    } else {
        $favorite['price_display'] = 'Liên hệ';
        $favorite['price_class'] = 'label-warning';
    }

    $favorite['rating_stars'] = '';
    if ($favorite['avg_rating'] > 0) {
        $full_stars = floor($favorite['avg_rating']);
        $half_star = ($favorite['avg_rating'] - $full_stars) >= 0.5 ? 1 : 0;
        $empty_stars = 5 - $full_stars - $half_star;

        $favorite['rating_stars'] = str_repeat('★', $full_stars);
        if ($half_star) {
            $favorite['rating_stars'] .= '☆';
        }
        $favorite['rating_stars'] .= str_repeat('☆', $empty_stars);
    } else {
        $favorite['rating_stars'] = str_repeat('☆', 5);
    }

    $add_time = isset($favorite['add_time']) && $favorite['add_time'] > 0 ? $favorite['add_time'] : time();
    $favorite['add_time_format'] = nv_date('d/m/Y H:i', $add_time);

    $favorite['remove_url'] = $base_url . '&remove=' . $favorite['id'] . '&checkss=' . md5($favorite['id'] . NV_CHECK_SESSION . $user_info['userid']);
    $favorite['remove_checkss'] = md5($favorite['id'] . '_remove_' . NV_CHECK_SESSION . '_' . $user_info['userid']);

    if (!empty($favorite['description'])) {
        $favorite['description_short'] = nv_clean60($favorite['description'], 150);
    } else {
        $favorite['description_short'] = '';
    }

    $favorites_list[] = $favorite;
}

$contents = nv_theme_sharecode_favorites($favorites_list, $generate_page, $total_favorites);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
