#!/bin/bash

#Set environment variables
SSL_KEY=$(grep SSL_KEY /run/secrets/credentials | cut -d '=' -f2)
SSL_CERT=$(grep SSL_CERT /run/secrets/credentials | cut -d '=' -f2)
HOST=$(grep G_HOST /run/secrets/credentials | cut -d '=' -f2)

#dir for ssl keys
mkdir /etc/nginx/ssl

chown -R www-data:www-data /var/www
chown -R www-data:www-data /etc/nginx/ssl

# create ssl key and certificate
openssl req -newkey rsa:2048 -nodes -x509 -days 365 -keyout $SSL_KEY -out $SSL_CERT \
    -subj "/C=DE/ST=Lower Saxony/L=Wolfsburg/O=mtrautne/CN=$HOST"

# start nginx
nginx -g 'daemon off;'