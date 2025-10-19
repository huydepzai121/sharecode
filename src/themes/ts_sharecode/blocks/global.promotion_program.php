<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

if (!nv_function_exists('nv_promotion_program')) {
    /**
     * nv_promotion_program_config()
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_promotion_program_config($module, $data_block)
    {
        global $nv_Lang;

        $html = '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Tiêu đề:</label>';
        $html .= '<div class="col-sm-9"><input type="text" class="form-control" name="config_title" value="' . $data_block['title_new'] . '" placeholder="Nhập tiêu đề chương trình ưu đãi"></div>';
        $html .= '</div>';
        
        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Mô tả:</label>';
        $html .= '<div class="col-sm-9"><textarea class="form-control" name="config_description" rows="4" placeholder="Nhập mô tả chương trình ưu đãi">' . $data_block['description'] . '</textarea></div>';
        $html .= '</div>';
        
        // Ảnh 1
        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Ảnh 1:</label>';
        $html .= '<div class="col-sm-9">';
        $html .= '<div class="input-group">';
        $html .= '<input type="text" class="form-control" name="config_image1" id="config_image1" value="' . $data_block['image1'] . '" placeholder="Chọn ảnh đầu tiên">';
        $html .= '<button type="button" class="btn btn-outline-secondary" data-toggle="selectfile" data-target="config_image1" data-path="' . NV_UPLOADS_DIR . '" data-currentpath="' . NV_UPLOADS_DIR . '" data-type="image" title="Chọn ảnh"><i class="fa fa-folder-open"></i></button>';
        $html .= '</div>';
        if (!empty($data_block['image1'])) {
            $html .= '<div class="mt-2"><img src="' . NV_BASE_SITEURL . $data_block['image1'] . '" alt="Preview" style="max-width: 200px; max-height: 150px;" class="img-thumbnail"></div>';
        }
        $html .= '</div>';
        $html .= '</div>';
        
        // Ảnh 2
        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Ảnh 2:</label>';
        $html .= '<div class="col-sm-9">';
        $html .= '<div class="input-group">';
        $html .= '<input type="text" class="form-control" name="config_image2" id="config_image2" value="' . $data_block['image2'] . '" placeholder="Chọn ảnh thứ hai">';
        $html .= '<button type="button" class="btn btn-outline-secondary" data-toggle="selectfile" data-target="config_image2" data-path="' . NV_UPLOADS_DIR . '" data-currentpath="' . NV_UPLOADS_DIR . '" data-type="image" title="Chọn ảnh"><i class="fa fa-folder-open"></i></button>';
        $html .= '</div>';
        if (!empty($data_block['image2'])) {
            $html .= '<div class="mt-2"><img src="' . NV_BASE_SITEURL . $data_block['image2'] . '" alt="Preview" style="max-width: 200px; max-height: 150px;" class="img-thumbnail"></div>';
        }
        $html .= '</div>';
        $html .= '</div>';
        
        // Ảnh 3
        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Ảnh 3:</label>';
        $html .= '<div class="col-sm-9">';
        $html .= '<div class="input-group">';
        $html .= '<input type="text" class="form-control" name="config_image3" id="config_image3" value="' . $data_block['image3'] . '" placeholder="Chọn ảnh thứ ba">';
        $html .= '<button type="button" class="btn btn-outline-secondary" data-toggle="selectfile" data-target="config_image3" data-path="' . NV_UPLOADS_DIR . '" data-currentpath="' . NV_UPLOADS_DIR . '" data-type="image" title="Chọn ảnh"><i class="fa fa-folder-open"></i></button>';
        $html .= '</div>';
        if (!empty($data_block['image3'])) {
            $html .= '<div class="mt-2"><img src="' . $data_block['image3'] . '" alt="Preview" style="max-width: 200px; max-height: 150px;" class="img-thumbnail"></div>';
        }
        $html .= '</div>';
        $html .= '</div>';

        return $html;
    }

    /**
     * nv_promotion_program_submit()
     *
     * @return array
     */
    function nv_promotion_program_submit()
    {
        global $nv_Request;

        $return = [];
        $return['error'] = [];
        $return['config']['title_new'] = $nv_Request->get_title('config_title', 'post', '');
        $return['config']['description'] = $nv_Request->get_textarea('config_description', 'post', '');
        $return['config']['image1'] = $nv_Request->get_title('config_image1', 'post', '');
        $return['config']['image2'] = $nv_Request->get_title('config_image2', 'post', '');
        $return['config']['image3'] = $nv_Request->get_title('config_image3', 'post', '');
       
        // Validate required fields
        if (empty($return['config']['title_new'])) {
            $return['error'][] = 'Vui lòng nhập tiêu đề chương trình ưu đãi';
        }
        
        if (empty($return['config']['description'])) {
            $return['error'][] = 'Vui lòng nhập mô tả chương trình ưu đãi';
        }

        return $return;
    }

    /**
     * nv_promotion_program()
     *
     * @param array $block_config
     * @return string
     */
    function nv_promotion_program($block_config)
    {
        global $global_config, $nv_Lang, $global_config;

        // Xử lý ảnh
        $images = [];
        for ($i = 1; $i <= 3; $i++) {
            $image_key = 'image' . $i;
            if (!empty($block_config[$image_key])) {
                if (file_exists(NV_ROOTDIR . $block_config[$image_key])) {
                    $images[] =  $block_config[$image_key];
                }
            }
        }

        $block_config['images'] = $images;
        $block_config['has_images'] = !empty($images);
        $stpl = new \NukeViet\Template\NVSmarty();
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('DATA', $block_config);
        $stpl->assign('IMAGE1', $block_config['images'][0]);
        $stpl->assign('IMAGE2', $block_config['images'][1]);
        $stpl->assign('IMAGE3', $block_config['images'][2]);
        $stpl->assign('DATE', date('m.Y'));
        $stpl->assign('LOGO_SRC', NV_STATIC_URL . 'uploads/mercedes-benz-logo.svg');
        return $stpl->fetch('global.promotion_program.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_promotion_program($block_config);
}
