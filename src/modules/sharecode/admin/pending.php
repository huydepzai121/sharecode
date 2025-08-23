<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    exit('Stop!!!');
}

$page_title = 'Duyệt mã nguồn chờ phê duyệt';

// Use modern Smarty templating
$tpl = new \NukeViet\Template\NVSmarty();
$tpl->setTemplateDir(get_module_tpl_dir('pending.tpl'));
$tpl->assign('LANG', $nv_Lang);
$tpl->assign('MODULE_NAME', $module_name);

$action = $nv_Request->get_title('action', 'get', '');
$id = $nv_Request->get_int('id', 'get', 0);
$page = $nv_Request->get_int('page', 'get', 1);
$per_page = $nv_Request->get_int('per_page', 'get', 20);

// Search parameters
$array_search = [];
$array_search['q'] = $nv_Request->get_title('q', 'get', '');
$array_search['catid'] = $nv_Request->get_int('catid', 'get', 0);
$array_search['userid'] = $nv_Request->get_int('userid', 'get', 0);
$array_search['fee_type'] = $nv_Request->get_title('fee_type', 'get', '');

// Nếu không có action thì mặc định hiển thị danh sách
if (empty($action)) {
    $action = 'list';
}

// Xử lý duyệt/từ chối với AJAX
if ($action == 'approve' && $id > 0) {
    $checksess = $nv_Request->get_title('checksess', 'post', '');
    $note = $nv_Request->get_textarea('note', 'post', '');
    
    if ($checksess == NV_CHECK_SESSION) {
        // Lấy thông tin source
        $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $id . " AND status=0";
        $source = $db->query($sql)->fetch();
        
        if (!empty($source)) {
            try {
                $db->beginTransaction();
                
                // Cập nhật status
                $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources
                              SET status=1, edit_time=" . NV_CURRENTTIME . "
                              WHERE id=" . $id;
                $db->exec($sql_update);
                
                // Thêm thông báo cho user
                if ($source['userid'] > 0) {
                    // Gửi email thông báo
                    $sql_user = "SELECT email, username FROM " . NV_USERS_GLOBALTABLE . " WHERE userid=" . $source['userid'];
                    $user_info = $db->query($sql_user)->fetch();
                    if (!empty($user_info)) {
                        $email_subject = 'Sản phẩm được phê duyệt - ' . $global_config['site_name'];
                        $email_message = 'Chào ' . $user_info['username'] . ',<br><br>';
                        $email_message .= 'Sản phẩm "<strong>' . $source['title'] . '</strong>" của bạn đã được phê duyệt và xuất bản trên hệ thống.<br><br>';
                        if (!empty($note)) {
                            $email_message .= '<strong>Ghi chú từ admin:</strong><br>' . nl2br($note) . '<br><br>';
                        }
                        $email_message .= 'Bạn có thể xem sản phẩm tại: <a href="' . $detail_url . '">' . $detail_url . '</a><br><br>';
                        $email_message .= 'Cảm ơn bạn đã đóng góp cho cộng đồng!';
                        
                        nv_sharecode_send_email_notification($user_info['email'], $user_info['username'], $email_subject, $email_message);
                    }
                }
                
                // Ghi log
                $note_text = !empty($note) ? $note : 'Sản phẩm đã được phê duyệt';
                nv_insert_logs(NV_LANG_DATA, $module_name, 'Approve Product', 'ID: ' . $id . ' - ' . $source['title'] . ' - Note: ' . $note_text, $admin_info['userid']);
                
                $db->commit();
                
                nv_jsonOutput([
                    'status' => 'OK',
                    'mess' => 'Phê duyệt sản phẩm thành công'
                ]);
            } catch (Exception $e) {
                $db->rollback();
                nv_jsonOutput([
                    'status' => 'ERROR',
                    'mess' => 'Lỗi: ' . $e->getMessage()
                ]);
            }
        } else {
            nv_jsonOutput([
                'status' => 'ERROR',
                'mess' => 'Không tìm thấy sản phẩm hoặc sản phẩm đã được xử lý'
            ]);
        }
    } else {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Không đúng checksum'
        ]);
    }
}

// Xử lý từ chối với AJAX
if ($action == 'reject' && $id > 0) {
    $checksess = $nv_Request->get_title('checksess', 'post', '');
    $note = $nv_Request->get_textarea('note', 'post', '');
    
    if ($checksess == NV_CHECK_SESSION) {
        // Lấy thông tin source
        $sql = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources WHERE id=" . $id . " AND status=0";
        $source = $db->query($sql)->fetch();
        
        if (!empty($source)) {
            try {
                $db->beginTransaction();
                
                // Cập nhật status
                $sql_update = "UPDATE " . NV_PREFIXLANG . "_" . $module_data . "_sources 
                              SET status=-1, update_time=" . NV_CURRENTTIME . "
                              WHERE id=" . $id;
                $db->exec($sql_update);
                
                // Thêm thông báo cho user
                if ($source['userid'] > 0) {
                    // Gửi email thông báo
                    $sql_user = "SELECT email, username FROM " . NV_USERS_GLOBALTABLE . " WHERE userid=" . $source['userid'];
                    $user_info = $db->query($sql_user)->fetch();
                    if (!empty($user_info)) {
                        $email_subject = 'Sản phẩm không được phê duyệt - ' . $global_config['site_name'];
                        $email_message = 'Chào ' . $user_info['username'] . ',<br><br>';
                        $email_message .= 'Rất tiếc, sản phẩm "<strong>' . $source['title'] . '</strong>" của bạn không được phê duyệt.<br><br>';
                        if (!empty($note)) {
                            $email_message .= '<strong>Lý do:</strong><br>' . nl2br($note) . '<br><br>';
                        }
                        $email_message .= 'Bạn có thể chỉnh sửa và gửi lại sản phẩm sau khi khắc phục các vấn đề được nêu.<br><br>';
                        $email_message .= 'Cảm ơn bạn đã quan tâm đến hệ thống!';
                        
                        nv_sharecode_send_email_notification($user_info['email'], $user_info['username'], $email_subject, $email_message);
                    }
                }
                
                // Ghi log
                $note_text = !empty($note) ? $note : 'Sản phẩm bị từ chối';
                nv_insert_logs(NV_LANG_DATA, $module_name, 'Reject Product', 'ID: ' . $id . ' - ' . $source['title'] . ' - Note: ' . $note_text, $admin_info['userid']);
                
                $db->commit();
                
                nv_jsonOutput([
                    'status' => 'OK',
                    'mess' => 'Từ chối sản phẩm thành công'
                ]);
            } catch (Exception $e) {
                $db->rollback();
                nv_jsonOutput([
                    'status' => 'ERROR',
                    'mess' => 'Lỗi: ' . $e->getMessage()
                ]);
            }
        } else {
            nv_jsonOutput([
                'status' => 'ERROR',
                'mess' => 'Không tìm thấy sản phẩm hoặc sản phẩm đã được xử lý'
            ]);
        }
    } else {
        nv_jsonOutput([
            'status' => 'ERROR',
            'mess' => 'Không đúng checksum'
        ]);
    }
}

// Hiển thị danh sách sản phẩm chờ duyệt
if ($action == 'list') {
    $offset = ($page - 1) * $per_page;
    
    // Build WHERE conditions
    $where_conditions = ['s.status = 0'];
    $search_params = [];
    
    if (!empty($array_search['q'])) {
        $where_conditions[] = "(s.title LIKE :q OR s.description LIKE :q OR s.keywords LIKE :q)";
        $search_params['q'] = '%' . $array_search['q'] . '%';
    }
    
    if ($array_search['catid'] > 0) {
        $where_conditions[] = "s.catid = :catid";
        $search_params['catid'] = $array_search['catid'];
    }
    
    if ($array_search['userid'] > 0) {
        $where_conditions[] = "s.userid = :userid";
        $search_params['userid'] = $array_search['userid'];
    }
    
    if (!empty($array_search['fee_type'])) {
        $where_conditions[] = "s.fee_type = :fee_type";
        $search_params['fee_type'] = $array_search['fee_type'];
    }
    
    $where_clause = implode(' AND ', $where_conditions);
    
    // Get total count
    $sql_count = "SELECT COUNT(*) FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s WHERE " . $where_clause;
    $stmt_count = $db->prepare($sql_count);
    foreach ($search_params as $key => $value) {
        $stmt_count->bindValue(':' . $key, $value);
    }
    $stmt_count->execute();
    $total_items = $stmt_count->fetchColumn();
    
    // Get items
    $sources = [];
    if ($total_items > 0) {
        $sql = "SELECT s.*, c.title as category_title 
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
                LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
                WHERE " . $where_clause . "
                ORDER BY s.add_time DESC
                LIMIT " . $offset . ", " . $per_page;
        
        $stmt = $db->prepare($sql);
        foreach ($search_params as $key => $value) {
            $stmt->bindValue(':' . $key, $value);
        }
        $stmt->execute();
        
        while ($row = $stmt->fetch()) {
            $row['add_time_format'] = nv_date('d/m/Y H:i', $row['add_time']);
            $row['add_time_hour'] = nv_date('H:i', $row['add_time']);
            $row['price_format'] = ($row['fee_type'] == 'free') ? 'Miễn phí' : number_format($row['fee_amount']) . ' VND';
            $row['username'] = empty($row['username']) ? 'Guest' : $row['username'];
            
            // Process keywords - trim and split
            if (!empty($row['keywords'])) {
                $keywords_array = array_map('trim', explode(',', $row['keywords']));
                $row['keywords_array'] = array_filter($keywords_array); // Remove empty values
            } else {
                $row['keywords_array'] = [];
            }
            
            $sources[] = $row;
        }
    }
    
    // Get categories for filter
    $categories = [];
    $sql_cats = "SELECT id, title FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE status=1 ORDER BY weight ASC";
    $result_cats = $db->query($sql_cats);
    while ($row = $result_cats->fetch()) {
        $categories[] = $row;
    }
    
    // Pagination
    $base_url = NV_BASE_ADMINURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op;
    $generate_page = nv_generate_page($base_url, $total_items, $per_page, $page);
    
    // Calculate pagination info
    $start_item = ($page - 1) * $per_page + 1;
    $end_item = min($page * $per_page, $total_items);
    
    // Assign to template
    $tpl->assign('SOURCES', $sources);
    $tpl->assign('CATEGORIES', $categories);
    $tpl->assign('SEARCH', $array_search);
    $tpl->assign('TOTAL_ITEMS', $total_items);
    $tpl->assign('GENERATE_PAGE', $generate_page);
    $tpl->assign('PER_PAGE', $per_page);
    $tpl->assign('PAGE', $page);
    $tpl->assign('START_ITEM', $start_item);
    $tpl->assign('END_ITEM', $end_item);
    $tpl->assign('BASE_URL', $base_url);
    $tpl->assign('NV_CHECK_SESSION', NV_CHECK_SESSION);
}

// Hiển thị template
$contents = $tpl->fetch('pending.tpl');

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';