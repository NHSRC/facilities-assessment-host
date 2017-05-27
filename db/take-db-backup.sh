#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo 'SCRIPT_DIR'
echo ${SCRIPT_DIR}

DAYNAME=$(date +%a)
pg_dump facilities_assessment > ${SCRIPT_DIR}/backup/facilities_asessment_dump_${DAYNAME}.sql
pg_dump facilities_assessment_cg > ${SCRIPT_DIR}/backup/facilities_asessment_cg_dump_${DAYNAME}.sql
pg_dump facilities_assessment > ${SCRIPT_DIR}/backup/facilities_asessment_metabase_dump_${DAYNAME}.sql