# Use the penultimate version of Debian
FROM debian:11

RUN apt-get update && apt-get install -y nginx openssl
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


RUN rm /etc/nginx/nginx.conf
COPY ./tools/nginx.conf /etc/nginx/

COPY ./tools/entrypoint.sh /usr/local/bin

RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]