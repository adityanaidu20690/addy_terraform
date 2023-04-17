#!/bin/bash
yum install docker -y
yum install git -y
yum update -y
yum install httpd -y
systemctl enable ttpd
service httpd start
service httpd restart
echo "hi ra" > /var/www/html/index.html
