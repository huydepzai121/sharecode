<?php
/**
 * Demo Extension Template Handler
 * Demonstrates how to handle both Smarty and XTemplate in NukeViet extensions
 */

// Security check
if (!in_array($_SERVER['REMOTE_ADDR'], ['127.0.0.1', '::1']) && !isset($_GET['force'])) {
    die('Access denied. This script can only be run from localhost.');
}

// Simulate NukeViet environment
define('NV_ROOTDIR', __DIR__);
define('NV_LANG_DATA', 'vi');

echo "<h1>🎨 NukeViet Extension Template Demo</h1>";

// Demo data
$demo_data = [
    ['id' => 1, 'name' => 'Item 1', 'status' => 1, 'created' => '2024-01-01'],
    ['id' => 2, 'name' => 'Item 2', 'status' => 0, 'created' => '2024-01-02'],
    ['id' => 3, 'name' => 'Item 3', 'status' => 1, 'created' => '2024-01-03'],
];

$template_variables = [
    'MODULE_NAME' => 'demo_extension',
    'PAGE_TITLE' => 'Demo Extension',
    'DATA' => $demo_data,
    'TOTAL_ITEMS' => count($demo_data),
    'CURRENT_TIME' => date('Y-m-d H:i:s'),
    'ACTIONS' => [
        ['value' => '', 'title' => '-- Chọn thao tác --'],
        ['value' => 'delete', 'title' => 'Xóa đã chọn'],
        ['value' => 'active', 'title' => 'Kích hoạt đã chọn'],
        ['value' => 'inactive', 'title' => 'Vô hiệu hóa đã chọn']
    ]
];

echo "<h2>📊 Demo Data</h2>";
echo "<pre>" . json_encode($template_variables, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE) . "</pre>";

echo "<h2>🔧 Template Engine Detection Logic</h2>";
echo "<div style='background: #f5f5f5; padding: 15px; border-radius: 5px;'>";
echo "<h3>PHP Code:</h3>";
echo "<pre><code>";
echo htmlspecialchars('
function detectTemplateEngine($template_dir) {
    // Check if admin_future theme (Smarty)
    if (strpos($template_dir, "admin_future") !== false) {
        return "smarty";
    }
    
    // Check if admin_default theme (XTemplate)  
    if (strpos($template_dir, "admin_default") !== false) {
        return "xtemplate";
    }
    
    // Default fallback
    return "xtemplate";
}

function renderTemplate($template_engine, $data, $template_file) {
    switch ($template_engine) {
        case "smarty":
            $tpl = new \NukeViet\Template\NVSmarty();
            $tpl->setTemplateDir($template_dir);
            foreach ($data as $key => $value) {
                $tpl->assign($key, $value);
            }
            return $tpl->fetch($template_file);
            
        case "xtemplate":
            $xtpl = new XTemplate($template_file, $template_dir);
            $xtpl->assign("LANG", $lang_module);
            foreach ($data as $key => $value) {
                $xtpl->assign($key, $value);
            }
            // Handle loops for XTemplate
            if (isset($data["DATA"])) {
                foreach ($data["DATA"] as $item) {
                    $xtpl->assign("ITEM", $item);
                    $xtpl->parse("main.loop");
                }
            }
            $xtpl->parse("main");
            return $xtpl->text("main");
    }
}
');
echo "</code></pre>";
echo "</div>";

echo "<h2>🎨 Smarty Template Example</h2>";
echo "<div style='background: #e8f5e8; padding: 15px; border-radius: 5px;'>";
echo "<h3>File: themes/admin_future/modules/demo_extension/main.tpl</h3>";
echo "<pre><code>";
echo htmlspecialchars('
<div class="card">
    <div class="card-header text-bg-primary">
        <h5 class="card-title mb-0">
            <i class="fa-solid fa-list"></i> {$PAGE_TITLE}
        </h5>
    </div>
    <div class="card-body">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <strong>Module:</strong> {$MODULE_NAME}<br>
                <strong>Total Items:</strong> {$TOTAL_ITEMS}<br>
                <strong>Generated:</strong> {$CURRENT_TIME}
            </div>
            <div>
                <button class="btn btn-primary" data-toggle="add">
                    <i class="fa-solid fa-plus"></i> Add New
                </button>
            </div>
        </div>
        
        {if isset($DATA) and !empty($DATA)}
        <div class="table-responsive">
            <table class="table table-striped align-middle">
                <thead class="table-dark">
                    <tr>
                        <th style="width: 1%;">
                            <input type="checkbox" data-toggle="checkAll" class="form-check-input">
                        </th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th style="width: 1%;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach from=$DATA item=item}
                    <tr>
                        <td>
                            <input type="checkbox" data-toggle="checkSingle" value="{$item.id}" class="form-check-input">
                        </td>
                        <td><span class="badge bg-secondary">#{$item.id}</span></td>
                        <td><strong>{$item.name}</strong></td>
                        <td>
                            {if $item.status}
                            <span class="badge bg-success">Active</span>
                            {else}
                            <span class="badge bg-danger">Inactive</span>
                            {/if}
                        </td>
                        <td>{$item.created}</td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <button class="btn btn-outline-primary" data-toggle="edit" data-id="{$item.id}">
                                    <i class="fa-solid fa-edit"></i>
                                </button>
                                <button class="btn btn-outline-danger" data-toggle="delete" data-id="{$item.id}">
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
        <div class="alert alert-info text-center">
            <i class="fa-solid fa-info-circle"></i> No data available.
        </div>
        {/if}
    </div>
    
    {if isset($DATA) and !empty($DATA)}
    <div class="card-footer">
        <div class="d-flex justify-content-between align-items-center">
            <div class="d-flex align-items-center">
                <input type="checkbox" data-toggle="checkAll" class="form-check-input me-2">
                <select class="form-select form-select-sm me-2" style="width: auto;" id="bulk-action">
                    {foreach from=$ACTIONS item=action}
                    <option value="{$action.value}">{$action.title}</option>
                    {/foreach}
                </select>
                <button class="btn btn-sm btn-primary" data-toggle="bulkAction">
                    Execute
                </button>
            </div>
            <div>
                <small class="text-muted">Total: {$TOTAL_ITEMS} items</small>
            </div>
        </div>
    </div>
    {/if}
</div>

<script>
$(document).ready(function() {
    // Bulk action handler
    $("[data-toggle=\"bulkAction\"]").on("click", function() {
        var action = $("#bulk-action").val();
        var selectedIds = [];
        
        $("input[data-toggle=\"checkSingle\"]:checked").each(function() {
            selectedIds.push($(this).val());
        });
        
        if (selectedIds.length === 0) {
            alert("Please select at least one item");
            return;
        }
        
        if (!action) {
            alert("Please select an action");
            return;
        }
        
        console.log("Bulk action:", action, "IDs:", selectedIds);
        alert("Action: " + action + "\\nSelected IDs: " + selectedIds.join(", "));
    });
    
    // Check all functionality
    $("[data-toggle=\"checkAll\"]").on("change", function() {
        var isChecked = $(this).is(":checked");
        $("input[data-toggle=\"checkSingle\"]").prop("checked", isChecked);
    });
});
</script>
');
echo "</code></pre>";
echo "</div>";

echo "<h2>📝 XTemplate Example</h2>";
echo "<div style='background: #fff5e6; padding: 15px; border-radius: 5px;'>";
echo "<h3>File: themes/admin_default/modules/demo_extension/main.tpl</h3>";
echo "<pre><code>";
echo htmlspecialchars('
<!-- BEGIN: main -->
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">
            <i class="fa fa-list"></i> {PAGE_TITLE}
        </h3>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-8">
                <p><strong>Module:</strong> {MODULE_NAME}</p>
                <p><strong>Total Items:</strong> {TOTAL_ITEMS}</p>
                <p><strong>Generated:</strong> {CURRENT_TIME}</p>
            </div>
            <div class="col-md-4 text-right">
                <button class="btn btn-primary" onclick="addNew()">
                    <i class="fa fa-plus"></i> Add New
                </button>
            </div>
        </div>
        
        <!-- BEGIN: has_data -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th width="1%">
                            <input type="checkbox" id="checkAll" onchange="toggleAll(this)">
                        </th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Status</th>
                        <th>Created</th>
                        <th width="1%">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- BEGIN: loop -->
                    <tr>
                        <td>
                            <input type="checkbox" name="selected[]" value="{ITEM.id}" class="item-checkbox">
                        </td>
                        <td><span class="label label-default">#{ITEM.id}</span></td>
                        <td><strong>{ITEM.name}</strong></td>
                        <td>
                            <!-- BEGIN: active -->
                            <span class="label label-success">Active</span>
                            <!-- END: active -->
                            <!-- BEGIN: inactive -->
                            <span class="label label-danger">Inactive</span>
                            <!-- END: inactive -->
                        </td>
                        <td>{ITEM.created}</td>
                        <td>
                            <div class="btn-group btn-group-xs">
                                <button class="btn btn-primary" onclick="editItem({ITEM.id})">
                                    <i class="fa fa-edit"></i>
                                </button>
                                <button class="btn btn-danger" onclick="deleteItem({ITEM.id})">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <!-- END: loop -->
                </tbody>
            </table>
        </div>
        
        <div class="row">
            <div class="col-md-6">
                <div class="form-inline">
                    <input type="checkbox" id="checkAllBottom" onchange="toggleAll(this)">
                    <select class="form-control input-sm" id="bulkAction" style="margin: 0 5px;">
                        <!-- BEGIN: action_option -->
                        <option value="{ACTION.value}">{ACTION.title}</option>
                        <!-- END: action_option -->
                    </select>
                    <button class="btn btn-sm btn-primary" onclick="executeBulkAction()">
                        Execute
                    </button>
                </div>
            </div>
            <div class="col-md-6 text-right">
                <small class="text-muted">Total: {TOTAL_ITEMS} items</small>
            </div>
        </div>
        <!-- END: has_data -->
        
        <!-- BEGIN: no_data -->
        <div class="alert alert-info text-center">
            <i class="fa fa-info-circle"></i> No data available.
        </div>
        <!-- END: no_data -->
    </div>
</div>

<script>
function toggleAll(checkbox) {
    var checkboxes = document.querySelectorAll(".item-checkbox");
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = checkbox.checked;
    }
    
    // Sync both check all checkboxes
    document.getElementById("checkAll").checked = checkbox.checked;
    document.getElementById("checkAllBottom").checked = checkbox.checked;
}

function executeBulkAction() {
    var action = document.getElementById("bulkAction").value;
    var selectedIds = [];
    var checkboxes = document.querySelectorAll(".item-checkbox:checked");
    
    for (var i = 0; i < checkboxes.length; i++) {
        selectedIds.push(checkboxes[i].value);
    }
    
    if (selectedIds.length === 0) {
        alert("Please select at least one item");
        return;
    }
    
    if (!action) {
        alert("Please select an action");
        return;
    }
    
    console.log("Bulk action:", action, "IDs:", selectedIds);
    alert("Action: " + action + "\\nSelected IDs: " + selectedIds.join(", "));
}

function addNew() {
    alert("Add new item functionality");
}

function editItem(id) {
    alert("Edit item ID: " + id);
}

function deleteItem(id) {
    if (confirm("Are you sure you want to delete item #" + id + "?")) {
        alert("Delete item ID: " + id);
    }
}
</script>
<!-- END: main -->
');
echo "</code></pre>";
echo "</div>";

echo "<h2>🚀 Key Differences Summary</h2>";
echo "<table border='1' cellpadding='10' style='border-collapse: collapse; width: 100%;'>";
echo "<tr style='background: #f0f0f0;'>";
echo "<th>Aspect</th><th>Smarty (admin_future)</th><th>XTemplate (admin_default)</th>";
echo "</tr>";
echo "<tr>";
echo "<td><strong>Syntax</strong></td>";
echo "<td><code>{\$variable}</code>, <code>{foreach}</code>, <code>{if}</code></td>";
echo "<td><code>{VARIABLE}</code>, <code>&lt;!-- BEGIN: block --&gt;</code></td>";
echo "</tr>";
echo "<tr>";
echo "<td><strong>Loops</strong></td>";
echo "<td><code>{foreach from=\$DATA item=item}</code></td>";
echo "<td><code>&lt;!-- BEGIN: loop --&gt;</code> + PHP parse</td>";
echo "</tr>";
echo "<tr>";
echo "<td><strong>Conditions</strong></td>";
echo "<td><code>{if \$item.status}...{else}...{/if}</code></td>";
echo "<td>Separate blocks: <code>&lt;!-- BEGIN: active --&gt;</code></td>";
echo "</tr>";
echo "<tr>";
echo "<td><strong>JavaScript</strong></td>";
echo "<td>Modern jQuery/ES6 syntax</td>";
echo "<td>Traditional JavaScript functions</td>";
echo "</tr>";
echo "<tr>";
echo "<td><strong>CSS Framework</strong></td>";
echo "<td>Bootstrap 5 classes</td>";
echo "<td>Bootstrap 3 classes</td>";
echo "</tr>";
echo "</table>";

echo "<hr>";
echo "<p><strong>📁 Files created:</strong></p>";
echo "<ul>";
echo "<li><code>NUKEVIET_ADMIN_FLOW_ANALYSIS.md</code> - Complete flow analysis</li>";
echo "<li><code>demo_extension_template.php</code> - This demo file</li>";
echo "</ul>";

echo "<p><em>This demo provides practical examples for developing NukeViet extensions with dual template engine support.</em></p>";
?>
