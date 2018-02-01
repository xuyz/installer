#!/bin/bash

role=`id -u`
if test $role -ne 0
then
    echo "Root permissions are required"
    exit 1
fi

cd ~

yum install -y gcc gcc-c++ make
yum install -y luarocks lua-devel openssl-devel
luarocks install busted
luarocks install lua-llthreads2

command -v kong
if test $? -ne 0
then
    wget https://bintray.com/kong/kong-community-edition-rpm/rpm -O /etc/yum.repos.d/bintray-kong-kong-community-edition-rpm.repo
    yum -y install kong-community-edition
fi
cp /etc/kong/kong.conf.default /etc/kong/kong.conf

sed -i ~/.bash_profile -e "/export PATH/d"
echo "PATH=$PATH:/usr/local/openresty/bin/:/usr/local/openresty/nginx/sbin" >> ~/.bash_profile
echo "export PATH" >> ~/.bash_profile
echo "ulimit -n 8192" >>  ~/.bash_profile
source ~/.bash_profile

command -v psql
if test $? -ne 0
then
    yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
    yum install -y postgresql96
    yum install -y postgresql96-server

    /usr/pgsql-9.6/bin/postgresql96-setup initdb
    systemctl enable postgresql-9.6
    sed -i 's/^local.*all.*all.*peer/local all all trust/g' /var/lib/pgsql/9.6/data/pg_hba.conf
    sed -i 's/^host.*all.*all.*127.0.0.1\/32.*ident/host all all 127.0.0.1\/32  trust/g' /var/lib/pgsql/9.6/data/pg_hba.conf
    systemctl start postgresql-9.6
fi

cd /tmp
sudo -u postgres createuser kong
sudo -u postgres createdb -O kong kong
sudo -u postgres createdb -O kong kong_tests
cd -


# install custom plugins
luarocks install kong-plugin-token-agent
luarocks install kong-plugin-pipeline
luarocks install kong-plugin-key-secret
luarocks install kong-plugin-extend-headers
luarocks install kong-plugin-debug
luarocks install kong-plugin-param-transformer

sed -i '/#custom_plugins =/i\custom_plugins = key-secret, pipeline, token-agent, extend-headers, debug, param-transformer' /etc/kong/kong.conf
sed -i '/#admin_listen =/i\admin_listen = 0.0.0.0:8001' /etc/kong/kong.conf

kong migrations up
kong start
