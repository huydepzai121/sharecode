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
 * NukeViet\Module\wallet\Api\GetUserBalance
 * API dùng để lấy số dư tài khoản ví tiền của user
 *
 * @package NukeViet\Module\wallet\Api
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @version 5.x
 * @access public
 */
class GetUserBalance implements IApi
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
        return 'Get';
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
        $postdata['currency'] = $nv_Request->get_title('currency', 'post,get', 'VND');

        // Nếu userid không được chỉ định, lấy user hiện tại
        if (empty($postdata['userid'])) {
            // Kiểm tra user đã đăng nhập chưa
            if (!defined('NV_IS_USER') or empty($GLOBALS['user_info'])) {
                return $this->result->setError()
                    ->setCode('4001')
                    ->setMessage('User chưa đăng nhập')
                    ->getResult();
            }
            $postdata['userid'] = $GLOBALS['user_info']['userid'];
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

        // Lấy thông tin ví tiền
        $sql = 'SELECT * FROM ' . $db_config['prefix'] . '_' . $module_data . '_money WHERE userid = ' . $postdata['userid'] . ' AND money_unit = ' . $db->quote($postdata['currency']);
        $wallet_info = $db->query($sql)->fetch();
        
        $balance_data = [
            'userid' => $postdata['userid'],
            'username' => $user_info['username'],
            'full_name' => $user_info['full_name'],
            'currency' => $postdata['currency'],
            'balance' => 0,
            'total_in' => 0,
            'total_out' => 0,
            'wallet_created' => false,
            'last_updated' => null
        ];

        if (!empty($wallet_info)) {
            $balance_data['balance'] = floatval($wallet_info['money_total']);
            $balance_data['total_in'] = floatval($wallet_info['money_in']);
            $balance_data['total_out'] = floatval($wallet_info['money_out']);
            $balance_data['wallet_created'] = true;
            $balance_data['last_updated'] = null; // Không có updatetime column
        }

        // Lấy lịch sử giao dịch gần nhất (5 giao dịch)
        $sql = 'SELECT transaction_id, transaction_status, money_unit, money_total, transaction_info, transaction_time
                FROM ' . $db_config['prefix'] . '_' . $module_data . '_transaction
                WHERE userid = ' . $postdata['userid'] . ' AND money_unit = ' . $db->quote($postdata['currency']) . '
                ORDER BY transaction_time DESC
                LIMIT 5';
        $recent_transactions = $db->query($sql)->fetchAll();

        $balance_data['recent_transactions'] = [];
        foreach ($recent_transactions as $trans) {
            $balance_data['recent_transactions'][] = [
                'transaction_id' => $trans['transaction_id'],
                'status' => $trans['transaction_status'],
                'amount' => floatval($trans['money_total']),
                'currency' => $trans['money_unit'],
                'note' => $trans['transaction_info'],
                'time' => $trans['transaction_time']
            ];
        }

        // Thông tin tổng quan
        $balance_data['summary'] = [
            'formatted_balance' => number_format($balance_data['balance'], 0, '.', ',') . ' ' . $postdata['currency'],
            'can_purchase' => $balance_data['balance'] > 0,
            'wallet_status' => $balance_data['wallet_created'] ? 'active' : 'not_created'
        ];

        $this->result->set('data', $balance_data);
        $this->result->setSuccess();

        return $this->result->getResult();
    }
}