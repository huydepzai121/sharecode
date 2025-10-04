<form action="{USER_LOGIN}" method="post" data-toggle="userLogin" data-precheck="login_form_precheck" autocomplete="off" novalidate<!-- BEGIN: captcha --> data-captcha="nv_seccode"<!-- END: captcha --><!-- BEGIN: recaptcha --> data-recaptcha2="1"<!-- END: recaptcha --><!-- BEGIN: recaptcha3 --> data-recaptcha3="1"<!-- END: recaptcha3 --><!-- BEGIN: turnstile --> data-turnstile="1"<!-- END: turnstile -->>
    <input type="hidden" name="_csrf" value="{CSRF}">
    <input type="hidden" name="cant_do_2step" value="0">
    <!-- BEGIN: header --><input name="nv_header" value="{NV_HEADER}" type="hidden"><!-- END: header -->
    <!-- BEGIN: redirect --><input name="nv_redirect" value="{REDIRECT}" type="hidden"><!-- END: redirect -->
    <div class="alert alert-info border-0 mb-4" role="alert" data-default="{GLANG.logininfo}">
        <i class="fa fa-info-circle me-2"></i>{GLANG.logininfo}
    </div>
    <div class="form-detail">
        <div class="loginstep1">
            <div class="mb-3">
                <label class="form-label fw-semibold text-dark mb-2">
                    <i class="fa fa-user text-primary me-2"></i>Tên đăng nhập hoặc Email
                </label>
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="fa fa-user text-muted"></i>
                    </span>
                    <input type="text" class="required form-control border-start-0 ps-0" placeholder="{GLANG.username_email}" value="" name="nv_login" maxlength="100" data-pattern="/^(.){1,}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.username_empty}">
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label fw-semibold text-dark mb-2">
                    <i class="fa fa-lock text-danger me-2"></i>Mật khẩu
                </label>
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="fa fa-key text-muted"></i>
                    </span>
                    <input type="password" autocomplete="off" class="required form-control border-start-0 ps-0" placeholder="{GLANG.password}" value="" name="nv_password" maxlength="100" data-pattern="/^(.){3,}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.password_empty}">
                </div>
            </div>
            <div class="d-grid gap-2 mb-4">
                <button class="bsubmit btn btn-primary btn-lg py-3 fw-semibold" type="submit">
                    <i class="fa fa-sign-in me-2"></i>{GLANG.loginsubmit}
                </button>
                <input type="button" value="{GLANG.reset}" class="btn btn-outline-secondary" data-toggle="validReset" />
            </div>
            <div class="text-center mb-4 d-none" data-toggle="passkey-ctn">
                <button class="btn btn-outline-primary w-100 d-none" type="button" data-toggle="passkey-btn"><i class="fa fa-key" data-icon="fa-key" aria-hidden="true"></i> {GLANG.passkey_login}</button>
                <a class="d-none" href="#" data-toggle="passkey-link">{GLANG.passkey_login}</a>
                <div class="text-danger mt-2 d-none" data-toggle="passkey-error"></div>
            </div>
        </div>
        <div class="loginstep2 d-none">
            <div class="loginstep2-item loginstep2-app d-none">
                <div class="mb-4">
                    <label class="form-label fw-semibold text-dark mb-3">
                        <i class="fa fa-mobile text-success me-2"></i>{GLANG.2teplogin_totppin_label}
                    </label>
                    <div class="input-group input-group-lg">
                        <span class="input-group-text bg-light border-end-0">
                            <i class="fa fa-key text-muted"></i>
                        </span>
                        <input type="text" class="required form-control border-start-0 ps-0" placeholder="{GLANG.2teplogin_totppin_placeholder}" value="" name="nv_totppin" maxlength="6" data-pattern="/^(.){6,}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.2teplogin_totppin_placeholder}">
                    </div>
                </div>
                <div class="d-grid gap-2 mb-4">
                    <button class="bsubmit btn btn-success btn-lg py-3 fw-semibold" type="submit">
                        <i class="fa fa-check me-2"></i>{GLANG.verify}
                    </button>
                    <button type="button" class="btn btn-outline-secondary" data-toggle="validReset2fa">{GLANG.reset}</button>
                </div>
            </div>
            <div class="loginstep2-item loginstep2-code d-none">
                <div class="mb-4">
                    <label class="form-label fw-semibold text-dark mb-3">
                        <i class="fa fa-shield text-warning me-2"></i>{GLANG.2teplogin_code_label}
                    </label>
                    <div class="input-group input-group-lg">
                        <span class="input-group-text bg-light border-end-0">
                            <i class="fa fa-key text-muted"></i>
                        </span>
                        <input type="text" class="required form-control border-start-0 ps-0" placeholder="{GLANG.2teplogin_code_placeholder}" value="" name="nv_backupcodepin" maxlength="8" data-pattern="/^(.){8,}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.2teplogin_code_placeholder}">
                    </div>
                </div>
                <div class="d-grid gap-2 mb-4">
                    <button class="bsubmit btn btn-success btn-lg py-3 fw-semibold" type="submit">
                        <i class="fa fa-check me-2"></i>{GLANG.verify}
                    </button>
                    <button type="button" class="btn btn-outline-secondary" data-toggle="validReset2fa">{GLANG.reset}</button>
                </div>
            </div>
            <div class="loginstep2-item loginstep2-key d-none">
                <div class="mb-4">
                    <div class="alert alert-info border-0 mb-3">
                        <i class="fa fa-info-circle me-2"></i>{GLANG.2fa_method_key2}
                    </div>
                    <div class="text-danger d-none mb-3" data-toggle="passkey-error"></div>
                    <div class="d-grid">
                        <button class="btn btn-success btn-lg py-3 fw-semibold" type="button" data-toggle="passkey-verify">
                            <i class="fa fa-key me-2" data-icon="fa-key" aria-hidden="true"></i> {GLANG.2fa_method_key1}
                        </button>
                    </div>
                </div>
                <input type="hidden" name="auth_assertion" value="">
            </div>
            <div class="loginstep2-methods methods" data-is-key="0">
                <div class="card border-0 bg-light">
                    <div class="card-body">
                        <h6 class="card-title fw-semibold mb-3">
                            <i class="fa fa-question-circle text-warning me-2"></i>{GLANG.2fa_problems}:
                        </h6>
                        <div class="list-group list-group-flush">
                            <a href="#" class="list-group-item list-group-item-action border-0 px-0" data-toggle="2fa-choose" data-method="key">
                                <i class="fa fa-key text-primary me-2"></i>{GLANG.2fa_method_key}
                            </a>
                            <a href="#" class="list-group-item list-group-item-action border-0 px-0" data-toggle="2fa-choose" data-method="app">
                                <i class="fa fa-mobile text-success me-2"></i>{GLANG.2fa_method_app}
                            </a>
                            <a href="#" class="list-group-item list-group-item-action border-0 px-0" data-toggle="2fa-choose" data-method="code">
                                <i class="fa fa-shield text-warning me-2"></i>{GLANG.2fa_method_code}
                            </a>
                            <a href="#" class="list-group-item list-group-item-action border-0 px-0" data-toggle="2fa-choose-recovery">
                                <i class="fa fa-life-ring text-danger me-2"></i>{GLANG.2fa_recovery}
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- BEGIN: allowuserreg2_form -->
        <div class="text-center mb-3">
            <div class="border-top pt-3">
                <p class="text-muted small mb-2">Chưa có tài khoản?</p>
                <a href="#" class="btn btn-outline-primary" data-toggle="modalShowByObj" data-obj="#guestReg_{BLOCKID}" data-callback="recaptchareset">
                    <i class="fa fa-user-plus me-2"></i>{GLANG.register}
                </a>
            </div>
        </div>
        <!-- END: allowuserreg2_form -->

        <!-- BEGIN: allowuserreg_linkform -->
        <div class="text-center mb-3">
            <div class="border-top pt-3">
                <p class="text-muted small mb-2">Chưa có tài khoản?</p>
                <a href="{USER_REGISTER}" class="btn btn-outline-primary">
                    <i class="fa fa-user-plus me-2"></i>{GLANG.register}
                </a>
            </div>
        </div>
        <!-- END: allowuserreg_linkform -->

        <!-- BEGIN: openid -->
        <div class="border-top pt-4 mt-4">
            <div class="text-center mb-3">
                <p class="text-muted small">Hoặc đăng nhập bằng</p>
            </div>

            <!-- BEGIN: google_identity_onload -->
            <div id="g_id_onload" data-client_id="{GOOGLE_CLIENT_ID}" data-context="signin" data-ux_mode="popup" data-callback="GIDHandleCredentialResponse" data-itp_support="true" data-use_fedcm_for_prompt="true" data-url="{GOOGLE_IDENTITY_URL}" data-csrf="{CHECKSS}" data-redirect="{REDIRECT}">
            </div>

            <div class="d-flex justify-content-center mb-3">
                <div class="g_id_signin" data-type="standard" data-shape="rectangular" data-theme="outline" data-text="signin_with" data-size="large" data-locale="{NV_LANG_INTERFACE}" data-logo_alignment="center" data-width="300">
                </div>
            </div>

            <div id="g_id_confirm" class="d-none">
                <div class="alert alert-info border-0">
                    <p class="mb-3">{LANG.g_id_confirm}</p>
                    <div class="text-center">
                        <a href="" class="btn btn-primary">{LANG.g_id_confirm2}</a>
                    </div>
                </div>
            </div>
            <!-- END: google_identity_onload -->

            <div class="text-center openid-btns">
                <!-- BEGIN: server -->
                <div class="d-grid gap-2 mb-2">
                    <a class="btn btn-outline-secondary openid-{OPENID.server}" href="{OPENID.href}" data-toggle="openID_load">
                        <i class="fa fa-{OPENID.icon} me-2"></i>{LANG.login_with} {OPENID.title}
                    </a>
                </div>
                <!-- END: server -->
            </div>
        </div>
        <!-- END: openid -->
    </div>
</form>
