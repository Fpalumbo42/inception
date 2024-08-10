#!/bin/sh

sleep 10

: "${SQL_DATABASE:?Variable not set or empty}"
: "${SQL_USER:?Variable not set or empty}"
: "${SQL_PASSWORD:?Variable not set or empty}"

if [ ! -e /var/www/wordpress/wp-config.php ]; then

cat << EOF > /var/www/wordpress/wp-config.php
<?php
define( 'DB_NAME', '${SQL_DATABASE}' );
define( 'DB_USER', '${SQL_USER}' );
define( 'DB_PASSWORD', '${SQL_PASSWORD}' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('FS_METHOD','direct');
\$table_prefix = 'wp_';
define( 'WP_DEBUG', true ); // Or false
if ( WP_DEBUG ) {
 define( 'WP_DEBUG_LOG', true );
 define( 'WP_DEBUG_DISPLAY', false );
 @ini_set( 'display_errors', 0 );
}
define('CONCATENATE_SCRIPTS', false);
define('FORCE_SSL_LOGIN', true);
define('FORCE_SSL_ADMIN', true);
define( 'SCRIPT_DEBUG', true );
if ( ! defined( 'ABSPATH' ) ) {
define( 'ABSPATH', __DIR__ . '/' );}
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );
require_once ABSPATH . 'wp-settings.php';
EOF

sleep 2
wp core install     --url=$DOMAIN_NAME --title=$SITE_TITLE --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root --path='/var/www/wordpress'
wp user create      --allow-root --role=author $USER1_LOGIN $USER1_MAIL --user_pass=$USER1_PASS --path='/var/www/wordpress' >> /log.txt

fi

if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "wp-config.php has been created or overwritten successfully."
else
    echo "Failed to create wp-config.php."
    exit 1
fi

exec "$@"
