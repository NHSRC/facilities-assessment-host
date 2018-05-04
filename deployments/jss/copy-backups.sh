#!/usr/bin/env bash
DAYNAME=$(date +%a)
scp /home/nhsrc/facilities-assessment-host/db/backup/facilities_assessment_cg_${DAYNAME}.sql bahmni_support@192.168.0.157:/home/bahmni_support/igunatmacbackup/
scp /home/nhsrc/facilities-assessment-host/metabase/metabase.db.mv.db_${DAYNAME} bahmni_support@192.168.0.157:/home/bahmni_support/igunatmacbackup/