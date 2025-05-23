# Hướng dẫn cài đặt và sử dụng Xray và Caddy

## 1. Cài đặt Xray

Để cài đặt Xray, chạy lệnh sau:

```bash
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u root
```

## 2. Cấu hình Xray

### Đường dẫn file cấu hình Xray
File cấu hình mặc định của Xray nằm tại:

```bash
/usr/local/etc/xray/config.json
```

### Kiểm tra cấu hình Xray
Để kiểm tra tính hợp lệ của file cấu hình, sử dụng lệnh:

```bash
xray -test -config /usr/local/etc/xray/config.json
```

## 3. Quản lý dịch vụ Xray

### Khởi động lại và kiểm tra trạng thái Xray
Để khởi động lại dịch vụ Xray và kiểm tra trạng thái, chạy:

```bash
systemctl restart xray && systemctl status xray
```

## 4. Cài đặt Caddy

Để cài đặt Caddy, thực hiện lệnh sau:

```bash
apt install -y sudo debian-keyring debian-archive-keyring apt-transport-https curl && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && apt update && apt install caddy
```

## 5. Cấu hình Caddy

### Thư mục file cấu hình mặc định của Caddy
File cấu hình mặc định của Caddy nằm tại:

```bash
/etc/caddy/caddy.json
```

### Kiểm tra file cấu hình Caddy
Để kiểm tra tính hợp lệ của file cấu hình Caddy, chạy:

```bash
caddy validate --config /etc/caddy/caddy.json
```

## 6. Quản lý dịch vụ Caddy

### Chạy Caddy ở chế độ foreground
Để chạy Caddy và giữ giao diện dòng lệnh:

```bash
caddy run --config /etc/caddy/caddy.json
```

Khi khởi động thành công, bạn sẽ nhận được thông báo:  
“certificate obtained successfully” và “releasing lock”.

### Chạy Caddy ở chế độ background
Để chạy Caddy ở chế độ nền:

```bash
caddy start --config /etc/caddy/caddy.json
```

### Tải lại cấu hình Caddy
Để áp dụng thay đổi cấu hình mà không dừng dịch vụ:

```bash
caddy reload
```

### Dừng Caddy
- Nếu Caddy đang chạy ở chế độ foreground, nhấn `Ctrl+C` để dừng.  
- Nếu Caddy đang chạy ở chế độ background, sử dụng lệnh:

```bash
caddy stop
```

## 7. Xử lý lỗi khi cổng 80 hoặc 2019 bị chiếm dụng
Nếu cổng 80 hoặc 2019 bị chiếm dụng, thực hiện:

```bash
caddy stop
```

Sau đó, khởi động lại dịch vụ Caddy bằng lệnh `caddy start` hoặc `caddy run` như trên.

## 8. Các lệnh Caddy thường dùng
- **Chạy ở chế độ foreground:**
  ```bash
  caddy run
  ```
- **Chạy ở chế độ background:**
  ```bash
  caddy start
  ```
- **Dừng dịch vụ:**
  ```bash
  caddy stop
  ```
- **Tải lại cấu hình:**
  ```bash
  caddy reload
  ```

---
