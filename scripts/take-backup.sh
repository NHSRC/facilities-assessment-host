#!/usr/bin/env bash
set -e

PROJECT_DIR=$(dirname $(readlink -f $(dirname "$0")))
BACKUP_DIR=${PROJECT_DIR}/backup
METABASE_DIR=${PROJECT_DIR}/metabase
BACKUP_FILE=${BACKUP_DIR}/facilities_assessment_$(date +%a).sql
METABASE_BACKUP_FILE=${BACKUP_DIR}/metabase.db.mv.db_$(date +%a).sql
BACKUP_FILE_YDAY=${BACKUP_DIR}/facilities_assessment_$(date --date="yesterday" +%a).sql
LOG_FILE=${PROJECT_DIR}/log/backup.log
S3_PATH=s3://samanvay/client-backups/${IMPLEMENTATION_NAME}

echo "[$(date)] Backing up postgres databases to '${BACKUP_FILE}' ..." >> ${LOG_FILE} 2>&1
pg_dump facilities_assessment_cg > ${BACKUP_FILE}
echo "[$(date)] Postgres backup complete" >> ${LOG_FILE} 2>&1

echo "[backup][$(date)] Backing up metabase to ${METABASE_BACKUP_FILE}" >> ${LOG_FILE} 2>&1
cp ${METABASE_DIR}/metabase.db.mv.db ${METABASE_BACKUP_FILE} >> ${LOG_FILE} 2>&1
echo "[backup][$(date)] Metabase backup complete" >> ${LOG_FILE} 2>&1 &

echo "[$(date)] Syncing to S3 ..." >> ${LOG_FILE} 2>&1
aws s3 sync ${BACKUP_DIR} ${S3_PATH} >> ${LOG_FILE} 2>&1
echo "[$(date)] Sync done!" >> ${LOG_FILE} 2>&1

echo "[$(date)] Verifying postgres dump size..." >> ${LOG_FILE} 2>&1
FILE_SIZE=$(stat --printf="%s" ${BACKUP_FILE})
if [[ ${FILE_SIZE} == 0 || (-e ${BACKUP_FILE_YDAY} && ${FILE_SIZE} < $(stat --printf="%s" ${BACKUP_FILE_YDAY})) ]];
then
    echo "[$(date)] Backed up file's size ${FILE_SIZE} less than previous day" >> ${LOG_FILE} 2>&1;
    exit 1;
else
    echo "[$(date)] File size ${FILE_SIZE} okay" >> ${LOG_FILE} 2>&1
fi
