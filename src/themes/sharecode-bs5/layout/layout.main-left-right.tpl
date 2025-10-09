<!-- BEGIN: main -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<div class="row">
    [HEADER]
</div>
<div class="row">
    <div class="col-sm-12 col-md-8 order-md-2">
        [TOP]
        {MODULE_CONTENT}
        [BOTTOM]
    </div>
    <div class="col-sm-6 col-md-2 order-md-3">
        [RIGHT]
    </div>
    <div class="col-sm-6 col-md-2 order-md-1">
        [LEFT]
    </div>
</div>
<div class="row">
    [FOOTER]
</div>
{FILE "footer_extended.tpl"}
{FILE "footer_only.tpl"}
<!-- END: main -->