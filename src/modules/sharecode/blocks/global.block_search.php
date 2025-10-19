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

if (!nv_function_exists('nv_sharecode_block_search')) {
    /**
     * nv_block_config_sharecode_search()
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_block_config_sharecode_search($module, $data_block)
    {
        global $nv_Lang;

        $html = '';
        $html .= '<tr>';
        $html .= '<td>' . $nv_Lang->getModule('show_category_filter') . '</td>';
        $html .= '<td>';
        $html .= '<input type="checkbox" value="1" name="config_show_category_filter"' . ($data_block['show_category_filter'] == 1 ? ' checked="checked"' : '') . ' />';
        $html .= '<br /><em>' . $nv_Lang->getModule('show_category_filter_note') . '</em>';
        $html .= '</td>';
        $html .= '</tr>';

        $html .= '<tr>';
        $html .= '<td>' . $nv_Lang->getModule('show_price_filter') . '</td>';
        $html .= '<td>';
        $html .= '<input type="checkbox" value="1" name="config_show_price_filter"' . ($data_block['show_price_filter'] == 1 ? ' checked="checked"' : '') . ' />';
        $html .= '<br /><em>' . $nv_Lang->getModule('show_price_filter_note') . '</em>';
        $html .= '</td>';
        $html .= '</tr>';

        return $html;
    }

    /**
     * nv_block_config_sharecode_search_submit()
     *
     * @param string $module
     * @return array
     */
    function nv_block_config_sharecode_search_submit($module)
    {
        global $nv_Request;
        $return = [];
        $return['error'] = [];
        $return['config'] = [];
        $return['config']['show_category_filter'] = $nv_Request->get_int('config_show_category_filter', 'post', 1);
        $return['config']['show_price_filter'] = $nv_Request->get_int('config_show_price_filter', 'post', 1);

        return $return;
    }

    /**
     * nv_sharecode_block_search()
     *
     * @param array $block_config
     * @return string
     */
    function nv_sharecode_block_search($block_config)
    {
        global $db, $global_config, $site_mods, $nv_Request;

        $module = $block_config['module'];
        if (!isset($site_mods[$module])) {
            return '';
        }

        $module_data = $site_mods[$module]['module_data'];
        $module_file = $site_mods[$module]['module_file'];

        $xtpl = new XTemplate('block_search.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);
        $xtpl->assign('BLOCK_CONFIG', $block_config);
        $xtpl->assign('MODULE_NAME', $module);
        $xtpl->assign('NV_LANG_VARIABLE', NV_LANG_VARIABLE);
        $xtpl->assign('NV_LANG_DATA', NV_LANG_DATA);
        $xtpl->assign('NV_NAME_VARIABLE', NV_NAME_VARIABLE);

        // Dữ liệu tìm kiếm hiện tại
        $search_data = [
            'q' => $nv_Request->get_title('q', 'get', ''),
            'category' => $nv_Request->get_int('category', 'get', 0),
            'fee_type' => $nv_Request->get_title('fee_type', 'get', ''),
            'sort' => $nv_Request->get_title('sort', 'get', '')
        ];
        $xtpl->assign('SEARCH', $search_data);

        // Categories for filter
        if ($block_config['show_category_filter']) {
            // Add "Tất cả danh mục" option
            $all_category = [
                'id' => 0,
                'title' => '📋 Tất cả danh mục',
                'selected' => ($search_data['category'] == 0) ? 'selected="selected"' : ''
            ];
            $xtpl->assign('CATEGORY', $all_category);
            $xtpl->parse('main.category_filter.category');

            // Add actual categories
            $sql = "SELECT id, title FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories WHERE status=1 ORDER BY weight ASC";
            $result = $db->query($sql);
            while ($row = $result->fetch()) {
                $row['title'] = '📁 ' . $row['title'];
                $row['selected'] = ($search_data['category'] == $row['id']) ? 'selected="selected"' : '';
                $xtpl->assign('CATEGORY', $row);
                $xtpl->parse('main.category_filter.category');
            }
            $xtpl->parse('main.category_filter');
        }

        // Fee type options
        $fee_types = [
            '' => 'Tất cả',
            'free' => '🆓 Miễn phí',
            'paid' => '💰 Có phí',
            'contact' => '📞 Liên hệ'
        ];

        foreach ($fee_types as $value => $label) {
            $fee_type_data = [
                'value' => $value,
                'label' => $label,
                'selected' => ($search_data['fee_type'] == $value) ? 'selected="selected"' : ''
            ];
            $xtpl->assign('FEE_TYPE', $fee_type_data);
            $xtpl->parse('main.fee_type');
        }

        // Sort options - chỉ parse một lần
        $sort_options = [
            'newest' => '🕒 Mới nhất',
            'popular' => '🔥 Phổ biến',
            'rating' => '⭐ Đánh giá cao',
            'price_low' => '💲 Giá thấp đến cao',
            'price_high' => '💰 Giá cao đến thấp'
        ];

        // Nếu không có sort được chọn, mặc định là newest
        $current_sort = !empty($search_data['sort']) ? $search_data['sort'] : 'newest';

        // Debug: Kiểm tra giá trị current_sort
        // error_log("Current sort: " . $current_sort);

        foreach ($sort_options as $value => $label) {
            $sort_data = [
                'value' => $value,
                'label' => $label,
                'selected' => ($current_sort == $value) ? 'selected="selected"' : ''
            ];
            $xtpl->assign('SORT_OPTION', $sort_data);
            $xtpl->parse('main.sort_option');
        }

        $xtpl->parse('main');
        return $xtpl->text('main');
    }
}

if (defined('NV_SYSTEM')) {
    global $site_mods, $module_name, $nv_Cache, $db;
    $module = $block_config['module'];
    if (isset($site_mods[$module])) {
        $content = nv_sharecode_block_search($block_config);
    }
}