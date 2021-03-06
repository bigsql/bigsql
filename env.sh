
bundle=pgsql
api=io
hubV=6.26

P13=13beta2-1
P12=12.3-1
P11=11.8-1
P10=10.13-1
P96=9.6.18-1
P95=9.5.22-1

dockerV=19
pgadminV=4

esfdwV=0.8.0
esV=7.8.0

odbcV=12.02-1
backrestV=2.27-1
bouncerV=1.14.0-1
pgtopV=3.7.0-1
proctabV=0.0.8.1-1
citusV=9.3.0-1

multicornV=1.4.0-1

orafceV=3.13.4-1
httpV=1.3.1-1
anonV=0.6.0-1
ddlxV=0.16-1
##omniV=2.17-1
hypoV=1.1.3-1
timescaleV=1.7.1-1
logicalV=2.3.2-1
##spockV=3.1.1-1
profV=4.1-1
bulkloadV=3.1.16-1
partmanV=4.4.0-1
repackV=1.4.5-1

audit11V=1.3.1-1
audit12V=1.4.0-1

postgis30V=3.0.1-1

tsqlV=3.0-1
pljavaV=1.5.5-1
debuggerV=2.0-1
agentV=4.0-1
cronV=1.2.0-1

mysqlfdwV=2.5.3-1

oraclefdwV=2.2.0-1
oracle_xeV=18c-1

tdsfdwV=2.0.1-1
sqlsvrV=2019-1

cstarV=3.11.6
cstarfdwV=3.1.5-1

hivefdwV=3.3.1-1
prestoV=0.233.1
hadoopV=2.10.0
#hiveV=3.1.2
#kafkaV=2.5.0

badgerV=11.2
ora2pgV=20.0

HUB="$PWD"
SRC="$HUB/src"
zipOut="off"
isENABLED=false

pg="postgres"

OS=`uname -s`
##if [[ $OS == "Darwin" ]]; then
##  OS=osx;
##  outDir=m64
##elif [[ $OS == "MINGW64_NT-6.1" ]]; then
##  OS=win;
##  outDir=w64
if [[ $OS == "Linux" ]]; then
  grep "CPU architecture:" /proc/cpuinfo 1>/dev/null
  rc=$?
  if [ "$rc" == "0" ]; then
    OS=arm
    outDir=a64
  else
    OS=amd;
    outDir=l64
  fi
else
  echo "ERROR: '$OS' is not supported"
  exit 1
fi

plat=$OS
