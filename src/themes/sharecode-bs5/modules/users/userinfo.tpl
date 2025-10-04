<!-- BEGIN: main -->
<!-- BEGIN: changepass_request2 -->
<div class="alert alert-danger border-0">
    <i class="fa fa-exclamation-triangle me-2"></i>{CHANGEPASS_INFO}
</div>
<!-- END: changepass_request2 -->
<!-- BEGIN: changeemail_request2 -->
<div class="alert alert-danger border-0">
    <i class="fa fa-exclamation-triangle me-2"></i>{CHANGEEMAIL_INFO}
</div>
<!-- END: changeemail_request2 -->

<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Header -->
            <div class="d-flex align-items-center mb-4">
                <div class="me-3">
                    <i class="fa fa-user fa-2x text-primary"></i>
                </div>
                <div>
                    <h2 class="mb-0 fw-bold">{LANG.user_info}</h2>
                    <p class="text-muted mb-0">Thông tin tài khoản cá nhân</p>
                </div>
            </div>

            <!-- User Profile Card -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-auto">
                            <figure data-toggle="changeAvatar" data-url="{URL_AVATAR}" class="mb-0 position-relative" style="cursor: pointer;">
                                <img src="{IMG.src}" alt="{USER.username}" title="{USER.username}"
                                     width="100" height="100" class="img-thumbnail rounded-circle border-3 border-primary"
                                     style="object-fit: cover;" />
                                <div class="position-absolute bottom-0 end-0 bg-primary text-white rounded-circle d-flex align-items-center justify-content-center"
                                     style="width: 30px; height: 30px;">
                                    <i class="fa fa-camera fa-sm"></i>
                                </div>
                                <figcaption class="text-center mt-2 small text-muted">{IMG.title}</figcaption>
                            </figure>
                        </div>
                        <div class="col">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-user text-primary me-2"></i>
                                        <strong class="text-muted">{LANG.account2}:</strong>
                                    </div>
                                    <div class="fw-bold text-break">
                                        <span class="text-primary">{USER.username}</span>
                                        <br><small class="text-muted">({USER.email})</small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-shield text-success me-2"></i>
                                        <strong class="text-muted">Trạng thái:</strong>
                                    </div>
                                    <div class="fw-bold text-break">{USER.current_mode}</div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-clock text-info me-2"></i>
                                        <strong class="text-muted">{LANG.current_login}:</strong>
                                    </div>
                                    <div class="fw-bold">{USER.current_login}</div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-globe text-warning me-2"></i>
                                        <strong class="text-muted">{LANG.ip}:</strong>
                                    </div>
                                    <div class="fw-bold font-monospace">{USER.current_ip}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- BEGIN: change_login_note -->
<div class="alert alert-danger">
    <em class="fa fa-exclamation-triangle ">&nbsp;</em> {USER.change_name_info}
</div>
<!-- END: change_login_note -->
<!-- BEGIN: pass_empty_note -->
<div class="alert alert-danger">
    <em class="fa fa-exclamation-triangle ">&nbsp;</em> {USER.pass_empty_note}
</div>
<!-- END: pass_empty_note -->
<!-- BEGIN: question_empty_note -->
<div class="alert alert-danger">
    <em class="fa fa-exclamation-triangle ">&nbsp;</em> {USER.question_empty_note}
</div>
<!-- END: question_empty_note -->
            <!-- Detailed Information Cards -->
            <div class="row g-4 mb-4">
                <!-- Personal Information -->
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-primary text-white">
                            <h6 class="card-title mb-0">
                                <i class="fa fa-id-card me-2"></i>Thông tin cá nhân
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-signature text-primary me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.name}:</small>
                                    </div>
                                    <div class="fw-bold">{USER.full_name}</div>
                                </div>
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-birthday-cake text-warning me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.birthday}:</small>
                                    </div>
                                    <div class="fw-bold">{USER.birthday}</div>
                                </div>
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-venus-mars text-info me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.gender}:</small>
                                    </div>
                                    <span class="badge bg-light text-dark border">
                                        <i class="fa fa-{USER.gender == 'Nam' ? 'mars' : (USER.gender == 'Nữ' ? 'venus' : 'genderless')} me-1"></i>
                                        {USER.gender}
                                    </span>
                                </div>
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-envelope text-success me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.showmail}:</small>
                                    </div>
                                    <div class="fw-bold">{USER.view_mail}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Account Information -->
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-success text-white">
                            <h6 class="card-title mb-0">
                                <i class="fa fa-user-cog me-2"></i>Thông tin tài khoản
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-calendar-plus text-primary me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.regdate}:</small>
                                    </div>
                                    <div class="fw-bold">{USER.regdate}</div>
                                </div>
                                <!-- BEGIN: langinterface -->
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-language text-info me-2"></i>
                                        <small class="text-muted fw-semibold">{GLANG.langinterface}:</small>
                                    </div>
                                    <span class="badge bg-info text-white">
                                        <i class="fa fa-globe me-1"></i>{USER.langinterface}
                                    </span>
                                </div>
                                <!-- END: langinterface -->
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-chart-line text-warning me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.st_login2}:</small>
                                    </div>
                                    <div class="fw-bold">{USER.st_login}</div>
                                </div>
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-desktop text-secondary me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.login_name}:</small>
                                    </div>
                                    <div class="fw-bold font-monospace">{USER.login_name}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Security & Additional Info -->
            <div class="row g-4 mb-4">
                <!-- Security Settings -->
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-warning text-dark">
                            <h6 class="card-title mb-0">
                                <i class="fa fa-shield-alt me-2"></i>Bảo mật
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="d-flex align-items-center justify-content-between mb-2">
                                        <div class="d-flex align-items-center">
                                            <i class="fa fa-lock text-warning me-2"></i>
                                            <small class="text-muted fw-semibold">{LANG.2step_status}:</small>
                                        </div>
                                        <a href="{URL_2STEP}" class="btn btn-outline-warning btn-sm">
                                            <i class="fa fa-cog me-1"></i>{LANG.2step_link}
                                        </a>
                                    </div>
                                    <div class="fw-bold">{USER.active2step}</div>
                                </div>
                                <div class="col-12">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-history text-info me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.last_login}:</small>
                                    </div>
                                    <div class="fw-bold">{USER.last_login}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Group Management -->
                <!-- BEGIN: group_manage -->
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm h-100">
                        <div class="card-header bg-info text-white">
                            <h6 class="card-title mb-0">
                                <i class="fa fa-users me-2"></i>Quản lý nhóm
                            </h6>
                        </div>
                        <div class="card-body">
                            <div class="d-flex align-items-center justify-content-between">
                                <div>
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-users-cog text-info me-2"></i>
                                        <small class="text-muted fw-semibold">{LANG.group_manage_count}:</small>
                                    </div>
                                    <div class="fw-bold fs-4 text-primary">{USER.group_manage}</div>
                                </div>
                                <a href="{URL_GROUPS}" class="btn btn-outline-info" title="{LANG.group_manage_list}">
                                    <i class="fa fa-list me-1"></i>Xem danh sách
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- END: group_manage -->
            </div>

            <!-- Custom Fields -->
            <!-- BEGIN: field -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-secondary text-white">
                    <h6 class="card-title mb-0">
                        <i class="fa fa-list-alt me-2"></i>Thông tin bổ sung
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <!-- BEGIN: loop -->
                        <div class="col-md-6">
                            <div class="d-flex align-items-center mb-2">
                                <i class="fa fa-tag text-secondary me-2"></i>
                                <small class="text-muted fw-semibold">{FIELD.title}:</small>
                            </div>
                            <div class="fw-bold">{FIELD.value}</div>
                        </div>
                        <!-- END: loop -->
                    </div>
                </div>
            </div>
            <!-- END: field -->

            <!-- Navigation Links -->
            <div class="card border-0 bg-light">
                <div class="card-body">
                    <h6 class="card-title text-muted mb-3">
                        <i class="fa fa-link me-2"></i>Liên kết nhanh
                    </h6>
                    <div class="d-flex flex-wrap gap-2">
                        <!-- BEGIN: navbar -->
                        <a href="{NAVBAR.href}" class="btn btn-outline-primary btn-sm">
                            <i class="fa fa-caret-right me-1"></i>{NAVBAR.title}
                        </a>
                        <!-- END: navbar -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->
