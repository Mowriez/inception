#!/bin/bash

echo "
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    index index.html;
    root /var/www/html;
}
" > /etc/nginx/sites-available/default

nginx -g "daemon off;"