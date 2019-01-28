USER=app
PROJECT_DIR=$(dirname $(readlink -f $(dirname "$0")))
APP_DIR=${PROJECT_DIR}/app-servers
METABASE_DIR=${PROJECT_DIR}/metabase
P12_NAME='keystore'
JKS_NAME=${P12_NAME}
CERTBOT_OUTPUT=/tmp/crt.txt

setup() {
    systemctl stop ${ENV_PREFIX}-fab

    openssl pkcs12 -export -out ${APP_DIR}/${P12_NAME}.p12 \
        -passin pass:${PASSWORD} -passout pass:${PASSWORD} \
        -in /etc/letsencrypt/live/${FQDN}/fullchain.pem \
        -inkey /etc/letsencrypt/live/${FQDN}/privkey.pem \
        -name tomcat

    keytool -importkeystore -deststorepass ${PASSWORD} -destkeypass ${PASSWORD} \
        -destkeystore ${METABASE_DIR}/${JKS_NAME}.jks \
        -srckeystore ${APP_DIR}/${P12_NAME}.p12 \
        -srcstoretype PKCS12 \
        -srcstorepass ${PASSWORD} -alias tomcat

    chown ${USER}:${USER} ${APP_DIR}/${P12_NAME}.p12
    chown ${USER}:${USER} ${METABASE_DIR}/${JKS_NAME}.jks

    systemctl start ${ENV_PREFIX}-fab
    systemctl restart ${ENV_PREFIX}-metabase
}

read -p "Enter fully qualified domain name: " FQDN
read -p "keystore password: " PASSWORD
read -p "environment name, ignore if production: " ENV_PREFIX
setup