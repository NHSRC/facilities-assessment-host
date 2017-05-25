#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#write out current crontab
crontab -l > dbbackupcron || true
#2am daily all dbs
echo "0 0 2 * * ? sh ${SCRIPT_DIR}/take-backup.sh" >> dbbackupcron
#3am every week entire cluster
#echo "0 0 3 1/7 * ? echo hello" >> dbbackupcron
#install new cron file
crontab dbbackupcron
rm dbbackupcron