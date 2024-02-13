# Use the penultimate version of Debian
FROM debian:latest

# Update package lists and install Nginx + OpenSSL
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 443

# Copy script into container environment
# COPY ./scripts/setup.sh /

# run script after container is launched
CMD ["nginx", "-g", "daemon off;"]