
function testAll {
  ./io install cron-pg$1          -d demo
  ./io install repack-pg$1        -d demo
  ./io install http-pg$1          -d demo
  ./io install plprofiler-pg$1    -d demo
  ./io install hypopg-pg$1        -d demo
  ./io install orafce-pg$1        -d demo
  ./io install pglogical-pg$1     -d demo
  ./io install partman-pg$1       -d demo
  ./io install audit-pg$1         -d demo
  ./io install ddlx-pg$1          -d demo
  ./io install anon-pg$1          -d demo
  ./io install mysqlfdw-pg$1      -d demo
  ./io install debugger-pg$1      -d demo
  if [ ! `arch` == "aarch64" ]; then
    ./io install bulkload-pg$1    -d demo
    ./io install tdsfdw-pg$1      -d demo
    ./io install oraclefdw-pg$1   -d demo
    ./io install postgis-pg$1     -d demo
    ##./io install hive_fdw-pg$1  -d demo
    ##./io install cassandra_fdw-pg$1 -d demo
  fi
}

function test11 {
  ./io install pg11; 
  ./io start pg11 -y -d demo; 
  ./io install pgtsql-pg11        -d demo
  if [ ! `uname` == "Darwin" ]; then
    ./io install timescaledb-pg11   -d demo
  fi
}

function test12 {
  ./io install pg12; 
  ./io start pg12 -y -d demo;
}

cd ../..

if [ "$1" == "11" ]; then
  test11
  testAll 11
  exit 0
fi

if [ "$1" == "12" ]; then
  test12
  testAll 12
  exit 0
fi

echo "ERROR: Invalid parm."
exit 1

