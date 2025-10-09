<!-- BEGIN: main -->
<div class="container-fluid p-0" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh;">
    <div class="row g-0 h-100">
        <div class="col-12">
            <div class="card border-0 shadow-lg m-3">
                <div class="card-header bg-primary text-white">
                    <h4 class="card-title mb-0">
                        <i class="fa fa-image me-2"></i>{LANG.change_avatar}
                    </h4>
                </div>
                <div class="card-body p-4">
                    <form id="upload-form" method="post" enctype="multipart/form-data" action="{NV_AVATAR_UPLOAD}">
                        <div class="row">
                            <!-- Upload Area -->
                            <div class="col-lg-8 mb-4">
                                <div class="upload-area">
                                    <div class="upload-zone border-2 border-dashed border-primary rounded-3 p-5 text-center position-relative" style="min-height: 400px; background: linear-gradient(45deg, #f8f9fa 25%, transparent 25%), linear-gradient(-45deg, #f8f9fa 25%, transparent 25%), linear-gradient(45deg, transparent 75%, #f8f9fa 75%), linear-gradient(-45deg, transparent 75%, #f8f9fa 75%); background-size: 20px 20px; background-position: 0 0, 0 10px, 10px -10px, -10px 0px;">
                                        <div title="{LANG.avatar_select_img}" id="upload_icon" class="upload-button position-absolute top-50 start-50 translate-middle">
                                            <div class="text-center">
                                                <div class="mb-3">
                                                    <i class="fa fa-cloud-upload-alt fa-4x text-primary"></i>
                                                </div>
                                                <h5 class="text-primary fw-bold">{LANG.avatar_select_img}</h5>
                                                <p class="text-muted">Kéo thả hoặc click để chọn ảnh</p>
                                                <button type="button" class="btn btn-primary">
                                                    <i class="fa fa-upload me-2"></i>Chọn ảnh
                                                </button>
                                            </div>
                                        </div>
                                        <div class="img-area position-absolute top-0 start-0 w-100 h-100">
                                            <img id="preview" class="img-fluid rounded-3 shadow" style="display: none; max-width: 100%; max-height: 100%; object-fit: contain;"/>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Info Panel -->
                            <div class="col-lg-4">
                                <div class="info-panel">
                                    <!-- Guide -->
                                    <div class="guide card border-0 bg-light mb-4" id="guide">
                                        <div class="card-body">
                                            <h6 class="card-title text-primary">
                                                <i class="fa fa-info-circle me-2"></i>{LANG.avatar_guide}:
                                            </h6>
                                            <ul class="list-unstyled mb-0">
                                                <li class="mb-2">
                                                    <i class="fa fa-check text-success me-2"></i>{LANG.avatar_chosen}
                                                </li>
                                                <li>
                                                    <i class="fa fa-check text-success me-2"></i>{LANG.avatar_upload}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>

                                    <!-- Upload Info -->
                                    <div class="upload-info card border-0 bg-info text-white d-none" id="uploadInfo">
                                        <div class="card-body">
                                            <h6 class="card-title">
                                                <i class="fa fa-info-circle me-2"></i>Thông tin ảnh
                                            </h6>
                                            <div class="info-list">
                                                <div class="mb-2">
                                                    <strong>{LANG.avatar_filesize}:</strong> <span id="image-size" class="badge bg-light text-dark"></span>
                                                </div>
                                                <div class="mb-2">
                                                    <strong>{LANG.avatar_ftype}:</strong> <span id="image-type" class="badge bg-light text-dark"></span>
                                                </div>
                                                <div class="mb-2">
                                                    <strong>{LANG.avatar_filedimension}:</strong> <span id="original-dimension" class="badge bg-light text-dark"></span>
                                                </div>
                                                <div class="mb-3">
                                                    <strong>{LANG.avatar_displaydimension}:</strong> <span id="display-dimension" class="badge bg-light text-dark"></span>
                                                </div>
                                                <div class="d-grid gap-2">
                                                    <button id="btn-submit" type="submit" class="btn btn-success">
                                                        <i class="fa fa-crop me-2"></i>{LANG.avatar_crop}
                                                    </button>
                                                    <button id="btn-reset" type="button" class="btn btn-outline-light">
                                                        <i class="fa fa-redo me-2"></i>{LANG.avatar_chosen_other}
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Cancel Button -->
                                    <div class="text-center mt-4">
                                        <button type="button" class="btn btn-outline-secondary" data-toggle="winCMD" data-cmd="close">
                                            <i class="fa fa-times me-2"></i>{GLANG.cancel}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Hidden Fields -->
                        <input type="hidden" name="client" value="{DATA.client}">
                        <input type="hidden" id="crop_x" name="crop_x"/>
                        <input type="hidden" id="crop_y" name="crop_y"/>
                        <input type="hidden" id="crop_width" name="crop_width"/>
                        <input type="hidden" id="crop_height" name="crop_height"/>
                        <input type="file" name="image_file" id="image_file" class="d-none" accept="image/*"/>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function() {
        <!-- BEGIN: complete -->
        $(window).on("beforeunload", function() {
            $("#avatar", opener.document).val('{FILENAME}')
        });
        window.close();
        <!-- END: complete -->
        <!-- BEGIN: complete2 -->
        $(window).on("beforeunload", function() {
            if ('{DATA.client}' != '') {
                window.opener.postMessage('nv.reload', '{DATA.client}');
            } else {
                window.opener.location.reload();
            }
        });
        window.close();
        <!-- END: complete2 -->
        <!-- BEGIN: complete3 -->
        $(window).on("beforeunload", function() {
            $("#myavatar", opener.document).attr('src', '{FILENAME}');
            $("#delavatar", opener.document).prop("disabled",!1)
        });
        window.close();
        <!-- END: complete3 -->
        <!-- BEGIN: init -->
        getFiles(['{ASSETS_STATIC_URL}/js/cropper/cropper.min.css','{ASSETS_STATIC_URL}/js/cropper/cropper.min.js','{NV_STATIC_URL}themes/{TEMPLATE}/js/avatar.js'], function(){
            UAV.config.maxsize = {NV_UPLOAD_MAX_FILESIZE};
            UAV.config.avatar_width = {NV_AVATAR_WIDTH};
            UAV.config.avatar_height = {NV_AVATAR_HEIGHT};
            UAV.lang.bigsize = '{LANG.avatar_bigsize}';
            UAV.lang.smallsize = '{LANG.avatar_smallsize}';
            UAV.lang.filetype = '{LANG.avatar_filetype}';
            UAV.lang.bigfile = '{LANG.avatar_bigfile}';
            UAV.lang.upload = '{LANG.avatar_upload}';
            UAV.init()
        });
        <!-- END: init -->
        <!-- BEGIN: error -->alert('{ERROR}');<!-- END: error -->
    });
</script>
<!-- END: main -->
