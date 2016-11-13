FROM nginx:latest

RUN apt-get update \
&& apt-get install -y  vim  wget \
&& rm -rf /var/lib/apt/lists/* \
&& rm -rf /tmp/*

RUN rm -rf /etc/localtime \
&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& echo "alias ls='ls -lhG --color=auto'" >> /root/.bashrc \
&& echo "alias ll='ls -lhG --color=auto'" >> /root/.bashrc \
&& . /root/.bashrc

RUN sed '1i\fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;' /etc/nginx/fastcgi_params > /etc/nginx/fastcgi

#&& sed -i 's:include /etc/nginx/conf:#include /etc/nginx/conf:g;' /etc/nginx/nginx.conf \
#&& sed -i "s:conf;:conf;\n    include /Volumes/work/vhost/\*.conf;:g" /etc/nginx/nginx.conf