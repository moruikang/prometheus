### 安装

#### 一. 前提：手动编译nginx，添加nginx-module-vts模块

```
$ tar -zxvf nginx-module-vts-0.1.16.tar.gz -C /opt/

$ tar -zxvf nginx-1.16.1.tar.gz

$ cd nginx-1.16.1

$ ./configure --add-module=/opt/nginx-module-vts-0.1.16 # nginx手动编译时，把模块nginx-module-vts编译进去
```

#### 二. 安装nginx_exporter

```
$ sh install_nginx_exporter.sh

请输入nginx的IP，默认为localhost，如果使用默认，请输入1并回车；如果需要自定义，请输入IP：

```

修改nginx.conf
```
http {
    vhost_traffic_status_zone;

    ...

    server {

        ...

        location /status {
            vhost_traffic_status_display;
            vhost_traffic_status_display_format html;
        }
    }
}
```

重启nginx
```
$ nginx restart 或者nginx -s reload
```
#### 三. 验证
```
$ curl localhost:9913/metrics
```

#### 三. Prometheus配置
```
  - job_name: 'nginx_vts_exporter'

    static_configs:
    - targets:
      - localhost:9913  # nginx_vts_exporter地址
      labels:
        app: "nginx_vts_exporter"
```



