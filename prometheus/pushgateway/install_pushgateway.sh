#!/bin/bash


tar -zxvf pushgateway-1.3.0.linux-amd64.tar.gz -C /opt/

echo -e "\033[1;33m pushgateway默认端口是9091,访问地址：http://localhost:9091/metrics \033[0m"


cp /opt/pushgateway-1.3.0.linux-amd64/pushgateway.service /etc/systemd/system/

systemctl daemon-reload
systemctl enable pushgateway.service
systemctl start pushgateway.service
systemctl status pushgateway.service
sleep 3s
curl localhost:9091/metrics
