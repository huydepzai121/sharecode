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
 * NukeViet\Module\wallet\Api\DeductBalance
 * API dùng để trừ tiền từ ví của user
 *
 * @package NukeViet\Module\wallet\Api
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @version 5.x
 * @access public
 */
class DeductBalance implements IApi
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
        return 'Transaction';
    }

    /**
     * {@inheritdoc}
     * @see \NukeViet\Api\IApi::setResultHander()
     */
    public function setResultHander(ApiResult $result)
    {
        $this->result = $result;
    }

    /**
     * {@inheritdoc}
     * @see \NukeViet\Api\IApi::execute()
     */
    public function execute()
    {
        global $db, $nv_Request, $nv_Lang, $db_config;

        $module_name = Api::getModuleName();
        $module_info = Api::getModuleInfo();
        $module_data = $module_info['module_data'];
        $module_file = $module_info['module_file'];

        $postdata = [];
        $postdata['userid'] = $nv_Request->get_int('userid', 'post,get', 0);
        $postdata['amount'] = $nv_Request->get_float('amount', 'post,get', 0);
        $postdata['currency'] = $nv_Request->get_title('currency', 'post,get', 'VND');
        $postdata['description'] = $nv_Request->get_title('description', 'post,get', '');
        $postdata['reference_type'] = $nv_Request->get_title('reference_type', 'post,get', '');
        $postdata['reference_id'] = $nv_Request->get_title('reference_id', 'post,get', '');

        // Validate input
        if ($postdata['userid'] <= 0) {
            return $this->result->setError()
                ->setCode('4001')
                ->setMessage('User ID không hợp lệ')
                ->getResult();
        }

        if ($postdata['amount'] <= 0) {
            return $this->result->setError()
                ->setCode('4002')
                ->setMessage('Số tiền phải lớn hơn 0')
                ->getResult();
        }

        // Kiểm tra user có tồn tại không
        $sql = 'SELECT userid, username, first_name, last_name FROM ' . NV_USERS_GLOBALTABLE . ' WHERE userid = ' . $postdata['userid'] . ' AND active = 1';
        $user_info = $db->query($sql)->fetch();
        if (empty($user_info)) {
            return $this->result->setError()
                ->setCode('4004')
                ->setMessage('User không tồn tại hoặc đã bị khóa')
                ->getResult();
        }

        // Tạo full_name từ first_name và last_name
        $user_info['full_name'] = trim($user_info['first_name'] . ' ' . $user_info['last_name']);

        try {
            $db->query('BEGIN');

            // Kiểm tra số dư ví
            $sql = 'SELECT * FROM ' . $db_config['prefix'] . '_' . $module_data . '_money WHERE userid = ' . $postdata['userid'] . ' AND money_unit = ' . $db->quote($postdata['currency']);
            $wallet_info = $db->query($sql)->fetch();

            if (empty($wallet_info)) {
                return $this->result->setError()
                    ->setCode('4005')
                    ->setMessage('Ví tiền chưa được khởi tạo')
                    ->getResult();
            }

            if ($wallet_info['money_total'] < $postdata['amount']) {
                return $this->result->setError()
                    ->setCode('4006')
                    ->setMessage('Số dư không đủ. Số dư hiện tại: ' . number_format($wallet_info['money_total'], 0, '.', ',') . ' ' . $postdata['currency'])
                    ->getResult();
            }

            // Tạo transaction ID
            $transaction_id = 'TXN' . strtoupper(substr(md5(uniqid(mt_rand(), true)), 0, 10));

            // Cập nhật số dư ví
            $new_balance = $wallet_info['money_total'] - $postdata['amount'];
            $new_money_out = $wallet_info['money_out'] + $postdata['amount'];

            $sql = 'UPDATE ' . $db_config['prefix'] . '_' . $module_data . '_money SET
                    money_total = ' . $new_balance . ',
                    money_out = ' . $new_money_out . '
                    WHERE userid = ' . $postdata['userid'] . ' AND money_unit = ' . $db->quote($postdata['currency']);

            if (!$db->query($sql)) {
                return $this->result->setError()
                    ->setCode('5001')
                    ->setMessage('Lỗi cập nhật số dư ví')
                    ->getResult();
            }

            $transaction_data = json_encode([
                'api_call' => true,
                'source' => 'DeductBalance API',
                'amount' => $postdata['amount'],
                'currency' => $postdata['currency'],
                'description' => $postdata['description'],
                'timestamp' => NV_CURRENTTIME,
                'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? '',
                'ip_address' => $_SERVER['REMOTE_ADDR'] ?? ''
            ]);

            $sql = 'INSERT INTO ' . $db_config['prefix'] . '_' . $module_data . '_transaction (
                transaction_id, userid, transaction_status, money_unit, money_total,
                money_net, transaction_info, transaction_data, transaction_time,
                status, created_time, adminid, customer_info
            ) VALUES (
                ' . $db->quote($transaction_id) . ',
                ' . $postdata['userid'] . ',
                4,
                ' . $db->quote($postdata['currency']) . ',
                -' . $postdata['amount'] . ',
                -' . $postdata['amount'] . ',
                ' . $db->quote($postdata['description']) . ',
                ' . $db->quote($transaction_data) . ',
                ' . NV_CURRENTTIME . ',
                -1,
                ' . NV_CURRENTTIME . ',
                ' . ($GLOBALS['admin_info']['userid'] ?? 0) . ',
                ' . $db->quote('API deduction: ' . $postdata['description']) . '
            )';

            if (!$db->query($sql)) {
                return $this->result->setError()
                    ->setCode('5002')
                    ->setMessage('Lỗi tạo bản ghi giao dịch')
                    ->getResult();
            }

            $db->query('COMMIT');

            // Trả về kết quả
            $result_data = [
                'transaction_id' => $transaction_id,
                'userid' => $postdata['userid'],
                'username' => $user_info['username'],
                'amount_deducted' => $postdata['amount'],
                'currency' => $postdata['currency'],
                'old_balance' => $wallet_info['money_total'],
                'new_balance' => $new_balance,
                'description' => $postdata['description'],
                'transaction_time' => NV_CURRENTTIME,
                'transaction_time_text' => date('d/m/Y H:i:s', NV_CURRENTTIME),
                'formatted_amount' => number_format($postdata['amount'], 0, '.', ',') . ' ' . $postdata['currency'],
                'formatted_new_balance' => number_format($new_balance, 0, '.', ',') . ' ' . $postdata['currency']
            ];

            $this->result->set('data', $result_data);
            $this->result->setSuccess();

            return $this->result->getResult();

        } catch (Exception $e) {
            return $this->result->setError()
                ->setCode('5000')
                ->setMessage('Lỗi hệ thống: ' . $e->getMessage())
                ->getResult();
        }
    }
}