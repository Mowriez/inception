#!/bin/bash

# potentially change ownership (recursively) of # /var/www/mtrautne to www-data (nginx user)
# chown -R 33:33 /var/www/mtrautne.conf

# create ssl key and certificate
openssl req \
       -newkey rsa:2048 -nodes -keyout $SSL_KEY \
       -x509 -days 365 -out $SSL_CERT \
       -subj "/C=DE/ST=Lower Saxony/L=Wolfsburg/O=mtrautne/CN=mtrautne.42.fr"

# nginx doens't understand env variables in the conf file
envsubst < /usr/share/nginx/mtrautne.conf > /etc/nginx/sites-available/default

# start nginx
nginx -g 'daemon off;'