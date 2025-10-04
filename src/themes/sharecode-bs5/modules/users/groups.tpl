<!-- BEGIN: main -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Header -->
            <div class="d-flex align-items-center mb-4">
                <div class="me-3">
                    <i class="fa fa-users fa-2x text-primary"></i>
                </div>
                <div>
                    <h2 class="mb-0 fw-bold">{LANG.group_manage}</h2>
                    <p class="text-muted mb-0">Quản lý nhóm thành viên</p>
                </div>
            </div>

            <div id="pageContent"></div>

            <div class="mt-4">
                <ul class="nav nav-pills flex-column flex-sm-row">
                    <!-- BEGIN: navbar --><li class="nav-item"><a class="nav-link" href="{NAVBAR.href}"><i class="fa fa-caret-right me-2"></i>{NAVBAR.title}</a></li><!-- END: navbar -->
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    $(function() {
        $("div#pageContent").load("{MODULE_URL}={OP}&list&random=" + nv_randomPassword(10))
    })
</script>
<!-- END: main -->

<!-- BEGIN: list -->
<div class="card border-0 shadow-sm">
    <div class="card-header bg-primary text-white">
        <h5 class="card-title mb-0">
            <i class="fa fa-list me-2"></i>Danh sách nhóm
        </h5>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="border-0 fw-bold">
                            <i class="fa fa-tag me-2"></i>{LANG.title}
                        </th>
                        <th class="text-center border-0 fw-bold">
                            <i class="fa fa-calendar-plus me-2"></i>{LANG.add_time}
                        </th>
                        <th class="text-center border-0 fw-bold">
                            <i class="fa fa-calendar-times me-2"></i>{LANG.exp_time}
                        </th>
                        <th class="text-center border-0 fw-bold">
                            <i class="fa fa-users me-2"></i>{LANG.users}
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: loop -->
                    <tr class="border-bottom">
                        <td>
                            <a title="{LANG.users}" href="{LOOP.link_userlist}" class="text-decoration-none fw-semibold text-primary">
                                <i class="fa fa-users me-2"></i>{LOOP.title}
                            </a>
                        </td>
                        <td class="text-center text-muted">{LOOP.add_time}</td>
                        <td class="text-center text-muted">{LOOP.exp_time}</td>
                        <td class="text-center">
                            <span class="badge bg-primary rounded-pill">{LOOP.number}</span>
                        </td>
                    </tr>
                    <!-- END: loop -->
                </tbody>
            </table>
        </div>
    </div>
</div>
<!-- END: list -->

<!-- BEGIN: listUsers -->
<!-- BEGIN: pending -->
<div id="id_pending" class="mb-4">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-warning text-dark">
            <h5 class="card-title mb-0">
                <i class="fa fa-clock me-2"></i>{PTITLE}
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center border-0" style="width: 60px">{LANG.STT}</th>
                            <th class="border-0">{LANG.account} ({LANG.nametitle})</th>
                            <th class="text-center border-0" style="width: 150px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: loop -->
                        <tr class="border-bottom">
                            <td class="text-center fw-bold text-muted">{LOOP.stt}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <i class="fa fa-user-circle text-muted me-2"></i>
                                    <div>
                                        <div class="fw-semibold">{LOOP.username}</div>
                                        <small class="text-muted">({LOOP.full_name})</small>
                                    </div>
                                </div>
                            </td>
                            <td class="text-center">
                                <!-- BEGIN: tools -->
                                <div class="btn-group" role="group">
                                    <button class="approved btn btn-success btn-sm" title="{LANG.approved}" data-id="{LOOP.userid}">
                                        <i class="fa fa-check me-1"></i>Duyệt
                                    </button>
                                    <button class="denied btn btn-outline-danger btn-sm" title="{LANG.denied}" data-id="{LOOP.userid}">
                                        <i class="fa fa-times me-1"></i>Từ chối
                                    </button>
                                </div>
                                <!-- END: tools -->
                            </td>
                        </tr>
                        <!-- END: loop -->
                    </tbody>
                </table>
            </div>
        </div>
        <!-- BEGIN: page -->
        <div class="card-footer bg-light text-center border-0">{PAGE}</div>
        <!-- END: page -->
    </div>
</div>
<script>
    $(".approved").click(function() {
        confirm(nv_is_add_user_confirm[0]) && $.ajax({
            type: "POST",
            url : "{MODULE_URL}={OP}",
            data : "gid={GID}&approved=" + $(this).data("id"),
            success: function(a) {
                a == "OK" ? $("div#pageContent").load("{MODULE_URL}={OP}&listUsers={GID}&random=" + nv_randomPassword(10)) : alert(a);
            }
        });
        return !1;
    });
    $(".denied").click(function() {
        confirm(nv_is_exclude_user_confirm[0]) && $.ajax({
            type: "POST",
            url : "{MODULE_URL}={OP}",
            data : "gid={GID}&denied=" + $(this).data("id"),
            success: function(a) {
                a == "OK" ? $("div#pageContent").load("{MODULE_URL}={OP}&listUsers={GID}&random=" + nv_randomPassword(10)) : alert(a);
            }
        });
        return !1;
    });
</script>
<!-- END: pending -->

<!-- BEGIN: leaders -->
<div id="id_leaders" class="mb-4">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-success text-white">
            <h5 class="card-title mb-0">
                <i class="fa fa-crown me-2"></i>{PTITLE}
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center border-0" style="width: 60px">{LANG.STT}</th>
                            <th class="border-0">{LANG.account} ({LANG.nametitle})</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: loop -->
                        <tr class="border-bottom">
                            <td class="text-center fw-bold text-muted">{LOOP.stt}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <i class="fa fa-user-tie text-success me-2"></i>
                                    <div>
                                        <div class="fw-semibold">{LOOP.username}</div>
                                        <small class="text-muted">({LOOP.full_name})</small>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <!-- END: loop -->
                    </tbody>
                </table>
            </div>
        </div>
        <!-- BEGIN: page -->
        <div class="card-footer bg-light text-center border-0">{PAGE}</div>
        <!-- END: page -->
    </div>
</div>
<!-- END: leaders -->

<!-- BEGIN: members -->
<div id="id_members" class="mb-4">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-info text-white">
            <h5 class="card-title mb-0">
                <i class="fa fa-users me-2"></i>{PTITLE}
            </h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="text-center border-0" style="width: 60px">{LANG.STT}</th>
                            <th class="border-0">{LANG.account} ({LANG.nametitle})</th>
                            <th class="text-center border-0" style="width: 200px">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- BEGIN: loop -->
                        <tr class="border-bottom">
                            <td class="text-center fw-bold text-muted">{LOOP.stt}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <i class="fa fa-user text-info me-2"></i>
                                    <div>
                                        <div class="fw-semibold">{LOOP.username}</div>
                                        <small class="text-muted">({LOOP.full_name})</small>
                                    </div>
                                </div>
                            </td>
                            <td class="text-center">
                                <!-- BEGIN: tools -->
                                <div class="btn-group" role="group">
                                    <!-- BEGIN: edituser -->
                                    <a href="{LINK_EDIT}" class="edituser btn btn-outline-primary btn-sm" title="{GLANG.edit}">
                                        <i class="fa fa-edit me-1"></i>Sửa
                                    </a>
                                    <!-- END: edituser -->
                                    <!-- BEGIN: deletemember -->
                                    <button class="deletemember btn btn-outline-warning btn-sm" title="{LANG.exclude_user2}" data-userid="{LOOP.userid}">
                                        <i class="fa fa-user-minus me-1"></i>Loại
                                    </button>
                                    <!-- END: deletemember -->
                                    <!-- BEGIN: deluser -->
                                    <button class="deluser btn btn-outline-danger btn-sm" title="{GLANG.delete}" data-userid="{LOOP.userid}">
                                        <i class="fa fa-trash me-1"></i>Xóa
                                    </button>
                                    <!-- END: deluser -->
                                </div>
                                <!-- END: tools -->
                            </td>
                        </tr>
                        <!-- END: loop -->
                    </tbody>
                </table>
            </div>
        </div>
        <!-- BEGIN: page -->
        <div class="card-footer bg-light text-center border-0">{PAGE}</div>
        <!-- END: page -->
    </div>
</div>
<script>
    $(".deluser").click(function() {
        confirm("{LANG.delConfirm} ?") && $.ajax({
        type: "POST",
        url : "{MODULE_URL}={OP}",
        data : "gid={GID}&del=" + $(this).attr("data-userid"),
        success: function(a) {
            a == "OK" ? $("div#pageContent").load("{MODULE_URL}={OP}&listUsers={GID}&random=" + nv_randomPassword(10)) : alert(a);
        }
    });
    return !1;
    });
    $(".deletemember").click(function() {
        confirm("{LANG.excludeUserConfirm} ?") && $.ajax({
        type: "POST",
        url : "{MODULE_URL}={OP}",
        data : "gid={GID}&exclude=" + $(this).attr("data-userid"),
        success: function(a) {
            a == "OK" ? $("div#pageContent").load("{MODULE_URL}={OP}&listUsers={GID}&random=" + nv_randomPassword(10)) : alert(a);
        }
    });
    return !1;
    });
</script>
<!-- END: members -->
<!-- END: listUsers -->

<!-- BEGIN: userlist -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Header -->
            <div class="d-flex align-items-center mb-4">
                <div class="me-3">
                    <i class="fa fa-users fa-2x text-primary"></i>
                </div>
                <div>
                    <h2 class="mb-0 fw-bold">{LANG.group_manage}</h2>
                    <p class="text-muted mb-0">Quản lý thành viên nhóm</p>
                </div>
            </div>

            <!-- BEGIN: tools -->
            <link rel="stylesheet" href="{ASSETS_STATIC_URL}/js/select2/select2.min.css">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-8 mb-3 mb-md-0">
                            <!-- BEGIN: addUserGroup -->
                            <div class="d-flex gap-2">
                                <select name="uid" id="uid" class="form-select" style="min-width: 250px"></select>
                                <button class="btn btn-primary" name="addUser" type="button" title="{LANG.addMemberToGroup}">
                                    <i class="fa fa-plus me-1"></i>Thêm
                                </button>
                            </div>
                            <!-- END: addUserGroup -->
                        </div>
                        <div class="col-md-4 text-end">
                            <div class="btn-group" role="group">
                                <a href="{EDIT_GROUP_URL}" class="btn btn-outline-primary btn-sm" title="{GLANG.edit}">
                                    <i class="fa fa-edit me-1"></i>Sửa
                                </a>
                                <!-- BEGIN: inform_notifications -->
                                <a href="{INFORM_NOTIFICATIONS_URL}" class="btn btn-outline-info btn-sm" title="{GLANG.inform_notifications}">
                                    <i class="fa fa-bell me-1"></i>Thông báo
                                </a>
                                <!-- END: inform_notifications -->
                                <!-- BEGIN: add_user -->
                                <a href="{MODULE_URL}=register/{GID}" class="btn btn-outline-success btn-sm" title="{LANG.addusers}">
                                    <i class="fa fa-user-plus me-1"></i>Đăng ký
                                </a>
                                <!-- END: add_user -->
                                <!-- BEGIN: user_waiting -->
                                <button class="btn btn-outline-warning btn-sm" name="user_waiting" type="button" title="{LANG.user_waiting}">
                                    <i class="fa fa-clock me-1"></i>Chờ duyệt
                                </button>
                                <!-- END: user_waiting -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<script src="{ASSETS_STATIC_URL}/js/select2/select2.min.js"></script>
<script src="{ASSETS_LANG_STATIC_URL}/js/select2/i18n/{NV_LANG_INTERFACE}.js"></script>
<script>
    $(document).ready(function() {
        $("#uid").select2({
            placeholder: "{LANG.addMemberToGroup}",
            ajax: {
                url: script_name + '?' + nv_name_variable + '=' + nv_module_name + '&' + nv_fc_variable + '=groups&get_user_json=1&gid={GID}',
                dataType: 'json',
                delay: 250,
                data: function(params) {
                    return {
                        q: params.term, // search term
                        page: params.page
                    };
                },
                processResults: function(data, params) {
                    params.page = params.page || 1;
                    return {
                        results: data,
                        pagination: {
                            more: (params.page * 30) < data.total_count
                        }
                    };
                },
                cache: true
            },
            escapeMarkup: function(markup) { return markup; }, // let our custom formatter work
            minimumInputLength: 3,
            templateResult: formatRepo, // omitted for brevity, see the source of this page
            templateSelection: formatRepoSelection, // omitted for brevity, see the source of this page
            language: {
                inputTooShort: function(args) {
                    // args.minimum is the minimum required length
                    // args.input is the user-typed text
                    return "{MIN_SEARCH}";
                }
            }
        });
    });

    function formatRepo(repo) {
        if (repo.loading) return repo.text;
        return '<div>' + repo.username + '<br/>(' + repo.fullname + ')</div>';
    }

    function formatRepoSelection(repo) {
        return repo.username || repo.text;
    }
</script>
            <!-- END: tools -->

            <!-- Group Information Card -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-body">
                    <div class="row">
                        <div class="col-auto">
                            <img title="{DATA.title}" alt="{DATA.title}" src="{ASSETS_STATIC_URL}/images/pix.svg"
                                 width="80" height="80" class="rounded-circle border border-2 border-primary"
                                 style="background-image:url({DATA.group_avatar});background-repeat:no-repeat;background-size:cover;object-fit:cover;" />
                        </div>
                        <div class="col">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-tag text-primary me-2"></i>
                                        <strong class="text-muted">{LANG.group_title}:</strong>
                                    </div>
                                    <div class="fw-bold">{DATA.title}
                                        <!-- BEGIN: group_desc -->
                                        <br><small class="text-muted">({DATA.description})</small>
                                        <!-- END: group_desc -->
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-cog text-success me-2"></i>
                                        <strong class="text-muted">{LANG.group_type}:</strong>
                                    </div>
                                    <div class="fw-bold">{DATA.group_type_mess}
                                        <!-- BEGIN: group_type_note -->
                                        <br><small class="text-muted">({DATA.group_type_note})</small>
                                        <!-- END: group_type_note -->
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-calendar text-warning me-2"></i>
                                        <strong class="text-muted">{LANG.group_exp_time}:</strong>
                                    </div>
                                    <div class="fw-bold">{DATA.exp}</div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fa fa-users text-info me-2"></i>
                                        <strong class="text-muted">{LANG.group_userr}:</strong>
                                    </div>
                                    <div class="fw-bold">
                                        <span class="badge bg-info rounded-pill fs-6">{DATA.numbers}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<!-- BEGIN: group_content -->
<div style="margin-bottom:20px">
    {DATA.content}
</div>
<!-- END: group_content -->
<div id="pageContent">&nbsp;</div>
<script>
    $(function() {
        $("div#pageContent").load("{MODULE_URL}={OP}&listUsers={GID}&random=" + nv_randomPassword(10));

        $("[name=addUser]").click(function() {
            var a = $("#ablist select[name=uid]").val(),
                a = intval(a);
            a == 0 && (a = "");
            $("#ablist select[name=uid]").val(a);
            if (a == "") {
                return alert("{LANG.choiceUserID}"), $("#ablist select[name=uid]").select2('open'), false;
            }
            $("#pageContent input, #pageContent select").attr("disabled", "disabled");
            $.ajax({
                type: "POST",
                url : "{MODULE_URL}={OP}",
                data : "gid={GID}&uid=" + a + "&rand=" + nv_randomPassword(10),
                success: function(a) {
                    a == "OK" ? ($("#ablist select[name=uid]").val("").trigger("change"), $("div#pageContent").load("{MODULE_URL}={OP}&listUsers={GID}&random=" + nv_randomPassword(10))) : alert(a);
                }
            });
            return !1;
        });
        $("button[name=user_waiting]").click(function() {
            $.ajax({
                type: "POST",
                url : "{MODULE_URL}={OP}",
                data : "gid={GID}&getuserid=1&rand=" + nv_randomPassword(10),
                success: function(a) {
                    modalShow('{LANG.user_waiting}', a);
                }
            });
        });
    });
</script>
<!-- END: userlist -->

<!-- BEGIN: editgroup -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Header -->
            <div class="d-flex align-items-center mb-4">
                <div class="me-3">
                    <i class="fa fa-edit fa-2x text-primary"></i>
                </div>
                <div>
                    <h2 class="mb-0 fw-bold">{LANG.group_edit}</h2>
                    <p class="text-muted mb-0">Chỉnh sửa thông tin nhóm</p>
                </div>
            </div>

            <div class="card border-0 shadow-sm">
                <div class="card-body">
                    <form action="{EDIT_GROUP_URL}" method="post" role="form" data-toggle="reg_validForm" autocomplete="off" novalidate>
                        <div class="nv-info alert alert-info d-none" data-default=""></div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="group_title" class="form-label fw-semibold">
                                        <i class="fa fa-tag text-primary me-2"></i>{LANG.group_title}
                                    </label>
                                    <input type="text" class="form-control required" placeholder="{LANG.group_title}"
                                           value="{DATA.title}" name="group_title" id="group_title" maxlength="240"
                                           data-toggle="validErrorHidden" data-event="keypress" data-mess="">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="group_desc" class="form-label fw-semibold">
                                        <i class="fa fa-info-circle text-info me-2"></i>{LANG.group_desc}
                                    </label>
                                    <input type="text" class="form-control" placeholder="{LANG.group_desc}"
                                           value="{DATA.description}" name="group_desc" id="group_desc" maxlength="240">
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-semibold">
                                <i class="fa fa-file-text text-success me-2"></i>{LANG.group_content}
                            </label>
                            <div class="border rounded p-3 bg-light">
                                {HTMLBODYTEXT}
                            </div>
                        </div>

                        <div class="text-center">
                            <input type="hidden" name="save" value="1" />
                            <button type="submit" class="btn btn-primary btn-lg px-5">
                                <i class="fa fa-save me-2"></i>{GLANG.save}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- END: editgroup -->

<!-- BEGIN: inform_notifications -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Header -->
            <div class="d-flex align-items-center justify-content-between mb-4">
                <div class="d-flex align-items-center">
                    <div class="me-3">
                        <i class="fa fa-bell fa-2x text-primary"></i>
                    </div>
                    <div>
                        <div class="text-muted small">{LANG.group}: <span class="fw-semibold">{GTITLE}</span></div>
                        <h2 class="mb-0 fw-bold">{GLANG.inform_notifications}</h2>
                    </div>
                </div>
                <div>
                    <a href="{GROUP_MANAGER_URL}" class="btn btn-outline-primary" title="{LANG.group_manage}">
                        <i class="fa fa-arrow-left me-2"></i>{LANG.group_manage}
                    </a>
                </div>
            </div>

            <div id="inform_notifications" data-ajax-url="{INFORM_MANAGER_URL}">
                <div class="text-center py-5">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Đang tải...</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
$(function() {
    var informObj = $('#inform_notifications');
    $.ajax({
        type: "GET",
        url: informObj.data('ajax-url'),
        success: function(a) {
            informObj.html(a)
        }
    });
})
</script>
<!-- END: inform_notifications -->
