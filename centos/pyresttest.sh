#!/bin/sh


yum -y install libcurl-devel

export PYCURL_SSL_LIBRARY=nss 
pip install pycurl

pip install pyresttest
