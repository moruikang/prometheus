### 前提依赖
- 9090端口单独划分给prometheus
- /data目录最好挂一块磁盘，用于存储prometheus数据
 
### 安装

#### 一. Linux安装prometheus

```
$ sh install_prometheus.sh

验证blackbox 是否安装成功
$ netstat -tnlp |grep 9090
tcp6       0      0 :::9090                 :::*                    LISTEN      945/prometheus

$ systemctl status prometheus
```

#### 安装路径和配置介绍
```
$ cat /etc/systemd/system/prometheus.service
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=root
Group=root
Type=simple
ExecStart=/data/prometheus-2.19.2.linux-amd64/prometheus \
    --config.file /data/prometheus-2.19.2.linux-amd64/prometheus.yml \
    --storage.tsdb.path /data/prometheus-2.19.2.linux-amd64/ \
    --web.console.templates=/data/prometheus-2.19.2.linux-amd64/consoles \
    --web.console.libraries=/data/prometheus-2.19.2.linux-amd64/console_libraries

[Install]
WantedBy=multi-user.target
```
prometheus会安装在/data目录下，配置文件位于: /data/prometheus-2.19.2.linux-amd64/prometheus.yml，默认监听9090端口

#### 二. Windows安装prometheus
解压prometheus-2.24.0.windows-amd64.zip,进入文件夹内部，双击prometheus.exe

#### 三.访问prometheus Dashboard
打开浏览器，访问prometheus部署节点ip:9090

