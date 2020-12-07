jar_file=facilities-assessment-server-0.0.1-SNAPSHOT.jar

database := facilities_assessment
qa_database := facilities_assessment_qa
postgres_user := $(shell id -un)

help: ##		Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

define _set_host_dir
	$(eval host_dir := /home/app/$1/facilities-assessment-host)
endef

define _start_server
    cd app-servers && java -jar $(jar_file) --database=$1 --server.http.port=$2 --server.port=$3 --fa.secure=$4
endef

define _start_daemon
	cd app-servers && nohup java -jar $(jar_file) --database=$1 --server.http.port=$2 --server.port=$3 --fa.secure=$4
endef

define _deploy_bash
	ssh $1 "cd $(prod_dir) && git pull"
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

backup_db:
	pg_dump -Unhsrc -hlocalhost -d facilities_assessment > $(file)

backup_nhsrc_qa_db:
	pg_dump -Unhsrc -hlocalhost -d facilities_assessment_qa > ./backup/facilities_assessment_$(date +%a).sql

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

start_all_nhsrc: start_daemon start_metabase

metabase_self_signed_key:
	keytool -genkey -keyalg RSA \
		-alias tomcat \
		-keystore metabase/keystore.jks \
		-storepass password \
		-validity 3650 \
		-keysize 2048

deploy_bash_to_jss:
	$(call _deploy_bash,igunatmac)

# UPDATE HOST CODE
define _update_host
	$(call _set_host_dir,$1)
	ssh $2 "cd $(host_dir) && git pull"
endef

update_host_nhsrc_prod:
	$(call _update_post,,gunak-main)

update_host_nhsrc_qa:
	$(call _update_post,qa-server,gunak-other)


# RUN ADHOC COMMAND REMOTE SERVER
define _run_adhoc
	$(call _update_host,$1,$2)
	ssh $2 "cd $(host_dir) && $3"
endef

run_adhoc_nhsrc_qa:
	$(call _run_adhoc,qa-server,gunak-other,$(command))

deploy_metabase_nhsrc_prod:
	scp metabase/metabase.db.mv.db gunak-main:/home/app/facilities-assessment-host/metabase/