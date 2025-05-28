# Sử dụng **[warp-reg](https://github.com/badafans/warp-reg)** để đăng ký tài khoản Warp

```
curl -sLo warp-reg https://github.com/badafans/warp-reg/releases/download/v1.0/main-linux-amd64 && chmod +x warp-reg && ./warp-reg && rm warp-reg
```

# Sử dụng **[warp-reg.sh](https://github.com/chise0713/warp-reg.sh)** để đăng ký tài khoản Warp

```
bash -c "$(curl -L warp-reg.vercel.app)"
```

# Sử dụng **api.zeroteam.top** để lấy tài khoản Warp

```
curl -sL "https://api.zeroteam.top/warp?format=sing-box" | grep -Eo --color=never '"2606:4700:[0-9a-f:]+/128"|"private_key":"[0-9a-zA-Z\/+]+="|"reserved":\[[0-9]+(,[0-9]+){2}\]'
```

- Sao chép địa chỉ IPv6 từ đầu ra và thay thế `2606:4700::` trong cấu hình dưới đây.
- Sao chép giá trị `private_key` từ đầu ra và dán vào phần `secretKey` trong `""` ở cấu hình dưới đây.
- Sao chép giá trị `reserved` từ đầu ra và dán vào phần `reserved` trong `[]` ở cấu hình dưới đây.

# "outbounds"

```jsonc
        {
            "protocol": "wireguard",
            "settings": {
                "secretKey": "", // Paste your "private_key" value here
                "address": [
                    "172.16.0.2/32",
                    "2606:4700::/128" // Paste your Warp IPv6 address here, add /128 at the end
                ],
                "peers": [
                    {
                        "publicKey": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
                        "allowedIPs": [
                            "0.0.0.0/0",
                            "::/0"
                        ],
                        "endpoint": "162.159.192.1:2408" // IPv6 address [2606:4700:d0::a29f:c001]:2408, or use domain engage.cloudflareclient.com:2408
                    }
                ],
                "reserved": [0, 0, 0], // Paste your "reserved" value here
                "mtu": 1280,
                "domainStrategy": "ForceIPv6v4" // Change to "ForceIPv4" if you need to use Cloudflare's IPv4
            },
            "tag": "warp"
        }
```

Edit file **/usr/local/etc/xray/config.json**, add content for **"routing"**, **"inbounds"**, and **"outbounds"** as needed (ensure correct JSON format), then run `systemctl restart xray` to restart Xray. Visit [chat.openai.com/cdn-cgi/trace](https://chat.openai.com/cdn-cgi/trace) to check if it’s a Cloudflare IP.

# "routing"

```jsonc
            {
                "domain": [
                    "geosite:openai"
                ],
                "outboundTag": "warp"
            }
```

# "inbounds"

```jsonc
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
```

# "dns"

```jsonc
    "dns": {
        "servers": [
            "https://1.1.1.1/dns-query"
        ],
        "queryStrategy": "UseIP" // If not specified, defaults to UseIP, querying both A and AAAA records. Options: UseIPv4, UseIPv6. Other record types use system DNS.
    }
```

# Server Configuration Example

```jsonc
{
    "log": {
        "loglevel": "warning"
    },
    "dns": {
        "servers": [
            "https://1.1.1.1/dns-query"
        ],
        "queryStrategy": "UseIP"
    },
    "routing": {
        "domainStrategy": "IPIfNonMatch",
        "rules": [
            {
                "domain": [
                    "geosite:openai"
                ],
                "outboundTag": "warp"
            },
            {
                "ip": [
                    "geoip:cn"
                ],
                "outboundTag": "warp"
            }
        ]
    },
    "inbounds": [
        {
            // Paste your server configuration here
            "sniffing": {
                "enabled": true,
                "destOverride": [
                    "http",
                    "tls",
                    "quic"
                ]
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom",
            "settings": {
                "domainStrategy": "UseIP"
            },
            "tag": "direct"
        },
        {
            "protocol": "blackhole",
            "tag": "block"
        },
        {
            "protocol": "wireguard",
            "settings": {
                "secretKey": "",
                "address": [
                    "172.16.0.2/32",
                    "2606:4700::/128"
                ],
                "peers": [
                    {
                        "publicKey": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
                        "allowedIPs": [
                            "0.0.0.0/0",
                            "::/0"
                        ],
                        "endpoint": "162.159.192.1:2408"
                    }
                ],
                "reserved": [0, 0, 0],
                "mtu": 1280,
                "domainStrategy": "ForceIPv6v4" // 1
            },
            "tag": "warp"
        }
    ]
}
```

**1:** If not specified or left empty, defaults to "ForceIP".  
When the destination is a domain, Xray-core’s built-in DNS server queries the IP (if no `"dns"` config is provided, system DNS is used), and the connection is made through WireGuard using this IP.

| domainStrategy | [test-ipv6.com](https://test-ipv6.com/) | [bgp.he.net](https://bgp.he.net/) | [chat.openai.com](https://chat.openai.com/cdn-cgi/trace) |
| :--- | :---: | :---: | :---: |
| ForceIPv6v4 | IPv6v4 address | IPv6 address | IPv6 address |
| ForceIPv6 | Website inaccessible | IPv6 address | IPv6 address |
| ForceIPv4v6 | IPv6v4 address **2** | IPv4 address | IPv4 address |
| ForceIPv4 | IPv4 address | IPv4 address | IPv4 address |
| ForceIP | IPv6v4 address **3** | IPv6 address | IPv6 address |

**2:** May display: "You already have an IPv6 address, but your browser is reluctant to use it, which is concerning."  
**3:** May occasionally display: "You already have an IPv6 address, but your browser is reluctant to use it, which is concerning."