<section id="car-showcase" class="car-showcase">
    <div class="container aos-init" data-aos="fade-up">
        <div class="section-title-car">
            <p class="text-center">
                <img src="{$LOGO_SRC}" alt="Logo" style="max-height: 60px;">
            </p>
            <h2 class="section-title-car-h2"><strong>{$DATA.title_new|default:"Chọn an toàn - chọn vững vàng êm ái!"}</strong></h2>
            <p>{$DATA.description|default:"Khám phá bộ sưu tập xe Mercedes-Benz cao cấp"}</p>
        </div>

        {if $CARS_DATA && count($CARS_DATA) > 0}
        <div class="row">
            {foreach from=$CARS_DATA item=car key=index}
            <div class="col-lg-3 col-md-6 mb-4" bis_skin_checked="1">
                <div class="news-item" bis_skin_checked="1">
                    <div class="news-img" bis_skin_checked="1">
                        <img src="{$car.image}" class="img-fluid" alt="{$car.name}">
                    </div>
                    <div class="news-content" bis_skin_checked="1">
                        <h3 class="news-content-title"><a href="{$car.detail_url}">{$car.name}</a></h3>
                        <div class="car-price text-center">{$car.price_formatted}</div>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>

        <div class="text-center mt-4">
            <a href="/category" class="btn car-showcase-btn btn--social">
                <i class="bx bx-car"></i> Xem thêm xe Mercedes-Benz
            </a>
        </div>
        {else}
        <div class="alert alert-info text-center">
            <h4>Thông báo</h4>
            <p>Hiện tại chưa có xe nào để hiển thị.</p>
            <p><small>Vui lòng vào phần quản trị block để cấu hình danh sách xe.</small></p>
        </div>
        {/if}
    </div>
</section>
<style>
    .section-title-car {
        text-align: center;
        text-transform: uppercase;
    }


    #car-showcase .news-content h3 {
        margin-bottom: 10px;
        display: -webkit-box;
        -webkit-line-clamp: 2; /* Giới hạn tối đa 2 dòng */
        line-clamp: 2; /* Thuộc tính chuẩn */
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    #car-showcase .news-content h3 a {
        color: #2c3e50;
        text-decoration: none;
        transition: color 0.3s ease;
        display: block;
        height: 100%;
        font-family: "MBCorpo Title", "DaimlerCAC-Regular", "DaimlerCACArab-Regular", serif;
        font-weight: 600 !important;
        text-align: center;
        font-size: 19px;;
    }

    #car-showcase .car-price  {
        font-family: "MBCorpo Title", "DaimlerCAC-Regular", "DaimlerCACArab-Regular", serif;
        font-weight: 600 !important;
        text-align: center;
        color: red;
    }

    #car-showcase .news-content {
        padding: 7px 0px;
    }

    #car-showcase .news-content h3 a:hover {
        color: #007bff;
        text-decoration: none;
    }

    .car-showcase-btn {
        transition: all 0.3s;
        animation: pulse-zoom 2s infinite;
        background: linear-gradient(135deg, var(--bg-primary), #083a6b) !important;
        border: none !important;
        padding: 15px 30px;
        font-size: 1.1rem;
        font-weight: 600;
        border-radius: 50px;
    }

    #car-showcase .news-item {
        border: 1px solid #dedede;
        margin-bottom: 14px;
        padding: 10px;
    }

    /* Responsive cho mobile */
    @media (max-width: 768px) {
        #car-showcase .news-content h3 {
            font-size: 14px;
        }

        .section-title-car-h2 {
            font-size: 22px;
        }

        .section-title-car p {
            font-size: 12px;
        }

         #car-showcase {
            padding: 20px 0px;
        }

        #car-showcase .news-content h3 a {
            font-size: 21px;
        }
    }
</style>
