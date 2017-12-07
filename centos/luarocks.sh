#!/bin/sh

yum -y install make
yum -y install unzip
yum -y install wget
yum -y install lua lua-devel

wget http://luarocks.github.io/luarocks/releases/luarocks-2.4.3.tar.gz
tar -zxvf luarocks-2.4.3.tar.gz
cd luarocks-2.4.3
./configure --with-lua-include=/usr/include/
make build
make install

cd ..
rm -rf luarocks-2.4.3 luarocks-2.4.3.tar.gz
