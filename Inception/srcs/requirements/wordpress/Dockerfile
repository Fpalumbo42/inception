FROM debian:buster

# Mettre à jour et installer les paquets nécessaires
RUN apt update -y && \
    apt upgrade -y && \
    apt-get install wget -y && \
    apt-get install -y php7.3 php7.3-fpm php7.3-mysql mariadb-client

# Installer WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
    tar -xzf /var/www/wordpress-6.0-fr_FR.tar.gz -C /var/www && \
    rm /var/www/wordpress-6.0-fr_FR.tar.gz && \
    chown -R www-data:www-data /var/www/wordpress && \
    find /var/www/wordpress -type d -exec chmod 755 {} \; && \
    find /var/www/wordpress -type f -exec chmod 644 {} \;

# Copier la configuration PHP
COPY ./conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf

# Variables d'environnement pour la base de données
ENV DB_NAME=wordpress
ENV DB_ROOT=rootpass
ENV DB_USER=wpuser

# Installer WP-CLI

# Copier le script de configuration automatique
COPY conf/auto_config.sh /auto_config.sh
RUN chmod +x /auto_config.sh

RUN sh /auto_config.sh
# Créer et définir les permissions pour le fichier de debug
RUN touch /var/www/wordpress/debug.log && \
    chmod 666 /var/www/wordpress/debug.log

# Créer le répertoire /run/php
RUN mkdir -p /run/php

# Démarrer PHP-FPM
CMD ["/usr/sbin/php-fpm7.3", "-F"]
