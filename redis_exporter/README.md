### 介绍

详见[github地址](https://github.com/oliver006/redis_exporter)

### 安装


####  安装redis_exporter
```
$ sh install_redis_exporter.sh

请输入redis的IP，默认为localhost，如果使用默认，请输入1并回车；如果需要自定义，请输入IP：

请输入redis的密码，默认为空，如果使用默认，请输入1并回车；如果Redis设置有密码，请输入密码：

```
验证redis_exporter 是否安装成功
```
$ curl localhost:9121/metrics
```
Prometheus配置redis_exporter
```
  - job_name: 'redis_exporter'

    static_configs:
    - targets:
      - localhost:9121
      labels:
        app: "redis_exporter"
```

