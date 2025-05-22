```markdown
# Cài đặt Xray

Chạy lệnh sau để cài đặt Xray:

```bash
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u root
```

# Đường dẫn file cấu hình Xray

```bash
/usr/local/etc/xray/config.json
```

# Kiểm tra cấu hình Xray

```bash
xray -test -config /usr/local/etc/xray/config.json
```

# Khởi động lại Xray và kiểm tra trạng thái

```bash
systemctl restart xray && systemctl status xray
```

# Cài đặt Caddy

Chạy lệnh sau để cài đặt Caddy:

```bash
apt install -y sudo debian-keyring debian-archive-keyring apt-transport-https curl && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list && apt update && apt install caddy
```

# Thư mục file cấu hình mặc định của Caddy

```bash
/etc/caddy/caddy.json
```

# Kiểm tra file cấu hình Caddy

```bash
caddy validate --config /etc/caddy/caddy.json
```

# Khởi động dịch vụ Caddy

```bash
caddy run --config /etc/caddy/caddy.json
```

Khi khởi động thành công, bạn sẽ nhận được thông báo:  
“certificate obtained successfully” và “releasing lock”.

# Xử lý khi cổng 80 hoặc 2019 bị chiếm dụng

```bash
caddy stop
```

Sau đó khởi động lại.

# Tắt Caddy

Nhấn `Ctrl+C` để tắt Caddy khi đang chạy ở chế độ foreground.

# Chạy Caddy ở chế độ background

```bash
caddy start --config /etc/caddy/caddy.json
```

# Các lệnh Caddy thường dùng

- Chạy Caddy ở chế độ foreground:  
  ```bash
  caddy run
  ```

- Chạy Caddy ở chế độ background:  
  ```bash
  caddy start
  ```

- Dừng Caddy:  
  ```bash
  caddy stop
  ```

- Tải lại cấu hình:  
  ```bash
  caddy reload
  ```
```
