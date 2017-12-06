#!/bin/sh

yum -y install yum-utils
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum -y install openresty

