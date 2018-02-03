#!/bin/sh
#Facilities Assessment init script

HOME=/home/nhsrc/facilities-assessment-host

case $1 in
start)
        sleep 10
        cd ${HOME} && make start_metabase
        cd ${HOME} && make start_server_jss
        ;;
stop)
        cd ${HOME} && make stop_metabase
        cd ${HOME} && make stop_server_jss
        ;;
restart)
        stop
        sleep 5
        start
        ;;
esac
exit 0