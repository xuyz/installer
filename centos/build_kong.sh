#!/bin/sh

### download depends
# yum-utils
yum -y install yum-utils --downloadonly --downloaddir=utils

# epel
yum -y install epel-release --downloadonly --downloaddir=epel

# openresty
yum -y install yum-utils
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum -y install openresty --downloadonly --downloaddir=openresty

# kong
wget https://bintray.com/kong/kong-community-edition-rpm/rpm -O /etc/yum.repos.d/bintray-kong-kong-community-edition-rpm.repo
yum install epel-release --downloadonly --downloaddir=kong
yum -y install kong-community-edition --downloadonly --downloaddir=kong

# postgres
yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum install -y postgresql96 --downloadonly --downloaddir=postgresql
yum install -y postgresql96-server --downloadonly --downloaddir=postgresql
