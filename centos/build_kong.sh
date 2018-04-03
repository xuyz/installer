#!/bin/sh

yum -y install yum-utils --downloadonly --downloaddir=utils
yum -y install epel-release --downloadonly --downloaddir=utils

### download depends
# openresty
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum -y install openresty openresty-resty --downloadonly --downloaddir=openresty

# kong


# postgres
yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96 --downloadonly --downloaddir=postgresql
yum install -y postgresql96-server --downloadonly --downloaddir=postgresql
