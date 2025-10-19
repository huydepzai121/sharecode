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

if (!nv_function_exists('nv_service_info_cards')) {
    /**
     * nv_service_info_cards_config()
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_service_info_cards_config($module, $data_block)
    {

        $html = '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Hotline:</label>';
        $html .= '<div class="col-sm-9"><input type="text" class="form-control" name="config_hotline" value="' . ($data_block['hotline'] ?? '0988111223') . '"></div>';
        $html .= '</div>';
        
        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Link tìm xe:</label>';
        $html .= '<div class="col-sm-9"><input type="text" class="form-control" name="config_search_link" value="' . ($data_block['search_link'] ?? '/car-interface/search') . '"></div>';
        $html .= '</div>';
        
        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Link lái thử:</label>';
        $html .= '<div class="col-sm-9"><input type="text" class="form-control" name="config_test_drive_link" value="' . ($data_block['test_drive_link'] ?? '/car-interface/test-drive') . '"></div>';
        $html .= '</div>';
        
        $html .= '<div class="row mb-3">';
        $html .= '<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">Link đặt lịch:</label>';
        $html .= '<div class="col-sm-9"><input type="text" class="form-control" name="config_booking_link" value="' . ($data_block['booking_link'] ?? '/car-interface/booking') . '"></div>';
        $html .= '</div>';

        return $html;
    }

    /**
     * nv_service_info_cards_submit()
     *
     * @return array
     */
    function nv_service_info_cards_submit()
    {
        global $nv_Request;

        $return = [];
        $return['error'] = [];
        $return['config']['hotline'] = $nv_Request->get_title('config_hotline', 'post', '0988111223');
        $return['config']['search_link'] = $nv_Request->get_title('config_search_link', 'post', '/car-interface/search');
        $return['config']['test_drive_link'] = $nv_Request->get_title('config_test_drive_link', 'post', '/car-interface/test-drive');
        $return['config']['booking_link'] = $nv_Request->get_title('config_booking_link', 'post', '/car-interface/booking');

        return $return;
    }

    /**
     * nv_service_info_cards()
     *
     * @param array $block_config
     * @return string
     */
    function nv_service_info_cards($block_config)
    {
        global $global_config, $nv_Lang;

        // Default values
        $block_config['hotline'] = $block_config['hotline'] ?? '0988111223';
        $block_config['search_link'] = $block_config['search_link'] ?? '/car-interface/search';
        $block_config['test_drive_link'] = $block_config['test_drive_link'] ?? '/car-interface/test-drive';
        $block_config['booking_link'] = $block_config['booking_link'] ?? '/car-interface/booking';

        // Build full URLs
        $block_config['hotline_url'] = 'tel:' . $block_config['hotline'];
        $block_config['search_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=car-interface&' . NV_OP_VARIABLE . '=search';
        $block_config['test_drive_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=car-interface&' . NV_OP_VARIABLE . '=test-drive';
        $block_config['booking_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=car-interface&' . NV_OP_VARIABLE . '=booking';

        $stpl = new \NukeViet\Template\NVSmarty();
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('DATA', $block_config);
        $stpl->assign('TEMPLATE', $global_config['site_theme']);
        $stpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);
        return $stpl->fetch('global.service_info_cards.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_service_info_cards($block_config);
}
