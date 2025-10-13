<!-- BEGIN: main -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<div class="main-site clearfix">
    <div class="row1">
        [HEADER]
    </div>

    <div class="aos-init">
        <div class="row1">
            <!-- <div class="col-md-12"> -->
                [TOP]
                {MODULE_CONTENT}
                [BOTTOM]
            <!-- </div> -->
        </div>
    </div>

    <div class="row1">
        [FOOTER]
    </div>
</div>
{FILE "footer_extended.tpl"}
{FILE "footer_only.tpl"}
<!-- END: main -->
