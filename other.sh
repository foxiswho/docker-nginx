#/bin/bash

# 用于手动操作,设置 nginx 配置文件目录为指定目

sed -i 's:include /etc/nginx/conf:#include /etc/nginx/conf:g;' /etc/nginx/nginx.conf \
&& sed -i "s:conf;:conf;\n    include /Volumes/work/vhost/\*.conf;:g" /etc/nginx/nginx.conf