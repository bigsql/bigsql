
bundle=pgsql
api=io
hubV=6.1

P12=12.2-2
P11=11.7-2
P10=10.12-2
P96=9.6.17-2
P95=9.5.21-2
P94=9.4.26-2

orafceV=3.9.0-1
httpV=1.3.1-1
anonV=0.5.0-1
ddlxV=0.16-1
omniV=2.17-1
hypoV=1.1.3-1
timescaleV=1.6.0-1
logicalV=2.3.0-1
profV=4.1-1
bulkloadV=3.1.16-1
partmanV=4.3.0-1
repackV=1.4.5-1

audit11V=1.3.1-1
audit12V=1.4.0-1

postgis25V=2.5.3-1
postgis30V=3.0.1-1

cstarV=3.1.5-1

prestoV=0.229

tsqlV=3.0-1
pljavaV=1.5.5-1
debuggerV=2.0-1
agentV=4.0-1

mysqlfdwV=2.5.3-1
oraclefdwV=2.2.0-1
tdsfdwV=2.0.1-1
cstarfdwV=3.1.5-1
hivefdwV=3.3.1-1

badgerV=11.1
ora2pgV=20.0

HUB="$PWD"
SRC="$HUB/src"
zipOut="off"
isENABLED=false

pg="postgres"

OS=`uname -s`
if [[ $OS == "Darwin" ]]; then
  OS=osx;
  outDir=m64
elif [[ $OS == "MINGW64_NT-6.1" ]]; then
  OS=win;
  outDir=w64
elif [[ $OS == "Linux" ]]; then
  grep "CPU architecture:" /proc/cpuinfo 1>/dev/null
  rc=$?
  if [ "$rc" == "0" ]; then
    OS=arm
    outDir=a64
  else
    OS=amd;
    outDir=l64
  fi
fi

plat=$OS
