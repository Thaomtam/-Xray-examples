## **Giới thiệu cấu hình:**

| | Không cần đăng ký tên miền | Giải quyết TLS trong TLS | Tích hợp ghép kênh | Truy cập qua CDN |
| :--- | :---: | :---: | :---: | :---: |
| **VLESS-Tầm-Góc-THỰC-TỰ** | :heavy_check_mark: | :heavy_check_mark: | :x: | :x: |
| **VLESS-TLS-Tầm nhìn** | :x: | :heavy_check_mark: | :x: | :x: |
| **VLESS-gRPC/HTTP2-REALITY** | :heavy_check_mark: | :x: | :heavy_check_mark: | :x: |
| **VLESS-gRPC-TLS** | :x: | :x: | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-WebSocket/HTTPUpgrade-TLS** | :x: | :x: | :x: | :heavy_check_mark: |

| | Sử dụng uTLS | Sử dụng Vision | Dấu vân tay TLS của máy chủ | Giao thức TCP | Giao thức UDP | MPTCP |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **VLESS-Tầm-Góc-THỰC-TỰ** | Bắt buộc | Khuyến nghị | **1** | **2** | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-TLS-Tầm nhìn** | Khuyến nghị | Khuyến nghị | Đi | **2** | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-gRPC/HTTP2-REALITY** | Bắt buộc | Không được phép | **1** | **3** | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-gRPC-TLS** | Khuyến nghị | Không thể | Nginx | ​​:heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-WebSocket/HTTPUpgrade-TLS** | Khuyến nghị | Không nên | Nginx | ​​:heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |

**1:** Được xác định bởi `"dest": "",` trang web mục tiêu, chẳng hạn như Nginx khi tự đánh cắp<br>
**2:** Không thể thực hiện khi sử dụng Vision<br>
**3:** Tích hợp ghép kênh

[**Mux**](https://xtls.github.io/Xray-docs-next/config/outbound.html#muxobject)

```jsonc
"mux": {
"enabled": true, // nếu đang chơi game, false
"concurrency": -1, // Không sử dụng Mux(TCP)
"xudpConcurrency": 16, // Sử dụng Mux(UDP), là UDP trên TCP. Nếu sử dụng Vision, phần đệm sẽ được thêm vào.
"xudpProxyUDP443": "từ chối"
}
```

> Cấu hình Mux chỉ cần được bật ở phía máy khách và phía máy chủ sẽ tự động điều chỉnh

[**MPTCP**](https://github.com/XTLS/Xray-core/pull/2520#issuecomment-1711212084)

```jsonc
"sockopt": {
"tcpMptcp": đúng,
"tcpNoDelay": đúng
}
```

> Cấu hình MPTCP cần được bật trên cả máy khách và máy chủ<br>
> Yêu cầu Xray-core phiên bản 1.8.6 trở lên<br>
> Yêu cầu phiên bản hạt nhân Linux 5.6 trở lên

:+1:**XTLS Vision [Nguyên lý](https://github.com/XTLS/Xray-core/discussions/1295) [Hướng dẫn cài đặt](https://github.com/chika0801/Xray-install)**

:+1:**THỰC TẾ [Triết lý thiết kế](https://github.com/XTLS/Xray-core/issues/1689#issuecomment-1439447009) [Nguyên tắc](https://github.com/XTLS/Xray-core/issues/1891#issuecomment-1495439413) [Hướng dẫn cấu hình](https://github.com/XTLS/REALITY#readme)**

## **[Máy khách GUI](https://github.com/XTLS/Xray-core/blob/main/README.md#gui-clients)**
