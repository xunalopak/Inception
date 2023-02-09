#!/bin/sh
# CURRENTLY UNUSED

if [ -f /var/www/html/wp-config.php ]
then
	echo "Wordpress is already installed";
else
	sed -i "s/votre_utilisateur_de_bdd/$MYSQL_USER/g" wp-config.php
	sed -i "s/votre_mdp_de_bdd/$MYSQL_PASSWORD/g" wp-config.php
	sed -i "s/localhost/mariadb/g" wp-config.php
	sed -i "s/votre_nom_de_bdd/$DB_NAME/g" wp-config.php
	mv wp-config.php /var/www/html/wp-config.php
fi
