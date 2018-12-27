jar_file=facilities-assessment-server-0.0.1-SNAPSHOT.jar
metabase_db_file=metabase.db.mv.db

database := facilities_assessment
qa_database := facilities_assessment_qa
nhsrc_port := 80
Today_Day_Name := $(shell date +%a)
postgres_user := $(shell id -un)
nhsrc_prod_server=10.31.37.23
nhsrc_slave_server=10.31.37.24

define _start_server
    cd app-servers && java -jar $(jar_file) --database=$1 --server.http.port=$2 --server.port=$3 --fa.secure=$4
endef

define _start_daemon
	cd app-servers && nohup java -jar $(jar_file) --database=$1 --server.http.port=$2 --server.port=$3 --fa.secure=$4
endef

define _stop_daemon
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

restore_prod_db:
	$(call _restore_db,$(database),$(file))

restore_qa_db:
	$(call _restore_db,$(qa_database),$(file))

create_qa_db:
	make recreate_db database=$(qa_database) postgres_user=postgres

recreate_schema:
	-psql -Unhsrc postgres -c 'drop database $(db)';
	-psql -Unhsrc postgres -c 'create database $(db) with owner nhsrc';
	-psql $(db) -c 'create extension if not exists "uuid-ossp"';
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(db) -schemas=public clean
	$(call _flyway_migrate,$(db))

schedule_backup:
	sudo sh schedule-backup.sh
# </db>

# <service>
start_server:
	$(call _start_server,$(database),80,443,false)

start_qa_server:
	$(call _start_server,$(qa_database),9001,9002,false)

# <daemon>
start_daemon:
	$(call _start_daemon,$(database),80,443,false)

# <metabase>
stop_metabase:
	-pkill -f 'java -Dlog4j.configuration=file:log4j.properties -jar metabase.jar'

start_metabase:
	cd metabase && nohup java -Dlog4j.configuration=file:log4j.properties -jar metabase.jar >> log/metabase.log 2>&1 &

start_metabase_server:
	cd metabase && java -Dlog4j.configuration=file:log4j.properties -jar metabase.jar >> log/metabase.log 2>&1
# </metabase>

# <metabase_db>
pull_jss_metabase_db:
	scp nhsrc@192.168.0.155:/home/nhsrc/facilities-assessment-host/metabase/$(metabase_db_file) metabase/backup/jssprod/
# </metabase_db>

start_all_nhsrc: start_daemon_nhsrc start_metabase
stop_all_nhsrc: stop_daemon_nhsrc stop_metabase
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


_get_server_jar:
	cd ../facilities-assessment-server && make binary
	cp ../facilities-assessment-server/build/libs/$(jar_file) app-servers/$(env)

_make_binary:
	cd ../facilities-assessment-server && make binary

create_release: _make_binary
	cp ../facilities-assessment-server/build/libs/$(jar_file) releases/$(client)/$(release)

deploy_server_from_download:
	cp downloads/$(jar_file) app-servers/

deploy_app_from_download:
	cp downloads/app.apk app-servers/external/app.apk

deploy_all_from_download: deploy_server_from_download deploy_app_from_download