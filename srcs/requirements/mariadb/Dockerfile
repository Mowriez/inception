FROM debian:11

RUN apt-get update && apt-get upgrade -y && apt-get install -y vim
RUN apt-get install -y mariadb-server

COPY ./tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]