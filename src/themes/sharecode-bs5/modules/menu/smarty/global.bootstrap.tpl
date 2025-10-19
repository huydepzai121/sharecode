{* define the function *}
{function name=menu data=[]}
{$i = 0}
{if count($data) > 0}
{foreach $data as $entry}
{if $i==0}
<ul class="{if $entry.parentid==0}nv-menu-nav-list{else}nv-menu-submenu{/if}">
{if $entry.parentid==0}
<li class="nv-menu-nav-item"><a class="nv-menu-nav-link nv-menu-home" title="{$LANG->getGlobal('Home')}" href="{$THEME_SITE_HREF}" rel="dofollow"><em class="fa fa-lg fa-home">&nbsp;</em><span class="nv-menu-home-text"> {$LANG->getGlobal('Home')}</span></a></li>
{/if}
{/if}
{strip}<li class="{if $entry.parentid==0}nv-menu-nav-item{else}nv-menu-submenu-item{/if}{if !empty($entry.sub)} nv-menu-has-submenu{/if}{if $entry.is_active} nv-menu-active{/if}{if !empty($entry.css)} {$entry.css}{/if}">
        <a href="{$entry.link}" rel="dofollow" class="{if $entry.parentid==0}nv-menu-nav-link{else}nv-menu-submenu-link{/if}"{if !empty($entry.note)} title="{$entry.note}"{/if}{if !empty($entry.target)} {$entry.target}{/if}>
            {if !empty($entry.icon)}<img src="{$entry.icon}" alt="" class="nv-menu-icon" />{/if}
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

<!-- CSS Inline cho NukeViet Menu -->
<style>
/* Reset và Base Styles cho NukeViet Menu */
.nv-menu-header {
    background: #FFFFFF;
    border-bottom: 1px solid #E5E7EB;
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    width: 100%;
    z-index: 1000;
    box-shadow: 0 1px 2px rgba(15, 23, 42, 0.08);
}

/* Thêm margin-top cho content sau menu để tránh bị che bởi fixed header */
.nv-menu-header + * {
    margin-top: 70px;
}

/* Fallback cho trường hợp không có element tiếp theo */
.nv-menu-spacer {
    height: 70px;
    display: block;
}

.nv-menu-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 40px;
}

.nv-menu-header-content {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 16px 0;
    gap: 16px;
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


</style>

<!-- Header Menu Structure -->
<div class="nv-menu-header">
    <div class="nv-menu-container">
        <div class="nv-menu-header-content">
            <!-- Mobile Toggle Button -->
            <button type="button" class="nv-menu-mobile-toggle" onclick="toggleMobileMenu()">
                <span></span>
                <span></span>
                <span></span>
            </button>

            <!-- Navigation -->
            <nav class="nv-menu-nav" id="nv-menu-nav">
                {call name=menu data=$MENU}
            </nav>
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
{/literal}
</script>
