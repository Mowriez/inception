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

DB_ADMIN=$(grep DB_ADMIN /run/secrets/credentials_file | cut -d '=' -f2)
DB_ADMIN_PASSWORD=$(cat /run/secrets/db_root_password_file)
DB_USER=$(grep DB_USER /run/secrets/credentials_file | cut -d '=' -f2)
DB_USER_PASSWORD=$(cat /run/secrets/db_password_file)
DB_NAME=$(grep DB_NAME /run/secrets/credentials_file | cut -d '=' -f2)

# Secure the MariaDB installation prod style
mysql_secure_installation << EOF
Y
Y
$DB_ADMIN_PASSWORD
$DB_ADMIN_PASSWORD
Y
Y
Y
Y
EOF

# Create a database and user for WordPress
mysql -u"root" -p"$DB_ADMIN_PASSWORD" << EOF
	CREATE DATABASE IF NOT EXISTS $DB_NAME ;
    CREATE USER IF NOT EXISTS '$DB_ADMIN'@'localhost' IDENTIFIED BY '$DB_ADMIN_PASSWORD' ;
    GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN'@'localhost' WITH GRANT OPTION ;
    FLUSH PRIVILEGES;
	CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD' ;
	GRANT ALL PRIVILEGES ON wordpress.* TO '$DB_USER'@'%' WITH GRANT OPTION ;
	FLUSH PRIVILEGES;
EOF

mysqladmin shutdown

# Restart the server again without backgrounding -> PID 1
exec mysqld