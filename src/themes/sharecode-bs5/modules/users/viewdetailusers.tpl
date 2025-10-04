<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Header -->
            <div class="d-flex align-items-center mb-4">
                <div class="me-3">
                    <i class="fa fa-user-circle fa-2x text-primary"></i>
                </div>
                <div>
                    <h2 class="mb-0 fw-bold">{LANG.user_info}</h2>
                    <p class="text-muted mb-0">Thông tin chi tiết thành viên</p>
                </div>
            </div>

            <!-- User Profile Card -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body">
                    <div class="row">
                        <!-- Avatar Section -->
                        <div class="col-md-3 text-center mb-4 mb-md-0">
                            <div class="position-relative d-inline-block">
                                <img src="{SRC_IMG}" alt="{USER.username}" title="{USER.username}"
                                     class="img-fluid rounded-circle shadow border border-3 border-white"
                                     style="width: 120px; height: 120px; object-fit: cover;" />
                                <div class="position-absolute bottom-0 end-0">
                                    <span class="badge bg-success rounded-pill p-2">
                                        <i class="fa fa-check"></i>
                                    </span>
                                </div>
                            </div>
                            <h4 class="mt-3 mb-1 fw-bold text-primary">{USER.username}</h4>
                            <!-- BEGIN: viewemail -->
                            <p class="text-muted small mb-0">
                                <i class="fa fa-envelope me-1"></i>{USER.email}
                            </p>
                            <!-- END: viewemail -->
                        </div>

                        <!-- User Info Section -->
                        <div class="col-md-9">
                            <div class="row">
                                <div class="col-sm-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <div class="icon-box bg-primary bg-opacity-10 text-primary rounded-circle p-2 me-3">
                                            <i class="fa fa-user"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 text-muted">{LANG.account2}</h6>
                                            <p class="mb-0 fw-semibold">{USER.username}</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 mb-3">
                                    <div class="d-flex align-items-center">
                                        <div class="icon-box bg-success bg-opacity-10 text-success rounded-circle p-2 me-3">
                                            <i class="fa fa-clock"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 text-muted">{LANG.last_login}</h6>
                                            <p class="mb-0 fw-semibold">{USER.last_login}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Admin Actions -->
                            <!-- BEGIN: for_admin -->
                            <div class="mt-4 pt-3 border-top">
                                <h6 class="text-muted mb-3">
                                    <i class="fa fa-cogs me-2"></i>Hành động quản trị
                                </h6>
                                <div class="d-flex gap-2">
                                    <!-- BEGIN: edit -->
                                    <a href="{USER.link_edit}" class="btn btn-outline-primary btn-sm">
                                        <i class="fa fa-edit me-1"></i>{GLANG.edit}
                                    </a>
                                    <!-- END: edit -->
                                    <!-- BEGIN: delete -->
                                    <a href="#" class="btn btn-outline-danger btn-sm" data-toggle="admindeluser" data-userid="{USER.userid}" data-link="{USER.link_delete}" data-back="{USER.link_delete_callback}">
                                        <i class="fa fa-trash me-1"></i>{GLANG.delete}
                                    </a>
                                    <!-- END: delete -->
                                </div>
                            </div>
                            <!-- END: for_admin -->
                        </div>
                    </div>
                </div>
            </div>

            <!-- Detailed Information -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-light">
                    <h5 class="card-title mb-0">
                        <i class="fa fa-info-circle me-2 text-primary"></i>Thông tin chi tiết
                    </h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <tbody>
                                <tr>
                                    <td class="fw-semibold text-muted border-0 py-3" style="width: 30%;">
                                        <i class="fa fa-id-card me-2 text-primary"></i>{LANG.name}
                                    </td>
                                    <td class="border-0 py-3">
                                        <span class="fw-semibold">{USER.full_name}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-semibold text-muted border-0 py-3">
                                        <i class="fa fa-birthday-cake me-2 text-warning"></i>{LANG.birthday}
                                    </td>
                                    <td class="border-0 py-3">
                                        <span class="fw-semibold">{USER.birthday}</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-semibold text-muted border-0 py-3">
                                        <i class="fa fa-venus-mars me-2 text-info"></i>{LANG.gender}
                                    </td>
                                    <td class="border-0 py-3">
                                        <span class="badge bg-light text-dark border">
                                            <i class="fa fa-{USER.gender == 'Nam' ? 'mars' : (USER.gender == 'Nữ' ? 'venus' : 'genderless')} me-1"></i>
                                            {USER.gender}
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fw-semibold text-muted border-0 py-3">
                                        <i class="fa fa-calendar-plus me-2 text-success"></i>{LANG.regdate}
                                    </td>
                                    <td class="border-0 py-3">
                                        <span class="fw-semibold">{USER.regdate}</span>
                                    </td>
                                </tr>
                                <!-- BEGIN: field -->
                                <!-- BEGIN: loop -->
                                <tr>
                                    <td class="fw-semibold text-muted border-0 py-3">
                                        <i class="fa fa-tag me-2 text-secondary"></i>{FIELD.title}
                                    </td>
                                    <td class="border-0 py-3">
                                        <span class="fw-semibold">{FIELD.value}</span>
                                    </td>
                                </tr>
                                <!-- END: loop -->
                                <!-- END: field -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: main -->