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

if (!nv_function_exists('nv_block_data_config_car_showcase')) {
    /**
     * nv_block_data_config_car_showcase()
     *
     * @param string $module
     * @param array  $data_block
     * @param array  $lang_block
     * @return string
     */
    function nv_block_data_config_car_showcase($module, $data_block = array(), $lang_block = array())
    {
        global $db;

        // Khởi tạo giá trị mặc định
        $data_block = !empty($data_block) ? $data_block : array(
            'title' => 'Chọn an toàn - chọn vững vàng êm ái!',
            'description' => 'Khám phá bộ sưu tập xe Mercedes-Benz cao cấp',
            'show_count' => 8,
            'selected_cars' => array()
        );

        // Đảm bảo có selected_cars
        if (!isset($data_block['selected_cars']) || !is_array($data_block['selected_cars'])) {
            $data_block['selected_cars'] = array();
        }

        $lang_block = !empty($lang_block) ? $lang_block : array(
            'title' => 'Tiêu đề',
            'description' => 'Mô tả',
            'show_count' => 'Số lượng xe hiển thị',
            'car_selection' => 'Chọn xe hiển thị'
        );
      
        // Lấy danh sách xe từ database
        $cars_list = array();
        try {
            $sql = "SELECT id, title, price, main_image, category_id, alias, location_address, content
                    FROM " . NV_PREFIXLANG . "_car_interface_cars
                    WHERE status = 1
                    ORDER BY id DESC
                    LIMIT 50";
            $result = $db->query($sql);
            while ($row = $result->fetch()) {
                // Xử lý mô tả ngắn từ content
                $description = '';
                if (!empty($row['content'])) {
                    $description = strip_tags($row['content']);
                    $description = mb_substr($description, 0, 100, 'UTF-8');
                    if (mb_strlen($row['content'], 'UTF-8') > 100) {
                        $description .= '...';
                    }
                }

                $cars_list[] = array(
                    'id' => $row['id'],
                    'name' => $row['title'],
                    'price' => $row['price'],
                    'image' => $row['main_image'],
                    'category' => $row['category_id'], // Sẽ cần join với bảng category để lấy tên
                    'alias' => $row['alias'],
                    'location' => $row['location_address'],
                    'description' => $description
                );
            }
        } catch (Exception $e) {
            // Fallback data nếu không có bảng cars
            $cars_list = array(
                array('id' => 1, 'name' => 'EQB 250', 'price' => '2.280.000.000', 'category' => 'XE ĐIỆN EQ', 'description' => 'Mercedes-Benz EQB 250 - SUV điện cao cấp với công nghệ tiên tiến...'),
                array('id' => 2, 'name' => 'V 250 Luxury', 'price' => '3.099.000.000', 'category' => 'V-CLASS', 'description' => 'Mercedes-Benz V 250 Luxury - Xe MPV hạng sang cho gia đình...'),
                array('id' => 3, 'name' => 'V 250 AMG', 'price' => '3.759.000.000', 'category' => 'V-CLASS', 'description' => 'Mercedes-Benz V 250 AMG - Phiên bản thể thao của dòng V-Class...'),
                array('id' => 4, 'name' => 'EQE 500 4MATIC SUV', 'price' => '3.999.000.000', 'category' => 'XE ĐIỆN EQ', 'description' => 'Mercedes-Benz EQE 500 4MATIC SUV - SUV điện hạng sang với dẫn động 4 bánh...')
            );
        }

        // Tạo HTML cho cấu hình
        $config_html = '
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $lang_block['title'] . ':</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" name="config_title" value="' . htmlspecialchars($data_block['title_new']) . '" placeholder="Nhập tiêu đề block">
            </div>
        </div>
        
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $lang_block['description'] . ':</label>
            <div class="col-sm-9">
                <textarea class="form-control" name="config_description" rows="3" placeholder="Nhập mô tả block">' . htmlspecialchars($data_block['description']) . '</textarea>
            </div>
        </div>
        
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $lang_block['show_count'] . ':</label>
            <div class="col-sm-9">
                <select class="form-control" name="config_show_count">
                    <option value="4"' . ($data_block['show_count'] == 4 ? ' selected' : '') . '>4 xe</option>
                    <option value="6"' . ($data_block['show_count'] == 6 ? ' selected' : '') . '>6 xe</option>
                    <option value="8"' . ($data_block['show_count'] == 8 ? ' selected' : '') . '>8 xe</option>
                    <option value="12"' . ($data_block['show_count'] == 12 ? ' selected' : '') . '>12 xe</option>
                </select>
            </div>
        </div>
        
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $lang_block['car_selection'] . ':</label>
            <div class="col-sm-9">
                <select class="form-control" name="config_selected_cars[]" id="cars_select2" multiple="multiple" style="width: 100%;">';
        foreach ($cars_list as $car) {
            $selected = in_array($car['id'], $data_block['selected_cars']) ? 'selected' : '';
            $price_formatted = !empty($car['price']) ? number_format($car['price'], 0, '.', '.') . ' VND' : 'Liên hệ';
            $category_name = !empty($car['category']) ? $car['category'] : 'Xe hơi';
            $config_html .= '
                    <option value="' . $car['id'] . '" ' . $selected . '>' . htmlspecialchars($car['name']) . ' - ' . $price_formatted . ' (' . htmlspecialchars($category_name) . ')</option>';
        }

        $config_html .= '
                </select>
                <small class="form-text text-muted mt-2">Chọn các xe muốn hiển thị. Nếu không chọn, sẽ lấy xe mới nhất theo số lượng đã chọn.</small>
            </div>
        </div>
        
        <script>
        // Sử dụng Select2 local
        $(document).ready(function() {
            // Load Select2 CSS local nếu chưa có
            if (!document.querySelector("link[href*=\"select2\"]")) {
                var select2CSS = document.createElement("link");
                select2CSS.rel = "stylesheet";
                select2CSS.href = "' . NV_BASE_SITEURL . 'assets/js/select2/select2.min.css";
                document.head.appendChild(select2CSS);
            }
            
            // Load Select2 JS local nếu chưa có
            if (typeof $.fn.select2 === "undefined") {
                $.getScript("' . NV_BASE_SITEURL . 'assets/js/select2/select2.min.js", function() {
                    initCarsSelect2();
                });
            } else {
                initCarsSelect2();
            }
        });
        
        function initCarsSelect2() {
            $("#cars_select2").select2({
                placeholder: "Tìm kiếm và chọn xe...",
                allowClear: false,
                width: "100%",
                language: {
                    noResults: function() {
                        return "Không tìm thấy xe nào";
                    },
                    searching: function() {
                        return "Đang tìm kiếm...";
                    },
                    removeAllItems: function() {
                        return "Xóa tất cả";
                    }
                }
            });
        }
        </script>
        
        <style>
        .select2-container {
            width: 100% !important;
        }
        .select2-container--default .select2-selection--multiple {
            min-height: 38px;
            border: 1px solid #ced4da;
            border-radius: 0.375rem;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background-color: #007bff;
            border-color: #007bff;
            color: #000 !important;
            border-radius: 0.25rem;
            padding: 2px 8px;
            margin: 2px;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice__remove {
            color: #212529 !important;
            margin-right: 5px;
        }
        .select2-container--default .select2-selection--multiple .select2-selection__choice__remove:hover {
            color: #dc3545 !important;
        }
        </style>';

        return $config_html;
    }

    /**
     * nv_block_data_config_car_showcase_submit()
     *
     * @param string $module
     * @param array  $lang_block
     * @return array
     */
    function nv_block_data_config_car_showcase_submit($module, $lang_block = array())
    {
        global $nv_Request;

        $return = [];
        $return['error'] = [];
        $return['config'] = [];

        // Lấy dữ liệu cấu hình
        $return['config']['title_new'] = $nv_Request->get_title('config_title', 'post', '');
        $return['config']['description'] = $nv_Request->get_textarea('config_description', 'post', '');
        $return['config']['show_count'] = $nv_Request->get_int('config_show_count', 'post', 8);

        // Lấy danh sách xe được chọn
        $selected_cars = $nv_Request->get_array('config_selected_cars', 'post', []);
        $selected_cars = array_filter($selected_cars, function($id) {
            return is_numeric($id) && intval($id) > 0;
        });
        $selected_cars = array_map('intval', $selected_cars);
        $return['config']['selected_cars'] = array_values($selected_cars);

        // Validate
        if (empty($return['config']['title_new'])) {
            $return['error'][] = 'Vui lòng nhập tiêu đề block';
        }

        if ($return['config']['show_count'] < 1 || $return['config']['show_count'] > 20) {
            $return['error'][] = 'Số lượng xe hiển thị phải từ 1 đến 20';
        }

        return $return;
    }

    /**
     * nv_block_global_car_showcase()
     *
     * @param array $block_config
     * @return mixed
     */
    function nv_block_global_car_showcase($block_config)
    {
        global $global_config, $nv_Lang, $db;

        // Lấy dữ liệu xe
        $cars_data = array();
        $selected_cars = isset($block_config['selected_cars']) ? $block_config['selected_cars'] : array();
        $show_count = isset($block_config['show_count']) ? intval($block_config['show_count']) : 8;

        // Kiểm tra xem có bảng car_interface_cars không
        $table_exists = false;
        try {
            $table_check = $db->query("SHOW TABLES LIKE '" . NV_PREFIXLANG . "_car_interface_cars'");
            $table_exists = ($table_check->rowCount() > 0);
        } catch (Exception $e) {
            $table_exists = false;
        }

        if ($table_exists) {
            try {
                if (!empty($selected_cars)) {
                    // Lấy các xe được chọn
                    $cars_ids = implode(',', array_map('intval', $selected_cars));
                    $sql = "SELECT id, title, price, main_image, category_id, alias, location_address, content
                            FROM " . NV_PREFIXLANG . "_car_interface_cars
                            WHERE status = 1 AND id IN (" . $cars_ids . ")
                            ORDER BY FIELD(id, " . $cars_ids . ")";
                } else {
                    // Lấy xe mới nhất nếu không có xe nào được chọn
                    $sql = "SELECT id, title, price, main_image, category_id, alias, location_address, content
                            FROM " . NV_PREFIXLANG . "_car_interface_cars
                            WHERE status = 1
                            ORDER BY id DESC
                            LIMIT " . $show_count;
                }

                $result = $db->query($sql);
                while ($row = $result->fetch()) {
                    // Xử lý ảnh
                    if (!empty($row['main_image'])) {
                        $row['image'] = $row['main_image'];
                    } else {
                        $row['image'] = NV_STATIC_URL . 'themes/' . $global_config['site_theme'] . '/images/no-image.jpg';
                    }

                    // Format giá
                    $row['price_formatted'] = !empty($row['price']) ? number_format($row['price'], 0, '.', '.') . ' VND' : 'Liên hệ';

                    // Tên xe
                    $row['name'] = $row['title'];

                    // Category (tạm thời dùng category_id, sau này có thể join với bảng category)
                    $row['category'] = 'Danh mục ' . $row['category_id'];

                    // Tạo URL chi tiết
                    $row['detail_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=car-interface&' . NV_OP_VARIABLE . '=detail/' . $row['alias'] . '-' . $row['id'] . $global_config['rewrite_exturl'];

                    // Mô tả ngắn
                    $row['description'] = !empty($row['content']) ? strip_tags(substr($row['content'], 0, 100)) . '...' : '';

                    // Thêm ngày hiển thị (sử dụng date() thay vì strftime())
                    $row['display_date'] = date('d/m/Y');

                    $cars_data[] = $row;
                }
            } catch (Exception $e) {
                // Log error nếu cần
                if (defined('NV_IS_ADMIN') && NV_IS_ADMIN) {
                    error_log('Block car_showcase display - Error loading cars: ' . $e->getMessage());
                }
            }
        } else {
            // Fallback data nếu không có bảng cars
            $fallback_cars = array(
                array('id' => 1, 'name' => 'EQB 250', 'price' => 2280000000, 'category' => 'XE ĐIỆN EQ', 'image' => '', 'description' => 'Xe điện cao cấp'),
                array('id' => 2, 'name' => 'V 250 Luxury', 'price' => 3099000000, 'category' => 'V-CLASS', 'image' => '', 'description' => 'Xe sang trọng'),
                array('id' => 3, 'name' => 'V 250 AMG', 'price' => 3759000000, 'category' => 'V-CLASS', 'image' => '', 'description' => 'Xe thể thao'),
                array('id' => 4, 'name' => 'EQE 500 4MATIC SUV', 'price' => 3999000000, 'category' => 'XE ĐIỆN EQ', 'image' => '', 'description' => 'SUV điện'),
                array('id' => 5, 'name' => 'EQS 450+', 'price' => 4839000000, 'category' => 'XE ĐIỆN EQ', 'image' => '', 'description' => 'Sedan điện'),
                array('id' => 6, 'name' => 'EQS 500 4MATIC SUV', 'price' => 4999000000, 'category' => 'XE ĐIỆN EQ', 'image' => '', 'description' => 'SUV điện cao cấp'),
                array('id' => 7, 'name' => 'EQS 450+ V1 (Hyper Screen)', 'price' => 5009000000, 'category' => 'XE ĐIỆN EQ', 'image' => '', 'description' => 'Công nghệ tiên tiến'),
                array('id' => 8, 'name' => 'EQS 500 4MATIC SUV (V1)', 'price' => 5099000000, 'category' => 'XE ĐIỆN EQ', 'image' => '', 'description' => 'Phiên bản đặc biệt')
            );

            $cars_data = array_slice($fallback_cars, 0, $show_count);
            foreach ($cars_data as &$car) {
                $car['image'] = 'https://via.placeholder.com/300x200/f8f9fa/6c757d?text=' . urlencode($car['name']);
                $car['price_formatted'] = number_format($car['price'], 0, '.', '.') . ' VND';
                $car['detail_url'] = '#';
                $car['display_date'] = date('d/m/Y');
            }
        }

        // Lấy logo từ global config
        $logo_src = '';
        if (!empty($global_config['site_logo'])) {
            $logo_src = NV_BASE_SITEURL . $global_config['site_logo'];
        }

        $stpl = new \NukeViet\Template\NVSmarty();
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('DATA', $block_config);
        $stpl->assign('CARS_DATA', $cars_data);
        $stpl->assign('LOGO_SRC', NV_STATIC_URL . 'uploads/mercedes-benz-logo.svg');

        return $stpl->fetch('global.car_showcase.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_global_car_showcase($block_config);
}
