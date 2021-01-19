#!/bin/bash

tar -zxvf postgres_exporter_v0.8.0_linux-amd64.tar.gz -C /opt/

echo -e "\033[1;33m请输入postgres的IP，默认为localhost，如果使用默认，请输入1并回车；如果需要自定义，请输入IP： \033[0m"

read postgres_ip

if [ $postgres_ip = 1 ]
    then
        export postgres_ip="localhost"
    else
        export postgres_ip=$postgres_ip
fi

sed -i "s/postgres_ip/$postgres_ip/" /opt/postgres_exporter_v0.8.0_linux-amd64/postgres_exporter.service

echo -e "\033[1;33m请输入postgres的端口，默认为5432，如果使用默认，请输入1并回车；如果postgres设置有另外端口，请输入端口： \033[0m"

read postgres_port
if [ $postgres_port = 1 ]
    then
        export postgres_port=5432
        sed -i "s/postgres_port/$postgres_port/" /opt/postgres_exporter_v0.8.0_linux-amd64/postgres_exporter.service
    else
        export postgres_port=$postgres_port
        sed -i "s/postgres_port/$postgres_port/" /opt/postgres_exporter_v0.8.0_linux-amd64/postgres_exporter.service
fi


cp /opt/postgres_exporter_v0.8.0_linux-amd64/postgres_exporter.service /etc/systemd/system/

systemctl enable postgres_exporter.service
systemctl daemon-reload
systemctl start postgres_exporter.service
systemctl status postgres_exporter.service
sleep 3s
curl localhost:9187/metrics
