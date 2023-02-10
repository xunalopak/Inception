#!/bin/bash

# logging functions
mysql_log() {
	local type="$1"; shift
	printf '%s [%s] [Entrypoint]: %s\n' "$(date --rfc-3339=seconds)" "$type" "$*"
}
mysql_note() {
	mysql_log Note "$@"
}
mysql_warn() {
	mysql_log Warn "$@" >&2
}
mysql_error() {
	mysql_log ERROR "$@" >&2
	exit 1
}


# arguments necessary to run "mysqld --verbose --help" successfully (used for testing configuration validity and for extracting default/configured values)
_verboseHelpArgs=(
	--verbose --help
	--log-bin-index="$(mktemp -u)" # https://github.com/docker-library/mysql/issues/136
)

mysql_check_config() {
	local toRun=( "$@" "${_verboseHelpArgs[@]}" ) errors
	if ! errors="$("${toRun[@]}" 2>&1 >/dev/null)"; then
		mysql_error $'mysqld failed while attempting to check config\n\tcommand was: '"${toRun[*]}"$'\n\t'"$errors"
	fi
}

# Fetch value from server config
# We use mysqld --verbose --help instead of my_print_defaults because the
# latter only show values present in config files, and not server defaults
mysql_get_config() {
	local conf="$1"; shift
	"$@" "${_verboseHelpArgs[@]}" 2>/dev/null \
		| awk -v conf="$conf" '$1 == conf && /^[^ \t]/ { sub(/^[^ \t]+[ \t]+/, ""); print; exit }'
	# match "datadir      /some/path with/spaces in/it here" but not "--xyz=abc\n     datadir (xyz)"
}

# Loads various settings that are used elsewhere in the script
# This should be called after mysql_check_config, but before any other functions
docker_setup_env() {
	# Get config
	declare -g DATADIR SOCKET
	DATADIR="$(mysql_get_config 'datadir' "$@")"
	SOCKET="$(mysql_get_config 'socket' "$@")"

	declare -g DATABASE_ALREADY_EXISTS
	if [ -d "$DATADIR/mysql" ]; then
		DATABASE_ALREADY_EXISTS='true'
	fi
}

# Initializes database with timezone info and root password, plus optional extra db/user
docker_setup_db() {
	mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
	service mysql start

	SECURE_MYSQL=$(expect -c "
set timeout 2
spawn mysql_secure_installation
expect \"Enter current password for root (enter for none):\"
send \"\r\"
expect \"Change the root password?\"
send \"y\r\"
expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Remove anonymous users?\"
send \"y\r\"
expect \"Disallow root login remotely?\"
send \"n\r\"
expect \"Remove test database and access to it?\"
send \"y\r\"
expect \"Reload privilege tables now?\"
send \"y\r\"
expect eof
")

	echo "$SECURE_MYSQL"

	echo
	echo "Create database and 2 user"
	echo
	readonly MYSQL=`which mysql`

	# Construct the MySQL query
	readonly Q1="CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;"
	readonly Q2="GRANT ALL ON *.* TO '$MYSQL_ADMIN_USER'@'%' IDENTIFIED BY '$MYSQL_ADMIN_PASSWORD';"
	readonly Q3="CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY 'MYSQL_PASSWORD';"
	readonly Q4="FLUSH PRIVILEGES;"
	readonly SQL="${Q1}${Q2}${Q3}${Q4}"

	# Run the actual command
	$MYSQL -uroot -p$MYSQL_ROOT_PASSWORD -e "$SQL"
}

_main() {
	mysql_check_config "$@"
	# Load various environment variables
	docker_setup_env "$@"
	# docker_create_db_directories

	# there's no database, so it needs to be initialized
	if [ -z "$DATABASE_ALREADY_EXISTS" ]; then
		echo "Database does not exist yet !"

		docker_setup_db
		echo
		mysql_note "MariaDB init process done. Ready for start up."
		echo
	fi

	cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    _main "$@"
fi
