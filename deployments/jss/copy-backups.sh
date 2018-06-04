#!/usr/bin/env bash
DAYNAME=$(date +%a)
scp /home/nhsrc/facilities-assessment-host/db/backup/facilities_assessment_cg_${DAYNAME}.sql bahmni_support@192.168.0.157:/home/bahmni_support/igunatmacbackup/
scp /home/nhsrc/facilities-assessment-host/metabase/metabase.db.mv.db bahmni_support@192.168.0.157:/home/bahmni_support/igunatmacbackup/metabase.db.mv.db_${DAYNAME}

SCRIPT_DIR=$(dirname "$0")
LOG_FILE=${SCRIPT_DIR}/log/backup.log

echo "[backup][$(date)] Backedup postgres databases at 157" >> ${LOG_FILE} 2>&1 &
