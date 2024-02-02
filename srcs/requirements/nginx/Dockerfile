FROM debian:oldstable

# Update the package repository and install required package, after that delete the package list from the images to reduce image size.
# All commands in one run instruction to reduce image layers
RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Generate a self-signed SSL certificate (for testing purposes)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=GER/CN=localhost"

# Configure Nginx to use TLSv1.3 and the self-signed certificate
RUN sed -i '/ssl_protocols/c\    ssl_protocols TLSv1.3;' /etc/nginx/nginx.conf \
    && sed -i '/listen 80/a \    listen 443 ssl;' /etc/nginx/nginx.conf \
    && sed -i '/server_name _;/a \    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;\n    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;' /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80
EXPOSE 443

# CMD instruction to start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]