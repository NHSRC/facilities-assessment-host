#!/usr/bin/env bash
SCRIPT_DIR=$(dirname "$0")

DAYNAME=$(date +%a)
echo "[backup] Backing up postgres databases as ${SCRIPT_DIR}/backup with ${DAYNAME}" >> ${SCRIPT_DIR}/log/backup.log 2>&1 &

pg_dump new_facilitiess_assessment_mp > ${SCRIPT_DIR}/backup/new_facilitiess_assessment_mp_${DAYNAME}.sql
echo "[backup] Backed up new_facilitiess_assessment_mp $(date)" >> ${SCRIPT_DIR}/log/backup.log 2>&1 &

pg_dump facilities_assessment_cg > ${SCRIPT_DIR}/backup/facilities_assessment_cg_${DAYNAME}.sql
echo "[backup] Backed up facilities_assessment_cg $(date)" >> ${SCRIPT_DIR}/log/backup.log 2>&1 &
