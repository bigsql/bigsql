#!/bin/bash

pg12V="12.2"
pg12BuildV=1

pg11V="11.7"
pg11BuildV=1

pg10V="10.12"
pg10BuildV=1

bouncerV="1.12.0"
odbcV="12.01.0000"
backrestV="2.23"

httpFullV=1.3.1
httpShortV=
httpBuildV=1

hypopgFullV=1.1.3
hypopgShortV=
hypopgBuildV=1

walgFullV=0.2.9
walgShortV=
walgBuildV=1


postgisFullVersion=2.5.3
postgisShortVersion=25
postgisBuildV=1

backgroundFullVersion=1.0
backgroundShortVersion=1
backgroundBuildV=1

prestoFullV=3.2.1
prestoShortV=
prestoBuildV=1

cassFullV=3.1.5
cassShortV=
cassBuildV=1

orafceFullV=3.8.0
orafceShortV=
orafceBuildV=1

oFDWFullVersion=2.2.0
oFDWShortVersion=
oFDWBuildV=1

tdsFDWFullVersion=1.0.7
tdsFDWShortVersion=1
tdsFDWBuildV=1

mysqlFDWFullVersion=2.5.0
mysqlFDWShortVersion=2
mysqlFDWBuildV=1

pgmpFullVersion=1.2.2
pgmpShortVersion=
pgmpBuildV=1

parquetFDWFullVersion=0.1.3
parquetFDWShortVersion=
parquetFDWBuildV=1

cstoreFDWFullVersion=1.6.2
cstoreFDWShortVersion=
cstoreFDWBuildV=1

plProfilerFullVersion=4.1
plProfilerShortVersion=
plprofilerBuildV=1

debugFullV=1.1
debugShortV=
debugBuildV=3

fdFullV=1.1.0
fdShortV=
fdBuildV=1

anonFullV=0.5.0
anonShortV=
anonBuildV=1

ddlxFullV=0.15
ddlxShortV=
ddlxBuildV=1

auditFull11V=1.3.1
auditFull12V=1.4.0
auditShortV=
auditBuildV=1

setUserFullVersion=1.6.2
setUserShortVersion=
setUserBuildV=1

pljavaFullV=1.5.5
pljavaShortV=
pljavaBuildV=1

plRFullVersion=8.3.0.17
plRShortVersion=83
plRBuildV=1

plV8FullVersion=1.4.8
plV8ShortVersion=14
plV8BuildV=1

pgTSQLFullV=3.0
pgTSQLShortV=
pgTSQLBuildV=1

bulkloadFullV=3.1.16
bulkloadShortV=
bulkloadBuildV=1

spockFullV=2.2.3
spockShortV=
spockBuildV=1

pgrepackFullVersion=1.4.4
pgrepackShortVersion=
pgrepackBuildV=1

partmanFullV=4.3.0
partmanShortV=
partmanBuildV=1

hintplanFullV=1.3.4
hintplanShortV=
hintplanBuildV=1

timescaledbFullV=1.6.0
timescaledbShortV=
timescaledbBuildV=1

cronFullVersion=1.1.3
cronShortVersion=
cronBuildV=1

pgAgentFullVersion=4.0.0
pgAgentShortVersion= 
pgAgentBuildV=1

OS=`uname -s`
if [[ $OS == "Darwin" ]]; then
  OS=osx
elif [[ $OS == "MINGW64_NT-6.1" ]]; then
  OS=win
elif [[ $OS == "Linux" ]]; then
  grep "CPU architecture: 8" /proc/cpuinfo 1>/dev/null
  rc=$?
  if [ "$rc" == "0" ]; then
    OS=arm
  else
    OS=amd
  fi
else
  OS=amd
fi
