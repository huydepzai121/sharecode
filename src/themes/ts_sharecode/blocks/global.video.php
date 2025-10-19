<?php
if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

if (!nv_function_exists('nv_video_info')) {
    /**
     * nv_video_info_config()
     *
     * @return string
     */
    function nv_video_info_config($module, $data_block)
    {
        global $nv_Lang, $global_config, $lang_block;
        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/global.config_image.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/global.config_image.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        $xtpl = new XTemplate('global.config_image.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
        $xtpl->assign('LANG', $lang_block);
        $xtpl->assign('image', $nv_Lang->getModule('image'));
        $xtpl->assign('IMAGE', $data_block['image']);
        $xtpl->parse('config');
        return $xtpl->text('config');
    }

    /**
     * nv_video_info_submit()
     *
     * @return array
     */
    function nv_video_info_submit($module)
    {
        global $nv_Request;

        $return = [];
        $return['config']['image'] = $nv_Request->get_title('config_image', 'post');
        return $return;
    }

    /**
     * nv_video_info()
     *
     * @param array $block_config
     * @return string
     */
    function nv_video_info($block_config)
    {
        global $nv_Cache, $global_config, $site_mods, $nv_Lang;

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/smarty/global.video.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/smarty/global.video.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        $stpl = new \NukeViet\Template\NVSmarty();
        $url_video = 
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('DATA', $block_config);
        $stpl->assign('SITE_URL', $global_config['site_url']);
        $stpl->assign('URL_VIDEO', !empty($block_config['image']) ? $block_config['image'] : NV_STATIC_URL . 'themes/' . $global_config['site_theme'] . '/assets/img/MBC34134.webm');
        return $stpl->fetch('global.video.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_video_info($block_config);
}
