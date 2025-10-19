/**
 * Mobile Tooltip Handler for Car Options
 * Hiển thị tooltip khi tap vào car option icons trên mobile
 */

document.addEventListener('DOMContentLoaded', function() {
    // Kiểm tra xem có phải mobile không
    function isMobile() {
        return window.innerWidth <= 768;
    }

    // Xử lý tooltip cho mobile
    function initMobileTooltips() {
        const optionIcons = document.querySelectorAll('.option-icon');
        let activeTooltip = null;

        optionIcons.forEach(icon => {
            const tooltip = icon.querySelector('.mobile-tooltip');
            
            if (!tooltip) return;

            // Touch events cho mobile
            icon.addEventListener('touchstart', function(e) {
                if (!isMobile()) return;
                
                e.preventDefault();
                
                // Ẩn tooltip đang active
                if (activeTooltip && activeTooltip !== tooltip) {
                    activeTooltip.classList.remove('show');
                }
                
                // Toggle tooltip hiện tại
                if (tooltip.classList.contains('show')) {
                    tooltip.classList.remove('show');
                    activeTooltip = null;
                } else {
                    tooltip.classList.add('show');
                    activeTooltip = tooltip;
                    
                    // Tự động ẩn sau 3 giây
                    setTimeout(() => {
                        if (activeTooltip === tooltip) {
                            tooltip.classList.remove('show');
                            activeTooltip = null;
                        }
                    }, 3000);
                }
            });

            // Click events cho desktop (fallback)
            icon.addEventListener('click', function(e) {
                if (isMobile()) {
                    e.preventDefault();
                    return false;
                }
            });
        });

        // Ẩn tooltip khi click ra ngoài
        document.addEventListener('touchstart', function(e) {
            if (!isMobile()) return;
            
            const clickedIcon = e.target.closest('.option-icon');
            if (!clickedIcon && activeTooltip) {
                activeTooltip.classList.remove('show');
                activeTooltip = null;
            }
        });
    }

    // Khởi tạo tooltips
    initMobileTooltips();

    // Re-init khi resize window
    let resizeTimer;
    window.addEventListener('resize', function() {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(function() {
            // Ẩn tất cả tooltips khi resize
            document.querySelectorAll('.mobile-tooltip.show').forEach(tooltip => {
                tooltip.classList.remove('show');
            });
        }, 250);
    });
});
