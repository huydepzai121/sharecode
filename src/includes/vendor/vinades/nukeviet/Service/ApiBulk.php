<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2020 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 24/4/2020, 20:6
 */
namespace NukeViet\Service;
class ApiBulk
{
    public static $api_url = API_URL_BULK; // API URL
    public static $api_key = API_KEY_BULK; // Your API key

    public static function status($order_id) { // get order status
        return json_decode(self::connect(array(
            'key' => self::$api_key,
            'action' => 'status',
            'order' => $order_id
        )), true);
    }

    public static function order($data) { // add order
        $post = array_merge(array('key' => self::$api_key, 'action' => 'add'), $data);
        return json_decode(self::connect($post), true);
    }

    public static function services() { // get services
        return json_decode(self::connect(array(
            'key' => self::$api_key,
            'action' => 'services',
        )), true);
    }

    public static function getservices() { // get services
        return json_decode(self::connect(array(
            'key' => self::$api_key,
            'action' => 'services',
        )), true);
    }

    public static function balance() { // get balance
        return json_decode(self::connect(array(
            'key' => self::$api_key,
            'action' => 'balance',
        )), true);
    }

    public static function connect($post) {
        $_post = Array();
        if (is_array($post)) {
            foreach ($post as $name => $value) {
                $_post[] = $name.'='.urlencode($value);
            }
        }

        $ch = curl_init(self::$api_url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, 1);
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        if (is_array($post)) {
            curl_setopt($ch, CURLOPT_POSTFIELDS, join('&', $_post));
        }
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)');
        $result = curl_exec($ch);
        if (curl_errno($ch) != 0 && empty($result)) {
            $result = false;
        }
        curl_close($ch);
        return $result;
    }
}
