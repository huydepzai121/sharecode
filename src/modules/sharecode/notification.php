<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_IS_FILE_SITEINFO')) {
    exit('Stop!!!');
}

if ($data['type'] == 'source_approved') {
    $data['title'] = 'Source code "' . $data['content']['title'] . '" đã được duyệt';
    $data['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $data['module'] . '&' . NV_OP_VARIABLE . '=detail&id=' . $data['obid'];
} elseif ($data['type'] == 'source_rejected') {
    $data['title'] = 'Source code "' . $data['content']['title'] . '" đã bị từ chối';
    $data['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $data['module'] . '&' . NV_OP_VARIABLE . '=detail&id=' . $data['obid'];
} elseif ($data['type'] == 'new_review') {
    $data['title'] = 'Có đánh giá mới cho source code "' . $data['content']['title'] . '"';
    $data['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $data['module'] . '&' . NV_OP_VARIABLE . '=detail&id=' . $data['obid'];
} elseif ($data['type'] == 'purchase_success') {
    $data['title'] = 'Mua source code "' . $data['content']['title'] . '" thành công';
    $data['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=' . $data['module'] . '&' . NV_OP_VARIABLE . '=detail&id=' . $data['obid'];
}