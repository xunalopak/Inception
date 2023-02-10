FROM debian:buster

MAINTAINER mathmart <mathmart@student.42lyon.fr>

RUN apt-get update -y
RUN apt-get install -y mariadb-server expect

COPY tools/docker-entrypoint.sh /usr/local/bin/
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
	rm -rf /var/lib/mysql

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
