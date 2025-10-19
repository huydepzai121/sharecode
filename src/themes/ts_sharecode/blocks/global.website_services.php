<?php
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

if (!nv_function_exists('nv_block_website_services_config')) {
    /**
     * nv_block_website_services_config()
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_block_website_services_config($module, $data_block)
    {
        $html = '<div class="alert alert-info">';
        $html .= '<i class="fa fa-info-circle"></i> <strong>Lưu ý:</strong> Block sẽ tự động hiển thị 10 dịch vụ mặc định.';
        $html .= '</div>';

        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end">Tiêu đề:</label>';
        $html .= '<div class="col-sm-9">';
        $html .= '<input class="form-control" type="text" name="config_title" value="' . (isset($data_block['title']) ? $data_block['title'] : '') . '" />';
        $html .= '</div>';
        $html .= '</div>';

        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end">Mô tả:</label>';
        $html .= '<div class="col-sm-9">';
        $html .= '<textarea class="form-control" name="config_description" rows="3">' . (isset($data_block['description']) ? $data_block['description'] : '') . '</textarea>';
        $html .= '</div>';
        $html .= '</div>';

        return $html;
    }

    /**
     * nv_block_website_services_config_submit()
     *
     * @param string $module
     * @return array
     */
    function nv_block_website_services_config_submit($module)
    {
        global $nv_Request;

        $return = [];
        $return['error'] = [];
        $return['config']['title'] = $nv_Request->get_title('config_title', 'post', '');
        $return['config']['description'] = $nv_Request->get_textarea('config_description', 'post', '');
        $return['config']['services'] = $nv_Request->get_array('config_services', 'post', []);

        return $return;
    }

    /**
     * nv_block_website_services()
     *
     * @param array $block_config
     * @return string
     */
    function nv_block_website_services($block_config)
    {
        global $global_config;

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/global.website_services.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/global.website_services.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        $xtpl = new XTemplate('global.website_services.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
        $xtpl->assign('TITLE', !empty($block_config['title']) ? $block_config['title'] : 'THIẾT KẾ WEBSITE TRỌN GÓI');
        $xtpl->assign('DESCRIPTION', !empty($block_config['description']) ? $block_config['description'] : 'Chúng tôi cung cấp giải pháp thiết kế website chuyên nghiệp cho mọi lĩnh vực kinh doanh');

        $xtpl->parse('main');
        return $xtpl->text('main');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_website_services($block_config);
}
