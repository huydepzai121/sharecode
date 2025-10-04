<?php

if (!defined('NV_IS_FILE_ADMIN')) {
    exit('Stop!!!');
}

$page_title = 'Quản lý mã nguồn';


$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('sources.tpl'));
$tpl->assign('LANG', $lang_module);
$tpl->assign('GLANG', $lang_global);
$tpl->assign('MODULE_NAME', $module_name);

$action = $nv_Request->get_title('action', 'get', '');
$id = $nv_Request->get_int('id', 'get', 0);
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = $nv_Request->get_int('per_page', 'get', 20);


$array_search = [];
$array_search['q'] = $nv_Request->get_title('q', 'get', '');
$array_search['catid'] = $nv_Request->get_int('catid', 'get', 0);
$array_search['status'] = $nv_Request->get_int('status', 'get', 1);
$array_search['fee_type'] = $nv_Request->get_title('fee_type', 'get', '');

if (empty($action) && $id == 0) {
    $action = 'list';
}

if ($nv_Request->get_title('action', 'post,get') == 'delete') {
    $checksess = $nv_Request->get_title('checksess', 'post', '');
    $id = $nv_Request->get_int('id', 'post', 0);
    if ($checksess == md5(NV_CHECK_SESSION)) {
        if (nv_admin_sharecode_delete_source($id)) {
            nv_jsonOutput([
                'status' => 'OK',
                'mess' => 'Xóa mã nguồn thành công'
            ]);
        } else {
            nv_jsonOutput([
                'status' => 'ERROR',
                'mess' => 'Lỗi khi xóa mã nguồn'
            ]);
        }
    }
    nv_jsonOutput([
        'status' => 'ERROR',
        'mess' => 'Lỗi xác thực'
    ]);
}

// AI Keywords Generation
if ($nv_Request->get_title('action', 'post') == 'ai_keywords') {
    $checksess = $nv_Request->get_title('checksess', 'post', '');
    if (md5($checksess) != md5(NV_CHECK_SESSION)) {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Lỗi xác thực'
        ]);
    }

    $title = $nv_Request->get_title('title', 'post', '');
    $description = $nv_Request->get_textarea('description', 'post', '');
    $content = $nv_Request->get_editor('content', 'post', '');

    if (empty($title) && empty($description) && empty($content)) {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Vui lòng nhập ít nhất tiêu đề hoặc mô tả'
        ]);
    }

    $keywords = nv_admin_sharecode_generate_ai_keywords($title, $description, $content);

    if (!empty($keywords)) {
        nv_jsonOutput([
            'status' => 'OK',
            'keywords' => $keywords,
            'mess' => 'Đã tạo ' . count($keywords) . ' từ khóa bằng AI'
        ]);
    } else {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Không thể tạo từ khóa. Vui lòng kiểm tra cấu hình AI hoặc thử lại sau.'
        ]);
    }
}

// AI Tags Generation
if ($nv_Request->get_title('action', 'post') == 'ai_tags') {
    $checksess = $nv_Request->get_title('checksess', 'post', '');
    if (md5($checksess) != md5(NV_CHECK_SESSION)) {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Lỗi xác thực'
        ]);
    }

    $title = $nv_Request->get_title('title', 'post', '');
    $description = $nv_Request->get_textarea('description', 'post', '');
    $content = $nv_Request->get_editor('content', 'post', '');

    if (empty($title) && empty($description) && empty($content)) {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Vui lòng nhập ít nhất tiêu đề hoặc mô tả'
        ]);
    }

    $tags = nv_admin_sharecode_generate_ai_tags($title, $description, $content);

    if (!empty($tags)) {
        nv_jsonOutput([
            'status' => 'OK',
            'tags' => $tags,
            'mess' => 'Đã tạo ' . count($tags) . ' tags bằng AI'
        ]);
    } else {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Không thể tạo tags. Vui lòng kiểm tra cấu hình AI hoặc thử lại sau.'
        ]);
    }
}

if ($nv_Request->isset_request('bulk_action', 'post')) {
    $action_type = $nv_Request->get_title('action_type', 'post', '');
    $ids = $nv_Request->get_array('ids', 'post', []);

    if (!empty($ids) && in_array($action_type, ['delete', 'activate', 'deactivate'])) {
        $success_count = 0;
        foreach ($ids as $source_id) {
            if ($action_type == 'delete') {
                if (nv_admin_sharecode_delete_source($source_id)) {
                    $success_count++;
                }
            } elseif ($action_type == 'activate') {
                $db->query("UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources SET status=1 WHERE id=" . intval($source_id));
                $success_count++;
            } elseif ($action_type == 'deactivate') {
                $db->query("UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources SET status=0 WHERE id=" . intval($source_id));
                $success_count++;
            }
        }

        nv_jsonOutput([
            'status' => 'OK',
            'mess' => sprintf('Đã xử lý %d mã nguồn', $success_count)
        ]);
    }

    nv_jsonOutput([
        'status' => 'ERROR',
        'mess' => 'Thao tác không hợp lệ'
    ]);
}


if ($nv_Request->isset_request('save', 'post,get')) {
    try {
        $error = [];
        $post = [];

        $post['title'] = $nv_Request->get_title('title', 'post', '');
        $post['alias'] = $nv_Request->get_title('alias', 'post', '');
        $post['description'] = $nv_Request->get_textarea('description', 'post', '');
        $post['content'] = $nv_Request->get_editor('content', 'post', '');
        $post['catid'] = $nv_Request->get_int('catid', 'post', 0);
        $post['download_link_type'] = $nv_Request->get_title('download_link_type', 'post', 'internal');
        $post['download_link'] = $nv_Request->get_textarea('download_link', 'post', '');
        $post['external_source_link'] = $nv_Request->get_textarea('external_source_link', 'post', '');
        $post['demo_link'] = $nv_Request->get_textarea('demo_link', 'post', '');
        $post['fee_type'] = $nv_Request->get_title('fee_type', 'post', 'free');
        $post['fee_amount'] = $nv_Request->get_float('fee_amount', 'post', 0);
        $post['keywords'] = $nv_Request->get_array('keywords', 'post', []);
        $post['tags'] = $nv_Request->get_array('tags', 'post', []);
        $post['status'] = $nv_Request->get_int('status', 'post', 1);
        $post['tag_ids'] = $nv_Request->get_array('tag_ids', 'post', []);

        $post['avatar'] = $nv_Request->get_title('avatar', 'post', '');

        $post['demo_images'] = $nv_Request->get_array('demo_images', 'post', []);
        $post['delete_image'] = $nv_Request->get_int('delete_image', 'post', 0);

        $demo_images_clean = [];
        foreach ($post['demo_images'] as $demo_image) {
            $demo_image = trim($demo_image);
            if (!empty($demo_image)) {
                $demo_images_clean[] = $demo_image;
            }
        }
        $post['demo_image_json'] = !empty($demo_images_clean) ? json_encode($demo_images_clean) : '';


        $post['contact_phone'] = $nv_Request->get_title('contact_phone', 'post', '');
        $post['contact_email'] = $nv_Request->get_title('contact_email', 'post', '');
        $post['contact_skype'] = $nv_Request->get_title('contact_skype', 'post', '');
        $post['contact_telegram'] = $nv_Request->get_title('contact_telegram', 'post', '');
        $post['contact_zalo'] = $nv_Request->get_title('contact_zalo', 'post', '');
        $post['contact_facebook'] = $nv_Request->get_title('contact_facebook', 'post', '');
        $post['contact_website'] = $nv_Request->get_title('contact_website', 'post', '');
        $post['contact_address'] = $nv_Request->get_textarea('contact_address', 'post', '');




        if (empty($post['title'])) {
            $error[] = 'Tên mã nguồn không được để trống';
        } elseif (strlen($post['title']) < 3) {
            $error[] = 'Tên mã nguồn phải có ít nhất 3 ký tự';
        } elseif (strlen($post['title']) > 255) {
            $error[] = 'Tên mã nguồn không được vượt quá 255 ký tự';
        }

        if ($post['catid'] <= 0) {
            $error[] = 'Vui lòng chọn danh mục phù hợp cho mã nguồn';
        }

        if (empty($post['description'])) {
            $error[] = 'Mô tả ngắn không được để trống';
        } elseif (strlen($post['description']) < 10) {
            $error[] = 'Mô tả ngắn phải có ít nhất 10 ký tự';
        }


        if ($post['download_link_type'] == 'external' && empty($post['download_link'])) {
            $error[] = 'Vui lòng nhập link download bên ngoài';
        } elseif ($post['download_link_type'] == 'external' && !filter_var($post['download_link'], FILTER_VALIDATE_URL)) {
            $error[] = 'Link download không hợp lệ';
        }


        if ($post['fee_type'] == 'paid' && $post['fee_amount'] <= 0) {
            $error[] = 'Vui lòng nhập số tiền hợp lệ cho mã nguồn trả phí';
        }


        if ($post['fee_type'] == 'contact') {
            $contact_fields = ['contact_phone', 'contact_email', 'contact_skype', 'contact_telegram', 'contact_zalo', 'contact_facebook', 'contact_website'];
            $has_contact = false;
            foreach ($contact_fields as $field) {
                if (!empty($post[$field])) {
                    $has_contact = true;
                    break;
                }
            }
            if (!$has_contact) {
                $error[] = 'Vui lòng nhập ít nhất một thông tin liên hệ khi chọn loại phí "Liên hệ"';
            }
        }


        if (empty($post['download_link'])) {
            $error[] = 'Vui lòng nhập link download';
        } elseif (!filter_var($post['download_link'], FILTER_VALIDATE_URL)) {
            $error[] = 'Link download không hợp lệ';
        }


        $post['download_link_type'] = 'external';


        if (empty($post['alias'])) {
            $post['alias'] = nv_admin_sharecode_create_alias($post['title'], 'sources', $id);
        } else {
            // Clean up manually entered alias
            $post['alias'] = nv_admin_sharecode_create_alias($post['alias'], 'sources', $id);
        }

        if (!nv_admin_sharecode_check_alias($post['alias'], 'sources', $id)) {
            $error[] = 'Liên kết tĩnh "' . $post['alias'] . '" đã tồn tại. Vui lòng sử dụng liên kết khác.';
        }

        if (empty($error)) {
            if ($id > 0) {
                // Cập nhật
                $sql = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources SET 
                    title=" . $db->quote($post['title']) . ",
                    alias=" . $db->quote($post['alias']) . ",
                    description=" . $db->quote($post['description']) . ",
                    content=" . $db->quote($post['content']) . ",
                    catid=" . $post['catid'] . ",
                    download_link_type=" . $db->quote($post['download_link_type']) . ",
                    download_link=" . $db->quote($post['download_link']) . ",
                    external_source_link=" . $db->quote($post['external_source_link']) . ",
                    demo_link=" . $db->quote($post['demo_link']) . ",
                    fee_type=" . $db->quote($post['fee_type']) . ",
                    fee_amount=" . $post['fee_amount'] . ",
                    keywords=" . $db->quote(implode(',', $post['keywords'])) . ",
                    contact_phone=" . $db->quote($post['contact_phone']) . ",
                    contact_email=" . $db->quote($post['contact_email']) . ",
                    contact_skype=" . $db->quote($post['contact_skype']) . ",
                    contact_telegram=" . $db->quote($post['contact_telegram']) . ",
                    contact_zalo=" . $db->quote($post['contact_zalo']) . ",
                    contact_facebook=" . $db->quote($post['contact_facebook']) . ",
                    contact_website=" . $db->quote($post['contact_website']) . ",
                    contact_address=" . $db->quote($post['contact_address']) . ",
                    avatar=" . $db->quote($post['avatar']) . ",
                    demo_image=" . $db->quote($post['demo_image_json']) . ",
                    status=" . $post['status'] . ",
                    edit_time=" . NV_CURRENTTIME . "
                    WHERE id=" . $id;
            } else {
                // Thêm mới
                $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_sources
                    (title, alias, description, content, catid, download_link_type, download_link, external_source_link, demo_link, keywords, fee_type, fee_amount,
                     contact_phone, contact_email, contact_skype, contact_telegram, contact_zalo, contact_facebook, contact_website, contact_address,
                     avatar, demo_image, status, userid, add_time) VALUES (
                    " . $db->quote($post['title']) . ",
                    " . $db->quote($post['alias']) . ",
                    " . $db->quote($post['description']) . ",
                    " . $db->quote($post['content']) . ",
                    " . $post['catid'] . ",
                    " . $db->quote($post['download_link_type']) . ",
                    " . $db->quote($post['download_link']) . ",
                    " . $db->quote($post['external_source_link']) . ",
                    " . $db->quote($post['demo_link']) . ",
                    " . $db->quote(implode(',', $post['keywords'])) . ",
                    " . $db->quote($post['fee_type']) . ",
                    " . $post['fee_amount'] . ",
                    " . $db->quote($post['contact_phone']) . ",
                    " . $db->quote($post['contact_email']) . ",
                    " . $db->quote($post['contact_skype']) . ",
                    " . $db->quote($post['contact_telegram']) . ",
                    " . $db->quote($post['contact_zalo']) . ",
                    " . $db->quote($post['contact_facebook']) . ",
                    " . $db->quote($post['contact_website']) . ",
                    " . $db->quote($post['contact_address']) . ",
                    " . $db->quote($post['avatar']) . ",
                    " . $db->quote($post['demo_image_json']) . ",
                    " . $post['status'] . ",
                    " . $admin_info['userid'] . ",
                    " . NV_CURRENTTIME . "
                    )";
            }

            try {
                $result = $db->exec($sql);
                if ($result) {
                    // Lấy ID của source (cho trường hợp thêm mới hoặc cập nhật)
                    if ($id > 0) {
                        $source_id = $id; // Trường hợp cập nhật
                    } else {
                        $source_id = $db->lastInsertId(); // Trường hợp thêm mới
                    }
                } else {
                    $error[] = "Lỗi khi lưu dữ liệu: " . $db->lastErrorMsg();
                    $result = false;
                }
            } catch (Exception $e) {
                $error[] = "Lỗi: " . $e->getMessage();
                $result = false;
            }

            if ($result) {

                // Xử lý keywords từ select2
                if ($source_id > 0) {
                    // Process keywords from select2 field
                    $keyword_ids_from_names = [];
                    if (!empty($post['keywords']) && is_array($post['keywords'])) {
                        foreach ($post['keywords'] as $keyword_name) {
                            $keyword_name = trim($keyword_name);
                            if (!empty($keyword_name)) {
                                // Check if keyword exists
                                $keyword_id = $db->query("SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE name=" . $db->quote($keyword_name))->fetchColumn();

                                if (!$keyword_id) {
                                    // Create new keyword
                                    $alias = change_alias($keyword_name);
                                    // Ensure unique alias
                                    $base_alias = $alias;
                                    $counter = 1;
                                    while ($db->query("SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE alias=" . $db->quote($alias))->fetchColumn()) {
                                        $alias = $base_alias . '-' . $counter;
                                        $counter++;
                                    }

                                    // Get max weight
                                    $max_weight = (int)$db->query("SELECT MAX(weight) FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords")->fetchColumn();
                                    $new_weight = $max_weight + 1;

                                    $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_keywords (name, alias, description, weight, status, add_time) VALUES (" . $db->quote($keyword_name) . ", " . $db->quote($alias) . ", '', " . $new_weight . ", 1, " . NV_CURRENTTIME . ")";
                                    if ($db->exec($sql)) {
                                        $keyword_id = $db->lastInsertId();
                                    }
                                }

                                if ($keyword_id) {
                                    $keyword_ids_from_names[] = $keyword_id;
                                }
                            }
                        }
                    }

                    // Update source keywords
                    if (!empty($keyword_ids_from_names)) {
                        nv_admin_sharecode_update_source_keywords($source_id, $keyword_ids_from_names);
                    }
                }

                if ($source_id > 0) {
                    $tag_ids_from_names = [];
                    if (!empty($post['tags'])) {
                        foreach ($post['tags'] as $tag_name) {
                            $tag_name = trim($tag_name);
                            if (!empty($tag_name)) {
                                $tag_id = $db->query("SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags WHERE name=" . $db->quote($tag_name))->fetchColumn();

                                if (!$tag_id) {
                                    $alias = change_alias($tag_name);
                                    $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_tags (name, alias, description, weight, status, add_time) VALUES (" . $db->quote($tag_name) . ", " . $db->quote($alias) . ", '', 0, 1, " . NV_CURRENTTIME . ")";
                                    $db->exec($sql);
                                    $tag_id = $db->lastInsertId();
                                }

                                if ($tag_id) {
                                    $tag_ids_from_names[] = $tag_id;
                                }
                            }
                        }
                    }

                    // Merge with existing tag_ids if any
                    $all_tag_ids = array_unique(array_merge($post['tag_ids'], $tag_ids_from_names));
                    nv_admin_sharecode_update_source_tags($source_id, $all_tag_ids);
                }

                // Gửi email thông báo nếu là thêm mới và được cấu hình
                if ($id == 0) { // Chỉ thông báo khi thêm mới
                    $sql_config = "SELECT config_name, config_value FROM " . NV_CONFIG_GLOBALTABLE . " WHERE lang='" . NV_LANG_DATA . "' AND module='" . $module_name . "'";
                    $result_config = $db->query($sql_config);
                    $module_config = [];
                    while ($row_config = $result_config->fetch()) {
                        $module_config[$row_config['config_name']] = $row_config['config_value'];
                    }

                    if (!empty($module_config['email_notify_new_source'])) {

                        $sql_admin = "SELECT email, first_name, last_name FROM " . NV_USERS_GLOBALTABLE . " WHERE userid = " . $admin_info['userid'];
                        $admin_info_notify = $db->query($sql_admin)->fetch();

                        if ($admin_info_notify) {
                            $admin_name = trim($admin_info_notify['first_name'] . ' ' . $admin_info_notify['last_name']);
                            if (empty($admin_name)) {
                                $admin_name = 'Admin';
                            }

                            $subject = '[' . $global_config['site_name'] . '] Sản phẩm mới được thêm';
                            $message = 'Xin chào ' . $admin_name . ',<br><br>';
                            $message .= 'Có sản phẩm mới được thêm bởi admin:<br><br>';
                            $message .= 'Tiêu đề: ' . $post['title'] . '<br>';
                            $message .= 'Mô tả: ' . $post['description'] . '<br>';
                            $message .= 'Loại phí: ' . ($post['fee_type'] == 'free' ? 'Miễn phí' : ($post['fee_type'] == 'paid' ? 'Trả phí: ' . number_format($post['fee_amount'], 0, ',', '.') . ' VND' : 'Liên hệ')) . '<br>';
                            $message .= 'Trạng thái: ' . ($post['status'] ? 'Đã duyệt' : 'Chờ duyệt') . '<br>';
                            $message .= 'Người thêm: ' . $admin_info['username'] . '<br>';
                            $message .= 'Thời gian: ' . date('d/m/Y H:i', NV_CURRENTTIME) . '<br><br>';
                            $message .= 'Xem chi tiết: ' . NV_MY_DOMAIN . NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=sources&action=edit&id=' . $source_id . '<br><br>';
                            $message .= 'Trân trọng,<br>' . $global_config['site_name'];


                            nv_sharecode_send_email_notification($admin_info_notify['email'], $admin_name, $subject, $message);
                        }
                    }
                }

                nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&success=1');
            } else {
                $error[] = 'Lỗi khi lưu dữ liệu vào cơ sở dữ liệu';
            }
        }
    } catch (Exception $e) {
        pr($e->getMessage());
        $error[] = 'Lỗi cơ sở dữ liệu: ' . $e->getMessage();
    }
}

// Lấy dữ liệu để sửa
$row = [];
$current_tag_ids = [];
$current_keyword_ids = [];
if ($id > 0 && ($action == 'edit' || $action == '')) {
    $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $id;
    $row = $db->query($sql)->fetch();
    if (empty($row)) {
        nv_redirect_location(NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op);
    }

    // Lấy tags hiện tại
    $current_tags = nv_admin_sharecode_get_source_tags($id);
    foreach ($current_tags as $tag) {
        $current_tag_ids[] = $tag['id'];
    }

    // Lấy keywords hiện tại
    $current_keywords = nv_admin_sharecode_get_source_keywords($id);
    foreach ($current_keywords as $keyword) {
        $current_keyword_ids[] = $keyword['id'];
    }
}

// Build search conditions
$where_conditions = [];
if (!empty($array_search['q'])) {
    $where_conditions[] = "(s.title LIKE '%" . $db->dblikeescape($array_search['q']) . "%' OR s.description LIKE '%" . $db->dblikeescape($array_search['q']) . "%')";
}
if ($array_search['catid'] > 0) {
    $where_conditions[] = "s.catid=" . $array_search['catid'];
}
// Luôn filter theo status (không có option "tất cả")
$where_conditions[] = "s.status=" . $array_search['status'];
if (!empty($array_search['fee_type'])) {
    $where_conditions[] = "s.fee_type='" . $db->dblikeescape($array_search['fee_type']) . "'";
}

$sources_data = nv_admin_sharecode_get_sources($where_conditions, $page, $per_page);

// Build search form data
$type_search = [
    '' => 'Tất cả',
    'title' => 'Tiêu đề',
    'description' => 'Mô tả'
];

$status_search = [
    -1 => 'Tất cả trạng thái',
    1 => 'Hoạt động',
    0 => 'Không hoạt động'
];

$fee_type_search = [
    '' => 'Tất cả loại phí',
    'free' => 'Miễn phí',
    'paid' => 'Có phí',
    'contact' => 'Liên hệ để biết giá'
];

// Get categories for filter - use proper function to get flat list
$val_cat_content = [];
$val_cat_content[] = [
    'value' => 0,
    'title' => 'Tất cả danh mục'
];
// Get categories using a direct query to handle crashed tables
$sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories ORDER BY parentid ASC, weight ASC";
try {
    $result = $db->query($sql);
    $categories_raw = [];
    while ($row_cat = $result->fetch()) {
        $categories_raw[$row_cat['parentid']][] = $row_cat;
    }
} catch (Exception $e) {
    // Debug SQL error
    error_log("SQL Error in sources.php: " . $e->getMessage());
    $categories_raw = [];
}

if (!empty($categories_raw)) {
    $categories_tree = nv_admin_sharecode_build_category_tree($categories_raw);

    foreach ($categories_tree as $cat) {
        $level = isset($cat['level']) ? $cat['level'] : 0;
        $prefix = str_repeat('&nbsp;&nbsp;&nbsp;', $level);
        $val_cat_content[] = [
            'value' => $cat['id'],
            'title' => $prefix . $cat['title']
        ];
    }
} else {
    // If no categories exist, add a message
    $val_cat_content[] = [
        'value' => '',
        'title' => '-- Chưa có danh mục nào --'
    ];
}

// Assign template variables
$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;

// Check for success message
$success_message = '';
if ($nv_Request->get_int('success', 'get', 0) == 1) {
    $success_message = 'Lưu mã nguồn thành công';
}

$tpl->assign('SUCCESS_MESSAGE', $success_message);
$tpl->assign('SEARCH', $array_search);
$tpl->assign('TYPE_SEARCH', $type_search);
$tpl->assign('STATUS_SEARCH', $status_search);
$tpl->assign('FEE_TYPE_SEARCH', $fee_type_search);
$tpl->assign('LIST_CAT', $val_cat_content);
$tpl->assign('PER_PAGE', $per_page);
$tpl->assign('BASE_URL', $base_url);
$tpl->assign('FORM_ACTION', $base_url . ($id > 0 ? '&id=' . $id : ''));

// Prepare form data
if ($id > 0 || $action == 'add' || $action == 'edit') {
    // Form data
    $default_fields = [
        'title' => '',
        'alias' => '',
        'description' => '', // Legacy field for compatibility
        'content' => '',
        'catid' => 0,
        'download_link_type' => 'internal',
        'download_link' => '',
        'external_source_link' => '',
        'demo_link' => '',
        'fee_type' => 'free',
        'fee_amount' => 0,
        'keywords' => '',
        'avatar' => '',
        'demo_image' => '',
        'status' => 1,
        'contact_phone' => '',
        'contact_email' => '',
        'contact_skype' => '',
        'contact_telegram' => '',
        'contact_zalo' => '',
        'contact_facebook' => '',
        'contact_website' => '',
        'contact_address' => ''
    ];

    if (!empty($post)) {
        $form_data = array_merge($default_fields, $post);
        // Nếu có demo_images từ POST, sử dụng nó
        if (isset($post['demo_images']) && is_array($post['demo_images'])) {
            $form_data['demo_images_array'] = $post['demo_images'];
        } else {
            $form_data['demo_images_array'] = [''];
        }
    } elseif (!empty($row)) {
        $form_data = array_merge($default_fields, $row);
        // Parse demo_image JSON to array for display
        if (!empty($form_data['demo_image'])) {
            $demo_images_array = json_decode($form_data['demo_image'], true);
            $form_data['demo_images_array'] = is_array($demo_images_array) ? $demo_images_array : [$form_data['demo_image']];
        } else {
            $form_data['demo_images_array'] = [''];
        }
    } else {
        $form_data = $default_fields;
        $form_data['demo_images_array'] = [''];
    }
    // Process keywords for select2 display
    if ($id > 0) {
        // Lấy keywords từ bảng liên kết
        $current_keywords = nv_admin_sharecode_get_source_keywords($id);
        $form_data['keywords_array'] = [];
        foreach ($current_keywords as $keyword) {
            $form_data['keywords_array'][] = $keyword['name'];
        }
    } else {
        $form_data['keywords_array'] = [];
    }

    // Format file size for display
    if (!empty($form_data['file_size']) && $form_data['file_size'] > 0) {
        $form_data['file_size_text'] = nv_convertfromBytes($form_data['file_size']);
    }

    $tpl->assign('DATA', $form_data);
    $tpl->assign('IS_FORM', true);
    $tpl->assign('IS_EDIT', $id > 0);
    $category_options = nv_admin_sharecode_get_category_options($form_data['catid'] ?? 0);
    $tpl->assign('CATEGORY_OPTIONS', $category_options);

    // Get available tags for select2
    $available_tags = [];
    $current_tag_ids = [];

    // Get current source tags if editing
    if ($id > 0) {
        $sql = "SELECT tag_id FROM " . NV_PREFIXLANG . "_" . $module_data . "_source_tags WHERE source_id=" . $id;
        $result = $db->query($sql);
        while ($rows = $result->fetch()) {
            $current_tag_ids[] = $rows['tag_id'];
        }
    }

    // Get all available tags
    $sql = "SELECT id, name FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags ORDER BY name ASC";
    $result = $db->query($sql);
    while ($row_tag = $result->fetch()) {
        $available_tags[] = [
            'name' => $row_tag['name'],
            'selected' => in_array($row_tag['id'], $current_tag_ids)
        ];
    }

    $tpl->assign('AVAILABLE_TAGS', $available_tags);

    if (!empty($error)) {
        $tpl->assign('ERRORS', $error);
    }
} else {
    $tpl->assign('IS_FORM', false);
}

// Prepare sources list data
if (!($id > 0 || $action == 'add')) {
    $sources = [];
    if (!empty($sources_data['data'])) {
        foreach ($sources_data['data'] as $source) {
            $source['link_detail'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=detail/' . $source['alias'];
            $source['add_time_format'] = date('d/m/Y H:i', $source['add_time']);
            $source['status_text'] = $source['status'] ? 'Hoạt động' : 'Không hoạt động';
            $source['status_class'] = $source['status'] ? 'success' : 'secondary';

            if ($source['fee_type'] == 'free') {
                $source['fee_text'] = 'Miễn phí';
                $source['fee_class'] = 'success';
            } elseif ($source['fee_type'] == 'contact') {
                $source['fee_text'] = 'Liên hệ';
                $source['fee_class'] = 'info';
            } else {
                $source['fee_text'] = number_format($source['fee_amount']) . ' VNĐ';
                $source['fee_class'] = 'warning';
            }

            $source['edit_url'] = $base_url . '&action=edit&id=' . $source['id'];
            $source['checksess'] = md5(NV_CHECK_SESSION);
            $sources[] = $source;
        }
    }

    $tpl->assign('SOURCES', $sources);
    $tpl->assign('PAGINATION', nv_generate_page($base_url, $sources_data['total'], $per_page, $page));

    // Bulk actions
    $actions = [
        ['value' => 'activate', 'title' => 'Kích hoạt'],
        ['value' => 'deactivate', 'title' => 'Ngừng kích hoạt'],
        ['value' => 'delete', 'title' => 'Xóa']
    ];
    $tpl->assign('ACTIONS', $actions);
}

// Khởi tạo dữ liệu mặc định nếu chưa có
if (empty($row)) {
    $row = [
        'title' => '',
        'alias' => '',
        'description' => '',
        'content' => '',
        'catid' => 0,
        'download_link_type' => 'internal',
        'download_link' => '',
        'external_source_link' => '',
        'demo_link' => '',
        'keywords' => '',
        'fee_type' => 'free',
        'fee_amount' => 0,
        'contact_phone' => '',
        'contact_email' => '',
        'contact_skype' => '',
        'contact_telegram' => '',
        'contact_zalo' => '',
        'contact_facebook' => '',
        'contact_website' => '',
        'contact_address' => '',
        'status' => 1,
        'image' => '',
        'avatar' => '',
        'demo_image' => ''
    ];
}

// Format file size for display
if (!empty($row['file_size']) && $row['file_size'] > 0) {
    $row['file_size_text'] = nv_convertfromBytes($row['file_size']);
}

// Parse demo_image JSON to array for display
if (!empty($row['demo_image'])) {
    $demo_images_array = json_decode($row['demo_image'], true);
    $row['demo_images_array'] = is_array($demo_images_array) ? $demo_images_array : [$row['demo_image']];
} else {
    $row['demo_images_array'] = [''];
}

// Process keywords for select2 display
if ($id > 0) {
    // Lấy keywords từ bảng liên kết
    $current_keywords = nv_admin_sharecode_get_source_keywords($id);
    $row['keywords_array'] = [];
    foreach ($current_keywords as $keyword) {
        $row['keywords_array'][] = $keyword['name'];
    }
} else {
    $row['keywords_array'] = [];
}

$tpl->assign('DATA', $row);
$tpl->assign('IS_EDIT', $id > 0);
$tpl->assign('CURRENT_TAG_IDS', $current_tag_ids);
$tpl->assign('UPLOADS_DIR', NV_BASE_SITEURL . NV_UPLOADS_DIR);
$tpl->assign('MODULE_UPLOAD', $module_upload);
$tpl->assign('MODULE_CONFIG', isset($module_config[$module_name]) ? $module_config[$module_name] : []);

// Lấy danh sách categories cho dropdown với cấu trúc cha-con
$category_options_all = nv_admin_sharecode_get_category_options(0);
$tpl->assign('CATEGORY_OPTIONS_ALL', $category_options_all);

// Assign CATEGORY_OPTIONS cho tất cả trường hợp (không chỉ form)
if (!isset($category_options)) {
    $category_options = nv_admin_sharecode_get_category_options(0);
}
// Xác định và tạo các thư mục upload
$username_alias = change_alias($admin_info['username']);
$array_structure_image = [];
$array_structure_image[''] = $module_upload;
$array_structure_image['Y'] = $module_upload . '/' . date('Y');
$array_structure_image['Ym'] = $module_upload . '/' . date('Y_m');
$array_structure_image['Y_m'] = $module_upload . '/' . date('Y/m');
$array_structure_image['Ym_d'] = $module_upload . '/' . date('Y_m/d');
$array_structure_image['Y_m_d'] = $module_upload . '/' . date('Y/m/d');
$array_structure_image['username'] = $module_upload . '/' . $username_alias;

$array_structure_image['username_Y'] = $module_upload . '/' . $username_alias . '/' . date('Y');
$array_structure_image['username_Ym'] = $module_upload . '/' . $username_alias . '/' . date('Y_m');
$array_structure_image['username_Y_m'] = $module_upload . '/' . $username_alias . '/' . date('Y/m');
$array_structure_image['username_Ym_d'] = $module_upload . '/' . $username_alias . '/' . date('Y_m/d');
$array_structure_image['username_Y_m_d'] = $module_upload . '/' . $username_alias . '/' . date('Y/m/d');

$structure_upload = $module_config[$module_name]['structure_upload'] ?? 'Ym';
$currentpath = $array_structure_image[$structure_upload] ?? '';

if (file_exists(NV_UPLOADS_REAL_DIR . '/' . $currentpath)) {
    $upload_real_dir_page = NV_UPLOADS_REAL_DIR . '/' . $currentpath;
} else {
    $upload_real_dir_page = NV_UPLOADS_REAL_DIR . '/' . $module_upload;
    $e = explode('/', $currentpath);
    if (!empty($e)) {
        $cp = '';
        foreach ($e as $p) {
            if (!empty($p) and !is_dir(NV_UPLOADS_REAL_DIR . '/' . $cp . $p)) {
                $mk = nv_mkdir(NV_UPLOADS_REAL_DIR . '/' . $cp, $p);
                if ($mk[0] > 0) {
                    $upload_real_dir_page = $mk[2];
                    try {
                        $db->query('INSERT INTO ' . NV_UPLOAD_GLOBALTABLE . "_dir (dirname, time) VALUES ('" . NV_UPLOADS_DIR . '/' . $cp . $p . "', 0)");
                    } catch (PDOException $e) {
                        trigger_error($e->getMessage());
                    }
                }
            } elseif (!empty($p)) {
                $upload_real_dir_page = NV_UPLOADS_REAL_DIR . '/' . $cp . $p;
            }
            $cp .= $p . '/';
        }
    }
    $upload_real_dir_page = str_replace('\\', '/', $upload_real_dir_page);
}

$currentpath = str_replace(NV_ROOTDIR . '/', '', $upload_real_dir_page);
$uploads_dir_user = NV_UPLOADS_DIR . '/' . $module_upload;
if (!defined('NV_IS_SPADMIN') and str_contains($structure_upload, 'username')) {
    $array_currentpath = explode('/', $currentpath);
    if ($array_currentpath[2] == $username_alias) {
        $uploads_dir_user = NV_UPLOADS_DIR . '/' . $module_upload . '/' . $username_alias;
    }
}
$tpl->assign('CATEGORY_OPTIONS', $category_options);
$tpl->assign('UPLOADS_DIR_USER', $uploads_dir_user);
$tpl->assign('UPLOAD_CURRENT', $currentpath);
if (defined('NV_EDITOR')) {
    require_once NV_ROOTDIR . '/' . NV_EDITORSDIR . '/' . NV_EDITOR . '/nv.php';
}
if (defined('NV_EDITOR') and nv_function_exists('nv_aleditor')) {
    $has_editor = true;
    $tpl->registerPlugin('modifier', 'editor', 'nv_aleditor');
} else {
    $has_editor = false;
}
$tpl->assign('HAS_EDITOR', $has_editor);

// Lấy danh sách keywords cho select2
$keywords = [];
$sql = "SELECT id, name as title FROM " . NV_PREFIXLANG . "_" . $module_data . "_keywords WHERE status = 1 ORDER BY weight ASC, name ASC";
$result = $db->query($sql);
if ($result) {
    while ($keyword = $result->fetch()) {
        $keywords[] = $keyword;
    }
}
$tpl->assign('KEYWORDS', $keywords);

// Lấy danh sách tags cho select2
$tags = [];
$sql = "SELECT id, name as title FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags ORDER BY name ASC";
$result = $db->query($sql);
if ($result) {
    while ($tag = $result->fetch()) {
        $tags[] = $tag;
    }
}
$tpl->assign('TAGS', $tags);
/**
 * Generate keywords using DeepSeek AI
 */
function nv_admin_sharecode_generate_ai_keywords($title, $description, $content)
{
    global $module_config, $module_name;

    // Check if AI is configured
    if (empty($module_config[$module_name]['deekseek_base_url']) || empty($module_config[$module_name]['deekseek_api_key'])) {
        return [];
    }

    // Prepare content for AI
    $full_content = trim($title . ' ' . $description . ' ' . strip_tags($content));
    if (strlen($full_content) < 10) {
        return [];
    }

    // Limit content length to avoid API limits
    if (strlen($full_content) > 2000) {
        $full_content = substr($full_content, 0, 2000) . '...';
    }

    $prompt = "Phân tích nội dung sau và tạo ra 6-8 từ khóa tìm kiếm ngắn gọn cho sản phẩm mã nguồn. Mỗi từ khóa tối đa 20 ký tự, bao gồm công nghệ và tính năng chính. Chỉ trả về danh sách từ khóa, mỗi từ khóa trên một dòng.\n\nNội dung:\n" . $full_content;

    $data = [
        'model' => 'deepseek-chat',
        'messages' => [
            [
                'role' => 'user',
                'content' => $prompt
            ]
        ],
        'max_tokens' => 500,
        'temperature' => 0.7
    ];

    $headers = [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $module_config[$module_name]['deekseek_api_key']
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, rtrim($module_config[$module_name]['deekseek_base_url'], '/') . '/chat/completions');
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($http_code !== 200 || !$response) {
        error_log("DeepSeek API Error: HTTP $http_code - $response");
        return [];
    }

    $result = json_decode($response, true);
    if (!isset($result['choices'][0]['message']['content'])) {
        error_log("DeepSeek API Invalid Response: " . $response);
        return [];
    }

    $ai_keywords = $result['choices'][0]['message']['content'];

    // Parse keywords from AI response
    $keywords = [];
    $lines = explode("\n", $ai_keywords);

    foreach ($lines as $line) {
        $line = trim($line);
        // Remove numbering, bullets, and special characters
        $line = preg_replace('/^[\d\-\*\•\.\)\s]+/', '', $line);
        $line = trim($line, ' .,;:');

        if (!empty($line) && strlen($line) >= 2 && strlen($line) <= 20) { // Giảm từ 50 xuống 20
            $keywords[] = $line;
        }
    }

    // Remove duplicates and limit keywords
    $keywords = array_unique($keywords);
    $keywords = array_slice($keywords, 0, 8); // Giảm từ 15 xuống 8

    // Check total length to avoid database truncation
    $total_length = 0;
    $final_keywords = [];

    foreach ($keywords as $keyword) {
        $keyword_length = strlen($keyword) + 2; // +2 for comma and space
        if ($total_length + $keyword_length <= 200) { // Giới hạn 200 ký tự
            $final_keywords[] = $keyword;
            $total_length += $keyword_length;
        } else {
            break;
        }
    }

    return $final_keywords;
}

/**
 * Generate tags using DeepSeek AI
 */
function nv_admin_sharecode_generate_ai_tags($title, $description, $content)
{
    global $module_config, $module_name;

    // Check if AI is configured
    if (empty($module_config[$module_name]['deekseek_base_url']) || empty($module_config[$module_name]['deekseek_api_key'])) {
        return [];
    }

    // Prepare content for AI
    $full_content = trim($title . ' ' . $description . ' ' . strip_tags($content));
    if (strlen($full_content) < 10) {
        return [];
    }

    // Limit content length to avoid API limits
    if (strlen($full_content) > 2000) {
        $full_content = substr($full_content, 0, 2000) . '...';
    }

    $prompt = "Phân tích nội dung sau và tạo ra 4-6 tags ngắn gọn cho sản phẩm mã nguồn. Mỗi tag tối đa 15 ký tự, là từ khóa đơn giản (1-2 từ): công nghệ, loại app, tính năng. Chỉ trả về danh sách tags, mỗi tag trên một dòng.\n\nVí dụ: PHP, Laravel, Website, CRM, React\n\nNội dung:\n" . $full_content;

    $data = [
        'model' => 'deepseek-chat',
        'messages' => [
            [
                'role' => 'user',
                'content' => $prompt
            ]
        ],
        'max_tokens' => 300,
        'temperature' => 0.5
    ];

    $headers = [
        'Content-Type: application/json',
        'Authorization: Bearer ' . $module_config[$module_name]['deekseek_api_key']
    ];

    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, rtrim($module_config[$module_name]['deekseek_base_url'], '/') . '/chat/completions');
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($http_code !== 200 || !$response) {
        error_log("DeepSeek API Error (Tags): HTTP $http_code - $response");
        return [];
    }

    $result = json_decode($response, true);
    if (!isset($result['choices'][0]['message']['content'])) {
        error_log("DeepSeek API Invalid Response (Tags): " . $response);
        return [];
    }

    $ai_tags = $result['choices'][0]['message']['content'];

    // Parse tags from AI response
    $tags = [];
    $lines = explode("\n", $ai_tags);

    foreach ($lines as $line) {
        $line = trim($line);
        // Remove numbering, bullets, and special characters
        $line = preg_replace('/^[\d\-\*\•\.\)\s]+/', '', $line);
        $line = trim($line, ' .,;:');

        // Tags should be shorter than keywords
        if (!empty($line) && strlen($line) >= 2 && strlen($line) <= 15) { // Giảm từ 25 xuống 15
            $tags[] = $line;
        }
    }

    // Remove duplicates and limit tags
    $tags = array_unique($tags);
    $tags = array_slice($tags, 0, 6); // Giảm từ 12 xuống 6

    // Check total length to avoid database truncation
    $total_length = 0;
    $final_tags = [];

    foreach ($tags as $tag) {
        $tag_length = strlen($tag) + 2; // +2 for comma and space
        if ($total_length + $tag_length <= 150) { // Giới hạn 150 ký tự cho tags
            $final_tags[] = $tag;
            $total_length += $tag_length;
        } else {
            break;
        }
    }

    return $final_tags;
}

$contents = $tpl->fetch('sources.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
