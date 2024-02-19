# Use the penultimate version of Debian
FROM debian:11

# Update package lists and install Nginx + OpenSSL
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 443

#Copy files into container environment
COPY ./config/nginx.conf /etc/nginx/conf.d
COPY ./utils/default.css /usr/share/nginx/html
COPY ./utils/mtrautne.html /usr/share/nginx/html

# run script after container is launched
CMD ["nginx", "-g", "daemon off;"]