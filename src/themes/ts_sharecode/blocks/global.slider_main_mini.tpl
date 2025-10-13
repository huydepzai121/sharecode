<!-- BEGIN: main -->
<link rel="stylesheet" href="{LINK_URL}/blocks/owl.carousel.css" type="text/css" media="screen"/>
<link rel="stylesheet" href="{LINK_URL}/blocks/owl.theme.default.css" type="text/css" media="screen"/>
<script src="{LINK_URL}/blocks/owl.carousel.min.js"></script>

<div id="slider_main_mini" class="owl-carousel owl-theme">
    <!-- BEGIN: image -->
        <div class="item">
            <a href="<!-- BEGIN: link -->{IMAGE.link}<!-- END: link -->" target="_blank">
                <img class="sp-image" src="{IMAGE.path}" data-src="{IMAGE.path}" data-retina="{IMAGE.path}" title="{IMAGE.description}" />
            </a>
        </div>
    <!-- END: image -->
</div>
<script type="text/javascript">
     $("#slider_main_mini").owlCarousel({
          slideSpeed : 2000,
          nav: true,
          margin:10,
          autoplay: true,
          dots: false,
          lazyLoad:true,
          loop: true,
          responsiveRefreshRate : 200,
          navText:['<i class="fa fa-angle-left"></i>','<i class="fa fa-angle-right"></i>'],
          responsive : {
            // breakpoint from 0 up
            0 : {
              items : 1,
              margin:20
            },
            // breakpoint from 480 up
            480 : {
              items : 1,
              margin:20,
              loop:false,
              rewind:true
            },
            // breakpoint from 768 up
            768 : {
              items : 2
            }
        }
    });
</script>
<style>
    #slider_main_mini {
        margin-top: 14px;
    }

    #slider_main_mini .item, .skSliderHome {
        border-radius: 12px;
        -webkit-border-radius: 12px;
        overflow: hidden;
    }

    #slider_main_mini .item, .skSliderHome img {
        border: 0;
        height: 100%;
        max-width: 100%;
    }

     #slider_main_mini .owl-nav {
        top: -15px !important;
     }
</style>
<!-- END: main -->

<!-- BEGIN: config -->
<div id="config_slide_box">
    <!-- BEGIN: image -->
    <div class="row mb-3">
        <label for="element_title" class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium" title="Tên block">Hình ảnh:</label>
        <div class="col-sm-3">
            <div class="input-group">
                <input class="form-control" type="text" name="config_image[{IMAGE.index}][path]" value="{IMAGE.path}" id="image_{IMAGE.index}" placeholder="{image}" /> <span class="input-group-btn">
                    <button class="btn btn-default" onclick="nv_selectfile($(this)); return !1;" data-index="{IMAGE.index}" data-currentpath="{IMAGE.currentpath}" type="button">
                        <em class="fa fa-folder-open-o fa-fix">&nbsp;</em>
                    </button>
                </span>
            </div>
        </div>

        <div class="col-sm-3">
            <input class="form-control" name="config_image[{IMAGE.index}][description]" value="{IMAGE.description}" type="text" placeholder="{description}">
        </div>

        <div class="col-sm-2">
            <input type="url" class="form-control" name="config_image[{IMAGE.index}][link]" value="{IMAGE.link}" placeholder="{link}" />
        </div>

        <div class="col-sm-1">
            <!-- BEGIN: show_remove -->
            <button type="button" class="btn btn-danger btn-xs remove_block_img"><i class="fa fa-minus-circle" aria-hidden="true"></i></button>
            <!-- END: show_remove -->
        </div>
    </div>
    <!-- END: image -->
</div>
<div class="row mb-3">
    <div class="col-sm-3"></div>
    <div class="col-sm-9">
        <button class="btn btn-primary btn-xs" onclick="nv_add_image(); return !1;"><i class="fa fa-plus-circle" aria-hidden="true"></i></button>
    </div>
</div>

<script>
    function nv_selectfile($this)
    {
        var area = "image_" + $this.data('index');
        var path = "{NV_UPLOADS_DIR}";
        var currentpath = $this.data('currentpath');
        var type = "image";
        nv_open_browse(script_name + "?" + nv_name_variable
            + "=upload&popup=1&area=" + area + "&path="
            + path + "&type=" + type + "&currentpath="
            + currentpath, "NVImg", 850, 420,
            "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
    }

    var index = {INDEX};
    function nv_add_image()
    {
        var html = '';

        html += `<div class="row mb-3">
            <label for="element_title" class="col-sm-3 col-form-label text-sm-end text-truncate fw-medium" title="Tên block">Hình ảnh:</label>
            <div class="col-sm-3">
                <div class="input-group">
                    <input class="form-control" type="text" name="config_image[` + index + `][path]" id="image_` + index + `" placeholder="{image}" /> <span class="input-group-btn">
                        <button class="btn btn-default" onclick="nv_selectfile($(this)); return !1;" data-index="` + index + `" data-currentpath="{NV_UPLOADS_DIR}" type="button">
                            <em class="fa fa-folder-open-o fa-fix">&nbsp;</em>
                        </button>
                    </span>
                </div>
            </div>

            <div class="col-sm-3">
                <input class="form-control" name="config_image[` + index + `][description]" value="" type="text" placeholder="{description}">
            </div>

            <div class="col-sm-2">
                <input type="url" class="form-control" name="config_image[` + index + `][link]" value="" placeholder="{link}" />
            </div>

            <div class="col-sm-1">
                <button type="button" class="btn btn-danger btn-xs remove_block_img"><i class="fa fa-minus-circle" aria-hidden="true"></i></button>
            </div>
        </div>`;
        index++;

        $('#config_slide_box').append(html);

        $(".remove_block_img").click(function() {
            $(this).closest('.row').remove();
        });
    }

    $(".remove_block_img").click(function() {
        $(this).closest('.row').remove();
    })
</script>
<!-- END: config -->
