# docker-nginx

```SHELL
# 宿主机是 linux系统
docker run --name nginx -e HOST_OS=linux -p 80:80 -v /www:/www -d foxiswho/nginx:last

# 宿主机是 mac系统
docker run --name nginx -e HOST_OS=mac -p 80:80 -v /Volumes:/Volumes -d foxiswho/nginx:last

# 直接使用docker
docker run --name nginx -p 80:80 -d foxiswho/nginx:last
```

# HOST_OS: `linux` 宿主机是 linux系统
挂载 宿主机 `/www` 目录，容器目录为 `/www`

宿主机 `/www/vhost` 目录中有 nginx 的配置文件,需要用户自己配置(可以复制`conf`目录下的`default.conf`为案例配置)

宿主机 `/www/logs` 为日志目录

宿主机 `/www/wwwroot` 为默认站点根目录

# HOST_OS:  `mac` 宿主机是 mac系统

宿主机 `/Volumes/work/vhost` 目录中有 nginx 的配置文件,需要用户自己配置(可以复制`conf`目录下的`default.conf`为案例配置,相应的目录地址也要修改)

宿主机 `/Volumes/work/logs` 为日志目录

宿主机 `/Volumes/work/wwwroot` 为默认站点根目录

# HOST_OS: `windows` 宿主机是 windows系统
挂载 宿主机 `E:/User/fox/www` 目录，容器目录为 `/www`

宿主机 `E:/User/fox/www/vhost` 目录中有 nginx 的配置文件,需要用户自己配置(可以复制`conf`目录下的`default.conf`为案例配置,相应的目录地址也要修改)

宿主机 `E:/User/fox/www/logs` 为日志目录

宿主机 `E:/User/fox/www/wwwroot` 为默认站点根目录

# HOST_OS:  空,直接使用docker