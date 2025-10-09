# CodeMarket Website

Website CodeMarket được chuyển đổi từ thiết kế Figma sang HTML và CSS.

## Tính năng

- **Header**: Logo, navigation menu, và thanh tìm kiếm
- **Hero Section**: Phần giới thiệu với thống kê và nút kêu gọi hành động
- **Sản phẩm nổi bật**: Hiển thị các sản phẩm được quan tâm nhất
- **Danh mục**: Các danh mục phổ biến với icons
- **Sản phẩm mới nhất**: Danh sách các sản phẩm mới cập nhật
- **Footer**: Copyright và liên kết mạng xã hội

## Công nghệ sử dụng

- HTML5
- CSS3 (Grid, Flexbox, CSS Variables)
- Google Fonts (Inter)
- Responsive Design
- Animate On Scroll (AOS)

## Cấu trúc file

```
/
├── index.html          # Cấu trúc HTML chính (include AOS)
├── styles.css          # Styling CSS
├── assets/             # Thư mục chứa ảnh và icons
│   ├── logo.svg        # Logo CodeMarket
│   ├── search-*.svg    # Icons tìm kiếm
│   ├── star-icon.svg   # Icon đánh giá
│   ├── web-icon.svg    # Icon danh mục Web
│   ├── mobile-icon.svg # Icon danh mục Mobile
│   ├── ai-icon.svg     # Icon danh mục AI
│   ├── game-icon.svg   # Icon danh mục Game
│   ├── ecommerce-icon.svg # Icon danh mục E-commerce
│   ├── backend-icon.svg # Icon danh mục Backend
│   ├── social-icon-*.svg # Icons mạng xã hội
│   └── *.png           # Hình ảnh sản phẩm
└── README.md           # Tài liệu này
```

## Chạy dự án

1. Mở terminal trong thư mục dự án
2. Tải phụ thuộc (nếu cần): đảm bảo có Internet để load CDN AOS
3. Chạy server: `python -m http.server 8000`
4. Mở trình duyệt và truy cập: `http://localhost:8000`

## Hiệu ứng

- Các section chính (hero, featured, categories, latest, footer) sử dụng AOS fade/zoom
- Product cards có độ trễ khác nhau tạo cảm giác chuyển động liên tục
- AOS khởi tạo với thời lượng 800ms, easing `ease-out-cubic`, offset 80px, chạy 1 lần khi cuộn

## Màu sắc chính

- Background chính: `#0F1724`
- Background card: `#2B2F3A`
- Text chính: `#E6EDF3`
- Text phụ: `#9CA3AF`
- Accent: `#BFD3FF`
- Gradient: Linear gradient từ `#667EEA` đến `#764ABC`

## Ảnh và Icons

Tất cả ảnh và icons được tải từ thiết kế Figma gốc:

### Sản phẩm:
- **Dashboard Admin Next.js** - Dashboard template với Next.js
- **UI Kit Flutter E-commerce** - Giao diện Flutter cho e-commerce
- **Starter SaaS Boilerplate** - Template khởi tạo SaaS
- **Chatbot AI Starter** - Template chatbot AI
- **Template Shop React** - Shop template với React
- **Bank App iOS Kit** - Ứng dụng ngân hàng iOS
- **Analytics Admin Vue** - Dashboard phân tích với Vue
- **Portfolio Dev Template** - Template portfolio developer
- **Food Delivery App Kit** - Ứng dụng giao đồ ăn
- **Stripe Billing Module** - Module thanh toán Stripe

### Danh mục:
- **Web** - Templates website
- **Mobile** - Ứng dụng di động
- **AI** - Công nghệ trí tuệ nhân tạo
- **Game** - Game development
- **E-commerce** - Thương mại điện tử
- **Backend** - Backend services

## Responsive

Website được thiết kế responsive cho các kích thước màn hình:
- Desktop: 1200px+
- Tablet: 768px - 1024px
- Mobile: < 768px
