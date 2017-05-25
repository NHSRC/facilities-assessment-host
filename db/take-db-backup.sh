#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DAYNAME=$(date +%a)
pg_dump facility_assessment > ${SCRIPT_DIR}/backup/facilities_asessment_dump_${DAYNAME}.sql
pg_dump facility_assessment_cg > ${SCRIPT_DIR}/backup/facilities_asessment_cg_dump_${DAYNAME}.sql
pg_dump facility_assessment > ${SCRIPT_DIR}/backup/facilities_asessment_metabase_dump_${DAYNAME}.sql