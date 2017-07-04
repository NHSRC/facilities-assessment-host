restore_new_db:
	-psql postgres -c 'drop database $(database)'
	-psql postgres -c 'create database $(database) with owner nhsrc'
	-psql facilities_assessment_nhsrc -c 'create extension if not exists "uuid-ossp"';
	-psql $(database) < db/backup/$(backup)

reset_db_nhsrc:
	-psql postgres -c 'drop database facilities_assessment_nhsrc';
	-psql postgres -c 'create database facilities_assessment_nhsrc with owner nhsrc';
	-psql facilities_assessment_nhsrc -c 'create extension if not exists "uuid-ossp"';
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/facilities_assessment_nhsrc -schemas=public clean
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/facilities_assessment_nhsrc -schemas=public -locations=filesystem:../facilities-assessment-server/src/main/resources/db/migration/ migrate

nhsrc_assessment_tools: reset_db_nhsrc
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < db/instances/nhsrc/assessment_tools.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../checklists/nhsrc/output/NHSRC_NQAS_DH.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../checklists/nhsrc/output/NHSRC_NQAS_CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../checklists/nhsrc/output/NHSRC_NQAS_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../checklists/nhsrc/output/NHSRC_NQAS_UPHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../checklists/nhsrc/output/NHSRC_KK_DH_SDH_CHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../checklists/nhsrc/output/NHSRC_KK_PHC.sql
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc facilities_assessment_nhsrc < ../checklists/nhsrc/output/NHSRC_KK_UPHC_APHC.sql

jss_cg_db_pull_and_restore:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/facilities_asessment_cg_dump_$(DAY).sql db/backup/
	make restore_new_db database=facilities_asessment_cg backup=facilities_asessment_cg_dump_$(DAY).sql

jss_mp_db_pull_and_restore:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/db/backup/facilities_asessment_cg_dump_$(DAY).sql db/backup/
	make restore_new_db database=facilities_asessment_cg backup=facilities_asessment_cg_dump_$(DAY).sql