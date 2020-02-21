
function test11 {
  ./io install pg11; 
  ./io start pg11 -y -d demo; 
  ./io install oraclefdw-pg11     -d demo; ./io status
  ./io install mysqlfdw-pg11      -d demo; ./io status
  ./io install postgis-pg11       -d demo; ./io status
  ./io install repack-pg11        -d demo; ./io status
  ./io install pgtsql-pg11        -d demo; ./io status
  ./io install http-pg11          -d demo; ./io status
  ./io install timescaledb-pg11   -d demo; ./io status
  ./io install plprofiler-pg11    -d demo; ./io status
  ./io install hypopg-pg11        -d demo; ./io status
  ./io install orafce-pg11        -d demo; ./io status
  ./io install pglogical-pg11     -d demo; ./io status
  ./io install bulkload-pg11      -d demo; ./io status
  ./io install partman-pg11       -d demo; ./io status
  ./io install audit-pg11         -d demo; ./io status
  ./io install ddlx-pg11          -d demo; ./io status
  ./io install anon-pg11          -d demo; ./io status
  ##./io install presto_fdw-pg11    -d demo; ./io status
  ##./io install cassandra_fdw-pg11 -d demo; ./io status
}

function test12 {
  ./io install pg12; 
  ./io start pg12 -y -d demo;
  ./io install mysqlfdw-pg11      -d demo; ./io status
  ./io install postgis-pg12       -d demo; ./io status
  ./io install repack-pg12        -d demo; ./io status
  ./io install http-pg12          -d demo; ./io status
  ./io install plprofiler-pg12    -d demo; ./io status
  ./io install hypopg-pg12        -d demo; ./io status
  ./io install orafce-pg12        -d demo; ./io status
  ./io install pglogical-pg12     -d demo; ./io status
  ./io install bulkload-pg12      -d demo; ./io status
  ./io install partman-pg12       -d demo; ./io status
  ./io install audit-pg12         -d demo; ./io status
  ./io install ddlx-pg12          -d demo; ./io status
  ./io install anon-pg12          -d demo; ./io status
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

