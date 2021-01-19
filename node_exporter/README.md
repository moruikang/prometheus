### 安装

#### 在每一台需要监控的主机上 执行 install_node_exporter.sh 安装脚本
##### node_exporter是主机指标收集器，用于收集主机CPU，Memory, Dsik，IO等metrics

```
$ sh  install_node_exporter.sh

```

####  验证
```
$ curl localhost:9100/metrics
```

#### Prometheus配置
```
  - job_name: 'node_exporter'

    static_configs:
    - targets:
      - localhost:9100  # nginx_vts_exporter地址
      labels:
        app: "node_exporter"
        host: "192.168.2.25" #假设这台监控主机IP是192.168.2.25
    #job_name可加入多个targets
    - targets:
      - 192.168.2.26:9100  # nginx_vts_exporter地址
      labels:
        app: "node_exporter"
        host: "192.168.2.26" #假设这台监控主机IP是192.168.2.26
```

#### Grafana Dashboard

node_exporter_dashboard.json 是Grafana Dashboard json文件，从Grafana导入即可



