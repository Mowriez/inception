#!/bin/bash
#exit script immediately if a command exits with a non-zero status
set -e

# Start the MariaDB server (daemon (d) in background (&))
mysqld &

# Wait for the MariaDB server to start
until mysqladmin ping >/dev/null 2>&1; do
  echo "Waiting for MariaDB to start..."
  sleep 1
done

# Secure the MariaDB installation
mysql_secure_installation << EOF
Y
Y
password
password
Y
Y
Y
Y
EOF

# Create a database and user for WordPress
mysql -u"test" -p"password" << EOF
	CREATE DATABASE IF NOT EXISTS wordpress ;
	CREATE USER IF NOT EXISTS 'user'@'%' IDENTIFIED BY 'user' ;
	GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'%' WITH GRANT OPTION;
	FLUSH PRIVILEGES;
EOF

# Create admin user 
# -e flag tells mysql command to execute the following string 
# as SQL command. Without it, it's interpreted as a database name
# mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'password';"
# mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;"

# # Create normal user
# mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
# mysql -e "CREATE USER 'wordpress'@'%' IDENTIFIED BY 'password';"
# mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';"

# Shutdown the MariaDB server
mysqladmin shutdown

# Start the MariaDB server again without backgrounding - PID 1
exec mysqld