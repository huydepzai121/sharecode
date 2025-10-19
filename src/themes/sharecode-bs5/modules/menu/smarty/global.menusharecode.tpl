{*
 * NukeViet Content Management System - ShareCode Menu with User Button
 * @version 5.x
 * @author VINADES.,JSC <contact@vinades.vn>
 * @copyright (C) 2009-2025 VINADES.,JSC. All rights reserved
 * @license GNU/GPL version 2 or any later version
 * @see https://github.com/nukeviet The NukeViet CMS GitHub project
*}

{function name=menu data=[]}
{$i = 0}
{if count($data) > 0}
{foreach $data as $entry}
{if $i==0}
<ul class="{if $entry.parentid==0}nv-menu-nav-list{else}nv-menu-submenu{/if}">
{if $entry.parentid==0}
<li class="nv-menu-nav-item"><a class="nv-menu-nav-link nv-menu-home" title="{$LANG->getGlobal('Home')}" href="{$THEME_SITE_HREF}" rel="dofollow"><i class="fa fa-home me-2"></i><span class="nv-menu-home-text">{$LANG->getGlobal('Home')}</span></a></li>
{/if}
{/if}
{strip}<li class="{if $entry.parentid==0}nv-menu-nav-item{else}nv-menu-submenu-item{/if}{if !empty($entry.sub)} nv-menu-has-submenu{/if}{if $entry.is_active} nv-menu-active{/if}{if !empty($entry.css)} {$entry.css}{/if}">
        <a href="{$entry.link}" rel="dofollow" class="{if $entry.parentid==0}nv-menu-nav-link{else}nv-menu-submenu-link{/if}"{if !empty($entry.note)} title="{$entry.note}"{/if}{if !empty($entry.target)} {$entry.target}{/if}>
            {if !empty($entry.icon)}<img src="{$entry.icon}" alt="" class="nv-menu-icon me-2" />{/if}
            {$entry.title_trim}
        </a>
{if !empty($entry.sub)}
{call name=menu data=$entry.sub}
{/if}
</li>{/strip}
{$i=$i+1}
{/foreach}
{if $i > 0}
</ul>
{/if}
{/if}
{/function}

<!-- CSS Inline cho ShareCode Menu với User Button -->
<style>
/* Reset và Base Styles cho ShareCode Menu */
.nv-menu-header {
    background: #FFFFFF;
    border-bottom: 1px solid #E5E7EB;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    width: 100%;
    z-index: 1000;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    padding: 12px 0;
}

/* Thêm padding-top cho body để tránh bị che bởi fixed header */
body {
    padding-top: 80px;
}

/* Menu Navigation Styles */
.nv-menu-nav {
    display: flex;
    align-items: center;
    justify-content: center;
    flex: 1;
}

.nv-menu-nav-list {
    display: flex;
    align-items: center;
    gap: 8px;
    margin: 0;
    padding: 0;
    list-style: none;
}

.nv-menu-nav-item {
    position: relative;
}

.nv-menu-nav-link {
    display: flex;
    align-items: center;
    gap: 6px;
    padding: 12px 16px;
    color: #4B5563;
    text-decoration: none;
    font-weight: 500;
    font-size: 14px;
    border-radius: 8px;
    transition: all 0.2s ease;
    white-space: nowrap;
}

.nv-menu-nav-link:hover {
    color: #4F46E5;
    background: #F3F4F6;
    text-decoration: none;
}

/* Active state */
.nv-menu-active > .nv-menu-nav-link {
    color: #4F46E5;
    background: #EEF2FF;
}

.nv-menu-logo {
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
    color: #111827;
    font-weight: 600;
    font-size: 18px;
}

.nv-menu-nav {
    display: flex;
    align-items: center;
}

.nv-menu-nav-list {
    display: flex;
    align-items: center;
    gap: 20px;
    list-style: none;
    margin: 0;
    padding: 0;
}

.nv-menu-nav-item {
    position: relative;
}

.nv-menu-submenu-item {
    position: relative;
}

.nv-menu-nav-link {
    color: #4B5563;
    text-decoration: none;
    padding: 8px 10px;
    border-radius: 6px;
    transition: all 0.2s ease;
    font-size: 14px;
    font-weight: 500;
    display: inline-flex;
    align-items: center;
    gap: 6px;
}

.nv-menu-nav-link:hover {
    color: #4F46E5;
    text-decoration: none;
}

.nv-menu-home {
    color: #4F46E5;
}

.nv-menu-home-text {
    display: none;
}

.nv-menu-icon {
    width: 16px;
    height: 16px;
    margin-right: 4px;
}

/* Dropdown arrow cho menu có submenu */
.nv-menu-has-submenu > .nv-menu-nav-link::after {
    content: '';
    display: inline-block;
    width: 6px;
    height: 6px;
    border-right: 1.5px solid currentColor;
    border-bottom: 1.5px solid currentColor;
    transform: rotate(45deg);
    margin-left: 4px;
    transition: transform 0.2s ease;
    opacity: 1;
}

.nv-menu-nav-item:hover > .nv-menu-nav-link::after {
    transform: rotate(225deg);
}

/* Arrow cho submenu item có nested submenu */
.nv-menu-has-submenu > .nv-menu-submenu-link {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.nv-menu-has-submenu > .nv-menu-submenu-link::after {
    content: '';
    width: 6px;
    height: 6px;
    border-right: 1.5px solid currentColor;
    border-bottom: 1.5px solid currentColor;
    transform: rotate(-45deg);
    transition: transform 0.2s ease;
    opacity: 1;
    flex-shrink: 0;
}

.nv-menu-submenu-item:hover > .nv-menu-submenu-link::after {
    transform: rotate(135deg);
}

/* Submenu Styles */
.nv-menu-submenu {
    position: absolute;
    top: calc(100% + 12px);
    left: 0;
    display: flex;
    flex-direction: column;
    gap: 4px;
    list-style: none;
    background: #FFFFFF;
    border: 1px solid #E5E7EB;
    border-radius: 12px;
    padding: 12px;
    box-shadow: 0 20px 40px rgba(15, 23, 42, 0.12);
    opacity: 0;
    visibility: hidden;
    transform: translateY(-8px);
    transition: opacity 0.2s ease, transform 0.2s ease, visibility 0.2s;
    min-width: 160px;
    z-index: 1100;
    margin: 0;
}

/* Nested submenu positioning */
.nv-menu-submenu .nv-menu-submenu {
    top: 0;
    left: calc(100% + 12px);
}

.nv-menu-submenu-item:hover > .nv-menu-submenu {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.nv-menu-nav-item:hover > .nv-menu-submenu {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.nv-menu-submenu-link {
    display: block;
    padding: 8px 10px;
    border-radius: 8px;
    color: #4B5563;
    font-size: 13px;
    font-weight: 500;
    text-decoration: none;
    transition: background 0.2s ease, color 0.2s ease;
}

.nv-menu-submenu-link:hover {
    background: #EEF2FF;
    color: #4F46E5;
    text-decoration: none;
}



/* Active state */
.nv-menu-active > .nv-menu-nav-link {
    color: #4F46E5;
    background: #EEF2FF;
}

/* Mobile Toggle Button */
.nv-menu-mobile-toggle {
    display: none;
    background: none;
    border: none;
    cursor: pointer;
    padding: 8px;
    border-radius: 6px;
    transition: background 0.2s ease;
}

.nv-menu-mobile-toggle:hover {
    background: #F3F4F6;
}

.nv-menu-mobile-toggle span {
    display: block;
    width: 20px;
    height: 2px;
    background: #4B5563;
    margin: 3px 0;
    transition: 0.3s;
}

/* Responsive Design */
@media (max-width: 768px) {
    .nv-menu-container {
        padding: 0 20px;
    }

    .nv-menu-header-content {
        flex-wrap: wrap;
        gap: 12px;
    }

    .nv-menu-nav {
        order: 3;
        flex-basis: 100%;
        justify-content: center;
        margin-top: 12px;
        display: none;
    }

    .nv-menu-nav.nv-menu-show {
        display: flex;
    }

    .nv-menu-nav-list {
        flex-wrap: wrap;
        justify-content: center;
        gap: 12px;
        flex-direction: column;
        width: 100%;
    }

    .nv-menu-nav-item {
        width: 100%;
        text-align: center;
    }

    .nv-menu-submenu {
        position: static;
        opacity: 1;
        visibility: visible;
        transform: none;
        box-shadow: none;
        border: 1px solid #E5E7EB;
        margin-top: 8px;
        padding: 8px 10px;
        background: #F9FAFB;
    }

    .nv-menu-submenu .nv-menu-submenu {
        position: static;
        margin-top: 4px;
        padding-left: 12px;
        border-left: 2px solid #E5E7EB;
        border-radius: 0;
        background: transparent;
    }

    .nv-menu-submenu-link {
        padding: 6px 0;
    }



    .nv-menu-mobile-toggle {
        display: block;
    }

    .nv-menu-home-text {
        display: inline;
    }

    /* Điều chỉnh spacer cho mobile */
    .nv-menu-spacer {
        height: 60px;
    }
}

/* User Button Styles */
.user-button-area {
    display: flex;
    align-items: center;
    position: relative;
}

.user-button-area .dropdown {
    position: static;
}

.user-button-area .btn {
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    padding: 8px 12px;
    transition: all 0.2s ease;
    border: 1px solid #E5E7EB;
    background: #FFFFFF;
    color: #4B5563;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
}

.user-button-area .btn:hover {
    background: #F3F4F6;
    border-color: #D1D5DB;
    color: #374151;
    text-decoration: none;
}

.user-button-area .btn-outline-primary {
    background: transparent;
    border-color: #4F46E5;
    color: #4F46E5;
}

.user-button-area .btn-outline-primary:hover {
    background: #4F46E5;
    border-color: #4F46E5;
    color: #FFFFFF;
}

.user-button-area .btn-outline-success {
    background: transparent;
    border-color: #10B981;
    color: #10B981;
}

.user-button-area .btn-outline-success:hover {
    background: #10B981;
    border-color: #10B981;
    color: #FFFFFF;
}

.user-button-area img {
    border-radius: 50%;
    object-fit: cover;
}

.user-button-area .badge {
    font-size: 10px;
    padding: 2px 4px;
}

/* Dropdown Menu Styles */
.user-button-area .dropdown-menu {
    border: 1px solid #E5E7EB;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
    border-radius: 8px;
    margin-top: 8px;
    background: #FFFFFF;
}

.user-button-area .dropdown-menu .card {
    border-radius: 8px;
    background: #FFFFFF;
}

.user-button-area .dropdown-menu .card-header {
    border-radius: 8px 8px 0 0;
}

.user-button-area .dropdown-menu .card-body {
    background: #FFFFFF !important;
    color: #000000 !important;
}

/* Đảm bảo text có màu đen trên background trắng */
.user-button-area .dropdown-menu .list-group-item {
    background: #FFFFFF !important;
    color: #000000 !important;
}

.user-button-area .dropdown-menu .list-group-item:hover {
    background: #F3F4F6 !important;
    color: #000000 !important;
}

.user-button-area .dropdown-menu .text-dark {
    color: #000000 !important;
}

.user-button-area .dropdown-menu p,
.user-button-area .dropdown-menu span,
.user-button-area .dropdown-menu div {
    color: #000000 !important;
}

/* Form Styles trong dropdown */
.user-button-area .form-control {
    border-radius: 6px;
    background: #FFFFFF !important;
    color: #000000 !important;
    border: 1px solid #D1D5DB;
}

.user-button-area .form-control::placeholder {
    color: #000000 !important;
}

.user-button-area .input-group-text {
    border-radius: 6px 0 0 6px;
    background: #F9FAFB !important;
    color: #000000 !important;
    border: 1px solid #D1D5DB;
}

.user-button-area .form-control:focus {
    border-color: #4F46E5;
    box-shadow: 0 0 0 0.2rem rgba(79, 70, 229, 0.25);
    background: #FFFFFF !important;
    color: #000000 !important;
}

.user-button-area .form-label {
    color: #000000 !important;
    font-weight: 600;
}

.user-button-area .btn {
    color: #000000 !important;
}

.user-button-area .btn-outline-secondary {
    color: #000000 !important;
    border-color: #D1D5DB !important;
}

.user-button-area .btn-outline-secondary:hover {
    background: #F3F4F6 !important;
    color: #000000 !important;
}

.user-button-area .btn-link {
    color: #4F46E5 !important;
}

/* Đảm bảo tất cả text trong dropdown đều màu đen */
.user-button-area .dropdown-menu * {
    color: #000000 !important;
}

/* Ngoại trừ các element có màu đặc biệt */
.user-button-area .dropdown-menu .text-white,
.user-button-area .dropdown-menu .text-primary,
.user-button-area .dropdown-menu .text-success,
.user-button-area .dropdown-menu .text-danger,
.user-button-area .dropdown-menu .text-warning,
.user-button-area .dropdown-menu .text-info,
.user-button-area .dropdown-menu .btn-primary,
.user-button-area .dropdown-menu .btn-success,
.user-button-area .dropdown-menu .btn-danger,
.user-button-area .dropdown-menu .btn-warning,
.user-button-area .dropdown-menu .btn-info,
.user-button-area .dropdown-menu .bg-primary *,
.user-button-area .dropdown-menu .bg-success *,
.user-button-area .dropdown-menu .bg-danger *,
.user-button-area .dropdown-menu .bg-warning *,
.user-button-area .dropdown-menu .bg-info * {
    color: inherit !important;
}

/* Responsive cho mobile */
@media (max-width: 768px) {
    .user-button-area .btn {
        font-size: 13px;
        padding: 6px 10px;
    }

    .user-button-area .dropdown-menu {
        min-width: 280px !important;
        max-width: calc(100vw - 20px);
    }
}
</style>

<!-- ShareCode Header Menu Structure với User Button -->
<div class="nv-menu-header">
    <div class="container d-flex align-items-center">
        <div class="row w-100 align-items-center">
            <!-- Mobile Toggle Button -->
            <div class="col-auto d-md-none">
                <button type="button" class="nv-menu-mobile-toggle" onclick="toggleMobileMenu()">
                    <span></span>
                    <span></span>
                    <span></span>
                </button>
            </div>

            <!-- Navigation Menu -->
            <div class="col">
                <nav class="nv-menu-nav" id="nv-menu-nav">
                    {call name=menu data=$MENU}
                </nav>
            </div>

            <!-- User Button Area -->
            <div class="col-auto">
                <div class="user-button-area">
                    {if $smarty.const.NV_IS_USER}
                        <!-- User đã đăng nhập -->
                        <div class="dropdown">
                            <a title="Tài khoản của tôi" class="btn btn-success btn-sm" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa fa-user-circle me-1"></i><span class="d-none d-sm-inline">Tài khoản</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end p-0" style="min-width: 280px;">
                                <div class="card border-0">
                                    <div class="card-header bg-success text-white">
                                        <h6 class="card-title mb-0 text-white">
                                            <i class="fa fa-user me-2 text-white"></i>Thông tin tài khoản
                                        </h6>
                                    </div>
                                    <div class="card-body bg-white">
                                        <div class="list-group list-group-flush">
                                            <a href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}=users" class="list-group-item list-group-item-action border-0 px-0 py-2" style="color: #000000 !important;">
                                                <i class="fa fa-user text-primary me-2"></i><span style="color: #000000 !important;">Thông tin cá nhân</span>
                                            </a>
                                            <a href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}=users&{$smarty.const.NV_OP_VARIABLE}=editinfo" class="list-group-item list-group-item-action border-0 px-0 py-2" style="color: #000000 !important;">
                                                <i class="fa fa-edit text-success me-2"></i><span style="color: #000000 !important;">Chỉnh sửa thông tin</span>
                                            </a>
                                            <a href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}=users&{$smarty.const.NV_OP_VARIABLE}=logout&checkss={$smarty.const.NV_CHECK_SESSION}" class="list-group-item list-group-item-action border-0 px-0 py-2 text-danger">
                                                <i class="fa fa-sign-out-alt text-danger me-2"></i><span class="text-danger">Đăng xuất</span>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {else}
                        <!-- Guest Login Button -->
                        <div class="dropdown">
                            <a title="Đăng nhập - Đăng ký" class="btn btn-outline-primary btn-sm" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa fa-user me-1"></i><span class="d-none d-sm-inline">Đăng nhập</span>
                            </a>

                    <!-- Login Dropdown -->
                    <div class="dropdown-menu dropdown-menu-end p-0" style="min-width: 320px;">
                        <div class="card border-0">
                            <div class="card-header bg-primary text-white">
                                <h6 class="card-title mb-0 text-white">
                                    <i class="fa fa-sign-in-alt me-2 text-white"></i><span class="text-white">Đăng nhập</span>
                                </h6>
                            </div>
                            <div class="card-body bg-white">
                                <div id="loginFormContainer">
                                    <div class="text-center">
                                        <div class="spinner-border text-primary" role="status">
                                            <span class="visually-hidden">Đang tải...</span>
                                        </div>
                                        <p class="mt-2" style="color: #000000 !important;">Đang tải form đăng nhập...</p>
                                    </div>
                                </div>
                                <div class="d-grid gap-2 mt-3">
                                    <a href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}=users&{$smarty.const.NV_OP_VARIABLE}=register" class="btn btn-outline-secondary">
                                        <i class="fa fa-user-plus me-2"></i>Đăng ký tài khoản mới
                                    </a>
                                    <a href="{$smarty.const.NV_BASE_SITEURL}index.php?{$smarty.const.NV_LANG_VARIABLE}={$smarty.const.NV_LANG_DATA}&{$smarty.const.NV_NAME_VARIABLE}=users&{$smarty.const.NV_OP_VARIABLE}=lostpass" class="btn btn-link btn-sm">
                                        <i class="fa fa-key me-2"></i>Quên mật khẩu?
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Spacer để tránh content bị che bởi fixed header -->
<div class="nv-menu-spacer"></div>
<script type="text/javascript" data-show="after">
{literal}
// Function để toggle mobile menu
function toggleMobileMenu() {
    var nav = document.getElementById('nv-menu-nav');
    if (nav.classList.contains('nv-menu-show')) {
        nav.classList.remove('nv-menu-show');
    } else {
        nav.classList.add('nv-menu-show');
    }
}

// Đóng mobile menu khi click outside
document.addEventListener('click', function(event) {
    var nav = document.getElementById('nv-menu-nav');
    var toggle = document.querySelector('.nv-menu-mobile-toggle');

    if (!nav.contains(event.target) && !toggle.contains(event.target)) {
        nav.classList.remove('nv-menu-show');
    }
});

// Đóng mobile menu khi resize về desktop
window.addEventListener('resize', function() {
    if (window.innerWidth > 768) {
        var nav = document.getElementById('nv-menu-nav');
        nav.classList.remove('nv-menu-show');
    }
});

// Load login form when dropdown is opened
document.addEventListener('DOMContentLoaded', function() {
    const loginContainer = document.getElementById('loginFormContainer');
    const dropdown = document.querySelector('.user-button-area .dropdown');

    if (dropdown && loginContainer) {
        const dropdownToggle = dropdown.querySelector('[data-bs-toggle="dropdown"]');

        dropdownToggle.addEventListener('click', function() {
            // Only load form if not already loaded
            if (loginContainer.innerHTML.includes('spinner-border')) {
                loadLoginForm();
            }
        });
    }

    function loadLoginForm() {
        // Use jQuery if available, otherwise use fetch
        if (typeof $ !== 'undefined') {
            $.ajax({
                type: 'POST',
                url: nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_fc_variable + '=login',
                cache: false,
                data: {
                    nv_ajax: 1,
                    nv_redirect: window.location.href
                },
                dataType: "json"
            }).done(function(res) {
                if (res.sso) {
                    window.location.href = res.sso;
                    return false;
                }
                if (res.reload) {
                    location.reload();
                    return false;
                }
                if (res.html) {
                    loginContainer.innerHTML = res.html;
                    // Re-bind form events
                    bindLoginFormEvents();
                }
            }).fail(function() {
                // Fallback: redirect to login page
                window.location.href = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_fc_variable + '=login';
            });
        } else {
            // Fallback: redirect to login page
            window.location.href = nv_base_siteurl + 'index.php?' + nv_lang_variable + '=' + nv_lang_data + '&' + nv_name_variable + '=users&' + nv_fc_variable + '=login';
        }
    }

    function bindLoginFormEvents() {
        const loginForm = loginContainer.querySelector('form');
        if (loginForm) {
            loginForm.addEventListener('submit', function(e) {
                e.preventDefault();

                const formData = new FormData(this);
                const submitBtn = this.querySelector('button[type="submit"], input[type="submit"]');

                if (submitBtn) {
                    const originalText = submitBtn.innerHTML || submitBtn.value;
                    submitBtn.innerHTML = '<i class="fa fa-spinner fa-spin me-2"></i>Đang đăng nhập...';
                    submitBtn.disabled = true;
                }

                // Submit form using jQuery if available
                if (typeof $ !== 'undefined') {
                    $.ajax({
                        type: 'POST',
                        url: this.action,
                        data: formData,
                        processData: false,
                        contentType: false,
                        dataType: 'json'
                    }).done(function(res) {
                        if (res.status === 'OK' || res.redirect) {
                            location.reload();
                        } else {
                            if (submitBtn) {
                                submitBtn.innerHTML = originalText;
                                submitBtn.disabled = false;
                            }
                            alert(res.mess || 'Thông tin đăng nhập không chính xác!');
                        }
                    }).fail(function() {
                        if (submitBtn) {
                            submitBtn.innerHTML = originalText;
                            submitBtn.disabled = false;
                        }
                        alert('Có lỗi xảy ra, vui lòng thử lại!');
                    });
                } else {
                    // Fallback: normal form submission
                    this.submit();
                }
            });
        }
    }
});
{/literal}
</script>
