# Use the penultimate version of Debian
FROM debian:11

# Update package lists and install nginx + vim + openssl
RUN apt-get update && apt-get install -y nginx vim openssl

# Install gettext for envsubst in seperate layer as it dies if i try only one
RUN apt-get install -y gettext-base net-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# just for documentation purposes, real port expose is handled by docker compose file
EXPOSE 443

# Copy files into container environment
COPY ./tools/mtrautne.conf /usr/share/nginx
COPY ./tools/default.css /usr/share/nginx/html
COPY ./tools/mtrautne.html /usr/share/nginx/html
COPY ./tools/entrypoint.sh /usr/bin

RUN chmod +x /usr/bin/entrypoint.sh

# run script after container is launched
ENTRYPOINT ["/usr/bin/entrypoint.sh"]