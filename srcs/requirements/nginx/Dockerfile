# Use the penultimate version of Debian
FROM debian:oldstable

# Update package lists and install Nginx + OpenSSL
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get install openssl -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY ./scripts/setup.sh /

# Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]