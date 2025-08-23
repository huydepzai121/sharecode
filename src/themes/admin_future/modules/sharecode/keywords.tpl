<div class="card mb-4">
    <div class="card-body">
        <div class="row g-1">
            <div class="col-auto">
                <a class="btn btn-primary" href="{$FORM_ACTION}">Tất cả từ khóa</a>
            </div>
            <div class="col-auto">
                <a class="btn btn-secondary" href="#" data-toggle="add_keywords" data-fc="addKeyword" data-mtitle="Thêm từ khóa" data-kid="0">Thêm từ khóa</a>
            </div>
            <div class="col-auto">
                <a class="btn btn-secondary" href="#" data-bs-toggle="modal" data-bs-target="#mdKeywordMulti">Thêm nhiều từ khóa</a>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <form method="get" action="{$FORM_ACTION}">
            <div class="d-flex align-items-end flex-wrap justify-content-between g-3">
                <div>
                    <div class="input-group">
                        <input type="text" class="form-control" name="search" value="{$SEARCH}" maxlength="64" placeholder="Tìm kiếm từ khóa" aria-label="Tìm kiếm từ khóa">
                        <button type="submit" class="btn btn-primary text-nowrap"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm</button>
                    </div>
                </div>
                <div>
                    Tổng số từ khóa: <strong class="text-danger">{$TOTAL}</strong>
                </div>
            </div>
        </form>
    </div>


    {if not empty($DATA)}
    <div class="card-body">
        <div class="table-responsive-lg table-card" id="list-keywords-items">
            <table class="table table-striped align-middle table-sticky mb-0">
                <thead class="text-muted">
                    <tr>
                        <th class="text-nowrap text-center" style="width: 8%;">Thứ tự</th>
                        <th class="text-nowrap">Tên từ khóa</th>
                        <th class="text-nowrap" style="width: 15%;">Liên kết tĩnh</th>
                        <th class="text-nowrap">Mô tả</th>
                        <th class="text-nowrap" style="width: 8%;">Trạng thái</th>
                        <th class="text-nowrap text-center" style="width: 12%;">Ngày tạo</th>
                        <th class="text-nowrap text-center" style="width: 10%;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $DATA as $keyword}
                    <tr>
                        <td class="text-center">
                            <span class="badge bg-primary change-weight-btn"
                                  style="cursor: pointer;"
                                  data-id="{$keyword.id}"
                                  data-current="{$keyword.weight}"
                                  data-max="{$TOTAL}">{$keyword.weight}</span>
                        </td>
                        <td>
                            <strong>{$keyword.name}</strong>
                            <br><small class="text-muted">ID: {$keyword.id}</small>
                        </td>
                        <td>
                            <code class="text-muted">{$keyword.alias}</code>
                        </td>
                        <td>
                            <small class="text-muted">{$keyword.description|default:'Chưa có mô tả'}</small>
                        </td>
                        <td class="text-center">
                            <div class="form-check form-switch">
                                <input type="checkbox" class="form-check-input status-switch"
                                       id="status_{$keyword.id}" data-id="{$keyword.id}"
                                       {if $keyword.status == 1}checked{/if}>
                            </div>
                        </td>
                        <td class="text-center">
                            <small class="text-muted">{$keyword.add_time_format}</small>
                        </td>
                        <td class="text-center">
                            <div class="btn-group btn-group-sm">
                                <a href="#" class="btn btn-outline-primary" title="Sửa"
                                   data-toggle="add_keywords" data-fc="editKeyword" data-mtitle="Sửa từ khóa" data-kid="{$keyword.id}">
                                    <i class="fa fa-edit"></i>
                                </a>
                                <button type="button" class="btn btn-outline-danger delete-btn"
                                        data-id="{$keyword.id}" data-name="{$keyword.name}" title="Xóa">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
    {if not empty($PAGINATION)}
    <div class="card-footer">
        <div class="d-flex justify-content-center">
            {$PAGINATION}
        </div>
    </div>
    {/if}
    {else}
    <div class="card-body text-center">
        <p class="text-muted">Chưa có từ khóa nào.</p>
        <a href="{$FORM_ACTION}&action=add" class="btn btn-primary">
            <i class="fa fa-plus"></i> Thêm từ khóa đầu tiên
        </a>
    </div>
    {/if}
</div>

<!-- Modal thêm nhiều từ khóa -->
<div class="modal fade" id="mdKeywordMulti" tabindex="-1" aria-labelledby="mdKeywordMultiLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title fs-5 fw-medium" id="mdKeywordMultiLabel">Thêm nhiều từ khóa</div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <form action="{$FORM_ACTION}" method="post" class="keyword-ajax-submit">
                    <input name="savemultikeywords" type="hidden" value="1">
                    <input name="checkss" type="hidden" value="{$smarty.const.NV_CHECK_SESSION}">
                    <div class="mb-3">
                        <label for="element_mkeyword_mtitle" class="form-label">Nhập từ khóa (mỗi dòng một từ khóa):</label>
                        <textarea name="keywords_multi" id="element_mkeyword_mtitle" class="form-control" rows="10" placeholder="PHP&#10;JavaScript&#10;HTML&#10;CSS&#10;Bootstrap"></textarea>
                        <div class="form-text">Mỗi dòng một từ khóa. Hệ thống sẽ tự động tạo liên kết tĩnh.</div>
                    </div>
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">Thêm từ khóa</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal thêm/sửa từ khóa đơn -->
<div class="modal fade" id="mdKeywordSingle" tabindex="-1" aria-labelledby="mdKeywordSingleLabel" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title fs-5 fw-medium" id="mdKeywordSingleLabel"></div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                <form action="{$FORM_ACTION}" method="post" class="keyword-ajax-submit">
                    <input name="savekeyword" type="hidden" value="1">
                    <input name="checkss" type="hidden" value="{$smarty.const.NV_CHECK_SESSION}">
                    <input name="id" type="hidden" value="0">
                    <div class="mb-3">
                        <label for="element_keyword_name" class="form-label">Tên từ khóa <span class="text-danger">*</span>:</label>
                        <input type="text" name="name" id="element_keyword_name" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="element_keyword_alias" class="form-label">Liên kết tĩnh:</label>
                        <div class="input-group">
                            <input type="text" name="alias" id="element_keyword_alias" class="form-control" placeholder="Tự động tạo từ tên từ khóa...">
                            <button type="button" class="btn btn-outline-secondary" id="btn-generate-alias" title="Tạo lại từ tên từ khóa">
                                <i class="fa fa-magic"></i>
                            </button>
                        </div>
                        <div class="form-text">
                            <i class="fa fa-magic text-primary"></i>
                            Tự động tạo từ tên từ khóa. Bạn có thể chỉnh sửa nếu muốn tùy chỉnh
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="element_keyword_description" class="form-label">Mô tả:</label>
                        <textarea name="description" id="element_keyword_description" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="mb-3">
                        <div class="form-check form-switch">
                            <input type="checkbox" name="status" id="element_keyword_status" class="form-check-input" value="1" checked>
                            <label for="element_keyword_status" class="form-check-label">Hoạt động</label>
                        </div>
                    </div>
                    <div class="text-end">
                        <button type="submit" class="btn btn-primary">Lưu từ khóa</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal for Change Weight -->
<div class="modal fade" id="modal-change-weight" tabindex="-1" aria-labelledby="modal-change-weight-label" aria-hidden="true">
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

<script type="text/javascript">
$(document).ready(function() {
    // Biến để ngăn chặn double submit
    var isSubmitting = false;

    // Add keyword modal
    $(document).on('click', '[data-toggle="add_keywords"]', function(e) {
        e.preventDefault();
        var kid = $(this).data('kid') || 0;
        var title = $(this).data('mtitle') || 'Thêm từ khóa';
        var fc = $(this).data('fc') || 'addKeyword';

        $('#mdKeywordSingle .modal-title').text(title);
        $('#mdKeywordSingle input[name="id"]').val(kid);

        if (fc === 'editKeyword' && kid > 0) {
            // Load keyword data for editing
            $.post('{$FORM_ACTION}', {
                getkeyword: 1,
                id: kid,
                checkss: '{$smarty.const.NV_CHECK_SESSION}'
            }, function(res) {
                console.log('Edit keyword response:', res);
                if (res.success && res.data) {
                    // Điền dữ liệu vào form
                    $('#mdKeywordSingle input[name="id"]').val(res.data.id);
                    $('#mdKeywordSingle input[name="name"]').val(res.data.name);
                    $('#mdKeywordSingle input[name="alias"]').val(res.data.alias);
                    $('#mdKeywordSingle textarea[name="description"]').val(res.data.description || '');
                    $('#mdKeywordSingle input[name="status"]').prop('checked', res.data.status == 1);

                    // Đánh dấu alias không tự động tạo nữa
                    $('#mdKeywordSingle input[name="alias"]').data('auto-generated', false);
                } else {
                    alert(res.text || 'Có lỗi xảy ra khi tải dữ liệu từ khóa');
                }
            }, 'json').fail(function() {
                alert('Có lỗi xảy ra khi tải dữ liệu từ khóa');
            });
        } else {
            // Clear form for new keyword
            $('#mdKeywordSingle form')[0].reset();
            $('#mdKeywordSingle input[name="id"]').val(0);
            $('#mdKeywordSingle input[name="status"]').prop('checked', true);
            $('#mdKeywordSingle input[name="alias"]').data('auto-generated', true);
        }

        $('#mdKeywordSingle').modal('show');
    });

    // Auto generate alias from keyword name
    function generateAlias(text) {
        if (!text) return '';

        // Vietnamese to ASCII conversion map
        var vietnameseMap = {
            'à': 'a', 'á': 'a', 'ạ': 'a', 'ả': 'a', 'ã': 'a',
            'â': 'a', 'ầ': 'a', 'ấ': 'a', 'ậ': 'a', 'ẩ': 'a', 'ẫ': 'a',
            'ă': 'a', 'ằ': 'a', 'ắ': 'a', 'ặ': 'a', 'ẳ': 'a', 'ẵ': 'a',
            'è': 'e', 'é': 'e', 'ẹ': 'e', 'ẻ': 'e', 'ẽ': 'e',
            'ê': 'e', 'ề': 'e', 'ế': 'e', 'ệ': 'e', 'ể': 'e', 'ễ': 'e',
            'ì': 'i', 'í': 'i', 'ị': 'i', 'ỉ': 'i', 'ĩ': 'i',
            'ò': 'o', 'ó': 'o', 'ọ': 'o', 'ỏ': 'o', 'õ': 'o',
            'ô': 'o', 'ồ': 'o', 'ố': 'o', 'ộ': 'o', 'ổ': 'o', 'ỗ': 'o',
            'ơ': 'o', 'ờ': 'o', 'ớ': 'o', 'ợ': 'o', 'ở': 'o', 'ỡ': 'o',
            'ù': 'u', 'ú': 'u', 'ụ': 'u', 'ủ': 'u', 'ũ': 'u',
            'ư': 'u', 'ừ': 'u', 'ứ': 'u', 'ự': 'u', 'ử': 'u', 'ữ': 'u',
            'ỳ': 'y', 'ý': 'y', 'ỵ': 'y', 'ỷ': 'y', 'ỹ': 'y',
            'đ': 'd'
        };

        // Convert Vietnamese characters
        text = text.toLowerCase();
        for (var char in vietnameseMap) {
            var regex = new RegExp(char, 'g');
            text = text.replace(regex, vietnameseMap[char]);
        }

        return text
            .replace(/[^a-z0-9\s-]/g, '') // Remove special characters
            .replace(/\s+/g, '-') // Replace spaces with hyphens
            .replace(/-+/g, '-') // Replace multiple hyphens with single
            .replace(/^-|-$/g, ''); // Remove leading/trailing hyphens
    }

    // Auto-generate alias when typing keyword name
    $(document).on('input', '#element_keyword_name', function() {
        var name = $(this).val();
        var aliasField = $('#element_keyword_alias');
        var isAutoGenerated = aliasField.data('auto-generated') !== false;

        // Only auto-generate if field is empty or was auto-generated before
        if (isAutoGenerated || aliasField.val() === '') {
            var alias = generateAlias(name);
            aliasField.val(alias).data('auto-generated', true);
        }
    });

    // Mark alias as manually edited when user types in it
    $(document).on('input', '#element_keyword_alias', function() {
        $(this).data('auto-generated', false);
    });

    // Manual generate alias button
    $(document).on('click', '#btn-generate-alias', function() {
        var name = $('#element_keyword_name').val();
        var alias = generateAlias(name);
        $('#element_keyword_alias').val(alias).data('auto-generated', true);
    });

    // Handle AJAX form submission với cơ chế ngăn chặn double submit
    // Sử dụng class riêng để tránh conflict với nv.core.js
    $(document).on('submit', '.keyword-ajax-submit', function(e) {
        e.preventDefault();
        e.stopImmediatePropagation(); // Ngăn chặn các event handler khác

        // Kiểm tra xem có đang submit không
        if (isSubmitting) {
            return false;
        }

        var form = $(this);
        var btn = form.find('button[type="submit"]');
        var originalText = btn.html();

        // Đánh dấu đang submit
        isSubmitting = true;
        btn.html('<i class="fa fa-spinner fa-spin"></i> Đang xử lý...').prop('disabled', true);

        $.ajax({
            url: location.href,
            type: 'POST',
            data: form.serialize(),
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    $('#mdKeywordSingle').modal('hide');
                    $('#mdKeywordMulti').modal('hide');
                    nukeviet.toast(response.mess, 'success');
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                } else {
                    nukeviet.toast(response.mess, 'error');
                }
            },
            error: function() {
                nukeviet.toast('Có lỗi xảy ra khi xử lý yêu cầu', 'error');
            },
            complete: function() {
                // Reset trạng thái submit
                isSubmitting = false;
                btn.html(originalText).prop('disabled', false);
            }
        });

        return false;
    });
    // Delete keyword
    $('.delete-btn').click(function() {
        var id = $(this).data('id');
        var name = $(this).data('name');

        if (confirm('Bạn có chắc chắn muốn xóa từ khóa "' + name + '"?')) {
            var btn = $(this);
            var originalText = btn.html();
            btn.html('<i class="fa fa-spinner fa-spin"></i>').prop('disabled', true);

            $.ajax({
                url: '{$FORM_ACTION}',
                type: 'POST',
                data: {
                    ajax: 1,
                    ajax_action: 'delete',
                    id: id
                },
                dataType: 'json',
                success: function(response) {
                    if (response.status === 'success') {
                        nukeviet.toast(response.mess, 'success');
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    } else {
                        nukeviet.toast(response.mess, 'error');
                        btn.html(originalText).prop('disabled', false);
                    }
                },
                error: function() {
                    nukeviet.toast('Có lỗi xảy ra khi xóa từ khóa', 'error');
                    btn.html(originalText).prop('disabled', false);
                }
            });
        }
    });

    // Change status
    $('.status-switch').change(function() {
        var id = $(this).data('id');
        var status = $(this).is(':checked') ? 1 : 0;
        var switchElement = $(this);

        $.ajax({
            url: '{$FORM_ACTION}',
            type: 'POST',
            data: {
                ajax: 1,
                ajax_action: 'change_status',
                id: id,
                status: status
            },
            dataType: 'json',
            success: function(response) {
                if (response.status === 'success') {
                    nukeviet.toast(response.mess, 'success');
                } else {
                    nukeviet.toast(response.mess, 'error');
                    // Revert switch
                    switchElement.prop('checked', !switchElement.is(':checked'));
                }
            },
            error: function() {
                nukeviet.toast('Có lỗi xảy ra khi cập nhật trạng thái', 'error');
                // Revert switch
                switchElement.prop('checked', !switchElement.is(':checked'));
            }
        });
    });

    // Weight change functionality using modal
    var currentWeightData = {};

    // Handle click on weight badge
    $('body').on('click', '.change-weight-btn', function() {
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
    $('#weight-up').on('click', function() {
        var input = $('#weight-input');
        var current = parseInt(input.val()) || 1;
        var max = parseInt(input.attr('max'));

        if (current < max) {
            input.val(current + 1);
        }
    });

    $('#weight-down').on('click', function() {
        var input = $('#weight-input');
        var current = parseInt(input.val()) || 1;

        if (current > 1) {
            input.val(current - 1);
        }
    });

    // Handle save weight
    $('#btn-save-weight').on('click', function() {
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
            $(this).prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Đang lưu...');

            $.ajax({
                url: '{$FORM_ACTION}',
                type: 'POST',
                data: {
                    action: 'change_weight',
                    id: id,
                    new_weight: new_weight,
                    checkss: '{$smarty.const.NV_CHECK_SESSION}'
                },
                success: function(res) {
                    if (res.indexOf('OK_') === 0) {
                        $('#modal-change-weight').modal('hide');
                        nukeviet.toast('Cập nhật thứ tự thành công', 'success');
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    } else {
                        nukeviet.toast('Lỗi khi cập nhật thứ tự: ' + res, 'error');
                    }
                },
                error: function() {
                    nukeviet.toast('Lỗi kết nối', 'error');
                },
                complete: function() {
                    $('#btn-save-weight').prop('disabled', false).html('<i class="fa-solid fa-check"></i> Cập nhật');
                }
            });
        } else {
            $('#modal-change-weight').modal('hide');
        }
    });
});
</script>