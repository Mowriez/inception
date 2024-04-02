FROM debian:11

RUN apt-get update && apt-get upgrade -y && apt-get install -y vim
RUN apt-get install -y mariadb-server

EXPOSE 3306

CMD ["mysqld"]