
#---------------------------------------------#
#      Copyright (c) 2013-2020 BigSQL         #
#---------------------------------------------#

bundle=bigsql
api=apg
hubV=5.1.1

P12=12.1-4
P11=11.6-4
P10=10.11-4
P96=9.6.16-4
P95=9.5.20-4
P94=9.4.25-4
P93=9.3.27-4

anonV=0.5.0-1
ddlxV=0.15-1
omniV=2.16-1
hypoV=1.1.3-1
timescaleV=1.5.1-1
logicalV=2.2.2-1
logical2V=2.3.1beta1-1
profV=4.1-1
cstarV=3.1.4-1
athenafdwV=3.1-2
tsqlV=3.0-1
patroniV=1.6.3

minikubeV=1.6.0
dockerV=19.03

mysqlfdwV=2.0.5-1

HUB="$PWD"
SRC="$HUB/src"
zipOut="off"
isENABLED=false

pg="postgres"

OS=`uname -s`
if [[ $OS == "Darwin" ]]; then
  OS=osx64;
  outDir=m64
elif [[ $OS == "MINGW64_NT-6.1" ]]; then
  OS=win64;
  outDir=w64
elif [[ $OS == "Linux" ]]; then
  grep "CPU architecture:" /proc/cpuinfo 1>/dev/null
  rc=$?
  if [ "$rc" == "0" ]; then
    OS=arm64
    outDir=a64
  else
    OS=linux64;
    outDir=l64
  fi
fi

plat=$OS
