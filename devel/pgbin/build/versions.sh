#!/bin/bash
# Set build version for pgBin and components.

pg12V="12.1"
pg12BuildV=3

pg11V="11.6"
pg11BuildV=3

pg10V="10.11"
pg10BuildV=3

## these are built w/ pgbin-linux.sh command line options"
bouncerV="1.12.0"
odbcV="12.00.0000"
backrestV="2.19"

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

athenaFullV=3.1
athenaShortV=
athenaBuildV=2

cassandraFDWFullVersion=3.1.4
cassandraFDWShortVersion=
cassandraFDWBuildV=1

orafceFullVersion=3.8.0
orafceShortVersion=
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

pgAuditFullVersion=1.3.1
pgAuditShortVersion=13
pgAuditBuildV=1

setUserFullVersion=1.6.2
setUserShortVersion=
setUserBuildV=1

plJavaFullVersion=1.5.2
plJavaShortVersion=
plJavaBuildV=1

plRFullVersion=8.3.0.17
plRShortVersion=83
plRBuildV=1

plV8FullVersion=1.4.8
plV8ShortVersion=14
plV8BuildV=1

pgTSQLFullV=3.0
pgTSQLShortV=
pgTSQLBuildV=1

bulkLoadFullVersion=3.1.15
bulkLoadShortVersion=
bulkLoadBuildV=1

pgLogicalFullV=2.3.0
pgLogicalShortV=
pgLogicalBuildV=1

pgSpockFullV=2.3.1
pgSpockShortV=
pgSpockBuildV=1

pgrepackFullVersion=1.4.4
pgrepackShortVersion=
pgrepackBuildV=1

pgPartmanFullVersion=4.2.0
pgPartmanShortVersion=
pgPartmanBuildV=1

hintplanFullVersion=1.3.2
hintplanShortVersion=
hintplanBuildV=1

timescaledbFullV=1.5.1
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
  OS=osx64
elif [[ $OS == "MINGW64_NT-6.1" ]]; then
  OS=win64
elif [[ $OS == "Linux" ]]; then
  grep "CPU architecture: 8" /proc/cpuinfo 1>/dev/null
  rc=$?
  if [ "$rc" == "0" ]; then
    OS=arm64
  else
    OS=linux64
  fi
else
  OS=linux64
fi
