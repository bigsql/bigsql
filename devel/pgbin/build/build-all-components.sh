
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

if [ "$1" == "odbc" ]; then
  build odbc $odbcFullV $2 odbc
fi

if [ "$1" == "backrest" ]; then
  build backrest $backrestFullV $2 backrest
fi

if [ "$1" == "agent" ]; then
  build agent $agentFullV $2 agent
fi

if [ "$1" == "pljava" ]; then
  build pljava $pljavaFullV $2 pljava
fi

if [ "$1" == "hintplan" ]; then
  build hintplan $hintplanFullV $2 hintplan
fi

if [ "$1" == "plv8" ]; then
  build plv8 $plv8FullV $2 plv8
fi

## prod ready across platforms #######################

if [ "$1" == "citus" ]  || [ "$1" == "all" ]; then
  build citus $citusFullV $2 citus
fi

if [ "$1" == "multicorn" ] || [ "$1" == "all" ]; then
  build multicorn $multicornFullV $2 multicorn 
fi

if [ "$1" == "cron" ] || [ "$1" == "all" ]; then
  build cron $cronFullV $2 cron
fi

if [ "$1" == "pldebugger" ] || [ "$1" == "all" ]; then
  build pldebugger $debugFullV $2 pldebugger
fi

if [ "$1" == "hivefdw" ] || [ "$1" == "all" ]; then
  build hivefdw $hivefdwFullV $2 hivefdw
fi

if [ "$1" == "cassandrafdw" ] || [ "$1" == "all" ]; then
  build cassandrafdw $cassFullV $2 cassandrafdw
fi

if [ "$1" == "repack" ] || [ "$1" == "all" ]; then
  build repack $repackFullV $2 repack
fi

if [ "$1" == "partman" ] || [ "$1" == "all" ]; then
  build partman $partmanFullV $2 partman
fi

if [ "$1" == "bulkload" ] || [ "$1" == "all" ]; then
  build bulkload $bulkloadFullV $2 bulkload
fi

if [ "$1" == "postgis" ] || [ "$1" == "all" ]; then
  if [ "$2" == "11" ]; then
    build postgis $postgisFull30V $2 postgis  
  else
    build postgis $postgisFull30V $2 postgis  
  fi
fi

if [ "$1" == "audit" ] || [ "$1" == "all" ]; then
  if [ "$2" == "11" ]; then
    build audit $auditFull11V $2 audit    
  else
    build audit $auditFull12V $2 audit    
  fi
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

if [ "$1" == "pglogical" ] || [ "$1" == "all" ]; then
  build pglogical $pgLogicalFullV $2 logical
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

if [ "$1" == "proctab" ] || [ "$1" == "all" ]; then
  build proctab $proctabFullV $2 proctab
fi

if [ "$1" == "pgtop" ] || [ "$1" == "all" ]; then
  build pgtop $pgtopFullV $2 pgtop
fi

if [ "$1" == "bouncer" ] || [ "$1" == "all" ]; then
  build bouncer $bouncerFullV $2 bouncer
fi

if [ "$1" == "mysqlfdw" ] || [ "$1" == "all" ]; then
  build mysqlfdw $mysqlfdwFullV $2 mysqlfdw
fi

if [ "$1" == "oraclefdw" ] || [ "$1" == "all" ]; then
  build oraclefdw $oraclefdwFullV $2 oraclefdw
fi

if [ "$1" == "tdsfdw" ] || [ "$1" == "all" ]; then
  build tdsfdw $tdsfdwFullV $2 tdsfdw
fi

exit 0
