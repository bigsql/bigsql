
function test11 {
  ./apg install pg11; ./apg start pg11 -y -d demo; ./apg status
  ./apg install pgtsql-pg11        -d demo; ./apg status
  ./apg install anon-pg11          -d demo; ./apg status
  ./apg install http-pg11          -d demo; ./apg status
  ./apg install timescaledb-pg11   -d demo; ./apg status
  ./apg install plprofiler-pg11    -d demo; ./apg status
  ./apg install hypopg-pg11        -d demo; ./apg status
  ./apg install orafce-pg11        -d demo; ./apg status
  ./apg install pglogical-pg11     -d demo; ./apg status
  ./apg install bulkload-pg11      -d demo; ./apg status
  ./apg install partman-pg11       -d demo; ./apg status
  ./apg install audit-pg11         -d demo; ./apg status
  ##./apg install presto_fdw-pg11    -d demo; ./apg status
  ##./apg install cassandra_fdw-pg11 -d demo; ./apg status
}

cd ../..

if [ "$1" == "11" ] || [ "$1" == "" ]; then
  test11
  exit 0
fi

echo "ERROR: Invalid parm."
exit 1

