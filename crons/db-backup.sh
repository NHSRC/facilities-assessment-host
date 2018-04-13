cd .. && make backup_nhsrc_db postgres_user=postgres NUM=$(date +%a)
scp /home/nhsrc1/facilities-assessment-host/db/backup/facilities_assessment_nhsrc_$(date +%a)_production.sql nhsrc2@10.31.37.23:/home/nhsrc2/backup/
scp /home/nhsrc1/facilities-assessment-host/metabase/metabase.db.mv.db nhsrc2@10.31.37.23:/home/nhsrc2/backup/metabase.db.mv.db_$(date +%a)