<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2020 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 24/4/2020, 20:6
 */
namespace NukeViet\Service;
class Share
{
    public static function nv_custom_insert($data, $table)
    {
        global $db;
        $id = 0;
        if (!empty($data)) {
            foreach ($data as $key => $value) {
                $arrayKey[] = $key;
                $arrayInsert[] = $db->quote($value);
            }
            try {
                $sqlInsert = "INSERT INTO $table (" . implode(",", $arrayKey) . ") VALUES ( " . implode(",", $arrayInsert) . " )";

                $db->query($sqlInsert);
                $id = $db->lastInsertId();
            } catch (PDOException $e) {
                trigger_error($e);
                $id = -1;
            }
        }
        return $id;
    }

    public static function getUid_NEW($linkpost) {
        global $db;
        $get_token = $db->query("SELECT * FROM " . NV_PREFIXLANG . "_service_api WHERE type = 'hacklike17'")->fetch();
        $token = $get_token['token'];

        // Đưa token vào trong body của gói tin
        $body['token'] = $token;
        $body['link'] = $linkpost;
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://hacklike17.com/api/get_link_uid',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => http_build_query($body, null, '&'),
        ));
        $response = curl_exec($curl);
        pr($response);
        curl_close($curl);
        $array = json_decode($response, true);
        if ($array['status']) {
            $json['id'] = $array['msg'];
        } else {
            $json['id'] = $linkpost;
        }
        return $json;
    }

    public static function getUid($linkpost) {
        $data = array(
            'link'=> $linkpost
        );

        $arr_agent = [
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101 Firefox/104.0',
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36 Edg/105.0.1343.42',
            'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',
            'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1',
            'Mozilla/5.0 (Linux; Android 9.0; SAMSUNG SM-F900U Build/PPR1.180610.011) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Mobile Safari/537.36',
            'Mozilla/5.0 (iPad; CPU OS 13_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/87.0.4280.77 Mobile/15E148 Safari/604.1',
            'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Mobile Safari/537.36',
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36'
        ];
        srand((float) microtime() * 10000000);
        $rand = array_rand($arr_agent);
        $agent = $arr_agent[$rand];

        $head = array(
            "user-agent: " . $agent
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "https://id.traodoisub.com/api.php");
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $head);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_ENCODING, true);
        $login_data =curl_exec($ch);
        curl_close($ch);
        $json = json_decode($login_data, true);
        $info = [];
        // Có dữ liệu
        if ($json['success'] == 200) {
            $check = self::getUID_Facebook($json['id']);
            if (!empty($check['data'])) {
                $info['name'] = $check['data']['name'];
                $info['id'] = $check['data']['id'];  
                $info['img'] = "https://graph.facebook.com/" . $info['id'] . "/picture?width=50&height=50&access_token=6628568379|c1e620fa708a1d5696fb991c1bde5662";
            } else {
                $info['name'] = '';
                $info['id'] = $json['id'];
                $info['img'] = "https://graph.facebook.com/" . $info['id'] . "/picture?width=50&height=50&access_token=6628568379|c1e620fa708a1d5696fb991c1bde5662";
            }
        } else {
            $check = self::getUID_Facebook($linkpost);
            if (!empty($check['data'])) {
                $info['name'] = $check['data']['name'];
                $info['id'] = $check['data']['id'];
                $info['img'] = "https://graph.facebook.com/" . $info['id'] . "/picture?width=50&height=50&access_token=6628568379|c1e620fa708a1d5696fb991c1bde5662";
            } else {
                $info['name'] = '';
                $info['id'] = $linkpost;
            }
        }
        return $info;
    }

    public static function getUID_Facebook($username) {
        global $db;
        $get_token = $db->query("SELECT * FROM " . NV_PREFIXLANG . "_service_api WHERE type = 'hacklike17'")->fetch();
        $token = $get_token['token'];

        // Đưa token vào trong body của gói tin
        $body['token'] = $token;
        $body['username'] = $username;
        $curl = curl_init();

        curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://hacklike17.com/api/get-uid',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => http_build_query($body, null, '&'),
        ));
        $response = curl_exec($curl);
        curl_close($curl);
        $array = json_decode($response, true);

        /**

         * Success: {"status":1,"msg":"Mua dịch vụ thành công","order_id":123,"original":456}

         * Error: {"status":0,"msg":"Tin nhắn lỗi ở đây"}

         */
        return $array;
    }

    public static function wallet($userid=0, $money=0, $notice='') {
        global $db_config, $db;
        // Gọi hàm lang
        include NV_ROOTDIR . '/modules/service/language/' . NV_LANG_INTERFACE . '.php';

        $loaigiaodich = '-1';
        $typeadd = $transaction_type = -1;
        $typemoney = 'VND';
        $transaction_status = 4;
        try {
            $sql = "SELECT * FROM " . $db_config['prefix'] . "_wallet_money WHERE userid ='" . $userid . "' AND money_unit=" . $db->quote($typemoney);
            $result = $db->query($sql)->fetch();

            $error = '';
            // Kiểm tra xem khách hàng có tiền không
            if ($result['money_total'] < $money) {
                $error  = $lang_module['no_money'];
                $res = [
                    'status' => 'error',
                    'mess' => $error,
                ];
                return $res;
            }
            
            // Cập nhật giao dịch
            // Giao dịch do admin khởi tạo thì không có tính phí vào mà cộng trực tiếp vào tiền luôn
            $_sql = 'SELECT * FROM ' . $db_config['prefix'] . '_wallet_money WHERE userid = ' . $userid . ' AND money_unit=' . $db->quote($typemoney);
            $_query = $db->query($_sql)->fetch();
            $row['detail_money'] = json_encode($_query);
            $sql = "INSERT INTO " . $db_config['prefix'] . "_wallet_transaction (
                created_time, status, money_unit, money_total, money_net, money_revenue, userid, adminid,
                customer_info, transaction_type, transaction_status, transaction_time, transaction_info, transaction_data, payment, detail_money, customer_id) VALUES (
                " . NV_CURRENTTIME . "," . $loaigiaodich . "," . $db->quote($typemoney) . ",
                " . $money . ", " . $money . ", " . $money . ", " . $userid . ", 0, '', " . $transaction_type . ",
                " . $transaction_status . "," . NV_CURRENTTIME . ", " . $db->quote($notice) . ", '', ''," . $db->quote($row['detail_money']) . ", " . $userid . ");";
            $res = self::UpdateMoney($userid, $typeadd, $typemoney = 'VND', $money);
            if ($res == 'success') {
                $id = $db->insert_id($sql);
                if ($id) {
                    $res = [
                        'status' => 'success',
                        'id' => $id
                    ];
                    return $res;
                } else {
                    $error  = $lang_module['no_order'];
                    $res = [
                        'status' => 'error',
                        'mess' => $error,
                    ];
                    return $res;
                }
            } else {
                $res = [
                    'status' => 'error',
                    'mess' => $res
                ];
                return $res;
            }
        } catch (Exception $e) {
            pr($e);
        }
    }

    public static function walletPlus($userid=0, $money=0, $notice='') {
        global $db_config, $db;
        // Gọi hàm lang
        include NV_ROOTDIR . '/modules/service/language/' . NV_LANG_INTERFACE . '.php';

        $loaigiaodich = '1';
        $typeadd = $transaction_type = 1;
        $typemoney = 'VND';
        $transaction_status = 4;
        try {
            $sql = "SELECT * FROM " . $db_config['prefix'] . "_wallet_money WHERE userid ='" . $userid . "' AND money_unit=" . $db->quote($typemoney);
            $result = $db->query($sql)->fetch();

            $error = '';
            // Kiểm tra xem khách hàng có tiền không
            if ($result['money_total'] < $money) {
                $error  = $lang_module['no_money'];
                $res = [
                    'status' => 'error',
                    'mess' => $error,
                ];
                return $res;
            }
            
            // Cập nhật giao dịch
            // Giao dịch do admin khởi tạo thì không có tính phí vào mà cộng trực tiếp vào tiền luôn
            $_sql = 'SELECT * FROM ' . $db_config['prefix'] . '_wallet_money WHERE userid = ' . $userid . ' AND money_unit=' . $db->quote($typemoney);
            $_query = $db->query($_sql)->fetch();
            $row['detail_money'] = json_encode($_query);
            $sql = "INSERT INTO " . $db_config['prefix'] . "_wallet_transaction (
                created_time, status, money_unit, money_total, money_net, money_revenue, userid, adminid,
                customer_info, transaction_type, transaction_status, transaction_time, transaction_info, transaction_data, payment, detail_money) VALUES (
                " . NV_CURRENTTIME . "," . $loaigiaodich . "," . $db->quote($typemoney) . ",
                " . $money . ", " . $money . ", " . $money . ", " . $userid . ", 0, '', " . $transaction_type . ",
                " . $transaction_status . "," . NV_CURRENTTIME . ", " . $db->quote($notice) . ", '', ''," . $db->quote($row['detail_money']) . ");";
            $res = self::UpdateMoneyPlus($userid, $typeadd, $typemoney = 'VND', $money);
            if ($res == 'success') {
                $id = $db->insert_id($sql);
                if ($id) {
                    $res = [
                        'status' => 'success',
                        'id' => $id
                    ];
                    return $res;
                } else {
                    $error  = $lang_module['no_order'];
                    $res = [
                        'status' => 'error',
                        'mess' => $error,
                    ];
                    return $res;
                }
            } else {
                $res = [
                    'status' => 'error',
                    'mess' => $res
                ];
                return $res;
            }
        } catch (Exception $e) {
            pr($e);
        }
    }

    public static function UpdateMoney($userid, $typeadd, $typemoney, $money) {
        global $db, $db_config;
        include NV_ROOTDIR . '/modules/service/language/' . NV_LANG_INTERFACE . '.php';
        $sql = "UPDATE " . $db_config['prefix'] . "_wallet_money SET
            money_total = money_total - " . $money . ",
            money_out = money_out + " . $money . "
        WHERE userid= " . $userid . " AND money_unit=" . $db->quote($typemoney);
        $res = $db->exec($sql);
        if (!$res) {
            return $lang_module['no_order'];
        } else {
            return 'success';
        }
    }

    public static function UpdateMoneyPlus($userid, $typeadd, $typemoney, $money) {
        global $db, $db_config;
        include NV_ROOTDIR . '/modules/service/language/' . NV_LANG_INTERFACE . '.php';
        $sql = "UPDATE " . $db_config['prefix'] . "_wallet_money SET
            money_total = money_total + " . $money . ",
            money_out = money_out - " . $money . "
        WHERE userid= " . $userid . " AND money_unit=" . $db->quote($typemoney);
        $res = $db->exec($sql);
        if (!$res) {
            return $lang_module['no_order'];
        } else {
            return 'success';
        }
    }

    public static function getInfoMoney() {
        global $user_info, $db_config, $db;
        $_sql = 'SELECT * FROM ' . $db_config['prefix'] . '_wallet_money WHERE userid = ' . $user_info['userid'] . ' AND money_unit = "VND"';
        $_query = $db->query($_sql)->fetch();
        return $_query;
    }

    public static function CallAPITrum($post) {
        $post_data = http_build_query($post);
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://trum.vip/api/server2/create');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        $result = curl_exec($ch);
        curl_close($ch);
        $res = json_decode($result, true);
        return $res;
    }

    public static function CallAPIVipFacebookSubGiaRe($data_post, $url) {
        $token_auto_dvfb = TOKEN_API_SUBGIARE;
        $ch = curl_init();
        $arr = [];

        foreach ($data_post as $k => $v) {
            $arr[] = $k . '=' . $v;
        }

        $post = implode("&", $arr);
        curl_setopt($ch, CURLOPT_URL, 'https://thuycute.hoangvanlinh.vn/' . $url . '/order');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post);
        curl_setopt($ch, CURLOPT_ENCODING, 'gzip, deflate');
        $headers = [];
        $headers[] = 'Authority: subgiare.vn';
        $headers[] = 'Accept: application/json, text/javascript, */*; q=0.01';
        $headers[] = 'Accept-Language: vi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5';
        $headers[] = 'Api-Token: ' . $token_auto_dvfb;
        $headers[] = 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8';
        $headers[] = 'Origin: https://subgiare.vn';
        $headers[] = 'Referer: https://subgiare.vn/service/' . $url . '/order';
        $headers[] = 'Sec-Ch-Ua: ^^Google';
        $headers[] = 'Sec-Ch-Ua-Mobile: ?0';
        $headers[] = 'Sec-Ch-Ua-Platform: ^^Windows^^\"\"';
        $headers[] = 'Sec-Fetch-Dest: empty';
        $headers[] = 'Sec-Fetch-Mode: cors';
        $headers[] = 'Sec-Fetch-Site: same-origin';
        $headers[] = 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36';
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        $result = curl_exec($ch);
        $res = json_decode($result, true);
        if (curl_errno($ch)) {
            echo 'Error:' . curl_error($ch);
            return [];
        }
        curl_close($ch);
        return $res;
    }

    public static function get_subgiare($link_post, $magd) {
        $token_auto_dvfb = TOKEN_API_SUBGIARE;

        $head = array(
            'api-token: '.$token_auto_dvfb,
            'content-type: application/json',
            "cache-control: no-cache"
        );

        $post_data['code_orders'] = $magd;
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://thuycute.hoangvanlinh.vn/' . $link_post . '/list',
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => json_encode($post_data),
            CURLOPT_HTTPHEADER => $head,
        ));
        $response = curl_exec($curl);
        curl_close($curl);
        $result = json_decode($response, true);
        $result = $result['data'][0];
        return $result;
    }

    public static function getOrderTrum($magd, $token) {
        $post_data = http_build_query([
            'key' => $token,
            'id' => $magd // nếu chỉ đinh order_id, response sẽ lọc theo order id
        ]);

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://trum.vip/api/order/status');
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        $result = curl_exec($ch);
        curl_close($ch);
        $rt = json_decode($result, true);
        $res = $rt['data'][0];
        return $res;
    }
}
