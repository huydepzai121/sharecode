<!-- BEGIN: config -->
<div id="config_slide_box">
    <div class="row mb-3">
        <label for="element_title" class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium" title="Tên block">Link video:</label>
        <div class="col-sm-9">
            <div class="input-group">
                <input class="form-control" type="text" name="config_image" value="{IMAGE}" placeholder="Link Video" id="link_video" /> <span class="input-group-btn">
                    <button class="btn btn-default" onclick="nv_selectfile($(this)); return !1;" data-currentpath="{IMAGE.currentpath}" type="button">
                        <em class="fa fa-folder-open-o fa-fix">&nbsp;</em>
                    </button>
                </span>
            </div>
        </div>
    </div>
</div>

<script>
    function nv_selectfile($this)
    {
        var area = "link_video";
        var path = "{NV_UPLOADS_DIR}";
        var currentpath = $this.data('currentpath');
        var type = "image";
        nv_open_browse(script_name + "?" + nv_name_variable
            + "=upload&popup=1&area=" + area + "&path="
            + path + "&type=" + type + "&currentpath="
            + currentpath, "NVImg", 850, 420,
            "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
    }
</script>
<!-- END: config -->
