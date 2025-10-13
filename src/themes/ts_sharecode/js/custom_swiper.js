// Khởi tạo Swiper với error handling
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM loaded, checking for gallery elements...');

    // Kiểm tra xem có elements gallery không
    const galleryThumbsEl = document.querySelector('.gallery-thumbs');
    const galleryTopEl = document.querySelector('.gallery-top');

    console.log('Gallery thumbs element:', galleryThumbsEl);
    console.log('Gallery top element:', galleryTopEl);

    if (!galleryThumbsEl || !galleryTopEl) {
        console.log('Gallery elements not found, skipping Swiper initialization');
        return;
    }

    // Kiểm tra có slides không
    const thumbSlides = galleryThumbsEl.querySelectorAll('.swiper-slide');
    const topSlides = galleryTopEl.querySelectorAll('.swiper-slide');

    console.log('Thumb slides count:', thumbSlides.length);
    console.log('Top slides count:', topSlides.length);

    if (thumbSlides.length === 0 || topSlides.length === 0) {
        console.log('No slides found, skipping Swiper initialization');
        return;
    }

    try {
        // Khởi tạo gallery thumbnails
        var galleryThumbs = new Swiper('.gallery-thumbs', {
            spaceBetween: 10,
            slidesPerView: Math.min(6, thumbSlides.length),
            lazy: false,
            hashNavigation: true,
            watchSlidesVisibility: true,
            watchSlidesProgress: true,
            direction: 'horizontal',
            loop: false,
            loopAdditionalSlides: 0,
            initialSlide: 0,
            breakpoints: {
                300: {
                    slidesPerView: Math.min(3, thumbSlides.length),
                    spaceBetween: 8,
                },
                500: {
                    slidesPerView: Math.min(4, thumbSlides.length),
                    spaceBetween: 10,
                },
                640: {
                    slidesPerView: Math.min(4, thumbSlides.length),
                    spaceBetween: 10,
                },
                768: {
                    slidesPerView: Math.min(5, thumbSlides.length),
                    spaceBetween: 10,
                },
                1024: {
                    slidesPerView: Math.min(6, thumbSlides.length),
                    spaceBetween: 10,
                },
                1200: {
                    slidesPerView: Math.min(7, thumbSlides.length),
                    spaceBetween: 12,
                },
            },
        });

        console.log('Gallery thumbs initialized successfully');

        // Khởi tạo gallery chính
        var galleryTop = new Swiper('.gallery-top', {
            spaceBetween: 0,
            lazy: true,
            hashNavigation: true,
            loop: false,
            loopAdditionalSlides: 0,
            initialSlide: 0,
            effect: topSlides.length > 1 ? 'fade' : 'slide',
            fadeEffect: {
                crossFade: true
            },
            navigation: {
                nextEl: '.gallery-top .swiper-button-next',
                prevEl: '.gallery-top .swiper-button-prev',
            },
            pagination: {
                el: '.gallery-top .swiper-pagination',
                clickable: true,
                type: 'bullets',
            },
            thumbs: {
                swiper: galleryThumbs
            }
        });

        console.log('Gallery top initialized successfully');

        // Ẩn navigation nếu chỉ có 1 slide
        if (topSlides.length <= 1) {
            const nextBtn = document.querySelector('.gallery-top .swiper-button-next');
            const prevBtn = document.querySelector('.gallery-top .swiper-button-prev');
            if (nextBtn) nextBtn.style.display = 'none';
            if (prevBtn) prevBtn.style.display = 'none';
        }

    } catch (error) {
        console.error('Error initializing Swiper:', error);
    }

    // Khởi tạo lightGallery nếu có
    try {
        const lightGalleryEl = document.getElementById('lightgallery');
        if (lightGalleryEl && typeof $ !== 'undefined' && typeof $.fn.lightGallery !== 'undefined') {
            $("#lightgallery").lightGallery({
                thumbnail: false
            });
            console.log('LightGallery initialized successfully');
        }
    } catch (error) {
        console.error('Error initializing LightGallery:', error);
    }
});
