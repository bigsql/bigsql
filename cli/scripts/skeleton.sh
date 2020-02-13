
function test11 {
  ./apg install pg11; 
  ./apg start pg11 -y -d demo; 
  ./apg install pgtsql-pg11        -d demo; ./apg status
  ./apg install http-pg11          -d demo; ./apg status
  ./apg install timescaledb-pg11   -d demo; ./apg status
  ./apg install plprofiler-pg11    -d demo; ./apg status
  ./apg install hypopg-pg11        -d demo; ./apg status
  ./apg install orafce-pg11        -d demo; ./apg status
  ./apg install spock-pg11         -d demo; ./apg status
  ./apg install bulkload-pg11      -d demo; ./apg status
  ./apg install partman-pg11       -d demo; ./apg status
  ./apg install audit-pg11         -d demo; ./apg status
  ./apg install ddlx-pg11          -d demo; ./apg status
  ./apg install anon-pg11          -d demo; ./apg status
  ##./apg install presto_fdw-pg11    -d demo; ./apg status
  ##./apg install cassandra_fdw-pg11 -d demo; ./apg status
}

function test12 {
  ./apg install pg12; 
  ./apg start pg12 -y -d demo;
  ./apg install http-pg12          -d demo; ./apg status
  ./apg install plprofiler-pg12    -d demo; ./apg status
  ./apg install hypopg-pg12        -d demo; ./apg status
  ./apg install orafce-pg12        -d demo; ./apg status
  ./apg install bulkload-pg12      -d demo; ./apg status
  ./apg install partman-pg12       -d demo; ./apg status
  ./apg install audit-pg12         -d demo; ./apg status
  ./apg install ddlx-pg12          -d demo; ./apg status
  ./apg install anon-pg12          -d demo; ./apg status
}

cd ../..

if [ "$1" == "11" ]; then
  test11
  exit 0
fi

if [ "$1" == "12" ]; then
  test12
  exit 0
fi

echo "ERROR: Invalid parm."
exit 1

