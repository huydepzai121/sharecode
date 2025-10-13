<?php

if (!defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

if (!nv_function_exists('nv_slider_theme_slide_mini')) {
    /**
     * nv_slider_theme_slide_mini_config()
     *
     * @param string $module
     * @param array  $data_block
     * @return string
     */
    function nv_slider_theme_slide_mini_config($module, $data_block)
    {
        global $nv_Lang, $global_config;

        if (file_exists(NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/blocks/global.slider_main_mini.tpl')) {
            $block_theme = $global_config['module_theme'];
        } elseif (file_exists(NV_ROOTDIR . '/themes/' . $global_config['site_theme'] . '/blocks/global.slider_main_mini.tpl')) {
            $block_theme = $global_config['site_theme'];
        } else {
            $block_theme = 'default';
        }

        $xtpl = new XTemplate('global.slider_main_mini.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
        $xtpl->assign('LANG', $lang_block);
        $xtpl->assign('description', $nv_Lang->getModule('description'));
        $xtpl->assign('link', $nv_Lang->getModule('link'));
        $xtpl->assign('image', $nv_Lang->getModule('image'));

        if(empty($data_block['image'])){
            $data_block['image'][] = array(
                'index' => 0,
                'path' => '',
                'description' => '',
                'currentpath' => ''
            );
        }

        foreach($data_block['image'] as $index => $image){
            $image['index'] = $index;

            if(file_exists(NV_ROOTDIR . '/' . NV_UPLOADS_DIR . '/' . $image['path'])){
                $image['path'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $image['path'];
            }else{
                continue;
            }

            $image['currentpath'] = str_replace(basename($image['path']), '', $image['path']);
            $xtpl->assign('IMAGE', $image);
            if ($index > 0) {
                $xtpl->parse('config.image.show_remove');
            }
            $xtpl->parse('config.image');
        }
        $xtpl->assign('INDEX', count($data_block['image']));

        $xtpl->parse('config');
        return $xtpl->text('config');
    }

    /**
     * nv_slider_theme_slide_mini_submit()
     *
     * @param string $module
     * @return array
     */
    function nv_slider_theme_slide_mini_submit($module)
    {
        global $nv_Request;
        $return = [];
        $return['error'] = [];
        $image = $nv_Request->get_array('config_image', 'post');
        foreach($image as $index => $value){
            if(empty($value['path'])){
                unset($image[$index]);
            }else{
                $lu = strlen(NV_BASE_SITEURL . NV_UPLOADS_DIR . '/');
                $image[$index]['path'] = substr($image[$index]['path'], $lu);
            }
        }
        $return['config']['image'] = $image;
        return $return;
    }

    /**
     * nv_slider_theme_slide_mini()
     *
     * @param array $block_config
     * @return string
     */
    function nv_slider_theme_slide_mini($block_config)
    {
        global $site_mods, $nv_Lang, $global_config, $block_theme;

        $slider = [];
        if(empty($block_config['image'])){
            return '';
        }

        $block_theme = basename(realpath(__DIR__ . '/../'));
        $xtpl = new XTemplate('global.slider_main_mini.tpl', NV_ROOTDIR . '/themes/' . $block_theme . '/blocks');
        $xtpl->assign('LANG', \NukeViet\Core\Language::$lang_global);
        $xtpl->assign('LINK_URL', "/themes/" . $global_config['module_theme']);

        foreach($block_config['image'] as $index => $image){
            $image['index'] = $index;

            $image['thumb'] = '';
            if(file_exists(NV_ROOTDIR . '/' . NV_ASSETS_DIR . '/' . $image['path'])){
                $image['thumb'] = NV_BASE_SITEURL . NV_ASSETS_DIR . '/' . $image['path'];
            }

            if(file_exists(NV_ROOTDIR . '/' . NV_UPLOADS_DIR . '/' . $image['path'])){
                $image['path'] = NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $image['path'];
            }

            $xtpl->assign('IMAGE', $image);

            if(nv_is_url($image['link'])){
                $xtpl->parse('main.image.link');
            }else{
                $xtpl->parse('main.image.nolink');
            }

            $xtpl->parse('main.image');

            if(!empty($image['description'])){
                $xtpl->parse('main.description');
            }
        }

        $xtpl->parse('main');
        return $xtpl->text('main');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_slider_theme_slide_mini($block_config);
}
