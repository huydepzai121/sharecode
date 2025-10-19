<div class="card mb-3">
    <div class="card-body">
        <div class="row g-1">
            <div class="col-auto">
                <a class="btn btn-{(!$COMPLETE and !$INCOMPLETE) ? 'primary' : 'secondary'}"
                    href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}">Tất
                    cả từ khóa</a>
            </div>
            <div class="col-auto">
                <a class="btn btn-{$COMPLETE ? 'primary' : 'secondary'}"
                    href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}&complete=1">Đã
                    có mô tả</a>
            </div>
            <div class="col-auto">
                <a class="btn btn-{$INCOMPLETE ? 'primary' : 'secondary'}"
                    href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}&incomplete=1">Chưa
                    có mô tả</a>
            </div>
            <div class="col-auto">
                <a class="btn btn-secondary" href="#" data-toggle="add_tags" data-fc="addTag" data-mtitle="Thêm từ khóa"
                    data-tid="0">Thêm từ khóa</a>
            </div>
            <div class="col-auto">
                <a class="btn btn-secondary" href="#" data-bs-toggle="modal" data-bs-target="#mdTagMulti">Thêm nhiều từ
                    khóa</a>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header text-bg-primary rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium"><i class="fa-solid fa-tags"></i> Quản lý từ khóa</div>
        <a href="#" class="btn btn-sm btn-secondary" data-toggle="add_tags" data-fc="addTag" data-mtitle="Thêm từ khóa" data-tid="0"><i class="fa-solid fa-plus"></i> Thêm từ khóa</a>
    </div>
    <div class="card-body">
        <form method="get" action="{$smarty.const.NV_BASE_ADMINURL}index.php" id="form-search-tags">
            <input type="hidden" name="{$smarty.const.NV_LANG_VARIABLE}" value="{$smarty.const.NV_LANG_DATA}">
            <input type="hidden" name="{$smarty.const.NV_NAME_VARIABLE}" value="{$MODULE_NAME}">
            <input type="hidden" name="{$smarty.const.NV_OP_VARIABLE}" value="{$OP}">
            <input type="hidden" name="incomplete" value="{$INCOMPLETE}">
            <input type="hidden" name="complete" value="{$COMPLETE}">
            <div class="row g-3 flex-xl-nowrap">
                <div class="col-md-6 flex-lg-fill">
                    <label for="element_q" class="form-label">Tìm kiếm từ khóa</label>
                    <input type="text" class="form-control" name="q" id="element_q" value="{$Q}" maxlength="64" placeholder="Nhập từ khóa...">
                </div>
                <div class="flex-grow-0 flex-shrink-1 w-auto">
                    <label for="submit_search" class="form-label d-none d-sm-block">&nbsp;</label>
                    <button id="submit_search" type="submit" class="btn btn-primary text-nowrap"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                </div>
                <div class="col-auto">
                    <label class="form-label d-none d-sm-block">&nbsp;</label>
                    <div class="text-muted">
                        {if $COMPLETE}Đã có mô tả{elseif $INCOMPLETE}Chưa có mô tả{else}Tất cả từ khóa{/if}: <strong class="text-primary">{$NUM_ITEMS}</strong>
                    </div>
                </div>
            </div>
        </form>
    </div>
    {if not empty($DATA)}
    <div class="card-body">
        <div class="table-responsive-lg table-card pb-1" id="list-tags-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted">
                    <tr>
                        <th class="text-nowrap" style="width: 1%;">
                            <input type="checkbox" data-toggle="checkAll" data-type="tag"
                                class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                        </th>
                        <th class="text-nowrap" style="width: 35%;">
                            {if isset($BASE_URL_ORDER)}
                            <a href="{$BASE_URL_ORDER}{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'name' or !isset($ARRAY_ORDER.value) or $ARRAY_ORDER.value neq 'asc'}&amp;of=name{if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'name' or empty($ARRAY_ORDER.value)}&amp;ov=asc{else}&amp;ov=desc{/if}{/if}" class="d-flex align-items-center justify-content-between">
                                <span class="me-1">Tên từ khóa</span>
                                {if !isset($ARRAY_ORDER.field) or $ARRAY_ORDER.field neq 'name' or empty($ARRAY_ORDER.value)}<i class="fa-solid fa-sort"></i>{elseif $ARRAY_ORDER.value eq 'asc'}<i class="fa-solid fa-sort-up"></i>{else}<i class="fa-solid fa-sort-down"></i>{/if}
                            </a>
                            {else}
                            <span>Tên từ khóa</span>
                            {/if}
                        </th>
                        <th class="text-nowrap text-center" style="width: 5%;">Mô tả</th>
                        <th class="text-nowrap" style="width: 35%;">Alias</th>
                        <th class="text-nowrap text-center" style="width: 8%;">Liên kết</th>
                        <th class="text-nowrap text-center" style="width: 1%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$DATA item=row}
                    <tr>
                        <td>
                            <input type="checkbox" data-toggle="checkSingle" data-type="tag" value="{$row.id}"
                                class="form-check-input m-0 align-middle" aria-label="Chọn mục này">
                        </td>
                        <td>
                            <div class="fw-medium">{$row.name}</div>
                            {if $row.description}<small class="text-muted">{$row.description|truncate:60}</small>{/if}
                        </td>
                        <td class="text-center">
                            {if empty($row.description)}
                            <i class="fa-solid fa-triangle-exclamation text-danger" data-bs-toggle="tooltip"
                                data-bs-title="Chưa có mô tả"></i>
                            {else}
                            <i class="fa-solid fa-check text-success" data-bs-toggle="tooltip"
                                data-bs-title="Đã có mô tả"></i>
                            {/if}
                        </td>
                        <td><code class="text-muted">{$row.alias}</code></td>
                        <td class="text-center">
                            <span class="badge bg-{if $row.num_sources > 0}primary{else}secondary{/if}">{$row.num_sources}</span>
                        </td>
                        <td>
                            <div class="input-group flex-nowrap">
                                <button type="button" class="btn btn-sm btn-secondary text-nowrap" data-toggle="add_tags"
                                    data-fc="editTag" data-mtitle="Sửa từ khóa" data-tid="{$row.id}">
                                    <i class="fa-solid fa-pen"></i> Sửa
                                </button>
                                <button type="button" class="btn btn-sm btn-secondary dropdown-toggle dropdown-toggle-split" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="visually-hidden">Thao tác</span>
                                </button>
                                <ul class="dropdown-menu">
                                    {if $row.num_sources > 0}
                                    <li><button type="button" class="dropdown-item" data-toggle="link_tags" data-tid="{$row.id}"><i class="fa-solid fa-tags fa-fw text-center text-info" data-icon="fa-tags"></i> Xem liên kết ({$row.num_sources})</button></li>
                                    {/if}
                                    <li><button type="button" class="dropdown-item" data-toggle="nv_del_tag" data-tid="{$row.id}"><i class="fa-solid fa-trash fa-fw text-center text-danger" data-icon="fa-trash"></i> Xóa</button></li>
                                </ul>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
    <div class="card-footer border-top">
        <div class="d-flex flex-wrap justify-content-between align-items-center">
            <div class="d-flex flex-wrap flex-sm-nowrap align-items-center">
                <div class="me-2">
                    <input type="checkbox" data-toggle="checkAll" data-type="tag"
                        class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                </div>
                <div class="input-group me-1 my-1">
                    <button type="button" class="btn btn-danger" data-toggle="nv_del_check_tags"><i
                            class="fa-solid fa-trash" data-icon="fa-trash"></i> Xóa</button>
                </div>
            </div>
            <div class="pagination-wrap">
                {$PAGINATION}
            </div>
        </div>
    </div>
    {/if}
</div>

<div class="modal fade" id="mdTagMulti" tabindex="-1" aria-labelledby="mdTagMultiLabel" aria-hidden="true"
    data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title fs-5 fw-medium" id="mdTagMultiLabel">Thêm nhiều từ khóa</div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <form
                    action="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}"
                    method="post" class="ajax-submit">
                    <input name="savetag" type="hidden" value="1">
                    <input name="checkss" type="hidden" value="{$CHECKSESS}">
                    <div class="mb-3">
                        <label for="element_mtag_mtitle" class="form-label">Nhập từ khóa (mỗi dòng một từ khóa):</label>
                        <textarea class="form-control" name="mtitle" id="element_mtag_mtitle" rows="5"
                            maxlength="2000"></textarea>
                    </div>
                    <div class="text-center">
                        <button class="btn btn-primary" type="submit"><i class="fa-solid fa-floppy-disk"
                                data-icon="fa-floppy-disk"></i> Lưu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="mdTagSingle" tabindex="-1" aria-labelledby="mdTagSingleLabel" aria-hidden="true"
    data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title fs-5 fw-medium" id="mdTagSingleLabel"></div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <form
                    action="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}"
                    method="post" class="ajax-submit">
                    <input name="savecat" type="hidden" value="1">
                    <input name="checkss" type="hidden" value="{$CHECKSESS}">
                    <input name="id" type="hidden" value="0">
                    <div class="row mb-3">
                        <label for="element_stag_name" class="col-12 col-sm-3 col-form-label text-sm-end">Tên tag <span
                                class="text-danger">(*)</span></label>
                        <div class="col-12 col-sm-8">
                            <input type="text" class="form-control" id="element_stag_name" name="name" value=""
                                maxlength="100">
                            <div class="invalid-feedback">Tên tag phải có ít nhất 2 ký tự</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="element_stag_alias" class="col-12 col-sm-3 col-form-label text-sm-end">Alias</label>
                        <div class="col-12 col-sm-8">
                            <input type="text" class="form-control" id="element_stag_alias" name="alias" value=""
                                maxlength="100">
                            <div class="form-text">Để trống sẽ tự động tạo từ tên tag</div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="element_stag_description" class="col-12 col-sm-3 col-form-label text-sm-end">Mô
                            tả</label>
                        <div class="col-12 col-sm-8">
                            <textarea class="form-control" id="element_stag_description" name="description"
                                rows="5"></textarea>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label for="element_stag_weight" class="col-12 col-sm-3 col-form-label text-sm-end">Thứ
                            tự</label>
                        <div class="col-12 col-sm-8">
                            <input type="number" class="form-control" id="element_stag_weight" name="weight" value="0"
                                min="0">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 col-sm-8 col-lg-6 col-xxl-5 offset-sm-3">
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="mdTagLinks" tabindex="-1" aria-labelledby="mdTagLinksLabel" aria-hidden="true"
    data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title fs-5 fw-medium" id="mdTagLinksLabel">Liên kết từ khóa</div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body p-0">
            </div>
            <div class="modal-footer justify-content-start">
                <div class="tag-tools">
                    <div class="d-flex align-items-center">
                        <div class="me-2">
                            <input type="checkbox" data-toggle="checkAll" data-type="link"
                                class="form-check-input m-0 d-block" aria-label="Chọn tất cả">
                        </div>
                        <div>
                            <button type="button" class="btn btn-danger" data-toggle="tags_id_check_del" data-tid="0"><i
                                    class="fa-solid fa-trash" data-icon="fa-trash"></i> Xóa</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        // Add tag modal
        $(document).on('click', '[data-toggle="add_tags"]', function (e) {
            e.preventDefault();
            var tid = $(this).data('tid') || 0;
            var title = $(this).data('mtitle') || 'Thêm từ khóa';
            var fc = $(this).data('fc') || 'addTag';

            $('#mdTagSingle .modal-title').text(title);
            $('#mdTagSingle input[name="id"]').val(tid);

            if (fc === 'editTag' && tid > 0) {
                // Load tag data for editing
                $.post('{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}', {
                    loadEditTag: 1,
                    id: tid,
                    checkss: nv_md5_check('{$CHECKSESS}')
                }, function (res) {
                    if (res.success) {
                        $('#element_stag_name').val(res.data.name);
                        $('#element_stag_alias').val(res.data.alias);
                        $('#element_stag_description').val(res.data.description);
                        $('#element_stag_weight').val(res.data.weight);
                    }
                }, 'json');
            } else {
                // Clear form for new tag
                $('#mdTagSingle form')[0].reset();
                $('#mdTagSingle input[name="id"]').val(0);
            }

            $('#mdTagSingle').modal('show');
        });

        // Tag links modal
        $(document).on('click', '[data-toggle="link_tags"]', function (e) {
            e.preventDefault();
            var tid = $(this).data('tid');

            $.post('{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}', {
                tagLinks: 1,
                id: tid,
                checkss: nv_md5_check('{$CHECKSESS}')
            }, function (res) {
                if (res.success) {
                    $('#mdTagLinks .modal-body').html(res.html);
                    $('#mdTagLinks [data-tid]').attr('data-tid', tid);
                    $('#mdTagLinks').modal('show');
                } else {
                    alert(res.text);
                }
            }, 'json');
        });

        // Delete single tag
        $(document).on('click', '[data-toggle="nv_del_tag"]', function (e) {
            e.preventDefault();
            if (confirm('Bạn có chắc chắn muốn xóa từ khóa này?')) {
                var tid = $(this).data('tid');
                $.post('{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}', {
                    del_tid: tid,
                    checkss: nv_md5_check('{$CHECKSESS}')
                }, function (res) {
                    if (res.success) {
                        location.reload();
                    } else {
                        alert(res.text);
                    }
                }, 'json');
            }
        });

        // Delete multiple tags
        $(document).on('click', '[data-toggle="nv_del_check_tags"]', function (e) {
            e.preventDefault();
            var ids = [];
            $('input[data-type="tag"]:checked').each(function () {
                if ($(this).val()) {
                    ids.push($(this).val());
                }
            });

            if (ids.length === 0) {
                alert('Vui lòng chọn từ khóa cần xóa');
                return;
            }

            if (confirm('Bạn có chắc chắn muốn xóa ' + ids.length + ' từ khóa đã chọn?')) {
                $.post('{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}', {
                    del_listid: ids.join(','),
                    checkss: nv_md5_check('{$CHECKSESS}')
                }, function (res) {
                    if (res.success) {
                        location.reload();
                    } else {
                        alert(res.text);
                    }
                }, 'json');
            }
        });

        // Check all functionality
        $(document).on('change', '[data-toggle="checkAll"]', function () {
            var type = $(this).data('type');
            var checked = $(this).prop('checked');
            $('input[data-type="' + type + '"]').prop('checked', checked);
        });

        // Ajax form submit
        $(document).on('submit', '.ajax-submit', function (e) {
            e.preventDefault();
            var form = $(this);
            var btn = form.find('button[type="submit"]');
            var btnText = btn.html();

            btn.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý...');

            $.post(form.attr('action'), form.serialize(), function (res) {
                if (res.status === 'ok' || res.status === 'success') {
                    if (res.refresh) {
                        location.reload();
                    } else {
                        $('.modal').modal('hide');
                        alert(res.mess);
                    }
                } else {
                    alert(res.mess);
                    if (res.input) {
                        form.find('[name="' + res.input + '"]').focus().addClass('is-invalid');
                    }
                }
            }, 'json').always(function () {
                btn.prop('disabled', false).html(btnText);
            });
        });

        // Auto-generate alias from name
        $(document).on('input', '#element_stag_name', function () {
            const aliasField = $('#element_stag_alias');
            if (!aliasField.val() || aliasField.data('auto') !== false) {
                // Simple alias generation
                let alias = $(this).val().toLowerCase()
                    .replace(/[àáạảãâầấậẩẫăằắặẳẵ]/g, 'a')
                    .replace(/[èéẹẻẽêềếệểễ]/g, 'e')
                    .replace(/[ìíịỉĩ]/g, 'i')
                    .replace(/[òóọỏõôồốộổỗơờớợởỡ]/g, 'o')
                    .replace(/[ùúụủũưừứựửữ]/g, 'u')
                    .replace(/[ỳýỵỷỹ]/g, 'y')
                    .replace(/đ/g, 'd')
                    .replace(/[^a-z0-9\s]/g, '')
                    .replace(/\s+/g, '-')
                    .replace(/^-+|-+$/g, '');
                aliasField.val(alias);
            }
        });

        // Mark alias as manually edited
        $(document).on('input', '#element_stag_alias', function () {
            $(this).data('auto', false);
        });
    });
</script>