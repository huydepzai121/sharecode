<!-- BEGIN: main -->
<div class="panel panel-primary">
    <div class="panel-body">
        <form action="{NV_BASE_SITEURL}index.php" method="get" role="form">
            <input type="hidden" name="{NV_LANG_VARIABLE}" value="{NV_LANG_DATA}" />
            <input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
            <input type="hidden" name="{NV_OP_VARIABLE}" value="main" />

            <div class="row">
                <div class="col-sm-12">
                    <input type="text" name="q" value="{SEARCH.q}" placeholder="Nhập từ khóa tìm kiếm..." class="form-control">
                </div>
                <!-- BEGIN: category_filter -->
                <div class="col-sm-8">
                    <select name="category" class="form-control">
                        <option value="0">Tất cả danh mục</option>
                        <!-- BEGIN: category -->
                        <option value="{CATEGORY.id}" {CATEGORY.selected}>{CATEGORY.title}</option>
                        <!-- END: category -->
                    </select>
                </div>
                <!-- END: category_filter -->

                <div class="col-sm-2">
                    <button type="submit" class="btn btn-success btn-block">
                        Tìm kiếm
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>


<!-- END: main -->