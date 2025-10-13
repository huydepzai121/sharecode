<!-- BEGIN: main -->
 <div class="container">
<!-- BEGIN: payport_content -->
<div class="clearfix margin-bottom">{PAYPORT_CONTENT}</div>
<!-- END: payport_content -->
<!-- BEGIN: payment -->
<div class="row">
    <div class="col-xl-12">
    </div>
    <div class="col-xl-12">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-xl-8">
                        <div class="row">
                            <!-- BEGIN: list_money -->
                                <!-- BEGIN: loop -->
                                <div class="col-xl-6">
                                    <div class="card_new {VALUE.class}">
                                        <div class="card-body">
                                            <h3 class="card-title text-white">{VALUE.title}<span class="float-right display-5 opacity-1"><img src="{VALUE.bank_name}" class="img__bank_wallet"></span></h3>
                                            <div class="d-inline-block">
                                                <p class="text-white mb-0">{LANG.account_holder}: {VALUE.account_holder}</p>
                                                <p class="text-white">{LANG.account_number}: <span id="{VALUE.id}">{VALUE.account_number}</span> <span class="copy_stk" onclick="copyToClipboard('#{VALUE.id}')"><i class="fa fa-clone" aria-hidden="true"></i></span></p>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- BEGIN: show_note1 -->
                                    <p><b>Nội dung chuyển khoản:</b> </p>
                                    <h4 class="text-center cuphap btn_copy" onclick="copyToClipboard('#copy')"><span>naptien <strong>{USERNAME}</strong></span><span>&nbsp; <i class="fa fa-clone" aria-hidden="true"></i></span></h4>
                                    <!-- END: show_note1 -->
                                </div>
                                <!-- END: loop -->
                            <!-- END: list_money -->
                            <div class="col-xl-12">
                                <ul class="navbar-cs">
                                    <li><strong>Chú ý:</strong></li>
                                    <li><i class="fa fa-circle no__icon" aria-hidden="true"></i>&nbsp; Hệ thống thực hiện xử lý giao dịch từ 1p -> 5p</li>
                                    <li><i class="fa fa-circle no__icon" aria-hidden="true"></i> &nbsp;Từ khung giờ 22h -> 24h hệ thống xử lý giao dịch có thể bị delay. </li>
                                    <li><strong><i class="fa fa-circle no__icon" aria-hidden="true"></i> &nbsp;Hệ thống tự động cộng tiền khi trong 1p -> 5p</strong></li>
                                </ul>
                            </div>

                            <div class="col-xl-12">
                                <h3 class="card-title"> <span class="float-right display-5 opacity-1"></span></h3>
                                <div class="d-inline-block">
                                    <p class="alert alert-info">- Nạp tối thiểu <label class="label label-success">50.000 VND</label> để sử dụng dịch vụ trong hệ thống. Nạp số tiền >= 1.000.000 để được hưởng ưu đãi khuyến mãi dịch vụ</p>
                                    <p class="alert alert-info">- Bạn vui lòng chuyển khoản chính xác nội dung để được cộng tiền nhanh nhất. Sai nội dung liên hệ admin để admin cộng tay cho bạn <br> - Nếu sau 10 phút từ khi tiền trong tài khoản của bạn bị trừ mà vẫn chưa được cộng tiền vui liên hệ Admin để được hỗ trợ.</p>
                                    <p class="alert alert-danger">
                                        Lưu ý<br>
                                        - Cố tình nạp dưới mức nạp không hỗ trợ<br>
                                        - Nạp sai nội dung chuyển tiền sẽ bị trừ 20% phí giao dịch. Vd: nạp 100k sai nội dung sẽ chỉ nhận được 80k coin và phải liên hệ admin để cộng tay.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-4">
                        <div id="view_Qrcode">
                            <a href="https://img.vietqr.io/image/{INFO_BANK.title}-{INFO_BANK.account_number}-compact2.png?addInfo=naptien {USERNAME}&accountName=Nap Tiền Sử dụng Dịch vụ" ref="noopener noreferrer nofollow" ><img src="https://img.vietqr.io/image/{INFO_BANK.title}-{INFO_BANK.account_number}-compact2.png?addInfo=naptien {USERNAME}&accountName=Nap Tiền Sử dụng Dịch vụ" width="100%" style="padding: 4px;"></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<!-- END: payment -->
<style>
    .img__bank_wallet {
        width: 30px;
    }

    .cuphap {
        background: #f5f5f591;
        padding: 14px;
        border-radius: 6px;
    }

    .btn_copy, .copy_stk {
        cursor: pointer;
    }

    .navbar-cs {
        margin: 0;
        padding: 0;
    }

    .navbar-cs li {
        font-size: 15px;
        font-weight: 500;
    }
</style>
<p id="copy" class="hidden">naptien {USERNAME}</p>
<script type="text/javascript">
    function copyToClipboard(element) {
        var $temp = $("<input>");
        $("body").append($temp);
        $temp.val($(element).html()).select();
        document.execCommand("copy");
        $temp.remove();
        success("Copy thành công: " + $(element).html());
    }
</script>
<!-- END: main -->
