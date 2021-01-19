#!/bin/bash


tar -zxvf nginx-vts-exporter-0.10.3.linux-amd64.tar.gz -C /opt/

echo -e "\033[1;33m请输入nginx的IP，默认为localhost，如果使用默认，请输入1并回车；如果需要自定义，请输入IP： \033[0m"

read nginx_ip

if [ $nginx_ip = 1 ]
    then
        export nginx_ip="localhost"
    else
        export nginx_ip=$nginx_ip
fi

sed -i "s/localhost/$nginx_ip/" /opt/nginx-vts-exporter-0.10.3.linux-amd64/nginx_exporter.service


cp /opt/nginx-vts-exporter-0.10.3.linux-amd64/nginx_exporter.service /etc/systemd/system/

systemctl enable nginx_exporter.service
systemctl daemon-reload
systemctl start nginx_exporter.service
systemctl status nginx_exporter.service
sleep 3s
curl localhost:9913/metrics
