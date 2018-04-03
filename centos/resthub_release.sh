#!/bin/sh

CURDIR=`pwd`

# yum-utils
cd $CURDIR
cd utils
yum -y install utils/epel-release-7-11.noarch.rpm


# epel
cd $CURDIR
cd epel
yum -y install epel-release-7-9.noarch.rpm

# openresty
cd $CURDIR
cd openresty
yum -y install openresty-pcre-8.41-1.el7.centos.x86_64.rpm
yum -y install openresty-openssl-1.0.2k-1.el7.centos.x86_64.rpm
yum -y install openresty-zlib-1.2.11-3.el7.centos.x86_64.rpm
yum -y install openresty-resty-1.13.6.1-1.el7.centos.noarch.rpm
yum -y install openresty-1.13.6.1-1.el7.centos.x86_64.rpm

# postgresql
cd $CURDIR
yum -y install glib2-2.50.3-3.el7.x86_64.rpm
yum -y install initscripts-9.49.39-1.el7_4.1.x86_64.rpm
yum -y install kmod-20-15.el7_4.7.x86_64.rpm
yum -y install dracut-network-033-502.el7_4.1.x86_64.rpm dracut-033-502.el7_4.1.x86_64.rpm dracut-config-rescue-033-502.el7_4.1.x86_64.rpm
yum -y install systemd-219-42.el7_4.10.x86_64.rpm  systemd-libs-219-42.el7_4.10.x86_64.rpm systemd-sysv-219-42.el7_4.10.x86_64.rpm libgudev1-219-42.el7_4.10.x86_64.rpm
yum -y install postgresql96-libs-9.6.8-1PGDG.rhel7.x86_64.rpm postgresql96-9.6.8-1PGDG.rhel7.x86_64.rpm postgresql96-server-9.6.8-1PGDG.rhel7.x86_64.rpm

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

#
