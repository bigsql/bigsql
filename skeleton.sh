
function test12 {
  ./apg install pg12; ./apg start pg12 -y -d demo; ./apg status
}

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
  ./apg install athena_fdw-pg11    -d demo; ./apg status
  ./apg install cassandra_fdw-pg11 -d demo; ./apg status
}

function test10 {
  ./apg install pg10; ./apg start pg10 -y -d demo; ./apg status
}

function test96 {
  ./apg install pg96; ./apg start pg96 -y -d demo; ./apg status
}

function test95 {
  ./apg install pg95; ./apg start pg95 -y -d demo; ./apg status
}

cd ../..

if [ "$1" == "12" ]; then
  test12
  exit 0
fi
if [ "$1" == "11" ]; then
  test11
  exit 0
fi
if [ "$1" == "10" ]; then
  test10
  exit 0
fi
if [ "$1" == "96" ]; then
  test96
  exit 0
fi
if [ "$1" == "95" ]; then
  test95
  exit 0
fi

echo "ERROR: Invalid parm.  Must be 95 thru 12."
exit 1

