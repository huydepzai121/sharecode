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

$source_id = $nv_Request->get_int('source_id', 'post', 0);

if ($source_id <= 0) {
    echo '<div class="alert alert-danger">ID sản phẩm không hợp lệ</div>';
    exit();
}

// Lấy thông tin chi tiết sản phẩm
$sql = "SELECT s.*, c.title as category_title, u.username, u.email, u.first_name, u.last_name
        FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
        LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
        LEFT JOIN " . NV_USERS_GLOBALTABLE . " u ON s.userid = u.userid
        WHERE s.id = " . $source_id;

$source = $db->query($sql)->fetch();

if (empty($source)) {
    echo '<div class="alert alert-danger">Không tìm thấy sản phẩm</div>';
    exit();
}

// Format data
$source['add_time_format'] = date('d/m/Y H:i:s', $source['add_time']);
$source['update_time_format'] = !empty($source['update_time']) ? date('d/m/Y H:i:s', $source['update_time']) : 'Chưa cập nhật';
$source['price_text'] = $source['fee_type'] == 'free' ? 'Miễn phí' : number_format($source['fee_amount']) . ' VNĐ';

// Status
switch ($source['status']) {
    case 0:
        $source['status_text'] = 'Chờ duyệt';
        $source['status_class'] = 'warning';
        break;
    case 1:
        $source['status_text'] = 'Đã duyệt';
        $source['status_class'] = 'success';
        break;
    case -1:
        $source['status_text'] = 'Đã từ chối';
        $source['status_class'] = 'danger';
        break;
}

// Image
if (!empty($source['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $source['image'])) {
    $source['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_upload . '/' . $source['image'];
    $source['has_image'] = true;
} else {
    $source['has_image'] = false;
}

// Author info
$source['author_display'] = !empty($source['username']) ? $source['username'] : $source['username'];
$source['author_fullname'] = trim($source['first_name'] . ' ' . $source['last_name']);

// Lấy tags
$tags = [];
$sql_tags = "SELECT t.name FROM " . NV_PREFIXLANG . "_" . $module_data . "_tags t
             INNER JOIN " . NV_PREFIXLANG . "_" . $module_data . "_source_tags st ON t.id = st.tag_id
             WHERE st.source_id = " . $source_id;
$result_tags = $db->query($sql_tags);
while ($row = $result_tags->fetch()) {
    $tags[] = $row['name'];
}

$source['tags_text'] = !empty($tags) ? implode(', ', $tags) : 'Không có';

// Check file exists
$source['file_exists'] = true;
$source['file_info'] = '';
if ($source['download_link_type'] == 'file' && !empty($source['file_path'])) {
    $file_path = NV_UPLOADS_REAL_DIR . '/' . $module_upload . '/' . $source['file_path'];
    if (file_exists($file_path)) {
        $source['file_size'] = filesize($file_path);
        $source['file_size_text'] = nv_convertfromBytes($source['file_size']);
        $source['file_info'] = 'File: ' . basename($source['file_path']) . ' (' . $source['file_size_text'] . ')';
    } else {
        $source['file_exists'] = false;
        $source['file_info'] = 'File không tồn tại: ' . $source['file_path'];
    }
} elseif ($source['download_link_type'] == 'external') {
    $source['file_info'] = 'Link bên ngoài: ' . $source['download_link'];
}

?>

<div class="row">
    <div class="col-md-12">
        <!-- Basic Info -->
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h4 class="panel-title">Thông tin cơ bản</h4>
            </div>
            <div class="panel-body">
                <div class="row">
                    <?php if ($source['has_image']): ?>
                    <div class="col-md-4">
                        <img src="<?php echo $source['image_url']; ?>" alt="<?php echo $source['title']; ?>" class="img-responsive thumbnail">
                    </div>
                    <div class="col-md-8">
                    <?php else: ?>
                    <div class="col-md-12">
                    <?php endif; ?>
                        <table class="table table-bordered">
                            <tr>
                                <th width="30%">Tiêu đề</th>
                                <td><strong><?php echo $source['title']; ?></strong></td>
                            </tr>
                            <tr>
                                <th>ID</th>
                                <td><?php echo $source['id']; ?></td>
                            </tr>
                            <tr>
                                <th>Alias</th>
                                <td><?php echo $source['alias']; ?></td>
                            </tr>
                            <tr>
                                <th>Danh mục</th>
                                <td><?php echo $source['category_title']; ?></td>
                            </tr>
                            <tr>
                                <th>Giá bán</th>
                                <td>
                                    <span class="label <?php echo $source['fee_type'] == 'free' ? 'label-success' : 'label-warning'; ?>">
                                        <?php echo $source['price_text']; ?>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>Trạng thái</th>
                                <td>
                                    <span class="label label-<?php echo $source['status_class']; ?>">
                                        <?php echo $source['status_text']; ?>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Author Info -->
        <div class="panel panel-info">
            <div class="panel-heading">
                <h4 class="panel-title">Thông tin tác giả</h4>
            </div>
            <div class="panel-body">
                <table class="table table-bordered">
                    <tr>
                        <th width="30%">Tên đăng nhập</th>
                        <td><?php echo $source['author_display']; ?></td>
                    </tr>
                    <?php if (!empty($source['author_fullname'])): ?>
                    <tr>
                        <th>Họ tên</th>
                        <td><?php echo $source['author_fullname']; ?></td>
                    </tr>
                    <?php endif; ?>
                    <?php if (!empty($source['email'])): ?>
                    <tr>
                        <th>Email</th>
                        <td><?php echo $source['email']; ?></td>
                    </tr>
                    <?php endif; ?>
                    <tr>
                        <th>User ID</th>
                        <td><?php echo $source['userid']; ?></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    
    <div class="col-md-12">
        <!-- Description -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">Mô tả sản phẩm</h4>
            </div>
            <div class="panel-body">
                <div style="max-height: 200px; overflow-y: auto; padding: 10px; background: #f9f9f9; border-radius: 4px;">
                    <?php echo nl2br($source['description']); ?>
                </div>
            </div>
        </div>

        <!-- Download Info -->
        <div class="panel panel-warning">
            <div class="panel-heading">
                <h4 class="panel-title">Thông tin tải xuống</h4>
            </div>
            <div class="panel-body">
                <table class="table table-bordered">
                    <tr>
                        <th width="30%">Phương thức</th>
                        <td>
                            <?php if ($source['download_link_type'] == 'file'): ?>
                                <span class="label label-primary">Upload file</span>
                            <?php else: ?>
                                <span class="label label-info">Link bên ngoài</span>
                            <?php endif; ?>
                        </td>
                    </tr>
                    <tr>
                        <th>Chi tiết</th>
                        <td>
                            <?php if (!$source['file_exists'] && $source['download_link_type'] == 'file'): ?>
                                <span class="text-danger"><?php echo $source['file_info']; ?></span>
                            <?php else: ?>
                                <?php echo $source['file_info']; ?>
                            <?php endif; ?>
                        </td>
                    </tr>
                    <?php if (!empty($source['demo_link'])): ?>
                    <tr>
                        <th>Demo</th>
                        <td>
                            <a href="<?php echo $source['demo_link']; ?>" target="_blank" class="btn btn-xs btn-info">
                                <i class="fa fa-external-link"></i> Xem demo
                            </a>
                        </td>
                    </tr>
                    <?php endif; ?>
                </table>
            </div>
        </div>

        <!-- Additional Info -->
        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">Thông tin bổ sung</h4>
            </div>
            <div class="panel-body">
                <table class="table table-bordered">
                    <tr>
                        <th width="30%">Keywords</th>
                        <td><?php echo !empty($source['keywords']) ? $source['keywords'] : 'Không có'; ?></td>
                    </tr>
                    <tr>
                        <th>Tags</th>
                        <td><?php echo $source['tags_text']; ?></td>
                    </tr>
                    <tr>
                        <th>Ngày tạo</th>
                        <td><?php echo $source['add_time_format']; ?></td>
                    </tr>
                    <tr>
                        <th>Cập nhật</th>
                        <td><?php echo $source['update_time_format']; ?></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

<?php if ($source['status'] == 0): ?>
<div class="row">
    <div class="col-md-24">
        <div class="panel panel-success">
            <div class="panel-body text-center">
                <h4>Thao tác nhanh</h4>
                <button type="button" class="btn btn-success btn-lg" onclick="$('#detailsModal').modal('hide'); showApproveModal(<?php echo $source['id']; ?>, '<?php echo addslashes($source['title']); ?>')">
                    <i class="fa fa-check"></i> Phê duyệt ngay
                </button>
                <button type="button" class="btn btn-danger btn-lg" onclick="$('#detailsModal').modal('hide'); showRejectModal(<?php echo $source['id']; ?>, '<?php echo addslashes($source['title']); ?>')">
                    <i class="fa fa-times"></i> Từ chối
                </button>
            </div>
        </div>
    </div>
</div>
<?php endif; ?>