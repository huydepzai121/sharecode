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

if (!nv_function_exists('nv_block_data_config_top_new')) {
    /**
     * nv_block_data_config_top_new()
     *
     * @param string $module
     * @param array  $data_block
     * @param array  $lang_block
     * @return string
     */
    function nv_block_data_config_top_new($module, $data_block = array(), $lang_block = array())
    {
        global $global_config, $db;

        if (defined('NV_EDITOR')) {
            require NV_ROOTDIR . '/' . NV_EDITORSDIR . '/' . NV_EDITOR . '/nv.php';
        }

        // Khởi tạo giá trị mặc định nếu không có
        $data_block = !empty($data_block) ? $data_block : array(
            'selected_news' => array() // Danh sách ID bài viết được chọn
        );

        // Đảm bảo có selected_news
        if (!isset($data_block['selected_news']) || !is_array($data_block['selected_news'])) {
            $data_block['selected_news'] = array();
        }

        $lang_block = !empty($lang_block) ? $lang_block : array(
            'news_selection' => 'Chọn bài viết tin tức'
        );

        // Lấy danh sách bài viết tin tức
        $news_list = array();

            try {
                $sql = "SELECT id, title, publtime FROM " . NV_PREFIXLANG . "_news_rows WHERE status = 1 ORDER BY publtime DESC LIMIT 50";
                $result = $db->query($sql);
                while ($row = $result->fetch()) {
                    $news_list[] = $row;
                }
            } catch (Exception $e) {
                // Log error nếu cần
                if (defined('NV_IS_ADMIN') && NV_IS_ADMIN) {
                    error_log('Block top_new config - Error loading news list: ' . $e->getMessage());
                }
            }

        // Tạo HTML cho cấu hình với Select2
        $config_html = '
        <div class="row mb-3">
            <label class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium">' . $lang_block['news_selection'] . ':</label>
            <div class="col-sm-9">
                <select class="form-control" name="config_selected_news[]" id="news_select2" multiple="multiple" style="width: 100%;">';

        foreach ($news_list as $news) {
            $selected = in_array($news['id'], $data_block['selected_news']) ? 'selected' : '';
            $config_html .= '
                    <option value="' . $news['id'] . '" ' . $selected . '>' . htmlspecialchars($news['title']) . ' (' . date('d/m/Y', $news['publtime']) . ')</option>';
        }

        $config_html .= '
                </select>
                <small class="form-text text-muted mt-2">Chọn các bài viết tin tức muốn hiển thị. Có thể tìm kiếm theo tên bài viết. Nếu không chọn, sẽ lấy bài viết mới nhất.</small>
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
                    initSelect2();
                });
            } else {
                initSelect2();
            }
        });

        function initSelect2() {
            $("#news_select2").select2({
                placeholder: "Tìm kiếm và chọn bài viết...",
                allowClear: false,
                width: "100%",
                language: {
                    noResults: function() {
                        return "Không tìm thấy bài viết nào";
                    },
                    searching: function() {
                        return "Đang tìm kiếm...";
                    },
                    removeAllItems: function() {
                        return "Xóa tất cả";
                    },
                    loadingMore: function() {
                        return "Đang tải thêm...";
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
     * nv_block_data_config_top_new_submit()
     *
     * @param string $module
     * @param array  $lang_block
     * @return array
     */
    function nv_block_data_config_top_new_submit($module, $lang_block = array())
    {
        global $nv_Request;

        // Lấy dữ liệu tin tức
        $selected_news = $nv_Request->get_array('config_selected_news', 'post', []);

        // Lọc selected_news để chỉ giữ lại số nguyên
        $selected_news = array_filter($selected_news, function($id) {
            return is_numeric($id) && intval($id) > 0;
        });
        $selected_news = array_map('intval', $selected_news);

        $return = [];
        $return['error'] = [];
        $return['config'] = [];
        $return['config']['selected_news'] = array_values($selected_news);

        return $return;
    }

    /**
     * nv_block_global_top_new()
     *
     * @param array $block_config
     * @return mixed
     */
    function nv_block_global_top_new($block_config)
    {
        global $global_config, $nv_Lang, $db;

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/smarty/global.top_new.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/smarty/global.top_new.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        // Lấy dữ liệu tin tức
        $news_data = array();
        $selected_news = isset($block_config['selected_news']) ? $block_config['selected_news'] : array();

        // Kiểm tra xem có module news không
        $table_exists = false;
        try {
            $table_check = $db->query("SHOW TABLES LIKE '" . NV_PREFIXLANG . "_news_rows'");
            $table_exists = ($table_check->rowCount() > 0);
        } catch (Exception $e) {
            $table_exists = false;
        }

        if ($table_exists) {
            try {
                if (!empty($selected_news)) {
                    // Lấy các bài viết được chọn
                    $news_ids = implode(',', array_map('intval', $selected_news));
                    $sql = "SELECT id, title, alias, hometext, homeimgfile, homeimgalt, publtime, catid
                            FROM " . NV_PREFIXLANG . "_news_rows
                            WHERE status = 1 AND id IN (" . $news_ids . ")
                            ORDER BY FIELD(id, " . $news_ids . ")";
                } else {
                    // Lấy bài viết mới nhất nếu không có bài viết nào được chọn
                    $sql = "SELECT id, title, alias, hometext, homeimgfile, homeimgalt, publtime, catid
                            FROM " . NV_PREFIXLANG . "_news_rows
                            WHERE status = 1
                            ORDER BY publtime DESC
                            LIMIT 6";
                }

                $result = $db->query($sql);
                while ($row = $result->fetch()) {
                    // Xử lý ảnh
                    if (!empty($row['homeimgfile'])) {
                        $row['homeimgfile'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/news/' . $row['homeimgfile'];
                    } else {
                        $row['homeimgfile'] = NV_STATIC_URL . 'themes/' . $block_theme . '/images/no-image.jpg';
                    }

                    // Tạo URL chi tiết
                    $row['detail_url'] = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=news' . '/Tin-tuc/' . $row['alias'] . '-' . $row['id'] . $global_config['rewrite_exturl'];

                    

                    // Format ngày tháng
                    $row['publtime_formatted'] = date('d/m/Y', $row['publtime']);

                    // Cắt ngắn hometext
                    $row['hometext_short'] = nv_clean60($row['hometext'], 150);

                    $news_data[] = $row;
                }
            } catch (Exception $e) {
                // Log error nếu cần
                if (defined('NV_IS_ADMIN') && NV_IS_ADMIN) {
                    error_log('Block top_new display - Error loading news: ' . $e->getMessage());
                }
            }
        }

        $stpl = new \NukeViet\Template\NVSmarty();
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('DATA', $block_config);
        $stpl->assign('NEWS_DATA', $news_data);
        $stpl->assign('URL', NV_STATIC_URL . 'themes/' . $block_theme);
        $stpl->assign('LOGO_SRC', NV_STATIC_URL . 'uploads/mercedes-benz-logo.svg');

        return $stpl->fetch('global.top_new.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_block_global_top_new($block_config);
}
