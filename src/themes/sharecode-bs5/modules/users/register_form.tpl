<form class="user-reg-form" action="{USER_REGISTER}" method="post" data-toggle="reg_validForm" data-precheck="reg_form_precheck" autocomplete="off" novalidate<!-- BEGIN: reg_captcha --> data-captcha="nv_seccode"<!-- END: reg_captcha --><!-- BEGIN: reg_recaptcha --> data-recaptcha2="1"<!-- END: reg_recaptcha --><!-- BEGIN: reg_recaptcha3 --> data-recaptcha3="1"<!-- END: reg_recaptcha3 --><!-- BEGIN: reg_turnstile --> data-turnstile="1"<!-- END: reg_turnstile -->>
    <!-- Registration Info Alert -->
    <div class="alert alert-info border-0 mb-4" role="alert" data-default="{LANG.info}">
        <div class="d-flex align-items-center">
            <i class="fa fa-info-circle fa-lg me-3 text-primary"></i>
            <div>
                <h6 class="alert-heading mb-1">Thông tin đăng ký</h6>
                <p class="mb-0 small">{LANG.info}</p>
            </div>
        </div>
    </div>

    <div class="form-detail">
        <!-- BEGIN: name_show_0 -->
        <!-- BEGIN: show_last_name-->
        <div class="mb-3">
            <div>
                <input type="text" class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" value="{FIELD.value}" name="last_name" maxlength="{FIELD.max_length}" data-toggle="validErrorHidden" data-event="keypress" data-mess="{LANG.field_unane_error}"<!-- BEGIN: data_callback--> data-callback="{CALLFUNC}" data-error="{ERRMESS}"<!-- END: data_callback-->>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: show_last_name-->
        <!-- BEGIN: show_first_name-->
        <div class="mb-3">
            <div>
                <input type="text" class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" value="{FIELD.value}" name="first_name" maxlength="{FIELD.max_length}" data-toggle="validErrorHidden" data-event="keypress" data-mess="{LANG.field_unane_error}"<!-- BEGIN: data_callback--> data-callback="{CALLFUNC}" data-error="{ERRMESS}"<!-- END: data_callback-->>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: show_first_name-->
        <!-- END: name_show_0 -->

        <!-- BEGIN: name_show_1 -->
        <!-- BEGIN: show_first_name-->
        <div class="mb-3">
            <div>
                <input type="text" class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" value="{FIELD.value}" name="first_name" maxlength="{FIELD.max_length}" data-toggle="validErrorHidden" data-event="keypress" data-mess=""<!-- BEGIN: data_callback--> data-callback="{CALLFUNC}" data-error="{ERRMESS}"<!-- END: data_callback-->>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: show_first_name-->
        <!-- BEGIN: show_last_name-->
        <div class="mb-3">
            <div>
                <input type="text" class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" value="{FIELD.value}" name="last_name" maxlength="{FIELD.max_length}" data-toggle="validErrorHidden" data-event="keypress" data-mess=""<!-- BEGIN: data_callback--> data-callback="{CALLFUNC}" data-error="{ERRMESS}"<!-- END: data_callback-->>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: show_last_name-->
        <!-- END: name_show_1 -->

        <!-- Account Information Section -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-primary text-white">
                <h6 class="card-title mb-0">
                    <i class="fa fa-user me-2"></i>Thông tin tài khoản
                </h6>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        <i class="fa fa-user text-primary me-2"></i>{LANG.username}
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fa fa-user text-muted"></i>
                        </span>
                        <input type="text" class="required form-control" placeholder="{LANG.username}" value="" name="username" maxlength="{NICK_MAXLENGTH}" data-toggle="validErrorHidden" data-event="keypress" data-mess="{USERNAME_RULE}" data-callback="login_check" data-minlength="{NICK_MINLENGTH}" data-type="{LOGINTYPE}">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        <i class="fa fa-envelope text-success me-2"></i>{LANG.email}
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fa fa-envelope text-muted"></i>
                        </span>
                        <input type="email" class="required form-control" placeholder="{LANG.email}" value="" name="email" maxlength="100" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.email_empty}">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        <i class="fa fa-lock text-danger me-2"></i>{LANG.password}
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fa fa-key text-muted"></i>
                        </span>
                        <input type="password" autocomplete="off" class="password required form-control" placeholder="{LANG.password}" value="" name="password" maxlength="{PASS_MAXLENGTH}" data-pattern="{PASSWORD_PATTERN}" data-toggle="validErrorHidden" data-event="keypress" data-mess="{PASSWORD_RULE}">
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        <i class="fa fa-lock text-warning me-2"></i>{LANG.re_password}
                    </label>
                    <div class="input-group">
                        <span class="input-group-text bg-light">
                            <i class="fa fa-key text-muted"></i>
                        </span>
                        <input type="password" autocomplete="off" class="re-password required form-control" placeholder="{LANG.re_password}" value="" name="re_password" maxlength="{PASS_MAXLENGTH}" data-pattern="/^(.){1,}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{GLANG.re_password_empty}">
                    </div>
                </div>
            </div>
        </div>

        <!-- BEGIN: show_gender -->
        <div>
            <div>
                <div class="mb-3 clearfix radio-box {FIELD.required} {FIELD.class}" data-mess="">
                    <label class="form-label {FIELD.required} {FIELD.class}" title="{FIELD.description}"> {FIELD.title} </label>
                    <div class="d-flex gap-3">
                        <!-- BEGIN: gender -->
                        <div class="form-check">
                            <input type="radio" name="gender" value="{GENDER.key}" class="form-check-input {FIELD.class}" data-toggle="validErrorHidden" data-event="click" data-parents="5" {GENDER.checked} id="gender_{GENDER.key}">
                            <label class="form-check-label" for="gender_{GENDER.key}">{GENDER.title}</label>
                        </div>
                        <!-- END: gender -->
                    </div>
                    <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
                </div>
            </div>
        </div>
        <!-- END: show_gender -->

        <!-- BEGIN: show_birthday -->
        <div class="mb-3">
            <div class="input-group" style="z-index: 1;">
                <input type="text" class="form-control datepicker {FIELD.required} {FIELD.class}" data-provide="datepicker" placeholder="{FIELD.title}" value="{FIELD.value}" name="birthday" readonly="readonly" style="background-color:#fff" data-toggle="validErrorHidden" data-event="change" data-focus="datepickerShow" data-mess=""/>
                <span class="input-group-text pointer" data-toggle="button_datepickerShow"> <i class="fa fa-calendar"></i> </span>
            </div>
            <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
        </div>
        <!-- END: show_birthday -->

        <!-- BEGIN: show_sig -->
        <div class="mb-3">
            <div>
                <textarea class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" name="sig" data-toggle="validErrorHidden" data-event="keypress" data-mess="">{FIELD.value}</textarea>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: show_sig -->

        <!-- BEGIN: show_question -->
        <div class="mb-3 position-relative">
            <div class="input-group">
                <input type="text" class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" value="{FIELD.value}" name="question" maxlength="{FIELD.max_length}" data-pattern="/^(.){{FIELD.min_length},}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{LANG.your_question_empty}">
                <div class="dropdown">
                    <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <!-- BEGIN: frquestion -->
                        <li><a class="dropdown-item" href="#" data-toggle="addQuestion">{QUESTION}</a></li>
                        <!-- END: frquestion -->
                    </ul>
                </div>
            </div>
            <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
        </div>
        <!-- END: show_question -->

        <!-- BEGIN: show_answer -->
        <div class="mb-3">
            <div>
                <input type="text" class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" value="{FIELD.value}" name="answer" maxlength="{FIELD.max_length}" data-pattern="/^(.){{FIELD.min_length},}$/" data-toggle="validErrorHidden" data-event="keypress" data-mess="{LANG.answer_empty}">
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: show_answer -->

        <!-- BEGIN: field -->
        <!-- BEGIN: loop -->
        <!-- BEGIN: textbox -->
        <div class="mb-3">
            <label for="nvcf-{FIELD.field}" class="form-label">{FIELD.title}:</label>
            <div>
                <input type="text" class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" value="{FIELD.value}" name="custom_fields[{FIELD.field}]" data-toggle="validErrorHidden" data-event="keypress" data-mess="" id="nvcf-{FIELD.field}"<!-- BEGIN: data_callback--> data-callback="{CALLFUNC}"  data-error="{ERRMESS}"<!-- END: data_callback-->>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: textbox -->

        <!-- BEGIN: date -->
        <div class="mb-3">
            <label for="nvcf-{FIELD.field}" class="form-label">{FIELD.title}:</label>
            <div class="input-group" style="z-index: 1;">
                <input type="text" class="form-control datepicker {FIELD.required} {FIELD.class}" data-provide="datepicker" placeholder="{FIELD.title}" value="{FIELD.value}" name="custom_fields[{FIELD.field}]" readonly="readonly" style="background-color:#fff" data-toggle="validErrorHidden" data-event="change" data-focus="datepickerShow" data-mess="" id="nvcf-{FIELD.field}">
                <span class="input-group-text pointer" data-toggle="button_datepickerShow"> <i class="fa fa-calendar"></i> </span>
            </div>
            <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
        </div>
        <!-- END: date -->

        <!-- BEGIN: textarea -->
        <div class="mb-3">
            <label for="nvcf-{FIELD.field}" class="form-label">{FIELD.title}:</label>
            <div>
                <textarea class="form-control {FIELD.required} {FIELD.class}" placeholder="{FIELD.title}" name="custom_fields[{FIELD.field}]" data-toggle="validErrorHidden" data-event="keypress" data-mess="" id="nvcf-{FIELD.field}">{FIELD.value}</textarea>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: textarea -->

        <!-- BEGIN: editor -->
        <div class="mb-3">
            <label class="form-label">{FIELD.title}:</label>
            {EDITOR}
            <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
        </div>
        <!-- END: editor -->

        <!-- BEGIN: select -->
        <div class="mb-3">
            <label for="nvcf-{FIELD.field}" class="form-label">{FIELD.title}:</label>
            <div>
                <select name="custom_fields[{FIELD.field}]" class="form-select {FIELD.required} {FIELD.class}" data-toggle="validErrorHidden" data-event="change" data-mess="" id="nvcf-{FIELD.field}">
                    <!-- BEGIN: loop -->
                    <option value="{FIELD_CHOICES.key}" {FIELD_CHOICES.selected}> {FIELD_CHOICES.value} </option>
                    <!-- END: loop -->
                </select>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: select -->

        <!-- BEGIN: radio -->
        <div>
            <div>
                <div class="mb-3 clearfix radio-box {FIELD.required}" data-mess="">
                    <div class="mb-2">
                        <label class="form-label {FIELD.required}" title="{FIELD.description}"> {FIELD.title}</label>
                    </div>
                    <!-- BEGIN: loop -->
                    <div class="form-check">
                        <input type="radio" name="custom_fields[{FIELD.field}]" id="lb_{FIELD_CHOICES.id}" value="{FIELD_CHOICES.key}" class="form-check-input {FIELD.class}" data-toggle="validErrorHidden" data-event="click" data-parents="5"{FIELD_CHOICES.checked}>
                        <label for="lb_{FIELD_CHOICES.id}" class="form-check-label">{FIELD_CHOICES.value}</label>
                    </div>
                    <!-- END: loop -->
                    <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
                </div>
            </div>
        </div>
        <!-- END: radio -->

        <!-- BEGIN: checkbox -->
        <div>
            <div>
                <div class="mb-3 clearfix check-box {FIELD.required}" data-mess="">
                    <div class="mb-2">
                        <label class="form-label {FIELD.required}" title="{FIELD.description}"> {FIELD.title}</label>
                    </div>
                    <!-- BEGIN: loop -->
                    <div class="form-check">
                        <input type="checkbox" name="custom_fields[{FIELD.field}][]" id="lb_{FIELD_CHOICES.id}" value="{FIELD_CHOICES.key}" class="form-check-input {FIELD.class}" data-toggle="validErrorHidden" data-event="click" data-parents="5"{FIELD_CHOICES.checked}>
                        <label for="lb_{FIELD_CHOICES.id}" class="form-check-label">{FIELD_CHOICES.value}</label>
                    </div>
                    <!-- END: loop -->
                    <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
                </div>
            </div>
        </div>
        <!-- END: checkbox -->

        <!-- BEGIN: multiselect -->
        <div class="mb-3">
            <label for="nvcf-{FIELD.field}" class="form-label">{FIELD.title}:</label>
            <div>
                <select name="custom_fields[{FIELD.field}][]" multiple="multiple" class="{FIELD.class} {FIELD.required} form-select" data-toggle="validErrorHidden" data-event="change" data-mess="" id="nvcf-{FIELD.field}">
                    <!-- BEGIN: loop -->
                    <option value="{FIELD_CHOICES.key}" {FIELD_CHOICES.selected}>{FIELD_CHOICES.value}</option>
                    <!-- END: loop -->
                </select>
                <!-- BEGIN: description --><div class="small form-text" style="margin-bottom:0">{FIELD.description}</div><!-- END: description -->
            </div>
        </div>
        <!-- END: multiselect -->

        <!-- BEGIN: file -->
        <div class="mb-3">
            <div class="filelist" data-field="{FIELD.field}" data-oclass="{FIELD.class}" data-maxnum="{FILEMAXNUM}">
                <div class="d-flex align-items-center">
                    <label class="form-label {FIELD.required}">{FIELD.title}</label>
                    <div class="ms-auto"><button type="button" class="btn btn-info btn-sm" data-toggle="addfilebtn" data-modal="uploadfile_{FIELD.field}"><i class="fa fa-upload"></i> {LANG.addfile}</button></div>
                </div>
                <ul class="list-unstyled items"></ul>
                <!-- START FORFOOTER -->
                <div class="modal fade uploadfile" tabindex="-1" role="dialog" id="uploadfile_{FIELD.field}" data-url="{URL_MODULE}" data-field="{FIELD.field}" data-csrf="{CSRF}" data-accept="{FILEACCEPT}" data-maxsize="{FILEMAXSIZE}" data-ext-error="{LANG.addfile_ext_error}" data-size-error="{LANG.addfile_size_error}" data-size-error2="{LANG.addfile_size_error2}" data-delete="{LANG.delete}">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title"><strong>{LANG.addfile}</strong></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p class="fileinput d-flex justify-content-center my-4"></p>
                                <ul class="list-unstyled text-muted small">
                                    <li>- {LANG.accepted_extensions}: {FILEACCEPT}</li>
                                    <li>- {LANG.field_file_max_size}: {FILEMAXSIZE_FORMAT}</li>
                                    <!-- BEGIN: widthlimit --><li>- {WIDTHLIMIT}</li><!-- END: widthlimit -->
                                    <!-- BEGIN: heightlimit --><li>- {HEIGHTLIMIT}</li><!-- END: heightlimit -->
                                </ul>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">{GLANG.close}</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END FORFOOTER -->
            </div>
        </div>
        <!-- END: file -->
        <!-- END: loop -->
        <!-- END: field -->

        <!-- BEGIN: agreecheck -->
        <div>
            <div>
                <div class="mb-3 text-center form-check required" data-mess="">
                    <input type="checkbox" name="agreecheck" value="1" class="form-check-input" id="agreecheck" data-toggle="validErrorHidden" data-event="click" data-parents="3"/>
                    <label class="form-check-label" for="agreecheck">{LANG.accept2} <a href="#" data-toggle="usageTermsShow" data-title="{LANG.usage_terms}"><span class="btn btn-outline-secondary btn-sm">{LANG.usage_terms}</span></a></label>
                </div>
            </div>
        </div>
        <!-- END: agreecheck -->

        <!-- Submit Section -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-body text-center">
                <input type="hidden" name="checkss" value="{CHECKSS}" />
                <!-- BEGIN: redirect --><input name="nv_redirect" value="{REDIRECT}" type="hidden" /><!-- END: redirect -->

                <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                    <button type="button" class="btn btn-outline-secondary btn-lg px-4" data-toggle="validReset">
                        <i class="fa fa-undo me-2"></i>{GLANG.reset}
                    </button>
                    <button type="submit" class="btn btn-primary btn-lg px-5">
                        <i class="fa fa-user-plus me-2"></i>{LANG.register}
                    </button>
                </div>

                <div class="mt-3">
                    <small class="text-muted">
                        <i class="fa fa-shield-alt me-1"></i>
                        Thông tin của bạn được bảo mật tuyệt đối
                    </small>
                </div>
            </div>
        </div>
        <!-- BEGIN: lostactivelink -->
        <div class="text-center">
            <a href="{LOSTACTIVELINK_SRC}">{LANG.resend_activelink}</a>
        </div>
        <!-- END: lostactivelink -->
    </div>
</form>
