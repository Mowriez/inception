FROM debian:11

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y vim
RUN apt-get install -y mariadb-server

COPY ./tools/entrypoint.sh /

EXPOSE 3306

CMD ["./entrypoint.sh"]