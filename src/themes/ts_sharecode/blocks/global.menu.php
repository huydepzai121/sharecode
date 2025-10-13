<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES ., JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Jan 17, 2011 11:34:27 AM
 */

if (! defined('NV_MAINFILE')) {
    die('Stop!!!');
}

if (defined('NV_IS_FILE_THEMES')) {
    // include config theme
    require NV_ROOTDIR . '/modules/menu/menu_config.php';
}

if (!function_exists('nv_menu_pvgas')) {
    function nv_menu_pvgas($block_config)
    {
        global $nv_Cache, $global_config, $lang_global, $home, $language_array;

        $block_config['module'] = 'menu';
        $block_config['block_name'] = 'global.menu';

        $list_cats = array();
        $sql = 'SELECT id, parentid, title, link, icon, note, subitem, groups_view, module_name, op, target, css, active_type FROM ' . NV_PREFIXLANG . '_menu_rows WHERE status=1 AND mid = ' . $block_config['menuid'] . ' ORDER BY weight ASC';
        $list = $nv_Cache->db($sql, '', $block_config['module']);

        foreach ($list as $row) {
            if (nv_user_in_groups($row['groups_view'])) {
                if ($row['link'] != '' and $row['link'] != '#') {
                    $row['link'] = nv_url_rewrite(nv_unhtmlspecialchars($row['link']), true);
                    switch ($row['target']) {
                        case 1:
                            $row['target'] = '';
                            break;
                        case 3:
                            $row['target'] = ' onclick="window.open(this.href,\'targetWindow\',\'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,\');return false;"';
                            break;
                        default:
                            $row['target'] = ' onclick="this.target=\'_blank\'"';
                    }
                } else {
                    $row['target'] = '';
                }

                if (!empty($row['icon']) and file_exists(NV_UPLOADS_REAL_DIR . '/menu/' . $row['icon'])) {
                    $row['icon'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/menu/' . $row['icon'];
                } else {
                    $row['icon'] = '';
                }
                $list_cats[$row['id']] = array(
                    'id' => $row['id'],
                    'parentid' => $row['parentid'],
                    'subcats' => $row['subitem'],
                    'title' => $row['title'],
                    'title_trim' => nv_clean60($row['title'], $block_config['title_length']),
                    'target' => $row['target'],
                    'note' => empty($row['note']) ? $row['title'] : $row['note'],
                    'link' => $row['link'],
                    'icon' => $row['icon'],
                    'html_class' => $row['css'],
                    'current' => nv_menu_pvgas_check_current($row['link'], $row['active_type'])
                );
            }
        }

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/' . $block_config['block_name'] . '.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/' . $block_config['block_name'] . '.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        $xtpl = new XTemplate($block_config['block_name'] . '.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
        $xtpl->assign('LANG', $lang_global);
        $xtpl->assign('BLOCK_THEME', $block_theme);
        $xtpl->assign('BLOCK_CONFIG', $block_config);
        $xtpl->assign('IS_HOME', $home ? 'true' : 'false');
        $xtpl->assign('NV_BASE_SITEURL', NV_BASE_SITEURL);
        $xtpl->assign('SITE_NAME', $global_config['site_name']);
        $xtpl->assign('THEME_SITE_HREF', NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA);
        $xtpl->assign('THEME_SEARCH_URL', nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=seek', true));

        if (!empty($list_cats)) {
            foreach ($list_cats as $cat) {
                if (empty($cat['parentid'])) {
                    $cat['class_sub'] = '';
                    if (!empty($cat['subcats'])) {
                        $submenu_active = array();
                        $html_content = nv_smenu_pvgas($block_config['block_name'], $list_cats, $cat['subcats'], $submenu_active, $block_theme);
                        $xtpl->assign('HTML_CONTENT', $html_content);
                        if ($html_content != '') {
                            $xtpl->parse('main.loopcat1.cat2');
                            $xtpl->parse('main.loopcat1.expand');
                        }
                        if (!empty($submenu_active)) {
                            $cat['current'] = true;
                        }

                        $cat['class_sub'] = 'drop-down';
                    }

                    $cat['class'] = nv_menu_pvgas_active($cat);
                    $xtpl->assign('CAT1', $cat);
                    if (!empty($cat['icon'])) {
                        $xtpl->parse('main.loopcat1.icon');
                    }
                    $xtpl->parse('main.loopcat1');
                }
            }
            $xtpl->assign('MENUID', $block_config['bid']);
        }

        // Multiple languages
        if ($global_config['lang_multi'] and sizeof($global_config['allow_sitelangs']) > 1) {
            $xtpl->assign('LANGSITENAME_CURRENT', $language_array[NV_LANG_DATA]['name']);

            foreach ($global_config['allow_sitelangs'] as $lang_i) {
                $xtpl->assign('LANGSITEKEY', $lang_i);
                $xtpl->assign('LANGSITENAME', $language_array[$lang_i]['name']);
                $xtpl->assign('LANGSITEURL', NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . $lang_i);

                $xtpl->parse('main.language.loop');
            }

            $xtpl->parse('main.language');
        }

        $xtpl->parse('main');

        return $xtpl->text('main');
    }

    function nv_menu_pvgas_active($cat)
    {
        if ($cat['current'] === true and !$cat['html_class']) {
            $class = 'current';
        } elseif ($cat['current'] === false and $cat['html_class']) {
            $class = $cat['html_class'];
        } elseif ($cat['current'] === true and $cat['html_class']) {
            $class = $cat['html_class'] . ' current';
        } else {
            $class = '';
        }

        return $class;
    }

    function nv_menu_pvgas_check_current($url, $type = 0)
    {
        global $home, $client_info, $global_config;

        if ($client_info['selfurl'] == $url) {
            return true;
        }
        // Chinh xac tuyet doi

        $_curr_url = NV_BASE_SITEURL . str_replace($global_config['site_url'] . '/', '', $client_info['selfurl']);
        $_url = nv_url_rewrite($url, true);

        if ($home and ($_url == nv_url_rewrite(NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA) or $_url == NV_BASE_SITEURL . 'index.php' or $_url == NV_BASE_SITEURL)) {
            return true;
        } elseif ($_url != NV_BASE_SITEURL) {
            if ($type == 2) {
                if (preg_match('#' . preg_quote($_url, '#') . '#', $_curr_url)) {
                    return true;
                }
                return false;
            } elseif ($type == 1) {
                if (preg_match('#^' . preg_quote($_url, '#') . '#', $_curr_url)) {
                    return true;
                }
                return false;
            } elseif ($_curr_url == $_url) {
                return true;
            }
        }

        return false;
    }

    function nv_smenu_pvgas($style, $list_cats, $list_sub, &$submenu_active, $block_theme)
    {
        $xtpl = new XTemplate($style . '.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');

        if (empty($list_sub)) {
            return '';
        } else {
            $list = explode(',', $list_sub);

            foreach ($list_cats as $cat) {
                $catid = $cat['id'];
                if (in_array($catid, $list)) {
                    $list_cats[$catid]['class'] = nv_menu_pvgas_active($list_cats[$catid]);

                    // Thêm class drop-down nếu có menu con
                    if (!empty($list_cats[$catid]['subcats'])) {
                        $list_cats[$catid]['class'] .= ($list_cats[$catid]['class'] ? ' ' : '') . 'drop-down';
                    }

                    if ($list_cats[$catid]['current'] === true) {
                        $submenu_active[] = $catid;
                    }

                    $xtpl->assign('MENUTREE', $list_cats[$catid]);
                    if (!empty($list_cats[$catid]['icon'])) {
                        $xtpl->parse('tree.icon');
                    }

                    if (!empty($list_cats[$catid]['subcats'])) {
                        $tree = nv_smenu_pvgas($style, $list_cats, $list_cats[$catid]['subcats'], $submenu_active, $block_theme);

                        $xtpl->assign('TREE_CONTENT', $tree);
                        $xtpl->parse('tree.tree_content');
                    }

                    $xtpl->parse('tree');
                }
            }

            return $xtpl->text('tree');
        }
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_menu_pvgas($block_config);
}
