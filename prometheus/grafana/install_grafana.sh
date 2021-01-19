#!/bin/bash

useradd -s /bin/bash -m grafana

mkdir -p /usr/share/grafana /var/log/grafana /var/lib/grafana /etc/grafana 

tar -zxvf grafana-7.3.6.linux-amd64.tar.gz
cd grafana-7.3.6

cp grafana-server.sysconfig /etc/sysconfig/grafana-server
cp grafana-server.service /etc/systemd/system/

cp bin/grafana-cli bin/grafana-server /usr/sbin/
cp -r conf/*  /etc/grafana/
cp -r * /usr/share/grafana/
cp -r data/* /var/lib/grafana/

chown -R grafana:grafana /usr/share/grafana /var/log/grafana /var/lib/grafana /etc/grafana

systemctl daemon-reload
systemctl enable grafana-server.service
systemctl start grafana-server.service
systemctl status grafana-server.service

