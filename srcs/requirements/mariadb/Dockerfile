FROM debian:buster

EXPOSE 3306

ARG DB_NAME
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

RUN apt-get update -y && apt-get install -y mariadb-server

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld 

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN	echo "CREATE DATABASE IF NOT EXISTS ${DB_NAME}; \
	CREATE USER ${MYSQL_USER}@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
	GRANT ALL ON ${DB_NAME}.* TO rchampli@'%'; \
	FLUSH PRIVILEGES; \
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" > db.sql
RUN	service mysql start && mysql < db.sql

CMD ["/usr/bin/mysqld_safe"]