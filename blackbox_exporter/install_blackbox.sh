#!/bin/bash
tar -zxvf blackbox_exporter-0.18.0.linux-amd64.tar.gz -C /opt/
cp /opt/blackbox_exporter-0.18.0.linux-amd64/blackbox_exporter.service /etc/systemd/system/
systemctl enable blackbox_exporter.service
systemctl daemon-reload
systemctl start  blackbox_exporter.service
systemctl status  blackbox_exporter.service
sleep 3s
curl localhost:9115/metrics
