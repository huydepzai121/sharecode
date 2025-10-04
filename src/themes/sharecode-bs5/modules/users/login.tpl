<!-- BEGIN: main -->
<!-- BEGIN: google_identity_js -->
<script src="https://accounts.google.com/gsi/client" async defer></script>
<!-- END: google_identity_js -->

<!-- Login Page with Modern Bootstrap 5 Design -->
<div class="min-vh-100 d-flex align-items-center py-5" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                <div class="card border-0 shadow-lg" style="border-radius: 1rem; backdrop-filter: blur(10px);">
                    <!-- BEGIN: redirect2 -->
                    <div class="card-header bg-transparent border-0 text-center pt-4 pb-2">
                        <a title="{SITE_NAME}" href="{THEME_SITE_HREF}" class="text-decoration-none">
                            <img class="logo mb-3" src="{LOGO_SRC}" alt="{SITE_NAME}" style="max-height: 60px;">
                        </a>
                    </div>
                    <!-- END: redirect2 -->

                    <div class="card-body px-4 py-4">
                        <div class="text-center mb-4">
                            <h2 class="fw-bold text-dark mb-2">{LANG.login}</h2>
                            <p class="text-muted small">Chào mừng bạn quay trở lại!</p>
                        </div>

                        {FILE "login_form.tpl"}
                    </div>

                    <!-- Navigation Links -->
                    <div class="card-footer bg-transparent border-0 text-center pb-4" id="other_form">
                        <div class="d-flex flex-wrap justify-content-center gap-3">
                            <!-- BEGIN: navbar -->
                            <a href="{NAVBAR.href}" class="btn btn-outline-primary btn-sm">
                                <i class="fa fa-caret-right me-1"></i>{NAVBAR.title}
                            </a>
                            <!-- END: navbar -->
                        </div>
                    </div>
                </div>

                <!-- Additional Info -->
                <div class="text-center mt-4">
                    <p class="text-white-50 small mb-0">
                        <i class="fa fa-shield-alt me-1"></i>
                        Đăng nhập an toàn và bảo mật
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Custom Styles for Login Page -->
<style>
.card {
    background: rgba(255, 255, 255, 0.95);
}

.card:hover {
    transform: translateY(-2px);
    transition: all 0.3s ease;
}

@media (max-width: 576px) {
    .card {
        margin: 1rem;
        border-radius: 0.75rem !important;
    }
}
</style>
<!-- END: main -->