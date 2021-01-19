#!/bin/bash


tar -zxvf rabbitmq_exporter-1.0.0-RC7.linux-amd64.tar.gz -C /opt/

echo -e "\033[1;33m请输入rabbitmq的IP，默认为localhost，如果使用默认，请输入1并回车；如果需要自定义，请输入IP： \033[0m"

read rabbitmq_ip

if [ $rabbitmq_ip = 1 ]
    then
        export rabbitmq_ip="localhost"
    else
        export rabbitmq_ip=$rabbitmq_ip
fi

sed -i "s/rabbit_ip/$rabbitmq_ip/" /opt/rabbitmq_exporter-1.0.0-RC7.linux-amd64/config.json


cp /opt/rabbitmq_exporter-1.0.0-RC7.linux-amd64/rabbitmq_exporter.service /etc/systemd/system/

systemctl enable rabbitmq_exporter.service
systemctl daemon-reload
systemctl start rabbitmq_exporter.service
systemctl status rabbitmq_exporter.service
sleep 3s
curl localhost:9419/metrics
