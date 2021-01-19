#!/bin/bash

#export REDIS_IP=

tar -zxvf redis_exporter-v1.13.1.linux-amd64.tar.gz -C /opt/

echo -e "\033[1;33m请输入redis的IP，默认为localhost，如果使用默认，请输入1并回车；如果需要自定义，请输入IP： \033[0m"

read redis_ip

if [ $redis_ip = 1 ]
    then
        export REDIS_IP="localhost"
    else
        export REDIS_IP=$redis_ip
fi

sed -i "s/REDIS_IP/$REDIS_IP/" /opt/redis_exporter-v1.13.1.linux-amd64/redis_exporter.service

echo -e "\033[1;33m请输入redis的密码，默认为空，如果使用默认，请输入1并回车；如果Redis设置有密码，请输入密码： \033[0m"

read redis_pass
if [ $redis_pass = 1 ]
    then
        #export REDIS_PASSWORD=""
        sed -i s/-redis.password "REDIS_PASSWORD"// /opt/redis_exporter-v1.13.1.linux-amd64/redis_exporter.service
    else
        export REDIS_PASSWORD=$redis_pass
        sed -i "s/REDIS_PASSWORD/$REDIS_PASSWORD/" /opt/redis_exporter-v1.13.1.linux-amd64/redis_exporter.service
fi


cp /opt/redis_exporter-v1.13.1.linux-amd64/redis_exporter.service /etc/systemd/system/

systemctl enable redis_exporter.service
systemctl daemon-reload
systemctl start redis_exporter.service
systemctl status redis_exporter.service
sleep 3s
curl localhost:9121/metrics
