jar_file=facilities-assessment-server-0.0.1-SNAPSHOT.jar
metabase_db_file=metabase.db.mv.db

jss_database := facilities_assessment_cg
nhsrc_database := facilities_assessment_nhsrc
jss_port := 6001
nhsrc_port := 80
DAYNAME := $(shell date +%a)
database_file := $(database)_$(NUM)_$(ENV).sql
prod_database_file := $(database)_$(NUM)_production.sql
superuser := $(shell id -un)

define _start_server
	cd app-servers && nohup java -jar $(jar_file) --database=$1 --server.port=$2 > log/facilities_assessment.log 2>&1 &
endef

define _stop_server
	-pkill -f 'database=$1'
endef

test:
	@echo $(database)

# <db>
recreate_db:
	sudo -u $(superuser) psql postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$(database)' AND pid <> pg_backend_pid()"
	-sudo -u $(superuser) psql postgres -c 'drop database $(database)'
	sudo -u $(superuser) psql postgres -c 'create database $(database) with owner nhsrc'
	sudo -u $(superuser) psql $(database) -c 'create extension if not exists "uuid-ossp"'

restore_db:
	make recreate_db database=$(database)
	sudo -u $(superuser) psql $(database) < db/backup/$(backup)

restore_prod_db:
	make restore_db database=$(database) backup=$(prod_database_file)

restore_development_db:
	make restore_db database=$(database) backup=$(database_file)

recreate_schema:
	-psql -Unhsrc postgres -c 'drop database $(db)';
	-psql -Unhsrc postgres -c 'create database $(db) with owner nhsrc';
	-psql $(db) -c 'create extension if not exists "uuid-ossp"';
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(db) -schemas=public clean
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(db) -schemas=public -locations=filesystem:../facilities-assessment-server/src/main/resources/db/migration/ migrate

backup_db:
	pg_dump $(database) > db/backup/$(database)_$(DAYNAME)_$(ENV).sql
# </db>

# <server>
start_server_jss:
	$(call _start_server,$(jss_database),$(jss_port))

start_server_nhsrc:
	$(call _start_server,$(nhsrc_database),$(nhsrc_port))

stop_server_jss:
	$(call _stop_server,$(jss_database))

stop_server_nhsrc:
	$(call _stop_server,$(nhsrc_database))
# </server>

download_file:
	cd downloads && wget -c --retry-connrefused --tries=0 -O $(outputfile) $(url)

# ALL JSS ENVIRONMENTS

jss_take_all_db_backup:
	sh db/take-db-backup.sh
	sh metabase/take-db-backup.sh
	ls -lt db/backup/
	ls -lt metabase/backup/

# PULL FROM JSS PRODUCTION
jss_pull_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/$(database_file) db/backup/

# PUSH TO JSS PRODUCTION
jss_push_metabase_db:
	scp metabase/$(metabase_db_file) nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/metabase/

jss_push_server_jar:
	scp ../facilities-assessment-server/build/libs/$(jar_file) nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/app-servers/cg


# JSS PRODUCTION SERVER
# Common to all environments
stop_metabase:
	-pkill -f 'java -jar metabase.jar'

start_metabase:
	cd metabase && nohup java -jar metabase.jar >> log/metabase.log 2>&1 &

# <nhsrc>
nhsrc_prod_server=103.35.123.67
nhsrc_slave_server=103.35.123.68
nhsrc_server_port=2249

nhsrc_setup_region_data:
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(database) < ../reference-data/nhsrc/regions/regionData.sql

nhsrc_setup_assessment_tools_data:
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < db/instances/nhsrc/assessment_tools.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_NQAS_DH.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_NQAS_CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_NQAS_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_NQAS_UPHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_KK_DH_SDH_CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_KK_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/NHSRC_KK_UPHC_APHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < ../reference-data/nhsrc/output/standards_short_names.sql

nhsrc_setup_all_data: nhsrc_setup_assessment_tools_data nhsrc_setup_region_data

nhsrc_pull_db:
	scp -P $(nhsrc_server_port) nhsrc@$(nhsrc_prod_server):/home/nhsrc/facilities-assessment-host/db/backup/$(nhsrc_db)_$(DAY).sql db/backup/$(nhsrc_db)_$(DAY)_Prod.sql

nhsrc_push_db:
	scp -P $(nhsrc_server_port) db/backup/$(database_file) nhsrc@$(nhsrc_prod_server):/home/nhsrc/facilities-assessment-host/db/backup/
# </nhsrc>


# <local_development>
_flyway_migrate:
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(database) -schemas=$(schema) -locations=filesystem:../facilities-assessment-server/src/main/resources/db/migration/ migrate

_get_server_jar:
	cd ../facilities-assessment-server && make binary
	cp ../facilities-assessment-server/build/libs/$(jar_file) app-servers/$(env)

_make_binary:
	cd ../facilities-assessment-server && make binary

cg_get_server_jar:
	make _get_server_jar env=cg

create_release: _make_binary
	cp ../facilities-assessment-server/build/libs/$(jar_file) releases/$(client)/$(release)

jss_cg_deploy_server:
	make _get_server_jar env=cg

jss_cg_assessment_tools:
	psql -Unhsrc facilities_assessment < src/test/resources/db/migration/jss/CGDeployment.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment < ../checklists/jss/cg/CG-NQAS-DH-English/output.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment < ../checklists/jss/cg/output.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment < ../checklists/jss/cg/output-bsu.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment < ../checklists/jss/cg/output-bsu-inputs.sql
# </local_development>


# <jss_release>
jss_try_release_3_local:
	make restore_db database=$(mp_db) backup=new_facilitiess_assessment_mp_WED_Prod.sql
	make restore_db database=$(cg_db) backup=facilities_assessment_cg_Wed_Prod.sql
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

	# fix jss data before we do the merge (remember there is no other MP data before this release)
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-fixjssdata.sql

	# copy over data from jss(mp) schema to public schema
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-mergedb.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'drop schema mp cascade'

	# Create new schema for mp, this time for importing MP (not JSS) checklists (not assessments)
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'create schema mp';
	make _flyway_migrate database=$(cg_db) schema=mp
	psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f ../reference-data/jss/mp/checklists/CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f ../reference-data/jss/mp/checklists/DH.sql
	psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f deployments/jss/v0.4-update-state.sql
#	find ../reference-data/jss/mp/assessments/output/ -name *verify_checklists*.sql -exec psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f {} \; > log/verifyChecklists.log
#	find ../reference-data/jss/mp/assessments/output/ -name *verify_checkpoints*.sql -exec psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=mp user=nhsrc" -a -f {} \; > log/verifyCheckpoints.log

	# copy over data from mp schema to public schema
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-mergedb.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) -c 'drop schema mp cascade'

#	Import assessments
	find ../reference-data/jss/mp/assessments/output/ -name *26-12-2016*.sql -exec psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=public user=nhsrc" -a -f {} \; > log/assessmentImport.log
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < deployments/jss/v0.4-update-assessment-dates.sql

jss_try_release_4_local:
	make restore_db database=$(cg_db) backup=facilities_assessment_cg_LOCAL.sql
	make restore_db database=$(mp_db) backup=new_facilitiess_assessment_mp_LOCAL.sql
	make jss_release_4 superuser=$(superuser)

jss_release_4_prod:
	make restore_db database=$(cg_db) backup=facilities_assessment_cg_LOCAL_4.sql

jss_release_4_1:
	find deployments/jss/0.4/ -name *.sql -exec psql -v ON_ERROR_STOP=1 --echo-all "dbname=$(cg_db) options=--search_path=public user=nhsrc" -a -f {} \; > log/assessmentImport2.log

schedule_backup:
	sudo sh schedule-backup.sh

jss_try_release_4_2_local:
	make restore_db database=$(cg_db) backup=facilities_assessment_cg_Sun_Prod.sql
#	make _flyway_migrate database=$(cg_db) schema=public

jss_try_release_6_local:
	make restore_db database=$(cg_db) backup=facilities_assessment_cg_Wed_Prod.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < releases/jss/0.6/prod_migration.sql

jss_migrate_release_6:
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < releases/jss/0.6/prod_migration.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < releases/jss/0.6/R__Reporting_Views.sql

jss_migrate_release_6_2:
	make restore_db database=$(cg_db) backup=facilities_assessment_cg_Thu_Prod.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < releases/jss/0.6.2/add-sector-schema.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < releases/jss/0.6.2/remove-kota-district.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < releases/jss/0.6.2/NHSRC_NQAS_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < releases/jss/0.6.2/SC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(cg_db) < releases/jss/0.6.2/fix-department-names.sql

jss_migrate_release_7:
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_db) < releases/nhsrc/0.7/deleteData.sql
# </jss_release>

# <nhsrc_releases>
# Release 1 - One uploaded first on playstore without a backend

# Release 2
nhsrc_migrate_release_7_2:
	make restore_prod_db NUM=1 db=nhsrc
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/fix-schema-version.sql
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(nhsrc_database) -schemas=public -locations=filesystem:../facilities-assessment-server/src/main/resources/db/migration/ migrate
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/cleanData.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/LAQSHYA-NQAS-LR.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/LAQSHYA-NQAS-OT.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/andaman-nicobar.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/dakshata.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/laqshya-modifications.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/updateStateNames.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/updateStateShortCode.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/create-hmis-table.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) -c "\copy hmis_facility FROM '~/Downloads/Kerala.csv' DELIMITER ',' CSV"
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < releases/nhsrc/0.7.2/update-hmis-id.sql
# </nhsrc_releases>