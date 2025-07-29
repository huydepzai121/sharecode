<!-- BEGIN: main -->
<div class="cart-page">
    <!-- Cart Header -->
    <div class="cart-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="cart-title">
                        <i class="fa fa-shopping-cart"></i> Giỏ hàng của bạn
                    </h1>
                    <p class="cart-subtitle">Quản lý và thanh toán các mã nguồn đã chọn</p>
                </div>
                <div class="col-md-4">
                    <div class="cart-stats">
                        <div class="stat-box">
                            <span class="stat-number" id="cart-count">0</span>
                            <span class="stat-label">Sản phẩm</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Cart Content -->
    <div class="cart-content">
        <div class="container-fluid">
            <div class="row">
                <!-- Cart Items -->
                <div class="col-md-8">
                    <div class="cart-items-section">
                        <div class="section-header">
                            <h3><i class="fa fa-list"></i> Danh sách sản phẩm</h3>
                            <div class="cart-actions">
                                <button class="btn btn-outline btn-sm" id="select-all">
                                    <i class="fa fa-check-square-o"></i> Chọn tất cả
                                </button>
                                <button class="btn btn-danger btn-sm" id="clear-cart">
                                    <i class="fa fa-trash"></i> Xóa tất cả
                                </button>
                            </div>
                        </div>
                        
                        <!-- Cart Items Container -->
                        <div id="cart-items-container">
                            <!-- Loading state -->
                            <div class="cart-loading text-center">
                                <i class="fa fa-spinner fa-spin fa-3x"></i>
                                <p>Đang tải giỏ hàng...</p>
                            </div>
                        </div>
                        
                        <!-- Empty Cart -->
                        <div id="empty-cart" class="empty-cart text-center" style="display: none;">
                            <i class="fa fa-shopping-cart fa-5x text-muted"></i>
                            <h3>Giỏ hàng trống</h3>
                            <p>Bạn chưa thêm sản phẩm nào vào giỏ hàng.</p>
                            <a href="{MODULE_URL}" class="btn btn-primary">
                                <i class="fa fa-search"></i> Khám phá mã nguồn
                            </a>
                        </div>
                    </div>
                </div>
                
                <!-- Cart Summary -->
                <div class="col-md-4">
                    <div class="cart-summary">
                        <div class="summary-header">
                            <h4><i class="fa fa-calculator"></i> Tổng kết đơn hàng</h4>
                        </div>
                        
                        <div class="summary-content">
                            <div class="summary-row">
                                <span>Số lượng sản phẩm:</span>
                                <span id="summary-count">0</span>
                            </div>
                            <div class="summary-row">
                                <span>Tạm tính:</span>
                                <span id="summary-subtotal">0 VNĐ</span>
                            </div>
                            <div class="summary-row summary-discount" style="display: none;">
                                <span>Giảm giá:</span>
                                <span id="summary-discount-amount">0 VNĐ</span>
                            </div>
                            <div class="summary-row summary-total">
                                <span>Tổng cộng:</span>
                                <span id="summary-total">0 VNĐ</span>
                            </div>
                        </div>
                        
                        <!-- Wallet Balance -->
                        <div class="wallet-info">
                            <div class="wallet-balance">
                                <i class="fa fa-wallet"></i>
                                <span>Số dư ví: </span>
                                <span id="wallet-balance">Đang tải...</span>
                            </div>
                        </div>
                        
                        <!-- Purchase Actions -->
                        <div class="purchase-actions">
                            <button class="btn btn-success btn-block btn-lg" id="purchase-all" disabled>
                                <i class="fa fa-credit-card"></i> Thanh toán tất cả
                            </button>
                            <button class="btn btn-outline btn-block" id="purchase-selected" disabled>
                                <i class="fa fa-shopping-cart"></i> Thanh toán đã chọn
                            </button>
                        </div>
                        
                        <!-- Payment Methods -->
                        <div class="payment-methods">
                            <h5><i class="fa fa-credit-card"></i> Phương thức thanh toán</h5>
                            <div class="payment-method active">
                                <i class="fa fa-wallet"></i>
                                <span>Ví điện tử</span>
                                <span class="method-badge">Khuyên dùng</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
/* Cart Page Styles */
.cart-page {
    background: #f8f9fa;
    min-height: 100vh;
}

.cart-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 40px 0;
    margin-bottom: 30px;
}

.cart-title {
    font-size: 32px;
    font-weight: 700;
    margin-bottom: 10px;
}

.cart-subtitle {
    font-size: 16px;
    opacity: 0.9;
    margin: 0;
}

.cart-stats {
    text-align: center;
}

.stat-box {
    background: rgba(255,255,255,0.2);
    padding: 20px;
    border-radius: 10px;
    backdrop-filter: blur(10px);
}

.stat-number {
    display: block;
    font-size: 32px;
    font-weight: 700;
}

.stat-label {
    font-size: 14px;
    opacity: 0.9;
}

.cart-content {
    padding: 0 0 50px 0;
}

/* Cart Items Section */
.cart-items-section {
    background: white;
    border-radius: 12px;
    padding: 30px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    margin-bottom: 30px;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
    padding-bottom: 20px;
    border-bottom: 2px solid #f1f3f4;
}

.section-header h3 {
    color: #2c3e50;
    margin: 0;
    font-weight: 600;
}

.cart-actions {
    display: flex;
    gap: 10px;
}

.cart-actions .btn {
    font-size: 13px;
    padding: 6px 12px;
}

/* Cart Item */
.cart-item {
    display: flex;
    align-items: center;
    padding: 20px 0;
    border-bottom: 1px solid #f1f3f4;
    transition: all 0.3s ease;
}

.cart-item:hover {
    background: #f8f9fa;
    border-radius: 8px;
    padding: 20px 15px;
}

.cart-item:last-child {
    border-bottom: none;
}

.item-checkbox {
    margin-right: 20px;
}

.item-checkbox input[type="checkbox"] {
    width: 18px;
    height: 18px;
    accent-color: #667eea;
}

.item-image {
    width: 80px;
    height: 60px;
    margin-right: 20px;
    border-radius: 8px;
    overflow: hidden;
}

.item-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.item-details {
    flex: 1;
    margin-right: 20px;
}

.item-title {
    font-size: 16px;
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 8px;
    line-height: 1.3;
}

.item-title a {
    color: inherit;
    text-decoration: none;
}

.item-title a:hover {
    color: #667eea;
}

.item-category {
    font-size: 13px;
    color: #6c757d;
    margin-bottom: 8px;
}

.item-description {
    font-size: 14px;
    color: #6c757d;
    line-height: 1.4;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.item-price {
    text-align: center;
    margin-right: 20px;
}

.price-amount {
    font-size: 18px;
    font-weight: 700;
    color: #e74c3c;
    display: block;
}

.price-original {
    font-size: 14px;
    color: #6c757d;
    text-decoration: line-through;
}

.item-actions {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.item-actions .btn {
    font-size: 12px;
    padding: 6px 12px;
    min-width: 80px;
}

/* Cart Summary */
.cart-summary {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    position: sticky;
    top: 20px;
}

.summary-header {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 20px;
}

.summary-header h4 {
    margin: 0;
    font-weight: 600;
}

.summary-content {
    padding: 25px;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    font-size: 15px;
}

.summary-total {
    padding-top: 15px;
    border-top: 2px solid #f1f3f4;
    font-size: 18px;
    font-weight: 700;
    color: #2c3e50;
}

.summary-total span:last-child {
    color: #e74c3c;
}

/* Wallet Info */
.wallet-info {
    padding: 20px 25px;
    background: #f8f9fa;
    border-top: 1px solid #e9ecef;
}

.wallet-balance {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 15px;
    color: #495057;
}

.wallet-balance i {
    color: #667eea;
}

/* Purchase Actions */
.purchase-actions {
    padding: 25px;
    border-top: 1px solid #e9ecef;
}

.purchase-actions .btn {
    margin-bottom: 10px;
    font-weight: 600;
    padding: 12px;
}

.btn-success {
    background: linear-gradient(45deg, #28a745, #20c997);
    border: none;
}

.btn-success:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
}

.btn-success:disabled {
    background: #6c757d;
    transform: none;
    box-shadow: none;
}

/* Payment Methods */
.payment-methods {
    padding: 20px 25px;
    border-top: 1px solid #e9ecef;
}

.payment-methods h5 {
    color: #2c3e50;
    margin-bottom: 15px;
    font-size: 14px;
    font-weight: 600;
}

.payment-method {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 12px;
    border: 2px solid #e9ecef;
    border-radius: 8px;
    font-size: 14px;
    transition: all 0.3s ease;
}

.payment-method.active {
    border-color: #667eea;
    background: rgba(102, 126, 234, 0.1);
}

.payment-method i {
    color: #667eea;
}

.method-badge {
    margin-left: auto;
    background: #667eea;
    color: white;
    padding: 2px 8px;
    border-radius: 10px;
    font-size: 11px;
    font-weight: 600;
}

/* Loading and Empty States */
.cart-loading {
    padding: 60px 20px;
    color: #6c757d;
}

.cart-loading i {
    color: #667eea;
    margin-bottom: 20px;
}

.empty-cart {
    padding: 60px 20px;
}

.empty-cart h3 {
    color: #495057;
    margin: 30px 0 20px;
}

.empty-cart p {
    color: #6c757d;
    margin-bottom: 30px;
}

/* Responsive */
@media (max-width: 768px) {
    .cart-header {
        padding: 20px 0;
    }
    
    .cart-title {
        font-size: 24px;
    }
    
    .section-header {
        flex-direction: column;
        gap: 15px;
        align-items: flex-start;
    }
    
    .cart-item {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
        padding: 20px 0;
    }
    
    .cart-item:hover {
        padding: 20px 0;
    }
    
    .item-checkbox {
        margin-right: 0;
        align-self: flex-end;
    }
    
    .item-image {
        margin-right: 0;
        width: 100%;
        height: 200px;
    }
    
    .item-details {
        margin-right: 0;
        width: 100%;
    }
    
    .item-price, .item-actions {
        margin-right: 0;
        align-self: stretch;
    }
    
    .item-actions {
        flex-direction: row;
        justify-content: space-between;
    }
    
    .cart-summary {
        position: static;
        margin-top: 20px;
    }
}
</style>

<script>
$(document).ready(function() {
    loadCartItems();
    loadWalletBalance();
    
    // Select all checkbox
    $('#select-all').click(function() {
        var allChecked = $('.item-checkbox input:checked').length === $('.item-checkbox input').length;
        $('.item-checkbox input').prop('checked', !allChecked);
        updateCartSummary();
        updateButtons();
    });
    
    // Clear cart
    $('#clear-cart').click(function() {
        if (confirm('Bạn có chắc muốn xóa tất cả sản phẩm khỏi giỏ hàng?')) {
            localStorage.removeItem('sharecode_cart');
            loadCartItems();
        }
    });
    
    // Purchase all
    $('#purchase-all').click(function() {
        var allItems = [];
        $('.cart-item').each(function() {
            allItems.push(parseInt($(this).data('id')));
        });
        
        if (allItems.length > 0) {
            purchaseItems(allItems);
        }
    });
    
    // Purchase selected
    $('#purchase-selected').click(function() {
        var selectedItems = [];
        $('.item-checkbox input:checked').each(function() {
            selectedItems.push(parseInt($(this).closest('.cart-item').data('id')));
        });
        
        if (selectedItems.length > 0) {
            purchaseItems(selectedItems);
        } else {
            alert('Vui lòng chọn ít nhất một sản phẩm');
        }
    });
});

// Load cart items from localStorage
function loadCartItems() {
    var cart = JSON.parse(localStorage.getItem('sharecode_cart') || '[]');
    
    if (cart.length === 0) {
        showEmptyCart();
        return;
    }
    
    // Call API to get cart data
    $.ajax({
        url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=sharecode&' + nv_op_variable + '=cart',
        type: 'POST',
        data: {
            action: 'get_cart',
            items: cart,
            ajax: 1
        },
        success: function(response) {
            if (response.status === 'success') {
                displayCartItems(response.items);
                updateCartSummary();
                $('#cart-count').text(response.count);
            } else {
                showEmptyCart();
            }
        },
        error: function() {
            showEmptyCart();
        }
    });
}

// Display cart items
function displayCartItems(items) {
    var html = '';
    
    items.forEach(function(item) {
        html += '<div class="cart-item" data-id="' + item.id + '">' +
            '<div class="item-checkbox">' +
                '<input type="checkbox" checked>' +
            '</div>' +
            '<div class="item-image">' +
                '<img src="' + item.image_url + '" alt="' + item.title + '">' +
            '</div>' +
            '<div class="item-details">' +
                '<div class="item-title">' +
                    '<a href="' + item.link + '">' + item.title + '</a>' +
                '</div>' +
                '<div class="item-category">' +
                    '<i class="fa fa-folder-o"></i> ' + item.category_title +
                '</div>' +
                '<div class="item-description">' + item.description + '</div>' +
            '</div>' +
            '<div class="item-price">' +
                '<span class="price-amount">' + item.price_text + '</span>' +
            '</div>' +
            '<div class="item-actions">' +
                '<button class="btn btn-primary btn-sm btn-buy-single" data-id="' + item.id + '" data-price="' + item.fee_amount + '">' +
                    '<i class="fa fa-credit-card"></i> Mua ngay' +
                '</button>' +
                '<button class="btn btn-danger btn-sm btn-remove" data-id="' + item.id + '">' +
                    '<i class="fa fa-trash"></i> Xóa' +
                '</button>' +
            '</div>' +
        '</div>';
    });
    
    $('#cart-items-container').html(html);
    $('.cart-loading').hide();
    
    // Bind events
    bindCartEvents();
    updateButtons();
}

// Bind cart item events
function bindCartEvents() {
    // Checkbox change
    $('.item-checkbox input').change(function() {
        updateCartSummary();
        updateButtons();
    });
    
    // Remove item
    $('.btn-remove').click(function() {
        var itemId = $(this).data('id');
        removeFromCart(itemId);
    });
    
    // Buy single item
    $('.btn-buy-single').click(function() {
        var itemId = $(this).data('id');
        var price = $(this).data('price');
        
        // Check login
        if (typeof nv_is_user === 'undefined' || !nv_is_user) {
            alert('Vui lòng đăng nhập để mua sản phẩm');
            window.location.href = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_op_variable + '=login';
            return;
        }
        
        purchaseItems([itemId]);
    });
}

// Remove item from cart
function removeFromCart(itemId) {
    var cart = JSON.parse(localStorage.getItem('sharecode_cart') || '[]');
    cart = cart.filter(function(id) {
        return id !== itemId;
    });
    localStorage.setItem('sharecode_cart', JSON.stringify(cart));
    
    // Remove from UI
    $('.cart-item[data-id="' + itemId + '"]').fadeOut(function() {
        $(this).remove();
        updateCartSummary();
        updateButtons();
        $('#cart-count').text($('.cart-item').length);
        
        if ($('.cart-item').length === 0) {
            showEmptyCart();
        }
    });
}

// Update cart summary
function updateCartSummary() {
    var total = 0;
    var count = 0;
    
    $('.item-checkbox input:checked').each(function() {
        var price = parseFloat($(this).closest('.cart-item').find('.btn-buy-single').data('price'));
        total += price;
        count++;
    });
    
    $('#summary-count').text(count);
    $('#summary-subtotal').text(formatPrice(total));
    $('#summary-total').text(formatPrice(total));
}

// Update buttons state
function updateButtons() {
    var totalItems = $('.cart-item').length;
    var selectedItems = $('.item-checkbox input:checked').length;
    
    $('#purchase-all').prop('disabled', totalItems === 0);
    $('#purchase-selected').prop('disabled', selectedItems === 0);
    
    // Update select all button
    if (totalItems > 0 && selectedItems === totalItems) {
        $('#select-all').html('<i class="fa fa-square-o"></i> Bỏ chọn tất cả');
    } else {
        $('#select-all').html('<i class="fa fa-check-square-o"></i> Chọn tất cả');
    }
}

// Purchase items
function purchaseItems(itemIds) {
    // Check login
    if (typeof nv_is_user === 'undefined' || !nv_is_user) {
        alert('Vui lòng đăng nhập để mua sản phẩm');
        window.location.href = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_op_variable + '=login';
        return;
    }
    
    var btn = itemIds.length === $('.cart-item').length ? $('#purchase-all') : $('#purchase-selected');
    var originalText = btn.html();
    
    btn.html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý...');
    btn.prop('disabled', true);
    
    $.ajax({
        url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=sharecode&' + nv_op_variable + '=cart',
        type: 'POST',
        data: {
            action: 'purchase_all',
            items: itemIds,
            ajax: 1
        },
        success: function(response) {
            if (response.status === 'success') {
                // Remove purchased items from cart
                itemIds.forEach(function(id) {
                    removeFromCart(id);
                });
                
                alert('Thanh toán thành công! Bạn có thể tải về các sản phẩm đã mua từ trang cá nhân.');
                
                // Redirect to dashboard
                if (response.data.dashboard_url) {
                    window.location.href = response.data.dashboard_url;
                }
            } else {
                alert('Lỗi: ' + response.message);
            }
        },
        error: function() {
            alert('Có lỗi xảy ra, vui lòng thử lại');
        },
        complete: function() {
            btn.html(originalText);
            btn.prop('disabled', false);
        }
    });
}

// Load wallet balance
function loadWalletBalance() {
    if (typeof nv_is_user === 'undefined' || !nv_is_user) {
        $('#wallet-balance').text('Chưa đăng nhập');
        return;
    }
    
    $.ajax({
        url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=wallet&' + nv_op_variable + '=api',
        type: 'POST',
        data: {
            action: 'get_balance',
            user_id: nv_user_id
        },
        success: function(response) {
            if (response.status === 'success') {
                $('#wallet-balance').text(formatPrice(response.balance));
            } else {
                $('#wallet-balance').text('Lỗi tải số dư');
            }
        },
        error: function() {
            $('#wallet-balance').text('Lỗi kết nối');
        }
    });
}

// Show empty cart
function showEmptyCart() {
    $('#cart-items-container').hide();
    $('#empty-cart').show();
    $('#cart-count').text('0');
    updateCartSummary();
    updateButtons();
}

// Format price
function formatPrice(amount) {
    return new Intl.NumberFormat('vi-VN').format(amount) + ' VNĐ';
}
</script>
<!-- END: main -->