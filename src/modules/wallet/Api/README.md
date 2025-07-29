# Wallet API Documentation

Các API của module Wallet để tích hợp với các module khác như ShareCode.
Hỗ trợ 2 cách gọi API:
- **Trong site**: sử dụng `nv_local_api()`
- **Ngoài site**: sử dụng `DoApi` với URL và key/secret

## Cấu hình

### Trong site (nv_local_api)
Không cần cấu hình gì thêm.

### Ngoài site (DoApi)
Thêm vào file config.php:
```php
define('API_WALLET_URL', 'https://sharecode.local/api.php');
define('API_WALLET_KEY', 'your_api_key');
define('API_WALLET_SECRET', 'your_api_secret');
```

## Danh sách API

### 1. GetUserBalance
Lấy số dư ví của một user cụ thể.

**Endpoint:** `POST /index.php?nv=wallet&op=api&action=GetUserBalance`

**Parameters:**
- `userid` (int, optional): ID của user. Nếu không cung cấp sẽ lấy user hiện tại
- `currency` (string, optional): Loại tiền tệ. Mặc định là 'VND'

**Response:**
```json
{
    "status": "success",
    "result": {
        "user_balance": {
            "userid": 123,
            "username": "testuser",
            "full_name": "Test User",
            "currency": "VND",
            "balance": 500000,
            "total_in": 1000000,
            "total_out": 500000,
            "wallet_created": true,
            "last_updated": "2025-01-20 10:30:00",
            "recent_transactions": [
                {
                    "transaction_id": "TXN123456",
                    "status": 4,
                    "amount": 100000,
                    "currency": "VND",
                    "note": "Mua source code ABC",
                    "time": "2025-01-20 09:15:00"
                }
            ],
            "summary": {
                "formatted_balance": "500,000 VND",
                "can_purchase": true,
                "wallet_status": "active"
            }
        }
    }
}
```

### 2. GetAllUserBalances
Lấy tất cả ví tiền của user (tất cả loại tiền tệ).

**Endpoint:** `POST /index.php?nv=wallet&op=api&action=GetAllUserBalances`

**Parameters:**
- `userid` (int, optional): ID của user. Nếu không cung cấp sẽ lấy user hiện tại

**Response:**
```json
{
    "status": "success",
    "result": {
        "user_wallets": {
            "userid": 123,
            "username": "testuser", 
            "full_name": "Test User",
            "total_wallets": 2,
            "wallets": [
                {
                    "currency": "VND",
                    "currency_name": "Việt Nam Đồng",
                    "currency_symbol": "₫",
                    "balance": 500000,
                    "total_in": 1000000,
                    "total_out": 500000,
                    "last_updated": "2025-01-20 10:30:00",
                    "formatted_balance": "500,000 VND",
                    "vnd_value": 500000
                },
                {
                    "currency": "USD",
                    "currency_name": "US Dollar",
                    "currency_symbol": "$",
                    "balance": 20,
                    "total_in": 50,
                    "total_out": 30,
                    "last_updated": "2025-01-20 08:15:00",
                    "formatted_balance": "20 USD",
                    "vnd_value": 480000,
                    "exchange_rate": 24000
                }
            ],
            "summary": {
                "total_vnd_value": 980000,
                "formatted_total_vnd": "980,000 VND",
                "has_balance": true,
                "primary_currency": "VND"
            },
            "recent_transactions": []
        }
    }
}
```

## Cách sử dụng trong ShareCode

### 1. Sử dụng Wallet Helper (Khuyến nghị)

```php
// Include helper
require_once NV_ROOTDIR . '/modules/sharecode/wallet_helper.php';

// Thiết lập chế độ API
sharecode_set_wallet_api_mode(false); // false = nv_local_api, true = DoApi

// Lấy số dư
$balance = sharecode_get_user_balance('VND');
if ($balance) {
    echo "Số dư: " . $balance['summary']['formatted_balance'];
}

// Kiểm tra đủ tiền mua
if (sharecode_can_afford(50000, 'VND')) {
    echo "Đủ tiền mua";
} else {
    echo sharecode_insufficient_funds_notice(50000, 'VND');
}

// Hiển thị widget ví tiền
echo sharecode_display_wallet_info();
```

### 2. Sử dụng Class WalletHelper

```php
use NukeViet\Api\DoApi;

// Thiết lập chế độ external API
ShareCodeWalletHelper::setExternalApi(true);

// Lấy số dư user cụ thể
$balance = ShareCodeWalletHelper::getUserBalance(123, 'VND');

// Lấy tất cả ví
$all_wallets = ShareCodeWalletHelper::getAllUserBalances(123);

// Kiểm tra đủ tiền
$can_buy = ShareCodeWalletHelper::canAfford(100000, 'VND', 123);
```

## Cách sử dụng trong code

### 3. Sử dụng nv_local_api() (Trong site)

```php
// Lấy số dư VND của user hiện tại
$params = ['currency' => 'VND'];
$response = nv_local_api('GetUserBalance', $params, '', 'wallet');

if ($response && $response['status'] == 'success') {
    $balance = $response['result']['user_balance']['balance'];
    echo "Số dư hiện tại: " . number_format($balance, 0, '.', ',') . " VND";
}
```

### 4. Sử dụng DoApi (Ngoài site)

```php
use NukeViet\Api\DoApi;

$api = new DoApi(API_WALLET_URL, API_WALLET_KEY, API_WALLET_SECRET);
$api->setModule('wallet')
    ->setLang(NV_LANG_DATA)
    ->setAction('GetUserBalance')
    ->setData(['userid' => 123, 'currency' => 'VND']);

$result_api = $api->execute();

if ($result_api['status'] == 'success') {
    $balance = $result_api['result']['user_balance']['balance'];
    echo "Số dư: " . number_format($balance, 0, '.', ',') . " VND";
} else {
    echo "Lỗi: " . $result_api['message'];
}
```

### 5. Sử dụng cURL (Thủ công)

```php
$api_url = NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&' . NV_NAME_VARIABLE . '=wallet&' . NV_OP_VARIABLE . '=api';

$postdata = [
    'action' => 'GetUserBalance',
    'userid' => $user_info['userid'],
    'currency' => 'VND'
];

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $api_url);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postdata));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_TIMEOUT, 30);

$response = curl_exec($ch);
curl_close($ch);

$result = json_decode($response, true);
if ($result && $result['status'] == 'success') {
    $balance = $result['result']['user_balance']['balance'];
}
```

### 6. Sử dụng trong JavaScript (AJAX)

```javascript
$.ajax({
    url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=wallet&' + nv_op_variable + '=api',
    method: 'POST',
    data: {
        action: 'GetUserBalance',
        currency: 'VND'
    },
    dataType: 'json',
    success: function(response) {
        if (response.status == 'success') {
            var balance = response.result.user_balance.balance;
            $('#wallet-balance').text(response.result.user_balance.summary.formatted_balance);
        }
    }
});
```

## Error Codes

- `4001`: User chưa đăng nhập
- `4004`: User không tồn tại hoặc đã bị khóa
- `5000`: Lỗi hệ thống khác

## Security Notes

1. API yêu cầu quyền admin module (ADMIN_LEV_MOD) để sử dụng
2. Nếu không cung cấp userid, API sẽ tự động lấy user hiện tại
3. API chỉ trả về thông tin của user được phép xem

## Tích hợp với ShareCode

### Files tham khảo:
- `wallet_helper.php`: Helper class và functions
- `example_usage.php`: Ví dụ sử dụng chi tiết
- `wallet_integration_example.php`: Demo tích hợp (deprecated)

### Các hàm tiện ích:

#### Simple Functions (Backward Compatibility)
- `sharecode_get_user_balance($currency)`: Lấy số dư một loại tiền
- `sharecode_get_all_user_balances()`: Lấy tất cả ví tiền  
- `sharecode_can_afford($price, $currency)`: Kiểm tra đủ tiền mua không
- `sharecode_display_wallet_info()`: Hiển thị giao diện ví tiền
- `sharecode_insufficient_funds_notice($price, $currency)`: Thông báo thiếu tiền
- `sharecode_set_wallet_api_mode($external)`: Thiết lập chế độ API

#### WalletHelper Class (Khuyến nghị)
- `ShareCodeWalletHelper::setExternalApi($external)`: Thiết lập API mode
- `ShareCodeWalletHelper::getUserBalance($userid, $currency)`: Lấy số dư
- `ShareCodeWalletHelper::getAllUserBalances($userid)`: Lấy tất cả ví
- `ShareCodeWalletHelper::canAfford($price, $currency, $userid)`: Kiểm tra đủ tiền
- `ShareCodeWalletHelper::getFormattedBalance($userid, $currency)`: Số dư formatted

### Cách sử dụng nhanh:

```php
// Include helper
require_once NV_ROOTDIR . '/modules/sharecode/wallet_helper.php';

// Trong site: dùng nv_local_api (mặc định)
sharecode_set_wallet_api_mode(false);

// Ngoài site: dùng DoApi
sharecode_set_wallet_api_mode(true);

// Kiểm tra cấu hình
$config = sharecode_check_wallet_api_config();
if (!$config['can_use_external']) {
    echo "Chưa cấu hình API_WALLET_URL";
}

// Sử dụng
if (sharecode_can_afford(50000, 'VND')) {
    echo "Đủ tiền mua";
} else {
    echo sharecode_insufficient_funds_notice(50000, 'VND');
}
```