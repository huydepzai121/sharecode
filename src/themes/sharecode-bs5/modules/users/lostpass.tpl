<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row justify-content-center align-items-center min-vh-100 py-5">
        <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
            <div class="card shadow-lg border-0">
                <div class="card-body p-4 p-sm-5">
                    <div class="text-center mb-4">
                        <div class="mb-3">
                            <i class="fa fa-lock fa-3x text-primary"></i>
                        </div>
                        <h2 class="card-title fw-bold text-dark">{LANG.lostpass_page_title}</h2>
                        <p class="text-muted small">Nhập thông tin để khôi phục mật khẩu</p>
                    </div>
                    {FILE "lostpass_form.tpl"}
                    <div class="text-center mt-4">
                        <div class="d-flex flex-wrap justify-content-center gap-3">
                            <!-- BEGIN: navbar --><a href="{NAVBAR.href}" class="btn btn-link text-decoration-none"><i class="fa fa-caret-right me-1"></i>{NAVBAR.title}</a><!-- END: navbar -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->