#!/bin/bash

echo $WEBSITE_HOSTNAMES

read -r -a hosts <<< "$WEBSITE_HOSTNAMES"

mkdir -p /usr/nginx/conf.d


for item in "${hosts[@]}"; do
    echo "server {
        listen 0.0.0.0:8080;
        server_name $item;

        root /app/$item;

        location / {
            index index.php index.html; # File di indice predefiniti da cercare nella directory
        }

        location ~ \.php$ {
            # fastcgi_pass [PHP_FPM_LINK_NAME]:9000;
            fastcgi_pass phpfpm:9000;
            fastcgi_index index.php;
            include fastcgi.conf;
        }
}" > /opt/bitnami/nginx/conf/server_blocks/$item.conf
done

nginx -g 'daemon off;'
