#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DAYNAME=$(date +%a)

cp ${SCRIPT_DIR}/metabase.db.mv.db ${SCRIPT_DIR}/backup/metabase.db.mv.db_DAYNAME