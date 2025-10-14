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

if (!nv_function_exists('nv_block_sharecode_latest_config')) {
    /**
     * Build block configuration form
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_block_sharecode_latest_config($module, $data_block)
    {
        global $db, $site_mods;

        $defaults = [
            'display_mode' => 'latest',
            'num_items' => 6,
            'selected_sources' => [],
            'section_title' => 'San pham ShareCode moi nhat',
            'section_description' => 'Kham pha cac san pham ShareCode moi duoc cap nhat, lua chon thu cong hoac tu dong.'
        ];

        $data_block = array_merge($defaults, (array) $data_block);
        if (!is_array($data_block['selected_sources'])) {
            $data_block['selected_sources'] = [];
        }

        $sharecode_module = '';
        $sharecode_module_data = '';

        foreach ($site_mods as $mod_name => $mod_info) {
            if ($mod_info['module_file'] === 'sharecode') {
                $sharecode_module = $mod_name;
                $sharecode_module_data = $mod_info['module_data'];
                break;
            }
        }

        if (empty($sharecode_module) || empty($sharecode_module_data)) {
            return '<div class="alert alert-warning mb-0">Module ShareCode chua duoc cai dat hoac kich hoat, khong the cau hinh block.</div>';
        }

        $options = [];
        try {
            $sql = 'SELECT id, title, fee_type, fee_amount
                FROM ' . NV_PREFIXLANG . '_' . $sharecode_module_data . '_sources
                WHERE status = 1
                ORDER BY add_time DESC
                LIMIT 50';
            $result = $db->query($sql);
            while ($row = $result->fetch()) {
                $options[] = $row;
            }
        } catch (\PDOException $e) {
            if (defined('NV_IS_ADMIN') && NV_IS_ADMIN) {
                error_log('Block sharecode latest config - query error: ' . $e->getMessage());
            }
        }

        $selectedIds = array_map('intval', $data_block['selected_sources']);
        $selectedIds = array_values(array_unique($selectedIds));

        $latestHidden = $data_block['display_mode'] === 'latest' ? '' : ' d-none';
        $manualHidden = $data_block['display_mode'] === 'manual' ? '' : ' d-none';

        $html = [];
        $html[] = '<div class="alert alert-success d-flex align-items-center" role="alert">';
        $html[] = '    <i class="fa fa-info-circle me-2"></i>';
        $html[] = '    <span>Block này hỗ trợ hiển thị sản phẩm ShareCode mới nhất hoặc sản phẩm được chọn cụ thể (tối đa 6 sản phẩm).</span>';
        $html[] = '</div>';

        $html[] = '<div class="row mb-3">';
        $html[] = '    <label class="col-sm-3 col-form-label text-sm-end">Tiêu đề block:</label>';
        $html[] = '    <div class="col-sm-9">';
        $html[] = '        <input type="text" class="form-control" name="config_section_title" value="' . nv_htmlspecialchars($data_block['section_title']) . '" />';
        $html[] = '    </div>';
        $html[] = '</div>';

        $html[] = '<div class="row mb-3">';
        $html[] = '    <label class="col-sm-3 col-form-label text-sm-end">Mô tả ngắn:</label>';
        $html[] = '    <div class="col-sm-9">';
        $html[] = '        <textarea class="form-control" name="config_section_description" rows="2">' . nv_htmlspecialchars($data_block['section_description']) . '</textarea>';
        $html[] = '    </div>';
        $html[] = '</div>';

        $html[] = '<div class="row mb-3">';
        $html[] = '    <label class="col-sm-3 col-form-label text-sm-end">Che do hien thi:</label>';
        $html[] = '    <div class="col-sm-9">';
        $html[] = '        <div class="form-check">';
        $html[] = '            <input class="form-check-input" type="radio" name="config_display_mode" id="display_mode_latest" value="latest"' . ($data_block['display_mode'] === 'latest' ? ' checked="checked"' : '') . ' />';
        $html[] = '            <label class="form-check-label fw-semibold" for="display_mode_latest">Lấy sản phẩm cụ thể</label>';
        $html[] = '        </div>';
        $html[] = '        <div class="border rounded p-3 bg-light mt-2 ms-2' . $latestHidden . '" id="latest_mode_container">';
        $html[] = '            <label class="form-label mb-1" for="config_num_items">Số lượng sản phẩm hiển thị (1 - 12):</label>';
        $html[] = '            <input type="number" min="1" max="12" class="form-control" style="max-width: 140px;" name="config_num_items" id="config_num_items" value="' . (int) $data_block['num_items'] . '" />';
        $html[] = '            <small class="text-muted d-block mt-2">Block sẽ tự động lấy sản phẩm mới nhất theo thời gian đăng.</small>';
        $html[] = '        </div>';
        $html[] = '        <div class="form-check mt-3">';
        $html[] = '            <input class="form-check-input" type="radio" name="config_display_mode" id="display_mode_manual" value="manual"' . ($data_block['display_mode'] === 'manual' ? ' checked="checked"' : '') . ' />';
        $html[] = '            <label class="form-check-label fw-semibold" for="display_mode_manual">Chọn sản phẩm cụ thể</label>';
        $html[] = '        </div>';
        $html[] = '        <div class="border rounded p-3 bg-light mt-2 ms-2' . $manualHidden . '" id="manual_mode_container">';
        $html[] = '            <label class="form-label mb-1" for="sharecode_sources_select">Chọn san pham (toi da 6):</label>';
        $html[] = '            <select class="form-control" name="config_selected_sources[]" id="sharecode_sources_select" multiple="multiple" style="width: 100%;">';

        foreach ($options as $option) {
            $priceLabel = 'Lien he';
            if ($option['fee_type'] === 'free') {
                $priceLabel = 'Mien phi';
            } elseif ($option['fee_type'] === 'paid') {
                $priceLabel = number_format((int) $option['fee_amount']) . ' VND';
            }
            $selected = in_array((int) $option['id'], $selectedIds, true) ? ' selected="selected"' : '';
            $html[] = '                <option value="' . (int) $option['id'] . '"' . $selected . '>' . nv_htmlspecialchars($option['title']) . ' (' . $priceLabel . ')</option>';
        }

        $html[] = '            </select>';
        $html[] = '            <small class="text-muted d-block mt-2">Co the tim kiem theo ten san pham. Neu khong chon, block se hien thi san pham moi nhat.</small>';
        $html[] = '        </div>';
        $html[] = '    </div>';
        $html[] = '</div>';

        $html[] = '<script>';
        $html[] = '    (function($) {';
        $html[] = '        function toggleModeContainers() {';
        $html[] = '            var mode = $(\'input[name="config_display_mode"]:checked\').val();';
        $html[] = '            $(\'#latest_mode_container\').toggleClass(\'d-none\', mode !== \'latest\');';
        $html[] = '            $(\'#manual_mode_container\').toggleClass(\'d-none\', mode !== \'manual\');';
        $html[] = '        }';
        $html[] = '        function initSelect2() {';
        $html[] = '            $("#sharecode_sources_select").select2({';
        $html[] = '                placeholder: "Tim kiem san pham ShareCode...",';
        $html[] = '                maximumSelectionLength: 6,';
        $html[] = '                width: "100%",';
        $html[] = '                language: {';
        $html[] = '                    noResults: function() { return "Khong tim thay san pham phu hop"; },';
        $html[] = '                    searching: function() { return "Dang tim kiem..."; },';
        $html[] = '                    maximumSelected: function() { return "Chi duoc chon toi da 6 san pham"; }';
        $html[] = '                }';
        $html[] = '            });';
        $html[] = '        }';
        $html[] = '        $(document).ready(function() {';
        $html[] = '            toggleModeContainers();';
        $html[] = '            $(document).on("change", \'input[name="config_display_mode"]\', toggleModeContainers);';
        $html[] = '            if (typeof $.fn.select2 === "undefined") {';
        $html[] = '                if (!$("link[href*=\'select2\']").length) {';
        $html[] = '                    $("<link/>", {';
        $html[] = '                        rel: "stylesheet",';
        $html[] = '                        href: "' . NV_BASE_SITEURL . 'assets/js/select2/select2.min.css"';
        $html[] = '                    }).appendTo("head");';
        $html[] = '                }';
        $html[] = '                $.getScript("' . NV_BASE_SITEURL . 'assets/js/select2/select2.min.js", initSelect2);';
        $html[] = '            } else {';
        $html[] = '                initSelect2();';
        $html[] = '            }';
        $html[] = '        });';
        $html[] = '    })(jQuery);';
        $html[] = '</script>';

        return implode(PHP_EOL, $html);
    }

    /**
     * Handle block config submit
     *
     * @param string $module
     * @return array
     */
    function nv_block_sharecode_latest_config_submit($module)
    {
        global $nv_Request;

        $return = [];
        $return['error'] = [];
        $return['config'] = [];

        $displayMode = $nv_Request->get_title('config_display_mode', 'post', 'latest');
        if (!in_array($displayMode, ['latest', 'manual'], true)) {
            $displayMode = 'latest';
        }

        $numItems = $nv_Request->get_int('config_num_items', 'post', 6);
        if ($numItems < 1 || $numItems > 12) {
            $return['error'][] = 'So luong san pham phai nam trong khoang tu 1 den 12.';
            $numItems = max(1, min(12, $numItems));
            if ($numItems < 1 || $numItems > 12) {
                $numItems = 6;
            }
        }

        $selectedSources = $nv_Request->get_array('config_selected_sources', 'post', []);
        $selectedSources = array_filter($selectedSources, static function ($sourceId) {
            return is_numeric($sourceId) && (int) $sourceId > 0;
        });
        $selectedSources = array_map('intval', $selectedSources);
        $selectedSources = array_values(array_unique($selectedSources));

        if ($displayMode === 'manual') {
            if (empty($selectedSources)) {
                $return['error'][] = 'Vui long chon it nhat 1 san pham khi su dung che do chon cu the.';
            }
            if (count($selectedSources) > 6) {
                $return['error'][] = 'Khong duoc chon qua 6 san pham.';
                $selectedSources = array_slice($selectedSources, 0, 6);
            }
        }

        $return['config']['display_mode'] = $displayMode;
        $return['config']['num_items'] = $numItems;
        $return['config']['selected_sources'] = $selectedSources;
        $sectionTitle = $nv_Request->get_title('config_section_title', 'post', '', 1);
        $sectionTitle = trim($sectionTitle);
        if ($sectionTitle === '') {
            $sectionTitle = 'San pham ShareCode moi nhat';
        }
        $return['config']['section_title'] = $sectionTitle;

        $sectionDescription = $nv_Request->get_textarea('config_section_description', 'post', '');
        $sectionDescription = trim($sectionDescription);
        if ($sectionDescription === '') {
            $sectionDescription = 'Kham pha cac san pham ShareCode moi duoc cap nhat, lua chon thu cong hoac tu dong.';
        }
        $return['config']['section_description'] = $sectionDescription;

        return $return;
    }

    /**
     * Render block content
     *
     * @param array $block_config
     * @return string
     */
    function nv_block_sharecode_latest($block_config)
    {
        global $db, $global_config, $site_mods;

        $sharecode_module = '';
        $sharecode_module_data = '';

        foreach ($site_mods as $mod_name => $mod_info) {
            if ($mod_info['module_file'] === 'sharecode') {
                $sharecode_module = $mod_name;
                $sharecode_module_data = $mod_info['module_data'];
                break;
            }
        }

        if (empty($sharecode_module) || empty($sharecode_module_data)) {
            return '';
        }

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/global.sharecode_latest.tpl')) {
            $blockTheme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/global.sharecode_latest.tpl')) {
            $blockTheme = $global_config['site_theme'];
        } else {
            $blockTheme = 'default';
        }

        $displayMode = isset($block_config['display_mode']) ? $block_config['display_mode'] : 'latest';
        if (!in_array($displayMode, ['latest', 'manual'], true)) {
            $displayMode = 'latest';
        }

        $numItems = isset($block_config['num_items']) ? (int) $block_config['num_items'] : 6;
        if ($numItems < 1 || $numItems > 12) {
            $numItems = 6;
        }

        $selectedSources = [];
        if (!empty($block_config['selected_sources']) && is_array($block_config['selected_sources'])) {
            $selectedSources = array_map('intval', $block_config['selected_sources']);
            $selectedSources = array_values(array_unique($selectedSources));
            if (count($selectedSources) > 6) {
                $selectedSources = array_slice($selectedSources, 0, 6);
            }
        }

        $tableName = NV_PREFIXLANG . '_' . $sharecode_module_data . '_sources';
        $products = [];

        try {
            if ($displayMode === 'manual' && !empty($selectedSources)) {
                $idList = implode(',', $selectedSources);
                $sql = 'SELECT id, title, alias, description, avatar, demo_image, fee_type, fee_amount, num_view, num_download, avg_rating, add_time
                    FROM ' . $tableName . '
                    WHERE status = 1 AND id IN (' . $idList . ')
                    ORDER BY FIELD(id, ' . $idList . ')';
            } else {
                $sql = 'SELECT id, title, alias, description, avatar, demo_image, fee_type, fee_amount, num_view, num_download, avg_rating, add_time
                    FROM ' . $tableName . '
                    WHERE status = 1
                    ORDER BY add_time DESC
                    LIMIT ' . $numItems;
            }

            $result = $db->query($sql);
            while ($row = $result->fetch()) {
                $products[] = nv_block_sharecode_latest_prepare_item($row, $sharecode_module, $blockTheme);
            }
        } catch (\PDOException $e) {
            if (defined('NV_IS_ADMIN') && NV_IS_ADMIN) {
                error_log('Block sharecode latest - query error: ' . $e->getMessage());
            }
            return '';
        }

        if (empty($products)) {
            return '';
        }

        $xtpl = new XTemplate('global.sharecode_latest.tpl', NV_ROOTDIR . '/themes/' . $blockTheme . '/blocks');
        $xtpl->assign('BLOCK_TITLE', !empty($block_config['section_title']) ? $block_config['section_title'] : 'San pham ShareCode moi nhat');
        $xtpl->assign('BLOCK_DESCRIPTION', !empty($block_config['section_description']) ? $block_config['section_description'] : 'Kham pha cac san pham ShareCode moi duoc cap nhat, lua chon thu cong hoac tu dong.');

        foreach ($products as $index => $product) {
            $product['aos_delay'] = $index * 100;
            $xtpl->assign('PRODUCT', $product);

            if ($product['fee_type'] === 'free') {
                $xtpl->parse('main.product.free_badge');
            } elseif ($product['fee_type'] === 'contact') {
                $xtpl->parse('main.product.contact_badge');
            } else {
                $xtpl->parse('main.product.paid_badge');
            }

            $xtpl->parse('main.product');
        }

        $xtpl->parse('main');
        return $xtpl->text('main');
    }

    /**
     * Prepare product data for template
     *
     * @param array  $row
     * @param string $moduleName
     * @param string $blockTheme
     * @return array
     */
    function nv_block_sharecode_latest_prepare_item(array $row, $moduleName, $blockTheme)
    {
        $product = [];

        $product['id'] = (int) $row['id'];
        $product['title'] = nv_htmlspecialchars($row['title']);
        $product['alias'] = $row['alias'];
        $product['fee_type'] = $row['fee_type'];
        $product['avg_rating'] = number_format((float) $row['avg_rating'], 1);
        $product['num_view'] = number_format((int) $row['num_view']);
        $product['num_download'] = number_format((int) $row['num_download']);
        $product['add_time'] = nv_date('d/m/Y', (int) $row['add_time']);

        $description = !empty($row['description']) ? strip_tags($row['description']) : '';
        $product['description_short'] = nv_clean60($description, 100);

        $product['detail_url'] = nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA
            . '&' . NV_NAME_VARIABLE . '=' . $moduleName
            . '&' . NV_OP_VARIABLE . '=detail/' . $row['alias'], true);

        $product['image'] = nv_block_sharecode_latest_resolve_image($row['avatar'], $row['demo_image'], $blockTheme);

        if ($row['fee_type'] === 'paid') {
            $product['price_text'] = number_format((int) $row['fee_amount']) . ' VND';
            $product['price_color'] = '#ff9800';
            $product['fee_type'] = 'paid';
        } elseif ($row['fee_type'] === 'contact') {
            $product['price_text'] = 'Lien he';
            $product['price_color'] = '#2196f3';
            $product['fee_type'] = 'contact';
        } else {
            $product['price_text'] = 'Free';
            $product['price_color'] = '#00b894';
            $product['fee_type'] = 'free';
        }

        return $product;
    }

    /**
     * Resolve product image url with fallbacks
     *
     * @param string $avatar
     * @param string $demoImage
     * @param string $blockTheme
     * @return string
     */
    function nv_block_sharecode_latest_resolve_image($avatar, $demoImage, $blockTheme)
    {
        global $global_config;

        $candidates = [];

        if (!empty($avatar)) {
            $candidates[] = $avatar;
        }

        if (!empty($demoImage)) {
            $decoded = json_decode($demoImage, true);
            if (json_last_error() === JSON_ERROR_NONE && is_array($decoded)) {
                foreach ($decoded as $item) {
                    if (!empty($item)) {
                        $candidates[] = $item;
                    }
                }
            }
        }

        foreach ($candidates as $candidate) {
            $candidate = trim((string) $candidate);
            if ($candidate === '') {
                continue;
            }

            if (preg_match('#^https?://#i', $candidate)) {
                return $candidate;
            }

            $relative = ltrim($candidate, '/');
            if ($relative !== '' && file_exists(NV_ROOTDIR . '/' . $relative)) {
                return NV_BASE_SITEURL . $relative;
            }
        }

        $fallbacks = [];
        if (!empty($blockTheme)) {
            $fallbacks[] = 'themes/' . $blockTheme . '/images/no-image.jpg';
            $fallbacks[] = 'themes/' . $blockTheme . '/images/no_image.gif';
        }

        if (!empty($global_config['site_theme'])) {
            $fallbacks[] = 'themes/' . $global_config['site_theme'] . '/images/no-image.jpg';
            $fallbacks[] = 'themes/' . $global_config['site_theme'] . '/images/no_image.gif';
        }

        $fallbacks[] = 'themes/default/images/no-image.jpg';
        $fallbacks[] = 'themes/default/images/no_image.gif';

        foreach ($fallbacks as $fallback) {
            if (!empty($fallback) && file_exists(NV_ROOTDIR . '/' . $fallback)) {
                return NV_BASE_SITEURL . $fallback;
            }
        }

        return NV_BASE_SITEURL . 'themes/default/images/no_image.gif';
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_sharecode_latest($block_config);
}
