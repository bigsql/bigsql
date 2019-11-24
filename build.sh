#!/bin/bash 

#----------------------------------------------------------------#
#             Copyright (c) 2015-2019 BigSQL                     #
#----------------------------------------------------------------#

source env.sh
if [ "x$REPO" == "x" ]; then
  repo="http://localhost"
else
  repo="$REPO"
fi

bundle="bigsql"

`python --version  > /dev/null 2>&1`
rc=$?
if [ $rc == 0 ];then
  PYTHON=python
else
  PYTHON=python3
fi

if [ "$OUT" == "" ] || [ "$APG" == "" ]; then
  echo "ERROR: Environment is not set"
  exit 1
fi


printUsageMessage () {
  echo "#--------------------------------------------------------#"
  echo "# -p $P12  $P11  $P10  cassandra_fdw-$cstarV"
  echo "#    timescale-$timescaleV  athenafdw-$athenafdwV"
  echo "#    anon-$anonV  ddlx-$ddlxV  hypopg-$hypoV"
  echo "#    plprofiler-$profV  pgtsql-$tsqlV  patroni-$patroniV"
  echo "# -B pip-$pipV  salt-$saltV"
  echo "# -b hub-$hubV"
  echo "#--------------------------------------------------------#"
  echo "# ./build.sh -X l64 -c $bundle -N $P11 -p 11 -b"
  echo "# ./build.sh -X l64 -c $bundle -N $P12 -p 12 -b"
  echo "#---------------------------------------------------#"
}


fatalError () {
  echo "FATAL ERROR!  $1"
  if [ "$2" == "u" ]; then
    printUsageMessage
  fi
  echo
  exit 1
}


echoCmd () {
  echo "# $1"
  checkCmd "$1"
}


checkCmd () {
  $1
  rc=`echo $?`
  if [ ! "$rc" == "0" ]; then
    fatalError "Stopping Script"
  fi
}


myReplace () {
  oldVal="$1"
  newVal="$2"
  fileName="$3"

  if [ ! -f "$fileName" ]; then
    echo "ERROR: Invalid file name - $fileName"
    return 1
  fi

  osName=`uname`
  sed -i "s#$oldVal#$newVal#g" "$fileName"
}

## write Setting row to SETTINGS config table
writeSettRow() {
  pSection="$1"
  pKey="$2"
  pValue="$3"
  pVerbose="$4"
  dbLocal="$out/conf/apg_local.db"
  cmdPy="$PYTHON $HUB/src/conf/insert_setting.py"
  $cmdPy "$dbLocal"  "$pSection" "$pKey" "$pValue"
  if [ "$pVerbose" == "-v" ]; then
    echo "$pKey = $pValue"
  fi
}


## write Component row to COMPONENTS config table
writeCompRow() {
  pComp="$1"
  pProj="$2"
  pVer="$3"
  pPlat="$4"
  pPort="$5"
  pStatus="$6"
  pStageDir="$7"

  if [ ! "$pStageDir" == "nil" ]; then
    echo "#"
  fi

  if [ "$pStatus" == "NotInstalled" ] && [ "$isENABLED" == "true" ]; then
    pStatus="Enabled"
  fi

  if [ ! "$pStatus" == "Enabled" ]; then
    return
  fi

  dbLocal="$out/conf/apg_local.db"
  cmdPy="$PYTHON $HUB/src/conf/insert_component.py"
  $cmdPy "$dbLocal"  "$pComp" "$pProj" "$pVer" "$pPlat" "$pPort" "$pStatus"
}


initDir () {
  pComponent=$1
  pProject=$2
  pPreNum=$3
  pExt=$4
  pStageSubDir=$5
  pStatus="$6"
  pPort="$7"
  pParent="$8"

  if [ "$pStatus" == "" ]; then
    pStatus="NotInstalled"
  fi

  if [ "$pStatus" == "NotInstalled" ] && [ "$isENABLED" == "true" ]; then
    pStatus="Enabled"
  fi

  if [ "$pStatus" == "NotInstalled" ] && [ ! "$zipOut" == "off" ]; then
     if [ "$pExt" == "" ]; then
       fileNm=$OUT/$pComponent-$pPreNum.tar.bz2
     else
       fileNm=$OUT/$pComponent-$pPreNum-$pExt.tar.bz2
     fi
     if [ -f "$fileNm" ]; then
       return
     fi
  fi

  osName=`uname`
  if [ "$osName" == "Darwin" ]; then
    cpCmd="cp -r"
  else
    cpCmd="cp -Lr"
  fi

  writeCompRow "$pComponent" "$pProject" "$pPreNum" "$pExt" "$pPort" "$pStatus" "nil"

  if [ "$pExt" == "" ]; then
    pCompNum=$pPreNum
  else
    pCompNum=$pPreNum-$pExt
  fi
  myOrigDir=$pComponent-$pCompNum
  myOrigFile=$myOrigDir.tar.bz2

  if [ "$pStageSubDir" == "nil" ]; then
    thisDir=$IN
  else
    thisDir=$IN/$pStageSubDir
  fi
 
  if [ ! -d "$thisDir/$myOrigDir" ]; then
    origFile=$thisDir/$myOrigFile
    if [ -f $origFile ]; then
      checkCmd "tar -xf $origFile"      
      ## pbzip2 -dc $origFile | tar x
      rc=`echo $?`
      if [ $rc -ne 0 ]; then
        fatalError "can't unzip"
      fi
    else
      fatalError "Missing input file: $origFile"
    fi
  fi

  if [ "$pParent" == "nil" ]; then
     myNewDir=$pComponent
     mv $myOrigDir $myNewDir
  fi

  if [ -d "$SRC/$pComponent" ]; then
    $cpCmd $SRC/$pComponent/*  $myNewDir/.
  fi

  copy-pgXX "pglogical"
  copy-pgXX "pgspock"
  copy-pgXX "timescaledb"
  copy-pgXX "anon"
  copy-pgXX "cassandra_fdw"
  copy-pgXX "athena_fdw"
  copy-pgXX "plprofiler"
  copy-pgXX "pgtsql"
  copy-pgXX "hypopg"

  if [ -f $myNewDir/LICENSE.TXT ]; then
    mv $myNewDir/LICENSE.TXT $myNewDir/$pComponent-LICENSE.TXT
  fi

  if [ -f $myNewDir/src.tar.gz ]; then
    mv $myNewDir/src.tar.gz $myNewDir/$pComponent-src.tar.gz
  fi

  rm -f $myNewDir/*INSTALL*
  rm -f $myNewDir/logs/*

  rm -rf $myNewDir/manual

  rm -rf $myNewdir/build*
  rm -rf $myNewDir/.git*
}


copy-pgXX () {
  if [ "$pComponent" == "$1-pg$pgM" ]; then
    checkCmd "cp -r $SRC/$1-pgXX/* $myNewDir/."

    checkCmd "mv $myNewDir/install-$1-pgXX.py $myNewDir/install-$1-pg$pgM.py"
    myReplace "pgXX" "pg$pgM" "$myNewDir/install-$1-pg$pgM.py"

    checkCmd "mv $myNewDir/remove-$1-pgXX.py $myNewDir/remove-$1-pg$pgM.py"
    myReplace "pgXX" "pg$pgM" "$myNewDir/remove-$1-pg$pgM.py"
  fi
}


zipDir () {
  pComponent="$1"
  pNum="$2"
  pPlat="$3"
  pStatus="$4"

  if [ "$zipOut" == "off" ]; then
    return
  fi

  if [ "$pPlat" == "" ]; then
    baseName=$pComponent-$pNum
  else
    baseName=$pComponent-$pNum-$pPlat
  fi
  myTarball=$baseName.tar.bz2
  myChecksum=$myTarball.sha512

  if [ ! -f "$OUT/$myTarball" ] && [ ! -f "$OUT/$myChecksum" ]; then
    echo "COMPONENT = '$baseName' '$pStatus'"
    options=""
    if [ "$osName" == "Linux" ]; then
      options="--owner=0 --group=0"
    fi
    checkCmd "tar $options -cjf $myTarball $pComponent"
    writeFileChecksum $myTarball
  fi

  if [ "$pStatus"  == "NotInstalled" ]; then
    rm -rf $pComponent
  fi
}


## move file to output directory and write a checksum file with it
writeFileChecksum () {
  pFile=$1
  sha512=`openssl dgst -sha512 $pFile | awk '{print $2}'`
  checkCmd "mv $pFile $OUT/."
  echo "$sha512  $pFile" > $OUT/$pFile.sha512
}


finalizeOutput () {
  writeCompRow "hub"  "hub" "$hubV" "" "0" "Enabled" "nil"
  checkCmd "cp -r $SRC/hub ."
  if [ ! -d "hub/scripts" ]; then
    checkCmd "mkdir hub/scripts"
  fi
  checkCmd "cp -r $CLI/* hub/scripts/."
  checkCmd "cp -r $CLI/../doc hub/."
  checkCmd "cp $CLI/../README.md  hub/doc/."
  checkCmd "rm -f hub/scripts/*.pyc"
  zipDir "hub" "$hubV" "" "Enabled"

  checkCmd "cp conf/$verSQL ."
  writeFileChecksum "$verSQL"

  checkCmd "cd $HUB"

  if [ ! "$zipOut" == "off" ] &&  [ ! "$zipOut" == "" ]; then
    zipExtension="tar.bz2"
    options=""
    options="--owner=0 --group=0"
    zipCommand="tar $options -cjf"
    zipCompressProg=""

    zipOutFile="$zipOut-$NUM-$plat.$zipExtension"
    if [ "$plat" == "posix" ]; then
      zipOutFile="$zipOut-$NUM.$zipExtension"
    fi

    if [ ! -f $OUT/$zipOutFile ]; then
      echo "OUTFILE = '$zipOutFile'"
      checkCmd "cd out"
      checkCmd "mv $outDir $bundle"
      outDir=$bundle
      checkCmd "$zipCommand $zipOutFile $zipCompressProg $outDir"
      writeFileChecksum "$zipOutFile"
      checkCmd "cd .."
    fi
  fi
}


copyReplaceScript() {
  script=$1
  comp=$2
  checkCmd "cp $pg9X/$script-pg9X.py  $newDir/$script-$comp.py"
  myReplace "pg9X" "$comp" "$comp/$script-$comp.py"
}


supplementalPG () {
  newDir=$1
  pg9X=$SRC/pg9X

  checkCmd "mkdir $newDir/init"

  copyReplaceScript "install"  "$newDir"
  copyReplaceScript "start"    "$newDir"
  copyReplaceScript "stop"     "$newDir"
  copyReplaceScript "init"     "$newDir"
  copyReplaceScript "config"   "$newDir"
  copyReplaceScript "reload"   "$newDir"
  copyReplaceScript "activity" "$newDir"
  copyReplaceScript "remove"   "$newDir"

  checkCmd "cp $pg9X/run-pgctl.py $newDir/"
  myReplace "pg9X" "$comp" "$newDir/run-pgctl.py"

  checkCmd "cp $pg9X/pg_hba.conf.nix      $newDir/init/pg_hba.conf"

  checkCmd "chmod 755 $newDir/bin/*"
  chmod 755 $newDir/lib/* 2>/dev/null
}


initC () {
  status="$6"
  if [ "$status" == "" ]; then
    status="NotInstalled"
  fi
  initDir "$1" "$2" "$3" "$4" "$5" "$status" "$7" "$8"
  zipDir "$1" "$3" "$4" "$status"
}


initPG () {
  if [ "$pgM" == "10" ]; then
    pgV=$P10
  elif [ "$pgM" == "11" ]; then
    pgV=$P11
  elif [ "$pgM" == "12" ]; then
    pgV=$P12
  else
    echo "ERROR: Invalid PG version '$pgM'"
    exit 1
  fi

  if [ "$outDir" == "a64" ]; then
    outPlat="arm64"
  else
    outPlat="linux64"
  fi

  initDir "pg$pgM" "pg" "$pgV" "$outPlat" "postgres/pg$pgM" "Enabled" "5432" "nil"
  supplementalPG "pg$pgM"
  zipDir "pg$pgM" "$pgV" "$outPlat" "Enabled"

  writeSettRow "GLOBAL" "STAGE" "prod"
  writeSettRow "GLOBAL" "AUTOSTART" "off"

  initC "patroni" "patroni" "$patroniV"  "" "postgres/patroni" "" "" "nil"

  if [ "$pgM" == "12" ]; then 
    initC "plprofiler-pg$pgM" "plprofiler" "$profV" "$outPlat" "postgres/profiler" "" "" "nil"
  fi

  if [ "$pgM" == "11" ]; then 
    initC "hypopg-pg$pgM" "hypopg" "$hypoV" "$outPlat" "postgres/hypopg" "" "" "nil"
    initC "pglogical-pg$pgM" "pglogical" "$logicalV" "$outPlat" "postgres/logical" "" "" "nil"
    initC "timescaledb-pg$pgM" "timescaledb" "$timescaleV"  "$outPlat" "postgres/timescale" "" "" "nil"
    initC "plprofiler-pg$pgM" "plprofiler" "$profV" "$outPlat" "postgres/profiler" "" "" "nil"
    initC "pgtsql-pg$pgM" "pgtsql" "$tsqlV" "$outPlat" "postgres/tsql" "" "" "nil"
    initC "ddlx-pg$pgM" "ddlx" "$ddlxV" "$outPlat" "postgres/ddlx" "" "" "nil"
    initC "anon-pg$pgM" "anon" "$anonV" "$outPlat" "postgres/anon" "" "" "nil"

    ##initC "pgspock-pg$pgM" "pgspock" "$spockV" "$plat" "postgres/spock" "" "" "nil"
    ##initC "athena_fdw-pg$pgM" "athena_fdw" "$athenafdwV" "$plat" "postgres/athenafdw" "" "" "nil"
    ##initC "cassandra_fdw-pg$pgM" "cassandra_fdw" "$cstarV" "$plat" "postgres/cstar" "" "" "nil"
  fi
}


setupOutdir () {
  rm -rf out
  mkdir out
  cd out
  mkdir $outDir
  cd $outDir
  out="$PWD"
  mkdir conf
  mkdir conf/cache
  conf="$SRC/conf"

  cp $conf/apg_local.db  conf/.
  cp $conf/versions.sql  conf/.
  sqlite3 conf/apg_local.db < conf/versions.sql
}


###############################    MAINLINE   #########################################
osName=`uname`
verSQL="versions.sql"


## process command line paramaters #######
while getopts "c:X:N:Ep:RBbh" opt
do
    case "$opt" in
      X)  if [ "$OPTARG" == "l64" ] || [ "$OPTARG" == "posix" ] ||
	     [ "$OPTARG" == "a64" ]; then
            outDir="$OPTARG"
            setupOutdir
            OS_TYPE="POSIX"
            cp $CLI/apg.sh apg
            if [ "$outDir" == "posix" ]; then
              OS="???"
              platx="posix"
              plat="posix"
            else
              OS="LINUX"
              platx=$plat
            fi
          else
            fatalError "Invalid Platform (-X) option" "u"
          fi
          writeSettRow "GLOBAL" "PLATFORM" "$plat"
          if [ "$plat" == "posix" ]; then
            checkCmd "cp $CLI/install.py $OUT/."
          fi;;

      B) initC "salt" "saltstack" "$saltV" "$plat" "salt" "" "" "nil" 
         initC "pip"  "pip"       "$pipV"  "$plat" "pip"  "" "" "nil" 
         ;;

      R)  writeSettRow "GLOBAL" "REPO" "$repo" "-v";;

      c)  zipOut="$OPTARG";;

      N)  NUM="$OPTARG";;

      E)  isENABLED=true;;

      p)  pgM="$OPTARG"
          checkCmd "initPG";;

      h)  printUsageMessage
          exit 1;;
    esac
done

if [ $# -lt 1 ]; then
  printUsageMessage
  exit 1
fi

finalizeOutput

exit 0
