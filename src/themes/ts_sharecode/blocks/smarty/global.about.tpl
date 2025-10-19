<script>
    var owl = $('.owl-carousel');
    owl.owlCarousel({
        items:1,                // chỉ hiển thị 1 ảnh
        loop:true,
        margin:10,
        autoplay:true,
        autoplayTimeout:3000,   // 3 giây đổi ảnh
        autoplayHoverPause:true
    });
</script>
<style>
    .about .content ul li {
        padding-bottom: 0 !important;
    }
</style>

<section id="about" class="about">
    <div class="container aos-init" data-aos="fade-up">
        <div class="row">
            <div class="col-lg-6 order-1 order-lg-2 aos-init aos-animate" data-aos="fade-left" data-aos-delay="100">
    			<div class="owl-carousel owl-theme">
    				{if $IMAGES && count($IMAGES) > 0}
    					{foreach from=$IMAGES item=image key=index}
    						{if $image}
    						<div class="item">
    							<img src="{$image}" class="d-block w-100" alt="Ảnh {$index+1}">
    						</div>
    						{/if}
    					{/foreach}
    				{/if}

    				{* Fallback images nếu không có ảnh nào được config *}
    				{if !$IMAGES || count($IMAGES) == 0 || (count($IMAGES) > 0 && !$IMAGES[0] && !$IMAGES[1])}
    				<div class="item">
    					<img src="{$URL}/assets/img/Picture1.jpg" class="d-block w-100" alt="Ảnh mặc định 1">
    				</div>
    				<div class="item">
    					<img src="{$URL}/assets/img/dai-ly-mercedes-benz-haxaco-ha-noi-quan-dong-da-ha-noi-1-47852j-Copy.jpg" class="d-block w-100" alt="Ảnh mặc định 2">
    				</div>
    				<div class="item">
    					<img src="{$URL}/assets/img/hinh-mercedes-can-tho-2.jpg" class="d-block w-100" alt="Ảnh mặc định 3">
    				</div>
    				{/if}
    			</div>
            </div>
            <div class="col-lg-6 order-2 order-lg-1 content">
                {if $HTML_CONTENT}
                    {$HTML_CONTENT}
                {else}
                <h2>Giới thiệu về chúng tôi</h2>
                <p class="font-italic">
                   Mercedes-Benz Miền Bắc trực thuộc hệ thống phân phối của Nhà phân phối ủy quyền của Mercedes-Benz Việt Nam. Hãy liên hệ Hotline: 0929.319.666 để được báo giá và tư vấn mua xe ngay hôm nay
                </p>
                <ul>
                    <li><i class="icofont-check-circled"></i> Kinh doanh xe mới & xe đã qua sử dụng chính hãng.</li>
                    <li><i class="icofont-check-circled"></i> Kinh doanh phụ tùng chính hãng.</li>
                    <li><i class="icofont-check-circled"></i> Cung cấp dịch vụ hậu mãi chính hãng.</li>
                </ul>
                <p>
                   Năm 2022, Mercedes-Benz Haxaco Láng Hạ trở thành đại lý đầu tiên phân phối xe Mercedes-EQ, mở ra kỷ nguyên mới của xe điện hạng sang tại thị trường Việt Nam.
                </p>
                {/if}
            </div>
        </div>
    </div>
</section>
<style>
    #about h2 strong {
        font-weight: 600;
    }
</style>