<?php

/**
 * NukeViet Content Management System
 * @version 4.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2021 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

if (!nv_function_exists('nv_block_data_config_vehicle_handover')) {
    /**
     * nv_block_data_config_vehicle_handover()
     *
     * @param string $module
     * @param array  $data_block
     * @param array  $lang_block
     * @return string
     */
    function nv_block_data_config_vehicle_handover($module, $data_block = array(), $lang_block = array())
    {
        global $global_config, $db;

        if (defined('NV_EDITOR')) {
            require NV_ROOTDIR . '/' . NV_EDITORSDIR . '/' . NV_EDITOR . '/nv.php';
        }

        // Khởi tạo giá trị mặc định nếu không có
        $data_block = !empty($data_block) ? $data_block : array(
            'numrow' => 6, // Số lượng bàn giao xe hiển thị
            'show_description' => 1, // Hiển thị mô tả
            'show_handover_time' => 1, // Hiển thị thời gian lấy xe
            'show_views' => 1 // Hiển thị lượt xem
        );

        // Đảm bảo có các giá trị mặc định
        if (!isset($data_block['numrow'])) {
            $data_block['numrow'] = 6;
        }
        if (!isset($data_block['show_description'])) {
            $data_block['show_description'] = 1;
        }
        if (!isset($data_block['show_handover_time'])) {
            $data_block['show_handover_time'] = 1;
        }
        if (!isset($data_block['show_views'])) {
            $data_block['show_views'] = 1;
        }

        $lang_block = !empty($lang_block) ? $lang_block : array(
            'numrow' => 'Số lượng hiển thị',
            'show_description' => 'Hiển thị mô tả',
            'show_handover_time' => 'Hiển thị thời gian lấy xe',
            'show_views' => 'Hiển thị lượt xem'
        );

        $html = '<div class="form-group">';
        $html .= '<label><strong>' . $lang_block['numrow'] . ':</strong></label>';
        $html .= '<select name="config_numrow" class="form-control w-200">';
        for ($i = 1; $i <= 20; $i++) {
            $selected = ($data_block['numrow'] == $i) ? ' selected="selected"' : '';
            $html .= '<option value="' . $i . '"' . $selected . '>' . $i . '</option>';
        }
        $html .= '</select>';
        $html .= '</div>';

        $html .= '<div class="form-group">';
        $html .= '<label><input type="checkbox" name="config_show_description" value="1"' . ($data_block['show_description'] ? ' checked="checked"' : '') . '> ' . $lang_block['show_description'] . '</label>';
        $html .= '</div>';

        $html .= '<div class="form-group">';
        $html .= '<label><input type="checkbox" name="config_show_handover_time" value="1"' . ($data_block['show_handover_time'] ? ' checked="checked"' : '') . '> ' . $lang_block['show_handover_time'] . '</label>';
        $html .= '</div>';

        $html .= '<div class="form-group">';
        $html .= '<label><input type="checkbox" name="config_show_views" value="1"' . ($data_block['show_views'] ? ' checked="checked"' : '') . '> ' . $lang_block['show_views'] . '</label>';
        $html .= '</div>';

        return $html;
    }

    /**
     * nv_block_data_config_vehicle_handover_submit()
     *
     * @param string $module
     * @param array  $lang_block
     * @return array
     */
    function nv_block_data_config_vehicle_handover_submit($module, $lang_block = array())
    {
        global $nv_Request;

        $return = [];
        $return['error'] = [];
        $return['config'] = [];
        
        $return['config']['numrow'] = $nv_Request->get_int('config_numrow', 'post', 6);
        $return['config']['show_description'] = $nv_Request->get_int('config_show_description', 'post', 0);
        $return['config']['show_handover_time'] = $nv_Request->get_int('config_show_handover_time', 'post', 0);
        $return['config']['show_views'] = $nv_Request->get_int('config_show_views', 'post', 0);

        return $return;
    }

    /**
     * nv_block_global_vehicle_handover()
     *
     * @param array $block_config
     * @return mixed
     */
    function nv_block_global_vehicle_handover($block_config)
    {
        global $global_config, $nv_Lang, $db;

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/smarty/global.vehicle_handover.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/smarty/global.vehicle_handover.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        // Lấy dữ liệu bàn giao xe
        $handover_data = array();
        $numrow = isset($block_config['numrow']) ? intval($block_config['numrow']) : 6;

        // Kiểm tra xem có module car-interface không
        $table_exists = false;
        try {
            $table_check = $db->query("SHOW TABLES LIKE '" . NV_PREFIXLANG . "_car_interface_vehicle_handover'");
            $table_exists = ($table_check->rowCount() > 0);
        } catch (Exception $e) {
            $table_exists = false;
        }

        if ($table_exists) {
            try {
                $sql = "SELECT id, title, description, main_image, gallery_images, handover_time, views, status, addtime
                        FROM " . NV_PREFIXLANG . "_car_interface_vehicle_handover
                        WHERE status = 1
                        ORDER BY handover_time DESC, addtime DESC
                        LIMIT " . $numrow;

                $result = $db->query($sql);
                while ($row = $result->fetch()) {
                    // Xử lý ảnh hiển thị
                    $row['display_image'] = '';
                    if (!empty($row['main_image']) && file_exists(NV_ROOTDIR . '/' . $row['main_image'])) {
                        $row['display_image'] = $row['main_image'];
                    } elseif (!empty($row['gallery_images'])) {
                        $images_array = explode(',', $row['gallery_images']);
                        $first_image = trim($images_array[0]);
                        if (!empty($first_image) && file_exists(NV_ROOTDIR . '/' . $first_image)) {
                            $row['display_image'] = $first_image;
                        }
                    }
                    
                    // Nếu không có ảnh nào, dùng ảnh mặc định
                    if (empty($row['display_image'])) {
                        $row['display_image'] = '/uploads/bg_bangiaoxe.jpg';
                    }

                    // Tạo URL chi tiết (có thể tùy chỉnh theo module car-interface)
                    $row['detail_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=car-interface&amp;' . NV_OP_VARIABLE . '=vehicle-handover&amp;id=' . $row['id'];

                    // Format thời gian lấy xe
                    $row['handover_time_formatted'] = date('d/m/Y H:i', $row['handover_time']);
                    $row['handover_date'] = date('d/m/Y', $row['handover_time']);
                    $row['handover_time_only'] = date('H:i', $row['handover_time']);

                    // Format thời gian thêm
                    $row['addtime_formatted'] = date('d/m/Y', $row['addtime']);

                    // Cắt ngắn mô tả
                    if (!empty($row['description'])) {
                        $row['description_short'] = nv_clean60($row['description'], 150);
                    } else {
                        $row['description_short'] = '';
                    }

                    // Format lượt xem
                    $row['views_formatted'] = number_format($row['views']);

                    $handover_data[] = $row;
                }
            } catch (Exception $e) {
                // Log error nếu cần
                if (defined('NV_IS_ADMIN') && NV_IS_ADMIN) {
                    error_log('Block vehicle_handover display - Error loading data: ' . $e->getMessage());
                }
            }
        }

        $stpl = new \NukeViet\Template\NVSmarty();
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('DATA', $block_config);
        $stpl->assign('HANDOVER_DATA', $handover_data);
        $stpl->assign('URL', NV_STATIC_URL . 'themes/' . $block_theme);
        $stpl->assign('LOGO_SRC', NV_STATIC_URL . 'uploads/mercedes-benz-logo.svg');

        return $stpl->fetch('global.vehicle_handover.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_global_vehicle_handover($block_config);
}
