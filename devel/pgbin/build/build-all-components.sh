
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

## WIP across platforms ###########################

if [ "$1" == "presto_fdw" ]; then
  build presto_fdw $prestoFullV $2 presto_fdw
fi

if [ "$1" == "cassandra_fdw" ]; then
  build cassandra_fdw $cassFullV $2 cassandra_fdw
fi

if [ "$1" == "pljava" ]; then
  build pljava $pljavaFullV $2 pljava
fi

if [ "$1" == "hintplan" ]; then
  build hintplan $hintplanFullV $2 hintplan
fi

## prod ready across platforms #######################

if [ "$1" == "partman" ] || [ "$1" == "all" ]; then
  build partman $partmanFullV $2 partman
fi

if [ "$1" == "bulkload" ] || [ "$1" == "all" ]; then
  build bulkload $bulkloadFullV $2 bulkload
fi

if [ "$1" == "audit" ] || [ "$1" == "all" ]; then
  build audit $auditFullV $2 audit    
fi

if [ "$1" == "orafce" ] || [ "$1" == "all" ]; then
  build orafce $orafceFullV $2 orafce
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

if [ "$1" == "timescaledb" ] || [ "$1" == "all" ]; then
  build timescaledb $timescaledbFullV $2 timescale
fi

if [ "$1" == "spock" ] || [ "$1" == "all" ]; then
  build spock $spockFullV $2 logical
fi

if [ "$1" == "anon" ] || [ "$1" == "all" ]; then
  build anon $anonFullV $2 anon
fi

if [ "$1" == "ddlx" ] || [ "$1" == "all" ]; then
  build ddlx $ddlxFullV $2 ddlx
fi

if [ "$1" == "http" ] || [ "$1" == "all" ]; then
  build http $httpFullV $2 http
fi

exit 0
