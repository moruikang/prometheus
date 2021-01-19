#!/bin/bash

mkdir -p /data

tar -zxvf prometheus-2.19.2.linux-amd64.tar.gz -C /data/

cp /data/prometheus-2.19.2.linux-amd64/prometheus.service  /etc/systemd/system/

systemctl daemon-reload
systemctl enable prometheus.service
systemctl start prometheus.service
systemctl status prometheus.service
