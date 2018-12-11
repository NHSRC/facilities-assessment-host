#!/usr/bin/env bash
set -e

PROJECT_DIR=$(dirname $(readlink -f $(dirname "$0")))
LOG_FILE=${PROJECT_DIR}/log/backup.log

if [[ -z "${IMPLEMENTATION_NAME}" ]]; then
echo "env var \$IMPLEMENTATION_NAME is unset" | tee -a ${LOG_FILE} ; exit 1;
fi

BACKUP_DIR=${PROJECT_DIR}/backup
METABASE_DIR=${PROJECT_DIR}/metabase
BACKUP_FILE=${BACKUP_DIR}/facilities_assessment_$(date +%a).sql
BACKUP_FILE_YDAY=${BACKUP_DIR}/facilities_assessment_$(date --date="yesterday" +%a).sql
METABASE_SOURCE_FILE=${METABASE_DIR}/metabase.db.mv.db
METABASE_BACKUP_FILE=${BACKUP_DIR}/metabase.db.mv.db_$(date +%a)
S3_PATH=s3://samanvay/client-backups/${IMPLEMENTATION_NAME}

echo "[$(date)] Backing up postgres databases to '${BACKUP_FILE}' ..." &>> ${LOG_FILE}
pg_dump -Unhsrc -hlocalhost -d facilities_assessment_cg > ${BACKUP_FILE}
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
if [[ ${FILE_SIZE} == 0 || (-e ${BACKUP_FILE_YDAY} && ${FILE_SIZE} < $(stat --printf="%s" ${BACKUP_FILE_YDAY})) ]];
then
    echo "[$(date)] Backed up file's size ${FILE_SIZE} less than previous day" &>> ${LOG_FILE} ;
    exit 1;
else
    echo "[$(date)] File size ${FILE_SIZE} okay" &>> ${LOG_FILE}
fi
