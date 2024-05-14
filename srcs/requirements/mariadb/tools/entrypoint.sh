#!/bin/bash
#exit script immediately if a command exits with a non-zero status
set -e

# Create the directory for the MariaDB socket file
mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

# setup mysql server settings
cat << EOF > /etc/mysql/my.cnf
[mysqld]
bind-address = 0.0.0.0
user = root
port = 3306
EOF

# Start the MariaDB server (background (&))
mysqld &

# Wait for the MariaDB server to start
until mysqladmin ping >/dev/null 2>&1; do
    echo -e "\e[1;32mWaiting for MariaDB Admin Service to start!\e[0m"
    sleep 1
done

# Get the database name, admin and user from the secrets
DB_NAME=$(grep DB_NAME /run/secrets/credentials | cut -d '=' -f2)
DB_ADMIN=$(grep DB_ADMIN /run/secrets/credentials | cut -d '=' -f2)
DB_USER=$(grep DB_USER /run/secrets/credentials | cut -d '=' -f2)
DB_ADMIN_PASSWORD=$(cat /run/secrets/db_root_password)
DB_USER_PASSWORD=$(cat /run/secrets/db_password)

# Secure MariaDB installation prod style
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

echo -e "\e[1;32mSetting up the database and user for WordPress...\e[0m"

mysql -u"root" -p"$DB_ADMIN_PASSWORD" << EOF
    CREATE DATABASE IF NOT EXISTS $DB_NAME ;
    CREATE USER IF NOT EXISTS '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_ADMIN_PASSWORD' ;
    GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN'@'%' WITH GRANT OPTION ;
    FLUSH PRIVILEGES;
    CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD' ;
    GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION ;
    FLUSH PRIVILEGES;
EOF

mysqladmin shutdown

echo -e "\e[1;32mDone with mariadb setup!\e[0m"

# Restart the server again without backgrounding -> PID 1
exec mysqld