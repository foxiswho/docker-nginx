#/bin/bash

# 用于手动操作,设置 nginx 配置文件目录为指定目

# usage: file_env VAR [DEFAULT]
#    ie: file_env 'XYZ_DB_PASSWORD' 'example'
# (will allow for "$XYZ_DB_PASSWORD_FILE" to fill in the value of
#  "$XYZ_DB_PASSWORD" from a file, especially for Docker's secrets feature)
file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'HOST_OS'
#if [ -z "$HOST_OS" ]; then
#    HOST_OS=mac
#fi
echo "宿主机系统变量："
echo $HOST_OS

echo "当前宿主机系统："
file_host_os=/host_os
if [ -f "$file_host_os" ]; then
    cat $file_host_os
else
    echo "$HOST_OS" > $file_host_os
    cat $file_host_os

    // 第一次处理
    // linux系统
    if [ "$HOST_OS" = "linux" ]; then
        # 加载宿主机 的目录,所以原目录要改变名称
        mv /www /www_backup
        sed -i 's:include /etc/nginx/conf:#include /etc/nginx/conf:g;' /etc/nginx/nginx.conf
        sed -i "s:conf;:conf;\n    include /www/vhost/\*.conf;:g" /etc/nginx/nginx.conf

    elif [ "$HOST_OS" = "mac" ]; then
        // mac 系统
        sed -i 's:include /etc/nginx/conf:#include /etc/nginx/conf:g;' /etc/nginx/nginx.conf
        sed -i "s:conf;:conf;\n    include /Volumes/work/vhost/\*.conf;:g" /etc/nginx/nginx.conf

    elif [ "$HOST_OS" = "windows" ]; then
        # 加载宿主机 的目录,所以原目录要改变名称
        mv /www /www_backup
        // windows 系统
        sed -i 's:include /etc/nginx/conf:#include /etc/nginx/conf:g;' /etc/nginx/nginx.conf
        sed -i "s:conf;:conf;\n    include /www/vhost/\*.conf;:g" /etc/nginx/nginx.conf
    else
        // 直接使用docker
        sed -i 's:include /etc/nginx/conf:#include /etc/nginx/conf:g;' /etc/nginx/nginx.conf
        sed -i "s:conf;:conf;\n    include /www/vhost/\*.conf;:g" /etc/nginx/nginx.conf
    fi
fi

exit 1