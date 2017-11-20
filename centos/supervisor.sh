#!/bin/sh

yum -y install supervisor

echo '
#[program:test]
#command=python3 /path/start.py
#directory=/path
#user=root
' > /etc/supervisord.d/example.conf


