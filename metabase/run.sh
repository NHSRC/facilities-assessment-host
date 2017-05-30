SCRIPT_DIR=$(dirname "$0")
nohup java -jar metabase.jar >> ${SCRIPT_DIR}/log/metabase.log 2>&1 &