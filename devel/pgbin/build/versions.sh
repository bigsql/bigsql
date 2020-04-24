#!/bin/bash

pg12V="12.2"
pg12BuildV=4

pg11V="11.7"
pg11BuildV=4

pg10V="10.12"
pg10BuildV=4

pg96V="9.6.17"
pg96BuildV=4

pg95V="9.5.21"
pg95BuildV=4

##odbcV=12.01.0000
##backrestV=2.24
##agentV=4.0.0

bouncerFullV=1.12.0
bouncerShortV=
bouncerBuildV=1

multicornFullV=1.4.0
multicornShortV=
multicornBuildV=1

pgtopFullV=3.7.0
pgtopShortV=
pgtopBuildV=1

proctabFullV=0.0.8.1
proctabShortV=
proctabBuildV=1

httpFullV=1.3.1
httpShortV=
httpBuildV=1

hypopgFullV=1.1.3
hypopgShortV=
hypopgBuildV=1

#postgisFull25V=2.5.4
postgisFull30V=3.0.1
postgisShortV=
postgisBuildV=1

backgroundFullVersion=1.0
backgroundShortVersion=1
backgroundBuildV=1

prestoFullV=0.229
prestoShortV=
prestoBuildV=1

cassFullV=3.1.5
cassShortV=
cassBuildV=1

orafceFullV=3.11.1
orafceShortV=
orafceBuildV=1

oraclefdwFullV=2.2.0
oraclefdwShortV=
oraclefdwBuildV=1

tdsfdwFullV=2.0.1
tdsfdwShortV=
tdsfdwBuildV=1

mysqlfdwFullV=2.5.3
mysqlfdwShortV=
mysqlfdwBuildV=1

hivefdwFullV=3.3.1
hivefdwShortV=
hivefdwBuildV=1

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

plv8FullV=2.3.14
plv8ShortV=
plv8BuildV=1

debugFullV=2.0
debugShortV=
debugBuildV=1

fdFullV=1.1.0
fdShortV=
fdBuildV=1

anonFullV=0.6.0
anonShortV=
anonBuildV=1

ddlxFullV=0.16
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

spockFullV=3.1.1
spockShortV=
spockBuildV=1

pgLogicalFullV=2.3.1
pgLogicalShortV=
pgLogicalBuildV=1

repackFullV=1.4.5
repackShortV=
repackBuildV=1

partmanFullV=4.3.1
partmanShortV=
partmanBuildV=1

hintplanFullV=1.3.4
hintplanShortV=
hintplanBuildV=1

timescaledbFullV=1.7.0
timescaledbShortV=
timescaledbBuildV=1

cronFullV=1.2.0
cronShortV=
cronBuildV=1

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
