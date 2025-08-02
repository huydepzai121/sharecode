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

if (!nv_function_exists('nv_sharecode_block_latest')) {
    /**
     * nv_block_config_sharecode_latest()
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_block_config_sharecode_latest($module, $data_block)
    {
        global $nv_Cache, $site_mods, $nv_Lang;

        $html = '';
        $html .= '<tr>';
        $html .= '<td>' . $nv_Lang->getModule('numrow') . '</td>';
        $html .= '<td><input type="number" name="config_numrow" class="form-control w200" min="1" max="20" value="' . $data_block['numrow'] . '"/></td>';
        $html .= '</tr>';

        $html .= '<tr>';
        $html .= '<td>' . $nv_Lang->getModule('category') . '</td>';
        $html .= '<td>';
        $html .= '<select name="config_catid" class="form-control w200">';
        $html .= '<option value="0"' . ($data_block['catid'] == 0 ? ' selected="selected"' : '') . '>' . $nv_Lang->getModule('all_categories') . '</option>';

        // Lấy danh sách categories từ cache
        $sql = 'SELECT id, title FROM ' . NV_PREFIXLANG . '_' . $site_mods[$module]['module_data'] . '_categories WHERE status=1 ORDER BY weight ASC';
        $list = $nv_Cache->db($sql, '', $module);
        foreach ($list as $l) {
            $selected = ($data_block['catid'] == $l['id']) ? ' selected="selected"' : '';
            $html .= '<option value="' . $l['id'] . '"' . $selected . '>' . $l['title'] . '</option>';
        }

        $html .= '</select>';
        $html .= '</td>';
        $html .= '</tr>';

        $html .= '<tr>';
        $html .= '<td>' . $nv_Lang->getModule('show_image') . '</td>';
        $html .= '<td>';
        $html .= '<input type="checkbox" value="1" name="config_show_image"' . ($data_block['show_image'] == 1 ? ' checked="checked"' : '') . ' />';
        $html .= '<br /><em>' . $nv_Lang->getModule('show_image_note') . '</em>';
        $html .= '</td>';
        $html .= '</tr>';

        return $html;
    }

    /**
     * nv_block_config_sharecode_latest_submit()
     *
     * @param string $module
     * @return array
     */
    function nv_block_config_sharecode_latest_submit($module)
    {
        global $nv_Request;
        $return = [];
        $return['error'] = [];
        $return['config'] = [];
        $return['config']['numrow'] = $nv_Request->get_int('config_numrow', 'post', 5);
        $return['config']['catid'] = $nv_Request->get_int('config_catid', 'post', 0);
        $return['config']['show_image'] = $nv_Request->get_int('config_show_image', 'post', 1);

        if ($return['config']['numrow'] < 1 or $return['config']['numrow'] > 20) {
            $return['error'][] = 'Số lượng hiển thị phải từ 1 đến 20';
        }

        return $return;
    }

    /**
     * nv_block_sharecode_latest()
     *
     * @param array $block_config
     * @return string
     */
    function nv_sharecode_block_latest($block_config)
    {
        global $db, $global_config, $site_mods, $nv_Cache;

        $module = $block_config['module'];
        if (!isset($site_mods[$module])) {
            return '';
        }

        $module_data = $site_mods[$module]['module_data'];
        $module_file = $site_mods[$module]['module_file'];

        $where = "s.status=1";
        if ($block_config['catid'] > 0) {
            $where .= " AND s.catid=" . $block_config['catid'];
        }

        $sql = "SELECT s.id, s.title, s.alias, s.image, s.description, s.fee_type, s.fee_amount, s.num_view, s.num_download, s.add_time,
                       c.title as category_title, c.alias as category_alias
                FROM " . NV_PREFIXLANG . "_" . $module_data . "_sources s
                LEFT JOIN " . NV_PREFIXLANG . "_" . $module_data . "_categories c ON s.catid = c.id
                WHERE " . $where . "
                ORDER BY s.add_time DESC
                LIMIT " . $block_config['numrow'];

        $result = $db->query($sql);
        $sources = [];
        while ($row = $result->fetch()) {
            $row['link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module . '&amp;' . NV_OP_VARIABLE . '=detail&amp;alias=' . $row['alias'];
            $row['category_link'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module . '&amp;' . NV_OP_VARIABLE . '=category&amp;alias=' . $row['category_alias'];
            $row['add_time_format'] = date('d/m/Y', $row['add_time']);
            $row['price_text'] = $row['fee_type'] == 'free' ? 'Miễn phí' : number_format($row['fee_amount']) . ' VNĐ';
            $row['description_short'] = nv_clean60($row['description'], 100);

            // Xử lý hình ảnh
            if (!empty($row['image']) && file_exists(NV_UPLOADS_REAL_DIR . '/' . $module . '/' . $row['image'])) {
                $row['image_url'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module . '/' . $row['image'];
            } else {
                $row['image_url'] = NV_BASE_SITEURL . 'themes/' . $global_config['site_theme'] . '/images/no-image.png';
            }

            $sources[] = $row;
        }

        if (empty($sources)) {
            return '';
        }

        $xtpl = new XTemplate('block_latest.tpl', NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/modules/' . $module_file);
        $xtpl->assign('BLOCK_CONFIG', $block_config);

        foreach ($sources as $source) {
            $xtpl->assign('SOURCE', $source);

            if ($block_config['show_image']) {
                $xtpl->parse('main.source.image');
            }

            if ($source['fee_type'] == 'free') {
                $xtpl->parse('main.source.free');
            } else {
                $xtpl->parse('main.source.paid');
            }

            $xtpl->parse('main.source');
        }

        $xtpl->parse('main');
        return $xtpl->text('main');
    }
}

if (defined('NV_SYSTEM')) {
    global $site_mods, $module_name, $nv_Cache, $db;
    $module = $block_config['module'];
    if (isset($site_mods[$module])) {
        $content = nv_sharecode_block_latest($block_config);
    }
}
