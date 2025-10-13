{if $HANDOVER_DATA && count($HANDOVER_DATA) > 0}
<section id="vehicle-handover" class="vehicle-handover">
    <div class="container aos-init" data-aos="fade-up">
        <div class="section-title-handover">
            <p class="text-center">
                <img src="{$LOGO_SRC}" alt="Logo">
            </p>
            <h2 class="mt-2">Bàn giao xe mới nhất</h2>
            <p>Những khoảnh khắc đáng nhớ khi khách hàng nhận xe Mercedes-Benz</p>
        </div>

        <div class="row">
            {foreach from=$HANDOVER_DATA item=handover key=index}
            <div class="col-lg-4 col-md-6 d-flex align-items-stretch mb-4">
                <div class="handover-item">
                    <div class="handover-img">
                        <img src="{$handover.display_image}" class="img-fluid" alt="{$handover.title}">
                        {if $DATA.show_views && $handover.views > 0}
                        <div class="handover-views">
                            <i class="bx bx-show"></i> {$handover.views_formatted}
                        </div>
                        {/if}
                    </div>
                    <div class="handover-content">
                        <h3><a href="{$handover.detail_url}">{$handover.title}</a></h3>
                        
                        {if $DATA.show_description && $handover.description_short}
                        <p class="handover-description">{$handover.description_short}</p>
                        {/if}
                        
                        {if $DATA.show_handover_time}
                        <div class="handover-time">
                            <i class="bx bx-calendar"></i> 
                            <span>Thời gian lấy xe: {$handover.handover_time_formatted}</span>
                        </div>
                        {/if}
                        
                        <div class="handover-footer">
                            <a href="{$handover.detail_url}" class="btn-view-more">Xem chi tiết <i class="bx bx-right-arrow-alt"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
        
        <div class="text-center mt-4">
            <a href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}=car-interface&{$smarty.const.NV_OP_VARIABLE}=vehicle-handover" class="btn btn-primary btn-lg btn--social"">
                Xem tất cả bàn giao xe <i class="bx bx-right-arrow-alt"></i>
            </a>
        </div>
    </div>
</section>

<style>
.vehicle-handover {
    padding-top: 0 !important;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

.section-title-handover {
    text-align: center;
    margin-bottom: 60px;
}

.section-title-handover img {
    height: 60px;
    margin-bottom: 20px;
}

.section-title-handover h2 {
    font-size: 2.5rem;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 15px;
}

.section-title-handover p {
    font-size: 1.1rem;
    color: #6c757d;
    max-width: 600px;
    margin: 0 auto;
}

.handover-item {
    background: #fff;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.handover-item:hover {
    transform: translateY(-10px);
    box-shadow: 0 20px 40px rgba(0,0,0,0.15);
}

.handover-img {
    position: relative;
    overflow: hidden;
    height: 250px;
}

.handover-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.handover-item:hover .handover-img img {
    transform: scale(1.05);
}

.handover-date {
    position: absolute;
    top: 15px;
    left: 15px;
    background: rgba(0,0,0,0.8);
    color: white;
    padding: 8px 12px;
    border-radius: 8px;
    text-align: center;
    font-size: 0.85rem;
}

.date-day {
    font-weight: 600;
    margin-bottom: 2px;
}

.date-time {
    font-size: 0.75rem;
    opacity: 0.9;
}

.handover-views {
    position: absolute;
    top: 15px;
    right: 15px;
    background: rgba(255,255,255,0.9);
    color: #333;
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 500;
}

.handover-content {
    padding: 25px;
    flex: 1;
    display: flex;
    flex-direction: column;
}

.handover-content h3 {
    font-size: 1.3rem;
    font-weight: 600;
    margin-bottom: 15px;
    line-height: 1.4;
}

.handover-content h3 a {
    color: #2c3e50;
    text-decoration: none;
    transition: color 0.3s ease;
}

.handover-content h3 a:hover {
    color: #007bff;
}

.handover-description {
    color: #6c757d;
    font-size: 0.95rem;
    line-height: 1.6;
    margin-bottom: 15px;
    flex: 1;
}

.handover-time {
    color: #495057;
    font-size: 0.9rem;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.handover-time i {
    color: #007bff;
    font-size: 1.1rem;
}

.handover-footer {
    margin-top: auto;
}

.btn-view-more {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    color: #007bff;
    text-decoration: none;
    font-weight: 500;
    font-size: 0.95rem;
    transition: all 0.3s ease;
}

.btn-view-more:hover {
    color: #0056b3;
    text-decoration: none;
    gap: 12px;
}

.btn-view-more i {
    transition: transform 0.3s ease;
}

.btn-view-more:hover i {
    transform: translateX(3px);
}

@media (max-width: 768px) {
    .vehicle-handover {
        padding: 60px 0;
    }
    
    .section-title-handover h2 {
        font-size: 2rem;
    }
    
    .handover-img {
        height: 200px;
    }
    
    .handover-content {
        padding: 20px;
    }
}
</style>

{else}
{* Debug: Hiển thị thông báo nếu không có dữ liệu *}
<section id="vehicle-handover-debug" class="vehicle-handover">
    <div class="container">
        <div class="alert alert-info text-center">
            <h4>Thông báo</h4>
            <p>Hiện tại chưa có thông tin bàn giao xe nào để hiển thị.</p>
            <p><small>Vui lòng vào phần quản trị để thêm thông tin bàn giao xe.</small></p>
        </div>
    </div>
</section>
{/if}
