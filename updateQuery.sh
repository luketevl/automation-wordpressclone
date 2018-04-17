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

        wp option update woocommerce_pagarme-banking-ticket_settings 'a:9:{s:7:"enabled";s:3:"yes";s:5:"title";s:16:"Boleto bancário";s:11:"description";s:26:"Pagar com boleto bancário";s:11:"integration";s:0:"";s:7:"api_key";s:38:"ak_live_X4az5TCYPUJVIOwR5FpxjrISqmMca6";s:14:"encryption_key";s:38:"ek_live_Lbi0uLYOniZmp96clcjcmks6soK2hD";s:5:"async";s:2:"no";s:7:"testing";s:0:"";s:5:"debug";s:2:"no";}' --allow-root --path=${client%*/}
        wp option update woocommerce_pagarme-credit-card_settings 'a:14:{s:7:"enabled";s:3:"yes";s:5:"title";s:19:"Cartão de crédito";s:11:"description";s:29:"Pagar com cartão de crédito";s:11:"integration";s:0:"";s:7:"api_key";s:38:"ak_live_X4az5TCYPUJVIOwR5FpxjrISqmMca6";s:14:"encryption_key";s:38:"ek_live_Lbi0uLYOniZmp96clcjcmks6soK2hD";s:8:"checkout";s:2:"no";s:12:"installments";s:0:"";s:15:"max_installment";s:2:"12";s:20:"smallest_installment";s:2:"10";s:13:"interest_rate";s:1:"1";s:17:"free_installments";s:1:"3";s:7:"testing";s:0:"";s:5:"debug";s:2:"no";}' --allow-root --path=${client%*/}
        
done