<?php

/**
 * NukeViet Content Management System
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
 */

namespace NukeViet\Module\wallet\Api;

use NukeViet\Api\Api;
use NukeViet\Api\ApiResult;
use NukeViet\Api\IApi;

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE')) {
    exit('Stop!!!');
}

/**
 * NukeViet\Module\wallet\Api\WalletGetBalance
 * API lấy số dư ví của user
 *
 * @package NukeViet\Module\wallet\Api
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @version 5.x
 * @access public
 */
class WalletGetBalance implements IApi
{
    private $result;

    /**
     * @return number
     */
    public static function getAdminLev()
    {
        return Api::ADMIN_LEV_MOD;
    }

    /**
     * @return string
     */
    public static function getCat()
    {
        return 'Wallet';
    }

    /**
     * setResultHander()
     *
     * @return mixed
     */
    public function setResultHander(ApiResult $result)
    {
        $this->result = $result;
    }

    /**
     * execute()
     *
     * @return mixed
     */
    public function execute()
    {
        global $db, $db_config, $module_data;

        $userid = $this->result->getParam('userid', 'int', 0);
        $currency = $this->result->getParam('currency', 'string', 'VND');

        if ($userid <= 0) {
            return $this->result->set(['status' => 'error', 'message' => 'User ID không hợp lệ']);
        }

        // Lấy thông tin số dư của user
        $sql = "SELECT money_total, money_in, money_out FROM " . $db_config['prefix'] . "_wallet_money 
                WHERE userid=" . $userid . " AND money_unit=" . $db->quote($currency) . " AND status=1";
        $balance_info = $db->query($sql)->fetch();

        if (!$balance_info) {
            // Nếu chưa có ví, tạo mới với số dư 0
            $balance_info = [
                'money_total' => 0,
                'money_in' => 0,
                'money_out' => 0
            ];
        }

        return $this->result->set([
            'status' => 'success',
            'data' => [
                'userid' => $userid,
                'currency' => $currency,
                'balance' => floatval($balance_info['money_total']),
                'total_in' => floatval($balance_info['money_in']),
                'total_out' => floatval($balance_info['money_out'])
            ]
        ]);
    }

    /**
     * @return array
     */
    public static function getParams()
    {
        return [
            'userid' => [
                'name' => 'User ID',
                'type' => 'int',
                'required' => true,
                'info' => 'ID của user cần lấy số dư'
            ],
            'currency' => [
                'name' => 'Loại tiền',
                'type' => 'string',
                'required' => false,
                'info' => 'Loại tiền tệ (mặc định: VND)'
            ]
        ];
    }

    /**
     * @return string
     */
    public static function getInfo()
    {
        return 'API lấy thông tin số dư ví của user';
    }
}
