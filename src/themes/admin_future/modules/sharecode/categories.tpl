{if isset($SUCCESS_MESSAGE) and !empty($SUCCESS_MESSAGE)}
<div class="alert alert-success" role="alert"><i class="fa-solid fa-check-circle"></i> {$SUCCESS_MESSAGE}</div>
{/if}

{if isset($ERRORS) and !empty($ERRORS)}
<div class="alert alert-danger" role="alert">{$ERRORS|join:"<br />"}</div>
{/if}

<div class="card">
    <div class="card-header text-bg-primary rounded-top-2 d-flex gap-2 justify-content-between align-items-center">
        <div class="fw-medium"><i class="fa-solid fa-list"></i> Danh sách danh mục</div>
        <button type="button" class="btn btn-sm btn-secondary" data-bs-toggle="modal" data-bs-target="#modal-category"
            data-action="add">
            <i class="fa-solid fa-plus"></i> Thêm danh mục
        </button>
    </div>
    <div class="card-body">
        {if $CATEGORIES}
        <div class="table-responsive-lg table-card">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted">
                    <tr>
                        <th class="text-nowrap text-center" style="width: 50px;">
                            <input type="checkbox" data-toggle="checkAll" name="checkAll[]"
                                class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                        </th>
                        <th class="text-nowrap text-center" style="width: 80px;">Thứ tự</th>
                        <th class="text-nowrap" style="width: auto;">Tên danh mục</th>
                        <th class="text-nowrap text-center" style="width: 100px;">Hình ảnh</th>
                        <th class="text-nowrap text-center" style="width: 100px;">Trạng thái</th>
                        <th class="text-nowrap text-center" style="width: 150px;">Thời gian</th>
                        <th class="text-nowrap text-center" style="width: 120px;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $CATEGORIES as $category}
                    <tr class="item category-row" data-id="{$category.id}" data-parent="{$category.parentid}"
                        data-level="{$category.level}" {if $category.parentid> 0}style="display: none;"{/if}>
                        <td class="text-center align-middle">
                            <input type="checkbox" data-toggle="checkSingle" name="checkSingle[]" value="{$category.id}"
                                class="form-check-input m-0 align-middle" aria-label="Chọn danh mục">
                        </td>
                        <td class="text-center align-middle">
                            <span class="badge bg-primary change-weight-btn" style="cursor: pointer;"
                                data-id="{$category.id}" data-current="{$category.weight}"
                                data-max="{$TOTAL_CATEGORIES}">{$category.weight}</span>
                        </td>
                        <td class="align-middle">
                            <div class="d-flex align-items-center">
                                {if $category.level > 0}
                                <span class="me-2 category-indent" data-level="{$category.level}">
                                    <i class="fa-solid fa-arrow-turn-down fa-rotate-90 text-muted"></i>
                                </span>
                                {/if}

                                {if $category.has_children}
                                <button type="button" class="btn btn-sm btn-link p-0 me-2 category-toggle"
                                    data-id="{$category.id}">
                                    <i class="fa-solid fa-plus text-primary"></i>
                                </button>
                                {else}
                                <span class="me-2" style="width: 24px;"></span>
                                {/if}

                                <div>
                                    <div class="fw-medium category-title {if $category.has_children}category-expandable{/if}"
                                        data-id="{$category.id}">
                                        {$category.title}
                                    </div>
                                    {if $category.alias}<div class="text-muted small">/{$category.alias}</div>{/if}
                                    {if $category.description}<div class="text-muted small mt-1">
                                        {$category.description|truncate:80}</div>{/if}
                                </div>
                            </div>
                        </td>
                        <td class="text-center align-middle">
                            {if $category.image}
                            <img src="{$category.image}" alt="{$category.title}" class="img-thumbnail preview-image"
                                style="max-width: 50px; max-height: 40px; cursor: pointer;" data-src="{$category.image}"
                                data-title="{$category.title}" title="Click để xem ảnh lớn">
                            {else}
                            <span class="text-muted small">Không có</span>
                            {/if}
                        </td>
                        <td class="text-center align-middle">
                            <span class="badge bg-{$category.status_class}">{$category.status_text}</span>
                        </td>
                        <td class="text-center align-middle">
                            <div class="text-muted small">
                                <div>Tạo: {$category.add_time_format}</div>
                                {if $category.edit_time_format}<div>Sửa: {$category.edit_time_format}</div>{/if}
                            </div>
                        </td>
                        <td class="text-center align-middle">
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-sm btn-outline-secondary" title="Chỉnh sửa"
                                    data-bs-toggle="modal" data-bs-target="#modal-category" data-action="edit"
                                    data-id="{$category.id}">
                                    <i class="fa-solid fa-pen"></i>
                                </button>
                                <button type="button" class="btn btn-sm btn-outline-danger" title="Xóa"
                                    data-toggle="delCategory" data-id="{$category.id}"
                                    data-checksess="{$category.checksess}">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
        {else}
        <div class="alert alert-info mb-0" role="alert">
            <i class="fa-solid fa-info-circle"></i> Chưa có danh mục nào.
            <button type="button" class="btn btn-sm btn-primary ms-2" data-bs-toggle="modal"
                data-bs-target="#modal-category" data-action="add">
                <i class="fa-solid fa-plus"></i> Thêm danh mục đầu tiên
            </button>
        </div>
        {/if}
    </div>
    {if $CATEGORIES}
    <div class="card-footer border-top">
        <div class="d-flex flex-wrap justify-content-between align-items-center">
            <div class="d-flex flex-wrap flex-sm-nowrap align-items-center">
                <div class="me-2">
                    <input type="checkbox" data-toggle="checkAll" name="checkAll[]"
                        class="form-check-input m-0 align-middle" aria-label="Chọn tất cả">
                </div>
                <div class="input-group me-1 my-1">
                    <select id="element_action" class="form-select fw-150" aria-label="Chọn thao tác"
                        aria-describedby="element_action_btn">
                        <option value="activate">Kích hoạt</option>
                        <option value="deactivate">Ngừng kích hoạt</option>
                        <option value="delete">Xóa</option>
                    </select>
                    <button class="btn btn-primary" type="button" id="element_action_btn"
                        data-toggle="actionCategory">Thực hiện</button>
                </div>
            </div>
            <div class="text-muted small">
                Tổng: {count($CATEGORIES)} danh mục
            </div>
        </div>
    </div>
    {/if}
</div>



<!-- Modal for Change Weight -->
<div class="modal fade" id="modal-change-weight" tabindex="-1" aria-labelledby="modal-change-weight-label"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-change-weight-label">
                    <i class="fa-solid fa-sort"></i> Thay đổi thứ tự
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label for="weight-input" class="form-label">Thứ tự mới:</label>
                    <div class="input-group">
                        <button type="button" class="btn btn-outline-secondary" id="weight-down">
                            <i class="fa fa-minus"></i>
                        </button>
                        <input type="number" class="form-control text-center" id="weight-input" min="1" value="1">
                        <button type="button" class="btn btn-outline-secondary" id="weight-up">
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                    <div class="form-text">Nhập thứ tự từ 1 đến <span id="max-weight">1</span></div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btn-save-weight">
                    <i class="fa-solid fa-check"></i> Cập nhật
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i> Hủy
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Image Preview -->
<div class="modal fade" id="modal-image-preview" tabindex="-1" aria-labelledby="modal-image-preview-label"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-image-preview-label">
                    <i class="fa-solid fa-image"></i> <span id="preview-title">Xem ảnh</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body text-center">
                <img id="preview-image" src="" alt="" class="img-fluid" style="max-height: 70vh;">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i> Đóng
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Add/Edit Category -->
<div class="modal fade" id="modal-category" tabindex="-1" aria-labelledby="modal-category-label" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modal-category-label">
                    <i class="fa-solid fa-plus" id="modal-icon"></i>
                    <span id="modal-title-text">Thêm danh mục mới</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <div id="modal-alert" class="alert alert-danger d-none" role="alert"></div>
                <form id="form-category" novalidate>
                    <input type="hidden" id="category-id" name="id" value="0">
                    <div class="mb-3">
                        <label for="modal-title" class="form-label">Tên danh mục <span
                                class="text-danger">*</span></label>
                        <div class="position-relative">
                            <input type="text" class="form-control required" id="modal-title" name="title"
                                maxlength="255" required>
                            <div class="invalid-feedback">Vui lòng nhập tên danh mục</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="modal-alias" class="form-label">Liên kết tĩnh</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="modal-alias" name="alias" maxlength="255">
                            <button class="btn btn-secondary" type="button" id="btn-generate-alias"
                                data-bs-toggle="tooltip" data-bs-title="Tự động tạo từ tên danh mục">
                                <i class="fa-solid fa-rotate"></i>
                            </button>
                        </div>
                        <div class="form-text">Sẽ tự động tạo từ tên danh mục nếu để trống</div>
                    </div>

                    <!-- <div class="mb-3">
                        <label for="modal-parent" class="form-label">Danh mục cha</label>
                        <select class="form-select" id="modal-parent" name="parent_id">
                            {$PARENT_OPTIONS}
                        </select>
                    </div> -->

                    <div class="mb-3">
                        <label for="modal-description" class="form-label">Mô tả</label>
                        <textarea class="form-control" id="modal-description" name="description" rows="4"></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="modal-image" class="form-label">Hình ảnh đại diện</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="modal-image" name="image" readonly>
                            <button class="btn btn-outline-secondary" type="button" id="btn-select-image">
                                <i class="fa-solid fa-image"></i> Chọn ảnh
                            </button>
                        </div>
                        <div id="image-preview" class="mt-2 d-none">
                            <img id="preview-img" src="" alt="Preview" class="img-thumbnail"
                                style="max-width: 150px; max-height: 100px;">
                            <button type="button" class="btn btn-sm btn-danger ms-2" id="btn-remove-image">
                                <i class="fa-solid fa-trash"></i> Xóa ảnh
                            </button>
                        </div>
                    </div>

                    <div class="mb-0">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" role="switch" id="modal-status"
                                name="status" value="1" checked>
                            <label class="form-check-label" for="modal-status">Hoạt động</label>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btn-save-category">
                    <i class="fa-solid fa-check"></i> <span id="btn-save-text">Thêm mới</span>
                </button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="fa-solid fa-xmark"></i> Hủy
                </button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        'use strict';

        var modal = $('#modal-category');
        var form = $('#form-category');
        var modalAlert = $('#modal-alert');

        // Modal event handlers
        modal.on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget);
            var action = button.data('action');
            var id = button.data('id') || 0;

            // Reset form and modal
            form[0].reset();
            form.removeClass('was-validated');
            modalAlert.addClass('d-none');
            $('#category-id').val(id);

            if (action === 'edit') {
                $('#modal-icon').removeClass('fa-plus').addClass('fa-edit');
                $('#modal-title-text').text('Chỉnh sửa danh mục');
                $('#btn-save-text').text('Cập nhật');

                // Load category data via AJAX
                $.ajax({
                    url: location.href,
                    method: 'GET',
                    data: {
                        action: 'get_category',
                        id: id,
                        ajax: 1
                    },
                    dataType: 'json',
                    success: function (response) {
                        if (response.status === 'OK') {
                            $('#modal-title').val(response.data.title);
                            $('#modal-alias').val(response.data.alias);
                            $('#modal-description').val(response.data.description);
                            $('#modal-image').val(response.data.image || '');
                            $('#modal-status').prop('checked', response.data.status == 1);

                            // Load parent options excluding current category
                            loadParentOptions(id, response.data.parentid || 0);

                            // Show image preview if exists
                            if (response.data.image) {
                                showImagePreview('{$smarty.const.NV_BASE_SITEURL}' + response.data.image);
                            } else {
                                hideImagePreview();
                            }
                        } else {
                            showAlert(response.mess || 'Lỗi khi tải dữ liệu danh mục');
                        }
                    },
                    error: function () {
                        showAlert('Lỗi kết nối khi tải dữ liệu danh mục');
                    }
                });
            } else {
                $('#modal-icon').removeClass('fa-edit').addClass('fa-plus');
                $('#modal-title-text').text('Thêm danh mục mới');
                $('#btn-save-text').text('Thêm mới');
                $('#modal-parent').val(0);
                $('#modal-image').val('');
                $('#modal-status').prop('checked', true);
                hideImagePreview();
            }
        });

        // Auto-generate alias
        $('#modal-title').on('input', function () {
            if ($('#modal-alias').val() === '') {
                var title = $(this).val();
                var alias = nv_create_alias(title);
                $('#modal-alias').val(alias);
            }
        });

        $('#btn-generate-alias').on('click', function () {
            var title = $('#modal-title').val();
            if (title) {
                var alias = nv_create_alias(title);
                $('#modal-alias').val(alias);
            }
        });

        $('#modal-alias').on('blur', function () {
            var alias = $(this).val();
            if (alias !== '') {
                $(this).val(nv_create_alias(alias));
            }
        });

        // Save category
        $('#btn-save-category').on('click', function () {
            var title = $('#modal-title').val().trim();

            if (!title) {
                $('#modal-title').addClass('is-invalid').focus();
                return;
            } else {
                $('#modal-title').removeClass('is-invalid');
            }

            var formData = {
                action: 'save_category',
                ajax: 1,
                id: $('#category-id').val(),
                title: title,
                alias: $('#modal-alias').val(),
                parent_id: $('#modal-parent').val(),
                description: $('#modal-description').val(),
                image: $('#modal-image').val(),
                status: $('#modal-status').prop('checked') ? 1 : 0,
                checkss: '{$smarty.const.NV_CHECK_SESSION}'
            };

            $(this).prop('disabled', true).html('<i class=\"fa-solid fa-spinner fa-spin\"></i> Đang lưu...');

            $.ajax({
                url: location.href,
                method: 'POST',
                data: formData,
                dataType: 'json',
                success: function (response) {
                    if (response.status === 'OK') {
                        $('#modal-category').modal('hide');
                        nukeviet.toast(response.mess || 'Lưu danh mục thành công', 'success');
                        setTimeout(function () {
                            location.reload();
                        }, 1500);
                    } else {
                        nukeviet.toast(response.mess || 'Có lỗi xảy ra khi lưu danh mục', 'error');
                    }
                },
                error: function () {
                    nukeviet.toast('Lỗi kết nối khi lưu danh mục', 'error');
                },
                complete: function () {
                    $('#btn-save-category').prop('disabled', false).html('<i class=\"fa-solid fa-check\"></i> <span id=\"btn-save-text\">' + $('#btn-save-text').text() + '</span>');
                }
            });
        });

        // Delete category handler
        $(document).on('click', '[data-toggle="delCategory"]', function () {
            var id = $(this).data('id');
            var checksess = $(this).data('checksess');

            nukeviet.confirm('Bạn có chắc chắn muốn xóa danh mục này?\n\nLưu ý: Không thể xóa danh mục đang chứa mã nguồn.', function () {
                window.location.href = '{$BASE_URL}&action=delete&id=' + id + '&confirm=' + checksess;
            });
        });

        // Bulk actions handler
        $(document).on('click', '[data-toggle="actionCategory"]', function () {
            var action = $('#element_action').val();
            var checkedItems = $('input[name="checkSingle[]"]:checked');

            if (checkedItems.length === 0) {
                alert('Vui lòng chọn ít nhất một danh mục để thực hiện');
                return;
            }

            var actionText = {
                'activate': 'kích hoạt',
                'deactivate': 'ngừng kích hoạt',
                'delete': 'xóa'
            };

            var confirmText = 'Bạn có chắc chắn muốn ' + (actionText[action] || action) + ' ' + checkedItems.length + ' danh mục đã chọn?';

            if (action === 'delete') {
                confirmText += '\n\nLưu ý: Không thể xóa danh mục đang chứa mã nguồn.';
            }

            nukeviet.confirm(confirmText, function () {
                var form = $('<form method="post" action="{$BASE_URL}"></form>');
                form.append('<input type="hidden" name="bulk_action" value="1">');
                form.append('<input type="hidden" name="action_type" value="' + action + '">');
                form.append('<input type="hidden" name="checkss" value="{$smarty.const.NV_CHECK_SESSION}">');

                checkedItems.each(function () {
                    form.append('<input type="hidden" name="ids[]" value="' + $(this).val() + '">');
                });

                $('body').append(form);
                form.submit();
            });
        });

        // Check all functionality
        $(document).on('change', '[data-toggle="checkAll"]', function () {
            var isChecked = $(this).prop('checked');
            $('input[name="checkSingle[]"]').prop('checked', isChecked);
        });

        // Update check all when individual items change
        $(document).on('change', 'input[name="checkSingle[]"]', function () {
            var totalItems = $('input[name="checkSingle[]"]').length;
            var checkedItems = $('input[name="checkSingle[]"]:checked').length;
            $('[data-toggle="checkAll"]').prop('checked', totalItems === checkedItems);
        });

        // Weight change functionality using modal
        var currentWeightData = {};

        // Handle click on weight badge
        $('body').on('click', '.change-weight-btn', function () {
            var id = $(this).data('id');
            var current = $(this).data('current');
            var max = $(this).data('max');

            currentWeightData = {
                id: id,
                current: current,
                max: max
            };

            $('#weight-input').val(current).attr('max', max);
            $('#max-weight').text(max);
            $('#modal-change-weight').modal('show');
        });

        // Handle weight up/down buttons in modal
        $('#weight-up').on('click', function () {
            var input = $('#weight-input');
            var current = parseInt(input.val()) || 1;
            var max = parseInt(input.attr('max'));

            if (current < max) {
                input.val(current + 1);
            }
        });

        $('#weight-down').on('click', function () {
            var input = $('#weight-input');
            var current = parseInt(input.val()) || 1;

            if (current > 1) {
                input.val(current - 1);
            }
        });

        // Handle save weight
        $('#btn-save-weight').on('click', function () {
            var new_weight = parseInt($('#weight-input').val());
            var id = currentWeightData.id;
            var current_weight = currentWeightData.current;
            var max = currentWeightData.max;

            // Validation
            if (isNaN(new_weight) || new_weight < 1 || new_weight > max) {
                $('#weight-input').addClass('is-invalid');
                nukeviet.toast('Thứ tự phải từ 1 đến ' + max, 'error');
                return false;
            }

            $('#weight-input').removeClass('is-invalid');

            if (new_weight != current_weight) {
                // Show loading
                $(this).prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang lưu...');

                $.ajax({
                    url: script_name + "?" + nv_lang_variable + "=" + nv_lang_data + "&" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=categories",
                    type: 'POST',
                    data: {
                        action: 'change_weight',
                        id: id,
                        new_weight: new_weight,
                        checkss: '{$smarty.const.NV_CHECK_SESSION}'
                    },
                    success: function (res) {
                        if (res.indexOf('OK_') === 0) {
                            $('#modal-change-weight').modal('hide');
                            nukeviet.toast('Cập nhật thứ tự thành công', 'success');
                            setTimeout(function () {
                                location.reload();
                            }, 1000);
                        } else {
                            nukeviet.toast('Lỗi khi cập nhật thứ tự: ' + res, 'error');
                        }
                    },
                    error: function () {
                        nukeviet.toast('Lỗi kết nối', 'error');
                    },
                    complete: function () {
                        $('#btn-save-weight').prop('disabled', false).html('<i class="fa-solid fa-check"></i> Cập nhật');
                    }
                });
            } else {
                $('#modal-change-weight').modal('hide');
            }
        });

        // Weight change functionality using Bootstrap 5 dropdown (old code - will be removed)
        if ({ $TOTAL_CATEGORIES } > 1) {

            // Handle weight up/down buttons
            $('body').on('click', '.weight-up, .weight-down', function (e) {
                e.preventDefault();
                e.stopPropagation();

                var ipt = $(this).siblings('.new-weight');
                var current = parseInt(ipt.val()) || 1;
                var max = parseInt(ipt.attr('max'));
                var min = parseInt(ipt.attr('min'));

                if ($(this).hasClass('weight-up')) {
                    if (current < max) {
                        ipt.val(current + 1);
                    }
                } else {
                    if (current > min) {
                        ipt.val(current - 1);
                    }
                }
            });

            // Handle weight change confirmation
            $('body').on('click', '.category-change-weight', function (e) {
                e.preventDefault();
                e.stopPropagation();

                var dropdown = $(this).closest('.dropdown-menu');
                var ipt = dropdown.find('.new-weight');
                var id = ipt.data('id');
                var new_weight = parseInt(ipt.val());
                var current_weight = parseInt(ipt.data('current'));
                var max = parseInt(ipt.attr('max'));
                var min = parseInt(ipt.attr('min'));

                // Validation
                if (isNaN(new_weight) || new_weight < min || new_weight > max) {
                    ipt.addClass('is-invalid');
                    nukeviet.toast('Thứ tự phải từ ' + min + ' đến ' + max, 'error');
                    return false;
                }

                ipt.removeClass('is-invalid');

                // Close dropdown safely
                try {
                    var dropdownToggle = dropdown.siblings('[data-bs-toggle="dropdown"]');
                    if (dropdownToggle.length > 0) {
                        var bsDropdown = bootstrap.Dropdown.getInstance(dropdownToggle[0]);
                        if (bsDropdown) {
                            bsDropdown.hide();
                        } else {
                            // Force close by removing show class
                            dropdown.removeClass('show');
                            dropdownToggle.removeClass('show').attr('aria-expanded', 'false');
                        }
                    }
                } catch (e) {
                    console.log('Dropdown close error:', e);
                    // Fallback: hide dropdown manually
                    dropdown.removeClass('show');
                    dropdown.siblings('[data-bs-toggle="dropdown"]').removeClass('show').attr('aria-expanded', 'false');
                }

                if (new_weight != current_weight) {
                    // Show loading
                    $(this).prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang lưu...');

                    console.log('Sending AJAX request:', {
                        id: id,
                        new_weight: new_weight,
                        current_weight: current_weight
                    });

                    $.ajax({
                        url: script_name + "?" + nv_lang_variable + "=" + nv_lang_data + "&" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=categories",
                        type: 'POST',
                        data: {
                            action: 'change_weight',
                            id: id,
                            new_weight: new_weight,
                            checkss: '{$smarty.const.NV_CHECK_SESSION}'
                        },
                        success: function (res) {
                            console.log('AJAX Response:', res);
                            if (res.indexOf('OK_') === 0) {
                                nukeviet.toast('Cập nhật thứ tự thành công', 'success');
                                setTimeout(function () {
                                    location.reload();
                                }, 1000);
                            } else {
                                console.error('Error response:', res);
                                nukeviet.toast('Lỗi khi cập nhật thứ tự: ' + res, 'error');
                            }
                        },
                        error: function () {
                            nukeviet.toast('Lỗi kết nối', 'error');
                        },
                        complete: function () {
                            $('.category-change-weight').prop('disabled', false).html('<i class="fa fa-check"></i> OK');
                        }
                    });
                }
            });

            // Prevent dropdown close when clicking inside
            $('body').on('click', '.dropdown-menu', function (e) {
                e.stopPropagation();
            });

            // Handle cancel button
            $('body').on('click', '.btn-secondary[data-bs-toggle="dropdown"]', function (e) {
                e.preventDefault();
                e.stopPropagation();

                var dropdown = $(this).closest('.dropdown-menu');
                var dropdownToggle = dropdown.siblings('[data-bs-toggle="dropdown"]');

                try {
                    var bsDropdown = bootstrap.Dropdown.getInstance(dropdownToggle[0]);
                    if (bsDropdown) {
                        bsDropdown.hide();
                    }
                } catch (e) {
                    dropdown.removeClass('show');
                    dropdownToggle.removeClass('show').attr('aria-expanded', 'false');
                }
            });

        }

        function nv_del_category(id) {
            if (confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
                window.location.href = '{$BASE_URL}&action=delete&id=' + id + '&confirm=' + nv_md5_check(id + '{$smarty.const.NV_CHECK_SESSION}');
            }
        }

        // Image preview functionality
        $('body').on('click', '.preview-image', function () {
            var imageSrc = $(this).data('src');
            var imageTitle = $(this).data('title');

            $('#preview-image').attr('src', imageSrc).attr('alt', imageTitle);
            $('#preview-title').text('Ảnh đại diện: ' + imageTitle);
            $('#modal-image-preview').modal('show');
        });

        // Image selection handlers
        $('#btn-select-image').on('click', function () {
            var area = 'modal-image';
            var path = 'uploads/sharecode';
            var currentpath = 'uploads/sharecode';
            var type = 'image';

            nv_open_browse(script_name + "?" + nv_name_variable + "=upload&popup=1&area=" + area + "&path=" + path + "&type=" + type + "&currentpath=" + currentpath, "NVImg", 850, 420, "resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
            return false;
        });

        $('#btn-remove-image').on('click', function () {
            $('#modal-image').val('');
            hideImagePreview();
        });

        // Monitor image input changes
        $('#modal-image').on('change', function () {
            var imagePath = $(this).val();
            if (imagePath) {
                showImagePreview('{$smarty.const.NV_BASE_SITEURL}' + imagePath);
            } else {
                hideImagePreview();
            }
        });

        // Initialize tooltips
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        }
    });

    // Function to create clean alias from text
    function nv_create_alias(text) {
        if (!text) return '';

        // Vietnamese character map
        var map = {
            'à': 'a', 'á': 'a', 'ạ': 'a', 'ả': 'a', 'ã': 'a', 'â': 'a', 'ầ': 'a', 'ấ': 'a', 'ậ': 'a', 'ẩ': 'a', 'ẫ': 'a', 'ă': 'a', 'ằ': 'a', 'ắ': 'a', 'ặ': 'a', 'ẳ': 'a', 'ẵ': 'a',
            'è': 'e', 'é': 'e', 'ẹ': 'e', 'ẻ': 'e', 'ẽ': 'e', 'ê': 'e', 'ề': 'e', 'ế': 'e', 'ệ': 'e', 'ể': 'e', 'ễ': 'e',
            'ì': 'i', 'í': 'i', 'ị': 'i', 'ỉ': 'i', 'ĩ': 'i',
            'ò': 'o', 'ó': 'o', 'ọ': 'o', 'ỏ': 'o', 'õ': 'o', 'ô': 'o', 'ồ': 'o', 'ố': 'o', 'ộ': 'o', 'ổ': 'o', 'ỗ': 'o', 'ơ': 'o', 'ờ': 'o', 'ớ': 'o', 'ợ': 'o', 'ở': 'o', 'ỡ': 'o',
            'ù': 'u', 'ú': 'u', 'ụ': 'u', 'ủ': 'u', 'ũ': 'u', 'ư': 'u', 'ừ': 'u', 'ứ': 'u', 'ự': 'u', 'ử': 'u', 'ữ': 'u',
            'ỳ': 'y', 'ý': 'y', 'ỵ': 'y', 'ỷ': 'y', 'ỹ': 'y',
            'đ': 'd'
        };

        // Convert to lowercase and replace Vietnamese characters
        text = text.toLowerCase();
        for (var char in map) {
            text = text.replace(new RegExp(char, 'g'), map[char]);
        }

        // Remove special characters and replace spaces with hyphens
        text = text.replace(/[^a-z0-9\s-]/g, '');
        text = text.replace(/\s+/g, '-');
        text = text.replace(/-+/g, '-');
        text = text.replace(/^-|-$/g, '');

        return text;
    }

    // Image preview functions
    function showImagePreview(imageUrl) {
        $('#preview-img').attr('src', imageUrl);
        $('#image-preview').removeClass('d-none');
    }

    function hideImagePreview() {
        $('#preview-img').attr('src', '');
        $('#image-preview').addClass('d-none');
    }

    // Load parent options excluding current category
    function loadParentOptions(excludeId, selectedId) {
        $.ajax({
            url: script_name + "?" + nv_lang_variable + "=" + nv_lang_data + "&" + nv_name_variable + "=" + nv_module_name + "&" + nv_fc_variable + "=categories",
            type: 'POST',
            data: {
                action: 'get_parent_options',
                exclude_id: excludeId,
                selected_id: selectedId,
                checkss: '{$smarty.const.NV_CHECK_SESSION}'
            },
            success: function (response) {
                $('#modal-parent').html(response).val(selectedId);
            },
            error: function () {
                console.error('Failed to load parent options');
            }
        });
    }

    // Tree view functionality
    $('body').on('click', '.category-toggle, .category-expandable', function () {
        var categoryId = $(this).data('id');
        var toggleBtn = $('.category-toggle[data-id="' + categoryId + '"]');
        var isExpanded = toggleBtn.hasClass('expanded');

        if (isExpanded) {
            // Collapse: Hide children
            $('.category-row[data-parent="' + categoryId + '"]').hide();
            toggleBtn.removeClass('expanded').find('i').removeClass('fa-minus').addClass('fa-plus');

            // Also collapse grandchildren
            $('.category-row[data-parent="' + categoryId + '"]').each(function () {
                var childId = $(this).data('id');
                $('.category-row[data-parent="' + childId + '"]').hide();
                $('.category-toggle[data-id="' + childId + '"]').removeClass('expanded').find('i').removeClass('fa-minus').addClass('fa-plus');
            });
        } else {
            // Expand: Show direct children only
            $('.category-row[data-parent="' + categoryId + '"]').show().addClass('child-visible');
            toggleBtn.addClass('expanded').find('i').removeClass('fa-plus').addClass('fa-minus');
        }
    });
</script>

<style>
    .category-indent[data-level="1"] {
        margin-left: 20px;
    }

    .category-indent[data-level="2"] {
        margin-left: 40px;
    }

    .category-indent[data-level="3"] {
        margin-left: 60px;
    }

    .category-indent[data-level="4"] {
        margin-left: 80px;
    }

    .category-indent[data-level="5"] {
        margin-left: 100px;
    }

    .category-expandable {
        cursor: pointer;
    }

    .category-toggle {
        transition: transform 0.2s ease;
    }

    .category-toggle.expanded i {
        transform: rotate(45deg);
    }

    .category-row.child-visible {
        animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
        }

        to {
            opacity: 1;
        }
    }
</style>