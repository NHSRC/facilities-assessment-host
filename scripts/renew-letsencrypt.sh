#!/usr/bin/env bash

if [[ $(id -u) -ne 0 ]] ; then echo "root/sudo privileges required" ; exit 1 ; fi
if [[ -z "${FQDN}" ]]; then echo "env var \$FQDN is not set" ; exit 1; fi
if [[ -z "${PASSWORD}" ]]; then echo "env var \$PASSWORD (keystore) is not set" ; exit 1; fi
if [[ -z "${ENV_PREFIX}" ]]; then echo "env var \$ENV_PREVIX (keystore) is not set" ; exit 1; fi

USER=app
PROJECT_DIR=$(dirname $(readlink -f $(dirname "$0")))
APP_DIR=${PROJECT_DIR}/app-servers
METABASE_DIR=${PROJECT_DIR}/metabase
P12_NAME='keystore'
JKS_NAME=${P12_NAME}
CERTBOT_OUTPUT=/tmp/crt.txt
LOG_FILE=/tmp/renew-le.log
PATH=$PATH:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/jdk1.8.0_192/bin:/opt/jdk1.8.0_192/jre/bin

echo "env var PROJECT_DIR set to ${PROJECT_DIR}"

# expecting ENV_PREFIX to come from the environment. If unset, prod will be assumed
echo "Stopping ${ENV_PREFIX}fab"
systemctl stop ${ENV_PREFIX}fab

certbot renew &> ${CERTBOT_OUTPUT}

grep -q "Cert not yet due for renewal" ${CERTBOT_OUTPUT}

if [ $? -eq 0 ]; then systemctl start ${ENV_PREFIX}fab && exit 0; fi

openssl pkcs12 -export -out ${APP_DIR}/${P12_NAME}.p12 \
-passin pass:${PASSWORD} -passout pass:${PASSWORD} \
-in /etc/letsencrypt/live/${FQDN}/fullchain.pem \
-inkey /etc/letsencrypt/live/${FQDN}/privkey.pem \
-name tomcat &>> ${LOG_FILE}

keytool -importkeystore -deststorepass ${PASSWORD} -destkeypass ${PASSWORD} \
-destkeystore ${METABASE_DIR}/${JKS_NAME}.jks \
-srckeystore ${APP_DIR}/${P12_NAME}.p12 \
-srcstoretype PKCS12 \
-srcstorepass ${PASSWORD} -alias "tomcat" -noprompt &>> ${LOG_FILE}

chown ${USER}:${USER} ${APP_DIR}/${P12_NAME}.p12
chown ${USER}:${USER} ${METABASE_DIR}/${JKS_NAME}.jks

systemctl start ${ENV_PREFIX}fab &>> ${LOG_FILE}
systemctl restart ${ENV_PREFIX}metabase &>> ${LOG_FILE}

# Tell LetsEncrypt that Certificate has been renewed so that it would not send email notification to us
aws ses send-email --from backupper@samanvayfoundation.org \
--to cron-alerts@samanvayfoundation.org \
--subject "LetsEncrypt Auto Renewal for ${FQDN}" \
--text "$(cat ${LOG_FILE})" \
--region us-east-1 &>> ${LOG_FILE}
