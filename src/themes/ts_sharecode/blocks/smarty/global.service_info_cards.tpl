<div class="service-info-cards-block mb-3">
    <div class="container">
        <div class="row g-4">
            <div class="col-md-12 text-center">
                <p class="text-center">
                    <img src="/uploads/mercedes-benz-logo.svg" alt="Logo">
                </p>

                <h2 class="mt-2">Thông tin khác</h2>
            </div>

            <!-- Card 1: Liên hệ -->
            <div class="col-lg-3 col-md-6">
                <div class="service-info-card">
                    <div class="service-card-icon">
                        <i class="ri-phone-line"></i>
                    </div>
                    <div class="service-card-content">
                        <h3 class="service-card-title"><a href="{$DATA.hotline_url}" class="service-card-link">Liên hệ</a></h3>
                        <p class="service-card-subtitle">Hotline: <a href="{$DATA.hotline_url}">{$DATA.hotline}</a></p>
                    </div>
                </div>
            </div>

            <!-- Card 2: Tìm xe có sẵn -->
            <div class="col-lg-3 col-md-6">
                <div class="service-info-card">
                    <div class="service-card-icon">
                        <i class="fa fa-car" aria-hidden="true"></i>
                    </div>
                    <div class="service-card-content">
                        <h3 class="service-card-title"><a href="{$DATA.search_url}">Tìm xe có sẵn</a></h3>
                        <p class="service-card-subtitle">Tự hào có lâu dài</p>
                    </div>
                </div>
            </div>

            <!-- Card 3: Đăng ký lái thử -->
            <div class="col-lg-3 col-md-6">
                <div class="service-info-card">
                    <div class="service-card-icon">
                        <i class="ri-steering-2-line"></i>
                    </div>
                    <div class="service-card-content">
                        <h3 class="service-card-title"><a href="{$DATA.test_drive_url}">Đăng ký lái thử</a></h3>
                        <p class="service-card-subtitle">Trải nghiệm mẫu xe yêu thích</p>
                    </div>
                </div>
            </div>

            <!-- Card 4: Đặt lịch hẹn dịch vụ -->
            <div class="col-lg-3 col-md-6">
                <div class="service-info-card">
                    <div class="service-card-icon">
                        <i class="ri-calendar-check-line"></i>
                    </div>
                    <div class="service-card-content">
                        <h3 class="service-card-title"><a href="{$DATA.booking_url}">Đặt lịch hẹn dịch vụ</a></h3>
                        <p class="service-card-subtitle">Trực tuyến 24/7</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    .service-info-card {
        display: flex;
        flex-direction: column;
        background: #f0f0f0;
        padding: 15px;
        text-align: center;
        margin-bottom: 8px;
    }

    .service-card-subtitle {
        font-size: 14px;
        font-weight: 600;
    }

    .service-card-link {
        font-family: var(--wb-font-roboto);
        font-weight: 600;
        font-size: 18px;
    }
</style>