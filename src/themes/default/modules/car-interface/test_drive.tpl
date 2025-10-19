<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
            <div class="panel panel-success">
                <div class="panel-heading text-center">
                    <h3 class="panel-title">
                        <i class="fa fa-car"></i> Đăng Ký Lái Thử
                    </h3>
                </div>
                <div class="panel-body">
                    <!-- Thông tin xe đang ký -->
                    <div class="alert alert-info">
                        <i class="fa fa-info-circle"></i> <strong>Xe đang ký:</strong>
                        <span id="selected-car-info">Vui lòng chọn xe muốn lái thử</span>
                    </div>

                    <!-- Form đăng ký -->
                    <form id="test-drive-form" method="post" action="{$FORM_ACTION}">
                        <div class="row">
                            <!-- Chọn xe -->
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="car_id">
                                        <i class="fa fa-car"></i> Xe muốn lái thử <span class="text-danger">*</span>
                                    </label>
                                    <select class="form-control" id="car_id" name="car_id" required>
                                        <option value="">-- Chọn xe --</option>
                                        {foreach $CARS as $car}
                                        <option value="{$car.id}" data-title="{$car.title}" data-category="{$car.category_title}" data-price="{$car.price_formatted}">
                                            {$car.title} {if $car.category_title}({$car.category_title}){/if} - {$car.price_formatted}
                                        </option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Họ và tên -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="full_name">
                                        <i class="fa fa-user"></i> Họ và tên <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="full_name" name="full_name" 
                                           placeholder="Nhập họ và tên của bạn" required maxlength="255">
                                </div>
                            </div>

                            <!-- Số điện thoại -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="phone">
                                        <i class="fa fa-phone"></i> Số điện thoại <span class="text-danger">*</span>
                                    </label>
                                    <input type="tel" class="form-control" id="phone" name="phone"
                                           placeholder="Nhập số điện thoại của bạn" required pattern="[0-9]{literal}{10,11}{/literal}" maxlength="11">
                                </div>
                            </div>
                        </div>

                        <!-- Địa chỉ -->
                        <div class="form-group">
                            <label for="address">
                                <i class="fa fa-map-marker"></i> Địa chỉ <span class="text-danger">*</span>
                            </label>
                            <textarea class="form-control" id="address" name="address" rows="3" 
                                      placeholder="Nhập địa chỉ của bạn" required maxlength="500"></textarea>
                        </div>

                        <!-- Thời gian mong muốn -->
                        <div class="form-group">
                            <label for="test_time">
                                <i class="fa fa-clock-o"></i> Thời gian mong muốn <span class="text-danger">*</span>
                            </label>
                            <select class="form-control" id="test_time" name="test_time" required>
                                <option value="">-- Chọn thời gian --</option>
                                {foreach $TEST_TIMES as $key => $time}
                                <option value="{$key}">{$time}</option>
                                {/foreach}
                            </select>
                        </div>

                        <!-- Thông báo -->
                        <div class="alert alert-warning">
                            <i class="fa fa-exclamation-triangle"></i> 
                            <strong>Lưu ý:</strong> Chúng tôi sẽ liên hệ với bạn trong vòng 24h để xác nhận lịch lái thử.
                        </div>

                        <!-- Buttons -->
                        <div class="text-center">
                            <button type="button" class="btn btn-default btn-lg" onclick="window.history.back();">
                                <i class="fa fa-times"></i> Hủy
                            </button>
                            <button type="submit" class="btn btn-success btn-lg" id="submit-btn">
                                <i class="fa fa-paper-plane"></i> Đăng ký lái thử
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Loading overlay -->
<div id="loading-overlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999;">
    <div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); color: white; text-align: center;">
        <i class="fa fa-spinner fa-spin fa-3x"></i>
        <div style="margin-top: 10px;">Đang xử lý...</div>
    </div>
</div>

<script>
$(document).ready(function() {
    // Cập nhật thông tin xe khi chọn
    $('#car_id').change(function() {
        var selectedOption = $(this).find('option:selected');
        if (selectedOption.val()) {
            var carInfo = selectedOption.data('title');
            if (selectedOption.data('category')) {
                carInfo += ' (' + selectedOption.data('category') + ')';
            }
            carInfo += ' - ' + selectedOption.data('price');
            $('#selected-car-info').html('<strong>' + carInfo + '</strong>');
        } else {
            $('#selected-car-info').text('Vui lòng chọn xe muốn lái thử');
        }
    });

    // Xử lý submit form
    $('#test-drive-form').submit(function(e) {
        e.preventDefault();
        
        // Validate form
        if (!validateForm()) {
            return false;
        }
        
        // Show loading
        $('#loading-overlay').show();
        $('#submit-btn').prop('disabled', true);
        
        // Submit via AJAX
        $.ajax({
            url: '{$FORM_ACTION}',
            type: 'POST',
            data: $(this).serialize() + '&submit_test_drive=1',
            dataType: 'json',
            success: function(response) {
                $('#loading-overlay').hide();
                $('#submit-btn').prop('disabled', false);
                
                if (response.status === 'success') {
                    alert(response.message);
                    // Reset form
                    $('#test-drive-form')[0].reset();
                    $('#selected-car-info').text('Vui lòng chọn xe muốn lái thử');
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                $('#loading-overlay').hide();
                $('#submit-btn').prop('disabled', false);
                alert('Có lỗi xảy ra. Vui lòng thử lại!');
            }
        });
    });
    
    // Validate form function
    function validateForm() {
        var isValid = true;
        var errorMessage = '';
        
        // Check car selection
        if (!$('#car_id').val()) {
            errorMessage += '- Vui lòng chọn xe muốn lái thử\n';
            isValid = false;
        }
        
        // Check full name
        if (!$('#full_name').val().trim()) {
            errorMessage += '- Vui lòng nhập họ và tên\n';
            isValid = false;
        }
        
        // Check phone
        var phone = $('#phone').val().trim();
        if (!phone) {
            errorMessage += '- Vui lòng nhập số điện thoại\n';
            isValid = false;
        } else if (!/^[0-9]{literal}{10,11}{/literal}$/.test(phone)) {
            errorMessage += '- Số điện thoại không hợp lệ (10-11 số)\n';
            isValid = false;
        }
        
        // Check address
        if (!$('#address').val().trim()) {
            errorMessage += '- Vui lòng nhập địa chỉ\n';
            isValid = false;
        }
        
        // Check test time
        if (!$('#test_time').val()) {
            errorMessage += '- Vui lòng chọn thời gian lái thử\n';
            isValid = false;
        }
        
        if (!isValid) {
            alert('Vui lòng kiểm tra lại thông tin:\n' + errorMessage);
        }
        
        return isValid;
    }
});
</script>

<style>
.panel-success .panel-heading {
    background-color: #5cb85c;
    border-color: #4cae4c;
    color: white;
}

.form-group label {
    font-weight: bold;
    color: #333;
}

.form-control:focus {
    border-color: #5cb85c;
    box-shadow: 0 0 0 0.2rem rgba(92, 184, 92, 0.25);
}

.btn-success {
    background-color: #5cb85c;
    border-color: #4cae4c;
}

.btn-success:hover {
    background-color: #449d44;
    border-color: #398439;
}

.alert-info {
    background-color: #d9edf7;
    border-color: #bce8f1;
    color: #31708f;
}

.alert-warning {
    background-color: #fcf8e3;
    border-color: #faebcc;
    color: #8a6d3b;
}

.text-danger {
    color: #d9534f;
}

@media (max-width: 768px) {
    .container-fluid {
        padding: 10px;
    }
    
    .col-lg-offset-2, .col-md-offset-1 {
        margin-left: 0;
    }
    
    .btn-lg {
        padding: 10px 16px;
        font-size: 16px;
    }
}
</style>
<!-- END: main -->
