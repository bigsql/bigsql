
#---------------------------------------------#
#      Copyright (c) 2013-2020 BigSQL         #
#---------------------------------------------#

bundle=bigsql
api=apg
hubV=6.0

P12=12.2-1
P11=11.7-1
P10=10.12-1

orafceV=3.8.0-1
httpV=1.3.1-1
anonV=0.5.0-1
ddlxV=0.15-1
omniV=2.17-1
hypoV=1.1.3-1
timescaleV=1.6.0-1
spockV=2.2.3-1
profV=4.1-1
bulkloadV=3.1.16-1
partmanV=4.3.0-1
auditV=1.3.1-1

cstarV=3.1.5-1

presV=0.229
prestoV=3.2.1-1

tsqlV=3.0-1
patroniV=1.6.3

minikubeV=1.6.2
dockerV=19.03.5

mysqlfdwV=2.0.5-1

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
