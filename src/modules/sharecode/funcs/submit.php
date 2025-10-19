<?php

if (!defined('NV_IS_MOD_SHARECODE')) {
    exit('Stop!!!');
}


if (!defined('NV_IS_USER') && empty($module_config['allow_guest_submit'])) {
    $redirect_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=submit';
    $login_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=users&' . NV_OP_VARIABLE . '=login&nv_redirect=' . nv_base64_encode($redirect_url);
    nv_redirect_location($login_url);
}

$errors = [];

if ($nv_Request->isset_request('submit_product', 'post')) {
    $title = $nv_Request->get_textarea('title', 'post', '');
    $alias = $nv_Request->get_title('alias', 'post', '');
    $catid = $nv_Request->get_int('catid', 'post', 0);
    $description = $nv_Request->get_textarea('description', 'post', '');
    $content = $nv_Request->get_editor('content', 'post', '', '', 'content');
    $demo_link = $nv_Request->get_textarea('demo_link', 'post', '');
    $external_source_link = $nv_Request->get_textarea('external_source_link', 'post', '');
    $fee_type = $nv_Request->get_string('fee_type', 'post', 'free');
    $fee_amount = $nv_Request->get_float('fee_amount', 'post', 0);
    $keywords = $nv_Request->get_array('keywords', 'post', []);
    $tags = $nv_Request->get_array('tags', 'post', []);
    $download_link_type = $nv_Request->get_string('download_link_type', 'post', 'external');
    $download_link = $nv_Request->get_textarea('download_link', 'post', '');

    $contact_phone = $nv_Request->get_title('contact_phone', 'post', '');
    $contact_email = $nv_Request->get_title('contact_email', 'post', '');
    $contact_skype = $nv_Request->get_title('contact_skype', 'post', '');
    $contact_telegram = $nv_Request->get_title('contact_telegram', 'post', '');
    $contact_zalo = $nv_Request->get_title('contact_zalo', 'post', '');
    $contact_facebook = $nv_Request->get_title('contact_facebook', 'post', '');
    $contact_website = $nv_Request->get_title('contact_website', 'post', '');
    $contact_address = $nv_Request->get_textarea('contact_address', 'post', '');

    if (empty($module_upload)) {
        $module_upload = $module_data;
    }

    nv_sharecode_create_upload_dirs($module_upload);

    $uploaded_image = '';
    if (isset($_FILES['product_image']) && $_FILES['product_image']['error'] == 0) {
        $upload_dir = NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/';

        $image_info = $_FILES['product_image'];
        $image_ext = strtolower(pathinfo($image_info['name'], PATHINFO_EXTENSION));
        $allowed_image_exts = ['jpg', 'jpeg', 'png', 'gif'];

        if (in_array($image_ext, $allowed_image_exts)) {
            if ($image_info['size'] <= 5 * 1024 * 1024) {
                $original_name = pathinfo($image_info['name'], PATHINFO_FILENAME);
                $safe_name = preg_replace('/[^a-zA-Z0-9_\-]/', '_', $original_name);
                $new_image_name = $safe_name . '_' . time() . '.' . $image_ext;
                $image_upload_path = $upload_dir . $new_image_name;

                if (move_uploaded_file($image_info['tmp_name'], $image_upload_path)) {
                    $uploaded_image = NV_UPLOADS_DIR . '/' . $module_upload . '/' . $new_image_name;
                }
            } else {
                $errors[] = 'Hình ảnh đại diện quá lớn. Kích thước tối đa 5MB';
            }
        } else {
            $errors[] = 'Định dạng hình ảnh đại diện không hợp lệ. Chỉ chấp nhận: ' . implode(', ', $allowed_image_exts);
        }
    }

    $uploaded_demo_images = [];
    if (isset($_FILES['demo_images']) && is_array($_FILES['demo_images']['name'])) {
        $upload_dir = NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/';
        $allowed_image_exts = ['jpg', 'jpeg', 'png', 'gif'];
        $max_demo_images = 5;
        $uploaded_count = 0;

        for ($i = 0; $i < count($_FILES['demo_images']['name']) && $uploaded_count < $max_demo_images; $i++) {
            if ($_FILES['demo_images']['error'][$i] == 0 && !empty($_FILES['demo_images']['name'][$i])) {
                $demo_info = [
                    'name' => $_FILES['demo_images']['name'][$i],
                    'tmp_name' => $_FILES['demo_images']['tmp_name'][$i],
                    'size' => $_FILES['demo_images']['size'][$i]
                ];

                $demo_ext = strtolower(pathinfo($demo_info['name'], PATHINFO_EXTENSION));

                if (in_array($demo_ext, $allowed_image_exts)) {
                    if ($demo_info['size'] <= 5 * 1024 * 1024) {
                        $original_demo_name = pathinfo($demo_info['name'], PATHINFO_FILENAME);
                        $safe_demo_name = preg_replace('/[^a-zA-Z0-9_\-]/', '_', $original_demo_name);
                        $new_demo_name = $safe_demo_name . '_demo_' . ($i + 1) . '_' . time() . '.' . $demo_ext;
                        $demo_upload_path = $upload_dir . $new_demo_name;

                        if (move_uploaded_file($demo_info['tmp_name'], $demo_upload_path)) {

                            $uploaded_demo_images[] = 'uploads/' . $module_upload . '/' . $new_demo_name;
                            $uploaded_count++;
                        }
                    } else {
                        $errors[] = 'Ảnh demo #' . ($i + 1) . ' quá lớn. Kích thước tối đa 5MB';
                    }
                } else {
                    $errors[] = 'Định dạng ảnh demo #' . ($i + 1) . ' không hợp lệ. Chỉ chấp nhận: ' . implode(', ', $allowed_image_exts);
                }
            }
        }
    }


    $uploaded_demo_image_json = !empty($uploaded_demo_images) ? json_encode($uploaded_demo_images) : '';




    if (empty($alias)) {
        $alias = change_alias($title);
    } else {
        $alias = change_alias($alias);
    }


    if (empty($title)) {
        $errors[] = 'Vui lòng nhập tiêu đề sản phẩm';
    }
    if ($catid <= 0) {
        $errors[] = 'Vui lòng chọn danh mục';
    }
    if (empty($description)) {
        $errors[] = 'Vui lòng nhập mô tả ngắn sản phẩm';
    }
    if (empty($content)) {
        $errors[] = 'Vui lòng nhập mô tả chi tiết sản phẩm';
    }
    if ($fee_type == 'paid' && $fee_amount <= 0) {
        $errors[] = 'Vui lòng nhập giá bán hợp lệ';
    }


    if ($fee_type == 'contact') {
        $contact_fields = [$contact_phone, $contact_email, $contact_skype, $contact_telegram, $contact_zalo, $contact_facebook, $contact_website];
        $has_contact = false;
        foreach ($contact_fields as $field) {
            if (!empty(trim($field))) {
                $has_contact = true;
                break;
            }
        }
        if (!$has_contact) {
            $errors[] = 'Vui lòng nhập ít nhất một thông tin liên hệ khi chọn loại phí "Liên hệ để biết giá"';
        }
    }

    if (empty($download_link)) {
        $errors[] = 'Vui lòng nhập link tải xuống mã nguồn';
    }


    if (!empty($alias)) {
        $sql = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE alias=" . $db->quote($alias);
        $existing_id = $db->query($sql)->fetchColumn();
        if ($existing_id) {
            $alias = $alias . '-' . time();
        }
    }


    if ($catid > 0) {
        $sql_cat = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE id=" . $catid . " AND status=1";
        $cat_exists = $db->query($sql_cat)->fetchColumn();
        if (!$cat_exists) {
            $errors[] = 'Danh mục không hợp lệ';
        }
    }

    if (empty($errors)) {
        try {
            $db->beginTransaction();


            $alias = change_alias($title);
            $check_alias = 0;
            $base_alias = $alias;
            while (true) {
                $sql_check = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE alias=" . $db->quote($alias);
                if (!$db->query($sql_check)->fetchColumn()) {
                    break;
                }
                $check_alias++;
                $alias = $base_alias . '-' . $check_alias;
            }


            $submit_userid = defined('NV_IS_USER') ? $user_info['userid'] : 0;
            $submit_username = defined('NV_IS_USER') ? $user_info['username'] : 'Guest';


            $keywords_string = is_array($keywords) ? implode(', ', $keywords) : $keywords;


            $sql_insert = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources (
                title, alias, catid, description, content, demo_link, external_source_link, keywords,
                fee_type, fee_amount, download_link_type, download_link, avatar, demo_image,
                contact_phone, contact_email, contact_skype, contact_telegram,
                contact_zalo, contact_facebook, contact_website, contact_address,
                userid, username, add_time, status
            ) VALUES (
                " . $db->quote($title) . ",
                " . $db->quote($alias) . ",
                " . $catid . ",
                " . $db->quote($description) . ",
                " . $db->quote($content) . ",
                " . $db->quote($demo_link) . ",
                " . $db->quote($external_source_link) . ",
                " . $db->quote($keywords_string) . ",
                " . $db->quote($fee_type) . ",
                " . $fee_amount . ",
                " . $db->quote($download_link_type) . ",
                " . $db->quote($download_link) . ",
                " . $db->quote($uploaded_image) . ",
                " . $db->quote($uploaded_demo_image_json) . ",
                " . $db->quote($contact_phone) . ",
                " . $db->quote($contact_email) . ",
                " . $db->quote($contact_skype) . ",
                " . $db->quote($contact_telegram) . ",
                " . $db->quote($contact_zalo) . ",
                " . $db->quote($contact_facebook) . ",
                " . $db->quote($contact_website) . ",
                " . $db->quote($contact_address) . ",
                " . $submit_userid . ",
                " . $db->quote($submit_username) . ",
                " . NV_CURRENTTIME . ",
                0
            )";

            if ($db->exec($sql_insert)) {
                $source_id = $db->lastInsertId();

                if (!empty($tags) && is_array($tags)) {
                    foreach ($tags as $tag_name) {
                        $tag_name = trim($tag_name);
                        if (!empty($tag_name)) {
                            $tag_alias = change_alias($tag_name);


                            $sql_tag = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags WHERE alias=" . $db->quote($tag_alias);
                            $tag_id = $db->query($sql_tag)->fetchColumn();

                            if (!$tag_id) {

                                $sql_new_tag = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, add_time) VALUES (" . $db->quote($tag_name) . ", " . $db->quote($tag_alias) . ", " . NV_CURRENTTIME . ")";
                                $db->exec($sql_new_tag);
                                $tag_id = $db->lastInsertId();
                            }


                            $sql_source_tag = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_source_tags (source_id, tag_id) VALUES (" . $source_id . ", " . $tag_id . ")";
                            $db->exec($sql_source_tag);
                        }
                    }
                }


                $sql_config = "SELECT config_name, config_value FROM " . NV_CONFIG_GLOBALTABLE . " WHERE lang='" . NV_LANG_DATA . "' AND module='" . $module_name . "'";
                $result_config = $db->query($sql_config);
                $module_config = [];
                while ($row_config = $result_config->fetch()) {
                    $module_config[$row_config['config_name']] = $row_config['config_value'];
                }

                if (!empty($module_config['email_notify_new_source'])) {

                    $sql_admin = "SELECT u.email, u.first_name, u.last_name
                                  FROM " . NV_AUTHORS_GLOBALTABLE . " a
                                  JOIN " . NV_USERS_GLOBALTABLE . " u ON a.admin_id = u.userid
                                  WHERE a.lev = 1 AND a.is_suspend = 0 AND u.active = 1
                                  LIMIT 1";
                    $admin_info_notify = $db->query($sql_admin)->fetch();

                    if ($admin_info_notify) {
                        $admin_name = trim($admin_info_notify['first_name'] . ' ' . $admin_info_notify['last_name']);
                        if (empty($admin_name)) {
                            $admin_name = 'Admin';
                        }

                        $subject = '[' . $global_config['site_name'] . '] Sản phẩm mới chờ duyệt';
                        $message = "Xin chào {$admin_name},\n\n";
                        $message .= "Có sản phẩm mới được đăng và đang chờ duyệt:\n\n";
                        $message .= "Tiêu đề: {$title}\n";
                        $message .= "Mô tả: {$description}\n";
                        $message .= "Loại phí: " . ($fee_type == 'free' ? 'Miễn phí' : ($fee_type == 'paid' ? 'Trả phí: ' . number_format($fee_amount, 0, ',', '.') . ' VND' : 'Liên hệ')) . "\n";
                        $message .= "Người đăng: {$submit_username}\n";
                        $message .= "Thời gian: " . date('d/m/Y H:i', NV_CURRENTTIME) . "\n\n";
                        $message .= "Duyệt sản phẩm: " . NV_MY_DOMAIN . NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=pending\n\n";
                        $message .= "Trân trọng,\n";
                        $message .= $global_config['site_name'];

                        nv_sharecode_send_email_notification($admin_info_notify['email'], $admin_name, $subject, $message);
                    }
                }

                $db->commit();

                nv_info_die('Thành công', 'Đăng sản phẩm thành công!', 'Sản phẩm của bạn đã được gửi và đang chờ admin duyệt. Bạn sẽ nhận được thông báo khi sản phẩm được phê duyệt.', 200);
            } else {
                throw new Exception('Không thể lưu sản phẩm');
            }
        } catch (Exception $e) {
            $db->rollback();
            $errors[] = 'Có lỗi xảy ra: ' . $e->getMessage();
        }
    }
}


$base_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=submit';
$array_mod_title[] = [
    'title' => 'Đăng mã nguồn',
    'link' => nv_url_rewrite($base_url, true)
];


$page_title = 'Đăng bán sản phẩm';
$key_words = 'đăng bán, sản phẩm, sharecode';
$description = 'Đăng bán sản phẩm lên website';


$form_data = [
    'title' => '',
    'alias' => '',
    'catid' => 0,
    'description' => '',
    'content' => '',
    'demo_link' => '',
    'external_source_link' => '',
    'keywords' => '',
    'tags' => '',
    'fee_type' => 'free',
    'fee_amount' => 0,
    'download_link_type' => 'external',
    'download_link' => '',
    'contact_phone' => '',
    'contact_email' => '',
    'contact_skype' => '',
    'contact_telegram' => '',
    'contact_zalo' => '',
    'contact_facebook' => '',
    'contact_website' => '',
    'contact_address' => ''
];


$checked_free = ($form_data['fee_type'] == 'free') ? 'checked' : '';
$checked_paid = ($form_data['fee_type'] == 'paid') ? 'checked' : '';
$checked_contact = ($form_data['fee_type'] == 'contact') ? 'checked' : '';


if (defined('NV_IS_USER')) {
    $form_data['contact_email'] = $user_info['email'];
    $form_data['contact_phone'] = !empty($user_info['phone']) ? $user_info['phone'] : '';
}


if ($nv_Request->isset_request('submit_product', 'post')) {
    $form_data['title'] = $nv_Request->get_textarea('title', 'post', '');
    $form_data['alias'] = $nv_Request->get_title('alias', 'post', '');
    $form_data['catid'] = $nv_Request->get_int('catid', 'post', 0);
    $form_data['description'] = $nv_Request->get_textarea('description', 'post', '');
    $form_data['content'] = $nv_Request->get_editor('content', 'post', '');
    $form_data['demo_link'] = $nv_Request->get_textarea('demo_link', 'post', '');
    $form_data['external_source_link'] = $nv_Request->get_textarea('external_source_link', 'post', '');
    $form_data['keywords'] = $nv_Request->get_array('keywords', 'post', []);
    $form_data['tags'] = $nv_Request->get_array('tags', 'post', []);
    $form_data['fee_type'] = $nv_Request->get_string('fee_type', 'post', 'free');
    $form_data['fee_amount'] = $nv_Request->get_float('fee_amount', 'post', 0);
    $form_data['download_link_type'] = $nv_Request->get_string('download_link_type', 'post', 'external');
    $form_data['download_link'] = $nv_Request->get_textarea('download_link', 'post', '');
    $form_data['contact_phone'] = $nv_Request->get_title('contact_phone', 'post', '');
    $form_data['contact_email'] = $nv_Request->get_title('contact_email', 'post', '');
    $form_data['contact_skype'] = $nv_Request->get_title('contact_skype', 'post', '');
    $form_data['contact_telegram'] = $nv_Request->get_title('contact_telegram', 'post', '');
    $form_data['contact_zalo'] = $nv_Request->get_title('contact_zalo', 'post', '');
    $form_data['contact_facebook'] = $nv_Request->get_title('contact_facebook', 'post', '');
    $form_data['contact_website'] = $nv_Request->get_title('contact_website', 'post', '');
    $form_data['contact_address'] = $nv_Request->get_textarea('contact_address', 'post', '');
}


$checked_free = ($form_data['fee_type'] == 'free') ? 'checked' : '';
$checked_paid = ($form_data['fee_type'] == 'paid') ? 'checked' : '';
$checked_contact = ($form_data['fee_type'] == 'contact') ? 'checked' : '';


function nv_submit_get_all_categories()
{
    global $db, $module_data;

    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories
            WHERE status=1 ORDER BY parentid ASC, weight ASC";
    $result = $db->query($sql);

    $categories = [];
    while ($row = $result->fetch()) {
        $categories[$row['parentid']][] = $row;
    }

    return $categories;
}

function nv_submit_build_category_tree($categories, $parent_id = 0, $level = 0)
{
    $tree = [];

    if (isset($categories[$parent_id])) {
        foreach ($categories[$parent_id] as $category) {
            $category['level'] = $level;
            $category['level_prefix'] = str_repeat('├── ', $level);
            $tree[] = $category;

            $children = nv_submit_build_category_tree($categories, $category['id'], $level + 1);
            if (!empty($children)) {
                $tree = array_merge($tree, $children);
            }
        }
    }

    return $tree;
}


$categories_raw = nv_submit_get_all_categories();
$categories = nv_submit_build_category_tree($categories_raw);


$available_keywords = [];
$sql = "SELECT id, name FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE status=1 ORDER BY name ASC";
$result = $db->query($sql);
while ($row_keyword = $result->fetch()) {
    $available_keywords[] = [
        'id' => $row_keyword['id'],
        'name' => $row_keyword['name']
    ];
}


$available_tags = [];
$sql = "SELECT id, name FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags WHERE status=1 ORDER BY name ASC";
$result = $db->query($sql);
while ($row_tag = $result->fetch()) {
    $available_tags[] = [
        'id' => $row_tag['id'],
        'name' => $row_tag['name']
    ];
}



$contents = nv_theme_sharecode_submit($categories, $available_keywords, $available_tags, $form_data, $errors);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
