        <!-- BEGIN: lt_ie9 --><p class="chromeframe">{LANG.chromeframe}</p><!-- END: lt_ie9 -->
        <!-- BEGIN: cookie_notice --><div class="cookie-notice"><div><button data-toggle="cookie_notice_hide">&times;</button>{COOKIE_NOTICE}</div></div><!-- END: cookie_notice -->
        <div id="timeoutsess" class="chromeframe">
            {LANG.timeoutsess_nouser}, <a data-toggle="timeoutsesscancel" href="#">{LANG.timeoutsess_click}</a>. {LANG.timeoutsess_timeout}: <span id="secField"> 60 </span> {LANG.sec}
        </div>
        <div id="openidResult" class="nv-alert" style="display:none"></div>
        <div id="openidBt" data-result="" data-redirect=""></div>
        <!-- BEGIN: crossdomain_listener -->
        <script type="text/javascript">
        function nvgSSOReciver(event) {
            if (event.origin !== '{SSO_REGISTER_ORIGIN}') {
                return false;
            }
            if (event.data == 'nv.reload') {
                location.reload();
            }
        }
        window.addEventListener('message', nvgSSOReciver, false);
        </script>
        <!-- END: crossdomain_listener -->
        <script src="{NV_STATIC_URL}themes/{TEMPLATE}/js/bootstrap.min.js"></script>

        <!-- AOS.js Script for scroll animations -->
        <script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
        <script>
        /**
         * Khởi tạo AOS.js với cấu hình tối ưu cho NukeViet ShareCode
         * - duration: 800ms cho animation mượt mà
         * - once: true để animation chỉ chạy 1 lần khi scroll xuống
         * - offset: 80px để trigger animation sớm hơn một chút
         * - easing: ease-out-cubic cho hiệu ứng tự nhiên
         */
        document.addEventListener('DOMContentLoaded', function() {
            // Kiểm tra AOS đã load thành công từ CDN
            if (typeof AOS !== 'undefined') {
                AOS.init({
                    duration: 800,
                    once: true,
                    offset: 80,
                    easing: 'ease-out-cubic'
                });
            } else {
                // Fallback graceful nếu AOS không load được từ CDN
                console.warn('AOS.js chưa được tải. Kiểm tra kết nối CDN.');
            }
        });
        </script>
    </body>
</html>
