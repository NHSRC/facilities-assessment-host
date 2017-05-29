#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DAYNAME=$(date +%a)

echo "[backup] Backing up metabase $(date)" >> ${SCRIPT_DIR}/log/backup.log 2>&1 &
cp ${SCRIPT_DIR}/metabase.db.mv.db ${SCRIPT_DIR}/backup/metabase.db.mv.db_DAYNAME >> ${SCRIPT_DIR}/log/backup.log 2>&1 &