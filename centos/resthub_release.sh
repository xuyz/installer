#!/bin/sh

CURDIR=`pwd`

# yum-utils
cd $CURDIR
cd utils
yum -y install *.rpm

# epel
cd $CURDIR
cd epel
yum -y install *.rpm

# openresty
cd $CURDIR
cd openresty
yum -y install *.rpm

# postgresql
cd $CURDIR
cd postgresql
yum -y install *.rpm

/usr/pgsql-9.6/bin/postgresql96-setup initdb
systemctl enable postgresql-9.6
sed -i 's/^local.*all.*all.*peer/local all all trust/g' /var/lib/pgsql/9.6/data/pg_hba.conf
sed -i 's/^host.*all.*all.*127.0.0.1\/32.*ident/host all all 127.0.0.1\/32  trust/g' /var/lib/pgsql/9.6/data/pg_hba.conf
systemctl start postgresql-9.6

sudo -u postgres createuser kong
sudo -u postgres createdb -O kong kong
sudo -u postgres createdb -O kong kong_tests

# kong
cd $CURDIR
cd kong
yum -y install *.rpm

sed -i ~/.bash_profile -e "/export PATH/d"
echo "PATH=$PATH:/usr/local/openresty/bin/:/usr/local/openresty/nginx/sbin" >> ~/.bash_profile
echo "export PATH" >> ~/.bash_profile
echo "ulimit -n 8192" >>  ~/.bash_profile
source ~/.bash_profile


