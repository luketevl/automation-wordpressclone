#!/bin/sh
# Creating new wordpress
CLIENTS_NAMES=$1
TARGET="lpmodelo"
for client in $CLIENTS_NAMES
do
	URL="$2"${client}
	if [ -d "../../${client}" ]; then
	echo "Já existe esse cliente"
	fi
	cp -rp  "../../${TARGET}" "../../${client}"
	rm  "../../${client}/wp-config.php"
	cp  "../../${TARGET}/wp-config-model.php" "../../${client}/wp-config.php"
	sed -i -e 's/usedbname/wp-${client}/g' "../../${client}/wp-config.php"
	DBPASS = ` wp config get --allow-root --constant=DB_PASSWORD --path="../../${client}/"`
	echo "${DBPASS}"
	DBUSER = ` wp config get --allow-root --constant=DB_USER --path=../../${client}/`
	echo "${DBUSER}"
	DBHOST = ` wp config get --allow-root --constant=DB_HOST --path=../../${client}/`
	echo "${DBHOST}"
	DBNAME = ` wp config get --allow-root --constant=DB_NAME --path=../../${client}/`
	echo "${DBNAME}"

	mysql -u "${DBUSER}" -h "${DBNAME}" -p${DBPASS} -e "create database ${DBNAME};"
	mysqldump -u "${DBUSER}" -p${DBPASS} -h ${DBHOST} --compress --single-transaction wp-lpmodelo | mysql --host=${DBHOST} -f --user=${DBUSER} --password=${DBPASS} ${DBNAME}
	 wp db query --allow-root "update wp-config set option_value = '${URL}' where option_name = 'siteurl' or option_name = 'home'"
done