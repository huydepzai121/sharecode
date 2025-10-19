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

    // Handle search button click
    $('.link-search').on('click', function(e) {
        e.preventDefault();
        console.log('Search button clicked');
        $('#search-container').slideToggle(300, function() {
            if ($(this).is(':visible')) {
                console.log('Search container shown');
                $('#search-input').select2('open');
            }
        });
    });

    // Handle close button click
    $('#search-close').on('click', function(e) {
        e.preventDefault();
        $('#search-container').slideUp(300);
    });

    // Handle ShareCode source selection in header search
    $('#search-input').on('change', function() {
        var sourceId = $(this).val();
        console.log('Source selected:', sourceId);
        if (sourceId) {
            // Check if we have the required NukeViet variables
            if (typeof nv_base_siteurl !== 'undefined' && typeof nv_lang_variable !== 'undefined' &&
                typeof nv_lang_data !== 'undefined' && typeof nv_name_variable !== 'undefined' &&
                typeof nv_fc_variable !== 'undefined') {
                // Redirect to ShareCode detail page using NukeViet variables
                var sourceDetailUrl = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=sharecode&' + nv_fc_variable + '=detail&id=' + sourceId;
                window.location.href = sourceDetailUrl;
            } else {
                // Fallback URL construction
                var baseUrl = window.location.origin + window.location.pathname.replace(/\/[^\/]*$/, '/');
                var sourceDetailUrl = baseUrl + 'index.php?language=vi&nv=sharecode&op=detail&id=' + sourceId;
                console.log('Redirecting to (fallback):', sourceDetailUrl);
                window.location.href = sourceDetailUrl;
            }
        }
    });

    // Close search when clicking outside the search box
    $('#search-container').on('click', function(e) {
        // Nếu click vào chính container (background đen) chứ không phải search-box
        if (e.target.id === 'search-container') {
            $(this).slideUp(300);
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
