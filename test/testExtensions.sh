
function install {
  if [ "$pComp" == "all" ] || [ "$1" == "$pComp" ]; then
    echo ""
    echo "# install $1 $2 $3"
    ./pgc install $1 $2 $3
    sleep 2
    isNothing="False"
  fi
}

########### MAINLINE #################

isNothing="True"
pComp="$1"

echo ""
echo "# pComp = '$pComp'"

cd ..
. ./bp.sh

./pgc install pg11
./pgc start pg11 -y -d demo
sleep 2

install pglogical -d demo
install timescaledb -d demo
install hypopg -d demo
install plprofiler -d demo
install pldebugger -d demo
install pgaudit -d demo
install set_user -d demo
install athena_fdw -d demo
install bulkload -d demo
install cron -d postgres
install hypopg -d demo
install orafce -d demo
install pgmp -d demo
install pgpartman4 -d demo
install cassandra_fdw -d demo
install cstore_fdw -d demo
install postgis25 -d demo
install repack14 -d demo
#install pljava -d demo
#install pgagent -d demo
#install oracle_fdw -d demo
#install mysql_fdw -d demo

if [ "$isNothing" == "True" ]; then
  echo "Nothing to do!"
  exit 1
fi

exit 0
