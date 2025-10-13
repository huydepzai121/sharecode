    <noscript>
        <div class="alert alert-danger">{LANG.nojs}</div>
    </noscript>
    <header id="header" class="fixed-top">
        <div class="container d-flex align-items-center">
            <span class="logo mr-auto">
                <a href="{THEME_SITE_HREF}" title="{SITE_NAME}">
                    <img alt="{SITE_NAME}" class="hp-header-ssr__logo-image" width="100" height="100" src="{LOGO_SRC}"> <span class="aos-init " data-aos="zoom-in-left" data-aos-delay="1000" data-aos-duration="1000"></span>
                </a>
            </span>

            <div class="menu">
                [MENU_SITE]
            </div>
            <a href="javascript:void(0)" class="get-started-btn link-search"><em class="fa fa-search fa-lg"></em></a>
       </div>
    </header>

    <div id="search-container" class="search-container" style="display: none; background: rgba(0, 0, 0, 0.9); position: fixed; top: 70px; left: 0; right: 0; z-index: 9999; padding: 20px 0; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);">
        <div class="search-box" style="position: relative; max-width: 600px; margin: 0 auto;">
            <div class="search-input-wrapper" style="position: relative; display: flex; align-items: center;">
                <select id="search-input" class="search-input form-control" autocomplete="off">
                    <option value="">-- Vui lòng chọn xe để tìm kiếm --</option>
                    {SEARCH_CARS_LIST}
                </select>
                <!-- <button type="button" class="search-close-btn" id="search-close" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); background: none; border: none; font-size: 20px; color: #666; cursor: pointer; padding: 5px;">
                    <em class="fa fa-times"></em>
                </button> -->
            </div>
            <div id="search-results" class="search-results"></div>
        </div>
    </div>

    <script>
    // Inline search functionality
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Search script loaded');

        // Search button click
        document.addEventListener('click', function(e) {
            if (e.target.closest('.link-search')) {
                e.preventDefault();
                console.log('Search button clicked');
                var searchContainer = document.getElementById('search-container');
                if (searchContainer) {
                    if (searchContainer.style.display === 'none' || searchContainer.style.display === '') {
                        searchContainer.style.display = 'block';
                        console.log('Search container shown');
                    } else {
                        searchContainer.style.display = 'none';
                        console.log('Search container hidden');
                    }
                } else {
                    console.log('Search container not found');
                }
            }

            if (e.target.closest('#search-close')) {
                e.preventDefault();
                console.log('Close button clicked');
                var searchContainer = document.getElementById('search-container');
                if (searchContainer) {
                    searchContainer.style.display = 'none';
                }
            }
        });

        // Car selection
        var searchInput = document.getElementById('search-input');
        if (searchInput) {
            searchInput.addEventListener('change', function() {
                var carId = this.value;
                console.log('Car selected:', carId);
                if (carId) {
                    // Redirect to car detail page
                    var baseUrl = window.location.origin + window.location.pathname.replace(/\/[^\/]*$/, '/');
                    var carDetailUrl = baseUrl + 'index.php?language=vi&nv=car-interface&op=detail&id=' + carId;
                    window.location.href = carDetailUrl;
                }
            });
        }
    });
    </script>

    <div id="header_about">
        [VIDEO_HEADER]
    </div>

    <div>
        [ABOUT]
    </div>
    
    <!-- BEGIN: currenttime --><span class="current-time hidden">{NV_CURRENTTIME}</span><!-- END: currenttime -->
    <!-- <div id="preloader"></div> -->
    <main id="main">
        [THEME_ERROR_INFO]
        <!-- BEGIN: breadcrumbs -->
        <section class="breadcrumb-section">
            <div class="container" bis_skin_checked="1">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
                        <li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a href="{THEME_SITE_HREF}" itemprop="item" title="{LANG.Home}"><span itemprop="name"><i class="fa fa-home" aria-hidden="true"></i> {LANG.Home}</span></a><i class="hidden" itemprop="position" content="1"></i></li>
                        <!-- BEGIN: loop --><li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem"><a href="{BREADCRUMBS.link}" itemprop="item" title="{BREADCRUMBS.title}"><span class="txt" itemprop="name">{BREADCRUMBS.title}</span></a><i class="hidden" itemprop="position" content="{BREADCRUMBS.position}"></i></li><!-- END: loop -->
                    </ol>
                </nav>
            </div>
        </section>
        <!-- END: breadcrumbs -->
    
