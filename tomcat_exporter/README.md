### 安装

#### 依赖
- tomcat 安装目录在/data/tomcat下


#### 安装jmx_prometheus_javaagent-0.12.0.jar

```
$ cp jmx_prometheus_javaagent-0.12.0.jar jmx_config.yaml setenv.sh /data/tomcat/bin/


```

重启tomcat
```
$ tomcat restart
```

#### 验证
```
$ curl localhost:9151/metrics
```

#### Prometheus配置
```
  - job_name: 'tomcat'

    static_configs:
    - targets:
      - localhost:9151 #tomcat的IP地址
      labels:
        app: "tomcat"
```
