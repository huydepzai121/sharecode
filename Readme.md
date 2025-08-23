# ShareCode - Module Chia Sẻ Mã Nguồn

## Giới thiệu
ShareCode là một module mạnh mẽ cho hệ thống NukeViet, cho phép người dùng chia sẻ, tải xuống và quản lý các mã nguồn lập trình. Module này được thiết kế để tạo ra một cộng đồng chia sẻ kiến thức lập trình hiệu quả.

## Tính năng chính

### 🎯 Dành cho người dùng
- **Duyệt mã nguồn**: Xem danh sách các mã nguồn theo danh mục
- **Tìm kiếm nâng cao**: Tìm kiếm theo từ khóa, danh mục, loại phí
- **Tải xuống**: Tải xuống mã nguồn miễn phí hoặc có phí
- **Đánh giá và bình luận**: Đánh giá chất lượng mã nguồn
- **Yêu thích**: Lưu các mã nguồn yêu thích
- **Lịch sử tải xuống**: Theo dõi các mã nguồn đã tải
- **Dashboard cá nhân**: Quản lý hoạt động cá nhân

### 🛠️ Dành cho tác giả
- **Đăng tải mã nguồn**: Upload và chia sẻ mã nguồn
- **Quản lý sản phẩm**: Chỉnh sửa, cập nhật mã nguồn
- **Thống kê**: Xem số lượt tải, đánh giá
- **Kiếm tiền**: Bán mã nguồn có phí

### ⚙️ Dành cho quản trị viên
- **Quản lý danh mục**: Tạo, sửa, xóa danh mục
- **Duyệt mã nguồn**: Phê duyệt/từ chối mã nguồn
- **Quản lý người dùng**: Theo dõi hoạt động người dùng
- **Thống kê tổng quan**: Báo cáo chi tiết về hệ thống
- **Cấu hình module**: Tùy chỉnh các thiết lập

## Cài đặt

### Yêu cầu hệ thống
- NukeViet 5.x trở lên
- PHP 7.4+
- MySQL 5.7+ hoặc MariaDB 10.2+
- Dung lượng ổ cứng: tối thiểu 100MB

### Hướng dẫn cài đặt
1. **Upload module**: Copy thư mục `sharecode` vào `/modules/`
2. **Cài đặt qua Admin**:
   - Vào Admin → Modules → Cài đặt module mới
   - Chọn ShareCode và click "Cài đặt"
3. **Cấu hình**: Thiết lập các tham số cơ bản trong phần cấu hình

## Thông tin đăng nhập Admin

### Tài khoản quản trị mặc định
- **Username**: `admin`
- **Password**: `Mamhp002vn@`

> ⚠️ **Lưu ý bảo mật**: Vui lòng thay đổi mật khẩu ngay sau khi đăng nhập lần đầu!

## Cấu hình Module

### Cài đặt cơ bản
- **Số item mỗi trang**: 12 (mặc định)
- **Cho phép guest tải**: Có
- **Yêu cầu đăng nhập cho mã nguồn có phí**: Có
- **Tự động duyệt đánh giá**: Không
- **Kích thước file tối đa**: 50MB
- **Định dạng file cho phép**: zip, rar, 7z, tar, gz

### Cài đặt nâng cao
- **Watermark**: Tùy chọn thêm watermark vào file
- **Email thông báo**: Gửi email khi có mã nguồn mới
- **Cache time**: 3600 giây (1 giờ)

## Cấu trúc Database

### Bảng chính
- `nv5_vi_sharecode_categories`: Danh mục
- `nv5_vi_sharecode_sources`: Mã nguồn
- `nv5_vi_sharecode_reviews`: Đánh giá
- `nv5_vi_sharecode_downloads`: Lịch sử tải xuống
- `nv5_vi_sharecode_favorites`: Yêu thích

## API và Hooks

### Events có sẵn
- `sharecode_source_approved`: Khi mã nguồn được duyệt
- `sharecode_source_downloaded`: Khi có lượt tải xuống
- `sharecode_review_added`: Khi có đánh giá mới

## Hỗ trợ và Phát triển

### Báo lỗi
- Tạo issue trên GitLab: https://gitlab.com/NguyenVanLam02101999/sharecode
- Email: contact@example.com

### Đóng góp
1. Fork repository
2. Tạo nhánh feature mới
3. Commit thay đổi
4. Tạo Merge Request


### Version 1.0.00 (2025-01-01)
- 🎉 Phiên bản đầu tiên
- ✨ Các tính năng cơ bản

## Giấy phép
Module ShareCode được phát hành dưới giấy phép GNU/GPL version 2.

---
**Phát triển bởi**: VINADES.,JSC
**Website**: https://nukeviet.vn
**Email**: contact@vinades.vn
