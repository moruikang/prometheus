### 适用场景
当prometheus exporter和prometheus不能网络直接通信的时候，需要通过pushgateway中转，exporter 定时上报数据到pushgateway， prometheus拉取pushgateway数据，实现数据采集

#### 安装

```
$ sh install_pushgateway.sh

```

####  验证
```
$ curl localhost:9091/metrics
```

#### Prometheus配置
```
scrape_configs:
  - job_name: 'pushgateway'

    static_configs:
    - targets:
      - 47.107.103.75:9091  #pushgateway IP地址，可和prometheus，对应exporter网络互通
      labels:
        host: "pushgateway"
```
