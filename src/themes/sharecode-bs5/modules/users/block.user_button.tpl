<!-- BEGIN: main -->
<div class="user-button-container">
    <button type="button" class="btn btn-primary btn-sm position-relative" data-toggle="tip" data-target="#guestBlock_{BLOCKID}" data-click="y" data-callback="loginFormLoad" title="{GLANG.signin} - {GLANG.register}">
        <i class="fa fa-user me-1"></i>
        <span class="d-none d-sm-inline">{GLANG.signin}</span>
        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary">
            <i class="fa fa-plus fa-xs"></i>
        </span>
    </button>
</div>

<!-- Enhanced Login Modal -->
<div id="guestBlock_{BLOCKID}" class="d-none">
    <div class="card border-0 shadow-lg" style="min-width: 350px; max-width: 400px;">
        <div class="card-header bg-gradient bg-primary text-white border-0">
            <div class="d-flex align-items-center justify-content-between">
                <h6 class="card-title mb-0 fw-bold">
                    <i class="fa fa-sign-in-alt me-2"></i>Đăng nhập tài khoản
                </h6>
                <div class="d-flex align-items-center">
                    <span class="badge bg-light text-primary small">
                        <i class="fa fa-shield-alt me-1"></i>Bảo mật
                    </span>
                </div>
            </div>
        </div>
        <div class="card-body p-4">
            <div class="text-center mb-3">
                <div class="spinner-border text-primary d-none" role="status" id="loginSpinner_{BLOCKID}">
                    <span class="visually-hidden">Đang tải...</span>
                </div>
            </div>
            <div class="log-area"></div>
        </div>
        <div class="card-footer bg-light border-0 text-center">
            <small class="text-muted">
                <i class="fa fa-info-circle me-1"></i>
                Đăng nhập để trải nghiệm đầy đủ tính năng
            </small>
        </div>
    </div>
</div>
<script>
function loginFormLoad() {
    // Show loading spinner
    const spinner = document.getElementById('loginSpinner_{BLOCKID}');
    if (spinner) {
        spinner.classList.remove('d-none');
    }

    $.ajax({
        type: 'POST',
        url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_fc_variable + '=login',
        cache: !1,
        data: {
            nv_ajax: 1,
            nv_redirect: '{NV_REDIRECT}'
        },
        dataType: "json"
    }).done(function(res) {
        if (res.sso) {
            window.location.href = res.sso;
            return !1;
        }
        if (res.reload) {
            location.reload();
            return !1;
        }
        $("#tip .log-area").html(res.html);
        change_captcha();
    });
}
</script>
<!-- END FORFOOTER -->
<!-- END: main -->

<!-- BEGIN: signed -->
<span>
    <a title="{USER.full_name}" class="btn btn-outline-success btn-sm position-relative" data-toggle="tip" data-target="#userBlock_{BLOCKID}" data-click="y">
        <img src="{AVATA}" alt="{USER.full_name}" class="rounded-circle me-1" width="20" height="20" style="object-fit: cover;">
        <span class="d-none d-sm-inline">{USER.full_name}</span>
        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-success">
            <i class="fa fa-check" style="font-size: 8px;"></i>
        </span>
    </a>
</span>
<!-- START FORFOOTER -->
<div id="userBlock_{BLOCKID}" class="d-none">
    <div class="card border-0 shadow-lg" style="min-width: 350px;">
        <div class="alert alert-success border-0 d-none" role="alert"></div>
        <div class="card-header bg-success text-white">
            <div class="d-flex align-items-center">
                <img src="{AVATA}" alt="{USER.full_name}" class="rounded-circle me-2" width="30" height="30" style="object-fit: cover;">
                <div>
                    <div class="badge bg-light text-success small lev-{LEVEL}">{WELCOME}</div>
                    <h6 class="mb-0">{USER.full_name}</h6>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-4 text-center">
                    <a title="{LANG.edituser}" href="#" data-toggle="changeAvatar" data-url="{URL_AVATAR}" class="d-block">
                        <img src="{AVATA}" alt="{USER.full_name}" class="img-thumbnail rounded-circle border-2 border-success" width="60" height="60" style="object-fit: cover;" />
                        <small class="text-muted d-block mt-1">Đổi ảnh</small>
                    </a>
                </div>
                <div class="col-8">
                    <div class="list-group list-group-flush">
                        <a href="{URL_MODULE}" class="list-group-item list-group-item-action border-0 px-0 py-1 active">
                            <i class="fa fa-user text-primary me-2"></i>{LANG.user_info}
                        </a>
                        <a href="{URL_HREF}editinfo" class="list-group-item list-group-item-action border-0 px-0 py-1">
                            <i class="fa fa-edit text-success me-2"></i>{LANG.editinfo}
                        </a>
                        <!-- BEGIN: allowopenid -->
                        <a href="{URL_HREF}editinfo/openid" class="list-group-item list-group-item-action border-0 px-0 py-1">
                            <i class="fa fa-openid text-info me-2"></i>{LANG.openid_administrator}
                        </a>
                        <!-- END: allowopenid -->
                        <!-- BEGIN: myapis -->
                        <a href="{NV_BASE_SITEURL}index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}&amp;{NV_NAME_VARIABLE}=myapi" class="list-group-item list-group-item-action border-0 px-0 py-1">
                            <i class="fa fa-code text-warning me-2"></i>{GLANG.myapis}
                        </a>
                        <!-- END: myapis -->
                    </div>
                </div>
            </div>
            <!-- BEGIN: admintoolbar -->
            <div class="border-top pt-3 mt-3">
                <h6 class="text-muted mb-2">
                    <i class="fa fa-cogs me-2"></i>{GLANG.for_admin}
                </h6>
                <div class="list-group list-group-flush">
                    <a href="{NV_BASE_SITEURL}{NV_ADMINDIR}/index.php?{NV_LANG_VARIABLE}={NV_LANG_DATA}" title="{GLANG.admin_page}" class="list-group-item list-group-item-action border-0 px-0 py-1">
                        <i class="fa fa-cog text-danger me-2"></i>{GLANG.admin_page}
                    </a>
                    <!-- BEGIN: is_modadmin -->
                    <a href="{URL_ADMINMODULE}" title="{GLANG.admin_module_sector} {MODULENAME}" class="list-group-item list-group-item-action border-0 px-0 py-1">
                        <i class="fa fa-key text-warning me-2"></i>{GLANG.admin_module_sector} {MODULENAME}
                    </a>
                    <!-- END: is_modadmin -->
                    <!-- BEGIN: is_spadadmin -->
                    <a href="{URL_DBLOCK}" title="{LANG_DBLOCK}" class="list-group-item list-group-item-action border-0 px-0 py-1">
                        <i class="fa fa-arrows text-info me-2"></i>{LANG_DBLOCK}
                    </a>
                    <!-- END: is_spadadmin -->
                    <a href="{URL_AUTHOR}" title="{GLANG.admin_view}" class="list-group-item list-group-item-action border-0 px-0 py-1">
                        <i class="fa fa-user text-secondary me-2"></i>{GLANG.admin_view}
                    </a>
                </div>
            </div>
            <!-- END: admintoolbar -->
        </div>
        <div class="card-footer bg-light border-0">
            <div class="d-flex align-items-center justify-content-between">
                <small class="text-muted" title="{LANG.current_login}">
                    <i class="fa fa-clock me-1"></i>{USER.current_login_txt}
                </small>
                <button type="button" class="btn btn-danger btn-sm" data-toggle="{URL_LOGOUT}">
                    <i class="fa fa-sign-out-alt me-1"></i>{LANG.logout_title}
                </button>
            </div>
        </div>
    </div>
</div>
<!-- END FORFOOTER -->
<script src="{NV_STATIC_URL}themes/{BLOCK_JS}/js/users.js"></script>
<!-- END: signed -->

<!-- BEGIN: sso -->
<span>
    <a title="{GLANG.signin}" class="btn btn-primary btn-sm" href="{LINK_LOGIN}" rel="nofollow">
        <i class="fa fa-user me-1"></i><span class="d-none d-sm-inline">{GLANG.signin}</span>
    </a>
</span>
<!-- END: sso -->
