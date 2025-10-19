{* Block Popup Liên Hệ Tự Động *}

<!-- Popup Contact Box -->
<div class="contact-popup-overlay" id="contactPopup">
    <div class="contact-popup-container">
        <button class="popup-close-btn" onclick="closeContactPopup()">
            <i class="fa fa-times"></i>
        </button>

        <div class="popup-content">
            <!-- Ảnh tượng trưng -->
            <div class="popup-image">
                <img src="/uploads/1757489547239.jpg" alt="Mercedes-Benz" class="img-fluid">
            </div>

            <!-- Nội dung -->
            <div class="popup-body">
                <h3 class="popup-title">
                    <i class="fa fa-car"></i> Bạn Đang Quan Tâm Đến Dòng Xe Nào?
                </h3>

                <p class="popup-description">
                    Hãy liên hệ với chúng tôi để được tư vấn chi tiết về các dòng xe Mercedes-Benz cao cấp.
                    Đội ngũ chuyên viên giàu kinh nghiệm sẵn sàng hỗ trợ bạn 24/7.
                </p>

                <!-- Thông tin ưu đãi -->
                <div class="promotion-highlight">
                    <div class="promotion-badge">
                        <i class="fa fa-gift"></i> ƯU ĐÃI ĐỘC QUYỀN
                    </div>
                    <p class="promotion-text">
                        <strong>Chương trình ưu đãi tháng {$DATE}</strong><br>
                        Giảm giá lên đến <span class="highlight-price">200 triệu đồng</span><br>
                        Quà tặng giá trị + Hỗ trợ vay <strong>0% lãi suất</strong><br>
                        Bảo hiểm xe <strong>1 năm miễn phí</strong>
                    </p>
                </div>

                <!-- Hotline -->
                <div class="popup-hotline">
                    <p class="hotline-label">
                        <i class="fa fa-phone-alt"></i> Hotline tư vấn 24/7:
                    </p>
                    <a href="tel:0929319666" class="hotline-number">
                        0929.319.666
                    </a>
                </div>

                <!-- Buttons -->
                <div class="popup-actions">
                    <a href="tel:0929319666" class="btn btn-call">
                        <i class="fa fa-phone"></i> Gọi ngay
                    </a>
                    <a href="/contact/" class="btn btn-contact">
                        <i class="fa fa-paper-plane"></i> Để lại thông tin
                    </a>
                </div>

                <!-- Checkbox không hiển thị lại -->
                <div class="popup-checkbox">
                    <label>
                        <input type="checkbox" id="dontShowAgain" onchange="handleDontShowAgain()">
                        Không hiển thị lại trong 24h
                    </label>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
/* Popup Overlay */
.contact-popup-overlay {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.7);
    z-index: 99999;
    animation: fadeIn 0.3s ease-in-out;
}

.contact-popup-overlay.show {
    display: flex;
    justify-content: center;
    align-items: center;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

/* Popup Container */
.contact-popup-container {
    position: relative;
    background: white;
    border-radius: 20px;
    max-width: 600px;
    width: 90%;
    max-height: 90vh;
    overflow-y: auto;
    box-shadow: 0 10px 50px rgba(0, 0, 0, 0.3);
    /*animation: slideUp 0.4s ease-out; */
    left: 50%;
    top: 1%;
    transform: translate(-50%);
}

@keyframes slideUp {
    from {
        transform: translate(-50%, 50px);
        opacity: 0;
    }
    to {
        transform: translate(-50%, 0);
        opacity: 1;
    }
}

/* Close Button */
.popup-close-btn {
    position: absolute;
    top: 15px;
    right: 15px;
    background: rgba(0, 0, 0, 0.5);
    border: none;
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    cursor: pointer;
    font-size: 20px;
    z-index: 100;
    transition: all 0.3s;
}

.popup-close-btn:hover {
    background: rgba(0, 0, 0, 0.8);
    transform: rotate(90deg);
}

/* Popup Image */
.popup-image {
    width: 100%;
    height: 250px;
    overflow: hidden;
    border-radius: 20px 20px 0 0;
}

.popup-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

/* Popup Body */
.popup-body {
    padding: 30px;
}

.popup-title {
    color: #2c3e50;
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 15px;
    text-align: center;
}

.popup-title i {
    color: #667eea;
    margin-right: 10px;
}

.popup-description {
    text-align: center;
    color: #666;
    font-size: 16px;
    margin-bottom: 25px;
    line-height: 1.6;
}

/* Promotion Highlight */
.promotion-highlight {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 20px;
    border-radius: 15px;
    margin-bottom: 25px;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.promotion-highlight::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
    animation: shine 3s infinite;
}

@keyframes shine {
    0% {
        transform: translateX(-100%) translateY(-100%) rotate(45deg);
    }
    100% {
        transform: translateX(100%) translateY(100%) rotate(45deg);
    }
}

.promotion-badge {
    background: rgba(255, 255, 255, 0.2);
    display: inline-block;
    padding: 8px 20px;
    border-radius: 25px;
    font-weight: 700;
    font-size: 14px;
    margin-bottom: 15px;
    animation: pulse 2s infinite;
    opacity: 0;
}

@keyframes pulse {
    0%, 100% {
        transform: scale(1);
    }
    50% {
        transform: scale(1.05);
    }
}

.promotion-text {
    margin: 0;
    font-size: 15px;
    line-height: 1.8;
}

.highlight-price {
    color: #ffd700;
    font-size: 20px;
    font-weight: 700;
}

/* Hotline */
.popup-hotline {
    text-align: center;
    margin-bottom: 25px;
}

.hotline-label {
    color: #666;
    font-size: 14px;
    margin-bottom: 10px;
}

.hotline-number {
    display: block;
    font-size: 32px;
    font-weight: 700;
    color: #dc3545;
    text-decoration: none;
    animation: phoneRing 2s infinite;
}

@keyframes phoneRing {
    0%, 100% {
        transform: rotate(0deg);
    }
    10%, 30% {
        transform: rotate(-10deg);
    }
    20%, 40% {
        transform: rotate(10deg);
    }
}

.hotline-number:hover {
    color: #c82333;
}

/* Action Buttons */
.popup-actions {
    display: flex;
    gap: 15px;
    margin-bottom: 20px;
}

.popup-actions .btn {
    flex: 1;
    padding: 15px 20px;
    border-radius: 10px;
    font-size: 16px;
    font-weight: 600;
    text-decoration: none;
    text-align: center;
    transition: all 0.3s;
    border: none;
    cursor: pointer;
}

.btn-call {
    background: #28a745;
    color: white;
}

.btn-call:hover {
    background: #218838;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
}

.btn-contact {
    background: #667eea;
    color: white;
}

.btn-contact:hover {
    background: #5568d3;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
}

/* Checkbox */
.popup-checkbox {
    text-align: center;
}

.popup-checkbox label {
    color: #999;
    font-size: 14px;
    cursor: pointer;
    user-select: none;
}

.popup-checkbox input[type="checkbox"] {
    margin-right: 8px;
    cursor: pointer;
}

/* Responsive */
@media (max-width: 768px) {
    .contact-popup-container {
        width: 95%;
        max-height: 95vh;
    }
    
    .popup-body {
        padding: 20px;
    }
    
    .popup-title {
        font-size: 20px;
    }
    
    .popup-description {
        font-size: 14px;
    }
    
    .hotline-number {
        font-size: 26px;
    }
    
    .popup-actions {
        flex-direction: column;
    }
    
    .popup-image {
        height: 180px;
    }
}
</style>

{literal}
<script>
// Kiểm tra cookie
function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) return parts.pop().split(';').shift();
    return null;
}

// Set cookie
function setCookie(name, value, hours) {
    const date = new Date();
    date.setTime(date.getTime() + (hours * 60 * 60 * 1000));
    const expires = `expires=${date.toUTCString()}`;
    document.cookie = `${name}=${value};${expires};path=/`;
}

// Hiển thị popup
function showContactPopup() {
    const popup = document.getElementById('contactPopup');
    if (popup) {
        popup.classList.add('show');
        document.body.style.overflow = 'hidden';
    }
}

// Đóng popup
function closeContactPopup() {
    const popup = document.getElementById('contactPopup');
    if (popup) {
        popup.classList.remove('show');
        document.body.style.overflow = '';
    }
}

// Xử lý checkbox "Không hiển thị lại"
function handleDontShowAgain() {
    const checkbox = document.getElementById('dontShowAgain');
    if (checkbox && checkbox.checked) {
        setCookie('hideContactPopup', 'true', 24); // 24 giờ
        closeContactPopup();
    }
}

// Đóng khi click bên ngoài
document.addEventListener('click', function(event) {
    const popup = document.getElementById('contactPopup');
    if (event.target === popup) {
        closeContactPopup();
    }
});

// Đóng khi nhấn ESC
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeContactPopup();
    }
});

// Tự động hiển thị popup sau 3 giây
document.addEventListener('DOMContentLoaded', function() {
    // Kiểm tra cookie
    const hidePopup = getCookie('hideContactPopup');

    if (!hidePopup) {
        // Hiển thị sau 3 giây
        setTimeout(function() {
            showContactPopup();
        }, 3000);
    }
});
</script>
{/literal}
