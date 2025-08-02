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
 * NukeViet\Module\wallet\Api\WalletDeductBalance
 * API trừ tiền từ ví của user
 *
 * @package NukeViet\Module\wallet\Api
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @version 5.x
 * @access public
 */
class WalletDeductBalance implements IApi
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
        global $db, $db_config, $module_data, $nv_Cache;

        $userid = $this->result->getParam('userid', 'int', 0);
        $amount = $this->result->getParam('amount', 'float', 0);
        $currency = $this->result->getParam('currency', 'string', 'VND');
        $description = $this->result->getParam('description', 'string', '');
        $module_ref = $this->result->getParam('module_ref', 'string', '');
        $ref_id = $this->result->getParam('ref_id', 'int', 0);

        if ($userid <= 0) {
            return $this->result->set(['status' => 'error', 'message' => 'User ID không hợp lệ']);
        }

        if ($amount <= 0) {
            return $this->result->set(['status' => 'error', 'message' => 'Số tiền không hợp lệ']);
        }

        if (empty($description)) {
            return $this->result->set(['status' => 'error', 'message' => 'Mô tả giao dịch không được để trống']);
        }

        // Kiểm tra số dư hiện tại
        $sql = "SELECT money_total FROM " . $db_config['prefix'] . "_wallet_money 
                WHERE userid=" . $userid . " AND money_unit=" . $db->quote($currency) . " AND status=1";
        $current_balance = $db->query($sql)->fetchColumn();

        if ($current_balance === false || $current_balance < $amount) {
            return $this->result->set(['status' => 'error', 'message' => 'Số dư không đủ']);
        }

        try {
            $db->beginTransaction();

            // Trừ tiền từ ví
            $sql = "UPDATE " . $db_config['prefix'] . "_wallet_money SET
                    money_total = money_total - " . $amount . ",
                    money_out = money_out + " . $amount . "
                    WHERE userid=" . $userid . " AND money_unit=" . $db->quote($currency);
            
            $result_update = $db->exec($sql);
            
            if (!$result_update) {
                throw new Exception('Không thể cập nhật số dư');
            }

            // Ghi log giao dịch
            $sql = "INSERT INTO " . $db_config['prefix'] . "_wallet_transaction 
                    (userid, transaction_code, transaction_status, payment_method, payment_amount, payment_unit, 
                     transaction_info, created_time, module_ref, ref_id) VALUES (
                    " . $userid . ",
                    " . $db->quote('DEDUCT_' . time() . '_' . $userid) . ",
                    2,
                    'wallet',
                    " . (-$amount) . ",
                    " . $db->quote($currency) . ",
                    " . $db->quote($description) . ",
                    " . NV_CURRENTTIME . ",
                    " . $db->quote($module_ref) . ",
                    " . $ref_id . "
                    )";
            
            $result_transaction = $db->exec($sql);
            
            if (!$result_transaction) {
                throw new Exception('Không thể ghi log giao dịch');
            }

            $db->commit();

            // Xóa cache
            $nv_Cache->delMod('wallet');

            return $this->result->set([
                'status' => 'success',
                'message' => 'Trừ tiền thành công',
                'data' => [
                    'userid' => $userid,
                    'amount_deducted' => floatval($amount),
                    'currency' => $currency,
                    'new_balance' => floatval($current_balance - $amount),
                    'transaction_time' => NV_CURRENTTIME
                ]
            ]);

        } catch (Exception $e) {
            $db->rollback();
            return $this->result->set(['status' => 'error', 'message' => $e->getMessage()]);
        }
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
                'info' => 'ID của user cần trừ tiền'
            ],
            'amount' => [
                'name' => 'Số tiền',
                'type' => 'float',
                'required' => true,
                'info' => 'Số tiền cần trừ'
            ],
            'currency' => [
                'name' => 'Loại tiền',
                'type' => 'string',
                'required' => false,
                'info' => 'Loại tiền tệ (mặc định: VND)'
            ],
            'description' => [
                'name' => 'Mô tả',
                'type' => 'string',
                'required' => true,
                'info' => 'Mô tả giao dịch'
            ],
            'module_ref' => [
                'name' => 'Module tham chiếu',
                'type' => 'string',
                'required' => false,
                'info' => 'Tên module thực hiện giao dịch'
            ],
            'ref_id' => [
                'name' => 'ID tham chiếu',
                'type' => 'int',
                'required' => false,
                'info' => 'ID của đối tượng liên quan'
            ]
        ];
    }

    /**
     * @return string
     */
    public static function getInfo()
    {
        return 'API trừ tiền từ ví của user và ghi log giao dịch';
    }
}
