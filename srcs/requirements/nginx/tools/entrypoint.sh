#!/bin/bash

#Set environment variables
export SSL_KEY=$(grep SSL_KEY /run/secrets/credentials | cut -d '=' -f2)
export SSL_CERT=$(grep SSL_CERT /run/secrets/credentials | cut -d '=' -f2)
export HOST=$(grep HOST /run/secrets/credentials | cut -d '=' -f2)

#dir for ssl keys
mkdir /etc/nginx/ssl

# create ssl key and certificate
openssl req -newkey rsa:2048 -nodes -x509 -days 365 -keyout $SSL_KEY -out $SSL_CERT \
    -subj "/C=DE/ST=Lower Saxony/L=Wolfsburg/O=mtrautne/CN=$HOST"

# nginx doens't understand env variables in the conf file so we need to replace them
envsubst < /usr/share/nginx/mtrautne.conf > /etc/nginx/sites-available/default

# start nginx
nginx -g 'daemon off;'