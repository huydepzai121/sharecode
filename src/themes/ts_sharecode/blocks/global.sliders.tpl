<!-- BEGIN: main -->
<link rel="stylesheet" href="{NV_STATIC_URL}themes/{TEMPLATE}/assets/vendor/owl.carousel/assets/owl.theme.default.min.css">

<div class="car-slider-section">
    <div class="container">
        <div class="car-slider-wrapper position-relative">
            <p class="text-center">
                <img src="{LOGO_SRC}" alt="Logo">
            </p>
            <div class="desc-title" style="font-size: 20px; font-weight: 600; color: #2c3e50; text-align: center; text-transform: uppercase;" bis_skin_checked="1">
                <i class="fa fa-star text-warning me-2"></i>
               <h2 style="font-size: 18px; display: inline-block; font-weight: 600; text-transform: uppercase;"> Bộ Sưu Tập Mercedes-Benz Chính Hãng Tại Việt Nam</h2>
                <i class="fa fa-star text-warning ms-2"></i>
            </div>
            <div class="owl-carousel owl-theme car-slider" id="carSlider">
                <!-- BEGIN: loop -->
                <div class="car-slide-item">
                    <div class="car-card text-center">
                        <div class="car-image-wrapper">
                            <a href="{CAR.link_url}" title="{CAR.title}">
                                <!-- BEGIN: has_image -->
                                <img src="{CAR.image_url}" alt="{CAR.title}" class="car-image">
                                <!-- END: has_image -->
                                <!-- BEGIN: no_image -->
                                <div class="no-image">
                                    <i class="fa fa-car fa-4x text-muted"></i>
                                </div>
                                <!-- END: no_image -->
                            </a>
                        </div>
                        <div class="car-info">
                            <h3 class="car-title">
                                <a href="{CAR.link_url}" title="{CAR.title}">{CAR.title}</a>
                            </h3>
                            <!-- BEGIN: has_description -->
                            <p class="car-description">{CAR.description}</p>
                            <!-- END: has_description -->
                            <div class="car-price">
                                <!-- BEGIN: original_price -->
                                <div class="original-price">{CAR.original_price}</div>
                                <!-- END: original_price -->
                                <div class="current-price">{CAR.price_display}</div>
                            </div>
                            <!-- BEGIN: promotion_text -->
                            <div class="promotion-text">
                                <span class="promotion-badge">{CAR.promotion_text}</span>
                            </div>
                            <!-- END: promotion_text -->
                        </div>
                    </div>
                </div>
                <!-- END: loop -->
            </div>
        </div>

        <!-- BEGIN: view_all -->
        <div class="view-all-section text-center">
            <a href="{VIEW_ALL_LINK}" class="btn-view-all">
                {VIEW_ALL_TEXT}
            </a>
        </div>
        <!-- END: view_all -->
    </div>
</div>

<style>
.car-slider-section {
    padding: 40px 0;
    background: #ffffff;
    position: relative;
    margin-top: 20px;
}

.car-slider-wrapper {
    max-width: 1600px;
    margin: 0 auto;
    position: relative;
}

.car-slide-item {
    padding: 15px 8px;
    width: 100%;
    box-sizing: border-box;
}

/* Fallback for when OwlCarousel is not loaded */
.car-slider:not(.owl-loaded) .car-slide-item {
    display: inline-block;
    width: 20%; /* 5 items per row */
    vertical-align: top;
}

@media (max-width: 1199px) {
    .car-slider:not(.owl-loaded) .car-slide-item {
        width: 25%; /* 4 items per row */
    }
}

@media (max-width: 991px) {
    .car-slider:not(.owl-loaded) .car-slide-item {
        width: 33.333%; /* 3 items per row */
    }
}

@media (max-width: 767px) {
    .car-slider:not(.owl-loaded) .car-slide-item {
        width: 50%; /* 2 items per row */
    }
}

@media (max-width: 575px) {
    .car-slider:not(.owl-loaded) .car-slide-item {
        width: 100%; /* 1 item per row */
    }
}

.car-card {
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    overflow: hidden;
    transition: all 0.4s ease;
    height: 100%;
    border: 2px solid transparent;
    position: relative;
}

.car-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.15);
}

.car-image-wrapper {
    position: relative;
    height: 140px;
    overflow: hidden;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    display: flex;
    align-items: center;
    justify-content: center;
}

.car-image {
    width: 100%;
    height: 100%;
    object-fit: contain;
    transition: transform 0.4s ease;
    filter: drop-shadow(0 3px 10px rgba(0,0,0,0.15));
}

.car-card:hover .car-image {
    transform: scale(1.05);
}

.no-image {
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f8f9fa;
}

.car-info {
    padding: 20px 15px;
    text-align: center;
}

.car-title {
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 6px;
    line-height: 1.2;
    text-transform: uppercase;
    letter-spacing: 0.3px;
}

.car-title a {
    color: #2c3e50;
    text-decoration: none;
    transition: color 0.3s ease;
}

.car-description {
    font-size: 11px;
    color: #7f8c8d;
    margin-bottom: 12px;
    line-height: 1.3;
    font-style: italic;
}

.car-price {
    margin-bottom: 8px;
}

.original-price {
    font-size: 12px;
    color: #95a5a6;
    text-decoration: line-through;
    margin-bottom: 3px;
}

.current-price {
    font-size: 14px;
    font-weight: 700;
    color: #e74c3c;
}

.promotion-text {
    margin-top: 8px;
}

.promotion-badge {
    background: linear-gradient(45deg, #0a1e4ba8, #0a1e4bba);
    color: white;
    padding: 3px 8px;
    border-radius: 10px;
    font-size: 9px;
    font-weight: 600;
    text-transform: uppercase;
    /* letter-spacing: 0.3px; */
}

.view-all-section {
    margin-top: 40px;
}

.btn-view-all {
    display: inline-block;
    padding: 12px 35px;
    background: #fff;
    color: var(--color--pr);
    text-decoration: none;
    border-radius: 25px;
    font-weight: 600;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 1px;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(0,123,255,0.2);
    border: 2px solid var(--color--pr);
}

.btn-view-all:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(0,123,255,0.3);
    background: var(--color--pr);
    color: white;
    text-decoration: none;
}

/* Force OwlCarousel to work properly */
.owl-carousel {
    display: block !important;
}

.owl-carousel .owl-stage-outer {
    overflow: hidden;
}

.owl-carousel .owl-stage {
    display: flex !important;
    align-items: stretch;
}

.owl-carousel .owl-item {
    float: none !important;
    display: flex !important;
    align-items: stretch;
}

/* Owl Carousel Custom Styles */
.owl-carousel .owl-nav {
    position: absolute;
    top: 50%;
    width: 100%;
    transform: translateY(-50%);
    pointer-events: none;
}

.owl-carousel .owl-nav button {
    position: absolute;
    width: 30px;
    height: 30px;
    background: linear-gradient(45deg, #0a1e4b, #0a1e4b) !important;
    color: #fff !important;
    border-radius: 50%;
    font-size: 18px;
    border: none;
    transition: all 0.3s ease;
    pointer-events: all;
    box-shadow: 0 4px 15px rgba(0,123,255,0.3);
    opacity: 0.9;
}

.owl-carousel .owl-nav button:hover {
    transform: scale(1.1);
    box-shadow: 0 6px 20px rgba(0,123,255,0.4);
    opacity: 1;
}

.owl-carousel .owl-nav .owl-prev {
    left: -25px;
}

.owl-carousel .owl-nav .owl-next {
    right: -25px;
}

.owl-carousel .owl-dots {
    text-align: center;
    margin-top: 30px;
}

.owl-carousel .owl-dots .owl-dot {
    display: inline-block;
    margin: 0 6px;
}

.owl-carousel .owl-dots .owl-dot span {
    width: 12px;
    height: 12px;
    background: #ddd;
    border-radius: 50%;
    display: block;
    transition: all 0.3s ease;
}

.owl-carousel .owl-dots .owl-dot.active span {
    background: var(--color--pr);
    transform: scale(1.3);
}

.owl-carousel .owl-dots .owl-dot:hover span {
    background: var(--color--pr);
    transform: scale(1.1);
}

@media (max-width: 768px) {
    .car-slider-section {
        padding: 30px 0;
    }

    .car-slider-wrapper {
        padding: 0;
    }

    .car-slide-item {
        padding: 15px 8px;
    }

    .car-info {
        padding: 20px 15px;
    }

    .car-title {
        font-size: 16px;
    }

    .current-price {
        font-size: 14px;
    }

    .owl-carousel .owl-nav button {
        width: 40px;
        height: 40px;
        font-size: 16px;
    }

    .owl-carousel .owl-nav .owl-prev {
        left: -20px;
    }

    .owl-carousel .owl-nav .owl-next {
        right: -20px;
    }
}
</style>

<script>
$(document).ready(function() {
    // Wait a bit for all resources to load
    setTimeout(function() {
        if (typeof $.fn.owlCarousel !== 'undefined') {
            console.log('Initializing OwlCarousel...');

            var $carousel = $('#carSlider');

            // Destroy existing carousel if any
            if ($carousel.hasClass('owl-loaded')) {
                $carousel.trigger('destroy.owl.carousel');
                $carousel.removeClass('owl-loaded owl-drag');
            }

            // Initialize carousel
            $carousel.owlCarousel({
                loop: true,
                margin: 20,
                nav: true,
                dots: false,
                autoplay: true,
                autoplayTimeout: 4000,
                autoplayHoverPause: true,
                smartSpeed: 800,
                navText: ['<i class="fa fa-chevron-left"></i>', '<i class="fa fa-chevron-right"></i>'],
                responsive: {
                    0: {
                        items: 1,
                        margin: 10
                    },
                    576: {
                        items: 2,
                        margin: 15
                    },
                    768: {
                        items: 3,
                        margin: 20
                    },
                    992: {
                        items: 4,
                        margin: 20
                    },
                    1200: {
                        items: 4,
                        margin: 20
                    }
                },
                onInitialized: function() {
                    console.log('OwlCarousel initialized successfully!');
                }
            });

            // Custom navigation events
            $carousel.on('click', '.owl-nav button', function() {
                $(this).addClass('clicked');
                setTimeout(() => {
                    $(this).removeClass('clicked');
                }, 200);
            });

        } else {
            console.error('OwlCarousel not found! Please check if the library is loaded.');
        }
    }, 50);
});
</script>
<!-- END: main -->
