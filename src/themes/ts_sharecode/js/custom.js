$(document).ready(function() {
    // Init AOS
    $(window).on('load', function() {
        AOS.init({
            duration: 1000,
            once: true
        });
    });

    $("#search-input, .filter-select").select2();

    window.addEventListener("scroll", function() {
        if (window.innerWidth <= 768) {
            if (window.scrollY > 200) {
                $("#header").addClass('scroll-fixed')
            } else {
                $("#header").removeClass("scroll-fixed");
            }
        } else {
            // Nếu là desktop thì luôn bỏ class (phòng trường hợp resize từ mobile sang)
            $("#header").removeClass("scroll-fixed");
        }
    });
  
    // $(window).scroll(function () {
    //     if ($(this).scrollTop() > 100) {
    //         $('.scrollToTop').fadeIn();
    //     } else {
    //         $('.scrollToTop').fadeOut();
    //     }
    // });

    // Click event to scroll to top
    // $('.scrollToTop').click(function (e) {
    //     e.preventDefault();
    //     $('html, body').animate({ scrollTop: 0 }, 800);
    //     return false;
    // });

    // // Đóng mở footer menu ở dạng mobile
    // $('.showFooterMenu').on("click", function(e) {
    //     e.preventDefault();
    //     $('.footer-menu .ftm').toggleClass("open");
    // });

    // // Đóng mở menu left
    // $('.menu-left .Left_sub').on("click", function(e) {
    //     e.preventDefault();
    //     $(this).parent().find(">ul").slideToggle(200);
    // });

    $('.link-search').on('click', function(e) {
        e.preventDefault();
        $('#search-container').slideToggle(300);
        $('#search-input').focus();
    });

    $('#search-close').on('click', function(e) {
        e.preventDefault();
        $('#search-container').slideUp(300);
    });

    // Handle car selection in header search
    $('#search-input').on('change', function() {
        var carId = $(this).val();
        if (carId) {
            // Check if we have the required variables
            if (typeof nv_base_siteurl !== 'undefined' && typeof nv_lang_variable !== 'undefined' &&
                typeof nv_lang_data !== 'undefined' && typeof nv_name_variable !== 'undefined' &&
                typeof nv_fc_variable !== 'undefined') {
                // Redirect to car detail page
                var carDetailUrl = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=car-interface&' + nv_fc_variable + '=detail&id=' + carId;
                window.location.href = carDetailUrl;
            } else {
                // Fallback URL construction
                var baseUrl = window.location.origin + window.location.pathname.replace(/\/[^\/]*$/, '/');
                var carDetailUrl = baseUrl + 'index.php?language=vi&nv=car-interface&op=detail&id=' + carId;
                window.location.href = carDetailUrl;
            }
        }
    });

    // Close search when clicking outside
    $(document).on('click', function(e) {
        if (!$(e.target).closest('#search-container, .link-search').length) {
            $('#search-container').slideUp(300);
        }
    });

    // Alternative search functionality using vanilla JavaScript
    document.addEventListener('click', function(e) {
        if (e.target.closest('.link-search')) {
            e.preventDefault();
            console.log('Search clicked (vanilla JS)');
            var searchContainer = document.getElementById('search-container');
            if (searchContainer) {
                if (searchContainer.style.display === 'none' || searchContainer.style.display === '') {
                    searchContainer.style.display = 'block';
                } else {
                    searchContainer.style.display = 'none';
                }
            }
        }

        if (e.target.closest('#search-close')) {
            e.preventDefault();
            console.log('Close clicked (vanilla JS)');
            var searchContainer = document.getElementById('search-container');
            if (searchContainer) {
                searchContainer.style.display = 'none';
            }
        }
    });

    // Sticky menu
    // var timercheckMenuSticky;

    // function checkMenuSticky() {
    //     var scroll = $(window).scrollTop();
    //     if (scroll> $('#header').height()) {
    //         $("#menusite").addClass("sticky");
    //         $(".son-body-bg > .son-wraper > section").css({
    //             "padding-top": $("#menusite").height() + "px"
    //         });
    //     } else {
    //         $("#menusite").removeClass("sticky");
    //         $(".son-body-bg > .son-wraper > section").css({
    //             "padding-top": "0px"
    //         });
    //     }
    // }

    // $(window).on('resize', function(e) {
    //     if (timercheckMenuSticky) {
    //         clearTimeout(timercheckMenuSticky);
    //     }
    //     timercheckMenuSticky = setTimeout(function() {
    //         checkMenuSticky();
    //     }, 100);
    // });

    // $(window).on('scroll', function(e) {
    //     checkMenuSticky();
    // });

    // checkMenuSticky();'
});
