#!/bin/bash

echo $WEBSITE_HOSTNAMES

read -r -a hosts <<< "$WEBSITE_HOSTNAMES"

mkdir -p /usr/nginx/conf.d


for item in "${hosts[@]}"; do
    echo "server {
        listen 80;
        server_name $item;

        location / {
            root /usr/share/nginx/html/$item;
            index index.html;
        }
    }" > /etc/nginx/conf.d/$item.conf
done

nginx -g 'daemon off;'
