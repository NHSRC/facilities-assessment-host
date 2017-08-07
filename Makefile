jar_file=facilities-assessment-server-0.0.1-SNAPSHOT.jar
metabase_db_file=metabase.db.mv.db

# JSS SPECIFIC TASKS
mp_db=new_facilitiess_assessment_mp
cg_db=facilities_assessment_cg
nhsrc_db := facilities_assessment_nhsrc
superuser := $(shell id -un)

restore_new_db:
	psql postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$(database)' AND pid <> pg_backend_pid()"
	-psql postgres -c 'drop database $(database)'
	psql postgres -c 'create database $(database) with owner nhsrc'
	psql $(database) -c 'create extension if not exists "uuid-ossp"';
	psql $(database) < db/backup/$(backup)

# ALL JSS ENVIRONMENTS
jss_mp_stop_server:
	-pkill -f 'database=$(mp_db)'

jss_cg_stop_server:
	-pkill -f 'database=$(cg_db)'

jss_mp_start_server:
	cd app-servers/mp && nohup java -jar $(jar_file) --database=$(mp_db) --server.port=5000 > log/facilities_assessment.log 2>&1 &

jss_mp_start_server_tail: jss_mp_start_server
	tail -f app-servers/mp/log/facilities_assessment.log

jss_cg_start_server:
	cd app-servers/cg && nohup java -jar $(jar_file) --database=facilities_assessment_cg --server.port=6001 > log/facilities_assessment.log 2>&1 &

jss_cg_start_server_tail: jss_cg_start_server
	tail -f app-servers/cg/log/facilities_assessment.log

jss_mp_restart_server: jss_mp_stop_server get_server_jar jss_mp_start_server

jss_take_all_db_backup:
	sh db/take-db-backup.sh
	sh metabase/take-db-backup.sh
	ls -lt db/backup/
	ls -lt metabase/backup/

jss_restore_mp_db:
	make restore_new_db DAY=$(DAY) database=$(mp_db) backup=$(mp_db)_$(DAY).sql

jss_restore_cg_db:
	make restore_new_db DAY=$(DAY) database=$(cg_db) backup=$(cg_db)_$(DAY).sql

# PULL FROM JSS PRODUCTION
jss_pull_and_restore_all_db: jss_pull_mp_db jss_pull_cg_db jss_pull_and_restore_metabase_db

jss_pull_mp_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/$(mp_db)_$(DAY).sql db/backup/$(mp_db)_$(DAY)_Prod.sql

jss_pull_cg_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/$(cg_db)_$(DAY).sql db/backup/$(cg_db)_$(DAY)_Prod.sql

jss_pull_and_restore_metabase_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/metabase/backup/$(metabase_db_file)_$(DAY) metabase/$(metabase_db_file)

# PUSH TO JSS PRODUCTION
jss_push_metabase_db:
	scp metabase/$(metabase_db_file) nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/metabase/

jss_cg_push_server_jar:
	scp ../facilities-assessment-server/build/libs/$(jar_file) nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/app-servers/cg

# JSS PRODUCTION SERVER
# Common to all environments
stop_metabase:
	-pkill -f 'java -jar metabase.jar'

start_metabase:
	cd metabase && nohup java -jar metabase.jar >> log/metabase.log 2>&1 &

jss_restore_all_db:
	make restore_new_db database=$(cg_db) backup=$(cg_db)_$(DAY).sql
	make restore_new_db database=$(mp_db) backup=$(mp_db)_$(DAY).sql

# NHSRC
reset_db_nhsrc:
	-psql -Unhsrc postgres -c 'drop database $(nhsrc_db)';
	-psql -Unhsrc postgres -c 'create database $(nhsrc_db) with owner nhsrc';
	-psql $(nhsrc_db) -c 'create extension if not exists "uuid-ossp"';
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(nhsrc_db) -schemas=public clean
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(nhsrc_db) -schemas=public -locations=filesystem:../facilities-assessment-server/src/main/resources/db/migration/ migrate

nhsrc_region_data:
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/regions/regionData.sql

nhsrc_assessment_tools: reset_db_nhsrc
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < db/instances/nhsrc/assessment_tools.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_NQAS_DH.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_NQAS_CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_NQAS_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_NQAS_UPHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_KK_DH_SDH_CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_KK_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_KK_UPHC_APHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/standards_short_names.sql

nhsrc_all: nhsrc_assessment_tools nhsrc_region_data

# LOCAL/DEVELOPMENT
_flyway_migrate:
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(database) -schemas=$(schema) -locations=filesystem:../facilities-assessment-server/src/main/resources/db/migration/ migrate

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

jss_cg_deploy_server:
	make _get_server_jar env=cg

jss_try_release_3_local:
	make restore_new_db database=$(mp_db) backup=new_facilitiess_assessment_mp_WED_Prod.sql
	make restore_new_db database=$(cg_db) backup=facilities_assessment_cg_Wed_Prod.sql
	make _flyway_migrate database=$(mp_db) schema=public
	make _flyway_migrate database=$(cg_db) schema=public
	make jss_release_3

jss_release_3:
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(mp_db) < deployments/jss/v0.3_facility_data.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(mp_db) < deployments/jss/v0.3_dakshata.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.3_dakshata.sql

#change the location of where to find the migration scripts. this may need to be packaged in this host project
jss_release_4:
	# bring all db to the latest version
	make _flyway_migrate database=$(mp_db) schema=public
	make _flyway_migrate database=$(cg_db) schema=public

	# copy jss db to main db as different schema
	psql -v ON_ERROR_STOP=1 --echo-all -U$(superuser) $(cg_db) -c 'ALTER SCHEMA public owner TO nhsrc';
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'alter schema public rename to original_public';
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'create schema public';
	psql -v ON_ERROR_STOP=1 --echo-all -U$(superuser) $(cg_db) -c 'ALTER EXTENSION "uuid-ossp" SET SCHEMA public';
	pg_dump --format custom --file db/backup/temp_mp.sql --schema "public" $(mp_db);
	pg_restore --dbname $(cg_db) db/backup/temp_mp.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'alter schema public rename to mp';
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'alter schema original_public rename to public';
	psql -v ON_ERROR_STOP=1 --echo-all -U$(superuser) $(cg_db) -c 'ALTER EXTENSION "uuid-ossp" SET SCHEMA public';

	# fix jss data before we do the merge
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-fixjssdata.sql

	# copy over data from jss(mp) schema to public schema
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-mergedb.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'drop schema mp cascade'

#	# Create new schema for mp, this time for importing MP (not JSS) checklists (not assessments)
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'create schema mp';
	make _flyway_migrate database=$(cg_db) schema=mp
	psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f ../reference-data/jss/mp/checklists/CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f ../reference-data/jss/mp/checklists/DH.sql
	psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f deployments/jss/v0.4-update-state.sql
#	find ../reference-data/jss/mp/assessments/output/ -name *verify_checklists*.sql -exec psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f {} \; > log/verifyChecklists.log
#	find ../reference-data/jss/mp/assessments/output/ -name *verify_checkpoints*.sql -exec psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f {} \; > log/verifyCheckpoints.log

	# copy over data from mp schema to public schema
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-mergedb.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-update-state.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'drop schema mp cascade'

#	# Import assessments
	find ../reference-data/jss/mp/assessments/output/ -name *26-12-2016*.sql -exec psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=public user=nhsrc" -a -f {} \; > log/assessmentImport.log
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-update-assessment-dates.sql

jss_try_release_4_local:
	make restore_new_db database=$(cg_db) backup=facilities_assessment_cg_LOCAL.sql
	make restore_new_db database=$(mp_db) backup=new_facilitiess_assessment_mp_LOCAL.sql
	make jss_release_4 superuser=$(superuser)