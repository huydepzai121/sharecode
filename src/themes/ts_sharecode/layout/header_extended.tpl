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

    <div id="search-container" class="search-container" style="display: none; background: rgba(0, 0, 0, 0.9); position: fixed; top: 0; left: 0; right: 0; bottom: 0; width: 100%; height: 100%; z-index: 9999; padding: 100px 20px 20px 20px;">
        <div class="search-box" style="position: relative; max-width: 600px; margin: 0 auto;">
            <div class="search-input-wrapper" style="position: relative; display: flex; align-items: center;">
                <select id="search-input" class="search-input form-control" autocomplete="off">
                    <option value="">-- Vui lòng chọn sản phẩm ShareCode --</option>
                    {SEARCH_SHARECODE_LIST}
                </select>
            </div>
            <div id="search-results" class="search-results"></div>
        </div>
    </div>

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
    
