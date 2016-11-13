FROM nginx:latest

RUN rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
&& apt-get update \
&& apt-get install -y  vim  wget \
&& echo "alias ls='ls -lhG --color=auto'" >> /root/.bashrc \
&& echo "alias ll='ls -lhG --color=auto'" >> /root/.bashrc \
&& . /root/.bashrc

RUN sed '1i\fastcgi_param  SCRIPT_FILENAME    \$document_root\$fastcgi_script_name;' /etc/nginx/fastcgi_params > /etc/nginx/fastcgi

#&& sed 's:include /etc/nginx/conf:#include /etc/nginx/conf:g;' /etc/nginx/include /etc/nginx/conf \
#&& sed "s:conf;:conf;\ninclude /Volumes/work/vhost/\*.conf;" /etc/nginx/include /etc/nginx/conf