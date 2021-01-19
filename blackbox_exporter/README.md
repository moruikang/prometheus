### 介绍
[Blackbox Exporter](https://github.com/prometheus/blackbox_exporter) 是 Prometheus 社区提供的官方黑盒监控解决方案，其允许用户通过：HTTP、HTTPS、DNS、TCP 以及 ICMP 的方式对网络进行探测

### 安装

#### 一. Linux安装blackbox
```
$ sh install_blackbox.sh

验证blackbox 是否安装成功
$ curl localhost:9115/metrics
```

#### 二. Windows安装blackbox
解压blackbox_exporter-0.18.0.linux-amd64.tar.gz，进入解压目录内，双击blackbox_exporter.exe

#####  Prometheus 配置blackbox 示例
示例1，telnet探测本机redis端口是否存活
```
  - job_name: 'blackbox'
    metrics_path: /probe
    params:
      module: ['tcp_connect']
    static_configs:
    - targets:
      - localhost:6379
      labels:
        app: "redis"
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: localhost:9115
```
示例2， 当blackbox部署在需要pushgateway中转数据到Prometheus架构下时

```
# 此处redis ip是172.18.223.146， pushgateway部署在本机localhost时的示例
$ curl -s "localhost:9115/probe?target=172.18.223.146:6379&module=tcp_connect"|curl --data-binary @- http://localhost:9091/metrics/job/blackbox-exporter/app/redis/ipaddr/172.18.223.146
```
