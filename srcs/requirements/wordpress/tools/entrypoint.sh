#!/bin/bash

#Get the credentials from the secrets
DBNAME=$(grep DB_NAME /run/secrets/credentials | cut -d '=' -f2)
DBUSER=$(grep DB_USER /run/secrets/credentials | cut -d '=' -f2)
DBPASS=$(cat /run/secrets/db_password)
DBHOST=$(grep DB_HOST /run/secrets/credentials | cut -d '=' -f2)
WP_ADMIN_USER=$(grep WP_ADMIN_USER /run/secrets/credentials | cut -d '=' -f2)
WP_ADMIN_PASS=$(grep WP_ADMIN_PASS /run/secrets/credentials | cut -d '=' -f2)
WP_ADMIN_EMAIL=$(grep WP_ADMIN_EMAIL /run/secrets/credentials | cut -d '=' -f2)
WP_USER=$(grep WP_USER /run/secrets/credentials | cut -d '=' -f2)
WP_PASS=$(grep WP_PASS /run/secrets/credentials | cut -d '=' -f2)
WP_EMAIL=$(grep WP_EMAIL /run/secrets/credentials | cut -d '=' -f2)
G_HOST=$(grep G_HOST /run/secrets/credentials | cut -d '=' -f2)

# get wordpress cli
mkdir /run/php
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# install wordpress
if ! wp core --allow-root is-installed ; then
    chown -R www-data:www-data /var/www/
    cd /var/www/html/
    wp core download --allow-root
    wp core config --dbname=$DBNAME --dbuser=$DBUSER --dbpass=$DBPASS --dbhost=$DBHOST --allow-root
    wp core install --allow-root --url=$G_HOST --title="my wordpress blog" --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL
    wp --allow-root user create $WP_USER  $WP_EMAIL --role=author --user_pass=$WP_PASS --display_name=$WP_USER
    chmod -R 777 /var/www/html
else
    echo -e "\e[1;32mwp already installed!\e[0m"
fi
echo -e "\e[1;32mwp setup done!\e[0m"

# Start php-fpm
php-fpm7.4 -F