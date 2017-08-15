#!/usr/bin/env bash
SCRIPT_DIR=$(dirname "$0")
DAYNAME=$(date +%a)
BACKUP_FILE_PATH=${SCRIPT_DIR}/backup/metabase.db.mv.db_${DAYNAME}
LOG_FILE=${SCRIPT_DIR}/log/backup.log

echo "[backup][$(date)] Backing up metabase to:${BACKUP_FILE_PATH}" >> ${LOG_FILE} 2>&1
cp ${SCRIPT_DIR}/metabase.db.mv.db ${BACKUP_FILE_PATH} >> ${LOG_FILE} 2>&1
echo "[backup][$(date)] Metabase backup complete" >> ${LOG_FILE} 2>&1 &