
source env.sh

function test12 {
  source bp.sh
  ./$api install pg12; ./$api start pg12 -y -d demo; ./$api status
}

function test11 {
  source bp.sh
  ./$api install pg11; ./$api start pg11 -y -d demo; ./$api status
  ./$api install pgtsql-pg11      -d demo; ./$api status
  ./$api install anon-pg11        -d demo; ./$api status
  ./$api install timescaledb-pg11 -d demo; ./$api status
  ./$api install plprofiler-pg11  -d demo; ./$api status
  ./$api install hypopg-pg11      -d demo; ./$api status
  ./$api install pglogical-pg11   -d demo; ./$api status
}

function test10 {
  source bp.sh
  ./$api install pg10; ./$api start pg10 -y -d demo; ./$api status
}

function test96 {
  source bp.sh
  ./$api install pg96; ./$api start pg96 -y -d demo; ./$api status
}

function test95 {
  source bp.sh
  ./$api install pg95; ./$api start pg95 -y -d demo; ./$api status
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

