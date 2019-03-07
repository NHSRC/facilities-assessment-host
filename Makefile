jar_file=facilities-assessment-server-0.0.1-SNAPSHOT.jar
metabase_db_file=metabase.db.mv.db

database := facilities_assessment
qa_database := facilities_assessment_qa
local_jss_database := facilities_assessment_cg
nhsrc_port := 80
Today_Day_Name := $(shell date +%a)
postgres_user := $(shell id -un)
nhsrc_prod_server=10.31.37.23
nhsrc_slave_server=10.31.37.24

help: ##		Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

define _start_server
    cd app-servers && java -jar $(jar_file) --database=$1 --server.http.port=$2 --server.port=$3 --fa.secure=$4
endef

define _start_daemon
	cd app-servers && nohup java -jar $(jar_file) --database=$1 --server.http.port=$2 --server.port=$3 --fa.secure=$4
endef

define _stop_daemon
	-pkill -f 'database=$1'
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
recreate_schema:
	-psql -Unhsrc postgres -c 'drop database $(db)';
	-psql -Unhsrc postgres -c 'create database $(db) with owner nhsrc';
	-psql $(db) -c 'create extension if not exists "uuid-ossp"';
	flyway -user=nhsrc -password=password -url=jdbc:postgresql://localhost:5432/$(db) -schemas=public clean
	$(call _flyway_migrate,$(db))

schedule_backup:
	sudo sh schedule-backup.sh

backup_db:
	pg_dump -Unhsrc -hlocalhost -d facilities_assessment > $(file)

backup_jss_db:
	pg_dump -Unhsrc -hlocalhost -d facilities_assessment_cg > $(file)
# </db>

# <service>
start_server:
	$(call _start_server,$(database),80,443,false)

start_qa_server:
	$(call _start_server,$(qa_database),9001,9002,true)

start_qa_server_nhsrc:
	$(call _start_server,$(qa_database),80,443,true)

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

metabase_self_signed_key:
	keytool -genkey -keyalg RSA \
		-alias tomcat \
		-keystore metabase/keystore.jks \
		-storepass password \
		-validity 3650 \
		-keysize 2048