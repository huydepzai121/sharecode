{if $DATA.has_images}
<div class="container aos-init aos-animate mt-3">
    <div class="box-uudai">
        <p class="text-center">
            <img src="{$LOGO_SRC}" alt="Logo">
        </p>
        <h2 class="endow-title" id="promotion-title" style="cursor: pointer;" onclick="showPromotionModal()">
            <img src="https://cdn2.cellphones.com.vn/x/media/wysiwyg/flashsale/fs-gift-box-8-1-2.png" alt="Logo" class="img_qua">
            <span class="rainbow-text">{$DATA.title_new} {$DATE}</span>
            <img src="https://cdn2.cellphones.com.vn/x/media/wysiwyg/flashsale/fs-gift-box-8-1.png" alt="Logo" class="img_qua">
        </h2>
        <p class="endow-des">{$DATA.description}</p>
        <div class="endow">
            <div class="endow-left aos-init" data-aos="zoom-in-up" data-aos-delay="100">
                <img src="{$IMAGE1}" >
            </div>
            <div class="endow-right aos-init" data-aos="zoom-in-up" data-aos-delay="100">
                <div class="endow-box-left">
                    <img src="{$IMAGE2}" class="attachment-original size-original" >	
                </div>
                <div class="endow-box-right">
                    <img src="{$IMAGE3}">
                </div>
            </div>
        </div>
    </div>
    <div class="promotion-actions text-center mt-4">
        <a href="/contact" class="btn btn-primary btn-lg promotion-btn btn--social">
            <i class="fa fa-gift"></i> Liên hệ tư vấn
        </a>
    </div>
</div>

<!-- Modal Thông Tin Ưu Đãi -->
<div class="modal" id="promotionModal" tabindex="-1" aria-labelledby="promotionModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-gradient-primary text-white">
                <h5 class="modal-title" id="promotionModalLabel">
                    <i class="fa fa-gift"></i> Thông Tin Ưu Đãi Đặc Biệt
                </h5>
            </div>
            <div class="modal-body">
                <div class="promotion-modal-content">
                    <!-- Ảnh quà tặng -->
                    <div class="gift-images mb-4">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="gift-image-card">
                                    <img src="{$IMAGE1}" alt="Quà tặng 1" class="img-fluid rounded shadow-sm">
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="gift-image-card">
                                    <img src="{$IMAGE2}" alt="Quà tặng 2" class="img-fluid rounded shadow-sm">
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="gift-image-card">
                                    <img src="{$IMAGE3}" alt="Quà tặng 3" class="img-fluid rounded shadow-sm">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Thông tin ưu đãi -->
                    <div class="promotion-info">
                        <h4 class="text-center mb-4">
                            <i class="fa fa-star text-warning"></i>
                            Chương Trình Ưu Đãi Đặc Biệt
                            <i class="fa fa-star text-warning"></i>
                        </h4>

                        <div class="alert alert-success">
                            <h5><i class="fa fa-check-circle"></i> Ưu đãi bao gồm:</h5>
                            <ul class="mb-0">
                                <li>🎁 Quà tặng giá trị lên đến <strong>100 triệu đồng</strong></li>
                                <li>💰 Hỗ trợ vay ngân hàng <strong>lãi suất 0%</strong></li>
                                <li>🚗 Bảo hiểm xe <strong>1 năm miễn phí</strong></li>
                                <li>🔧 Bảo dưỡng <strong>10.000km đầu tiên</strong></li>
                                <li>📱 Phụ kiện chính hãng <strong>giảm 50%</strong></li>
                            </ul>
                        </div>

                        <!-- Hỗ trợ ngân hàng -->
                        <div class="bank-support mb-4">
                            <h5 class="text-center mb-3">
                                <i class="fa fa-university"></i> Hỗ Trợ Vay Ngân Hàng Liên Kết
                            </h5>
                            <div class="row text-center">
                                <div class="col-4 mb-2">
                                    <div class="bank-logo-card p-2 border rounded">
                                        <img src="/uploads/vcb.jpg"
                                             alt="Vietcombank" class="img-fluid" style="max-height: 40px;">
                                    </div>
                                </div>
                                <div class="col-4 mb-2">
                                    <div class="bank-logo-card p-2 border rounded">
                                        <img src="/uploads/viettinbank.jpg"
                                             alt="VietinBank" class="img-fluid" style="max-height: 40px;">
                                    </div>
                                </div>
                                <div class="col-4 mb-2">
                                    <div class="bank-logo-card p-2 border rounded">
                                        <img src="/uploads/teckcombank.png"
                                             alt="Techcombank" class="img-fluid" style="max-height: 40px;">
                                    </div>
                                </div>
                                <div class="col-4 mb-2">
                                    <div class="bank-logo-card p-2 border rounded">
                                        <img src="/uploads/mb.png"
                                             alt="MB Bank" class="img-fluid" style="max-height: 40px;">
                                    </div>
                                </div>
                                <div class="col-4 mb-2">
                                    <div class="bank-logo-card p-2 border rounded">
                                        <img src="/uploads/acb.png"
                                             alt="ACB" class="img-fluid" style="max-height: 40px;">
                                    </div>
                                </div>
                                <div class="col-4 mb-2">
                                    <div class="bank-logo-card p-2 border rounded">
                                        <img src="/uploads/sacombank.jpg"
                                             alt="Sacombank" class="img-fluid" style="max-height: 40px;">
                                    </div>
                                </div>
                            </div>
                            <p class="text-center text-muted mt-2">
                                <small>* Lãi suất ưu đãi từ 0% - 6.99%/năm</small>
                            </p>
                        </div>

                        <!-- Thông tin liên hệ -->
                        <div class="contact-info text-center">
                            <div class="alert alert-warning">
                                <h5><i class="fa fa-phone-alt"></i> Liên Hệ Ngay Để Nhận Ưu Đãi</h5>
                                <p class="mb-2">Hotline tư vấn 24/7:</p>
                                <a href="tel:0929319666" class="btn btn-danger btn-lg pulse-animation">
                                    <i class="fa fa-phone"></i> 0929.319.666
                                </a>
                                <p class="mt-3 mb-0">
                                    <small>Hoặc để lại thông tin, chúng tôi sẽ liên hệ tư vấn miễn phí</small>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closePromotionModal()">Đóng</button>
                <a href="/contact" class="btn btn-primary">
                    <i class="fa fa-paper-plane"></i> Đăng ký nhận ưu đãi
                </a>
            </div>
        </div>
    </div>
</div>
{/if}

<style>
    /* Hiệu ứng đổi màu từng chữ cái */
    .rainbow-text {
        background: linear-gradient(90deg,
            #ff0000, #ff7f00, #ffff00, #00ff00,
            #0000ff, #4b0082, #9400d3, #ff0000);
        background-size: 200% auto;
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
        animation: rainbow-animation 3s linear infinite;
        font-weight: 700;
        display: inline-block;
    }

    @keyframes rainbow-animation {
        0% {
            background-position: 0% center;
        }
        100% {
            background-position: 200% center;
        }
    }

    .endow-title {
        text-align: center;
        text-transform: uppercase;
        font-weight: 600;
        transition: transform 0.3s ease;
    }

    .endow-title:hover {
        transform: scale(1.05);
    }

    .endow-des {
        text-align: center;
        text-transform: uppercase;
    }
    .endow {
        width: 100%;
        position: relative;
        display: flex;
        max-height: 600px; /* đặt chiều cao tổng, hoặc để auto theo nội dung bên phải */
        padding: 10px;
        background: #f0f0f0;
        gap: 4px;
    }

    .endow img {
        opacity: 0.7;
        transition: all 0.3s;
    }

    .endow img:hover {
        opacity: 1;
    }
    .endow-left {
        flex: 1;
        display: flex;
    }

    .endow-left img {
        width: 100%;
        height: 100%;      /* ép full chiều cao */
        object-fit: cover; /* ảnh fill kín không méo */
    }

    .endow-right {
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 4px;
    }

    .endow-box-left,
    .endow-box-right {
        flex: 1;
        display: flex;
        max-height: 50%;;
    }

    .endow-box-left img,
    .endow-box-right img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .img_qua {
        width: 50px;
        height: 50px;
    }

    .promotion-btn {
        transition: all 0.3s;
        animation: pulse-zoom 2s infinite;
    }

    /* Modal styles */
    .modal {
        display: none;
        position: fixed;
        z-index: 9999;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.5);
    }

    .modal.show {
        display: block;
    }

    .modal-dialog {
        position: relative;
        margin: 1.75rem auto;
        max-width: 800px;
    }

    .modal-content {
        position: relative;
        background-color: #fff;
        border-radius: 0.5rem;
        box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15);
    }

    .modal-header.bg-gradient-primary {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 0.5rem 0.5rem 0 0;
        padding: 1rem 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .btn-close-custom {
        background: transparent;
        border: none;
        color: white;
        font-size: 1.5rem;
        cursor: pointer;
        padding: 0.5rem;
        line-height: 1;
        opacity: 0.8;
        transition: opacity 0.3s;
    }

    .btn-close-custom:hover {
        opacity: 1;
    }

    .modal-body {
        padding: 1.5rem;
        max-height: 70vh;
        overflow-y: auto;
    }

    .modal-footer {
        padding: 1rem 1.5rem;
        border-top: 1px solid #dee2e6;
        display: flex;
        justify-content: flex-end;
        gap: 0.5rem;
    }

    .gift-image-card {
        transition: transform 0.3s ease;
        cursor: pointer;
    }

    .gift-image-card:hover {
        transform: scale(1.05);
    }

    .gift-image-card img {
        border: 3px solid #f0f0f0;
        transition: border-color 0.3s ease;
    }

    .gift-image-card:hover img {
        border-color: #667eea;
    }

    .bank-logo-card {
        transition: all 0.3s ease;
        background: white;
    }

    .bank-logo-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    /* Pulse animation cho nút hotline */
    .pulse-animation {
        animation: pulse-phone 2s infinite;
        box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.7);
    }

    @keyframes pulse-phone {
        0% {
            box-shadow: 0 0 0 0 rgba(220, 53, 69, 0.7);
        }
        70% {
            box-shadow: 0 0 0 15px rgba(220, 53, 69, 0);
        }
        100% {
            box-shadow: 0 0 0 0 rgba(220, 53, 69, 0);
        }
    }

    /* Responsive */
    @media (max-width: 768px) {
        .img_qua {
            width: 25px;
            height: 25px;
        }

        .endow-title {
            font-size: 28px;
        }

        .rainbow-text {
            font-size: 0.9em;
        }

        .bank-logo-card img {
            max-height: 30px !important;
        }
    }
</style>

{literal}
<script>
// Hàm hiển thị modal
function showPromotionModal() {
    var modal = document.getElementById('promotionModal');
    if (modal) {
        modal.classList.add('show');
        document.body.style.overflow = 'hidden'; // Ngăn scroll body
    }
}

// Hàm đóng modal
function closePromotionModal() {
    var modal = document.getElementById('promotionModal');
    if (modal) {
        modal.classList.remove('show');
        document.body.style.overflow = ''; // Cho phép scroll lại
    }
}

// Đóng modal khi click bên ngoài
document.addEventListener('click', function(event) {
    var modal = document.getElementById('promotionModal');
    if (event.target === modal) {
        closePromotionModal();
    }
});

// Đóng modal khi nhấn ESC
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closePromotionModal();
    }
});

// Tự động tách từng chữ cái để tạo hiệu ứng (optional - nâng cao)
document.addEventListener('DOMContentLoaded', function() {
    const rainbowText = document.querySelector('.rainbow-text');
    if (rainbowText) {
        const text = rainbowText.textContent;
        rainbowText.innerHTML = '';

        // Tách từng ký tự và thêm span với delay animation
        text.split('').forEach((char, index) => {
            const span = document.createElement('span');
            span.textContent = char;
            span.style.animationDelay = `${index * 0.1}s`;
            rainbowText.appendChild(span);
        });
    }
});
</script>
{/literal}