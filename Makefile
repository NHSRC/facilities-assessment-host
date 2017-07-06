# JSS SPECIFIC TASKS
# Common to all JSS environments
jss_mp_start_server:
	cd app-servers/mp && nohup java -jar facilities-assessment-server-0.0.1-SNAPSHOT.jar > log/facilities_assessment.log 2>&1 &

jss_take_all_db_backup:
	cd db/

# Getting stuff from JSS Production
jss_pull_all_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/facilities_assessment_cg_dump_$(DAY).sql db/backup/
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/new_facilitiess_assessment_mp_$(DAY).sql db/backup/
	make restore_new_db database=facilities_assessment_cg backup=facilities_assessment_cg_dump_$(DAY).sql
	make restore_new_db database=new_facilitiess_assessment_mp backup=new_facilitiess_assessment_mp_$(DAY).sql

# Pushing stuff to JSS Production

# Working in JSS production server

jss_cg_start_server:
	cd app-servers/cg && nohup java -jar facilities-assessment-server-0.0.1-SNAPSHOT.jar > log/facilities_assessment.log 2>&1 &

# Common to all environments
start_metabase:
	cd metabase && nohup java -jar metabase.jar >> log/metabase.log 2>&1 &

restore_new_db:
	-psql postgres -c 'drop database $(database)'
	psql postgres -c 'create database $(database) with owner nhsrc'
	psql facilities_assessment_nhsrc -c 'create extension if not exists "uuid-ossp"';
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