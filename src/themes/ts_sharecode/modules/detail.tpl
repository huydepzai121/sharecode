<!-- BEGIN: main -->
<!-- Structured Data for Car Detail Page -->
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Car",
    "@id": "{CAR.detail_url}",
    "name": "{CAR.title}",
    "description": "{CAR.description_clean}",
    "image": [
        "{CAR.main_image}"
        <!-- BEGIN: gallery_images -->
        ,"{GALLERY_IMAGE.src}"
        <!-- END: gallery_images -->
    ],
    "brand": {
        "@type": "Brand",
        "name": "Mercedes-Benz",
        "logo": "{NV_BASE_SITEURL}uploads/logo.svg"
    },
    "model": "{CAR.title}",
    "vehicleConfiguration": "{CAR.category_title}",
    "vehicleEngine": {
        "@type": "EngineSpecification",
        "name": "{CAR.engine_type}",
        "fuelType": "{CAR.fuel_type}"
    },
    "fuelConsumption": {
        "@type": "QuantitativeValue",
        "value": "{CAR.fuel_consumption}",
        "unitText": "L/100km"
    },
    "vehicleTransmission": "{CAR.transmission}",
    "numberOfDoors": "{CAR.doors}",
    "seatingCapacity": "{CAR.seats}",
    "offers": {
        "@type": "Offer",
        "price": "{CAR.price_number}",
        "priceCurrency": "VND",
        "availability": "https://schema.org/InStock",
        "priceValidUntil": "{CAR.price_valid_until}",
        "seller": {
            "@type": "Organization",
            "name": "Mercedes-Benz Vietnam",
            "url": "{NV_BASE_SITEURL}",
            "telephone": "1900-1234"
        },
        "url": "{CAR.detail_url}"
    },
    "manufacturer": {
        "@type": "Organization",
        "name": "Mercedes-Benz",
        "url": "https://www.mercedes-benz.com"
    },
    "category": "Automobile",
    "url": "{CAR.detail_url}",
    "mainEntityOfPage": {
        "@type": "WebPage",
        "@id": "{CAR.detail_url}"
    }
}
</script>

<!-- Product Schema -->
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Product",
    "name": "{CAR.title}",
    "description": "{CAR.description_clean}",
    "image": [
        "{CAR.main_image}"
        <!-- BEGIN: gallery_images -->
        ,"{GALLERY_IMAGE.src}"
        <!-- END: gallery_images -->
    ],
    "brand": {
        "@type": "Brand",
        "name": "Mercedes-Benz"
    },
    "model": "{CAR.title}",
    "category": "Automobile",
    "offers": {
        "@type": "Offer",
        "price": "{CAR.price_number}",
        "priceValidUntil": "{CAR.price_valid_until}",
        "priceCurrency": "VND",
        "availability": "https://schema.org/InStock",
        "seller": {
            "@type": "Organization",
            "name": "Mercedes-Benz Vietnam"
        }
    },
    "aggregateRating": {
        "@type": "AggregateRating",
        "ratingValue": "{CAR.rating_value}",
        "reviewCount": "{CAR.review_count}",
        "bestRating": "5",
        "worstRating": "1"
    }
}
</script>

<!-- Breadcrumb Schema -->
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
        {
            "@type": "ListItem",
            "position": 1,
            "name": "Trang chủ",
            "item": "{NV_BASE_SITEURL}"
        },
        {
            "@type": "ListItem",
            "position": 2,
            "name": "Danh mục xe",
            "item": "{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=category"
        },
        {
            "@type": "ListItem",
            "position": 3,
            "name": "{CAR.category_title}",
            "item": "{CAR.category_url}"
        },
        {
            "@type": "ListItem",
            "position": 4,
            "name": "{CAR.title}",
            "item": "{CAR.detail_url}"
        }
    ]
}
</script>

<!-- Organization Schema -->
<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Organization",
    "name": "Mercedes-Benz Vietnam",
    "url": "{NV_BASE_SITEURL}",
    "logo": "{NV_BASE_SITEURL}uploads/logo.svg",
    "description": "Đại lý chính thức Mercedes-Benz tại Việt Nam",
    "address": {
        "@type": "PostalAddress",
        "streetAddress": "số 46 Láng Hạ, phường Láng",
        "addressLocality": "Hà Nội",
        "addressCountry": "VN"
    },
    "contactPoint": {
        "@type": "ContactPoint",
        "telephone": "1900-1234",
        "contactType": "customer service",
        "availableLanguage": ["Vietnamese", "English"]
    }
}
</script>

<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/assets/vendor/boxicons/css/boxicons.min.css">
<link rel="stylesheet" href="{NV_BASE_SITEURL}themes/{TEMPLATE}/assets/vendor/remixicon/remixicon.css">
<link rel="stylesheet" href="{LINK_URL}/css/swiper-bundle.min.css">
<link rel="stylesheet" href="{LINK_URL}/css/picbox.css">
<link rel="stylesheet" href="{LINK_URL}/css/lightgallery.css">
<link rel="stylesheet" href="{LINK_URL}/css/gallery-fix.css">
<script src="{LINK_URL}/js/swiper-bundle.min.js"></script>
<script src="{LINK_URL}/js/picbox.js"></script>
<script type="text/javascript" src="{LINK_URL}/js/custom_swiper.js"></script>

<div class="car-detail-page">
    <!-- Car Hero Section -->
    <section class="car-hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="car-image-gallery">
                        <div class="main-image-container">
                            <!-- BEGIN: has_main_image -->
                            <div class="product-image-block relative">
                                <div class="swiper-image">
                                    <div class="swiper-container gallery-top">
                                        <div class="swiper-wrapper" id="lightgallery">
                                            <a class="swiper-slide swiper-slide-active" data-hash="0" href="{CAR.main_image}" title="{CAR.title}">
                                                <img itemprop="image" src="{CAR.main_image}" alt="{CAR.title}" class="img-responsive mx-auto d-block swiper-lazy swiper-lazy-loaded imgage__slide_first">
                                            </a>
                                        </div>
                                    </div>

                                    <div class="swiper-container gallery-thumbs">
                                        <div class="swiper-wrapper">
                                            <div class="swiper-slide">
                                                <img height="80" width="80" src="{CAR.main_image}" alt="{CAR.title}" data-image="{CAR.main_image}" class="swiper-lazy">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- END: has_main_image -->

                            <!-- BEGIN: no_main_image -->
                           
                            <!-- END: no_main_image -->
                        </div>

                        <!-- BEGIN: gallery -->
                        <div class="product-image-block relative">
                            <div class="swiper-image">
                                <div class="swiper-container gallery-top">
                                    <div class="swiper-wrapper" id="lightgallery">
                                        <!-- BEGIN: image1 -->
                                        <a class="swiper-slide swiper-slide-active" data-hash="0" href="{IMAGE.src}" title="{IMAGE.alt}" data-item="{IMAGE.index}">
                                            <img src="{IMAGE.src}" alt="{IMAGE.alt}" class="img-responsive mx-auto d-block swiper-lazy swiper-lazy-loaded imgage__slide_first">
                                        </a>
                                        <!-- END: image1 -->
                                    </div>

                                    <div class="swiper-button-next swiper-button-white"></div>
                                    <div class="swiper-button-prev swiper-button-white"></div>
                                </div>

                                <div class="swiper-container gallery-thumbs">
                                    <div class="swiper-wrapper">
                                        <!-- BEGIN: image -->
                                        <div class="swiper-slide <!-- BEGIN: active --> active<!-- END: active -->" data-item="{IMAGE.index}">
                                            <img height="80" width="80" src="{IMAGE.src}" alt="{IMAGE.alt}" data-image="{IMAGE.src}" class="swiper-lazy">
                                        </div>
                                        <!-- END: image -->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END: gallery -->
                    </div>
                </div>
                
                <div class="col-lg-4">
                    <div class="car-info-card">
                        <div class="car-header">
                            <h1 class="car-title">{CAR.title} <span class="discount-percent">Giảm {CAR.discount_percent}%</span></h1>
                            <!-- BEGIN: featured -->
                            <span class="badge badge-featured">
                                <i class="bx bx-star"></i> Xe nổi bật
                            </span>
                            <!-- END: featured -->
                        </div>
                        
                        <div class="car-price-section">
                            <!-- BEGIN: has_promotion -->
                            <div class="price-promotion">
                                <span class="price-old">Giá niêm yết: {CAR.price_formatted}</span>
                                <span class="price-current">Giá sau giảm: {CAR.price_promotion_formatted}</span>
                            </div>
                            <!-- END: has_promotion -->
                            <!-- BEGIN: no_promotion -->
                            <div class="price-normal">
                                <span class="price-current">{CAR.price_formatted}</span>
                            </div>
                            <!-- END: no_promotion -->
                        </div>
                        
                        <div class="car-quick-specs">
                            <!-- BEGIN: has_year -->
                            <div class="spec-item">
                                <i class="ri-calendar-line"></i>
                                <span class="spec-label">Năm sản xuất:</span>
                                <span class="spec-value">{CAR.year}</span>
                            </div>
                            <!-- END: has_year -->

                            <!-- BEGIN: has_fuel_type -->
                            <div class="spec-item">
                                <i class="ri-gas-station-line"></i>
                                <span class="spec-label">Nhiên liệu:</span>
                                <span class="spec-value">{CAR.fuel_type}</span>
                            </div>
                            <!-- END: has_fuel_type -->

                            <!-- BEGIN: has_transmission -->
                            <div class="spec-item">
                                <i class="ri-settings-3-line"></i>
                                <span class="spec-label">Hộp số:</span>
                                <span class="spec-value">{CAR.transmission}</span>
                            </div>
                            <!-- END: has_transmission -->

                            <!-- BEGIN: has_seats -->
                            <div class="spec-item">
                                <i class="ri-user-3-line"></i>
                                <span class="spec-label">Số chỗ ngồi:</span>
                                <span class="spec-value">{CAR.seats}</span>
                            </div>
                            <!-- END: has_seats -->

                            <!-- BEGIN: has_versions -->
                            <div class="spec-item">
                                <i class="ri-bookmark-line"></i>
                                <span class="spec-label">Phiên bản:</span>
                                <span class="spec-value">{CAR.versions}</span>
                            </div>
                            <!-- END: has_versions -->

                            <!-- BEGIN: has_color -->
                            <div class="spec-item">
                                <i class="ri-palette-line"></i>
                                <span class="spec-label">Màu sắc:</span>
                                <span class="spec-value">{CAR.color}</span>
                            </div>
                            <!-- END: has_color -->

                            <!-- BEGIN: has_specifications_pdf -->
                            <div class="spec-item">
                                <i class="ri-file-pdf-line"></i>
                                <span class="spec-label">File thông số kỹ thuật:</span>
                                <span class="spec-value">
                                    <a href="{CAR.specifications_pdf}" target="_blank" class="pdf-link">
                                        <i class="ri-download-line"></i> Tải xuống PDF
                                    </a>
                                </span>
                            </div>
                            <!-- END: has_specifications_pdf -->
                        </div>
                        
                        <div class="car-actions">
                            <button class="btn btn-primary btn-lg btn-block contact-btn mb-2">
                                <i class="bx bx-phone"></i> Liên hệ tư vấn
                            </button>
                            <button class="btn btn-success btn-lg btn-block test-drive-btn mb-2"
                                    data-car-id="{CAR.id}"
                                    data-car-name="{CAR.title}">
                                <i class="bx bx-car"></i> Đăng ký lái thử
                            </button>
                            <button class="btn btn-outline-primary btn-lg btn-block hidden">
                                <i class="bx bx-heart"></i> Yêu thích
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <section class="car-details-tabs">
        <div class="container">
            <div class="row">
                <!-- BEGIN: has_promotion_info -->
                <div class="col-12">
                    <div style="border: 2px dotted #cb6060; padding: 12px;">
                    {CAR.promotion_info}
                    </div>
                </div>
                <!-- END: has_promotion_info -->

                <div class="col-12">
                    <ul class="nav nav-tabs car-tabs" id="carTabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="description-tab" data-toggle="tab" href="#description" role="tab">
                                <i class="bx bx-info-circle"></i> Mô tả xe
                            </a>
                        </li>

                        <!-- BEGIN: has_specifications1 -->
                        <li class="nav-item">
                            <a class="nav-link" id="specifications-tab" data-toggle="tab" href="#specifications" role="tab">
                                <i class="bx bx-cog"></i> Thông số kỹ thuật
                            </a>
                        </li>
                        <!-- END: has_specifications1 -->

                        <!-- BEGIN: has_amenities -->
                        <li class="nav-item">
                            <a class="nav-link" id="amenities-tab" data-toggle="tab" href="#amenities" role="tab">
                                <i class="bx bx-star"></i> Thông tin tiện nghi
                            </a>
                        </li>
                        <!-- END: has_amenities -->

                        <!-- BEGIN: has_safety_info -->
                        <li class="nav-item">
                            <a class="nav-link" id="safety-tab" data-toggle="tab" href="#safety" role="tab">
                                <i class="bx bx-shield"></i> An toàn
                            </a>
                        </li>
                        <!-- END: has_safety_info -->

                        <!-- BEGIN: has_pricing_table1 -->
                        <li class="nav-item">
                            <a class="nav-link" id="pricing-tab" data-toggle="tab" href="#pricing" role="tab">
                                <i class="bx bx-money"></i> Bảng giá
                            </a>
                        </li>
                        <!-- END: has_pricing_table1 -->

                        <li class="nav-item">
                            <a class="nav-link" id="installment-tab" data-toggle="tab" href="#installment" role="tab">
                                <i class="bx bx-credit-card"></i> Trả góp
                            </a>
                        </li>
                    </ul>
                    
                    <div class="tab-content car-tab-content" id="carTabsContent">
                        <div class="tab-pane show active" id="description" role="tabpanel">
                            <div class="description-content">
                                <div class="car-overview">
                                    <h2 class="mb-4 hidden">Mô tả xe {CAR.title}</h2>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="description-text">
                                                {CAR.content}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="tab-pane" id="specifications" role="tabpanel">
                            <div class="specifications-content">
                                <h2 class="mb-4 hidden">Thông số kỹ thuật {CAR.title}</h2>
                                <!-- BEGIN: has_specifications -->
                                <div class="row">
                                    <div class="col-md-12">
                                        {SPECIFICATIONS_HTML}
                                    </div>
                                </div>
                                <!-- END: has_specifications -->
                                <!-- BEGIN: no_specifications -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <p class="text-muted">Thông số kỹ thuật sẽ được cập nhật sớm.</p>
                                    </div>
                                </div>
                                <!-- END: no_specifications -->
                            </div>
                        </div>
                        
                        <div class="tab-pane" id="amenities" role="tabpanel">
                            <div class="amenities-content">
                                <h3 class="mb-4 hidden">Thông tin tiện nghi {CAR.title}</h3>
                                <div class="row">
                                    <div class="col-md-12">
                                        {CAR.amenities}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="safety" role="tabpanel">
                            <div class="safety-content">
                                <h3 class="mb-4 hidden">Thông tin An toàn</h3>
                                <div class="row">
                                    <div class="col-md-12">
                                        {CAR.safety_info}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="pricing" role="tabpanel">
                            <div class="pricing-content">
                                <h3 class="mb-4 hidden">Bảng giá lăn bánh {CAR.title}</h3>

                                <!-- BEGIN: has_pricing_table -->
                                <div class="pricing-table-container">
                                    <div class="table-responsive">
                                        <table class="table table-bordered pricing-table">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th>Địa chỉ</th>
                                                    <th>Giá niêm yết</th>
                                                    <th>Giá lăn bánh</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- BEGIN: pricing_row -->
                                                <tr>
                                                    <td><strong>{PRICING.address}</strong></td>
                                                    <td>{PRICING.list_price}</td>
                                                    <td>{PRICING.road_price}</td>
                                                </tr>
                                                <!-- END: pricing_row -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- END: has_pricing_table -->

                                <div class="pricing-notes mt-4">
                                    <h4>Ghi chú về giá</h4>
                                    <div class="alert alert-warning">
                                        <p>Giá trên là giá dự kiến, giá có thể thay đổi tuỳ theo thời điểm bán hàng
                                            </p>
                                        <p>Hãy liên hệ với số Hotline: <a href="tel:0929319666" class="service-card-link">0929.319.666</a> để được tư vấn chi tiết</p>
                                    </div>

                                    <div class="alert alert-info">
                                        <ul class="nav mb-0">
                                            <li>Giá lăn bánh đã bao gồm: VAT, phí trước bạ, bảo hiểm bắt buộc, phí đăng ký</li>
                                            <li>Giá có thể thay đổi tùy theo từng khu vực và chính sách của đại lý</li>
                                            <li>Chưa bao gồm: Bảo hiểm tự nguyện, phụ kiện tùy chọn</li>
                                            <li>Liên hệ showroom để được tư vấn giá tốt nhất</li>
                                        </ul>
                                    </div>
                                </div>

                                <!-- BEGIN: has_promotions -->
                                <div class="current-promotions mt-4">
                                    <h4>Ưu đãi hiện tại</h4>
                                    <div class="row">
                                        <!-- BEGIN: promotion -->
                                        <div class="col-md-6 mb-3">
                                            <div class="promotion-card">
                                                <div class="promotion-header">
                                                    <i class="bx bx-gift text-danger"></i>
                                                    <strong>{PROMOTION.title}</strong>
                                                </div>
                                                <div class="promotion-content">
                                                    <p>{PROMOTION.description}</p>
                                                    <!-- BEGIN: has_value -->
                                                    <div class="promotion-value">
                                                        Giá trị: <span class="text-danger font-weight-bold">{PROMOTION.value}</span>
                                                    </div>
                                                    <!-- END: has_value -->
                                                    <!-- BEGIN: has_expiry -->
                                                    <small class="text-muted">Có hiệu lực đến: {PROMOTION.expiry_date}</small>
                                                    <!-- END: has_expiry -->
                                                </div>
                                            </div>
                                        </div>
                                        <!-- END: promotion -->
                                    </div>
                                </div>
                                <!-- END: has_promotions -->
                            </div>
                        </div>

                        <div class="tab-pane" id="installment" role="tabpanel">
                            <div class="installment-content">
                                <h3 class="mb-4 hidden">Thông tin trả góp {CAR.title}</h3>

                                <!-- BEGIN: has_installment_options -->
                                <div class="installment-calculator">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="calculator-form">
                                                <h4>Tính toán trả góp</h4>
                                                <form id="installmentCalculator">
                                                    <div class="form-group">
                                                        <label>Giá xe</label>
                                                        <input type="text" class="form-control" id="carPrice" value="{CAR.final_price_formatted}" readonly>
                                                        <input type="hidden" id="carPriceNumber" value="{CAR.price_number}">
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Trả trước (%)</label>
                                                        <select class="form-control" id="downPaymentPercent">
                                                            <option value="20">20%</option>
                                                            <option value="30" selected>30%</option>
                                                            <option value="40">40%</option>
                                                            <option value="50">50%</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Thời gian vay (năm)</label>
                                                        <select class="form-control" id="loanTerm">
                                                            <option value="3">3 năm</option>
                                                            <option value="5" selected>5 năm</option>
                                                            <option value="7">7 năm</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Lãi suất (%/năm)</label>
                                                        <input type="number" class="form-control" id="interestRate" value="8.5" step="0.1">
                                                    </div>
                                                    <button type="button" class="btn btn-primary btn-block mb-2" onclick="calculateInstallment()">
                                                        <i class="bx bx-calculator"></i> Kiểm tra kết quả
                                                    </button>
                                                </form>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="calculation-result">
                                                <h4>Kết quả tính toán</h4>
                                                <div class="result-card">
                                                    <div class="result-item">
                                                        <span class="result-label">Số tiền trả trước:</span>
                                                        <span class="result-value" id="downPaymentAmount">-</span>
                                                    </div>
                                                    <div class="result-item">
                                                        <span class="result-label">Số tiền vay:</span>
                                                        <span class="result-value" id="loanAmount">-</span>
                                                    </div>
                                                    <div class="result-item">
                                                        <span class="result-label">Trả hàng tháng:</span>
                                                        <span class="result-value highlight" id="monthlyPayment">-</span>
                                                    </div>
                                                    <div class="result-item">
                                                        <span class="result-label">Tổng tiền phải trả:</span>
                                                        <span class="result-value" id="totalPayment">-</span>
                                                    </div>
                                                    <div class="result-item">
                                                        <span class="result-label">Tổng tiền lãi:</span>
                                                        <span class="result-value" id="totalInterest">-</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END: has_installment_options -->

                                <div class="installment-banks mt-5 hidden">
                                    <h4>Ngân hàng hỗ trợ vay</h4>
                                    <div class="row">
                                        <!-- BEGIN: bank -->
                                        <div class="col-md-4 col-sm-6 mb-3">
                                            <div class="bank-card">
                                                <div class="bank-logo">
                                                    <img src="{BANK.logo}" alt="{BANK.name}" class="img-fluid">
                                                </div>
                                                <div class="bank-info">
                                                    <h5>{BANK.name}</h5>
                                                    <p class="bank-rate">Lãi suất từ: <strong>{BANK.interest_rate}%/năm</strong></p>
                                                    <p class="bank-term">Thời gian vay: {BANK.max_term}</p>
                                                    <!-- BEGIN: has_promotion -->
                                                    <div class="bank-promotion">
                                                        <i class="bx bx-gift text-danger"></i>
                                                        <small>{BANK.promotion}</small>
                                                    </div>
                                                    <!-- END: has_promotion -->
                                                </div>
                                            </div>
                                        </div>
                                        <!-- END: bank -->
                                    </div>
                                </div>

                                <div class="installment-requirements mt-4">
                                    <h4>Điều kiện vay mua xe</h4>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="requirements-list">
                                                <h5>Hồ sơ cần thiết:</h5>
                                                <ul style="padding-left: 0">
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> CMND/CCCD (bản gốc + photocopy)</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Hộ khẩu (bản gốc + photocopy)</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Giấy đăng ký kết hôn (nếu có)</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Bảng lương 3 tháng gần nhất</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Sao kê tài khoản 6 tháng</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Hợp đồng lao động</li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="requirements-list">
                                                <h5>Điều kiện:</h5>
                                                <ul style="padding-left: 0">
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Tuổi: 18-65 tuổi</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Thu nhập ổn định tối thiểu 15 triệu/tháng</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Thời gian làm việc tại công ty hiện tại ≥ 6 tháng</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Không nợ xấu tại các ngân hàng</li>
                                                    <li><i class="fa fa-dot-circle-o" aria-hidden="true"></i> Trả trước tối thiểu 20% giá trị xe</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- BEGIN: show_related_car -->
    <section class="related-cars">
        <div class="container">
            <h3 class="section-title"> <i class="fa fa-star text-warning me-2"></i> Xe liên quan <i class="fa fa-star text-warning me-2"></i> </h3>
            <div class="row">
                <!-- BEGIN: related_car -->
                <div class="col-lg-4 col-md-4 d-flex align-items-stretch mb-2">
                    <div class="course-item">
                        <div class="car-image-container position-relative">
                            <img src="{RELATED_CAR.main_image}" class="img-fluid car-image" alt="{RELATED_CAR.title}">
                            <!-- BEGIN: has_promotion -->
                            <!-- Promotion Badge -->
                            <div class="promotion-badge">
                                <span class="discount-percent animate__animated animate__pulse">-{RELATED_CAR.discount_percent}%</span>
                            </div>
                            <!-- END: has_promotion -->
                            <!-- Car Options Icons -->
                            <div class="car-options-icons">
                                <!-- BEGIN: has_engine_power -->
                                <div class="option-icon">
                                    <i class="bx bx-tachometer"></i>
                                    <span>{RELATED_CAR.engine_power}</span>
                                </div>
                                <!-- END: has_engine_power -->
                                <!-- BEGIN: has_fuel_type -->
                                <div class="option-icon">
                                    <i class="bx bx-gas-pump"></i>
                                    <span>{RELATED_CAR.fuel_type}</span>
                                </div>
                                <!-- END: has_fuel_type -->
                                <!-- BEGIN: has_seats -->
                                <div class="option-icon">
                                    <i class="bx bx-user"></i>
                                    <span>{RELATED_CAR.seats}</span>
                                </div>
                                <!-- END: has_seats -->
                                <!-- BEGIN: has_year -->
                                <div class="option-icon">
                                    <i class="bx bx-calendar"></i>
                                    <span>{RELATED_CAR.year}</span>
                                </div>
                                <!-- END: has_year -->
                                <!-- BEGIN: has_color -->
                                <div class="option-icon">
                                    <i class="bx bx-palette"></i>
                                    <span>{RELATED_CAR.color}</span>
                                </div>
                                <!-- END: has_color -->
                            </div>
                        </div>
                        <div class="course-content">
                            <h4><a href="{RELATED_CAR.detail_url}" class="car-title-link">{RELATED_CAR.title}</a></h4>
                            <div class="d-flex align-items-center">
                                    <!-- BEGIN: has_promotion_price -->
                                    <p class="price">Giá niêm yết: {RELATED_CAR.price_formatted}</p>
                                    <p class="original-price">Giá sau giảm: {RELATED_CAR.price_promotion_formatted}</p>
                                    <!-- END: has_promotion_price -->
                                    <!-- BEGIN: no_promotion_price -->
                                    <p class="price">{RELATED_CAR.price_formatted}</p>
                                    <!-- END: no_promotion_price -->
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="trainer-profile d-flex align-items-center">
                                    <i class="bx bx-user"></i>&nbsp;{RELATED_CAR.category_title}
                                    &nbsp;&nbsp;
                                </div>
                                <div class="d-flex align-items-center">
                                    <small><i class="fa fa-eye" aria-hidden="true"></i>&nbsp;{RELATED_CAR.views_formatted} lượt xem</small>
                                </div>
                            </div>
                            <div class="car-actions mt-3">
                                <a href="{RELATED_CAR.detail_url}" class="btn btn-primary btn-sm">
                                    <i class="bx bx-show"></i> Xem chi tiết
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: related_car -->
            </div>
        </div>
    </section>
    <!-- END: show_related_car -->
</div>

<!-- Modal đăng ký lái thử -->
<div class="modal" id="testDriveModal" tabindex="-1" aria-labelledby="testDriveModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <p class="modal-title" id="testDriveModalLabel">
                    <i class="bx bx-car me-2"></i>Đăng Ký Lái Thử
                </p>
            </div>
            <div class="modal-body">
                <div class="alert alert-info">
                    <i class="bx bx-info-circle me-2"></i>
                    <strong>Xe đăng ký:</strong> <span id="selectedCarName"></span>
                </div>

                <form id="testDriveForm">
                    <input type="hidden" name="token" value="{TOKEN}" />
                    <input type="hidden" name="ajax_test_drive" value="1" />
                    <input type="hidden" name="car_id" id="carIdInput" value="" />

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group mb-3">
                                <label for="testFullName" class="form-label">
                                    <i class="bx bx-user text-primary me-1"></i>Họ và tên <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control" name="full_name" id="testFullName"
                                       placeholder="Nhập họ và tên của bạn" required />
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group mb-3">
                                <label for="testPhone" class="form-label">
                                    <i class="bx bx-phone text-primary me-1"></i>Số điện thoại <span class="text-danger">*</span>
                                </label>
                                <input type="tel" class="form-control" name="phone" id="testPhone"
                                       placeholder="Nhập số điện thoại của bạn" required />
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="testAddress" class="form-label">
                            <i class="bx bx-map text-primary me-1"></i>Địa chỉ <span class="text-danger">*</span>
                        </label>
                        <textarea class="form-control" name="address" id="testAddress" rows="3"
                                  placeholder="Nhập địa chỉ của bạn" required></textarea>
                        <div class="invalid-feedback"></div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group mb-3">
                                <label for="testDate" class="form-label">
                                    <i class="bx bx-calendar text-primary me-1"></i>Ngày lái thử <span class="text-danger">*</span>
                                </label>
                                <input type="date" class="form-control" name="test_date" id="testDate"
                                       min="" required />
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group mb-3">
                                <label for="testTime" class="form-label">
                                    <i class="bx bx-time text-primary me-1"></i>Thời gian mong muốn <span class="text-danger">*</span>
                                </label>
                                <select class="form-control" name="test_time" id="testTime" required>
                                    <option value="">-- Chọn thời gian --</option>
                                    <option value="Sáng (8h-12h)">Sáng (8h-12h)</option>
                                    <option value="Chiều (13h-17h)">Chiều (13h-17h)</option>
                                    <option value="Tối (18h-21h)">Tối (18h-21h)</option>
                                    <option value="Cuối tuần">Cuối tuần</option>
                                    <option value="Bất kỳ lúc nào">Bất kỳ lúc nào</option>
                                </select>
                                <div class="invalid-feedback"></div>
                            </div>
                        </div>
                    </div>

                    <div class="alert alert-warning">
                        <i class="bx bx-info-circle me-2"></i>
                        <small>Chúng tôi sẽ liên hệ với bạn trong vòng 24h để xác nhận lịch lái thử.</small>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-modal-btn" data-bs-dismiss="modal">
                    <i class="bx bx-x me-1"></i>Hủy
                </button>
                <button type="button" class="btn btn-success" id="submitTestDrive">
                    <i class="bx bx-check me-1"></i>Đăng ký lái thử
                </button>
            </div>
        </div>
    </div>
</div>

<script>
// Global function để show modal
function showTestDriveModal(carId, carName) {
    console.log('showTestDriveModal called with:', carId, carName);

    $('#carIdInput').val(carId);
    $('#selectedCarName').text(carName);

    console.log('Updated selectedCarName to:', carName);
    console.log('selectedCarName element text:', $('#selectedCarName').text());

    // Thiết lập ngày tối thiểu cho date picker (ngày hôm nay)
    var today = new Date();
    var todayString = today.getFullYear() + '-' +
                     String(today.getMonth() + 1).padStart(2, '0') + '-' +
                     String(today.getDate()).padStart(2, '0');
    $('#testDate').attr('min', todayString);

    // Simple modal show
    $('#testDriveModal').addClass('show').css('display', 'block');
    $('body').addClass('modal-open');

    // Add backdrop
    if ($('.modal-backdrop').length === 0) {
        $('body').append('<div class="modal-backdrop fade show"></div>');
    }
}

// Function hiển thị modal thành công
function showSuccessModal(title, message) {
    // Tạo modal thông báo thành công
    const successModal = `
        <div class="modal show" id="successModal" tabindex="-1" style="display: block; z-index: 10000;">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg">
                    <div class="modal-header bg-success text-white text-center">
                        <h5 class="modal-title w-100">
                            <i class="bx bx-check-circle me-2"></i>`+ title + `
                        </h5>
                    </div>
                    <div class="modal-body text-center py-4">
                        <div class="mb-3">
                            <i class="bx bx-check-circle text-success" style="font-size: 4rem;"></i>
                        </div>
                        <p class="mb-0 fs-5">`+ message + `</p>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <button type="button" class="btn btn-success px-4" onclick="closeSuccessModal()">
                            <i class="bx bx-check me-1"></i>Đã hiểu
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-backdrop fade show"></div>
    `;

    $('body').append(successModal);
    $('body').addClass('modal-open');
}

// Function đóng modal thành công
function closeSuccessModal() {
    $('#successModal').remove();
    $('.modal-backdrop').remove();
    $('body').removeClass('modal-open');
}

// Function hiển thị alert lỗi
function showErrorAlert(title, message) {
    $('body').prepend(`
        <div class="alert alert-danger alert-dismissible fade show position-fixed"
             style="top: 20px; right: 20px; z-index: 9999; min-width: 350px; max-width: 500px;">
            <h6 class="alert-heading mb-2">
                <i class="bx bx-error me-2"></i>${title}
            </h6>
            <p class="mb-0">${message}</p>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    `);

    // Tự động ẩn sau 8 giây
    setTimeout(function() {
        $('.alert-danger').fadeOut();
    }, 8000);
}

$(document).ready(function() {

    // Xử lý click nút đăng ký lái thử
    $('.test-drive-btn').on('click', function(e) {
        e.preventDefault();

        var carId = $(this).data('car-id');
        var carName = $(this).data('car-name');

        console.log('Car ID:', carId);
        console.log('Car Name:', carName);

        showTestDriveModal(carId, carName);
    });

    // Xử lý click nút liên hệ tư vấn
    $('.contact-btn').on('click', function(e) {
        e.preventDefault();
        // Chuyển sang trang contact
        window.location.href = '{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&{NV_NAME_VARIABLE}={MODULE_NAME}&{NV_OP_VARIABLE}=contact';
    });

    // Xử lý submit form đăng ký lái thử
    $('#submitTestDrive').on('click', function() {
        var form = $('#testDriveForm');
        var submitBtn = $(this);

        // Reset validation
        form.find('.is-invalid').removeClass('is-invalid');
        form.find('.invalid-feedback').text('');

        // Validate form
        var isValid = true;
        var fullName = $('#testFullName').val().trim();
        var phone = $('#testPhone').val().trim();
        var address = $('#testAddress').val().trim();
        var testDate = $('#testDate').val();
        var testTime = $('#testTime').val();

        if (!fullName) {
            $('#testFullName').addClass('is-invalid').siblings('.invalid-feedback').text('Vui lòng nhập họ và tên');
            isValid = false;
        }

        if (!phone) {
            $('#testPhone').addClass('is-invalid').siblings('.invalid-feedback').text('Vui lòng nhập số điện thoại');
            isValid = false;
        } else if (!/^[0-9+\-\s\(\)]{8,15}$/.test(phone)) {
            $('#testPhone').addClass('is-invalid').siblings('.invalid-feedback').text('Số điện thoại không hợp lệ');
            isValid = false;
        }

        if (!address) {
            $('#testAddress').addClass('is-invalid').siblings('.invalid-feedback').text('Vui lòng nhập địa chỉ');
            isValid = false;
        }

        if (!testDate) {
            $('#testDate').addClass('is-invalid').siblings('.invalid-feedback').text('Vui lòng chọn ngày lái thử');
            isValid = false;
        } else {
            // Kiểm tra ngày không được trong quá khứ
            var selectedDate = new Date(testDate);
            var today = new Date();
            today.setHours(0, 0, 0, 0);

            if (selectedDate < today) {
                $('#testDate').addClass('is-invalid').siblings('.invalid-feedback').text('Ngày lái thử không được trong quá khứ');
                isValid = false;
            }
        }

        if (!testTime) {
            $('#testTime').addClass('is-invalid').siblings('.invalid-feedback').text('Vui lòng chọn thời gian');
            isValid = false;
        }

        if (!isValid) return;

        // Disable button và hiển thị loading
        submitBtn.prop('disabled', true).html('<i class="bx bx-loader-alt bx-spin me-1"></i>Đang xử lý...');

        // Submit AJAX
        $.ajax({
            url: window.location.href,
            type: 'POST',
            data: form.serialize(),
            dataType: 'json',
            beforeSend: function() {
                console.log('Sending AJAX request...');
                console.log('Form data:', form.serialize());
            },
            success: function(response) {
                if (response.status === 'success') {
                    // Ẩn modal
                    $('#testDriveModal').removeClass('show').css('display', 'none');
                    $('body').removeClass('modal-open');
                    $('.modal-backdrop').remove();

                    // Reset form
                    form[0].reset();

                    // Hiển thị modal thông báo thành công
                    showSuccessModal(response.title || 'Thành công!', response.message);
                } else {
                    // Hiển thị thông báo lỗi
                    showErrorAlert(response.title || 'Lỗi!', response.message);
                }
            },
            error: function() {
                showErrorAlert('Lỗi kết nối!', 'Không thể kết nối đến server, vui lòng kiểm tra kết nối mạng và thử lại!');
            },
            complete: function() {
                // Enable button
                submitBtn.prop('disabled', false).html('<i class="bx bx-check me-1"></i>Đăng ký lái thử');
            }
        });
    });

    // Xử lý đóng modal - Simple
    $(document).on('click', '[data-bs-dismiss="modal"], .close-modal-btn, .modal-backdrop', function(e) {
        if (e.target === this) {
            $('#testDriveModal').removeClass('show').css('display', 'none');
            $('body').removeClass('modal-open');
            $('.modal-backdrop').remove();

            // Reset form
            $('#testDriveForm')[0].reset();
            $('#testDriveForm').find('.is-invalid').removeClass('is-invalid');
            $('#testDriveForm').find('.invalid-feedback').text('');
        }
    });

    // Reset form khi đóng modal
    $('#testDriveModal').on('hidden.bs.modal', function() {
        $('#testDriveForm')[0].reset();
        $('#testDriveForm').find('.is-invalid').removeClass('is-invalid');
        $('#testDriveForm').find('.invalid-feedback').text('');
    });

    // Fallback cho việc reset form
    $(document).on('click', '.modal-backdrop, [data-bs-dismiss="modal"]', function() {
        setTimeout(function() {
            $('#testDriveForm')[0].reset();
            $('#testDriveForm').find('.is-invalid').removeClass('is-invalid');
            $('#testDriveForm').find('.invalid-feedback').text('');
        }, 300);
    });
});
</script>

<style>
/* Modal fallback styles */
.modal {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1050;
    width: 100%;
    height: 100%;
    overflow: hidden;
    outline: 0;
}

.modal.show {
    display: block !important;
}

.modal-backdrop {
    position: fixed;
    top: 0;
    left: 0;
    z-index: 1040;
    width: 100vw;
    height: 100vh;
    background-color: #000;
    opacity: 0.5;
}

.modal-dialog {
    position: relative;
    width: auto;
    pointer-events: none;
}

.modal.show .modal-dialog {
    transform: none;
}

.modal-content {
    position: relative;
    display: flex;
    flex-direction: column;
    width: 100%;
    pointer-events: auto;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid rgba(0,0,0,.2);
    border-radius: 0.3rem;
    outline: 0;
}

/* Close button styles */
.btn-close, .close-modal-btn {
    cursor: pointer;
}

.btn-close span {
    font-size: 1.5rem;
    font-weight: bold;
    color: #fff;
}

/* Debug styles */
.test-drive-btn {
    position: relative;
}

.test-drive-btn:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

/* Ensure modal is above everything */
#testDriveModal {
    z-index: 9999 !important;
}

#testDriveModal .modal-dialog {
    margin: 30px auto;
}

/* Animation fallback */
.modal.fade .modal-dialog {
    transition: transform 0.3s ease-out;
    transform: translate(0, -50px);
}

.modal.show .modal-dialog {
    transform: translate(0, 0);
}

/* Success Modal Styles */
#successModal .modal-content {
    animation: successModalIn 0.3s ease-out;
    border-radius: 15px;
    border: none;
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
}

#successModal .modal-header {
    background: linear-gradient(135deg, #28a745, #20c997) !important;
    border-radius: 15px 15px 0 0;
}

#successModal .bx-check-circle {
    animation: successIcon 0.6s ease-out;
}

@keyframes successModalIn {
    from {
        opacity: 0;
        transform: scale(0.8) translateY(-50px);
    }
    to {
        opacity: 1;
        transform: scale(1) translateY(0);
    }
}

@keyframes successIcon {
    0% {
        opacity: 0;
        transform: scale(0);
    }
    50% {
        opacity: 1;
        transform: scale(1.2);
    }
    100% {
        opacity: 1;
        transform: scale(1);
    }
}

/* Alert Styles */
.alert {
    border-radius: 10px;
    border: none;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    animation: slideInRight 0.3s ease-out;
}

.alert-success {
    background: linear-gradient(135deg, #d4edda, #c3e6cb);
    color: #155724;
    border-left: 4px solid #28a745;
}

.alert-danger {
    background: linear-gradient(135deg, #f8d7da, #f5c6cb);
    color: #721c24;
    border-left: 4px solid #dc3545;
}

@keyframes slideInRight {
    from {
        opacity: 0;
        transform: translateX(100%);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}
</style>
<script>
function calculateInstallment() {
    const carPrice = parseFloat(document.getElementById("carPriceNumber").value);
    const downPaymentPercent = parseFloat(document.getElementById("downPaymentPercent").value);
    const loanTermYears = parseFloat(document.getElementById("loanTerm").value);
    const interestRate = parseFloat(document.getElementById("interestRate").value);

    if (!carPrice || carPrice <= 0) {
        alert("Vui lòng nhập giá xe hợp lệ");
        return;
    }

    // Tính toán
    const downPaymentAmount = carPrice * (downPaymentPercent / 100);
    const loanAmount = carPrice - downPaymentAmount;
    const monthlyInterestRate = interestRate / 100 / 12;
    const loanTermMonths = loanTermYears * 12;

    // Công thức tính trả góp hàng tháng
    const monthlyPayment = loanAmount * (monthlyInterestRate * Math.pow(1 + monthlyInterestRate, loanTermMonths)) / (Math.pow(1 + monthlyInterestRate, loanTermMonths) - 1);

    const totalPayment = downPaymentAmount + (monthlyPayment * loanTermMonths);
    const totalInterest = totalPayment - carPrice;

    // Hiển thị kết quả
    document.getElementById("downPaymentAmount").textContent = formatCurrency(downPaymentAmount);
    document.getElementById("loanAmount").textContent = formatCurrency(loanAmount);
    document.getElementById("monthlyPayment").textContent = formatCurrency(monthlyPayment);
    document.getElementById("totalPayment").textContent = formatCurrency(totalPayment);
    document.getElementById("totalInterest").textContent = formatCurrency(totalInterest);
}

function formatCurrency(amount) {
    return new Intl.NumberFormat("vi-VN", {
        style: "currency",
        currency: "VND",
        minimumFractionDigits: 0
    }).format(amount);
}

// Tự động tính toán khi trang load
document.addEventListener("DOMContentLoaded", function() {
    if (document.getElementById("installmentCalculator")) {
        calculateInstallment();
    }
});
</script>
<!-- END: main -->

