<!-- BEGIN: main -->
<div class="min-vh-100 d-flex align-items-center" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card border-0 shadow-lg">
                    <div class="card-body p-4 p-sm-5">
                        <!-- Header -->
                        <div class="text-center mb-4">
                            <div class="mb-3">
                                <i class="fa fa-shield-alt fa-3x text-warning"></i>
                            </div>
                            <h2 class="card-title fw-bold text-dark">{PAGETITLE}</h2>
                            <p class="text-muted small">Xác nhận danh tính để tiếp tục</p>
                        </div>

                        <!-- Form -->
                        <form action="{OPENID_LOGIN}" method="post" role="form" <!-- BEGIN: captcha --> data-captcha="nv_seccode"<!-- END: captcha --><!-- BEGIN: recaptcha --> data-recaptcha2="1"<!-- END: recaptcha --><!-- BEGIN: recaptcha3 --> data-recaptcha3="1"<!-- END: recaptcha3 -->>
                            <!-- Info Alert -->
                            <div class="alert alert-info border-0 mb-4" role="alert">
                                <i class="fa fa-info-circle me-2"></i>{LANG.openid_confirm_info}
                            </div>

                            <!-- Password Field -->
                            <div class="mb-4">
                                <label class="form-label fw-semibold text-dark mb-2">
                                    <i class="fa fa-lock text-danger me-2"></i>Xác nhận mật khẩu
                                </label>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fa fa-key text-muted"></i>
                                    </span>
                                    <input type="password" autocomplete="off" class="required form-control border-start-0 ps-0" placeholder="{GLANG.password}" value="" name="password" maxlength="100" />
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="d-grid gap-2">
                                <input name="openid_account_confirm" value="1" type="hidden" />
                                <!-- BEGIN: redirect --><input name="nv_redirect" value="{REDIRECT}" type="hidden" /><!-- END: redirect -->
                                <button class="bsubmit btn btn-primary btn-lg py-3 fw-semibold" type="submit">
                                    <i class="fa fa-check me-2"></i>{GLANG.loginsubmit}
                                </button>
                                <button type="reset" class="btn btn-outline-secondary">
                                    <i class="fa fa-undo me-2"></i>{GLANG.reset}
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->