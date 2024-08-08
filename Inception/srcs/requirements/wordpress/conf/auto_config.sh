#!/bin/sh

# Vérifier que toutes les variables nécessaires sont définies
: "${SQL_DATABASE:?Variable not set or empty}"
: "${SQL_USER:?Variable not set or empty}"
: "${SQL_PASSWORD:?Variable not set or empty}"

# Créer ou écraser le fichier wp-config.php avec le contenu fourni
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

# Vérifier si le fichier a été créé correctement
if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "wp-config.php has been created or overwritten successfully."
else
    echo "Failed to create wp-config.php."
    exit 1
fi

# Exécuter le processus principal du conteneur
exec "$@"
