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
 * NukeViet\Module\wallet\Api\GetAllUserBalances
 * API dùng để lấy số dư tất cả loại tiền tệ của user
 *
 * @package NukeViet\Module\wallet\Api
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @version 5.x
 * @access public
 */
class GetAllUserBalances implements IApi
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

        // Lấy tất cả ví tiền của user
        $sql = 'SELECT m.*, mu.money_name, mu.money_currency
                FROM ' . $db_config['prefix'] . '_' . $module_data . '_money m
                LEFT JOIN ' . $db_config['prefix'] . '_' . $module_data . '_money_unit mu ON m.money_unit = mu.money_unit
                WHERE m.userid = ' . $postdata['userid'] . '
                ORDER BY mu.weight ASC, m.money_unit ASC';
        $wallets = $db->query($sql)->fetchAll();

        $user_data = [
            'userid' => $postdata['userid'],
            'username' => $user_info['username'],
            'full_name' => $user_info['full_name'],
            'total_wallets' => count($wallets),
            'wallets' => []
        ];

        $total_value_vnd = 0; // Tổng giá trị qui đổi về VND

        foreach ($wallets as $wallet) {
            $wallet_data = [
                'currency' => $wallet['money_unit'],
                'currency_name' => $wallet['money_name'] ?: $wallet['money_unit'],
                'currency_symbol' => $wallet['money_currency'] ?: $wallet['money_unit'],
                'balance' => floatval($wallet['money_total']),
                'total_in' => floatval($wallet['money_total_in']),
                'total_out' => floatval($wallet['money_total_out']),
                'last_updated' => $wallet['updatetime'],
                'formatted_balance' => number_format($wallet['money_total'], 0, '.', ',') . ' ' . $wallet['money_unit']
            ];

            // Nếu là VND thì cộng trực tiếp, nếu không thì cần tỷ giá
            if ($wallet['money_unit'] == 'VND') {
                $total_value_vnd += $wallet['money_total'];
                $wallet_data['vnd_value'] = floatval($wallet['money_total']);
            } else {
                // Lấy tỷ giá để quy đổi về VND
                $sql_rate = 'SELECT rate FROM ' . $db_config['prefix'] . '_' . $module_data . '_exchange_rate
                            WHERE from_unit = ' . $db->quote($wallet['money_unit']) . '
                            AND to_unit = \'VND\'
                            ORDER BY addtime DESC LIMIT 1';
                $rate = $db->query($sql_rate)->fetchColumn();
                
                if ($rate > 0) {
                    $vnd_value = $wallet['money_total'] * $rate;
                    $wallet_data['vnd_value'] = $vnd_value;
                    $wallet_data['exchange_rate'] = floatval($rate);
                    $total_value_vnd += $vnd_value;
                } else {
                    $wallet_data['vnd_value'] = 0;
                    $wallet_data['exchange_rate'] = 0;
                    $wallet_data['note'] = 'Chưa có tỷ giá quy đổi';
                }
            }

            $user_data['wallets'][] = $wallet_data;
        }

        // Thống kê tổng quan
        $user_data['summary'] = [
            'total_vnd_value' => $total_value_vnd,
            'formatted_total_vnd' => number_format($total_value_vnd, 0, '.', ',') . ' VND',
            'has_balance' => $total_value_vnd > 0,
            'primary_currency' => !empty($wallets) ? $wallets[0]['money_unit'] : 'VND'
        ];

        // Thống kê giao dịch gần nhất (tất cả loại tiền)
        $sql = 'SELECT transaction_id, transaction_status, money_unit, money_total, transaction_info, transaction_time
                FROM ' . $db_config['prefix'] . '_' . $module_data . '_transaction
                WHERE userid = ' . $postdata['userid'] . '
                ORDER BY transaction_time DESC
                LIMIT 10';
        $recent_transactions = $db->query($sql)->fetchAll();

        $user_data['recent_transactions'] = [];
        foreach ($recent_transactions as $trans) {
            $user_data['recent_transactions'][] = [
                'transaction_id' => $trans['transaction_id'],
                'status' => $trans['transaction_status'],
                'amount' => floatval($trans['money_total']),
                'currency' => $trans['money_unit'],
                'note' => $trans['transaction_info'],
                'time' => $trans['transaction_time'],
                'formatted_amount' => number_format($trans['money_total'], 0, '.', ',') . ' ' . $trans['money_unit']
            ];
        }

        $this->result->set('data', $user_data);
        $this->result->setSuccess();

        return $this->result->getResult();
    }
}