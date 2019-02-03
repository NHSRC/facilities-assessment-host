#!/usr/bin/env bash
set -e

PROJECT_DIR=$(dirname $(readlink -f $(dirname "$0")))
BACKUP_DIR=${PROJECT_DIR}/backup
METABASE_DIR=${PROJECT_DIR}/metabase
LOG_FILE=${BACKUP_DIR}/log/backup_$(date +%a).log

echo "" > ${LOG_FILE}

if [[ -z "${S3_BACKUP_DIRNAME}" ]]; then
echo "env var \$S3_BACKUP_DIRNAME is unset" | tee -a ${LOG_FILE} ; exit 1;
fi

BACKUP_FILE=${BACKUP_DIR}/facilities_assessment_$(date +%a).sql
BACKUP_FILE_YDAY=${BACKUP_DIR}/facilities_assessment_$(date --date="yesterday" +%a).sql
METABASE_SOURCE_FILE=${METABASE_DIR}/metabase.db.mv.db
METABASE_BACKUP_FILE=${BACKUP_DIR}/metabase.db.mv.db_$(date +%a)
S3_PATH=s3://samanvay/client-backups/${S3_BACKUP_DIRNAME}

echo "[$(date)] Backing up postgres databases to '${BACKUP_FILE}' ..." &>> ${LOG_FILE}
pg_dump -Unhsrc -hlocalhost facilities_assessment > ${BACKUP_FILE}
echo "[$(date)] Postgres backup complete" &>> ${LOG_FILE}

echo "[$(date)] Backing up metabase to ${METABASE_BACKUP_FILE}" &>> ${LOG_FILE}
if [[ -e ${METABASE_SOURCE_FILE} ]]; then
    cp ${METABASE_SOURCE_FILE} ${METABASE_BACKUP_FILE};
    echo "[$(date)] Metabase backup complete" &>> ${LOG_FILE};
else
    echo "[$(date)] ${METABASE_SOURCE_FILE} does not exist" &>> ${LOG_FILE};
fi

echo "[$(date)] Syncing to S3 ..." &>> ${LOG_FILE}
aws s3 sync --no-progress ${BACKUP_DIR} ${S3_PATH} &>> ${LOG_FILE}
echo "[$(date)] Sync done!" &>> ${LOG_FILE}

echo "[$(date)] Verifying postgres dump size..." &>> ${LOG_FILE}
FILE_SIZE=$(stat --printf="%s" ${BACKUP_FILE})
YDAY_FILE_SIZE=$(stat --printf="%s" ${BACKUP_FILE_YDAY})
DIFF=$(expr ${YDAY_FILE_SIZE} - ${FILE_SIZE})
MAX_DIFF=2000000 #2mb
if [[ ${FILE_SIZE} == 0 || -e ${BACKUP_FILE_YDAY} &&  "$DIFF" -gt "$MAX_DIFF" ]];
then
    echo "[$(date)] Backed up file's size ${FILE_SIZE} less than previous day ${YDAY_FILE_SIZE}" &>> ${LOG_FILE} ;
    exit 1;
else
    echo "[$(date)] File size ${FILE_SIZE} okay" &>> ${LOG_FILE}
fi
