FROM debian:11

RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 9000

ENTRYPOINT ["tail", "-f", "/dev/null"]
