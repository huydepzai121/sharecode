<!-- BEGIN: main -->
<div id="nv-block-login" class="card border-0 shadow-sm">
    <div class="card-body text-center">
        <div class="mb-3">
            <i class="fa fa-user-circle fa-2x text-primary"></i>
        </div>
        <h6 class="card-title text-muted mb-3">Tài khoản</h6>
        <div class="d-grid gap-2">
            <!-- BEGIN: login_form -->
            <button type="button" class="btn btn-primary" data-toggle="loginForm">
                <i class="fa fa-sign-in-alt me-2"></i>{GLANG.signin}
            </button>
            <!-- END: login_form -->
            <!-- BEGIN: login_sso -->
            <a href="{LINK_LOGIN}" class="btn btn-primary">
                <i class="fa fa-sign-in-alt me-2"></i>{GLANG.signin}
            </a>
            <!-- END: login_sso -->
            <!-- BEGIN: allowuserreg -->
            <a href="{USER_REGISTER}" class="btn btn-outline-primary">
                <i class="fa fa-user-plus me-2"></i>{GLANG.register}
            </a>
            <!-- END: allowuserreg -->
        </div>
    </div>
</div>
<!-- END: main -->

<!-- BEGIN: signed -->
<div class="card border-0 shadow-sm">
    <div class="alert alert-success border-0 d-none" role="alert"></div>
    <div class="card-body">
        <!-- User Profile Header -->
        <div class="d-flex align-items-center mb-3">
            <a title="{LANG.edituser}" href="{URL_MODULE}" class="me-3">
                <img src="{AVATA}" alt="{USER.full_name}" class="img-thumbnail rounded-circle border-2 border-primary" width="50" height="50" style="object-fit: cover;" />
            </a>
            <div class="flex-grow-1">
                <div class="badge bg-primary bg-opacity-10 text-primary small mb-1 lev-{LEVEL}">{WELCOME}</div>
                <h6 class="mb-0 fw-bold text-dark">{USER.full_name}</h6>
            </div>
        </div>

        <!-- User Menu -->
        <div class="list-group list-group-flush mb-3">
            <a href="{URL_MODULE}" class="list-group-item list-group-item-action border-0 px-0 py-2">
                <i class="fa fa-user text-primary me-2"></i>{LANG.user_info}
            </a>
            <a href="{URL_HREF}editinfo" class="list-group-item list-group-item-action border-0 px-0 py-2">
                <i class="fa fa-edit text-success me-2"></i>{LANG.editinfo}
            </a>
            <!-- BEGIN: allowopenid -->
            <a href="{URL_HREF}editinfo/openid" class="list-group-item list-group-item-action border-0 px-0 py-2">
                <i class="fa fa-openid text-info me-2"></i>{LANG.openid_administrator}
            </a>
            <!-- END: allowopenid -->
            <!-- BEGIN: myapis -->
            <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}=myapi" class="list-group-item list-group-item-action border-0 px-0 py-2">
                <i class="fa fa-code text-warning me-2"></i>{GLANG.myapis}
            </a>
            <!-- END: myapis -->
        </div>
        <!-- BEGIN: admintoolbar -->
        <div class="border-top pt-3 mb-3">
            <h6 class="text-muted mb-2">
                <i class="fa fa-cogs me-2"></i>{GLANG.for_admin}
            </h6>
            <div class="list-group list-group-flush">
                <a href="{NV_BASE_SITEURL}{NV_ADMINDIR}/index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}" title="{GLANG.admin_page}" class="list-group-item list-group-item-action border-0 px-0 py-2">
                    <i class="fa fa-cog text-danger me-2"></i>{GLANG.admin_page}
                </a>
                <!-- BEGIN: is_modadmin -->
                <a href="{URL_ADMINMODULE}" title="{GLANG.admin_module_sector} {MODULENAME}" class="list-group-item list-group-item-action border-0 px-0 py-2">
                    <i class="fa fa-key text-warning me-2"></i>{GLANG.admin_module_sector} {MODULENAME}
                </a>
                <!-- END: is_modadmin -->
                <!-- BEGIN: is_spadadmin -->
                <a href="{URL_DBLOCK}" title="{LANG_DBLOCK}" class="list-group-item list-group-item-action border-0 px-0 py-2">
                    <i class="fa fa-arrows text-info me-2"></i>{LANG_DBLOCK}
                </a>
                <!-- END: is_spadadmin -->
                <a href="{URL_AUTHOR}" title="{GLANG.admin_view}" class="list-group-item list-group-item-action border-0 px-0 py-2">
                    <i class="fa fa-user text-secondary me-2"></i>{GLANG.admin_view}
                </a>
            </div>
        </div>
        <!-- END: admintoolbar -->

        <!-- Footer -->
        <div class="d-flex align-items-center justify-content-between border-top pt-3">
            <div class="small text-muted" title="{GLANG.current_login}">
                <i class="fa fa-clock me-1"></i>{USER.current_login_txt}
            </div>
            <button type="button" class="btn btn-outline-danger btn-sm" data-toggle="{URL_LOGOUT}">
                <i class="fa fa-sign-out-alt me-1"></i>{GLANG.logout}
            </button>
        </div>
    </div>
</div>
<!-- END: signed -->
