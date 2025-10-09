<!-- BEGIN: main -->
{FILE "header_only.tpl"}
{FILE "header_extended.tpl"}
<div class="row">
    <div class="col-12">
        [HEADER]
    </div>
</div>
<div class="row">
    <div class="col-sm-12 col-md-8">
        [TOP]
        {MODULE_CONTENT}
        [BOTTOM]
    </div>
    <div class="col-sm-12 col-md-4">
        [RIGHT]
    </div>
</div>
<div class="row">
    [FOOTER]
</div>
{FILE "footer_extended.tpl"}
{FILE "footer_only.tpl"}
<!-- END: main -->