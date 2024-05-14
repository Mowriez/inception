FROM debian:11

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysqlnd \
    curl \
    php-curl \
    php-bcmath \
    php-gd \
    php-soap \
    php-mbstring \
    php-gd \
    php-xml \
    php-intl \
    php-zip \
    php-xmlrpc \
    php-cgi \
    unzip \
    wget \
    # sendmail \
    && rm -rf /var/lib/apt/lists/*
#really only need the first 3 for demonstration purposes

RUN rm /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/

COPY ./tools/entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
