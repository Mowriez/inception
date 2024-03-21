#!/bin/bash

envsubst < .env > /etc/mysql/conf.d/mariadb-env.cnf

# Start MariaDB server
exec mysqld --user=mysql --console