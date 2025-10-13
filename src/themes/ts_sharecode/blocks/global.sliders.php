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

if (!nv_function_exists('nv_block_data_config_sliders')) {
    /**
     * nv_block_data_config_sliders()
     *
     * @param string $module
     * @param array  $data_block
     * @param array  $lang_block
     * @return string
     */
    function nv_block_data_config_sliders($module, $data_block = array(), $lang_block = array())
    {
         global $nv_Lang, $global_config, $db;

        // Khởi tạo giá trị mặc định
        if (empty($data_block) || !is_array($data_block)) {
            $data_block = array();
        }

        // Đảm bảo các key cần thiết tồn tại
        if (!isset($data_block['view_all_link'])) {
            $data_block['view_all_link'] = '';
        }
        if (!isset($data_block['view_all_text'])) {
            $data_block['view_all_text'] = 'XEM TẤT CẢ';
        }
        if (!isset($data_block['selected_cars']) || !is_array($data_block['selected_cars'])) {
            $data_block['selected_cars'] = array();
        }

        // Lấy danh sách xe từ database
        $cars_list = array();
        try {
            $sql = 'SELECT c.id, c.title, c.main_image, c.price, c.price_promotion, c.promotion_type, cat.title as category_title
                    FROM ' . NV_PREFIXLANG . '_car_interface_cars c
                    LEFT JOIN ' . NV_PREFIXLANG . '_car_interface_categories cat ON c.category_id = cat.id
                    WHERE c.status = 1
                    ORDER BY c.weight ASC, c.id DESC';
            $result = $db->query($sql);

            while ($row = $result->fetch()) {
                // Xử lý giá hiển thị
                $display_price = '';
                if ($row['promotion_type'] == 'price' && $row['price_promotion'] > 0) {
                    $display_price = number_format($row['price_promotion'], 0, ',', '.') . ' VNĐ';
                } elseif ($row['price'] > 0) {
                    $display_price = number_format($row['price'], 0, ',', '.') . ' VNĐ';
                }

                $cars_list[] = array(
                    'id' => $row['id'],
                    'title' => $row['title'],
                    'category' => $row['category_title'],
                    'main_image' => $row['main_image'],
                    'price_display' => $display_price
                );
            }
        } catch (Exception $e) {
            // Nếu bảng chưa tồn tại hoặc có lỗi, trả về mảng rỗng
        }

        // Tạo HTML cho form config
        $config_html = '
        <div class="row mb-3">
            <label for="view_all_text" class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Text nút xem tất cả:</label>
            <div class="col-sm-9">
                <input class="form-control" type="text" name="config_view_all_text" value="' . htmlspecialchars($data_block['view_all_text']) . '" placeholder="VD: XEM TẤT CẢ" id="view_all_text" />
            </div>
        </div>

        <div class="row mb-3">
            <label for="view_all_link" class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Link nút xem tất cả:</label>
            <div class="col-sm-9">
                <input class="form-control" type="text" name="config_view_all_link" value="' . htmlspecialchars($data_block['view_all_link']) . '" placeholder="VD: /car-interface/" id="view_all_link" />
            </div>
        </div>

        <div class="row mb-3">
            <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Chọn xe hiển thị:</label>
            <div class="col-sm-9">
                <div class="border rounded p-3" style="max-height: 400px; overflow-y: auto;">
                    <div class="mb-2">
                        <small class="text-muted">Chọn các xe muốn hiển thị trong slider (tối thiểu 2 xe):</small>
                    </div>';

        if (!empty($cars_list)) {
            foreach ($cars_list as $car) {
                $checked = (is_array($data_block['selected_cars']) && in_array($car['id'], $data_block['selected_cars'])) ? 'checked' : '';
                $image_display = '';
                if (!empty($car['main_image'])) {
                    $image_url = (strpos($car['main_image'], 'http') === 0) ? $car['main_image'] : $car['main_image'];
                    $image_display = '<img src="' . $image_url . '" alt="' . htmlspecialchars($car['title']) . '" class="img-thumbnail me-2" style="width: 50px; height: 35px; object-fit: cover;">';
                } else {
                    $image_display = '<div class="bg-light d-flex align-items-center justify-content-center me-2" style="width: 50px; height: 35px;"><i class="fa fa-car text-muted"></i></div>';
                }

                $config_html .= '
                    <div class="form-check mb-2">
                        <input class="form-check-input" type="checkbox" name="config_selected_cars[]" value="' . $car['id'] . '" id="car_' . $car['id'] . '" ' . $checked . '>
                        <label class="form-check-label d-flex align-items-center" for="car_' . $car['id'] . '">
                            ' . $image_display . '
                            <div>
                                <strong>' . htmlspecialchars($car['title']) . '</strong>
                                <br>
                                <small class="text-muted">' . htmlspecialchars($car['category']) . ' • ' . $car['price_display'] . '</small>
                            </div>
                        </label>
                    </div>';
            }
        } else {
            $config_html .= '
                    <div class="alert alert-warning mb-0">
                        <i class="fa fa-exclamation-triangle"></i> Chưa có xe nào trong hệ thống hoặc module Car Interface chưa được cài đặt.
                    </div>';
        }

        $config_html .= '
                </div>
                <small class="form-text text-muted mt-2">
                    <i class="fa fa-info-circle"></i> Thứ tự hiển thị sẽ theo thứ tự bạn chọn ở trên.
                </small>
            </div>
        </div>';


        return $config_html;
    }

    /**
     * nv_block_data_config_sliders_submit()
     *
     * @param string $module
     * @param array  $lang_block
     * @return array
     */
    function nv_block_data_config_sliders_submit($module, $lang_block = array())
    {
        global $nv_Request;

        $return = array();
        $return['error'] = array();
        $return['config'] = array();

        // Lấy dữ liệu từ form
        $return['config']['view_all_text'] = $nv_Request->get_title('config_view_all_text', 'post', 'XEM TẤT CẢ');
        $return['config']['view_all_link'] = $nv_Request->get_title('config_view_all_link', 'post', '');
        $return['config']['selected_cars'] = array();

        $selected_cars = $nv_Request->get_array('config_selected_cars', 'post', array());

        if (!empty($selected_cars) && is_array($selected_cars)) {
            foreach ($selected_cars as $car_id) {
                $car_id = intval($car_id);
                if ($car_id > 0) {
                    $return['config']['selected_cars'][] = $car_id;
                }
            }
        }

        // Kiểm tra có ít nhất 2 xe được chọn
        if (count($return['config']['selected_cars']) < 2) {
            $return['error'][] = 'Cần chọn ít nhất 2 xe để hiển thị slider';
        }

        return $return;
    }

    /**
     * nv_block_global_sliders()
     *
     * @param array $block_config
     * @return string
     */
    function nv_block_global_sliders($block_config)
    {
        global $global_config, $db;

        // Kiểm tra cấu hình xe được chọn
        if (empty($block_config['selected_cars']) || !is_array($block_config['selected_cars'])) {
            return '';
        }

        // Lấy thông tin xe từ database
        $cars_data = array();
        try {
            $car_ids = array_map('intval', $block_config['selected_cars']);
            $car_ids_str = implode(',', $car_ids);

            $sql = 'SELECT c.id, c.title, c.alias, c.main_image, c.price, c.price_promotion, c.promotion_type, c.promotion_text, c.description, cat.title as category_title
                    FROM ' . NV_PREFIXLANG . '_car_interface_cars c
                    LEFT JOIN ' . NV_PREFIXLANG . '_car_interface_categories cat ON c.category_id = cat.id
                    WHERE c.id IN (' . $car_ids_str . ') AND c.status = 1
                    ORDER BY FIELD(c.id, ' . $car_ids_str . ')';
            $result = $db->query($sql);

            while ($row = $result->fetch()) {
                // Xử lý giá hiển thị
                $price_display = '';
                $original_price = '';

                if ($row['promotion_type'] == 'price' && $row['price_promotion'] > 0) {
                    $price_display = number_format($row['price_promotion'], 0, ',', '.') . ' VNĐ';
                    $original_price = number_format($row['price'], 0, ',', '.') . ' VNĐ';
                } elseif ($row['price'] > 0) {
                    $price_display = number_format($row['price'], 0, ',', '.') . ' VNĐ';
                }

                // Xử lý đường dẫn ảnh
                $image_url = '';
                if (!empty($row['main_image'])) {
                    if (strpos($row['main_image'], 'http') === 0) {
                        $image_url = $row['main_image'];
                    } else {
                        $image_url = $row['main_image'];
                    }
                }

                // Tạo link chi tiết xe
                $car_link = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=car-interface&' . NV_OP_VARIABLE . '=detail/' . $row['alias'] . '-' . $row['id'] . '.html';

                $cars_data[] = array(
                    'id' => $row['id'],
                    'title' => $row['title'],
                    'description' => $row['description'],
                    'category' => $row['category_title'],
                    'image_url' => $image_url,
                    'price_display' => $price_display,
                    'original_price' => $original_price,
                    'promotion_text' => $row['promotion_text'],
                    'link_url' => $car_link
                );
            }
        } catch (Exception $e) {
            return '';
        }

        if (empty($cars_data)) {
            return '';
        }

        // Xác định theme để sử dụng
        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/global.sliders.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/global.sliders.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        // Khởi tạo template
        $xtpl = new XTemplate('global.sliders.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');

        // Gán biến chung
        $xtpl->assign('TEMPLATE', $block_theme);
        $xtpl->assign('VIEW_ALL_TEXT', !empty($block_config['view_all_text']) ? $block_config['view_all_text'] : 'XEM TẤT CẢ');
        $xtpl->assign('LOGO_SRC', NV_STATIC_URL . 'uploads/mercedes-benz-logo.svg');
        // Xử lý link xem tất cả
        if (!empty($block_config['view_all_link'])) {
            if (strpos($block_config['view_all_link'], 'http') === 0) {
                $view_all_url = $block_config['view_all_link'];
            } else {
                $view_all_url = NV_BASE_SITEURL . ltrim($block_config['view_all_link'], '/');
            }
            $xtpl->assign('VIEW_ALL_LINK', $view_all_url);
            $xtpl->parse('main.view_all');
        }

        // Gán từng xe
        foreach ($cars_data as $car) {
            $xtpl->assign('CAR', $car);

            // Hiển thị ảnh hoặc placeholder
            if (!empty($car['image_url'])) {
                $xtpl->parse('main.loop.has_image');
            } else {
                $xtpl->parse('main.loop.no_image');
            }

            // Hiển thị mô tả nếu có
            if (!empty($car['description'])) {
                $xtpl->parse('main.loop.has_description');
            }

            // Hiển thị giá gốc nếu có khuyến mãi
            if (!empty($car['original_price'])) {
                $xtpl->parse('main.loop.original_price');
            }

            // Hiển thị text khuyến mãi
            if (!empty($car['promotion_text'])) {
                $xtpl->parse('main.loop.promotion_text');
            }

            $xtpl->parse('main.loop');
        }

        $xtpl->parse('main');
        return $xtpl->text('main');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_global_sliders($block_config);
}
