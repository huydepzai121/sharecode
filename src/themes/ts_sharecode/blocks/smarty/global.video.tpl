<div class="hp-stage-media__ratio">
    <video id="myVideo" autoplay loop muted playsinline webkit-playsinline>
        {* Cung cấp nhiều định dạng video cho tương thích tối đa *}
        {* Thử WebM trước (chất lượng tốt, dung lượng nhỏ) *}
        {assign var="webm_video" value=$URL_VIDEO|replace:'.mp4':'.webm'}
        <source src="{$webm_video}" type="video/webm">

        {* MP4 cho Safari và iOS *}
        {assign var="mp4_video" value=$URL_VIDEO|replace:'.webm':'.mp4'}
        <source src="{$mp4_video}" type="video/mp4">

        {* Fallback - video gốc *}
        <source src="{$URL_VIDEO}">

        {* Fallback message *}
        <p>Trình duyệt của bạn không hỗ trợ video HTML5.
           <a href="{$URL_VIDEO}" target="_blank">Tải video về để xem</a>
        </p>
    </video>
</div>

<div class="content-video">
    <h1 class="position-relative title_h1_video" data-aos="zoom-in" data-aos-delay="100" data-aos-duration="1000"><strong>Chào mừng bạn đến với Mercedes-Benz Haxaco Láng Hạ</strong></h1>
    <p class="position-relative title-des-video" data-aos="fade-up" data-aos-delay="300" data-aos-duration="1000">Một trong những nhà phân phối chính hãng đầu tiên của Mercedes-Benz Việt Nam.</p>
    <div class="btn-hero-group">
        <a href="/contact" class="btn-hero btn-hero-contact" data-aos="fade-in" data-aos-delay="800">
            <i class="fa fa-phone"></i>Liên hệ
        </a>
        <a href="/category" class="btn-hero btn--social btn-hero-search" data-aos="fade-in" data-aos-delay="1000">
            <i class="fa fa-car"></i>Tìm xe có sẵn
        </a>
    </div>
</div>

<nav class="hp-brand-switcher__brands hp-brand-switcher--overlapping-half">
    <ul>
        <li class="selected">
            <a href="{$SITE_URL}/category/?car_type=1" target="_self">
                <img class="hp-brand-switcher__brands--benz"
                        src="/uploads/mercedes-benz.svg"
                        title="Mercedes-Benz logo"
                        alt="Mercedes-Benz logo">
            </a>
        </li>
        <li class="">
            <a href="{$SITE_URL}/category/?car_type=2" target="_self">
                <img class="hp-brand-switcher__brands--amg"
                        src="/uploads/amg.svg"
                        title="Mercedes-AMG logo"
                        alt="Mercedes-AMG logo">
            </a>
        </li>

        <li class="">
            <a href="{$SITE_URL}/category/?car_type=3" target="_self">
                <img class="hp-brand-switcher__brands--maybach"
                        src="/uploads/mercedes-eq.svg" style="height: 27px;"
                        title="Mercedes-EQ logo"
                        alt="Mercedes-EQ logo">
            </a>
        </li>

        <li class="">
            <a href="{$SITE_URL}/category/?car_type=4" target="_self">
                <img class="hp-brand-switcher__brands--maybach"
                        src="/uploads/maybach.svg"
                        title="Mercedes-Maybach logo"
                        alt="Mercedes-Maybach logo">
            </a>
        </li>
    </ul>
</nav>

<style>
    .title_h1_video {
        font-family: "MBCorpo Title", "DaimlerCAC-Regular", "DaimlerCACArab-Regular", serif;
    }

    /* CSS cho video tương thích iOS */
    #myVideo {
        width: 100%;
        height: 100%;
        object-fit: cover;
        /* Đảm bảo video không bị zoom trên iOS */
        -webkit-transform: translateZ(0);
        transform: translateZ(0);
    }

    /* CSS cho Brand Switcher */
    .hp-brand-switcher__brands {
        position: absolute;
        bottom: -11px;
        left: 50%;
        transform: translateX(-50%);
        z-index: 10;
        background: #fff;
        padding: 4px;
        box-shadow: 0px 5px 10px rgb(58 58 58 / 60%);
    }

    .hp-brand-switcher__brands ul {
        display: flex;
        align-items: center;
/*        justify-content: center;*/
        border-radius: 8px;
        padding: 0;
        margin: 0;
        list-style: none;
        /* box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3); */
    }

    .hp-brand-switcher__brands li {
        margin: 0;
        padding: 0;
/*        border-right: 1px solid rgba(255, 255, 255, 0.2);*/
        border: 1px solid #5e5e5e;
    }

    .hp-brand-switcher__brands li.selected {
        background: #000;
    }

    .hp-brand-switcher__brands li:last-child {
/*        border-right: none;*/
    }

    .hp-brand-switcher__brands li:nth-child(3) a {
        padding-right: 0 !important;
    }

    .hp-brand-switcher__brands li a {
        display: block;
        padding: 20px 35px;
        transition: all 0.3s ease;
        text-decoration: none;
    }

    .hp-brand-switcher__brands img {
        height: 12px;
        width: auto;
        transition: all 0.3s ease;
        
    }

    .hp-brand-switcher__brands li:hover img {
        /* filter: brightness(0) invert(1); */
        transform: scale(1.05);
    }

    .hp-brand-switcher__brands li.selected img {
        filter: brightness(0) invert(1);
    }

    #header_about {
        margin-bottom: 40px;  
    }

    /* Responsive cho mobile */
    @media (max-width: 768px) {
        .hp-stage-media__ratio {
            position: relative;
            overflow: hidden;
        }

        #myVideo {
            /* Tối ưu performance trên mobile */
            will-change: transform;
            /* Đảm bảo video responsive */
            max-width: 100%;
        }

        /* Brand switcher responsive */
        .hp-brand-switcher__brands {
            bottom: 15px;
        }

        .hp-brand-switcher__brands ul {
            border-radius: 6px;
            flex-wrap: nowrap;
            overflow-x: scroll;
            scrollbar-width: none;
            -ms-overflow-style: none;
        }

        .hp-brand-switcher__brands ul::-webkit-scrollbar {
            display: none;
        }

        .hp-brand-switcher__brands li a {
            padding: 12px 9px;
            white-space: nowrap;
        }

        .hp-brand-switcher__brands img {
            height: 20px;
        }

        .title-des-video {
            font-size: 16px;
        }
    }

    @media (max-width: 480px) {
        .hp-brand-switcher__brands {
            bottom: -36px;
            left: 10px;
            right: 10px;
            transform: none;
            width: calc(100% - 20px);
        }

        .hp-brand-switcher__brands li a {
            padding: 12px 20px;
        }

        .hp-brand-switcher__brands img {
            height: 10px;
        }
    }

    /* Fix cho Safari iOS */
    @supports (-webkit-appearance: none) {
        #myVideo::-webkit-media-controls {
            display: none !important;
        }

        #myVideo::-webkit-media-controls-enclosure {
            display: none !important;
        }
    }
    </style>

    <script>
    // JavaScript để xử lý video trên iOS
    document.addEventListener('DOMContentLoaded', function() {
        var video = document.getElementById('myVideo');

        if (video) {
            // Kiểm tra nếu là iOS
            var isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;

            if (isIOS) {
                // Đảm bảo video có thể autoplay trên iOS (cần muted)
                video.muted = true;
                video.playsInline = true;

                // Thử play video sau khi load
                video.addEventListener('loadeddata', function() {
                    var playPromise = video.play();

                    if (playPromise !== undefined) {
                        playPromise.then(function() {
                            console.log('Video autoplay thành công trên iOS');
                        }).catch(function(error) {
                            console.log('Video autoplay bị chặn trên iOS:', error);
                            // Hiển thị nút play thủ công nếu cần
                            showPlayButton();
                        });
                    }
                });
            }

            // Xử lý lỗi video
            video.addEventListener('error', function(e) {
                console.error('Lỗi video:', e);
                showVideoError();
            });
        }
    });

    // Hiển thị nút play thủ công
    function showPlayButton() {
        var video = document.getElementById('myVideo');
        var container = video.parentElement;

        var playBtn = document.createElement('button');
        playBtn.innerHTML = '<i class="fa fa-play"></i> Phát video';
        playBtn.className = 'video-play-btn';
        playBtn.style.cssText = `
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(0,0,0,0.7);
            color: white;
            border: none;
            padding: 15px 25px;
            border-radius: 50px;
            font-size: 16px;
            cursor: pointer;
            z-index: 10;
        `;

        playBtn.onclick = function() {
            video.play();
            playBtn.remove();
        };

        container.style.position = 'relative';
        container.appendChild(playBtn);
    }

    // Hiển thị thông báo lỗi video
    function showVideoError() {
        var video = document.getElementById('myVideo');
        var container = video.parentElement;

        var errorMsg = document.createElement('div');
        errorMsg.innerHTML = `
            <div style="
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: rgba(0,0,0,0.8);
                color: white;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                z-index: 10;
            ">
                <i class="fa fa-exclamation-triangle" style="font-size: 24px; margin-bottom: 10px;"></i><br>
                Video không thể tải. Vui lòng thử lại sau.
            </div>
        `;

        container.style.position = 'relative';
        container.appendChild(errorMsg);
    }
</script>
