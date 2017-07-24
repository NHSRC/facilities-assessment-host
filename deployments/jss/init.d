#!/bin/sh
#Facilities Assessment init script

HOME=/home/nhsrc/facilities-assessment-host

case $1 in
start)
        cd ${HOME} && make start_metabase
        cd ${HOME} && make jss_cg_start_server
        cd ${HOME} && make jss_mp_start_server
        ;;
stop)
        cd ${HOME} && make stop_metabase
        cd ${HOME} && make jss_cg_stop_server
        cd ${HOME} && make jss_mp_stop_server
        ;;
restart)
        stop
        sleep 5
        start
        ;;
esac
exit 0