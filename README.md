```
bash <(wget --no-check-certificate -qO- ${GH_PROXY}https://raw.githubusercontent.com/Thaomtam/-Xray-examples/refs/heads/main/ipleak.sh)
```
## **Configuration Overview**

| | No Domain Registration Required | Resolves TLS in TLS | Built-in Multiplexing | Accessible via CDN |
| :--- | :---: | :---: | :---: | :---: |
| **VLESS-Vision-REALITY** | :heavy_check_mark: | :heavy_check_mark: | :x: | :x: |
| **VLESS-Vision-TLS** | :x: | :heavy_check_mark: | :x: | :x: |
| **VLESS-gRPC/HTTP2-REALITY** | :heavy_check_mark: | :x: | :heavy_check_mark: | :x: |
| **VLESS-gRPC-TLS** | :x: | :x: | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-WebSocket/HTTPUpgrade-TLS** | :x: | :x: | :x: | :heavy_check_mark: |

| | Uses uTLS | Uses Vision | Server TLS Fingerprint | Mux(TCP) | Mux(UDP) | MPTCP |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: |
| **VLESS-Vision-REALITY** | Required | Recommended | **1** | **2** | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-Vision-TLS** | Recommended | Recommended | Go | **2** | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-gRPC/HTTP2-REALITY** | Required | Not Supported | **1** | **3** | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-gRPC-TLS** | Recommended | Not Supported | Nginx | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **VLESS-WebSocket/HTTPUpgrade-TLS** | Recommended | Not Supported | Nginx | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |

**1:** Determined by `"dest": "",` target website, e.g., Nginx when self-hosted  
**2:** Not supported when using Vision  
**3:** Built-in multiplexing

[**Mux**](https://xtls.github.io/Xray-docs-next/config/outbound.html#muxobject)

```jsonc
            "mux": {
                "enabled": true, // Set to false for gaming
                "concurrency": -1, // Disables Mux(TCP)
                "xudpConcurrency": 16, // Enables Mux(UDP), UDP over TCP; adds padding when using Vision
                "xudpProxyUDP443": "reject"
            }
```

> Mux configuration only needs to be enabled on the client; the server auto-adapts.

[**MPTCP**](https://github.com/XTLS/Xray-core/pull/2520#issuecomment-1711212084)

```jsonc
                "sockopt": {
                    "tcpMptcp": true,
                    "tcpNoDelay": true
                }
```

> MPTCP configuration must be enabled on both client and server.  
> Requires Xray-core version 1.8.6 or higher.  
> Requires Linux kernel version 5.6 or higher.

:+1: **XTLS Vision [How It Works](https://github.com/XTLS/Xray-core/discussions/1295) [Installation Guide](https://github.com/chika0801/Xray-install)**

:+1: **REALITY [Design Philosophy](https://github.com/XTLS/Xray-core/issues/1689#issuecomment-1439447009) [Technical Details](https://github.com/XTLS/Xray-core/issues/1891#issuecomment-1495439413) [Configuration Guide](https://github.com/XTLS/REALITY#readme)**

## **[GUI Clients](https://github.com/XTLS/Xray-core/blob/main/README.md#gui-clients)**

---
