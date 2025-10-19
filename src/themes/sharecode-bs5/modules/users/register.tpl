<!-- BEGIN: main -->
<div class="row justify-content-center mt-4 mb-4">
    <div class="col-12 col-md-6 col-lg-5">
        <div class="card shadow bg-light">
            <div class="card-body">
                <h2 class="text-center mb-4">{LANG.register}</h2>
                {FILE "register_form.tpl"}
                <div class="text-center mt-4">
                    <ul class="users-menu nav flex-column">
                        <!-- BEGIN: navbar --><li class="nav-item"><a class="nav-link" href="{NAVBAR.href}"><i class="fa fa-caret-right me-2"></i>{NAVBAR.title}</a></li><!-- END: navbar -->
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- BEGIN: datepicker -->
<link type="text/css" href="{ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<script type="text/javascript" src="{ASSETS_STATIC_URL}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{ASSETS_LANG_STATIC_URL}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>
<!-- END: datepicker -->
<!-- END: main -->