#!/bin/sh

#if [ -f .env ]; then
#    export $(grep -v '^#' .env | xargs)
#else
#    echo ".env file not found!"
#    exit 1
#fi

# Vérifier que toutes les variables nécessaires sont définies
#: "${SQL_ROOT_PASSWORD:?Variable not set or empty}"
#: "${SQL_NAME:?Variable not set or empty}"
#: "${SQL_USER:?Variable not set or empty}"
#: "${SQL_PASSWORD:?Variable not set or empty}"

service mysql start;
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e -p$SQL_ROOT_PASSWORD "FLUSH PRIVILEGES ;"
mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown
exec mysqld_safe