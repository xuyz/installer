#!/bin/sh

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

mkdir -p /etc/yum.repos.d/

echo '
[kibana-5.x]
name=Kibana repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
' >> /etc/yum.repos.d/elastic.repo


yum -y install kibana
