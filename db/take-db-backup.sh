#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "SCRIPT_DIR ${SCRIPT_DIR}"

DAYNAME=$(date +%a)
echo "[backup] Backing up postgres databases $(date)" >> ${SCRIPT_DIR}/log/backup.log 2>&1 &
pg_dump facilities_assessment > ${SCRIPT_DIR}/backup/facilities_asessment_dump_${DAYNAME}.sql >> ${SCRIPT_DIR}/log/backup.log 2>&1 &
pg_dump facilities_assessment_cg > ${SCRIPT_DIR}/backup/facilities_asessment_cg_dump_${DAYNAME}.sql >> ${SCRIPT_DIR}/log/backup.log 2>&1 &