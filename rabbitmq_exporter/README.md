### 介绍

详见[github地址](https://github.com/kbudde/rabbitmq_exporter)

### 安装

#### 安装rabbitmq_exporter

```
$ sh install_rabbitmq_exporter.sh

请输入rabbitmq的IP，默认为localhost，如果使用默认，请输入1并回车；如果需要自定义，请输入IP：

```
验证rabbitmq_exporter 是否安装成功
```
$ curl localhost:9419/metrics
```
Prometheus配置rabbitmq_exporter
```
  - job_name: 'rabbitmq_exporter'

    static_configs:
    - targets:
      - localhost:9419
      labels:
        app: "rabbitmq_exporter"
```

