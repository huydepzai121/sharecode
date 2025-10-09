<form action="{FORM_ACTION}" method="post" data-toggle="lostPass" autocomplete="off" novalidate<!-- BEGIN: captcha --> data-captcha="nv_seccode"<!-- END: captcha --><!-- BEGIN: recaptcha --> data-recaptcha2="1"<!-- END: recaptcha --><!-- BEGIN: recaptcha3 --> data-recaptcha3="1"<!-- END: recaptcha3 --><!-- BEGIN: turnstile --> data-turnstile="1"<!-- END: turnstile -->>
    <div class="alert alert-info border-0 mb-4" role="alert" data-default="{LANG.lostpass_info1}">
        <i class="fa fa-info-circle me-2"></i>{LANG.lostpass_info1}
    </div>

    <div class="form-detail">
        <!-- Step 1: Username/Email -->
        <div class="step1">
            <div class="mb-4">
                <label class="form-label fw-semibold text-dark mb-2">
                    <i class="fa fa-user text-primary me-2"></i>Thông tin tài khoản
                </label>
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="fa fa-user text-muted"></i>
                    </span>
                    <input type="text" class="required form-control border-start-0 ps-0" placeholder="{LANG.username_or_email}" value="" name="userField" maxlength="100" data-pattern="/^(.){3,}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{LANG.lostpass_no_info1}">
                </div>
            </div>
        </div>

        <!-- Step 2: Security Question -->
        <div class="step2" style="display:none">
            <div class="mb-4">
                <label class="form-label fw-semibold text-dark mb-2">
                    <i class="fa fa-question-circle text-warning me-2"></i>Câu hỏi bảo mật
                </label>
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="fa fa-pencil-square-o text-muted"></i>
                    </span>
                    <input type="text" class="form-control border-start-0 ps-0" placeholder="{LANG.answer_question}" value="" name="answer" maxlength="255" data-toggle="validErrorHidden" data-event="keypress" data-mess="{LANG.answer_empty}">
                </div>
            </div>
        </div>

        <!-- Step 3: Verification Key -->
        <div class="step3" style="display:none">
            <div class="mb-4">
                <label class="form-label fw-semibold text-dark mb-2">
                    <i class="fa fa-shield text-success me-2"></i>Mã xác thực
                </label>
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="fa fa-shield text-muted"></i>
                    </span>
                    <input type="text" class="form-control border-start-0 ps-0" placeholder="{LANG.lostpass_key}" value="" name="verifykey" maxlength="10" data-pattern="/^[a-zA-Z0-9]{10,10}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{LANG.lostpass_active_error}">
                </div>
            </div>
        </div>

        <!-- Step 4: New Password -->
        <div class="step4" style="display:none">
            <div class="mb-3">
                <label class="form-label fw-semibold text-dark mb-2">
                    <i class="fa fa-key text-danger me-2"></i>Mật khẩu mới
                </label>
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="fa fa-key text-muted"></i>
                    </span>
                    <input type="password" autocomplete="off" class="form-control border-start-0 ps-0" placeholder="{LANG.pass_new}" value="" name="new_password" maxlength="100" data-pattern="/^(.){3,}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.password_empty}">
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold text-dark mb-2">
                    <i class="fa fa-key text-danger me-2"></i>Xác nhận mật khẩu
                </label>
                <div class="input-group input-group-lg">
                    <span class="input-group-text bg-light border-end-0">
                        <i class="fa fa-key text-muted"></i>
                    </span>
                    <input type="password" autocomplete="off" class="form-control border-start-0 ps-0" placeholder="{LANG.pass_new_re}" value="" name="re_password" maxlength="100" data-pattern="/^(.){3,}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.passwordsincorrect}">
                </div>
            </div>
        </div>

        <div class="d-grid gap-2 mt-4">
            <input type="hidden" name="step" value="step1" />
            <input type="hidden" name="checkss" value="{DATA.checkss}" />
            <input type="hidden" name="gcaptcha_session" value="" />
            <!-- BEGIN: redirect --><input name="nv_redirect" value="{REDIRECT}" type="hidden" /><!-- END: redirect -->
            <button class="bsubmit btn btn-primary btn-lg py-3 fw-semibold" type="submit">
                <i class="fa fa-paper-plane me-2"></i>{LANG.lostpass_submit}
            </button>
        </div>
    </div>
</form>
