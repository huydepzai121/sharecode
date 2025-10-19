<!-- BEGIN: main -->
<section class="website-services-section">
    <div class="container">
        <!-- Section Header -->
        <div class="section-header text-center" data-aos="fade-down">
            <h2 class="section-title">{TITLE}</h2>
            <p class="section-description">{DESCRIPTION}</p>
        </div>

        <!-- Services Grid -->
        <div class="services-grid">
            <div class="service-card" data-aos="fade-up" data-aos-delay="0">
                <div class="service-icon-wrapper" style="background: #e3f2fd;">
                    <i class="fa fa-desktop service-icon" style="color: #2196f3;"></i>
                </div>
                <h3 class="service-title">Website Bán Hàng</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="100">
                <div class="service-icon-wrapper" style="background: #fff3e0;">
                    <i class="fa fa-home service-icon" style="color: #ff9800;"></i>
                </div>
                <h3 class="service-title">Website Bất Động Sản</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="200">
                <div class="service-icon-wrapper" style="background: #e8f5e9;">
                    <i class="fa fa-car service-icon" style="color: #4caf50;"></i>
                </div>
                <h3 class="service-title">Website Ô Tô</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="300">
                <div class="service-icon-wrapper" style="background: #fff3e0;">
                    <i class="fa fa-briefcase service-icon" style="color: #ff9800;"></i>
                </div>
                <h3 class="service-title">Website Công Ty</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="400">
                <div class="service-icon-wrapper" style="background: #fff3e0;">
                    <i class="fa fa-briefcase service-icon" style="color: #ff9800;"></i>
                </div>
                <h3 class="service-title">Website Cổng Thông Tin</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="500">
                <div class="service-icon-wrapper" style="background: #e8f5e9;">
                    <i class="fa fa-scissors service-icon" style="color: #4caf50;"></i>
                </div>
                <h3 class="service-title">Website Dịch Vụ</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="600">
                <div class="service-icon-wrapper" style="background: #f3e5f5;">
                    <i class="fa fa-scissors service-icon" style="color: #9c27b0;"></i>
                </div>
                <h3 class="service-title">Website Thời Trang</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="700">
                <div class="service-icon-wrapper" style="background: #fff3e0;">
                    <i class="fa fa-graduation-cap service-icon" style="color: #ff9800;"></i>
                </div>
                <h3 class="service-title">Website Trường Học</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="800">
                <div class="service-icon-wrapper" style="background: #ffebee;">
                    <i class="fa fa-heartbeat service-icon" style="color: #f44336;"></i>
                </div>
                <h3 class="service-title">Website Y Khoa</h3>
            </div>
            <div class="service-card" data-aos="fade-up" data-aos-delay="900">
                <div class="service-icon-wrapper" style="background: #fff3e0;">
                    <i class="fa fa-futbol-o service-icon" style="color: #ff9800;"></i>
                </div>
                <h3 class="service-title">Website Tổng Hợp</h3>
            </div>
        </div>
    </div>
</section>

<style>
.website-services-section {
    padding: 60px 0;
    background: #ffffff;
    position: relative;
    overflow: hidden;
}

.section-header {
    margin-bottom: 50px;
    position: relative;
    z-index: 1;
}

.section-title {
    font-size: 32px;
    font-weight: 700;
    color: #00b894;
    margin-bottom: 15px;
    text-transform: uppercase;
    letter-spacing: 1px;
    position: relative;
    display: inline-block;
}

.section-title::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 120px;
    height: 3px;
    background: #00b894;
    border-radius: 2px;
}

.section-description {
    font-size: 16px;
    color: #636e72;
    margin-top: 25px;
    max-width: 900px;
    margin-left: auto;
    margin-right: auto;
    line-height: 1.6;
}

.services-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 25px;
    position: relative;
    z-index: 1;
}

.service-card {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 30px 20px;
    text-align: center;
    transition: all 0.3s ease;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
    border: 2px solid #e9ecef;
    position: relative;
    overflow: hidden;
    cursor: pointer;
}

.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 20px rgba(0, 184, 148, 0.15);
    border-color: #00b894;
    background: #ffffff;
}

.service-icon-wrapper {
    width: 80px;
    height: 80px;
    margin: 0 auto 20px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    position: relative;
    z-index: 1;
}

.service-card:hover .service-icon-wrapper {
    transform: scale(1.05);
}

.service-icon {
    font-size: 40px;
    transition: all 0.3s ease;
}

.service-card:hover .service-icon {
    transform: scale(1.1);
}

.service-title {
    font-size: 14px;
    font-weight: 700;
    color: #00b894;
    margin: 0;
    line-height: 1.4;
    transition: color 0.3s ease;
    position: relative;
    z-index: 1;
    text-transform: uppercase;
}

.service-card:hover .service-title {
    color: #00a383;
}

/* Responsive Design */
@media (max-width: 1199px) {
    .services-grid {
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
    }
}

@media (max-width: 991px) {
    .services-grid {
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
    }

    .section-title {
        font-size: 28px;
    }

    .service-icon-wrapper {
        width: 70px;
        height: 70px;
    }

    .service-icon {
        font-size: 32px;
    }

    .service-title {
        font-size: 14px;
    }
}

@media (max-width: 767px) {
    .website-services-section {
        padding: 40px 0;
    }

    .services-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 15px;
    }

    .section-header {
        margin-bottom: 35px;
    }

    .section-title {
        font-size: 24px;
    }

    .section-description {
        font-size: 14px;
    }

    .service-card {
        padding: 25px 15px;
    }

    .service-icon-wrapper {
        width: 60px;
        height: 60px;
        margin-bottom: 15px;
    }

    .service-icon {
        font-size: 28px;
    }

    .service-title {
        font-size: 13px;
    }
}

@media (max-width: 480px) {
    .website-services-section {
        padding: 30px 0;
    }

    .services-grid {
        gap: 12px;
    }

    .section-title {
        font-size: 20px;
    }

    .section-title::after {
        width: 60px;
        height: 3px;
    }

    .service-card {
        padding: 20px 10px;
        border-radius: 12px;
    }

    .service-icon-wrapper {
        width: 55px;
        height: 55px;
    }

    .service-icon {
        font-size: 24px;
    }

    .service-title {
        font-size: 12px;
    }
}



/* Print styles */
@media print {
    .website-services-section {
        padding: 20px 0;
        background: white;
    }

    .service-card {
        box-shadow: none;
        border: 1px solid #ddd;
        break-inside: avoid;
    }

    .service-card:hover {
        transform: none;
    }
}
</style>
<!-- END: main -->

