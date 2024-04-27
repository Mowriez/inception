FROM debian:11

RUN apt-get update && apt-get install -y \
RUN apt-get install -y \
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

ENTRYPOINT ["tail", "-f", "/dev/null"]
