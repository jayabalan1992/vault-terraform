#!/bin/bash
echo "
[influxdb]
name = InfluxDB Repository - RHEL \$releasever
baseurl = https://repos.influxdata.com/rhel/\$releasever/\$basearch/stable
enabled = 1
gpgcheck = 1
gpgkey = https://repos.influxdata.com/influxdb.key "> /etc/yum.repos.d/influxdb.repo

yum install telegraf -y
systemctl start telegraf
systemctl enable telegraf

