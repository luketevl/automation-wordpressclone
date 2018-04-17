#!/bin/sh
# Creating new wordpress
TARGET="lpmodelo"
for client in ../../lps/*/
do
        CLIENT= ${client}
        dir=${client%*/}
        sed -i -e "s/usedbname/wp${client}/g" "${client%*/}/wp-config.php"
        DBPASS=$(wp config get --allow-root --constant=DB_PASSWORD --path=${client%*/}/)
        echo ${DBPASS}
        DBUSER=$(wp config get --allow-root --constant=DB_USER --path=${client%*/}/)
        echo ${DBUSER}
        DBHOST=$(wp config get --allow-root --constant=DB_HOST --path=${client%*/}/)
        echo ${DBHOST}
        DBNAME=$(wp config get --allow-root --constant=DB_NAME --path=${client%*/}/)
        echo ${DBNAME}

        # mysql --host=${DBHOST} -f --user=${DBUSER} --password=${DBPASS} ${DBNAME}

        wp option update woocommerce_pagarme-banking-ticket_settings '' --allow-root --path=${client%*/}
        wp option update woocommerce_pagarme-credit-card_settings '' --allow-root --path=${client%*/}
        
done
