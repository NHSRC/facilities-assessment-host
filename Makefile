jar_file=facilities-assessment-server-0.0.1-SNAPSHOT.jar

# JSS SPECIFIC TASKS
mp_db=new_facilitiess_assessment_mp
cg_db=facilities_assessment_cg

# ALL JSS ENVIRONMENTS
jss_mp_stop_server:
	-pkill -f 'database=$(mp_db)'

jss_cg_stop_server:
	-pkill -f 'database=$(cg_db)'

jss_mp_start_server: jss_mp_stop_server
	cd app-servers/mp && nohup java -jar $(jar_file) --database=$(mp_db) --server.port=5000 > log/facilities_assessment.log 2>&1 &
	tail -f app-servers/mp/log/facilities_assessment.log

jss_cg_start_server:
	cd app-servers/cg && nohup java -jar $(jar_file) --database=facilities_assessment_cg --server.port=6001 > log/facilities_assessment.log 2>&1 &
	tail -f app-servers/cg/log/facilities_assessment.log

jss_mp_restart_server: jss_mp_stop_server get_server_jar jss_mp_start_server

jss_take_all_db_backup:
	sh db/take-db-backup.sh
	sh metabase/take-db-backup.sh
	ls -lt db/backup/
	ls -lt metabase/backup/

# PULL FROM JSS PRODUCTION
jss_pull_and_restore_all_db: jss_pull_mp_db jss_pull_cg_db jss_pull_and_restore_metabase_db

jss_pull_mp_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/$(mp_db)_$(DAY).sql db/backup/

jss_pull_cg_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/facilities_assessment_cg_$(DAY).sql db/backup/

jss_pull_and_restore_metabase_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/metabase/backup/metabase.db.mv.db_$(DAY) metabase/metabase.db.mv.db

jss_restore_all_db:
	make restore_new_db database=facilities_assessment_cg backup=facilities_assessment_cg_$(DAY).sql
	make restore_new_db database=$(mp_db) backup=$(mp_db)_$(DAY).sql

# PUSH TO JSS PRODUCTION
jss_push_metabase_db:
	scp metabase/metabase.db.mv.db nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/metabase/

jss_cg_push_server_jar:
	scp ../facilities-assessment-server/build/libs/$(jar_file) nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/app-servers/cg

# JSS PRODUCTION SERVER
# Common to all environments
stop_metabase:
	-pkill -f 'java -jar metabase.jar'

start_metabase:
	cd metabase && nohup java -jar metabase.jar >> log/metabase.log 2>&1 &

restore_new_db:
	psql postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$(database)' AND pid <> pg_backend_pid()"
	-psql postgres -c 'drop database $(database)'
	psql postgres -c 'create database $(database) with owner nhsrc'
	psql $(database) -c 'create extension if not exists "uuid-ossp"';
	psql $(database) < db/backup/$(backup)

reset_db_nhsrc:
	-psql postgres -c 'drop database facilities_assessment_nhsrc';
	-psql postgres -c 'create database facilities_assessment_nhsrc with owner nhsrc';
	-psql facilities_assessment_nhsrc -c 'create extension if not exists "uuid-ossp"';
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/facilities_assessment_nhsrc -schemas=public clean
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/facilities_assessment_nhsrc -schemas=public -locations=filesystem:../facilities-assessment-server/src/main/resources/db/migration/ migrate

nhsrc_region_data:
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../reference-data/nhsrc/regions/regionData.sql

nhsrc_assessment_tools: reset_db_nhsrc
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < db/instances/nhsrc/assessment_tools.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../reference-data/nhsrc/output/NHSRC_NQAS_DH.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../reference-data/nhsrc/output/NHSRC_NQAS_CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../reference-data/nhsrc/output/NHSRC_NQAS_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../reference-data/nhsrc/output/NHSRC_NQAS_UPHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../reference-data/nhsrc/output/NHSRC_KK_DH_SDH_CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../reference-data/nhsrc/output/NHSRC_KK_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../reference-data/nhsrc/output/NHSRC_KK_UPHC_APHC.sql

nhsrc_all: nhsrc_assessment_tools nhsrc_region_data

# LOCAL/DEVELOPMENT
_get_server_jar:
	cd ../facilities-assessment-server && make binary
	cp ../facilities-assessment-server/build/libs/$(jar_file) app-servers/$(env)

_make_binary:
	cd ../facilities-assessment-server && make binary

qa_db=facilities_assessment_cg

qa_restore_db_from:
	make restore_new_db database=$(qa_db) backup=$(BACKUP).sql

qa_get_server_jar:
	make _get_server_jar env=qa

cg_get_server_jar:
	make _get_server_jar env=cg

qa_stop_server:
	-pkill -f 'database=$(qa_db)'

qa_start_server: qa_stop_server
	cd app-servers/qa && nohup java -jar $(jar_file) --database=$(qa_db) --server.port=5000 > log/facilities_assessment.log 2>&1 &
	tail -f app-servers/qa/log/facilities_assessment.log

create_release: _make_binary
	cp ../facilities-assessment-server/build/libs/$(jar_file) releases/$(client)/$(release)
