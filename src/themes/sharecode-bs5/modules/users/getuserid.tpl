<!-- BEGIN: main -->
<div id="getuidcontent">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="card-title mb-0">
                <i class="fa fa-search me-2"></i>Tìm kiếm người dùng
            </h5>
        </div>
        <div class="card-body">
            <form id="formgetuid" method="get" action="{FORM_ACTION}">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-id-card text-primary me-2"></i>{LANG.user_id}
                        </label>
                        <input class="form-control" type="text" name="user_id" value="" maxlength="100" placeholder="Nhập ID người dùng" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-user text-success me-2"></i>{LANG.username}
                        </label>
                        <input class="form-control" type="text" name="username" value="" maxlength="100" placeholder="Nhập tên đăng nhập" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-user-circle text-info me-2"></i>{LANG.fullname}
                        </label>
                        <input class="form-control" type="text" name="full_name" value="" maxlength="100" placeholder="Nhập họ tên" />
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">
                            <i class="fa fa-envelope text-warning me-2"></i>{LANG.email}
                        </label>
                        <input class="form-control" type="text" name="email" value="" maxlength="100" placeholder="Nhập email" />
                    </div>
                </div>
                <div class="text-center mt-4">
                    <div class="btn-group" role="group">
                        <button type="reset" class="btn btn-outline-secondary">
                            <i class="fa fa-undo me-2"></i>{LANG.reset}
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-search me-2"></i>{LANG.search}
                        </button>
                    </div>
                    <input type="hidden" name="fsubmit" value="1" />
                </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript">
    $("#formgetuid").submit(function() {
        var a = $(this).attr("action");
        b = $(this).serialize();
        a = a + "&" + b + "&fsubmit";
        $("#formgetuid input, #formgetuid select").attr("disabled", "disabled");
        $.ajax({
            type: "GET",
            url: a,
            success: function(c) {
                $("#resultdata").html(c);
                $("#formgetuid input, #formgetuid select").removeAttr("disabled");
            }
        });
        return !1;
    });
</script>
<div id="resultdata">&nbsp;</div>
<!--  END: main  -->

<!-- BEGIN: resultdata -->
<!-- BEGIN: data -->
<div class="card border-0 shadow-sm mt-4">
    <div class="card-header bg-success text-white">
        <h5 class="card-title mb-0">
            <i class="fa fa-list me-2"></i>Kết quả tìm kiếm
        </h5>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th class="border-0" style="width: 80px">
                            <i class="fa fa-id-card text-primary me-2"></i>ID
                        </th>
                        <th class="border-0">
                            <i class="fa fa-user text-success me-2"></i>{LANG.username}
                        </th>
                        <th class="border-0">
                            <i class="fa fa-envelope text-warning me-2"></i>{LANG.email}
                        </th>
                        <th class="border-0" style="width: 150px">
                            <i class="fa fa-calendar text-info me-2"></i>{LANG.regdate}
                        </th>
                        <th class="text-center border-0" style="width: 120px">
                            <i class="fa fa-cogs text-secondary me-2"></i>Thao tác
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: row -->
                    <tr class="border-bottom">
                        <td class="fw-bold text-primary">{ROW.userid}</td>
                        <td>
                            <div class="d-flex align-items-center">
                                <i class="fa fa-user-circle text-muted me-2"></i>
                                <span class="fw-semibold">{ROW.username}</span>
                            </div>
                        </td>
                        <td class="text-muted">{ROW.email}</td>
                        <td class="text-muted small">{ROW.regdate}</td>
                        <td class="text-center">
                            <button class="btn btn-outline-primary btn-sm" data-toggle="nv_active" data-userid="{ROW.userid}" title="{LANG.active}">
                                <i class="fa fa-check me-1"></i>Kích hoạt
                            </button>
                        </td>
                    </tr>
                    <!-- END: row -->
                </tbody>
            </table>
        </div>
    </div>
    <!-- BEGIN: generate_page -->
    <div class="card-footer bg-light text-center border-0">
        {GENERATE_PAGE}
    </div>
    <!-- END: generate_page -->
</div>
<script>
$(function() {
    $('[data-toggle=nv_active][data-userid]').on('click', function() {
        $.ajax({
            type: "POST",
            url : "{FORM_ACTION}",
            data: "act=1&userid=" + $(this).data('userid'),
            success: function(a) {
                if (a == "OK") {
                    alert('{LANG.actived_users}');
                    modalHide();
                    location.reload();
                } else {
                    alert('{LANG.not_active}');
                }
            }
        });
    })
})
</script>
<!-- END: data -->
<!-- BEGIN: nodata -->
<div class="table-responsive">
    <table class="table table-striped table-bordered table-hover">
        <tbody>
            <tr>
                <td class="text-center">{LANG.noresult}</td>
            </tr>
        </tbody>
    </table>
</div>
<!-- END: nodata -->
<!-- END: resultdata -->
