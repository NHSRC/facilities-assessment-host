#!/usr/bin/env bash
SCRIPT_DIR=$(dirname "$0")
DAYNAME=$(date +%a)
BACKUP_FILE_PATH=${SCRIPT_DIR}/backup/facilities_assessment_cg_${DAYNAME}.sql
LOG_FILE=${SCRIPT_DIR}/log/backup.log

echo "[backup][$(date)] Backing up postgres databases at ${BACKUP_FILE_PATH}" >> ${LOG_FILE} 2>&1 &
pg_dump facilities_assessment_cg > ${BACKUP_FILE_PATH}
echo "[backup][$(date)] Postgres backup complete" >> ${LOG_FILE} 2>&1 &