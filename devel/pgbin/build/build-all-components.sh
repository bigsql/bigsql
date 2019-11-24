
source versions.sh


function build {
  pgbin="--with-pgbin /opt/pgcomponent/pg$pgV"
  pgver="--with-pgver $3"
  src="$SRC/$1-$2.tar.gz"
  echo ""
  echo "###################################"
  cmd="./build-component.sh --build-$1 $src $pgbin $pgver $copyBin $4"
  ## echo "cmd=$cmd"
  $cmd
  rc=$?
}


################### MAINLINE #####################

pgV="$2"
copyBin="$3"
if [ "$copyBin" == "" ]; then
  copyBin="--no-copy-bin"
fi
if [ ! "$pgV"  == "11" ] && [ ! "$pgV"  == "12" ]; then
  echo  "ERROR: second parm must be 11 or 12"
  exit 1
fi

if [ "$1" == "oraclefdw" ] || [ "$1" == "all" ]; then
  build oraclefdw $oFDWFullVersion $2 oraclefdw 
fi

if [ "$1" == "orafce" ] || [ "$1" == "all" ]; then
  build orafce $orafceFullVersion $2 orafce
fi

if [ "$1" == "hypopg" ] || [ "$1" == "all" ]; then
  build hypopg $hypopgFullV $2 hypopg
fi

if [ "$1" == "pgtsql" ] || [ "$1" == "all" ]; then
  build pgtsql $pgTSQLFullV $2 tsql
fi

if [ "$1" == "plprofiler" ] || [ "$1" == "all" ]; then
  build plprofiler $plProfilerFullVersion $2 profiler
fi

##if [ "$1" == "cassandra_fdw" ] || [ "$1" == "all" ]; then
##  build cassandra_fdw $cassandraFDWFullVersion
##fi

if [ "$1" == "timescaledb" ] || [ "$1" == "all" ]; then
  build timescaledb $timescaledbFullV $2 timescale
fi

if [ "$1" == "pglogical" ] || [ "$1" == "all" ]; then
  build pglogical $pgLogicalFullV $2 logical
fi

if [ "$1" == "anon" ] || [ "$1" == "all" ]; then
  build anon $anonFullV $2 anon
fi

if [ "$1" == "ddlx" ] || [ "$1" == "all" ]; then
  build ddlx $ddlxFullV $2 ddlx
fi

exit 0
