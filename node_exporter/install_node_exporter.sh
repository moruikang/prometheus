#!/bin/bash

tar -zxvf node_exporter.tar.gz -C /opt/

echo -e "\033[1;33m node_exporter默认端口是9100,访问地址：http://localhost:9100/metrics \033[0m"


cp /opt/node_exporter/node_exporter  /usr/local/bin/node_exporter
cp /opt/node_exporter/node_exporter.service /etc/systemd/system/

systemctl daemon-reload
systemctl enable node_exporter.service
systemctl start node_exporter.service
systemctl status node_exporter.service
sleep 3s
curl localhost:9100/metrics
