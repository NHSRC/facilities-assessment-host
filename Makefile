jar_file=facilities-assessment-server-0.0.1-SNAPSHOT.jar
metabase_db_file=metabase.db.mv.db

jss_database := facilities_assessment_cg
nhsrc_database := facilities_assessment_nhsrc
nhsrc_port := 80
Today_Day_Name := $(shell date +%a)
postgres_user := $(shell id -un)
nhsrc_prod_server=10.31.37.23
nhsrc_slave_server=10.31.37.24

define _start_server
	cd app-servers && nohup java -jar $(jar_file) --database=$1 --server.http.port=$2 --server.port=$3 > log/facilities_assessment.log 2>&1 &
endef

define _stop_server
	-pkill -f 'database=$1'
endef

define _restore_db
	make recreate_db database=$1
	sudo -u $(postgres_user) psql $1 < db/backup/$2
endef

define _flyway_migrate
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$1 -schemas=public -locations=filesystem:../facilities-assessment-server/src/main/resources/db/migration/ migrate
endef

define _backup_db
	sudo -u $(postgres_user) pg_dump $1 > db/backup/$1_$2_production.sql
endef

define _execute_on_nhsrc_prod
	ssh gunak-main "cd /home/nhsrc1/facilities-assessment-host && make $1"
endef

test:
	@echo $(Today_Day_Name)

# <db>
recreate_db:
	sudo -u $(postgres_user) psql postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = '$(database)' AND pid <> pg_backend_pid()"
	-sudo -u $(postgres_user) psql postgres -c 'drop database $(database)'
	sudo -u $(postgres_user) psql postgres -c 'create database $(database) with owner nhsrc'
	sudo -u $(postgres_user) psql $(database) -c 'create extension if not exists "uuid-ossp"'

restore_jss_db:
	$(call _restore_db,$(jss_database),$(file))

restore_nhsrc_db:
	$(call _restore_db,$(nhsrc_database),$(file))

recreate_schema:
	-psql -Unhsrc postgres -c 'drop database $(db)';
	-psql -Unhsrc postgres -c 'create database $(db) with owner nhsrc';
	-psql $(db) -c 'create extension if not exists "uuid-ossp"';
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(db) -schemas=public clean
	$(call _flyway_migrate,$(db))

backup_nhsrc_db:
	$(call _backup_db,$(nhsrc_database),$(NUM))

pull_jss_db:
	scp igunatmac:/home/nhsrc/facilities-assessment-host/db/backup/$(file) db/backup/

pull_nhsrc_db:
	scp gunak-main:/home/nhsrc1/facilities-assessment-host/db/backup/$(file) db/backup/

schedule_backup:
	sudo sh schedule-backup.sh

export_nhsrc_db_data_only:
	psql -v ON_ERROR_STOP=1 --echo-all -Unhsrc $(nhsrc_database) < db/deleteMostAssessments.sql
	sudo -u $(postgres_user) pg_dump $(nhsrc_database) -a --inserts -T schema_version -T users -T user_role > db/backup/data_only.sql
# </db>

# <server>
start_server_jss:
	$(call _start_server,$(jss_database),6001,6002)

start_server_nhsrc:
	$(call _start_server,$(nhsrc_database),80,443)

stop_server_jss:
	$(call _stop_server,$(jss_database))

stop_server_nhsrc:
	$(call _stop_server,$(nhsrc_database))
# </server>

# <metabase>
stop_metabase:
	-pkill -f 'java -Dlog4j.configuration=file:log4j.properties -jar metabase.jar'

start_metabase:
	cd metabase && nohup java -Dlog4j.configuration=file:log4j.properties -jar metabase.jar >> log/metabase.log 2>&1 &
# </metabase>

# <metabase_db>
pull_jss_metabase_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/metabase/$(metabase_db_file) metabase/backup/jssprod/
# </metabase_db>

start_all_nhsrc: start_server_nhsrc start_metabase
stop_all_nhsrc: stop_server_nhsrc stop_metabase
	ps -ef | grep java

download_file:
	rm downloads/$(outputfile)
	cd downloads && wget -c --retry-connrefused --tries=0 -O $(outputfile) $(url)

jss_take_all_db_backup:
	sh db/take-db-backup.sh
	sh metabase/take-db-backup.sh
	ls -lt db/backup/
	ls -lt metabase/backup/

# PUSH TO JSS PRODUCTION
jss_push_server_jar:
	scp ../facilities-assessment-server/build/libs/$(jar_file) nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/app-servers/cg


# <nhsrc>
nhsrc_pull_db:
	scp -P $(nhsrc_server_port) nhsrc@$(nhsrc_prod_server):/home/nhsrc/facilities-assessment-host/db/backup/$(nhsrc_db)_$(DAY).sql db/backup/$(nhsrc_db)_$(DAY)_Prod.sql

nhsrc_pull_metabase_db:
	scp gunak-main:/home/nhsrc1/facilities-assessment-host/metabase/metabase.db.mv.db metabase/nhsrc/

nhsrc_push_db:
	scp -P $(nhsrc_server_port) db/backup/$(database_file) nhsrc@$(nhsrc_prod_server):/home/nhsrc/facilities-assessment-host/db/backup/
# </nhsrc>


# <local_development>

_get_server_jar:
	cd ../facilities-assessment-server && make binary
	cp ../facilities-assessment-server/build/libs/$(jar_file) app-servers/$(env)

_make_binary:
	cd ../facilities-assessment-server && make binary

create_release: _make_binary
	cp ../facilities-assessment-server/build/libs/$(jar_file) releases/$(client)/$(release)
# </local_development>

deploy_server_from_download:
	cp downloads/$(jar_file) app-servers/

deploy_app_from_download:
	cp downloads/app.apk app-servers/external/app.apk

deploy_all_from_download: deploy_server_from_download deploy_app_from_download

# prod
nhsrc_cron_backup:
	$(call _backup_db,$(nhsrc_database),$(Today_Day_Name))
	scp /home/nhsrc1/facilities-assessment-host/db/backup/facilities_assessment_nhsrc_$(Today_Day_Name)_production.sql nhsrc2@10.31.37.24:/home/nhsrc2/backup/
	scp /home/nhsrc1/facilities-assessment-host/metabase/metabase.db.mv.db nhsrc2@10.31.37.24:/home/nhsrc2/backup/metabase.db.mv.db_$(Today_Day_Name)

nhsrc_migrate_release_7_8:
	$(call _restore_db,$(nhsrc_database),facilities_assessment_nhsrc_Wed_production.sql)

jss_migrate_release_7_4:
	$(call _restore_db,$(jss_database),facilities_assessment_cg_Fri.sql)
	sudo -u $(postgres_user) psql -v ON_ERROR_STOP=1 --echo-all -U$(postgres_user) $(jss_database) < releases/jss/laqshya-checklist-dh-chc-0.7.4/Maternity-Services.sql
	sudo -u $(postgres_user) psql -v ON_ERROR_STOP=1 --echo-all -U$(postgres_user) $(jss_database) < releases/jss/laqshya-checklist-dh-chc-0.7.4/opd-anc.sql


rescore_everything_nhsrc:
	sudo -u $(postgres_user) psql -v ON_ERROR_STOP=1 --echo-all -U$(postgres_user) $(nhsrc_database) < db/rescore-everything.sql

publish_server_to_nhsrc_prod:
	cd ../facilities-assessment-server && make build_server
	scp build/libs/facilities-assessment-server-0.0.1-SNAPSHOT.jar gunak-main:/home/nhsrc1/facilities-assessment-host/downloads/
	$(call _execute_on_nhsrc_prod,prepare_server_for_release)

publish_metabase_db_to_nhsrc_prod:
	scp metabase/nhsrc/metabase.db.mv.db gunak-main:/home/nhsrc1/facilities-assessment-host/downloads/
	$(call _execute_on_nhsrc_prod,prepare_metabase_db_for_release)

publish_metabase_server_to_nhsrc_prod:
	scp metabase/nhsrc/metabase.jar gunak-main:/home/nhsrc1/facilities-assessment-host/downloads/
	$(call _execute_on_nhsrc_prod,prepare_metabase_server_for_release)

publish_gunak_web_to_nhsrc_prod:
	cd ../gunak-web-app && make deploy_gunak_server
	scp -r app-servers/app/*.* gunak-main:/home/nhsrc1/facilities-assessment-host/downloads/app/
	$(call _execute_on_nhsrc_prod,prepare_gunak_web_for_release)

prepare_server_for_release:
	cp app-servers/facilities-assessment-server-0.0.1-SNAPSHOT.jar downloads/facilities-assessment-server-0.0.1-SNAPSHOT.jar.before.release
	make backup_nhsrc_db NUM=before-release postgres_user=postgres

prepare_metabase_db_for_release:
	cp metabase/metabase.db.mv.db downloads/metabase.db.mv.db.beforeRelease

prepare_metabase_server_for_release:
	cp metabase/metabase.jar downloads/metabase.jar.beforeRelease

prepare_gunak_web_for_release:
	rm -rf downloads/app-before-release/*
	-mkdir downloads/app-before-release/
	cp app-servers/app/*.* downloads/app-before-release/

nhsrc_release_server:
	make stop_metabase
	cp downloads/metabase.db.mv.db metabase/
	make start_metabase

nhsrc_release_metabase:
	make stop_server_nhsrc
	cp downloads/facilities-assessment-server-0.0.1-SNAPSHOT.jar app-servers/
	make start_server_nhsrc
	tail -n300 -f app-servers/log/facilities_assessment.log