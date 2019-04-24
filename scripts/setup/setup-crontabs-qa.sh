#!/usr/bin/env bash

if [[ $(id -u) -ne 0 ]] ; then echo "root/sudo privileges required" ; exit 1 ; fi

USER=app
TMP_CRON_FILE=/tmp/fab-cron
THIS_DIR=$(readlink -f $(dirname "$0"))
SCRIPTS_DIR=$(dirname ${THIS_DIR})
#PROJECT_DIR=$(dirname ${SCRIPTS_DIR})

read -p "Enable LetsEncrypt auto renewal (y/n)? " ENABLE_AUTO_RENEW

echo "PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
LD_LIBRARY_PATH=/usr/local/lib

if [ "${ENABLE_AUTO_RENEW,,}" = "y" ]; then
    read -p "Enter fully qualified domain name: " FQDN
    read -p "keystore password: " PASSWORD
    read -p "HEALTHCHECK_LETSENCRYPT_UUID = " HEALTHCHECK_LETSENCRYPT_UUID
    ENV_PREFIX=
    read -p "QA env? (y/n): " IS_QA
    if [ "${IS_QA,,}" = "y" ]; then ENV_PREFIX="qa-"; fi

    echo "Configure aws for 'root'..."
    TMP_RENEWAL_CRON=/tmp/fab-lenc-cron

    # LetsEncrypt renewal job will be in root's crontab
    crontab -l > ${TMP_RENEWAL_CRON}

    echo "FQDN=${FQDN}" >> ${TMP_RENEWAL_CRON}
    echo "PASSWORD=${PASSWORD}" >> ${TMP_RENEWAL_CRON}
    if [ "${IS_QA,,}" = "y" ]; then echo "ENV_PREFIX=\"qa-\"" >> ${TMP_RENEWAL_CRON}; fi

    echo "0 3 1,15 * * ${SCRIPTS_DIR}/renew-letsencrypt.sh && curl --retry 3 https://hc-ping.com/${HEALTHCHECK_LETSENCRYPT_UUID}" >> ${TMP_RENEWAL_CRON}

    crontab < ${TMP_RENEWAL_CRON}
fi

su ${USER} -c "crontab < ${TMP_CRON_FILE}"

systemctl reload-or-restart cron || (echo "Trying crond instead..." && systemctl reload-or-restart crond && echo "Restarted crond")
