<!-- BEGIN: main -->
<div class="min-vh-100 d-flex align-items-center" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8 col-lg-6 col-xl-5">
                <div class="card shadow-lg border-0">
                    <div class="card-body p-4 p-sm-5">
                        <!-- Logo -->
                        <div class="text-center mb-4">
                            <img class="img-fluid" src="{LOGO}" alt="{SITE_NAME}" title="{SITE_NAME}" style="max-height: 60px;">
                        </div>

                        <!-- Header -->
                        <div class="text-center mb-4">
                            <div class="mb-3">
                                <i class="fa fa-key fa-3x text-warning"></i>
                            </div>
                            <h2 class="card-title fw-bold text-dark">{LANG.change_pass}</h2>
                            <p class="text-muted small">Cập nhật mật khẩu bảo mật</p>
                        </div>

                        <!-- Info Alert -->
                        <div class="alert alert-info border-0 mb-4" role="alert">
                            <i class="fa fa-info-circle me-2"></i>{CHANGEPASS_INFO}
                        </div>

                        <!-- Form -->
                        <form action="{CHANGEPASS_FORM}" method="post" role="form" data-toggle="reg_validForm" autocomplete="off" novalidate>
                            <div class="alert alert-danger border-0 d-none" role="alert" data-default="">
                                <i class="fa fa-exclamation-triangle me-2"></i><span></span>
                            </div>

                            <!-- BEGIN: is_old_pass -->
                            <div class="mb-3">
                                <label for="nv_password" class="form-label fw-semibold text-dark mb-2">
                                    <i class="fa fa-lock text-danger me-2"></i>{LANG.pass_old}
                                </label>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fa fa-key text-muted"></i>
                                    </span>
                                    <input type="password" autocomplete="off" class="required form-control border-start-0 ps-0" placeholder="{LANG.pass_old}" value="" name="nv_password" maxlength="{PASS_MAXLENGTH}" data-pattern="/^(.){{PASS_MINLENGTH},{PASS_MAXLENGTH}}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{LANG.required}">
                                </div>
                            </div>
                            <!-- END: is_old_pass -->

                            <div class="mb-3">
                                <label for="new_password" class="form-label fw-semibold text-dark mb-2">
                                    <i class="fa fa-lock text-success me-2"></i>{LANG.pass_new}
                                </label>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fa fa-key text-muted"></i>
                                    </span>
                                    <input type="password" autocomplete="off" class="required form-control border-start-0 ps-0" placeholder="{LANG.pass_new}" value="" name="new_password" maxlength="{PASS_MAXLENGTH}" data-pattern="/^(.){{PASS_MINLENGTH},{PASS_MAXLENGTH}}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{PASSWORD_RULE}">
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="re_password" class="form-label fw-semibold text-dark mb-2">
                                    <i class="fa fa-check-circle text-success me-2"></i>{LANG.pass_new_re}
                                </label>
                                <div class="input-group input-group-lg">
                                    <span class="input-group-text bg-light border-end-0">
                                        <i class="fa fa-key text-muted"></i>
                                    </span>
                                    <input type="password" autocomplete="off" class="required form-control border-start-0 ps-0" placeholder="{LANG.pass_new_re}" value="" name="re_password" maxlength="{PASS_MAXLENGTH}" data-pattern="/^(.){{PASS_MINLENGTH},{PASS_MAXLENGTH}}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.re_password_empty}">
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="d-grid gap-2 mb-4">
                                <input type="hidden" name="checkss" value="{CHECKSS}" />
                                <button type="submit" class="btn btn-primary btn-lg py-3 fw-semibold">
                                    <i class="fa fa-save me-2"></i>{LANG.editinfo_confirm}
                                </button>
                                <button type="button" class="btn btn-outline-secondary" data-toggle="validReset">
                                    <i class="fa fa-undo me-2"></i>{GLANG.reset}
                                </button>
                            </div>

                            <!-- Logout Section -->
                            <div class="border-top pt-4 text-center">
                                <p class="text-muted small mb-3">Hoặc thoát khỏi tài khoản</p>
                                <button type="button" class="btn btn-outline-danger" data-toggle="{URL_LOGOUT}">
                                    <i class="fa fa-sign-out-alt me-2"></i>{LANG.logout_title}
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