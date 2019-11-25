
function test12 {
  source bp.sh
  ./dpg install pg12; ./dpg start pg12 -y -d demo; ./dpg status
}

function test11 {
  source bp.sh
  ./dpg install pg11; ./dpg start pg11 -y -d demo; ./dpg status
  ./dpg install pgtsql-pg11      -d demo; ./dpg status
  ./dpg install anon-pg11        -d demo; ./dpg status
  ./dpg install timescaledb-pg11 -d demo; ./dpg status
  ./dpg install plprofiler-pg11  -d demo; ./dpg status
  ./dpg install hypopg-pg11      -d demo; ./dpg status
  ./dpg install pglogical-pg11   -d demo; ./dpg status
}

function test10 {
  source bp.sh
  ./dpg install pg10; ./dpg start pg10 -y -d demo; ./dpg status
}

function test96 {
  source bp.sh
  ./dpg install pg96; ./dpg start pg96 -y -d demo; ./dpg status
}

function test95 {
  source bp.sh
  ./dpg install pg95; ./dpg start pg95 -y -d demo; ./dpg status
}

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

