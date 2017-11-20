#!/bin/sh

yum -y install supervisor

echo '
#[program:test]
#command=python3 /path/start.py
#directory=/path
#user=root
#autorestart=true
#redirect_stderr=true
#stdout_logfile=/var/log/test/access.log
#loglevel=info
' > /etc/supervisord.d/example.conf


