{if $NEWS_DATA && count($NEWS_DATA) > 0}
<section id="top-news" class="top-news">
    <div class="container aos-init" data-aos="fade-up">
        <div class="section-title-topnew">
            <p class="text-center">
                <img src="{$LOGO_SRC}" alt="Logo">
            </p>
            <h2 class="mt-2">Tin tức nổi bật</h2>
            <p>Cập nhật những thông tin mới nhất về Mercedes-Benz</p>
        </div>

        <div class="row">
            {foreach from=$NEWS_DATA item=news key=index}
            <div class="col-lg-4 col-md-6 d-flex align-items-stretch mb-4">
                <div class="news-item">
                    <div class="news-img">
                        <img src="{$news.homeimgfile}" class="img-fluid" alt="{$news.homeimgalt|default:$news.title}">
                        <div class="news-date">
                            <span>{$news.publtime_formatted}</span>
                        </div>
                    </div>
                    <div class="news-content">
                        <h3><a href="{$news.detail_url}">{$news.title}</a></h3>
                        <p>{$news.hometext_short}</p>
                        <div class="news-footer">
                            <a href="{$news.detail_url}" class="btn-read-more">Đọc thêm <i class="bx bx-right-arrow-alt"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            {/foreach}
        </div>
    </div>
</section>

{else}
{* Debug: Hiển thị thông báo nếu không có tin tức *}
<section id="top-news-debug" class="top-news">
    <div class="container">
        <div class="alert alert-info text-center">
            <h4>Thông báo</h4>
            <p>Hiện tại chưa có bài viết tin tức nào được chọn để hiển thị.</p>
            <p><small>Vui lòng vào phần quản trị block để chọn các bài viết tin tức muốn hiển thị.</small></p>
        </div>
    </div>
</section>
{/if}