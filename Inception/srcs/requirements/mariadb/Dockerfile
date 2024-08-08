FROM debian:buster

RUN apt update -y && \
    apt upgrade -y && \
    apt-get install -y mariadb-server procps

RUN chown -R mysql:mysql /var/lib/mysql
RUN chmod 700 /var/lib/mysql

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/config.sh /config.sh

RUN chmod +x /config.sh

EXPOSE 3306

CMD ["sh", "/config.sh"]
