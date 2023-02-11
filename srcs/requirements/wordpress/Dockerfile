FROM debian:buster

EXPOSE 9000

RUN mkdir /var/www/
RUN mkdir -p /var/run/ && mkdir /run/php

RUN apt-get update -y && apt-get install -y php7.3 php-mysqli php-fpm wget mariadb-client

RUN cd /var/www/ && wget http://fr.wordpress.org/latest-fr_FR.tar.gz && \
	tar -xzvf latest-fr_FR.tar.gz && rm latest-fr_FR.tar.gz
RUN mv /var/www/wordpress/ /var/www/html

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/
RUN	chown -R www-data:www-data /var/www/html
RUN chmod -R -wx,u+rwX,g+rX,o+rX /var/www/html

COPY ./conf/wp-config.php ./wp-config.php

CMD [ "/usr/sbin/php-fpm7.3", "-F" ]