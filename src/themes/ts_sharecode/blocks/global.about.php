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

if (!nv_function_exists('nv_block_data_config_about')) {
    /**
     * nv_block_data_config_about()
     *
     * @param string $module
     * @param array  $data_block
     * @param array  $lang_block
     * @return string
     */
    function nv_block_data_config_about($module, $data_block = array(), $lang_block = array())
    {
        global $global_config;

        if (defined('NV_EDITOR')) {
            require NV_ROOTDIR . '/' . NV_EDITORSDIR . '/' . NV_EDITOR . '/nv.php';
        }

        // Khởi tạo giá trị mặc định nếu không có
        $data_block = !empty($data_block) ? $data_block : array(
            'htmlcontent' => '',
            'images' => array('', '') // Mặc định 2 ảnh trống
        );

        // Đảm bảo có ít nhất 2 ảnh
        if (!isset($data_block['images']) || !is_array($data_block['images'])) {
            $data_block['images'] = array('', '');
        } elseif (count($data_block['images']) < 2) {
            while (count($data_block['images']) < 2) {
                $data_block['images'][] = '';
            }
        }
        $lang_block = !empty($lang_block) ? $lang_block : array('htmlcontent' => 'HTML Content');

        $htmlcontent = htmlspecialchars(nv_editor_br2nl($data_block['htmlcontent']));
        if (defined('NV_EDITOR') and nv_function_exists('nv_aleditor')) {
            $html = nv_aleditor('htmlcontent', '100%', '150px', $htmlcontent);
        } else {
            $html = '<textarea style="width: 100%" name="htmlcontent" id="htmlcontent" cols="20" rows="8">' . $htmlcontent . '</textarea>';
        }

        // Tạo HTML cho các ô chọn ảnh
        $config_html = '
        <div class="clearfix mb-3">' . $lang_block['htmlcontent'] . ':<br>' . $html . '</div>

        <div id="config_slide_box">
            <div class="row mb-3">
                <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Ảnh carousel:</label>
                <div class="col-sm-9">
                    <div id="images_container">';

        // Tạo các ô ảnh động
        foreach ($data_block['images'] as $index => $image_path) {
            $image_num = $index + 1;
            $config_html .= '
                        <div class="image-item mb-2" data-index="' . $index . '">
                            <div class="input-group">
                                <span class="input-group-text">Ảnh ' . $image_num . '</span>
                                <input class="form-control image-input" type="text" name="config_images[]" value="' . htmlspecialchars($image_path) . '" placeholder="Chọn ảnh ' . $image_num . '" />
                                <button class="btn btn-outline-secondary" onclick="nv_selectfile_image(this); return false;" data-currentpath="' . NV_UPLOADS_DIR . '" type="button">
                                    <i class="fa fa-folder-open-o"></i>
                                </button>';

            // Chỉ hiện nút xóa nếu có hơn 2 ảnh
            if (count($data_block['images']) > 2) {
                $config_html .= '
                                <button class="btn btn-outline-danger" onclick="removeImageItem(this); return false;" type="button">
                                    <i class="fa fa-trash"></i>
                                </button>';
            }

            $config_html .= '
                            </div>
                        </div>';
        }

        $config_html .= '
                    </div>
                    <button class="btn btn-outline-success btn-sm mt-2" onclick="addImageItem(); return false;" type="button">
                        <i class="fa fa-plus"></i> Thêm ảnh
                    </button>
                </div>
            </div>
        </div>

        <script>
            var imageCounter = ' . count($data_block['images']) . ';

            function nv_selectfile_image(button) {
                var input = $(button).siblings(".image-input")[0];
                var area = input.id || "image_" + Date.now();
                input.id = area;

                var path = "' . NV_UPLOADS_DIR . '";
                var currentpath = $(button).data("currentpath");
                var type = "image";
                nv_open_browse(script_name + "?" + nv_name_variable
                    + "=upload&popup=1&area=" + area + "&path="
                    + path + "&type=" + type + "&currentpath="
                    + currentpath, "NVImg", 850, 420,
                    "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
            }

            function addImageItem() {
                imageCounter++;
                var newItem = $(`
                    <div class="image-item mb-2" data-index="${imageCounter}">
                        <div class="input-group">
                            <span class="input-group-text">Ảnh ${imageCounter}</span>
                            <input class="form-control image-input" type="text" name="config_images[]" value="" placeholder="Chọn ảnh ${imageCounter}" />
                            <button class="btn btn-outline-secondary" onclick="nv_selectfile_image(this); return false;" data-currentpath="' . NV_UPLOADS_DIR . '" type="button">
                                <i class="fa fa-folder-open-o"></i>
                            </button>
                            <button class="btn btn-outline-danger" onclick="removeImageItem(this); return false;" type="button">
                                <i class="fa fa-trash"></i>
                            </button>
                        </div>
                    </div>
                `);
                $("#images_container").append(newItem);
                updateRemoveButtons();
            }

            function removeImageItem(button) {
                $(button).closest(".image-item").remove();
                updateImageLabels();
                updateRemoveButtons();
            }

            function updateImageLabels() {
                $("#images_container .image-item").each(function(index) {
                    var label = $(this).find(".input-group-text");
                    var input = $(this).find(".image-input");
                    label.text("Ảnh " + (index + 1));
                    input.attr("placeholder", "Chọn ảnh " + (index + 1));
                });
            }

            function updateRemoveButtons() {
                var totalItems = $("#images_container .image-item").length;
                if (totalItems <= 2) {
                    $(".btn-outline-danger").hide();
                } else {
                    $(".btn-outline-danger").show();
                }
            }

            // Khởi tạo
            $(document).ready(function() {
                updateRemoveButtons();
            });
        </script>';

        return $config_html;
    }

    /**
     * nv_block_data_config_about_submit()
     *
     * @param string $module
     * @param array  $lang_block
     * @return array
     */
    function nv_block_data_config_about_submit($module, $lang_block = array())
    {
        global $nv_Request;

        $htmlcontent = $nv_Request->get_editor('htmlcontent', '', NV_ALLOWED_HTML_TAGS);
        $htmlcontent = strtr($htmlcontent, [
            "\r\n" => '',
            "\r" => '',
            "\n" => ''
        ]);

        // Lấy dữ liệu từ các ô ảnh
        $images = $nv_Request->get_array('config_images', 'post', []);

        // Lọc bỏ ảnh trống và đảm bảo có ít nhất 2 ảnh
        $images = array_filter($images, function($img) {
            return !empty(trim($img));
        });

        // Đảm bảo có ít nhất 2 slot (có thể trống)
        while (count($images) < 2) {
            $images[] = '';
        }

        $return = [];
        $return['error'] = [];
        $return['config'] = [];
        $return['config']['htmlcontent'] = $htmlcontent;
        $return['config']['images'] = array_values($images); // Reset index

        return $return;
    }

    /**
     * nv_block_global_about()
     *
     * @param array $block_config
     * @return mixed
     */
    function nv_block_global_about($block_config)
    {
        global $global_config, $nv_Lang;

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/smarty/global.about.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/smarty/global.about.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        $stpl = new \NukeViet\Template\NVSmarty();
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('DATA', $block_config);
        $stpl->assign('HTML_CONTENT', $block_config['htmlcontent']);
        $stpl->assign('IMAGES', isset($block_config['images']) ? $block_config['images'] : array());
        $stpl->assign('URL', NV_STATIC_URL . 'themes/' . $block_theme);

        return $stpl->fetch('global.about.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_global_about($block_config);
}
