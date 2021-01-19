### 项目组织架构
```
prometheus
├ README.md
├ blackbox_exporter
├ nginx_exporter
├ node_exporter
├ postgres_exporter
├ prometheus         #包含prometheus，grafana，pushgateway基础组件
├ rabbitmq_exporter
├ redis_exporter
└ tomcat_exporter
```
### 介绍
项目主要包含prometheus基础组件和各个应用的exporter，相关安装方式在各自文件夹内的README.md.


### 参考文档

- [Prometheus](https://prometheus.io)
- [Prometheus中文](https://yunlzheng.gitbook.io/prometheus-book/)
- [Prometheus exporter](https://prometheus.io/docs/instrumenting/exporters/)
