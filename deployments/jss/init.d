#!/bin/sh
#Facilities Assessment init script

HOME=/home/nhsrc/facilities-assessment-host

case $1 in
start)
        cd ${HOME} && sh metabase/run.sh
        cd ${HOME} && sh app-servers/cg/run.sh
        cd ${HOME} && sh app-servers/mp/run.sh
        ;;
stop)
        pkill -f 'java -jar metabase.jar'
        pkill -f 'database=new_facilitiess_assessment_mp'
        pkill -f 'database=facilities_assessment_cg'
        ;;
restart)
        stop
        sleep 5
        start
        ;;
esac
exit 0