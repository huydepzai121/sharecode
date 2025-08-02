<div class="page-header">
    <h1><i class="fa fa-folder"></i> {$LANG->getModule('admin_categories')} <small class="text-muted">Quản lý danh mục</small></h1>
</div>

<div class="row">
    <div class="col-md-5">
        <div class="card">
            <div class="card-header text-bg-primary">
                <div class="fw-medium">
                    <i class="fa-solid fa-{if $IS_EDIT}edit{else}plus{/if}"></i> 
                    {if $IS_EDIT}Sửa danh mục{else}Thêm danh mục mới{/if}
                </div>
            </div>
            <div class="card-body">
                {if isset($ERRORS) and !empty($ERRORS)}
                <div class="alert alert-danger">
                    <ul class="mb-0">
                        {foreach from=$ERRORS item=error}
                        <li>{$error}</li>
                        {/foreach}
                    </ul>
                </div>
                {/if}
                
                <form action="{$FORM_ACTION}" method="post">
                    <div class="mb-3">
                        <label for="title" class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="title" id="title" value="{$DATA.title}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="alias" class="form-label">Liên kết tĩnh</label>
                        <input type="text" class="form-control" name="alias" id="alias" value="{$DATA.alias}">
                        <small class="form-text text-muted">Sẽ tự động tạo từ tên danh mục</small>
                    </div>
                    
                    {* Parent category removed as per issue #1 *}
                    
                    <div class="mb-3">
                        <label for="description" class="form-label">Mô tả</label>
                        <textarea class="form-control" name="description" id="description" rows="3">{$DATA.description}</textarea>
                    </div>
                    
                    {* Weight/order display removed as per issue #1 *}
                    
                    <div class="mb-3">
                        <label for="status" class="form-label">Trạng thái</label>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="status" id="status" value="1" {if $DATA.status}checked{/if}>
                            <label class="form-check-label" for="status">
                                Hoạt động
                            </label>
                        </div>
                    </div>
                    
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary" name="save">
                            <i class="fa fa-save"></i> Lưu danh mục
                        </button>
                        {if $IS_EDIT}
                        <a href="{$smarty.const.NV_BASE_ADMINURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}={$MODULE_NAME}&{$smarty.const.NV_OP_VARIABLE}={$OP}" class="btn btn-secondary">
                            <i class="fa fa-ban"></i> Hủy
                        </a>
                        {/if}
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-md-7">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fa fa-list"></i> Danh sách danh mục
                </h5>
            </div>
            <div class="card-body">
                {if $CATEGORIES}
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th width="50">ID</th>
                                <th>Tên danh mục</th>
                                <th width="100">Trạng thái</th>
                                <th width="120">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $CATEGORIES as $category}
                            <tr>
                                <td>{$category.id}</td>
                                <td>
                                    <strong>{$category.title}</strong>
                                    {if $category.alias}<br><small class="text-muted">{$category.alias}</small>{/if}
                                </td>
                                <td>
                                    <span class="badge bg-{$category.status_class}">{$category.status_text}</span>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <a href="{$category.edit_url}" class="btn btn-primary btn-sm" title="Sửa">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <a href="javascript:void(0);" onclick="nv_del_category({$category.id});" class="btn btn-danger btn-sm" title="Xóa">
                                            <i class="fa fa-trash"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
                {else}
                <div class="alert alert-info">
                    Chưa có danh mục nào. Vui lòng thêm danh mục mới.
                </div>
                {/if}
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
function nv_del_category(id) {
    if (confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
        window.location.href = '{$BASE_URL}&action=delete&id=' + id + '&confirm=' + nv_md5(id + '{$smarty.const.NV_CHECK_SESSION}');
    }
}

// Auto-fill static link from title (Issue #1 fix)
$(document).ready(function() {
    var aliasField = $('#alias');
    var titleField = $('#title');
    var isEditMode = {if $IS_EDIT}true{else}false{/if};
    
    // Only auto-fill if alias is empty or if we're creating new category
    titleField.on('input keyup', function() {
        if (!isEditMode || aliasField.val() === '') {
            var title = $(this).val();
            var alias = nv_create_alias(title);
            aliasField.val(alias);
        }
    });
    
    // Allow manual editing of alias but still auto-clean it
    aliasField.on('blur', function() {
        var alias = $(this).val();
        if (alias !== '') {
            $(this).val(nv_create_alias(alias));
        }
    });
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
</script>
