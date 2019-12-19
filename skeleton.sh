
function test12 {
  ./apg install pg12; ./apg start pg12 -y -d demo; ./apg status
}

function test11 {
  ./apg install pg11; ./apg start pg11 -y -d demo; ./apg status
  ./apg install pgtsql-pg11      -d demo; ./apg status
  ./apg install anon-pg11        -d demo; ./apg status
  ./apg install http-pg11        -d demo; ./apg status
  ./apg install timescaledb-pg11 -d demo; ./apg status
  ./apg install plprofiler-pg11  -d demo; ./apg status
  ./apg install hypopg-pg11      -d demo; ./apg status
  ./apg install pglogical2-pg11  -d demo; ./apg status
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

if [ "$1" == "12" ] || [ "$1" == "all" ]; then
  test12
fi
if [ "$1" == "11" ] || [ "$1" == "all" ]; then
  test11
fi
if [ "$1" == "10" ] || [ "$1" == "all" ]; then
  test10
fi
if [ "$1" == "96" ] || [ "$1" == "all" ]; then
  test96
fi
if [ "$1" == "95" ] || [ "$1" == "all" ]; then
  test95
fi

echo ""
echo "Goodbye!"
exit 0

