
## Hysteria2手动搭建


---
```mkdir /root/hy2 && cd /root/hy2```


```uname -a```

[https://github.com/apernet/hysteria/releases/latest](https://github.com/apernet/hysteria/releases/latest)

```shell
wget -O hy2 url
```

```chmod +x hy2```

---

hy2配置文件：```vim /root/hy2/hy2.yaml```
```shell
listen: :12331 #默认端口443，可以修改为其他端口

#使用CA证书
#acme:
#  domains:
#    - www.example.com #已经解析到服务器的域名 需开放80 443 端口
#  email: vum@vum.qzz.io #你的邮箱

#使用自签证书
tls:
  cert: ./cert.crt 
  key: ./private.key 

quic:
  initStreamReceiveWindow: 8388608
  maxStreamReceiveWindow: 8388608
  initConnReceiveWindow: 16777216
  maxConnReceiveWindow: 16777216

auth:
  type: password
  password: 123123 #认证密码，使用一个强密码进行替换


masquerade:
  type: proxy
  proxy:
    url: https://www.bing.com #伪装网址
    rewriteHost: true
```

---

生成自签证书

```openssl ecparam -genkey -name prime256v1 -out /root/hy2/private.key```

```openssl req -new -x509 -days 36500 -key /root/hy2/private.key -out /root/hy2/cert.crt -subj "/CN=www.bing.com"```

---

systemd：放到 `/etc/systemd/system/hy2.service`

hy2守护进程配置文件：```vim /etc/systemd/system/hy2.service```
```shell
[Unit]
Description=Hysteria Server Service (hy2.yaml)
After=network.target

[Service]
Type=simple
ExecStart=/root/hy2/hy2 server --config /root/hy2/hy2.yaml
WorkingDirectory=/root/hy2
User=root
Group=root
Environment=HYSTERIA_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true
Restart=always
RestartSec=10
MemoryMax=150M
OOMScoreAdjust=-500

[Install]
WantedBy=multi-user.target
```

重新加载systemd配置：```systemctl daemon-reload```

---

设置开机自启
```systemctl enable hy2```

启动Hysteria2
```systemctl start hy2```

重启Hysteria2
```systemctl restart hy2```

查看Hysteria2状态
```systemctl status hy2```

停止Hysteria2
```systemctl stop hy2```


查看日志
```journalctl -u hy2 -f```


---


OpenRC：放到 `/etc/init.d/hy2`

`vi /etc/init.d/hy2`
```
#!/sbin/openrc-run

name="hy2"
description="Hysteria2 server"

command="/root/hy2/hy2"
command_args="server --config /root/hy2/hy2.yaml"
directory="/root/hy2"

supervisor=supervise-daemon
respawn_delay=5
respawn_max=0

depend() {
    need net
}
```

`chmod +x /etc/init.d/hy2`


开机自启：`rc-update add hy2 default`

`rc-service hy2 status`

`rc-service hy2 start`

`rc-service hy2 restart`


> 推荐优先使用systemd



---

导入代理软件格式：
```shell
hy2://password@ip:port/?insecure=1&sni=www.bing.com#节点名称
```
请将```password``` ```ip``` ```port```替换成你的。

---


非root用户，使用一键脚本（使用nohup守护进程）
```shell
curl -o hysteria.sh -fsSL https://raw.githubusercontent.com/MEILOI/HYTWOALPINE/main/hysteria.sh && chmod +x hysteria.sh && ./hysteria.sh
```

---

