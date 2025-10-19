<!-- BEGIN: main -->
<section class="sharecode-latest-section">
    <div class="container">
        <div class="section-header text-center" data-aos="fade-down" data-aos-once="true">
            <h2 class="section-title">{BLOCK_TITLE}</h2>
            <p class="section-description">{BLOCK_DESCRIPTION}</p>
        </div>

        <div class="products-grid">
            <!-- BEGIN: product -->
            <article class="product-card" data-aos="fade-up" data-aos-once="true" data-aos-delay="{PRODUCT.aos_delay}">
                <a class="product-image" href="{PRODUCT.detail_url}" title="{PRODUCT.title}">
                    <div class="image-wrapper">
                        <img src="{PRODUCT.image}" alt="{PRODUCT.title}" loading="lazy" />
                    </div>
                </a>
                <div class="product-content">
                    <a class="product-title" href="{PRODUCT.detail_url}" title="{PRODUCT.title}">{PRODUCT.title}</a>
                    <p class="product-description">{PRODUCT.description_short}</p>
                    <div class="product-price">
                        <!-- BEGIN: free_badge -->
                        <span class="price-badge badge-free">{PRODUCT.price_text}</span>
                        <!-- END: free_badge -->
                        <!-- BEGIN: paid_badge -->
                        <span class="price-badge badge-paid">{PRODUCT.price_text}</span>
                        <!-- END: paid_badge -->
                        <!-- BEGIN: contact_badge -->
                        <span class="price-badge badge-contact">{PRODUCT.price_text}</span>
                        <!-- END: contact_badge -->
                    </div>
                    <div class="product-stats">
                        <span class="stat-item">
                            <i class="fa fa-eye"></i>
                            {PRODUCT.num_view}
                        </span>
                        <span class="stat-item">
                            <i class="fa fa-download"></i>
                            {PRODUCT.num_download}
                        </span>
                        <span class="stat-item">
                            <i class="fa fa-star"></i>
                            {PRODUCT.avg_rating}
                        </span>
                    </div>
                </div>
            </article>
            <!-- END: product -->
        </div>
    </div>
</section>

<style>
.sharecode-latest-section {
    padding: 60px 0;
    background-color: #ffffff;
    position: relative;
}

.sharecode-latest-section::before {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(circle at top right, rgba(0, 184, 148, 0.07), transparent 55%);
    z-index: 0;
}

.sharecode-latest-section .container {
    position: relative;
    z-index: 1;
}

.section-header {
    max-width: 760px;
    margin: 0 auto 40px auto;
}

.section-title {
    font-size: 32px;
    font-weight: 700;
    color: #00b894;
    text-transform: uppercase;
    display: inline-block;
    position: relative;
    margin-bottom: 15px;
    letter-spacing: 1px;
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
    margin: 0 auto;
    font-size: 16px;
    color: #636e72;
    line-height: 1.7;
}

.products-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
}

.product-card {
    background: #ffffff;
    border-radius: 18px;
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.08);
    overflow: hidden;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    border: 1px solid rgba(0, 184, 148, 0.08);
}

.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 28px 60px rgba(0, 0, 0, 0.12);
    border-color: #00b894;
}

.product-image {
    display: block;
    overflow: hidden;
    border-bottom: 1px solid rgba(99, 110, 114, 0.08);
}

.image-wrapper {
    position: relative;
    padding-top: 62%;
    overflow: hidden;
}

.image-wrapper img {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease;
}

.product-card:hover .image-wrapper img {
    transform: scale(1.05);
}

.product-content {
    padding: 22px 24px 26px 24px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.product-title {
    font-size: 20px;
    font-weight: 700;
    line-height: 1.4;
    color: #2d3436;
    text-decoration: none;
    display: block;
    margin-bottom: 14px;
    transition: color 0.2s ease;
}

.product-card:hover .product-title {
    color: #00b894;
}

.product-description {
    font-size: 15px;
    color: #636e72;
    margin-bottom: 18px;
    line-height: 1.6;
    flex-grow: 1;
}

.product-price {
    margin-bottom: 18px;
}

.price-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    font-size: 14px;
    padding: 6px 16px;
    border-radius: 999px;
    border: 1px solid transparent;
    text-transform: uppercase;
    letter-spacing: 0.6px;
}

.price-badge.badge-free {
    color: #00b894;
    background: rgba(0, 184, 148, 0.12);
    border-color: rgba(0, 184, 148, 0.45);
}

.price-badge.badge-paid {
    color: #ff9800;
    background: rgba(255, 152, 0, 0.12);
    border-color: rgba(255, 152, 0, 0.45);
}

.price-badge.badge-contact {
    color: #2196f3;
    background: rgba(33, 150, 243, 0.12);
    border-color: rgba(33, 150, 243, 0.45);
}

.product-stats {
    display: flex;
    align-items: center;
    gap: 16px;
    color: #2d3436;
    font-size: 14px;
    flex-wrap: wrap;
}

.stat-item {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    color: #2d3436;
}

.stat-item i {
    color: #00b894;
}

@media (max-width: 1199px) {
    .products-grid {
        gap: 24px;
    }
}

@media (max-width: 991px) {
    .products-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
    }

    .section-title {
        font-size: 28px;
    }
}

@media (max-width: 767px) {
    .sharecode-latest-section {
        padding: 45px 0;
    }

    .section-title {
        font-size: 24px;
    }

    .section-description {
        font-size: 14px;
    }
}

@media (max-width: 575px) {
    .products-grid {
        grid-template-columns: 1fr;
        gap: 20px;
    }

    .product-content {
        padding: 20px;
    }

    .product-title {
        font-size: 18px;
    }
}
</style>
<!-- END: main -->
