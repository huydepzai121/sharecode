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

if (!nv_function_exists('nv_sharecode_block_categories')) {
    /**
     * nv_block_config_categories_blocks()
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_block_config_categories_blocks($module, $data_block)
    {
        global $nv_Lang;

        $html = '';
        $html .= '<div class="row mb-3">';
        $html .= '	<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $nv_Lang->getModule('numrow') . ':</label>';
        $html .= '	<div class="col-sm-9"><input type="text" name="config_numrow" class="form-control w100" size="5" value="' . $data_block['numrow'] . '"/></div>';
        $html .= '</div>';
        $html .= '<div class="row mb-3">';
        $html .= '	<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $nv_Lang->getModule('show_category_filter') . ':</label>';
        $html .= '	<div class="col-sm-9">';
        $html .= '		<input class="form-check-input" type="checkbox" value="1" name="config_show_count" ' . ($data_block['show_count'] == 1 ? 'checked="checked"' : '') . ' />';
        $html .= '		<br /><em>' . $nv_Lang->getModule('show_category_filter_note') . '</em>';
        $html .= '	</div>';
        $html .= '</div>';
        $html .= '<div class="row mb-3">';
        $html .= '	<label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $nv_Lang->getModule('show_description') . ':</label>';
        $html .= '	<div class="col-sm-9">';
        $html .= '		<input class="form-check-input" type="checkbox" value="1" name="config_show_description" ' . ($data_block['show_description'] == 1 ? 'checked="checked"' : '') . ' />';
        $html .= '		<br /><em>' . $nv_Lang->getModule('show_description_note') . '</em>';
        $html .= '	</div>';
        $html .= '</div>';

        return $html;
    }

    /**
     * nv_block_config_categories_blocks_submit()
     *
     * @param string $module
     * @return array
     */
    function nv_block_config_categories_blocks_submit($module)
    {
        global $nv_Request;
        $return = [];
        $return['error'] = [];
        $return['config'] = [];
        $return['config']['numrow'] = $nv_Request->get_int('config_numrow', 'post', 6);
        $return['config']['show_count'] = $nv_Request->get_int('config_show_count', 'post', 1);
        $return['config']['show_description'] = $nv_Request->get_int('config_show_description', 'post', 1);

        if ($return['config']['numrow'] < 1 or $return['config']['numrow'] > 20) {
            $return['error'][] = 'Số lượng hiển thị phải từ 1 đến 20';
        }

        return $return;
    }

    /**
     * nv_sharecode_block_categories()
     *
     * @param array $block_config
     * @return string
     */
    function nv_sharecode_block_categories($block_config)
    {
        global $db, $global_config, $site_mods;

        if (!isset($site_mods['sharecode'])) {
            return '';
        }

        $module_data = $site_mods['sharecode']['module_data'];
        $module_file = $site_mods['sharecode']['module_file'];

        $sql = "SELECT c.id, c.title, c.alias, c.description,
                       COUNT(s.id) as num_sources
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_categories c
                LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_sources s ON c.id = s.catid AND s.status=1
                WHERE c.status=1
                GROUP BY c.id, c.title, c.alias, c.description, c.weight
                ORDER BY c.weight ASC, num_sources DESC
                LIMIT " . $block_config['numrow'];

        $result = $db->query($sql);
        $categories = [];
        while ($row = $result->fetch()) {
            $row['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=sharecode&amp;' . NV_OP_VARIABLE . '=category&amp;alias=' . $row['alias'];
            $row['description_short'] = nv_clean60($row['description'], 80);
            $categories[] = $row;
        }

        if (empty($categories)) {
            return '';
        }

        $xtpl = new XTemplate('block_categories.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);
        $xtpl->assign('BLOCK_CONFIG', $block_config);

        foreach ($categories as $category) {
            if ($block_config['show_description'] && !empty($category['description_short'])) {
                $xtpl->assign('CATEGORY', $category);
                $xtpl->parse('main.category.description');
            }
            
            if ($block_config['show_count']) {
                $xtpl->assign('CATEGORY', $category);
                $xtpl->parse('main.category.count');
            }
            
            $xtpl->assign('CATEGORY', $category);
            $xtpl->parse('main.category');
        }

        $xtpl->parse('main');
        return $xtpl->text('main');
    }
}
