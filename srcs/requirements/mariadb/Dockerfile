FROM debian:11

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y vim mariadb-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY ./tools/entrypoint.sh /usr/local/bin

WORKDIR /usr/local/bin

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]