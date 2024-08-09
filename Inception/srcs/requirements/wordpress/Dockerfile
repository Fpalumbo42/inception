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
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf

COPY conf/auto_config.sh /usr/local/bin/auto_config.sh
RUN chmod +x /usr/local/bin/auto_config.sh

RUN touch /var/www/wordpress/debug.log && \
    chmod 666 /var/www/wordpress/debug.log

RUN mkdir -p /run/php


ENTRYPOINT ["sh" , "/usr/local/bin/auto_config.sh"]

CMD ["/usr/sbin/php-fpm7.3", "-F"]
