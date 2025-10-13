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

if (!nv_function_exists('nv_contact_popup_block')) {
    /**
     * nv_contact_popup_block()
     *
     * @param array $block_config
     * @return string
     */
    function nv_contact_popup_block($block_config)
    {
        global $nv_Lang;

        $stpl = new \NukeViet\Template\NVSmarty();
        $stpl->setTemplateDir($block_config['real_path'] . '/smarty');
        $stpl->assign('LANG', $nv_Lang);
        $stpl->assign('DATE', date('m/Y'));

        return $stpl->fetch('global.contact_popup.tpl');
    }
}

if (defined('NV_SYSTEM')) {
    $content = nv_contact_popup_block($block_config);
}

