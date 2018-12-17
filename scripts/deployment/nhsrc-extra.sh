#!/usr/bin/env bash
set -x

#~~~ RUN THIS SCRIPT AFTER SETTING UP EVERYTHING ELSE ~~~~#
THIS_DIR=$(readlink -f $(dirname "$0"))
SCRIPTS_DIR=$(dirname ${THIS_DIR})
PROJECT_DIR=$(dirname ${SCRIPTS_DIR})
START_METABASE=${PROJECT_DIR}/start-metabase.sh
USER=app
CRON_FILE=/var/spool/cron/crontabs/${USER}

echo "export http_proxy=http://10.31.37.253:3128
export https_proxy=${http_proxy}
export MB_JETTY_SSL=\"true\"
export MB_JETTY_SSL_Port=\"3000\"
export MB_JETTY_SSL_Keystore=\"keystore.jks\"
export MB_JETTY_SSL_Keystore_Password=\"password\"
export MB_JETTY_PORT=\"3001\"
make start_metabase_server" > ${START_METABASE}

sed -i "2s/^/http_proxy=http://10.31.37.253:3128\n
https_proxy=http://10.31.37.253:3128\n/" ${CRON_FILE}
