FROM debian:11

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-curl \
    php-bcmath \
    php-gd \
    php-soap \
    php-mbstring \
    php-mysqlnd \
    php-gd \
    php-xml \
    php-intl \
    php-zip \
    php-xmlrpc \
    php-cgi \
    curl \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 9000

RUN rm /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/
COPY ./tools/entrypoint.sh /usr/bin

RUN chmod +x /usr/bin/entrypoint.sh


ENTRYPOINT ["/usr/bin/entrypoint.sh"]
