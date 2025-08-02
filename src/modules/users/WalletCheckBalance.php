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
 * NukeViet\Module\wallet\Api\WalletCheckBalance
 * API kiểm tra số dư ví của user
 *
 * @package NukeViet\Module\wallet\Api
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @version 5.x
 * @access public
 */
class WalletCheckBalance implements IApi
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
        $amount = $this->result->getParam('amount', 'float', 0);
        $currency = $this->result->getParam('currency', 'string', 'VND');

        if ($userid <= 0) {
            return $this->result->set(['status' => 'error', 'message' => 'User ID không hợp lệ']);
        }

        if ($amount <= 0) {
            return $this->result->set(['status' => 'error', 'message' => 'Số tiền không hợp lệ']);
        }

        // Lấy thông tin số dư của user
        $sql = "SELECT money_total FROM " . $db_config['prefix'] . "_wallet_money 
                WHERE userid=" . $userid . " AND money_unit=" . $db->quote($currency) . " AND status=1";
        $balance = $db->query($sql)->fetchColumn();

        if ($balance === false) {
            $balance = 0;
        }

        $has_enough = ($balance >= $amount);

        return $this->result->set([
            'status' => 'success',
            'data' => [
                'userid' => $userid,
                'currency' => $currency,
                'current_balance' => floatval($balance),
                'required_amount' => floatval($amount),
                'has_enough' => $has_enough
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
                'info' => 'ID của user cần kiểm tra'
            ],
            'amount' => [
                'name' => 'Số tiền',
                'type' => 'float',
                'required' => true,
                'info' => 'Số tiền cần kiểm tra'
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
        return 'API kiểm tra số dư ví của user có đủ để thực hiện giao dịch hay không';
    }
}
